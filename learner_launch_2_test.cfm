<!DOCTYPE html>
<cfsilent>
	
	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">	

	<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
		SELECT `user_status_id` FROM `user` WHERE `user_status_id` = 3 AND `user_id` = #SESSION.USER_ID#
	</cfquery>

	<cfif get_status.recordCount eq 0>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
			
	<!--------------- SET DEFAULT CRITERIAS / INIT CONFIG --->
	<cfset SESSION.booking_array = {}>

	<cfset step = "2">
	<cfset test = "1">
	<cfset get_tp = obj_tp_get.oget_tp(t_id="#SESSION.TP_ID#")>
	<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#SESSION.TP_ID#")>
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>
	<cfset get_session = obj_tp_get.oget_session(t_id="#SESSION.TP_ID#")>
	<cfset s_id = get_session.session_id>
	<cfset s_dur = get_session.session_duration>
	<cfif s_dur eq "">
		<cfset s_dur = 45>
	</cfif>
	<!--- <cfset tp_date_end = dateformat(get_session.tp_date_end,'yyyy-mm-dd')> --->

	<cfset SESSION.tp_date_start = dateformat(get_tp.tp_date_start,'yyyy-mm-dd')>
	<cfset SESSION.tp_date_end = dateformat(get_tp.tp_date_end,'yyyy-mm-dd')>

	<cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level = evaluate("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level_letter = mid(u_level,1,1)>
		<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
		SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_level#">
		</cfquery>
		<cfset level_criteria_id = get_level.level_id>
	<cfelse>
		<cfset u_level = "N/A">
		<cfset u_level_letter = "N/A">
		<cfset level_criteria_id = 0>
	</cfif>

	<cfset teaching_criteria_id = f_id>
	<cfset teaching_criteria_code = f_code>
	
	<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_blocker, u.user_add_learner, u.user_add_course, u.user_create,
	c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
	s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
	FROM user u
	LEFT JOIN settings_country c ON c.country_id = u.country_id
	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
	LEFT JOIN user_ready ur ON u.user_id = ur.user_id AND ur.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#">
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = 4

	<!---- PROFIL TRAINER, ACTIVE --->	
	WHERE u.user_status_id = 4 

	<!---- VISIO --->
	AND FIND_IN_SET(1,method_id)

	<cfif get_trainer.recordcount neq "0">
		
		AND u.user_id IN (<cfloop query="get_trainer">#get_trainer.planner_id#,</cfloop>0)

	<cfelse>

		<!---- READY TO TAKE TEST --->
		AND ur.user_ready_test = 1

		<!---- TAUGHT LANGUAGE --->
		<cfif teaching_criteria_id neq "0" AND teaching_criteria_id neq "">
			AND u.user_id IN (SELECT user_id FROM user_teaching WHERE (formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#"> <cfif level_criteria_id neq "0" AND level_criteria_id neq "">AND FIND_IN_SET(#level_criteria_id#,level_id)</cfif>))
		</cfif>

		<!---- REMOVE FAKE TRAINERS --->
		AND u.user_id <> 2656 AND u.user_id <> 4784 AND u.user_id <> 4785 AND u.user_id <> 201 

		<!---- TRAINER WHO ACCEPT THIS TYPE OF USER --->
		<cfif SESSION.USER_TYPE_ID eq 4>
			AND ur.user_ready_tm = 1
		<cfelseif SESSION.USER_TYPE_ID eq 5>
			AND ur.user_ready_vip = 1
		<cfelseif SESSION.USER_TYPE_ID eq 6>
				AND ur.user_ready_children = 1
		<cfelse>
			AND ur.user_ready_classic = 1
		</cfif>

		HAVING (SELECT COUNT(slot_id) FROM user_slots us WHERE us.planner_id = u.user_id AND slot_start > now() AND slot_start < <cfqueryparam cfsqltype="cf_sql_date" value="#dateAdd("d",7,now())#">) > 0



		ORDER BY rand()

			
	</cfif>
	


	
	</cfquery>

	

	<cfset __alert_no_avail = obj_translater.get_translate('alert_no_avail')>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

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
	  
			<cfinclude template="./incl/incl_nav_launching.cfm">
<!---  --->
			<!--- <div class="card border">
				<div class="card-body">
					<div class="row">
						<!--- <div class="col-md-3">
						</div> --->
						<div class="col-md-9" align="center">
							<strong>Planifier votre premi&#232;re le&#231;on !</strong>
							<strong><span id="lesson_counter"></span></strong>
						</div>
						<div class="col-md-3">
							<a class="btn btn-success btn_save_book">Valider</a>
						</div>
					</div>
				</div>
			</div> --->
			
			<cfset counter_trainer = 0>
			<cfoutput query="get_trainer">
				<cfset counter_trainer++>
			<cfset "date_ref_#user_id#" = now()>
	
			<!---- OBJ QUERIES--->
			<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
			<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
			<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
			
			<!---- HARD QUERIES--->
			<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
			</cfquery>

			<!--- <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(DISTINCT(t.user_id)) as nb FROM lms_tp t
				INNER JOIN lms_tpplanner p
				WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			</cfquery> --->

			<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
				SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			</cfquery>
			

			<div class="card border mt-2">
				<div class="card-body">
					<div class="row">
						<div class="col-md-3">
							<div class="p-1">
								<!--- <div class="d-flex justify-content-center align-items-center">
									<div>
										<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
											<img src="./assets/user/#user_id#/photo.jpg" class="rounded-circle img-responsive btn_view_trainer" id="trainer_#user_id#" width="75" style="position:relative;">
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
											<img src="./assets/user/#user_id#/photo.png" class="rounded-circle img-responsive btn_view_trainer" id="trainer_#user_id#" width="75" style="position:relative;">
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
									</div>
								</div> --->
										
								<div align="center" class="mb-1">
									<strong style="font-size:18px" class="text-dark">#user_firstname# </strong>
									 <br> Corporate Trainer
									<!---<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif>  --->
									
								</div>

								<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>
									<video controls preload width="100%" height="180" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>poster="./assets/user/#user_id#/photo.jpg"</cfif>>
										<source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4">
											<!--- <p> --->
											<!--- <cfset user_id = get_trainer_go.user_id> --->
											<!--- <cfset arr = ['SESSION.BO_ROOT_URL', 'user_id']> --->
											<!--- <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->
											<!--- #obj_translater.get_translate_complex(id_translate="download_trainer_video", argv="#argv#")#</p> --->
									</video>
								<cfelse>
									<div align="center" class="mt-4">
										<h2 class="text-muted"><i class="fal fa-stopwatch fa-3x"></i></h2>																							
										#obj_translater.get_translate('coming_soon')#
									</div>
								</cfif>
								
								

								<div align="center" class="mt-1">
									<button class="btn btn-outline-info btn-sm btn-block btn_view_trainer" id="trainer_#user_id#" >
										<i class="fal fa-address-card"></i>
										#obj_translater.get_translate('btn_view_profile')#
									</button>
								</div>

								<div class="d-flex justify-content-center align-items-top mt-3" align="center">
									<!--- <div class="avail_item"><i class="fal fa-users fa-2x text-info"></i><br>#get_learner.nb+user_add_learner#<br><small>#obj_translater.get_translate('table_th_learners')#</small></div> --->
									<!--- <div class="avail_item"><i class="fal fa-chalkboard-teacher fa-2x text-info"></i><br>#get_lesson.nb+user_add_course#<br><small>#obj_translater.get_translate('lessons')#</small></div> --->
									<!--- <div class="avail_item"><i class="fal fa-history fa-2x text-info"></i><br>#obj_translater.get_translate('table_th_since')#<br><small><cfif user_create neq "">#year(user_create)#<cfelse>NC</cfif></small></div> --->
									<!--- <div class="avail_item"><i class="fal fa-star fa-2x text-info"></i><br><cfif get_rating.sum_rating gte 1>#numberformat(get_rating.avg_rating,'_._')#<br><small>#get_rating.sum_rating# vote<cfif get_rating.sum_rating gt 1>(s)</cfif><cfelse>-</cfif></small></div> --->
								
										<div class="m-2">
											<strong>#obj_translater.get_translate('table_th_teaches')#</strong>
											<br>
											<cfloop query="get_teaching">
												<!--- <img src="./assets/img/training_#lcase(get_teaching.formation_code)#.png" width="80"> --->
												<span class="lang-lg" lang="#get_teaching.formation_code#"></span>
											</cfloop>
										</div>
										<div class="m-2">				
											<strong>#obj_translater.get_translate('table_th_speaks')#</strong>
											<br>
											<cfset count_speak = 0>
											<cfloop query="get_speaking">
												<cfset count_speak++>
												<!--- <cfif count_speak lte 2> --->
												<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
												#get_speaking.formation_name# 
												<cfset level_id = get_speaking.level_id>
												<div class="clearfix"></div>
												<div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
												</span>
												<!--- </cfif> --->
											</cfloop>
										</div>		

										
										
								</div>		
									
													
							</div>
						</div>
						<div class="col-md-9 col-12">
							<div class="p-2">
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
									<cfif counter_trainer lte 3>		
									<cfinclude template="./incl/incl_calendar_week_slot.cfm">
									</cfif>
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

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>


$(document).ready(function() {


	<cfif isdefined("display_info")>
	$('#window_item_lg').modal({keyboard: true});
	// $('#modal_title_lg').text("\u00c9diter contact");
	$('#modal_body_lg').load("modal_window_info.cfm?show_info=trainer_choice", function() {});
	</cfif>


	var s_dur = <cfoutput>#s_dur#</cfoutput>;

	<cfoutput query="get_trainer">
		<cfif counter_trainer lte 3>		
		var	display_#user_id# = 1;
		<cfelse>
		var	display_#user_id# = 0;
		</cfif>
		
	</cfoutput>


	$(window).on('scroll', function() {
		<cfoutput query="get_trainer">
		var hT = $('##avail_container_#user_id#').offset().top,
		hH = $('##avail_container_#user_id#').outerHeight(),
		wH = $(window).height(),
		wS = $(this).scrollTop();
		if (wS > (hT+hH-wH)){
			if(display_#user_id# == 0)
			{
				// console.log("display ok for #user_id#");
				$('##avail_container_#user_id#').load("./incl/incl_calendar_week_slot.cfm?user_id=#user_id#&s_dur=#s_dur#", function(){
					display_#user_id# = 1;
					<!----- KILL & REAFFECT ACTION ---->
					$(".btn_avail_prev").off("click");
					$(".btn_avail_prev").bind("click",handler_prev);
					$(".btn_avail_next").off("click");
					$(".btn_avail_next").bind("click",handler_next);
					$(".btn_display_avail").off("click");
					$(".btn_display_avail").bind("click",handler_display_more);		
					$(".btn_jump_next_avail").off("click");
					$(".btn_jump_next_avail").bind("click",handler_jump_next);
					$(".btn_book_lesson").off("click");
					$(".btn_book_lesson").bind("click",handler_book_lesson);
				})
			
			}
		}
		</cfoutput>
	})

function go_next(id, date, add = 1) {
	// console.log(id, date);
	$('#avail_container_'+id).empty();	
	var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
	$('#avail_container_'+id).append(loader);	
	$('#avail_container_'+id).load("./incl/incl_calendar_week_slot.cfm?date_ref="+date+"&date_add="+(7*add)+"&user_id="+id+"&s_dur=<cfoutput>#s_dur#</cfoutput>", function() {
		<!----- KILL & REAFFECT ACTION ---->
		$(".btn_avail_prev").off("click");
		$(".btn_avail_prev").bind("click",handler_prev);
		$(".btn_avail_next").off("click");
		$(".btn_avail_next").bind("click",handler_next);
		$(".btn_display_avail").off("click");
		$(".btn_display_avail").bind("click",handler_display_more);		
		$(".btn_jump_next_avail").off("click");
		$(".btn_jump_next_avail").bind("click",handler_jump_next);
		$(".btn_book_lesson").off("click");
		$(".btn_book_lesson").bind("click",handler_book_lesson);
	});
}


var handler_book_lesson = function(event) {	
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var date = idtemp[1];
	var hour = parseInt(idtemp[2]);
	var min = parseInt(idtemp[3]);
	var planner_id = idtemp[4];	

	<cfoutput>
	if(confirm("#obj_translater.get_translate('js_book_confirm')#"))
	{
		var urlgo = "updater_lesson.cfm?m_id=1&t_id=#SESSION.TP_ID#&u_id=#SESSION.USER_ID#&p_id="+planner_id+"&s_id=#s_id#&s_dur=#s_dur#&l_date_start="+date+"&l_time_start="+hour + "-" + min;
		document.location.href=urlgo;
	}
	</cfoutput>

};
$('.btn_book_lesson').bind("click",handler_book_lesson);

$('.btn_view_trainer').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#</cfoutput>");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_trainerview.cfm?p_id="+p_id, function() {});
	});


var handler_jump_next = function(event) {	
	event.preventDefault();
	var nametmp = $(this).attr("name");
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var date_ref = $('#date_ref_'+idtemp[1]).val();
	// console.log(nametmp)
	go_next(idtemp[1], date_ref, nametmp);
};
$(".btn_jump_next_avail").bind("click",handler_jump_next);
	
var handler_display_more = function get_more(){	

	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var u_id = idtemp[1];
	
	$('.avail_display_add_'+u_id).collapse('toggle');			
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
	$('#avail_container_'+u_id).load("./incl/incl_calendar_week_slot.cfm?date_ref="+date_ref+"&date_add=-7&user_id="+u_id+"&s_dur=<cfoutput>#s_dur#</cfoutput>", function() {
		<!----- KILL & REAFFECT ACTION ---->
		$(".btn_avail_prev").off("click");
		$(".btn_avail_prev").bind("click",handler_prev);
		$(".btn_avail_next").off("click");
		$(".btn_avail_next").bind("click",handler_next);
		$(".btn_display_avail").off("click")
		$(".btn_display_avail").bind("click",handler_display_more);
		$(".btn_jump_next_avail").off("click")
		$(".btn_jump_next_avail").bind("click",handler_jump_next);
		$(".btn_book_lesson").off("click")
		$(".btn_book_lesson").bind("click",handler_book_lesson);
	});				
}
$(".btn_avail_prev").bind("click",handler_prev);


var handler_next = function get_next(){	
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var u_id = idtemp[1];	
	var date_ref = $('#date_ref_'+u_id).val();	
	go_next(u_id, date_ref)
					
}
$(".btn_avail_next").bind("click",handler_next);

		
});
</script>

</body>
</html>