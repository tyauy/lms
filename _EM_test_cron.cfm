
<cfquery name="get_lesson" datasource="lms-1">
SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.lesson_duration, l.lesson_link, l.tp_id, l.planner_id, l.user_id,
ul.user_firstname as learner_firstname, ul.user_name as learner_lastname, ul.user_email as learner_email, ul.user_lang as learner_lang, ul.user_remind_missed as learner_remind,
sm.sessionmaster_name, sm.sessionmaster_id,
a.account_name,
s.session_duration
FROM lms_lesson2 l
INNER JOIN lms_tpsession s ON s.session_id = l.session_id
INNER JOIN lms_tp t ON t.tp_id = s.tp_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
INNER JOIN lms_tpuser tu ON tu.tp_id = t.tp_id AND tu.tpuser_active = 1
INNER JOIN user ul ON ul.user_id = tu.user_id
LEFT JOIN account a ON a.account_id = ul.account_id
WHERE l.lesson_pending = 1
AND l.booker_date < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateadd("n","-180",now())#">
</cfquery>
<cfdump var="#get_lesson#">

<cfoutput query="get_lesson">
    
    <cfset subject = "[LMS] | Did not complete launching ! #learner_firstname# #learner_lastname#">

    <cfmail from="WEFIT <service@wefitgroup.com>" to="efiliondonato@wefitgroup.com, rremacle@wefitgroup.com,service@wefitgroup.com,trainer@wefitgroup.com,amorisset@wefitgroup.com" subject="#subject#" type="html" server="localhost">
        The lesson of this learner have been deleted because he did not complete his launching or spent more than one hour without clicking on 'continue' :
        <a href='https://lms.wefitgroup.com/common_tp_details.cfm?tp_id=#tp_id#'>GO TP</a><br>
        <a href='https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#user_id#'>GO LEARNER</a><br>
    </cfmail>
   <cfquery name="del_blocker" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM lms_lesson2
        WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_lesson.lesson_id#">
    </cfquery>

    <cfquery name="del_blocker_att" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM lms_lesson2_attendance
        WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_lesson.lesson_id#">
        AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.user_id#">
    </cfquery> 

</cfoutput>






