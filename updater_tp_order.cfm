
<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_tp SET order_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#order_id#">

WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
</cfquery>

<cfabort>

<cflocation addtoken="no" url="common_order_check.cfm##u_#u_id#">
