<!--- head as rank
UPDATE lms_quiz_user qu SET qu.quiz_head=(SELECT q.quiz_rank FROM lms_quiz q WHERE q.quiz_id = qu.quiz_id)
 --->


<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(qu.quiz_user_id) as id, qu.quiz_user_group_id, qu.user_id, q.quiz_formation_id
FROM lms_quiz_user qu
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
GROUP BY qu.quiz_user_group_id
</cfquery>

<cfloop query="get_group">

    <cfif quiz_user_group_id neq "">

        <cfquery name="insert_quiz_score" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO `lms_quiz_user_score`(`quiz_user_group_id`, quiz_formation_id, user_id) 
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_group.quiz_user_group_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_group.quiz_formation_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_group.user_id#">
                )
        </cfquery>
    
    
        <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_quiz_user SET quiz_head = 1 WHERE quiz_user_id = #get_group.id#
        </cfquery>
    </cfif>
    


</cfloop>


    <!--- <cfquery name="get_global" datasource="#SESSION.BDDSOURCE#">
        SELECT SUM(qr.ans_gain) as score, q.quiz_formation_id
		FROM lms_quiz_result qr
		INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
		WHERE qu.quiz_user_group_id = #item#
    </cfquery> --->

<!--- <cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
    SELECT SUM(qr.ans_gain) as score
    FROM lms_quiz_result qr
    INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
    INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
    INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
    WHERE qu.quiz_user_group_id = #item#
    AND (que.qu_category_id = 1 OR que.qu_category_id = 2) 
</cfquery>

<cfquery name="get_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT SUM(qr.ans_gain) as score
    FROM lms_quiz_result qr
    INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
    INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
    INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
    WHERE qu.quiz_user_group_id = #item#
    AND que.qu_category_id = 4
</cfquery>

<cfquery name="get_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT SUM(qr.ans_gain) as score
    FROM lms_quiz_result qr
    INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
    INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
    INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
    WHERE qu.quiz_user_group_id = #item#
    AND que.qu_category_id = 3
</cfquery> --->


<!--- <cfoutput>
    <p>
        #get_global.score#
        <!--- #get_grammar.score#
        #get_listening.score#
        #get_reading.score# --->
    </p>
</cfoutput> --->

OK
