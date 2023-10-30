<cfcomponent>

<cffunction name="get_trainer_businesshour" access="public" returntype="query" description="Get trainer theorical business hours">
    <cfargument name="u_id" type="numeric" required="yes">

    <cftry>

        <cfquery name="get_trainer_businesshour" datasource="#SESSION.BDDSOURCE#">
            SELECT ubh.*
            FROM user_business_hours ubh
            INNER JOIN user u on u.user_id = ubh.user_id
            WHERE ubh.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            ORDER BY week_day
        </cfquery>
    
        <cfreturn get_trainer_businesshour>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
        </cfcatch>

    </cftry>
    
</cffunction>
</cfcomponent>