<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	
										
	<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_blocker, u.user_add_learner, u.user_add_course, u.user_create,
	c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
	s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
	FROM user u
	LEFT JOIN settings_country c ON c.country_id = u.country_id
	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id

	<!---- PROFIL TRAINER, ACTIVE --->
	WHERE profile_id = 4 
	AND u.user_status_id = 4 
	AND user_id IN (SELECT user_id FROM user_teaching WHERE formation_id = 2)
	AND FIND_IN_SET(1,method_id)
	AND user_id <> 2656 AND user_id <> 4784 AND user_id <> 4785 AND user_id <> 201
	
	HAVING (SELECT COUNT(slot_id) FROM user_slots us WHERE us.planner_id = u.user_id AND slot_start > now()) > 0
	
	ORDER BY u.user_firstname ASC
	LIMIT 10
	</cfquery>

</cfsilent>
	
	<cfset s_dur = 60>
	<cfset __alert_no_avail = obj_translater.get_translate('alert_no_avail')>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
	  
			<cfoutput query="get_trainer">
			
			<cfset "date_ref_#user_id#" = now()>
	
			<!---- OBJ QUERIES--->
			<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
			<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
			<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
			
			<!---- HARD QUERIES--->
			<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
			</cfquery>

			<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as nb FROM lms_tpplanner 
				WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				AND active = 1
			</cfquery>



			<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
				SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			</cfquery>
			
			<div class="card border">
				<div class="card-body">
					<div class="row">
						<div class="col-md-3">
							<div class="p-3">
								<div class="d-flex justify-content-center align-items-center">
									<div>
										<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
											<img src="./assets/user/#user_id#/photo.jpg" class="rounded-circle img-responsive" width="75" style="position:relative;">
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
											<img src="./assets/user/#user_id#/photo.png" class="rounded-circle img-responsive" width="75" style="position:relative;">
										<cfelse>
											<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
												SELECT user_gender FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
											</cfquery>
											<cfif get_gender.user_gender eq "M.">
												<img src="./assets/img/unknown_male.png" class="rounded-circle img-responsive" width="75" style="position:relative;">
											<cfelse>
												<img src="./assets/img/unknown_female.png" class="rounded-circle img-responsive" width="75" style="position:relative;">
											</cfif>
										</cfif>
									</div>
									<div class="ml-3">
										<strong style="font-size:18px" class="text-dark">#user_firstname# </strong>
										<br>
										<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> Corporate Trainer
									</div>
								</div>
																
								<div class="d-flex justify-content-center align-items-center mt-5" align="center">
									<div class="avail_item"><i class="fal fa-users fa-2x text-info"></i><br>#get_learner.nb+user_add_learner#<br><small>#obj_translater.get_translate('table_th_learners')#</small></div>
									<div class="avail_item"><i class="fal fa-chalkboard-teacher fa-2x text-info"></i><br>#get_lesson.nb+user_add_course#<br><small>#obj_translater.get_translate('lessons')#</small></div>
									<div class="avail_item"><i class="fal fa-history fa-2x text-info"></i><br>#obj_translater.get_translate('table_th_since')#<br><small><cfif user_create neq "">#year(user_create)#<cfelse>NC</cfif></small></div>
									<div class="avail_item"><i class="fal fa-star fa-2x text-info"></i><br><cfif get_rating.sum_rating gte 1>#numberformat(get_rating.avg_rating,'_._')#<br><small>#get_rating.sum_rating# vote<cfif get_rating.sum_rating gt 1>(s)</cfif><cfelse>-</cfif></small></div>
								</div>		
									
									<!---#user_id# - <img src="./assets/css/flags/blank.gif" class="flag_lg flag-#lcase(country_alpha)# mr-3" align="left">---> 
									<!--- <cfif user_based neq ""><br>#obj_translater.get_translate('lives')#</cfif> --->
									<!--- <div class="d-inline pull-right"><i class="fas fa-heart fa-lg grey"></i></div> --->
									
									<!--- <strong style="font-size:18px" class="text-dark">#user_firstname# <cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif></strong> --->
									<!--- <br><br> --->
									<!--- <small><strong>#obj_translater.get_translate('table_th_teaches')# :</strong></small> --->
									
									<!--- <cfloop query="get_teaching"> --->
										<!--- <span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center"> --->
											<!--- #get_teaching.formation_name#  --->
											<!--- <cfset learner_level = 5> --->
											<!--- <div class="clearfix"></div> --->
											<!--- <div class="gauge <cfif learner_level eq 1>bg-danger<cfelseif learner_level eq 2>bg-warning<cfelseif learner_level eq 3>bg-warning<cfelseif learner_level eq 4>bg-success<cfelseif learner_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div>  --->
											<!--- <div class="gauge <cfif learner_level eq 1><cfelseif learner_level eq 2>bg-warning<cfelseif learner_level eq 3>bg-warning<cfelseif learner_level eq 4>bg-success<cfelseif learner_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif learner_level eq 1><cfelseif learner_level eq 2><cfelseif learner_level eq 3>bg-warning<cfelseif learner_level eq 4>bg-success<cfelseif learner_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif learner_level eq 1><cfelseif learner_level eq 2><cfelseif learner_level eq 3>bg-warning<cfelseif learner_level eq 4>bg-success<cfelseif learner_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif learner_level eq 1><cfelseif learner_level eq 2><cfelseif learner_level eq 3>bg-warning<cfelseif learner_level eq 4>bg-success<cfelseif learner_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
										<!--- </span> --->
									<!--- </cfloop> --->

									<!--- <br><br> --->

									<!--- <small><strong>#obj_translater.get_translate('table_th_speaks')# :</strong></small> --->

									<!--- <cfloop query="get_speaking"> --->
										<!--- <span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center"> --->
											<!--- #get_speaking.formation_name#  --->
											<!--- <cfset speaking_level = get_speaking.speaking_level> --->
											<!--- <div class="clearfix"></div> --->
											<!--- <div class="gauge <cfif speaking_level eq 1>bg-danger<cfelseif speaking_level eq 2>bg-warning<cfelseif speaking_level eq 3>bg-warning<cfelseif speaking_level eq 4>bg-success<cfelseif speaking_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div>  --->
											<!--- <div class="gauge <cfif speaking_level eq 1><cfelseif speaking_level eq 2>bg-warning<cfelseif speaking_level eq 3>bg-warning<cfelseif speaking_level eq 4>bg-success<cfelseif speaking_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif speaking_level eq 1><cfelseif speaking_level eq 2><cfelseif speaking_level eq 3>bg-warning<cfelseif speaking_level eq 4>bg-success<cfelseif speaking_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif speaking_level eq 1><cfelseif speaking_level eq 2><cfelseif speaking_level eq 3><cfelseif speaking_level eq 4>bg-success<cfelseif speaking_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
											<!--- <div class="gauge <cfif speaking_level eq 1><cfelseif speaking_level eq 2><cfelseif speaking_level eq 3><cfelseif speaking_level eq 4><cfelseif speaking_level eq 5>bg-success</cfif> float-left ml-1 mt-1"> --->
											<!--- </div> --->
										<!--- </span> --->
									<!--- </cfloop> --->

											
									<!--- <br><br><br><br> --->
									
									
							</div>
						</div>
						<div class="col-md-9 col-12">
							<div class="p-3">
									<!--- <div class="tab-pane fade <cfif display eq "video"> show active</cfif>" id="video_#user_id#" role="tabpanel"> --->
										<!--- <cfif user_video neq "">	 --->
											<!--- <div class="video-container m-4"> --->
												<!--- <iframe src="#user_video#" width="100%" height="180" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> --->
											<!--- </div> --->
										<!--- </cfif> --->
										<!--- <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")> --->
											<!--- <video controls width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo_video.jpg")>poster="./assets/user/#user_id#/photo_video.jpg"</cfif>> --->
												<!--- <source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4"> --->
											<!--- </video> --->
										<!--- <cfelse> --->
											<!--- <div align="center" class="mt-4"> --->
												<!--- <h2 class="text-muted"><i class="fal fa-stopwatch fa-3x"></i></h2>																							 --->
												<!--- #obj_translater.get_translate('coming_soon')# --->
											<!--- </div> --->
										<!--- </cfif> --->
									<!--- </div> --->

								<div id="avail_container_#user_id#">			
									<cfinclude template="./incl/incl_calendar_week_slot.cfm">
								</div>
								
							</div>
						</div>	
					</div>
				</div>
			</div>
			</cfoutput>
	  
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>

<cfif not isdefined("picker")>
<cfset picker = dateformat(now(),"yyyy-mm-dd")>
</cfif>

var avail_choice = "remove";
var currentTimezone = "UTC";


$(document).ready(function() {


var handler_display_more = function get_more(){	

	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var u_id = idtemp[1];	
	
	$('.avail_display_add_'+u_id).collapse('show');			
}
$(".btn_display_avail").bind("click",handler_display_more);

var handler_prev = function get_prev(){	
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var u_id = idtemp[1];
	var date_ref = $('#date_ref_'+u_id).val();	
	<!--- alert(date_ref); --->
	$('#avail_container_'+u_id).empty();	
	var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+u_id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
	$('#avail_container_'+u_id).append(loader);	
	$('#avail_container_'+u_id).load("_AD_calendar_display.cfm?date_ref="+date_ref+"&date_add=-7&user_id="+u_id+"&s_dur=60", function() {
		<!----- KILL & REAFFECT ACTION ---->
		$(".btn_avail_prev").off("click");
		$(".btn_avail_prev").bind("click",handler_prev);
		$(".btn_avail_next").off("click");
		$(".btn_avail_next").bind("click",handler_next);
		$(".btn_display_avail").off("click")
		$(".btn_display_avail").bind("click",handler_display_more);
	});				
}
$(".btn_avail_prev").bind("click",handler_prev);


var handler_next = function get_next(){	
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var u_id = idtemp[1];	
	var date_ref = $('#date_ref_'+u_id).val();	
	$('#avail_container_'+u_id).empty();	
	var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+u_id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
	$('#avail_container_'+u_id).append(loader);	
	$('#avail_container_'+u_id).load("_AD_calendar_display.cfm?date_ref="+date_ref+"&date_add=7&user_id="+u_id+"&s_dur=60", function() {
		<!----- KILL & REAFFECT ACTION ---->
		$(".btn_avail_prev").off("click");
		$(".btn_avail_prev").bind("click",handler_prev);
		$(".btn_avail_next").off("click");
		$(".btn_avail_next").bind("click",handler_next);
		$(".btn_display_avail").off("click")
		$(".btn_display_avail").bind("click",handler_display_more);		
	});
					
}
$(".btn_avail_next").bind("click",handler_next);


$('#calendar').fullCalendar({
schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
  initialView: 'resourceTimeGridDay',
  resources: [{'id':'r1','name':'Resource 1'},{'id':'r2', 'name':'Resource 2'}],
		events: [
		{
		title: 'R1-R2: Lunch 14.00-15.00',
		start: '2021-05-06T14:00:00.000Z',
		end: '2021-05-06T15:00:00.000Z',
		resources: ['r1','r2']
		}
		]
});


	
		
});
</script>

</body>
</html>