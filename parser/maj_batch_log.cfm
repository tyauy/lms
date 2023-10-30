<cfabort>
<cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM logs WHERE task_type_id IS NOT NULL ORDER BY log_id ASC
</cfquery>






<cfquery name="ins_item" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO logs_item
(
    log_id,
    task_type_id
)
VALUES
<cfoutput query="get_log">
(
    <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#">
)
<cfif get_log.recordcount neq get_log.currentrow>
,
</cfif>
</cfoutput>
</cfquery>



