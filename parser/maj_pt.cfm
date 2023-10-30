<cfquery name="get_pt" datasource="#SESSION.BDDSOURCE#">
 SELECT * FROM lms_quiz_user qu
 INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
 WHERE q.quiz_type ="qpt_zh" ORDER BY qu.user_id, q.quiz_rank
</cfquery>

<cfset u_id = 0>

<cfoutput query="get_pt">
    <cfif u_id neq user_id>
        <cfset quiz_user_g_id = quiz_user_id>
        <cfset u_id = user_id>
    </cfif>
    
    <cfquery name="update" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_quiz_user SET quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_g_id#"> WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=" #quiz_user_id#">
    </cfquery>
    #user_id# > #quiz_alias# > #quiz_success#<br>
    UPDATE lms_quiz_user SET quiz_user_group_id = #quiz_user_g_id# WHERE quiz_user_id = #quiz_user_id#<br><br><br>
    
</cfoutput>