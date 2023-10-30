<!------------------- GET GLOBAL QUIZ --------------------->
	<!--- ! quiz_success = 1 to remove empty test from showing --->
	
<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
SELECT qu.quiz_user_id, q.quiz_id, q.quiz_type, q.quiz_name, q.quiz_name_fr, q.quiz_name_en, q.quiz_name_de, q.quiz_name_es, q.quiz_name_it, q.quiz_rank, q.quiz_alias,
qu.quiz_success, qu.quiz_user_group_id, qu.user_id, q.sessionmaster_id
FROM lms_quiz_user qu
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
WHERE qu.quiz_user_end IS NOT NULL 
AND qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> 
AND qu.quiz_head = 1
AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>
<cfset quiz_type = get_quiz_id.quiz_type>
<cfset quiz_user_id = get_quiz_id.quiz_user_id>

<cfset qpt_page = "qpt_score">
<cfinclude template="./incl/incl_pt_container.cfm">

<cfset qpt_page = "qpt_analysis">
<cfset qpt_view_only = "1">
<cfinclude template="./incl/incl_pt_container.cfm">