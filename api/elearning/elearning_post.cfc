<cfcomponent>


    <cffunction name="insert_elearning_session" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="elearning_module_group_name" type="string" required="yes">
		<cfargument name="level_id" type="any" required="yes">


        <!--- <cftry> --->


            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `elearning_module_group_id ` FROM `lms_elearning_session` 
                WHERE `elearning_module_group_name` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_group_name#">
				AND `level_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">
            </cfquery>

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `lms_elearning_session`(
                        elearning_module_group_name,
                        level_id
                        ) 
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_group_name#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.elearning_module_group_id >

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `lms_elearning_user` SET
                    elearning_module_group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_group_name#">,
                    elearning_module_group_update = NOW()
                    WHERE `elearning_module_group_id ` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

            <cfreturn return_id>
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
	</cffunction>


    <cffunction name="elearning_add_module_user" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="elearning_module_id" type="any" required="yes">
		<cfargument name="user_id" type="any" required="yes">
		<cfargument name="session_id" type="any" required="no" default="0">


        <!--- <cftry> --->


            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `elearning_session_user_id` FROM `lms_elearning_session_user` 
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">
				AND `elearning_module_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_module_id#">
				AND `session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
            </cfquery>

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `lms_elearning_session_user`(
                        elearning_module_id,
                        user_id,
                        session_id,
                        active
                        ) 
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_module_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
                        1
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.elearning_session_user_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `lms_elearning_session_user` SET
                    active = NOT active
                    WHERE `elearning_session_user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

            <cfreturn return_id>
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
	</cffunction>


    <cffunction name="elearning_add_module" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="elearning_module_id" type="string" required="yes">
		<cfargument name="elearning_module_group_id" type="any" required="yes">


        <!--- <cftry> --->


            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `elearning_module_cor_id` FROM `lms_elearning_module_cor` 
                WHERE `elearning_module_id` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_id#">
				AND `elearning_module_group_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_module_group_id#">
            </cfquery>

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `lms_elearning_module_cor`(
                        elearning_module_id,
                        elearning_module_group_id
                        ) 
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_module_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_module_group_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.elearning_module_cor_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    DELETE FROM `lms_elearning_module_cor`
                    WHERE `elearning_module_cor_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

            <cfreturn return_id>
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
	</cffunction>


    <!--- <cffunction name="upload_module" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="doc_attach_preview" type="any" required="yes">
		<cfargument name="doc_attach_elearning" type="any" required="no">
		<cfargument name="elearning_id" type="any" required="no" default="0">
		<cfargument name="module_name" type="any" required="no">
		<cfargument name="module_path" type="any" required="no">
		<cfargument name="module_difficulty" type="any" required="no">

        <cftry>

		<cfif isdefined("doc_attach_preview") AND doc_attach_preview neq "">

            <cfset dir_go = "#SESSION.BO_ROOT#/assets/img_elearning/thumbs/">

            <!--- <cfif not directoryExists(dir_go)>
			
                <cfdirectory directory="#dir_go#" action="create" mode="777">
                
            </cfif> --->

            <cffile action = "upload" 
            filefield = "doc_attach_preview" 
            destination = "#dir_go#" 
            result="uploaded_file"
            nameConflict = "Overwrite"
            mode="777">		
                                
            <!--- <cfdump var="#uploaded_file#"> --->
            <cfif uploaded_file.FileWasSaved>

                <cfif FileExists("#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#")>
                    <cffile action = "delete" file = "#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#">
                </cfif>

                <cffile action="rename" 
                source = "#dir_go#/#uploaded_file.ClientFile#" 
                destination = "#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#" 
                attributes="normal"
                mode="777"> 

			</cfif>

		</cfif>

        <cfif elearning_id eq 0>

            <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                INSERT INTO `lms_elearning`(
                    module_path,
                    module_name,
                    module_difficulty
                    ) 
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_path#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_name#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#module_difficulty#">,
                    1
                )
            </cfquery>
    
        <cfelse>

            <cfquery datasource="#SESSION.BDDSOURCE#">
                UPDATE `lms_elearning` SET
                module_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_name#">
                WHERE `elearning_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#">
            </cfquery>

        </cfif>


        <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction> --->

</cfcomponent>