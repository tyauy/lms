<cfcomponent>

	<cffunction name="oget_session_access" access="remote" returntype="query">
        <cfargument name="user_session_right_id" type="any" required="no">
        <cfargument name="user_account_right_id" type="any" required="no">

        <cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
            SELECT token_session_id, token_session_name
            FROM lms_list_token_session
            <cfif isdefined("user_session_right_id")>
            WHERE token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_session_right_id#" list="true">)
            <cfelseif isdefined("user_account_right_id")>
            WHERE account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_account_right_id#" list="true">)
            <cfelse>
            1 = 0
            </cfif>
        </cfquery>

        <cfreturn get_session_access>

    </cffunction>

</cfcomponent>