<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">


<cfparam name="l_id" default="0">
<cfsilent>


		<cfquery name="get_lesson_cancel" datasource="#SESSION.BDDSOURCE#">	
			SELECT l.lesson_id, l.lesson_start, l.lesson_duration, l.updater_date, l.planner_id, 
			u.user_firstname, au.avail_id, au.group_name_fr, au.avail_name_fr,
			COUNT(*) as nb
			FROM lms_lesson_canceled_adv lca
			INNER JOIN lms_lesson2 l ON l.lesson_id = lca.lesson_id
			INNER JOIN user u ON l.planner_id = u.user_id
			LEFT JOIN user_availability au ON DATE_FORMAT(l.lesson_start,'%a') = au.avail_day AND DATE_FORMAT(l.lesson_start,'%H:%i') BETWEEN au.hour_start AND au.hour_end
			<cfif l_id neq 0>
				WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
			</cfif>
			GROUP BY l.lesson_id
			ORDER BY l.lesson_start DESC
		</cfquery>

		<cfif l_id neq 0>

		<!--- get lesson learner --->
		<cfquery name="get_lesson_learner" datasource="#SESSION.BDDSOURCE#">	
			SELECT l.lesson_id, l.lesson_start, l.lesson_duration, l.updater_date, l.planner_id, 
			u.user_firstname, u.user_name, u.user_id,
			lca.canceled_adv_mail_sent, lca.canceled_adv_clicked
			FROM lms_lesson_canceled_adv lca
			INNER JOIN lms_lesson2 l ON l.lesson_id = lca.lesson_id
			INNER JOIN user u ON lca.user_id = u.user_id
			WHERE lca.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>

	</cfif>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Cancelled Lesson - Send notifications">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">	
			
				<div class="col-md-12">

					<div class="card">
						<div class="card-body">

						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>LESSON DATE</strong></td>
								<td><strong>CANCEL DATE</strong></td>
								<td><strong>DUR</strong></td>
								<td><strong>TRAINER</strong></td>
								<!--- <td><strong>TRAINER ID </strong></td>
								<td><strong>AVAIL ID</strong></td>
								<td><strong>AVAIL</strong></td> --->
								<cfif l_id eq 0>
									<td><strong>NB USER WITH TRAINER</strong></td>
									<td><strong>T</strong></td>
									<td><strong>MORE</strong></td>
								</cfif>
					
								<!--- <td><strong></strong></td> --->
							</tr>
							<cfoutput query="get_lesson_cancel">
							<tr>
								<td>
									#lsDateTimeFormat(lesson_start, 'dd-mm-yyyy HH:nn:ss', 'fr')#
								</td>
								<td>
									#lsDateTimeFormat(updater_date, 'dd-mm-yyyy HH:nn:ss', 'fr')#
								</td>
								<td>
									#lesson_duration#
								</td>
								<td>
									<a href="common_trainer_account.cfm?p_id=#planner_id#">#user_firstname#</a>
								</td>
								<!--- <td>
									#planner_id#
								</td>
								<td>
									#avail_id#
								</td>
								<td>
									#group_name_fr# #avail_name_fr#
								</td> --->
								<cfif l_id eq 0>
									<td>
										#nb#
									</td>
									<td>
										<button id="l_#lesson_id#" class="btn btn-success btn-sm btn_test_cancel my-0"><i class="fal fa-eye"></i></button>
										<button id="l_#lesson_id#" class="btn btn-success btn-sm btn_test_cancel_test my-0"><i class="fal fa-eye"></i></button>	
									</td>
									<td>
										<a href="cs_alert_cancel_adv.cfm?l_id=#lesson_id#">-></a>
									</td>
								</cfif>
							</tr>						
							</cfoutput>
						</table>
						<cfif l_id neq 0>

							<div class="alert alert-success collapse" id="message_ok">
								Les emails ont correctement été envoyés.
							</div>	

							<div class="row">
								<div class="col-md-2">
									<td>
										<a href="cs_alert_cancel_adv.cfm"><- back</a>
									</td>
								</div>

								
								<div class="col-md-2">
									<input type="button" class="btn btn-sm btn-info" id="send_mail" value="Send ADV MAIL">
								</div>
							</div>
							<table class="table table-bordered">						
								<tr class="bg-light">
									<td><input type="checkbox" id="check_all"></td>
									<!--- <td><strong>ID</strong></td> --->
									<td><strong>LEARNER</strong></td>
									<td><strong>TP</strong></td>
									<td><strong>DUR</strong></td>
									<td><strong>PROGRESS</strong></td>
									<td><strong>TP END</strong></td>
									<td><strong>LAST LESSON</strong></td>
									<td colspan="2"style="text-align: center"><strong>NEXT LESSON</strong></td>
									<td><strong>MAIL SENT</strong></td>
									<td><strong>MAIL CLICKED</strong></td>
								</tr>
								<cfoutput query="get_lesson_learner">

									<cfquery name="get_next_session" datasource="#SESSION.BDDSOURCE#">
										SELECT s.session_id, s.session_duration, s.session_name,
										t.method_id, t.tp_id,
										l.lesson_start,
										lv.level_id, lv.level_alias, lv.level_css,
										sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_name, sm.sessionmaster_description
										FROM lms_tp t
										INNER JOIN lms_tpuser tu ON t.tp_id = tu.tp_id AND tpuser_active = 1
										INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
										LEFT JOIN lms_lesson2 l ON s.session_id = l.session_id
										INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
										LEFT JOIN lms_level lv ON lv.level_id = s.level_id
										WHERE tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
										AND t.tp_status_id = 2
										AND t.method_id = 1
										AND s.sessionmaster_id <> 694
										AND l.lesson_id IS NULL
										ORDER BY s.session_rank ASC 
										LIMIT 1
									</cfquery>

									<cfset get_tp = obj_tp_get.oget_tps(st_id="2",m_id="1",u_id="#user_id#",tp_id="#get_next_session.tp_id#")>
									
									<cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = get_tp.tp_scheduled></cfif>
									<cfif get_tp.tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = get_tp.tp_inprogress></cfif>
									<cfif get_tp.tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = get_tp.tp_cancelled></cfif>
									<cfif get_tp.tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = get_tp.tp_missed></cfif>
									<cfif get_tp.tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = get_tp.tp_completed></cfif>
									<cfif get_tp.tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = get_tp.tp_duration></cfif>
									<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
									<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
									<cfset tp_done_go = tp_completed_go+tp_inprogress_go>

									

									<cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
										SELECT l.lesson_start
										FROM lms_tp t
										INNER JOIN lms_lesson2 l ON t.tp_id = l.tp_id
										WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next_session.tp_id neq "" ? get_next_session.tp_id : 0#">
										AND l.status_id IN (2,5)
										ORDER BY l.lesson_start DESC 
										LIMIT 1
									</cfquery>

									<cfquery name="get_next_lesson" datasource="#SESSION.BDDSOURCE#">
										SELECT l.lesson_start
										FROM lms_tp t
										INNER JOIN lms_lesson2 l ON t.tp_id = l.tp_id
										WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next_session.tp_id neq "" ? get_next_session.tp_id : 0#">
										AND l.status_id = 1
										ORDER BY l.lesson_start ASC 
										LIMIT 1
									</cfquery>


								<tr>
									<td class="user_line" data-uid='#user_id#'>
										<input type="checkbox"  data-uid='#user_id#' id="check_#user_id#" class="user_checkbox" style="pointer-events: none;">
									</td>
									<!--- <td>
										#user_id#
									</td> --->
									<td>
										<a href="common_learner_account.cfm?u_id=#user_id#">#ucase(user_name)# #user_firstname#</a>
									</td>
									<td>
										<a href="common_tp_details.cfm?t_id=#get_tp.tp_id#&u_id=#user_id#">
											<cftry>
												#obj_lms.get_tp_icon(tp_id="#get_tp.tp_id#",tp_name="#get_tp.tp_name#",tp_rank="#get_tp.tp_rank#",formation_code="#get_tp.formation_code#",method_id="#get_tp.method_id#",tp_duration="#get_tp.tp_duration#",elearning_name="#get_tp.elearning_name#",elearning_duration="#get_tp.elearning_duration#",certif_name="#get_tp.certif_name#")#
												<cfcatch></cfcatch>
											</cftry>
										</a>
									</td>
									<td>
										#get_next_session.session_duration#
									</td> 
									<td>
										<cftry>
											#obj_lms.get_progress_bar(met_id="#get_tp.method_id#",tp_status="#get_tp.tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#get_tp.tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#get_tp.tp_duration#")#
											<cfcatch></cfcatch>
										</cftry>
									</td>
									<td>
										#lsdateformat(get_tp.tp_date_end,'dd/mm/yyyy', 'fr')#
									</td>
									<td>
										#lsDateTimeFormat(get_last_lesson.lesson_start, 'dd-mm-yyyy HH:nn:ss', 'fr')#
									</td>
									<td>
										#lsDateTimeFormat(get_next_lesson.lesson_start, 'dd-mm-yyyy HH:nn:ss', 'fr')#
									</td>
									<td>
										<cfif get_next_session.session_name neq "">
											#get_next_session.session_name#
										<cfelse>
											#get_next_session.sessionmaster_name#
										</cfif>
									</td>
									<td>
										#canceled_adv_mail_sent#
									</td>
									<td>
										#canceled_adv_clicked#
									</td>
								</tr>						
								</cfoutput>
							</table>
						</cfif>
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>
$( document ).ready(function() {

	$('.btn_test_cancel').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		console.log(l_id);

		$('#modal_title_lg').text("LATE LESSON");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_lesson_late_adv.cfm?l_id=" + l_id, function() {});

	});

	$('.btn_test_cancel_test').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		console.log(l_id);

		$('#modal_title_lg').text("LATE LESSON");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_lesson_late_adv.cfm?admin=0&l_id=" + l_id, function() {});

	});

	$('#check_all').click(function(event) {	
		// console.log(event)
		// console.log(event.target.dataset.uid)

		$('input:checkbox').not(this).prop('checked', this.checked);
	});

	$('.user_line').click(function(event) {	
		// console.log(event)
		// console.log(event.target.dataset.uid)
		let id = event.target.dataset.uid;

		$('#check_' + id).prop( "checked", !$('#check_' + id).prop('checked') );

	});

	$("#send_mail").click(function( event ) {
		event.preventDefault();
		
		var user_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			user_list.push($(this)[0].dataset.uid);
		});

		// console.log(user_list);

		$.ajax({
			url: './api/tp/tp_post.cfc?method=send_adv_mail',
			type: 'POST',
			data : {
				user_list:user_list, 
				l_id:<cfoutput>#l_id#</cfoutput>, 
			},
			success : function(result, status){
				// console.log(result);
				$("#message_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

})
</script>

</body>
</html>