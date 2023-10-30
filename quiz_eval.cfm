<!DOCTYPE html>

<cfsilent>
	
	<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "test">
		<cfset u_id = SESSION.USER_ID>
	<cfelse>
		<cfset u_id = u_id>
	</cfif>
	
	<!------------------- GET GLOBAL QUIZ --------------------->
	<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_name, q.quiz_name_fr, q.quiz_name_en, q.quiz_name_de, q.quiz_name_es, q.quiz_name_it, q.quiz_rank, 
	qu.quiz_success, qu.user_id, qu.quiz_user_group_id, q.sessionmaster_id
	FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	<cfif get_quiz_id.recordcount eq "0">
		<cflocation addtoken="no" url="index.cfm">
	<cfelse>
			
		<!------------------- CONDITION DISPLAY --------------------->
		
		<cfif findnocase("qpt_",get_quiz_id.quiz_type)>
			<cfset display_result_qpt = "1">
			<cfset title_page = "#obj_translater.get_translate('title_page_learner_eval_pt')#">
		<cfelse>
			<cfif get_quiz_id.quiz_type eq "lst">
				<cfset display_result_lst = "1">
				<cfset title_page = "#obj_translater.get_translate('title_page_learner_eval_lst')#">
			<cfelseif get_quiz_id.quiz_type eq "unit">
				<cfset display_result_unit = "1">
				<cfset title_page = "#obj_translater.get_translate('title_page_learner_eou_quiz')#">
			<cfelseif get_quiz_id.quiz_type eq "exercice">
				<cfset display_result_exercice = "1">
				<cfset title_page = "Exercice">
			<cfelseif get_quiz_id.quiz_type eq "bright reading">
				<cfset display_result_bright_reading = "1">
				<cfset title_page = "Bright Reading Comprehension">
			<cfelseif get_quiz_id.quiz_type eq "bright listening">
				<cfset display_result_bright_listening = "1">
				<cfset title_page = "Bright Listening Comprehension">
			<cfelseif get_quiz_id.quiz_type eq "toeic">
				<cfset display_result_toeic = "1">
				<cfset title_page = "Toeic">
			<cfelseif get_quiz_id.quiz_type eq "linguaskill">
				<cfset display_result_linguaskill = "1">
				<cfset title_page = "Linguaskill">
			<cfelseif get_quiz_id.quiz_type eq "reading_training">
				<cfset display_result_exercice = "1">
				<cfset title_page = "Reading Comprehension Training">

			</cfif>
		</cfif>
		
	</cfif>
		

<cfoutput><cfset message_go_needs = #obj_translater.get_translate_complex('message_go_needs')#></cfoutput>

														
														
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
</head>

	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
		
	}
	</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<cfif isdefined("display_result_lst")>
			
				<div class="row">				
					<div class="col-lg-10 offset-lg-1 col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">
								<h4 class="card-title d-inline"><cfoutput>#obj_translater.get_translate('title_page_learner_eval_lst')#</cfoutput></h4>
									<cfinclude template="./incl/incl_lst_container.cfm">
								</div>
							</div>
						</div>						
					</div>					
				</div>
			
			<cfelseif isdefined("display_result_qpt")>
											
				<div class="row">	
					<div class="col-lg-10 offset-lg-1 col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">
								<cfset qpt_page = "qpt_score">
								<cfinclude template="./incl/incl_pt_container.cfm">

								<cfset qpt_page = "qpt_analysis">
								<cfinclude template="./incl/incl_pt_container.cfm">
							</div>		
						</div>						
					</div>
				</div>
									
			<cfelse>
			
				<div class="row">	
					<div class="col-lg-10 offset-lg-1 col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">
								<cfinclude template="./incl/incl_quiz_container.cfm">
							</div>		
						</div>						
					</div>
				</div>		
				
				<div class="row">				
					<div class="col-lg-10 offset-lg-1 col-md-12">					
						<div class="card border-top border-info">					
							<div class="card-body">						
								<h4 class="card-title text-center d-block">
								<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
								<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
								<cfelse>
								<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
								</cfif>
								- <cfoutput>#obj_translater.get_translate('card_eval_answer_details')#</cfoutput></h4>
								<br><br>
								<cfset show_result = "answer_analysis">
								<cfinclude template="./incl/incl_quiz_result.cfm">
							</div>		
						</div>
					</div>
				</div>
			
			</cfif>
			
			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">


<cfif not isdefined("display_result_lst")>

	<cfset show_result = "chart">
	<cfinclude template="./incl/incl_quiz_result.cfm">
								
</cfif>
</body>
</html>



