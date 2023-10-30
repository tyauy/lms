
<cfsilent>
	<cfparam name="from_msel" default="#month(now())#">

	<cfif SESSION.LANG_CODE neq "fr">
		<cfset from_mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),from_msel)>
	<cfelse>
		<cfset from_mlongsel = listgetat(SESSION.LISTMONTHS,from_msel)>
	</cfif>
	<cfset from_msel = listgetat(SESSION.LISTMONTHS_CODE,from_msel)>

	<cfparam name="from_ysel" default="#year(now())#">
	<cfparam name="from_tselect" default="#from_ysel#-#from_msel#-01">
	<cfparam name="p_id" default="0">

	<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id, user_firstname, user_name FROM user u
		WHERE profile_id = 4
		AND u.user_status_id = 4
		ORDER BY user_firstname
	</cfquery>


	<cfquery name="get_lesson_learner" datasource="#SESSION.BDDSOURCE#">	
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.tp_id, l.updater_date,
		ul.user_id, ul.user_firstname as learner_firstname, ul.user_name as learner_name, 
		ut.user_firstname as trainer_firstname, 
		sm.sessionmaster_name		
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession tps ON tps.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON tps.sessionmaster_id = sm.sessionmaster_id
		INNER JOIN user ul ON ul.user_id = l.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id
		WHERE l.updater_date >= "#from_tselect#"
		<cfif p_id neq 0>
			AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		AND l.status_id = 3
		AND l.user_id = l.updater_id
		ORDER BY l.updater_date DESC
	</cfquery>

	<cfquery name="get_lesson_trainer" datasource="#SESSION.BDDSOURCE#">	
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.tp_id, l.updater_date,
		ul.user_id, ul.user_firstname as learner_firstname, ul.user_name as learner_name, 
		ut.user_firstname as trainer_firstname, 
		sm.sessionmaster_name		
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession tps ON tps.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON tps.sessionmaster_id = sm.sessionmaster_id
		INNER JOIN user ul ON ul.user_id = l.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id
		WHERE l.updater_date >= "#from_tselect#"
		<cfif p_id neq 0>
			AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		AND l.status_id = 3
		AND l.planner_id = l.updater_id
		ORDER BY l.updater_date DESC
	</cfquery>

	<cfquery name="get_lesson_other" datasource="#SESSION.BDDSOURCE#">	
		SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.tp_id, l.updater_date,
		ul.user_id, ul.user_firstname as learner_firstname, ul.user_name as learner_name, 
		ut.user_firstname as trainer_firstname, 
		sm.sessionmaster_name		
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession tps ON tps.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON tps.sessionmaster_id = sm.sessionmaster_id
		INNER JOIN user ul ON ul.user_id = l.user_id
		INNER JOIN user ut ON ut.user_id = l.planner_id
		WHERE l.updater_date >= "#from_tselect#"
		<cfif p_id neq 0>
			AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>
		AND l.status_id = 3
		AND !((l.planner_id = l.updater_id) OR  (l.user_id = l.updater_id))
		ORDER BY l.updater_date DESC
	</cfquery>
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "CANCEL LESSON">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row" style="margin-top:10px">

				<div class="col-md-12">
					<div class="card border-top border-info" style="min-height:140px">						
						<div class="card-body">
							<h4 class="card-title">S&eacute;lection : Depuis <cfoutput>#from_mlongsel# #from_ysel#</cfoutput></h4>
							<div class="row">
								<div class="col-md-12 mt-4">
									<cfform action="cs_alert_cancel_recap.cfm">
										<div class="form-row">
											<div class="col">
												<cfselect class="form-control" name="p_id" query="get_trainers" value="user_id" display="user_firstname" selected="#p_id#">
													<option value="0" <cfif p_id eq "0">selected</cfif>>---ALL TRAINERS----</option>
												</cfselect>
											</div>

											<div class="col">
												<select class="form-control" name="from_msel">

													<cfloop from="1" to="12" index="m">
														<cfoutput>
															<cfif SESSION.LANG_CODE neq "fr">
																<option value="#m#" <cfif from_msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
															<cfelse>
																<option value="#m#" <cfif from_msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
															</cfif>


														</cfoutput>
													</cfloop>
												</select>
											</div>

											<div class="col">

												<select class="form-control" name="from_ysel">
													<cfloop from="2019" to="#year(now())#" index="y">
														<cfoutput>
															<option value="#y#" <cfif from_ysel eq y>selected="selected"</cfif>>#y#</option>
														</cfoutput>
													</cfloop>
												</select>

											</div>

											<div class="col">
												<input type="submit" value="GO" class="btn btn-info">
											</div>
										</div>
									</cfform>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">	
			
				<div class="col-md-4">

					<div class="card">
						<div class="card-header">
							<span>CANCEL BY LEARNER</span>
						</div>
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>LESSON DATE</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<!--- <td><strong>UPDATER</strong></td> --->
								<td><strong>TP</strong></td>
								<td><strong>UPDATE DATE</strong></td>
							</tr>
							<cfoutput query="get_lesson_learner">				
							<tr>
								<td>
									#dateformat(lesson_start, 'dd/mm/yyyy')#
								</td>
								<td>
									#trainer_firstname#
								</td>
								<td>
									<a href="common_learner_account.cfm?u_id=#user_id#">#learner_firstname# #learner_name#</a>
								</td>
								<!--- <td>
									#updater_firstname#
								</td> --->
								<td>
									<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">TP</a>
								</td>
								<td>
									#dateformat(updater_date, 'dd/mm/yyyy')#
								</td>
							</tr>
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>

				<div class="col-md-4">

					<div class="card">
						<div class="card-header">
							<span>CANCEL BY TRAINER</span>
						</div>
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>LESSON DATE</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<td><strong>TP</strong></td>
								<td><strong>UPDATE DATE</strong></td>
							</tr>
							<cfoutput query="get_lesson_trainer">				
							<tr>
								<td>
									#dateformat(lesson_start, 'dd/mm/yyyy')#
								</td>
								<td>
									#trainer_firstname#
								</td>
								<td>
									<a href="common_learner_account.cfm?u_id=#user_id#">#learner_firstname# #learner_name#</a>
								</td>
								<td>
									<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">TP</a>
								</td>
								<td>
									#dateformat(updater_date, 'dd/mm/yyyy')#
								</td>
							</tr>
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>

				<div class="col-md-4">

					<div class="card">
						<div class="card-header">
							<span>CANCEL BY OTHER</span>
						</div>
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>LESSON DATE</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<td><strong>TP</strong></td>
								<td><strong>UPDATE DATE</strong></td>
							</tr>
							<cfoutput query="get_lesson_other">				
							<tr>
								<td>
									#dateformat(lesson_start, 'dd/mm/yyyy')#
								</td>
								<td>
									#trainer_firstname#
								</td>
								<td>
									<a href="common_learner_account.cfm?u_id=#user_id#">#learner_firstname# #learner_name#</a>
								</td>
								<td>
									<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">TP</a>
								</td>
								<td>
									#dateformat(updater_date, 'dd/mm/yyyy')#
								</td>
							</tr>
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>
$( document ).ready(function() {

})
</script>

</body>
</html>