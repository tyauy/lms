
<cfsilent>
	<!--- <cfparam name="from_msel" default="#month(now())#">

	<cfif SESSION.LANG_CODE neq "fr">
		<cfset from_mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),from_msel)>
	<cfelse>
		<cfset from_mlongsel = listgetat(SESSION.LISTMONTHS,from_msel)>
	</cfif>
	<cfset from_msel = listgetat(SESSION.LISTMONTHS_CODE,from_msel)>

	<cfparam name="from_ysel" default="#year(now())#">
	<cfparam name="from_tselect" default="#from_ysel#-#from_msel#-01">
	<cfparam name="p_id" default="0"> --->

	<!--- <cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
		SELECT l.planner_id, u.user_blocker, u.user_firstname FROM lms_lesson2 l 
		INNER JOIN user u ON u.user_id = l.planner_id
		WHERE l.status_id = 1 GROUP BY planner_id
	</cfquery> --->

	<cfquery name="get_lesson_learner" datasource="#SESSION.BDDSOURCE#">	
		SELECT tlp.planner_id , tlp.creation_date, tlp.modification_date, tlp.tp_id, u2.user_firstname as learner_firstname, u2.user_name as learner_name, u2.user_id as learner_id, ut.user_type_name_en,
		u.user_firstname, l.lesson_id, l.lesson_start
		FROM lms_tpplanner tlp
		INNER JOIN user u ON u.user_id = tlp.planner_id 
		INNER JOIN lms_tp t ON t.tp_id = tlp.tp_id AND t.tp_status_id = 2
		LEFT JOIN lms_lesson2 l ON l.tp_id = tlp.tp_id AND lesson_start > DATE_ADD(NOW(), INTERVAL -4 MONTH)
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
		INNER JOIN user u2 ON u2.user_id = tpu.user_id 
		LEFT JOIN user_type ut ON u2.user_type_id = ut.user_type_id
		
		WHERE tlp.active = 1 
		AND l.lesson_id IS NULL
		AND tlp.planner_id <> 4784
		AND t.method_id <> 12
		ORDER BY u.user_firstname ASC, l.lesson_start DESC
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
      
		<cfset title_page = "no lesson">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row" style="margin-top:10px">
			</div>
			
			<div class="row">	
			
				<div class="col-md-12">

					
					<div class="card">
						<div class="card-header">
							<span>LESSON </span>
						</div>
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>LEARNER</strong></td>
								<td><strong>RANKING</strong></td>
								<td><strong>TRAINER ADD DATE</strong></td>
								<td><strong>TRAINER ADD UPDATE</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LAST ACTIVITY</strong></td>
								<!--- <td><strong>UPDATER</strong></td> --->
								<td><strong>TP</strong></td>
								<td><strong>TP TRAINER</strong></td>
							</tr>
							<cfoutput query="get_lesson_learner">				
							<tr>
								<td>
									<a href="common_learner_account.cfm?u_id=#learner_id#">#ucase(learner_name)# #learner_firstname#</a>
								</td>
								<td>
									#user_type_name_en#
								</td>
								<td>
									#dateformat(creation_date, 'dd/mm/yyyy')#
								</td>
								<td>
									#dateformat(modification_date, 'dd/mm/yyyy')#
								</td>
								<td>
									#obj_function.get_thumb_border(user_id="#planner_id#",size="40",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#
									- #user_firstname#
								</td>
								<!--- <td>
									#updater_firstname#
								</td> --->
								<td>
									#lesson_start#
								</td>
								<td>
									<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#learner_id#">TP</a>
								</td>
								<td>
									<cfquery name="get_lesson_overall" datasource="#SESSION.BDDSOURCE#">	
										SELECT p.planner_id, u.user_firstname, COUNT(l.lesson_id) as nb FROM lms_tpplanner p
										INNER JOIN user u ON u.user_id = p.planner_id
										LEFT JOIN lms_lesson2 l ON l.planner_id = p.planner_id AND l.tp_id = p.tp_id
										WHERE p.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
										GROUP BY p.planner_id
									</cfquery>
									<cfloop query="get_lesson_overall">
										#get_lesson_overall.user_firstname# - #get_lesson_overall.nb# <br>
									</cfloop>
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