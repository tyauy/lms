<!DOCTYPE html>

<cfsilent>
	<cfquery name="get_lessonote" datasource="#SESSION.BDDSOURCE#">	
	SELECT l.lesson_id, l.lesson_start, l.lesson_end, ln.*, ul.user_id, ul.user_firstname as learner_firstname, ul.user_name as learner_name, ut.user_firstname as trainer_firstname, sm.sessionmaster_name		
	FROM lms_lesson_note ln 
	INNER JOIN lms_lesson2 l ON l.lesson_id = ln.lesson_id
	INNER JOIN lms_tpsession tps ON tps.session_id = l.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON tps.sessionmaster_id = sm.sessionmaster_id
	INNER JOIN user ul ON ul.user_id = l.user_id
	INNER JOIN user ut ON ut.user_id = l.planner_id
	ORDER BY note_id desc
	LIMIT 50
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
      
		<cfset title_page = "QA ALERT : LAST LESSON NOTES">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">	
			
				<div class="col-md-12">

					<div class="card">
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>DATE</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<td><strong>LESSON</strong></td>
								<td><strong>ACTION</strong></td>
							</tr>
							<cfoutput query="get_lessonote">				
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
									
								</td>
								<td>
									<a href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-info" target="_blank">LN</a>
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