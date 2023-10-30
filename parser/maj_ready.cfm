<cfabort>
<cfquery name="select_rdy" datasource="#SESSION.BDDSOURCE#">
   SELECT u.user_id, t.speciality_id, t.teaching_level, f.formation_id, f.formation_code, ur.ready_id
   FROM user_teaching t INNER JOIN lms_formation f ON f.formation_id = t.formation_id 
   INNER JOIN user u ON u.user_id = t.user_id 
   LEFT JOIN user_ready ur ON t.formation_id = ur.formation_id AND t.user_id = ur.user_id
</cfquery>


<cfoutput query="select_rdy">
    <cftry>

        <cfif ready_id eq "">

            <cfquery name="insert_rdy" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_ready`(
                    `user_id`, 
                    <cfif user_ready_france neq "">`user_ready_france`,</cfif>
                    <cfif user_ready_germany neq "">`user_ready_germany`,</cfif>
                    <cfif user_ready_test neq "">`user_ready_test`,</cfif>
                    `formation_id`
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    <cfif user_ready_france neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_france#">,</cfif>
                    <cfif user_ready_germany neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_germany#">,</cfif>
                    <cfif user_ready_test neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_test#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                    )
            </cfquery>

        <cfelse>

            <cfquery name="update_rdy" datasource="#SESSION.BDDSOURCE#">
                UPDATE `user_ready` SET
                    <cfif user_ready_france neq "">`user_ready_france` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_france#">,</cfif>
                    <cfif user_ready_germany neq "">`user_ready_germany` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_germany#">,</cfif>
                    <cfif user_ready_test neq "">`user_ready_test` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_test#">,</cfif>
                    `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
            </cfquery>
            
        </cfif>


        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

</cfoutput>