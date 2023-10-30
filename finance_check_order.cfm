<!DOCTYPE html>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "Check">
			<cfinclude template="./incl/incl_nav.cfm">
			<cfparam name="display" default="date">

			<div class="content">

				<div class="row" style="margin-top:10px">


					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "date">active</cfif>" onclick="location.href='finance_check_order.cfm?display=date'"> DATE END</button>
					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "lesson">active</cfif>" onclick="location.href='finance_check_order.cfm?display=lesson'">LESSON_SCH / TP DEADLINES</button>
					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "el">active</cfif>" onclick="location.href='finance_check_order.cfm?display=el'"> E-LEARNING</button>
					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "paid">active</cfif>" onclick="location.href='finance_check_order.cfm?display=paid'"> PAID</button>
					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "invoiced">active</cfif>" onclick="location.href='finance_check_order.cfm?display=invoiced'"> INVOICED</button>
					<button type="button" class="btn btn btn-outline-info p-2 <cfif display eq "no_limit">active</cfif>" onclick="location.href='finance_check_order.cfm?display=no_limit'"> NO LIMIT </button>


					<cfif display eq "date">
					
						<cfquery name="get_check_tp_date" datasource="#SESSION.BDDSOURCE#">
							SELECT DATEDIFF(t.tp_date_end, o.order_end) as delta, 
							t.method_id, 
							t.tp_vip, t.tp_date_end, t.tp_id as cur_tp, 
							o.order_ref as oid, o.order_end, 
							u.user_id as uid, u.user_name, u.user_firstname, 
							a.account_name, 
							of.status_finance_name
							FROM lms_tp t 
							INNER JOIN orders o ON t.order_id = o.order_id 
							INNER JOIN order_status_finance of ON of.status_finance_id = o.order_status_id 
							INNER JOIN orders_users ou ON o.order_id = ou.order_id
							INNER JOIN user u ON u.user_id = ou.user_id 
							INNER JOIN account a ON a.account_id = u.account_id
							WHERE t.method_id < 3  AND t.tp_status_id=2  AND t.tp_date_end != o.order_end
							ORDER BY oid
						</cfquery>
						
						<table class="table table-sm">
							<tbody>
								<tr class="bg-light">
									<th>ORDER ID</th>
									<th>ORDER STATUS</th>
									
									<th width="20%">ACCOUNT</th>
									
									<th>USER</th>
									<th>TP END</th>
									<th>ORDER END</th>
									<th>DELTA (days)</th>
									<th>NO LIMIT</th>
									<th>GO TO LEARNER</th>
									<th>GO TO TP</th>
								</tr>
								<cfoutput query="get_check_tp_date">
									<tr>
										<td>#oid#</td>
										<td>#status_finance_name#</td>
										<td>#account_name#</td>
										<td>#user_name# #user_firstname#</td>
										<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>
										<td>#dateformat("#order_end#", "dd/mm/yyyy")#</td>
										<td align="center">#delta#</td>
										<td>#tp_vip#</td>
										<td><a href="common_learner_account.cfm?u_id=#uid#">LINK TO LEARNER</a></td>
										<td><a href="common_tp_details.cfm?t_id=#cur_tp#&u_id=#uid#">LINK TO TP</a></td>
									</tr>
								</cfoutput>

							</tbody>
						</table>

						<!--- SELECT t.tp_date_end, o.order_end, t.method_id, DATEDIFF(t.tp_date_end, o.order_end) as diff FROM lms_tp t LEFT JOIN orders o ON t.order_id = o.order_id  --->
						<!--- WHERE t.method_id < 3 AND t.tp_status_id=2 AND DATEDIFF(t.tp_date_end, o.order_end) != 0 AND DATEDIFF(t.tp_date_end, o.order_end) < 10 AND DATEDIFF(t.tp_date_end, o.order_end) > -10 --->


					<cfelseif display eq "lesson">

						<cfquery name="get_check_lessons" datasource="#SESSION.BDDSOURCE#">	
							SELECT l.lesson_start , t.tp_date_end, o.order_ref as oid, o.order_end, t.tp_vip, t.tp_id as cur_tp, ul.user_id as uid, ul.user_name, ul.user_firstname, ts.tp_status_name_fr as status, a.account_name, of.status_finance_name
							FROM lms_lesson2 l
							INNER JOIN lms_tpsession s ON s.session_id = l.session_id 
							INNER JOIN lms_lesson_method lm ON lm.method_id = l.method_id 
							INNER JOIN lms_tp t ON t.tp_id = s.tp_id 
							INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
							INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
							INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id 
							INNER JOIN user ul ON ul.user_id = l.user_id 
							INNER JOIN user ut ON ut.user_id = l.planner_id
							LEFT JOIN user ub ON ub.user_id = l.booker_id 
							INNER JOIN account a ON a.account_id = ul.account_id 
							INNER JOIN orders o ON o.order_id = t.order_id 
							INNER JOIN order_status_finance of ON of.status_finance_id = o.order_status_id 
							
							WHERE l.lesson_start > o.order_end AND t.method_id < 3 AND t.tp_status_id=2
							GROUP BY t.tp_id
							ORDER BY oid
						</cfquery>

						<table class="table table-sm">
							<tbody>
								<tr class="bg-light">
									<th>ORDER ID</th>
									<th>ORDER STATUS</th>
									<th width="20%">ACCOUNT</th>
									<th>USER</th>
									<th>TP END</th>
									<th>ORDER END</th>
									<th>TP STATUS</th>
									<th>NO LIMIT</th>
									<th>GO TO LEARNER</th>
									<th>GO TO TP</th>
								</tr>
								<cfoutput query="get_check_lessons">
									<tr>
										<td>#oid#</td>
										<td>#status_finance_name#</td>
										<td>#account_name#</td>
										<td>#user_name# #user_firstname#</td>
										<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>
										<td>#dateformat("#order_end#", "dd/mm/yyyy")#</td>
										<td>#status#</td>
										<td>#tp_vip#</td>
										<td><a href="common_learner_account.cfm?u_id=#uid#">LINK TO LEARNER</a></td>
										<td><a href="common_tp_details.cfm?t_id=#cur_tp#&u_id=#uid#">LINK TO TP</a></td>
									</tr>
								</cfoutput>

							</tbody>
						</table>


				<cfelseif display eq "el">

					<cfquery name="get_check_tp_date" datasource="#SESSION.BDDSOURCE#">
						SELECT ts.tp_status_name_fr as status, t.tp_date_start, t.tp_date_end, ROUND(DATEDIFF(t.tp_date_end, t.tp_date_start)/30) as delta, t.elearning_duration, o.order_ref as oid, t.tp_id as cur_tp, u.user_id as uid, u.user_name, u.user_firstname, a.account_name, t.method_id
						FROM lms_tp t 
						LEFT JOIN orders o ON t.order_id = o.order_id 
						INNER JOIN orders_users ou ON o.order_id = ou.order_id
						INNER JOIN user u ON u.user_id = ou.user_id
						INNER JOIN account a ON a.account_id = u.account_id
						INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
						WHERE t.method_id = 3  AND t.tp_status_id=2 AND ROUND(DATEDIFF(t.tp_date_end, t.tp_date_start)/30) != elearning_duration
						ORDER BY oid
					</cfquery>

					<table class="table table-sm">
						<tbody>
							<tr class="bg-light">
								<th>ORDER ID</th>
								<th width="20%">ACCOUNT</th>
								<th>USER</th>

								<th>TP STATUS</th>

								<th>TP START</th>
								<th>TP END</th>

								<th>DELTA</th>
								<th>DURATION</th>

								<th>GO TO LEARNER</th>
								<th>GO TO TP</th>
							</tr>
							<cfoutput query="get_check_tp_date">
								<tr>
									<td>#oid#</td>
									<td>#account_name#</td>
									<td>#user_name# #user_firstname#</td>

									<td>#status#</td>

									<td>#dateformat("#tp_date_start#", "dd/mm/yyyy")#</td>
									<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>

									<td align="center">#delta#</td>
									<td align="center">#elearning_duration#</td>

									<td><a href="common_learner_account.cfm?u_id=#uid#">LINK TO LEARNER</a></td>
									<td><a href="common_tp_details.cfm?t_id=#cur_tp#&u_id=#uid#">LINK TO TP</a></td>
								</tr>
							</cfoutput>

						</tbody>
					</table>

				<cfelseif display eq "paid">

					<cfquery name="get_check" datasource="#SESSION.BDDSOURCE#">
						SELECT t.*, 
						ts.tp_status_name_fr as status,
						of.status_finance_name,
						o.*,
						a.account_name,
						u.user_firstname, u.user_name
						FROM lms_tp t
						INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
						INNER JOIN orders o ON o.order_id = t.order_id
						INNER JOIN order_status_finance of ON of.status_finance_id = o.order_status_id 
						INNER JOIN orders_users ou ON o.order_id = ou.order_id
						INNER JOIN user u ON u.user_id = ou.user_id
						INNER JOIN account a ON a.account_id = u.account_id
						WHERE o.order_status_id = 10 
						AND t.tp_status_id = 2
						AND t.method_id = 1
						AND t.tp_vip = 0
					</cfquery>		

					<table class="table table-sm">
					<tbody>
						<tr class="bg-light">
							<th>ORDER ID</th>
							<th>ORDER STATUS</th>
							<th width="20%">ACCOUNT</th>
							<th>USER</th>
							<th>TP END</th>
							<th>ORDER END</th>
							<th>TP STATUS</th>
							<th>NO LIMIT</th>
							<th>GO TO LEARNER</th>
							<th>GO TO TP</th>
						</tr>
						<cfoutput query="get_check">
						
						
							<tr>
								<td>#order_ref#</td>
								<td>#status_finance_name#</td>
								<td>#account_name#</td>
								<td>#user_name# #user_firstname#</td>

								<td>#dateformat("#tp_date_start#", "dd/mm/yyyy")#</td>
								<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>
								<td>#status#</td>
								<td>#tp_vip#</td>


								<td><a href="common_learner_account.cfm?u_id=#user_id#">LINK TO LEARNER</a></td>
								<td><a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">LINK TO TP</a></td>
							</tr>
						</cfoutput>
					</table>
					
				<cfelseif display eq "invoiced">

					<cfquery name="get_check" datasource="#SESSION.BDDSOURCE#">
						SELECT t.*, 
						ts.tp_status_name_fr as status,
						of.status_finance_name,
						o.*,
						a.account_name,
						u.user_firstname, u.user_name
						FROM lms_tp t
						INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
						INNER JOIN orders o ON o.order_id = t.order_id
						INNER JOIN order_status_finance of ON of.status_finance_id = o.order_status_id 
						INNER JOIN orders_users ou ON o.order_id = ou.order_id
						INNER JOIN user u ON u.user_id = ou.user_id
						INNER JOIN account a ON a.account_id = u.account_id
						WHERE o.order_status_id = 5 
						AND t.tp_status_id = 2
						AND t.method_id = 1
						AND t.tp_vip = 0
					</cfquery>		

					<table class="table table-sm">
					<tbody>
						<tr class="bg-light">
							<th>ORDER ID</th>
							<th>ORDER STATUS</th>
							<th width="20%">ACCOUNT</th>
							<th>USER</th>
							<th>TP END</th>
							<th>ORDER END</th>
							<th>TP STATUS</th>
							<th>NO LIMIT</th>
							<th>GO TO LEARNER</th>
							<th>GO TO TP</th>
						</tr>
						<cfoutput query="get_check">
						
						<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#"> --->
							<!--- UPDATE lms_tp SET tp_vip = 1 WHERE tp_id = #tp_id# --->
						<!--- </cfquery> --->
					
					
							<tr>
								<td>#order_ref#</td>
								<td>#status_finance_name#</td>
								<td>#account_name#</td>
								<td>#user_name# #user_firstname#</td>

								<td>#dateformat("#tp_date_start#", "dd/mm/yyyy")#</td>
								<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>
								<td>#status#</td>
								<td>#tp_vip#</td>


								<td><a href="common_learner_account.cfm?u_id=#user_id#">LINK TO LEARNER</a></td>
								<td><a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">LINK TO TP</a></td>
							</tr>
						</cfoutput>
					</table>
				<cfelseif display eq "no_limit">
					
						<cfquery name="get_check_tp_date" datasource="#SESSION.BDDSOURCE#">
							SELECT t.method_id, 
							t.tp_vip, t.tp_date_end, t.tp_id as cur_tp, 
							o.order_ref as oid, o.order_end, 
							u.user_id as uid, u.user_name, u.user_firstname, 
							a.account_name, 
							of.status_finance_name
							FROM lms_tp t 
							INNER JOIN orders o ON t.order_id = o.order_id 
							INNER JOIN order_status_finance of ON of.status_finance_id = o.order_status_id 
							INNER JOIN orders_users ou ON o.order_id = ou.order_id
							INNER JOIN user u ON u.user_id = ou.user_id
							INNER JOIN account a ON a.account_id = u.account_id
							WHERE t.method_id < 3  AND t.tp_status_id=2  AND t.tp_vip = 1
							ORDER BY oid
						</cfquery>
						
						
						
						
						
						<table class="table table-sm">
							<tbody>
								<tr class="bg-light">
									<th>ORDER ID</th>
									<th>ORDER STATUS</th>
									
									<th width="20%">ACCOUNT</th>
									
									<th>USER</th>
									
									<th>LAST LESSON</th>
									<th>TP END</th>
									
									<th>GO TO LEARNER</th>
									<th>GO TO TP</th>
								</tr>
								<cfoutput query="get_check_tp_date">
									<cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
										SELECT lesson_start
										FROM lms_lesson2
										WHERE user_id = #uid# AND tp_id = #cur_tp#
										ORDER BY lesson_start DESC
									</cfquery>
									<tr>
										<td>#oid#</td>
										<td>#status_finance_name#</td>
										<td>#account_name#</td>
										<td>#user_name# #user_firstname#</td>
										<td>#dateformat("#get_last_lesson.lesson_start#", "dd/mm/yyyy")#</td>
										<td>#dateformat("#tp_date_end#", "dd/mm/yyyy")#</td>
										
										<td><a href="common_learner_account.cfm?u_id=#uid#">LINK TO LEARNER</a></td>
										<td><a href="common_tp_details.cfm?t_id=#cur_tp#&u_id=#uid#">LINK TO TP</a></td>
									</tr>
								</cfoutput>

							</tbody>
						</table>				
				</cfif>



			</div>

		</div>
	</div>
</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

</body>
</html>