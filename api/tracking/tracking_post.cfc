<cfcomponent>

	<cffunction name="insert_tracking_keyword" httpMethod="POST" access="remote"  returnFormat="json" returntype="string" output="false">
		<cfargument name="session_id" type="numeric" required="yes">
		<cfargument name="trainer_id" type="any" required="no" default="">
		<cfargument name="keyword_id" type="string" required="yes">
		<cfargument name="tracking_status_id" type="string" required="yes">
		<cfargument name="sm_id" type="string" required="no" default="">
		<cfargument name="tracking_progress" type="string" required="no" default="">
		<cfargument name="tracking_note" type="string" required="no" default="">
		<cfargument name="tracking_elapsed" type="string" required="no" default="">

	
		<cftry>
	
			<cfdump var="#keyword_id#">
			<cfdump var="#deserializeJSON(keyword_id)#">

			<cfset karray = deserializeJSON(keyword_id)>
			<cfset klist = karray.toList()>
			<cfdump var="#klist#">

			<cfif klist eq "">
				<cfreturn 0>
			</cfif>

			<cfquery name="select_keyword" datasource="#SESSION.BDDSOURCE#">
				SELECT `tracking_keyword_id`, `keyword_id` FROM `tracking_keyword` 
				WHERE <!---`trainer_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">
				AND --->`session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
				AND `tracking_keyword_status_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">
			</cfquery>
			<!--- AND `keyword_id` IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#klist#" list="true">) --->

			<cfdump var="#select_keyword#">

			<cfoutput query="select_keyword">
				<cfset pos = listFindNoCase(klist, select_keyword.keyword_id)>


				<cfif pos eq 0>
					<cfquery datasource="#SESSION.BDDSOURCE#">
						DELETE FROM `tracking_keyword` 
						WHERE `tracking_keyword_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_keyword.tracking_keyword_id#">
					</cfquery>
				<cfelse>
					<cfset klist = ListDeleteAt(klist,pos)>
				</cfif>

			</cfoutput>
		
			<cfloop list="#klist#" index="cor">
				<cfquery datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `tracking_keyword`(
						`session_id`, 
						`keyword_id`,
						<cfif sm_id neq "">`sm_id`,</cfif>
						`tracking_keyword_status_id`,
						<cfif tracking_progress neq "">`tracking_keyword_progress`,</cfif>
						<cfif tracking_note neq "">`tracking_keyword_note`,</cfif>
						<cfif trainer_id neq "">`trainer_id`,</cfif>
						`tracking_keyword_date`,
						`tracking_keyword_elapsed`
						) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
						<cfif sm_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,</cfif>
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">,
						<cfif tracking_progress neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_progress#">,</cfif>
						<cfif tracking_note neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_note#">,</cfif>
						<cfif trainer_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">,</cfif>
						NOW(),
						0
						)
				</cfquery>
			</cfloop>

	
		<cfreturn 1>
		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>
	</cffunction>






	<cffunction name="insert_tracking_mapping" httpMethod="POST" access="remote"  returnFormat="json" returntype="string" output="false">
		<cfargument name="session_id" type="numeric" required="yes">
		<cfargument name="trainer_id" type="any" required="no" default="">
		<cfargument name="mapping_id" type="string" required="yes">
		<cfargument name="sm_id" type="string" required="no" default="">
		<cfargument name="tracking_status_id" type="string" required="yes">
		<cfargument name="tracking_progress" type="string" required="no" default="">
		<cfargument name="tracking_note" type="string" required="no" default="">
		<cfargument name="tracking_elapsed" type="string" required="no" default="">

	
		<cftry>
	
			<cfdump var="#mapping_id#">
			<cfdump var="#deserializeJSON(mapping_id)#">

			<cfset karray = deserializeJSON(mapping_id)>
			<cfset klist = karray.toList()>
			<cfdump var="#klist#">

			<cfif klist eq "">
				<cfreturn 0>
			</cfif>

			<cfquery name="select_mapping" datasource="#SESSION.BDDSOURCE#">
				SELECT `tracking_mapping_id`, `mapping_id` FROM `tracking_mapping` 
				WHERE <!---`trainer_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">
				AND --->`session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
				AND `tracking_mapping_status_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">
			</cfquery>
			<!--- AND `mapping_id` IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#klist#" list="true">) --->

			<cfdump var="#select_mapping#">

			<cfoutput query="select_mapping">
				<cfset pos = listFindNoCase(klist, select_mapping.mapping_id)>


				<cfif pos eq 0>
					<cfquery datasource="#SESSION.BDDSOURCE#">
						DELETE FROM `tracking_mapping` 
						WHERE `tracking_mapping_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_mapping.tracking_mapping_id#">
					</cfquery>
				<cfelse>
					<cfset klist = ListDeleteAt(klist,pos)>
				</cfif>

			</cfoutput>
		
			<cfloop list="#klist#" index="cor">
				<cfquery datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `tracking_mapping`(
						`session_id`, 
						`mapping_id`,
						<cfif sm_id neq "">`sm_id`,</cfif>
						`tracking_mapping_status_id`,
						<cfif tracking_progress neq "">`tracking_mapping_progress`,</cfif>
						<cfif tracking_note neq "">`tracking_mapping_note`,</cfif>
						<cfif trainer_id neq "">`trainer_id`,</cfif>
						`tracking_mapping_date`,
						`tracking_mapping_elapsed`
						) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
						<cfif sm_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,</cfif>
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">,
						<cfif tracking_progress neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_progress#">,</cfif>
						<cfif tracking_note neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_note#">,</cfif>
						<cfif trainer_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">,</cfif>
						NOW(),
						0
						)
				</cfquery>
			</cfloop>

	
		<cfreturn 1>
		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="insert_tracking_vocab" httpMethod="POST" access="remote" returntype="any" output="false">
		<cfargument name="session_id" type="numeric" required="yes">
		<cfargument name="trainer_id" type="any" required="no" default="">
		<cfargument name="vocab_id" type="numeric" required="yes">
		<cfargument name="sm_id" type="string" required="no" default="">
		<cfargument name="tracking_status_id" type="string" required="yes">
		<cfargument name="tracking_progress" type="string" required="no" default="">
		<cfargument name="tracking_note" type="string" required="no" default="">
		<cfargument name="tracking_elapsed" type="string" required="no" default="">

	
		<cftry>
	
			<cfquery name="select_vocab" datasource="#SESSION.BDDSOURCE#">
				SELECT `tracking_voc_id`, `voc_cat_id` FROM `tracking_vocab` 
				WHERE <!---`trainer_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">
				AND---> `session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
				AND `voc_cat_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#vocab_id#">
				AND `tracking_voc_status_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">
			</cfquery>


			<cfif select_vocab.recordcount eq 0>
				
				<cfquery datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `tracking_vocab`(
						`session_id`, 
						`voc_cat_id`,
						<cfif sm_id neq "">`sm_id`,</cfif>
						<cfif tracking_status_id neq "">`tracking_voc_status_id`,</cfif>
						<cfif tracking_progress neq "">`tracking_voc_progress`,</cfif>
						<cfif tracking_note neq "">`tracking_voc_note`,</cfif>
						<cfif trainer_id neq "">`trainer_id`,</cfif>
						`tracking_voc_date`,
						`tracking_voc_elapsed`
						) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#vocab_id#">,
						<cfif sm_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,</cfif>
						<cfif tracking_status_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_status_id#">,</cfif>
						<cfif tracking_progress neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_progress#">,</cfif>
						<cfif tracking_note neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#tracking_note#">,</cfif>
						<cfif trainer_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">,</cfif>
						NOW(),
						0
						)
				</cfquery>

			<cfelse>

				<cfquery datasource="#SESSION.BDDSOURCE#">
					DELETE FROM `tracking_vocab` 
					WHERE `tracking_voc_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_vocab.tracking_voc_id#">
				</cfquery>

			</cfif>

	
		<cfreturn 1>
		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="up_user_level_subskill" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="formation_id" type="numeric" required="yes">
		<cfargument name="level_sub_id" type="numeric" required="yes">
		<cfargument name="skill_id" type="numeric" required="yes">
        <cfargument name="sub_skill_id" type="numeric" required="yes">
		<cfargument name="trainer_id" type="any" required="no" default="">


        <cftry>

			<cfquery name="get_info" datasource="#SESSION.BDDSOURCE#">
                SELECT l.level_id, l.level_alias, ls.level_sub_name, ls.level_sub_id,
                (SELECT formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">) as formation_code
                FROM lms_level_sub ls
                INNER JOIN lms_level l ON l.level_id = ls.level_id
                WHERE ls.level_sub_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_sub_id#">
            </cfquery>

            <cfquery name="select_skill" datasource="#SESSION.BDDSOURCE#">
				SELECT `tracking_skill_id` FROM `tracking_skill` 
				WHERE <!---`trainer_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">
				AND---> `session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
				AND `sub_skill_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_skill_id#">
			</cfquery>


			<cfif select_skill.recordcount eq 0>
				
				<cfquery datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `tracking_skill`(
						`session_id`, 
						`skill_id`,
						`sub_skill_id`,
						`level_id`,
						`level_sub_id`,
						<cfif trainer_id neq "">`trainer_id`,</cfif>
						`tracking_skill_date`
						) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#skill_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#sub_skill_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#get_info.level_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#level_sub_id#">,
						<cfif trainer_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#trainer_id#">,</cfif>
						NOW()
						)
				</cfquery>

			<cfelse>

				<!--- <cfquery datasource="#SESSION.BDDSOURCE#">
					DELETE FROM `tracking_vocab` 
					WHERE `tracking_voc_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_skill.tracking_voc_id#">
				</cfquery> --->

			</cfif>
			
			<!--- DO WE UPDATE IT EVERY TIME ? --->

            <!--- NEW INSERT LEVEL GLOBAL --->
			<!--- <cfinvoke component="api/users/user_post" method="up_user_level">
				<cfinvokeargument name="user_id" value="#user_id#">
				<cfinvokeargument name="skill_id" value="#skill_id#">
				<cfinvokeargument name="sub_skill_id" value="#sub_skill_id#">
				<cfinvokeargument name="formation_id" value="#formation_id#">
				<cfinvokeargument name="formation_code" value="#get_info.formation_code#">
				<cfinvokeargument name="level_id" value="#get_info.level_id#">
				<cfinvokeargument name="level_code" value="#get_info.level_alias#">
                <cfinvokeargument name="level_sub_id" value="#get_info.level_sub_id#">
				<cfinvokeargument name="level_sub_code" value="#get_info.level_sub_name#">
				<cfinvokeargument name="level_verified" value="1">
			</cfinvoke> --->
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>


	<!--- <cffunction name="updt_session_vocab" httpMethod="POST" access="remote" returntype="any" output="false">
		<cfargument name="s_id" type="numeric" required="yes">
		<cfargument name="v_id" type="numeric" required="yes">

	
		<cftry>

			<cfquery name="get_v" datasource="#SESSION.BDDSOURCE#">
				SELECT voc_cat_id FROM lms_tpsession 
				WHERE session_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
			</cfquery>

			<cfset newlist = get_v.voc_cat_id>

			<cfif not listfind(newlist,v_id)>
				<cfset newlist = ListAppend(newlist,v_id)>
			</cfif>
	
			<cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tpsession SET
				voc_cat_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newlist#">
				WHERE session_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
			</cfquery>
	
		<cfreturn 1>
		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>
	</cffunction> --->


	<cffunction name="insert_elearning_progress" access="remote" returntype="numeric">
        <cfargument name="user_id" type="numeric" required="no" default="#SESSION.USER_ID#">
        <cfargument name="module_id" type="string" required="yes">

        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `elearning_user_id`, `elearning_active` FROM `lms_elearning_module_user` 
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `elearning_module_id` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_id#">
            </cfquery>

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `lms_elearning_module_user`(
                        elearning_module_id,
                        user_id
                        ) 
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.elearning_user_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `lms_elearning_module_user` SET
                    update_date = NOW()
                    WHERE `elearning_user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn return_id>

        <cfcatch type="any">
            insert_elearning_progress: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


	<cffunction name="update_elearning_progress" access="remote" returntype="any" method="POST" returnformat="json">
		<cfargument name="elearning_user_id" type="numeric" required="yes">
        <cfargument name="user_id" type="numeric" required="no" default="#SESSION.USER_ID#">
        <cfargument name="module_id" type="string" required="yes">

        <cfargument name="elearning_completion" type="float" required="no" default="0">
        <cfargument name="elearning_data" type="string" required="no" default="">
        <cfargument name="time_elapsed" type="string" required="no" default="">
        <cfargument name="elearning_score" type="float" required="no" default="0">
        <cfargument name="session_id" type="numeric" required="no" default="0">

        <cftry>

			<cfquery datasource="#SESSION.BDDSOURCE#">
				UPDATE `lms_elearning_module_user` SET
				elearning_completion = <cfqueryparam cfsqltype="cf_sql_float" value="#elearning_completion#">,
				elearning_data = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_data#">,
				time_elapsed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#time_elapsed#">,
				elearning_score = <cfqueryparam cfsqltype="cf_sql_float" value="#elearning_score#">,
				update_date = NOW()
				WHERE `elearning_user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_user_id#">
				AND `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `elearning_module_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">
				AND `session_id` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session_id#">
			</cfquery>

        <cfreturn 1>

        <cfcatch type="any">
            update_elearning_progress: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


	<cffunction name="insert_elearning_session" access="remote" returntype="any" method="POST" returnformat="json">
		<cfargument name="user_id" type="numeric" required="no" default="#SESSION.USER_ID#">
        <cfargument name="module_id" type="string" required="yes">
        <cfargument name="session_id" type="numeric" required="no" default="0">

        <cftry>

			<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `elearning_session_user_id`, `active` FROM `lms_elearning_session_user` 
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `elearning_module_id` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_id#">
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
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
						1
                    )
                </cfquery>

				<cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
					INSERT INTO `lms_elearning_module_user`(
						elearning_module_id,
						user_id
						) 
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">
					)
				</cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.elearning_session_user_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `lms_elearning_session_user` SET
					session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">,
					active = NOT active
                    WHERE `elearning_session_user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn 1>

        <cfcatch type="any">
            insert_elearning_session: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>
	
</cfcomponent>