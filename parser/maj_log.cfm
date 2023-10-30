<!---<cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
SELECT log_id, order_id FROM logs
</cfquery>

<cfoutput query="get_log">

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id FROM orders WHERE order_id = #order_id#
</cfquery>

<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
UPDATE logs SET user_id = #get_user.user_id# WHERE log_id = #log_id#
</cfquery>

</cfoutput>--->