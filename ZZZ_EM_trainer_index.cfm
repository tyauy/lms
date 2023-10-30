<!DOCTYPE html>

<cfsilent>

<cfset secure = "4">
<cfinclude template="./incl/incl_secure.cfm">	

<cfinclude template="./incl/incl_cached.cfm">	

<cfquery name="get_tp_active" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(t.tp_id) AS nb
FROM lms_tp t 
INNER JOIN user u ON t.user_id = u.user_id
LEFT JOIN account a ON a.account_id = u.account_id
INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
INNER JOIN lms_lesson_method lm ON lm.method_id = t.method_id
INNER JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1


WHERE lm.method_scheduler = "scheduler"

AND (t.tp_status_id = 2 OR t.tp_status_id = 1)

AND p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		
</cfquery>	
	
<cfquery name="get_count_lesson_planned" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(l.lesson_id) AS nb, SUM(lesson_duration/60) as h
FROM lms_lesson2 l
INNER JOIN lms_tpsession s ON s.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
INNER JOIN user u ON u.user_id = l.user_id
INNER JOIN user u2 ON u2.user_id = l.planner_id
WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL
AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
AND l.status_id = 1
AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#year(now())#-#dateformat(now(),'mm')#'
</cfquery>

<cfquery name="get_count_lesson_done" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(l.lesson_id) AS nb, SUM(lesson_duration/60) as h
FROM lms_lesson2 l
INNER JOIN lms_tpsession s ON s.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
INNER JOIN user u ON u.user_id = l.user_id
INNER JOIN user u2 ON u2.user_id = l.planner_id
WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL
AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
AND (l.status_id = 5 OR l.status_id = 6 OR l.status_id = 2)
AND DATE_FORMAT(l.lesson_start, "%Y-%m") = '#year(now())#-#dateformat(now(),'mm')#'
</cfquery>

<cfquery name="get_next_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.lesson_id, l.lesson_start, l.lesson_end, sm.sessionmaster_id, sm.sessionmaster_name, ul.user_firstname, ul.user_name, l.method_id
FROM lms_lesson2 l

INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
INNER JOIN lms_lesson_status st ON st.status_id = l.status_id
INNER JOIN lms_tpsession s ON l.session_id = s.session_id

LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
LEFT JOIN lms_tpmodulemaster tm ON tm.module_id = sm.module_id

INNER JOIN user ul ON ul.user_id = l.user_id
INNER JOIN user ut ON ut.user_id = l.planner_id

WHERE (ut.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
OR ul.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">)
AND l.lesson_start > #dateadd("n",-15,now())#
AND l.status_id = "1"

ORDER BY l.lesson_start ASC 
LIMIT 1
</cfquery>
	
<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_fill_pta = obj_translater.get_translate('tooltip_fill_pta')>
<cfset __tooltip_fill_na = obj_translater.get_translate('tooltip_fill_na')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>
<cfset __tooltip_cancel_lesson = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfset __btn_support_short = obj_translater.get_translate('btn_support_short')>
<cfset __btn_notes_short = obj_translater.get_translate('btn_notes_short')>
<cfset __btn_fill_notes = obj_translater.get_translate('btn_fill_notes')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>

<cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#SESSION.USER_ID#")>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_trainer_index')#">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  	
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert">
				Vous n'avez pas acc&egrave;s &agrave; la page demand&eacute;e, vous avez &eacute;t&eacute; redirig&eacute;(e) vers votre page d'accueil
				</div>
			</cfif>
			
			<cfif isdefined("k")>
				<div class="alert alert-success" role="alert" align="center">
				<cfoutput>
				<cfif k eq "2">
				#obj_translater.get_translate('alert_ln_treated')#
				<cfelseif k eq "3">
				#obj_translater.get_translate('alert_ln_removed')#
				</cfif>
				</cfoutput>
				</div>
			</cfif>
			
			
			<div class="row">
				<div class="col-lg-4 col-md-4 col-sm-6 mb-2">
					<div class="card card-stats h-100 border-top border-success">
						<div class="card-body">
							<div class="row">
								<div class="col-8 col-md-9">
									<div class="numbers text-left" style="min-height:1px !important"> 
										<p class="card-category"><cfoutput>#obj_translater.get_translate('card_learner_nextlesson')#</cfoutput></p>
									</div>
									<div class="mt-2 ml-2">
									<cfif get_next_lesson.recordcount neq "0">
										<cfoutput>
										<strong>#dateformat(get_next_lesson.lesson_start,'dd/mm/yyyy')#</strong>
										<br>
										#timeformat(get_next_lesson.lesson_start,'HH:mm')# - #timeformat(get_next_lesson.lesson_end,'HH:mm')#
										<br>
										#get_next_lesson.sessionmaster_name#
										<br>
										#obj_translater.get_translate('with')# #get_next_lesson.user_firstname# #ucase(get_next_lesson.user_name)#
										</cfoutput>
									<cfelse>
										<em><cfoutput>#obj_translater.get_translate('alert_no_planned')#</cfoutput></em>
									</cfif>
									</div>
								</div>
								<div class="col-4 col-md-3">
									<div class="text-center">
									<i class="fa-light fa-calendar-alt text-success fa-2x"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right;">
							
							<cfif get_next_lesson.recordcount neq "0">
							<hr>
							<cfif get_next_lesson.method_id neq "2">
							<a href="##" class="btn btn-sm btn-info btn_next_lesson"><cfoutput>#obj_translater.get_translate('btn_launch_short')#</cfoutput></a>
							</cfif>
							<cfelse>
							<hr>
							<a href="##" class="btn btn-sm btn-link"><cfoutput>#obj_translater.get_translate('btn_trainer_nonextlesson')#</cfoutput></a>
							</cfif>
						</div>
					</div>
				</div>
				
				
				<div class="col-lg-4 col-md-4 col-sm-6 mb-2">
					<div class="card card-stats h-100 border-top border-info">
						<div class="card-body">
							<div class="row">
								<div class="col-8 col-md-9">
									<div class="numbers text-left">
									<p class="card-category"><cfoutput>#obj_translater.get_translate('card_trainer_done')#</cfoutput></p>
									<p class="card-title"><!---#get_count_lesson_done.nb# #obj_translater.get_translate('course')# / ---> <cfoutput>#numberformat(get_count_lesson_done.h,'____.__')#h</cfoutput></p>
									</div>
								</div>
								<div class="col-4 col-md-3">
									<div class="text-center">
										<i class="fa-light fa-hourglass-half text-info fa-2x"></i>
									</div>
								</div>
							</div>
                            <div class="row">
								<div class="col-8 col-md-9">
									<div class="numbers text-left">
									<p class="card-category"><cfoutput>#obj_translater.get_translate('card_trainer_active')#</cfoutput></p>
									<p class="card-title"><cfoutput>#get_tp_active.nb#</cfoutput></p>
									</div>
								</div>
								<div class="col-4 col-md-3">
									<div class="icon-big text-center">
									
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right">
							<hr>
							<div>
							<a href="trainer_lessons.cfm" class="btn btn-sm btn-outline-info d-inline-block<cfif SESSION.USER_STATUS_ID neq "4" AND SESSION.USER_STATUS_ID neq "6">disabled</cfif>"><cfoutput>#obj_translater.get_translate('btn_trainer_report_access')#</cfoutput></a>
                            <a href="trainer_learners.cfm?st_id=1,2" class="btn btn-sm btn-outline-info d-inline-block <cfif SESSION.USER_STATUS_ID neq "4" AND SESSION.USER_STATUS_ID neq "6">disabled</cfif>"><cfoutput>#obj_translater.get_translate('btn_trainer_view')# #obj_translater.get_translate('btn_learners')#  </cfoutput></a>
                            </div>
						</div>
					</div>
				</div>
				
	
				
				<div class="col-lg-4 col-md-4 col-sm-6 mb-2">
					<div class="card card-stats h-100 border-top border-danger">
						<div class="card-body">
							<div class="row">
								<div class="col-8 col-md-9">
									<div class="text-left">
									<p class="card-category"><cfoutput> #obj_translater.get_translate('table_th_visio_techno')#</cfoutput></p>
									<p class="card-title"><!---#get_count_lesson_done.nb# #obj_translater.get_translate('course')# / ---> </p>
									</div>
								</div>
								<div class="col-4 col-md-3 pb-3">
									<div class="text-center">
										<i class="fa-light fa-camera-web fa-2x text-danger"></i>
									</div>
								</div>
							</div>
								<cfoutput>
                                    
                                    <table class="table table-bordered table-sm bg-white mb-0">
                                    
                                        <!-- Begin the loop through the "get_techno_list" query -->
                                        <cfloop query="get_techno_list">
                                        
                                            <!-- Check if the "user_techno_link" value is not null or empty -->
                                            <cfif len(trim(get_techno_list.user_techno_link))>
                                            
                                            <!-- If the value is not null or empty, display the row -->
                                            <tr>
                                                <td width="25%" class="bg-light">
                                                <label>
                                                    #get_techno_list.techno_alias# 
                                                    
                                                    <!-- Display a star icon if the "user_techno_preferred" value is 1 -->
                                                    <cfif get_techno_list.user_techno_preferred eq "1">
                                                    <i class="fas fa-star text-warning"></i>
                                                    </cfif>
                                                </label>
                                                </td>
                                                
                                                <!-- Display a hyperlink to the "user_techno_link" -->
                                              
                                                <td class="text-center"><a id='#get_techno_list.user_techno_link#' class="btn btn-sm btn-info markup-copy">copy link</a></td>
                                            </tr>
                                            
                                            </cfif>
                                            
                                        </cfloop>
  
                                    </table>
                                   </cfoutput>
						</div>
						<div class="card-footer" style="text-align:right">
							<hr>
                            <div>
                                <a href="common_trainer_account.cfm" class="btn btn-sm btn-outline-info d-inline-block <cfif SESSION.USER_STATUS_ID neq "4" AND SESSION.USER_STATUS_ID neq "6">disabled</cfif>"><cfoutput>#obj_translater.get_translate('sidemenu_trainer_settings')#</cfoutput></a>
                            </div>
						</div>
					</div>
				</div>
		
			</div>
			
			<div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border-top border-info">
						<div class="card-body">
							<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_trainer_activity')#</cfoutput></h4>
							<cfset cal_view = "basicWeek">
							<cfset u_id = "0">
							<cfset p_id = SESSION.USER_ID>
							<cfset cal_height = "260">
							<div id="calendar" class="mt-3"></div> 
						</div>
					</div>			
				</div>
				
			</div>
			
			<div class="row mt-3">
				<div class="col-md-12">
					<div class="card border-top border-info">
						<div class="card-body">

							<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_trainer_tocomplete')#</cfoutput></h4>
							<cfset show_tab = "2">
							<cfinclude template="./widget/wid_lesson_list_trainer.cfm">
						</div>
					</div>
				
				</div>
			</div>
			
			
				
			
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<cfinclude template="./calendar/lms_calendar_param.cfm">

<script>
<cfif get_next_lesson.recordcount neq "0">
<cfoutput>
$('.btn_next_lesson').click(function(event) {		
	event.preventDefault();
	$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_nextlesson')#");
	$('##window_item_lg').modal({keyboard: true});
	$('##modal_body_lg').load("modal_window_event_light2.cfm?lesson_id=#get_next_lesson.lesson_id#", function() {
	});
})
</cfoutput>
</cfif>

// copy link

        // Attach a click event listener to any element with class "markup-copy" on the document
        $(document).on("click", ".markup-copy", function(event) {
        // Prevent the default action of clicking on a link or button
        event.preventDefault();

        // Get the value of the "id" attribute of the clicked element
        var link = $(this).attr("id");

        // Use the Clipboard API to write the link to the clipboard
        navigator.clipboard.writeText(link)
            // If the copy was successful, display an alert message with the link
            .then(function() {
            alert("Link copied to clipboard: " + link);
            })
            // If the copy failed, display an error message
            .catch(function() {
            alert("Failed to copy link to clipboard. Please try again.");
            });
        });

</script>



</body>
</html>