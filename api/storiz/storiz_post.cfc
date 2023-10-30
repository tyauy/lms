<cfcomponent>


    <cffunction name="insert_storiz_page" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="sco" type="any" required="yes">
		<cfargument name="index" type="any" required="yes">
		<cfargument name="type" type="any" required="yes">
		<cfargument name="test" type="any" required="yes">

        <!--- <cftry> --->


            <cfquery name="ins_sco" datasource="#SESSION.BDDSOURCE#" result="new_index">
                INSERT INTO lms_scorm_mapping
                (
                    scorm_id,
                    scorm_index,
                    scorm_type,
                    test
                )
                VALUES(
                <cfqueryparam cfsqltype="cf_sql_integer" value="#sco#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#index#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#test#">
                )
            </cfquery>


            <cfreturn 1>
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
	</cffunction>

</cfcomponent>