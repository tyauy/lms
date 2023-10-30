<cfparam name="window_origin" default="modal">


<cfif !isDefined("quiz_user_id") or quiz_user_id eq "">

	<cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_user_id
		FROM lms_quiz_user WHERE 
		user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
		AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cfset quiz_user_id = get_result_unit.quiz_user_id>
</cfif>



<!------------------- GET GLOBAL QUIZ --------------------->
<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
SELECT q.quiz_id, q.quiz_type, q.quiz_name, q.quiz_name_fr, q.quiz_name_en, q.quiz_name_de, q.quiz_name_es, q.quiz_name_it, q.quiz_rank, 
qu.quiz_success, qu.user_id, q.sessionmaster_id
FROM lms_quiz_user qu
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>

<!--- <cfdump var="#get_quiz_id#"> --->

<cfif get_quiz_id.recordcount eq "0">
	<cflocation addtoken="no" url="index.cfm">
<cfelse>
			
	<!------------------- CONDITION DISPLAY --------------------->
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
	<cfelseif get_quiz_id.quiz_type eq "toeic_online">
		<cfset display_result_toeic_online = "1">
		<cfset title_page = "Toeic">
	<cfelseif get_quiz_id.quiz_type eq "linguaskill">
		<cfset display_result_linguaskill = "1">
		<cfset title_page = "Linguaskill">
	<cfelseif get_quiz_id.quiz_type eq "reading_training">
		<cfset display_result_exercice = "1">
		<cfset title_page = "Reading Comprehension Training">
	</cfif>
	
</cfif>

<cfif get_quiz_id.quiz_type eq "lst">
	<cfinclude template="./incl/incl_lst_container.cfm">
<cfelse>
	<div align="center">
		<cfoutput>
			<button class="btn btn-sm btn-outline-red btn_restart_quiz" id="q_#get_quiz_id.quiz_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</button>
		</cfoutput>	
		<br>											
	</div>
	<cfset show_return = "false">
	<cfinclude template="./incl/incl_quiz_container.cfm">
</cfif>

<cfif get_quiz_id.quiz_type neq "lst">
	<cfset show_result = "answer_analysis">
	<cfinclude template="./incl/incl_quiz_result.cfm">
</cfif>

<script>
$(function() {
	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	

		if(confirm("<cfoutput>#obj_translater.get_translate('js_restart_quiz_confirm')#</cfoutput>")){
		

			<cfif window_origin eq "modal">
				$('#modal_body_xl').empty();
				$('#modal_body_xl').load("./modal_window_quiz_play_test.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});
			<cfelseif window_origin eq "div">
				$('#container_quiz_video').load("./modal_window_quiz_play_test.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});
			</cfif>
		}
	})
})
</script>