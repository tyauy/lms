<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<!--------------- DEFAULT DATE & VIEW  ------------->
<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfset y = mid(ysel,3,2)>

<cfparam name="view" default="reg">
<!--------------- DEFAULT DATE & VIEW  ------------->

<cfparam name="teaching_criteria_id" default="1,2,3,4">

<cfsilent>



<cfloop list="1,6" index="tp_status_cor">
<cfloop list="2,3,4" index="user_status_cor">

    <cfquery name="get_tp_fr_#tp_status_cor#_#user_status_cor#" datasource="#SESSION.BDDSOURCE#">
    SELECT s.tp_status_name_#SESSION.LANG_CODE# as tp_status_name, t.tp_duration, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, s.tp_status_id, u.user_id, u.user_firstname, u.user_name, u.user_status_id, a.account_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id, t.tp_date_start
    FROM lms_tp t
    INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
    INNER JOIN lms_formation f ON f.formation_id = t.formation_id
    INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
    INNER JOIN user u ON u.user_id = t.user_id
    INNER JOIN account a ON a.account_id = u.account_id
    WHERE t.method_id = 1 AND s.tp_status_id IN (#tp_status_cor#) AND u.user_status_id IN (#user_status_cor#) AND a.provider_id IN (1,3)
    ORDER BY t.formation_id, t.tp_status_id, a.account_name, u.user_name, a.provider_id
    </cfquery>

    <cfquery name="get_tp_de_#tp_status_cor#_#user_status_cor#" datasource="#SESSION.BDDSOURCE#">
    SELECT s.tp_status_name_#SESSION.LANG_CODE# as tp_status_name, t.tp_duration, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, s.tp_status_id, u.user_id, u.user_firstname, u.user_name, u.user_status_id, a.account_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id, t.tp_date_start
    FROM lms_tp t
    INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
    INNER JOIN lms_formation f ON f.formation_id = t.formation_id
    INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
    INNER JOIN user u ON u.user_id = t.user_id
    INNER JOIN account a ON a.account_id = u.account_id
    WHERE t.method_id = 1 AND s.tp_status_id IN (#tp_status_cor#) AND u.user_status_id IN (#user_status_cor#) AND a.provider_id IN (2)
    ORDER BY t.formation_id, t.tp_status_id, a.account_name, u.user_name, a.provider_id
    </cfquery>

	<cfquery name="get_tp_type_fr_#tp_status_cor#_#user_status_cor#" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(t.tp_id) as nb, s.tp_status_name_fr, s.tp_status_id, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name,ut.user_type_name_#SESSION.LANG_CODE# as type_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN user_type ut ON ut.user_type_id = u.user_type_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (#tp_status_cor#) AND u.user_status_id IN (#user_status_cor#) AND a.provider_id IN (1,3)
	GROUP BY t.formation_id, t.tp_status_id, u.user_type_id
	</cfquery>

	<cfquery name="get_tp_type_de_#tp_status_cor#_#user_status_cor#" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(t.tp_id) as nb, s.tp_status_name_fr, s.tp_status_id, t.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name,ut.user_type_name_#SESSION.LANG_CODE# as type_name, CASE a.provider_id WHEN "3" THEN "1" ELSE a.provider_id END as provider_id
	FROM lms_tp t
	INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
	INNER JOIN user u ON u.user_id = t.user_id
	INNER JOIN user_type ut ON ut.user_type_id = u.user_type_id
	INNER JOIN account a ON a.account_id = u.account_id
	WHERE t.method_id = 1 AND s.tp_status_id IN (#tp_status_cor#) AND u.user_status_id IN (#user_status_cor#) AND a.provider_id IN (2)
	GROUP BY t.formation_id, t.tp_status_id, u.user_type_id
	</cfquery>

</cfloop>
</cfloop>





<cfloop list="3,7,9" index="profile_cor">
<cfquery name="get_tps_#profile_cor#" datasource="#SESSION.BDDSOURCE#">	
	SELECT t.*, u.user_id, u.user_firstname, u.user_name,
	o.order_id, o.order_ref, o.order_start, o.order_end,
	ts.tp_status_name_fr,
	a.account_name

	FROM lms_tp t 

	INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id

	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
	INNER JOIN user u ON tpu.user_id = u.user_id
	INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#profile_cor#">
	INNER JOIN user_profile up ON up.profile_id = upc.profile_id
	
	LEFT JOIN account a ON a.account_id = u.account_id
	INNER JOIN orders o ON o.order_id = t.order_id
	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
	LEFT JOIN order_context oc ON oc.context_id = o.context_id
	
	WHERE t.method_id = 1
	AND t.tp_status_id <> 3 AND t.tp_status_id <> 11

	AND 
	(
		<!---DATE_FORMAT(tp_date_start, '%Y-%m-%d') <> DATE_FORMAT(order_start, '%Y-%m-%d')
		OR --->DATE_FORMAT(tp_date_end, '%Y-%m-%d') <> DATE_FORMAT(order_end, '%Y-%m-%d')
	)
	ORDER BY tp_id desc

	</cfquery>
	</cfloop>
</cfsilent>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "DASHBOARD TRAINER MANAGER">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">

			<cfset urlgo = "tmg_index.cfm">
			<cfinclude template="./incl/incl_nav_tmg.cfm">

			<h5 class="m-0">LAUNCHING</h5>
			<hr class="m-0 mb-3">
			<div class="row">
				
				<cfset idgo = 0>
				<cfloop list="fr,de" index="provider_cor">
				<cfloop list="1,6" index="tp_status_cor">
				
				<div class="col-md-3">
                    
					<cfloop list="2,3,4" index="user_status_cor">
					<cfset idgo ++>
					<div class="card border mb-3">

						<div class="card-body">
							<!--- <h6> --->
								<a class="btn btn-primary" data-toggle="collapse" href="#<cfoutput>div_#idgo#</cfoutput>" role="button" aria-expanded="false">
									
                                	<cfif provider_cor eq "fr">FRANCE<cfelse>GERMANY</cfif> - 

									<cfif tp_status_cor eq "1" AND user_status_cor eq "2">
									TO LAUNCH
									<cfelseif tp_status_cor eq "1" AND user_status_cor eq "3">
									LAUNCHED - STEPS NOT DONE
									<cfelseif tp_status_cor eq "1" AND user_status_cor eq "4">
									TO LAUNCH - ACTIVE ?
									</cfif>


									<cfif tp_status_cor eq "6" AND user_status_cor eq "2">
									LAUNCH AT DATE
									<cfelseif tp_status_cor eq "6" AND user_status_cor eq "3">
									LAUNCH AT DATE - STEPS NOT DONE
									<cfelseif tp_status_cor eq "6" AND user_status_cor eq "4">
									LAUNCH AT DATE - ACTIVE ?
									</cfif>

								</a>
                            
                            <!--- </h6> --->
							
							<div class="collapse" id="<cfoutput>div_#idgo#</cfoutput>">

								<cfoutput query="get_tp_#provider_cor#_#tp_status_cor#_#user_status_cor#" group="formation_id">
							
									<!--- <cfif tp_status_id eq tp_status_cor AND user_status_id eq user_status_cor> --->
									
										<select class="form-control form-control-sm" onchange="window.open('common_learner_account.cfm?u_id='+$(this).val()+'');">
											<option value="0" selected><img src="./assets/img_formation/#formation_id#.png" width="20"> #formation_name#</option>
											<cfoutput>
											<option value="#user_id#"><cfif tp_status_cor eq "6">#dateformat(tp_date_start,'dd/mm/yyyy')#</cfif> [#account_name#] [#tp_duration/60# h] #user_name# #user_firstname#</option>
											</cfoutput>
										</select>
									<!--- </cfif> --->
									
								</cfoutput>

								<table class="table table-sm">

									<cfoutput query="get_tp_type_#provider_cor#_#tp_status_cor#_#user_status_cor#">
										<cfif tp_status_id eq tp_status_cor>
										<tr>
											<td>
												<img src="./assets/img_formation/#formation_id#.png" width="20"> #formation_name#
											</td>
											<td>
												#type_name#
											</td>
											<td>
												#nb#
											</td>
										</tr>
									</cfif>
									</cfoutput>

								</table>
                            </div>

						</div>

					</div>
                    </cfloop>

				</div>
				</cfloop>
				</cfloop>

			</div>

			<h5 class="m-0">TP CHECK DATE ORDER</h5>
			<hr class="m-0 mb-3">

			<div class="row">
				<cfloop list="3,7,9" index="profile_cor">

				<div class="col-md-6">
					<div class="card border mb-3">

						<div class="card-body">
							
							<cfset idgo ++>
							<a class="btn btn-primary" data-toggle="collapse" href="#<cfoutput>div_#idgo#</cfoutput>" role="button" aria-expanded="false">
								<cfif profile_cor eq "3">LEARNER<cfelseif profile_cor eq "7">GUEST<cfelseif profile_cor eq "9">TEST</cfif> - WRONG DATE (<cfoutput>#evaluate("get_tps_#profile_cor#").recordcount#</cfoutput>)
							</a>
							<div class="collapse" id="<cfoutput>div_#idgo#</cfoutput>">

								<table class="table table-sm">
									<tr>
										<td>
											USER
										</td>
										<td>
											ACCOUNT
										</td>
										<td>
											TP
										</td>
										<td>
											ORDER END
										</td>
										<td>
											TP END
										</td>
									</tr>
									<cfoutput query="get_tps_#profile_cor#">
										
										<tr>
											<td>
												<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname#
												#ucase(user_name)# </a>
											</td>
											<td>
												<small>#account_name#</small>
											</td>
											<td>
												<!--- #method_id# /  --->
												#tp_duration/60#h - #tp_status_name_fr#
											</td>
											<!--- <td>
												#dateformat(order_start,'dd/mm/yyyy')#
											</td> --->
											<td>
												#dateformat(order_end,'dd/mm/yyyy')#
											</td>
											<!--- <td>
												#dateformat(tp_date_start,'dd/mm/yyyy')#
											</td> --->
											<td>
												#dateformat(tp_date_end,'dd/mm/yyyy')#
											</td>
										</tr>
									</cfoutput>
					
								</table>

							</div>

						</div>

					</div>

				</div>
				</cfloop>	

			</div>

			<h5 class="m-0">USER CHECK</h5>
			<hr class="m-0 mb-3">

			<div class="row">
				<div class="col-md-6">
					<div class="card border mb-3">

						<div class="card-body">

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







<script>

	<cfif not isdefined("picker")>
	<cfset picker = dateformat(now(),"yyyy-mm-dd")>
	</cfif>
	
	var avail_choice = "remove";
	var currentTimezone = "UTC";
	
	
$(document).ready(function() {


	function renderCalendar() {
		
		$('#calendar').fullCalendar({

		
		schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
		defaultDate: '<cfoutput>#picker#</cfoutput>',	
		timeFormat: 'H:mm',
		hiddenDays: [0,6],
		lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
		axisFormat: 'HH:mm',
		allDaySlot: true,	
		defaultEventMinutes:15,
		timezone: currentTimezone,
		<cfif isdefined("cal_view")>
		defaultView: '<cfoutput>#cal_view#</cfoutput>',
		<cfelse>
		defaultView: 'agendaWeek',
		</cfif>	
		selectHelper: false,	
		firstDay: 1,
		minTime: '06:00:00',
		maxTime: '23:00:00',
		slotDuration: '00:15:00',
		navLinks: true,
		editable: false,
		eventStartEditable: false,
		eventResizableFromStart: false,
		eventDurationEditable: false,
		droppable: false,
		eventOrder:["task_group_alias"],
		height:200,
			
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'agendaWeek,month'
		},		
		
		eventOrder:'title',
	  
		/**************SOURCE****************/	
		eventSources: [
			"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_trainer&task_closed=0"
		],		
		/**************END SOURCE****************/
	
			
			eventClick: function(event) {
	
				if($.isNumeric(event.user_id) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?u_id="+event.user_id, function() {})
				}
				else if($.isNumeric(event.account_id_log) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?a_id="+event.account_id_log, function() {})
				}
				else if($.isNumeric(event.group_id_log) && !$.isNumeric(event.lesson_id))
				{
					$('#modal_title_xl').text("Follow-Up");
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_body_xl').load("modal_window_log.cfm?g_id="+event.group_id_log, function() {})
				}
				
			},
		  
			eventRender: function(event, element) {
				
				if($.isNumeric(event.lesson_id) && $.isNumeric(event.calendartype)){    
					if(event.calendartype == "2")
					{
						
						element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><a class="btn btn-sm btn-danger text-white p-0 m-0 remove" style="min-width:20px !important; padding:2px !important"><i class="fas fa-times"></i></a><br><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
						element.find(".remove").on("click", function() {
						if(confirm("Remove Setup ?"))
							{
							document.location.href='updater_lesson.cfm?faction=erase&l_id='+event.lesson_id+'&p_id='+event.planner_id+'&u_id='+event.user_id;
							}
						})
					
					}
					else{
						element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><!---<a class="btn btn-sm btn-danger text-white p-0 m-0 remove" href=""><i class="fas fa-times"></i></a><br>---><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
					}
			
				}
				
				element.find(".fc-title").html(element.find('.fc-title').text());
	
			}
		
		
	});
	
		
	}
	
	
	renderCalendar();
	
		

	});
	</script>



</body>
</html>