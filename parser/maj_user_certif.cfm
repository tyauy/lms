<cfabort>

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, certif_id FROM `user` WHERE certif_id IS NOT NULL
 </cfquery>
 
 
 <cfoutput query="select">

    <cfloop list="#certif_id#" delimiters="," index="name">

    <cftry>

            <cfquery name="insert_user_certif" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_certif`(
                    `user_id`, 
                    `certif_id`
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#name#">
                    )
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

    </cfloop>

 
 </cfoutput>
