<cfquery name="get_tp_outdated" datasource="lms-1">
SELECT * FROM lms_tp WHERE method_id = 3 AND tp_date_end < now() AND tp_status_id = 2 LIMIT 500
</cfquery>

<cfoutput query="get_tp_outdated">

<cfquery name="updt_tp" datasource="lms-1">
UPDATE lms_tp SET tp_status_id = 3
WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
</cfquery>

USER_ID = #user_id# // TP_ID  = #tp_id# // #tp_date_start# // #tp_date_end# <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#user_id#">GO</a><br><br>

</cfoutput>

    