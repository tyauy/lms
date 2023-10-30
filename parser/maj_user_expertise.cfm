<cfabort>

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, expertise_id FROM `user` WHERE expertise_id IS NOT NULL
 </cfquery>
 
 
 <cfoutput query="select">

    <cfloop list="#expertise_id#" delimiters="," index="name">

    <cftry>

            <cfquery name="insert_user_expertise" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_expertise`(
                    `user_id`, 
                    `expertise_id`,
                    expertise_needed
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#name#">,
                    0
                    )
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

    </cfloop>

 
 </cfoutput>


 <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, user_needs_expertise_id FROM `user` WHERE user_needs_expertise_id IS NOT NULL
 </cfquery>

<cfoutput query="select">

    <cfloop list="#user_needs_expertise_id#" delimiters="," index="name">

    <cftry>

            <cfquery name="insert_user_expertise" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_expertise`(
                    `user_id`, 
                    `expertise_id`,
                    expertise_needed
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#name#">,
                    1
                    )
            </cfquery>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

    </cfloop>

 
 </cfoutput>