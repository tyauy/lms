<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT lqu.quiz_user_group_id, lms_tp.tp_id, lqu.pt_type FROM lms_tp INNER JOIN lms_quiz_user lqu ON lqu.tp_id = lms_tp.tp_id GROUP BY quiz_user_group_id
 </cfquery>
 
 
 <cfoutput query="select">


    <cftry>

            <cfquery name="insert_start" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `lms_quiz_user_tp`(`tp_id`, `quiz_user_group_id`, `type`) 
                VALUES (#tp_id#,#quiz_user_group_id#,"#pt_type#")
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>


 
 </cfoutput>

 <cfquery name="select2" datasource="#SESSION.BDDSOURCE#">
    SELECT tp_id, tp_quiz_start_id FROM lms_tp WHERE tp_quiz_start_id IS NOT NULL
 </cfquery>
 
 
 <cfoutput query="select2">


    <cftry>

            <cfquery name="insert_start" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `lms_quiz_user_tp`(`tp_id`, `quiz_user_group_id`, `type`) 
                VALUES (#tp_id#,#tp_quiz_start_id#,"start")
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>


 
 </cfoutput>

 <cfquery name="select3" datasource="#SESSION.BDDSOURCE#">
    SELECT tp_id, tp_quiz_end_id  FROM lms_tp WHERE tp_quiz_end_id  IS NOT NULL
 </cfquery>
 
 
 <cfoutput query="select3">


    <cftry>

            <cfquery name="insert_start" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `lms_quiz_user_tp`(`tp_id`, `quiz_user_group_id`, `type`) 
                VALUES (#tp_id#,#tp_quiz_end_id#,"end")
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>


 
 </cfoutput>
 
 <!--- <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT lqu.quiz_user_group_id, lms_tp.tp_id FROM lms_tp 
    INNER JOIN lms_quiz_user lqu ON lqu.tp_id = lms_tp.tp_id AND lqu.pt_type = "start"
 </cfquery>
 
 
 <cfoutput query="select">


    <cftry>

            <cfquery name="insert_start" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_tp SET
                tp_quiz_start_id = #quiz_user_group_id#
                WHERE tp_id = #tp_id#
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>


 
 </cfoutput>


 <cfquery name="selectend" datasource="#SESSION.BDDSOURCE#">
    SELECT lqu.quiz_user_group_id, lms_tp.tp_id FROM lms_tp INNER JOIN lms_quiz_user lqu ON lqu.tp_id = lms_tp.tp_id AND lqu.pt_type = "end"
 </cfquery>
 
 
 <cfoutput query="selectend">


    <cftry>

            <cfquery name="insert_end" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_tp SET
                tp_quiz_end_id = #quiz_user_group_id#
                WHERE tp_id = #tp_id#
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>


 
 </cfoutput> --->
