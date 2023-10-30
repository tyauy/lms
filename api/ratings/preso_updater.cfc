<cfcomponent>
    <cfquery name="del_user_personality" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM `user_personality` WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
    </cfquery>

    <cfloop list="#perso_id#" delimiters="," index="name">
        <cftry>
        
            <cfquery name="insert_user_personality" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_personality`(
                    `user_id`, 
                    `personality_id`
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#name#">
                    )
            </cfquery>
         
     
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
        </cftry>
    
    </cfloop>
</cfcomponent>