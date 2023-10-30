<cfabort>

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, perso_id FROM `user` WHERE perso_id IS NOT NULL
 </cfquery>
 
 
 <cfoutput query="select">

    <cfloop list="#perso_id#" delimiters="," index="name">

    <cftry>

            <cfquery name="insert_user_personality" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_personality`(
                    `user_id`, 
                    `personality_id`
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