
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
		SELECT l.planner_id, u.user_blocker, u.user_firstname FROM lms_lesson2 l 
		INNER JOIN user u ON u.user_id = l.planner_id
		WHERE l.status_id = 1 GROUP BY planner_id
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
			</div>
			
			<div class="row">	
			
				<div class="col-md-12">

					<cfloop query="#get_trainers#">

						<cfquery name="get_lesson_learner" datasource="#SESSION.BDDSOURCE#">	
							SELECT l1.lesson_id, l1.lesson_start, l1.lesson_end, l1.tp_id, l1.planner_id, l1.user_id,
							l2.lesson_id as id2, l2.lesson_start as start2, l2.lesson_end as end2, l2.tp_id as tp2, l2.planner_id as p2, l2.user_id as u2
							FROM lms_lesson2 l1
							INNER JOIN lms_lesson2 l2
							ON l1.planner_id = l2.planner_id AND l2.lesson_start > l1.lesson_start 
							AND l2.lesson_start < DATE_ADD(l1.lesson_end, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#get_trainers.user_blocker#"> MINUTE)
							
							WHERE l1.planner_id = #get_trainers.planner_id# AND l2.planner_id = #get_trainers.planner_id#
							
							AND l1.status_id = 1
							AND l1.lesson_start > NOW()
							
							AND  l2.status_id = 1
							AND l2.lesson_start > NOW()
						</cfquery>

						<cfif get_lesson_learner.recordCount GT 0>						
						<div class="card">
							<div class="card-header">
								<span>LESSON - <cfoutput>#get_trainers.user_firstname#</cfoutput></span>
							</div>
							<div class="card-body">
							<table class="table table-bordered">						
								<tr class="bg-light">
									<td><strong>LESSON DATE</strong></td>
									<td><strong>BLOCKER</strong></td>
									<td><strong>TRAINER</strong></td>
									<td><strong>LEARNER</strong></td>
									<!--- <td><strong>UPDATER</strong></td> --->
									<td><strong>TP</strong></td>
									<td><strong>-</strong></td>
									<td><strong>LESSON DATE</strong></td>
									<td><strong>BLOCKER</strong></td>
									<td><strong>TRAINER</strong></td>
									<td><strong>LEARNER</strong></td>
									<td><strong>TP</strong></td>
								</tr>
								<cfoutput query="get_lesson_learner">				
								<tr>
									<td>
										#dateformat(lesson_start, 'dd/mm/yyyy')# | #timeformat(lesson_start, 'HH:nn')# - #timeformat(lesson_end, 'HH:nn')#
									</td>
									<td>
										#get_trainers.user_blocker#
									</td>
									<td>
										#planner_id#
									</td>
									<td>
										<a href="common_learner_account.cfm?u_id=#user_id#">#user_id#</a>
									</td>
									<!--- <td>
										#updater_firstname#
									</td> --->
									<td>
										<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">TP</a>
									</td>
									<td>
										-
									</td>
									<td>
										#dateformat(start2, 'dd/mm/yyyy')# | #timeformat(start2, 'HH:nn')# - #timeformat(end2, 'HH:nn')#
									</td>
									<td>
										#get_trainers.user_blocker#
									</td>
									<td>
										#p2#
									</td>
									<td>
										<a href="common_learner_account.cfm?u_id=#u2#">#u2#</a>
									</td>
									<td>
										<a href="common_tp_details.cfm?t_id=#tp2#&u_id=#u2#">TP</a>
									</td>
								</tr>
								</cfoutput>
							</table>
							</div>						
						</div>
						</cfif>

					</cfloop>

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