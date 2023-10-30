<cfquery name="get_flying_lessons" datasource="#SESSION.BDDSOURCE#">
    SELECT ll2.*
    FROM lms_lesson2 ll2
    LEFT JOIN lms_tpsession ltp ON ll2.session_id = ltp.session_id AND ll2.tp_id = ltp.tp_id
    WHERE ltp.session_id IS NULL
    AND ll2.session_id IS NOT NULL
    AND (ll2.blocker_id IS NULL OR ll2.blocker_id != 1)
    AND (ll2.status_id IS NULL OR (ll2.status_id != 3 AND ll2.status_id != 4))
    ORDER BY ll2.lesson_start DESC
</cfquery>

<cfset message = "">
<cfloop query="get_flying_lessons">
    <cfset message = message & "
    -----------------------------------
    session_id: " & session_id & "
    tp_id: " & tp_id & "
    user_id: "& user_id &"
    -----------------------------------
    ">
</cfloop>

<cfmail from="service@wefitgroup.com" to="efiliondonato@wefitgroup.com" subject="SQL Flying Lessons Query Results">
    #message#
</cfmail>
