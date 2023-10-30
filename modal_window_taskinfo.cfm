<cfif isdefined("tt_id")>
    <cfquery name="get_task_info" datasource="#SESSION.BDDSOURCE#">
        SELECT task_explanation_long FROM task_type WHERE task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tt_id#">
    </cfquery>

        <cfoutput>#get_task_info.task_explanation_long#</cfoutput>


</cfif>