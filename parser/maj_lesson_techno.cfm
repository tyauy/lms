<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
SELECT tp_id, techno_id FROM lms_tp WHERE method_id = 1 LIMIT 100
</cfquery>



<cfoutput query="get_tp">

    <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
    SELECT session_id FROM lms_tpsession WHERE tp_id = #tp_id#
    </cfquery>

    <cfloop query="get_session">
    UPDATE lms_lesson2 SET techno_id = #get_tp.techno_id# WHERE session_id = #session_id#<br><br>
    </cfloop>

</cfoutput>