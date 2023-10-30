<cfif isdefined("o_md")>
<cfsilent>
<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT order_ref FROM orders WHERE order_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#o_md#">
</cfquery>
</cfsilent><cfcontent file = "#SESSION.BO_ROOT#/admin/#o_type#/#ucase(o_type)#_#get_order.order_ref#.pdf">
<cfelseif isdefined("sm_md") AND isdefined("tdoc")>
<cfsilent>
<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT sessionmaster_ressource FROM lms_tpsessionmaster2 WHERE sessionmaster_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sm_md#">
</cfquery>
</cfsilent><cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#ucase(tdoc)#.pdf")><cfcontent file = "#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#ucase(tdoc)#.pdf"></cfif>
</cfif>