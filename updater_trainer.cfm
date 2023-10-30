<cfif isdefined("updt_trainer") AND isdefined("FORM") AND isdefined("p_id")>
	
	<cfif isdefined("updt_avail")>

		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfif isdefined("avail_id")>
				<!--- SET SESSION VARIABLES --->
				<cfset SESSION.AVAIL_ID = avail_id>
			<cfelse>
				<cfset SESSION.AVAIL_ID = "">
			</cfif>
			<cfset p_id = SESSION.USER_ID>
		<cfelse>
			<cfif not isdefined("avail_id")>
				<cfset avail_id = "">
			</cfif>
		</cfif>

		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET avail_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#avail_id#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
	<cfelseif isdefined("updt_signature")>
	
			<cfif isdefined("signature_base64")>

				<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#p_id#">
				
				<cfif not directoryExists(dir_go)>
				
				<cfdirectory directory="#dir_go#" action="create" mode="777">
				
				</cfif>
				
				<cfset myImage = ImageReadBase64(signature_base64)>

				<cfimage source="#myImage#" destination="./assets/user/#p_id#/signature.png" action="write" overwrite="yes" >

				<!---<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_lesson2 SET lesson_signed = 1 WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> AND status_id = 5
				</cfquery>--->
				
			</cfif>
			
			<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
	<cfelseif isdefined("updt_status")>
		
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

			<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET user_status_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_status_id#">,
			user_type_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_type_id#">	
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
			</cfquery>
			
			<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
			
		</cfif>
		
	<cfelseif isdefined("updt_ready")>
		
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

			<cfif isdefined("formation_id")>
				<cfinvoke component="api/users/user_trainer_post" method="post_user_ready">
					<cfinvokeargument name="user_id" value="#p_id#">
					<cfinvokeargument name="user_ready_france" value="#user_ready_france#">
					<cfinvokeargument name="user_ready_germany" value="#user_ready_germany#">
					<cfinvokeargument name="user_ready_test" value="#user_ready_test#">
					<cfinvokeargument name="user_ready_group" value="#user_ready_group#">
					<cfinvokeargument name="user_ready_classic" value="#user_ready_classic#">
					<cfinvokeargument name="user_ready_tm" value="#user_ready_tm#">
					<cfinvokeargument name="user_ready_vip" value="#user_ready_vip#">
					<cfinvokeargument name="user_ready_partner" value="#user_ready_partner#">
					<cfinvokeargument name="user_ready_assessment" value="#user_ready_assessment#">
					<cfinvokeargument name="formation_id" value="#formation_id#">
				</cfinvoke>

				<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1&rdya=1">
			</cfif>
			
		</cfif>
		
	<cfelseif isdefined("updt_details")>
		
		
		<cfif isdefined("updt_trainer_coord")>

			<cfif SESSION.USER_PROFILE eq "TRAINER">
				
				<cfset p_id = SESSION.USER_ID>
				
				<!--- <cfif isdefined("timezone_id")>
				<cfset SESSION.USER_TIMEZONE_ID = timezone_id>
				
				<cfquery name="get_timezone" datasource="#SESSION.BDDSOURCE#">
				SELECT timezone_text FROM settings_timezone WHERE timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#timezone_id#">
				</cfquery>
				<cfset SESSION.USER_TIMEZONE = get_timezone.timezone_text>
				</cfif> --->
				
				<cfset SESSION.USER_PHONE = user_phone>
				<cfset SESSION.USER_PHONE_CODE = user_phone_code>
				<cfset SESSION.USER_EMAIL_2 = user_email_2>
				
			</cfif>
			
			<cfif isdefined("user_file") AND user_file neq "">
				
				<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#p_id#">
					
				<cfif not directoryExists(dir_go)>
				
				<cfdirectory directory="#dir_go#" action="create" mode="777">
				
				</cfif>
					
				<cffile action = "upload" 
				filefield = "user_file" 
				destination = "#dir_go#" 
				nameConflict = "Overwrite"
				mode="777">			
				<cfif cffile.FileWasSaved>		
					<!---<cfif fileexists("#dir_go#/photo.jpg")>
						<cffile action="delete" file="#dir_go#/photo.jpg">
					</cfif>--->
					<cffile action="rename" 
					source = "#dir_go#/#cffile.ClientFile#" 
					destination = "#dir_go#/photo.jpg" 
					attributes="normal"> 
				</cfif>
			</cfif>

			<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
				UPDATE user 
				SET
				<cfif user_phone neq "">
					user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
					user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
				</cfif>
				<cfif isdefined("user_gender")>
				user_gender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
				</cfif>
				<cfif isdefined("user_firstname")>
				user_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
				</cfif>
				<cfif isdefined("user_name")>
				user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">,
				</cfif>
				user_email_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_2#">
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>
		
		</cfif>

		<cfif isdefined("updt_trainer_tech")>
		
				<cfinvoke component="api/users/user_trainer_post" method="post_user_techno">
					<cfinvokeargument name="user_id" value="#p_id#">
					<!--- <cfinvokeargument name="user_skype" value="#techno_9#"> --->
					<cfinvokeargument name="user_room" value="#techno_3#">
					<cfinvokeargument name="user_ggmeet" value="#techno_4#">
					<cfinvokeargument name="user_teams" value="#techno_5#">
					<cfinvokeargument name="user_zoom" value="#techno_6#">
					<!--- <cfinvokeargument name="user_whereby" value="#techno_11#"> --->
					<cfinvokeargument name="user_webex" value="#techno_10#">
					<cfif isDefined("user_techno_preferred")>
						<cfinvokeargument name="user_techno_preferred" value="#form["techno_" & user_techno_preferred]#">
					</cfif>
				</cfinvoke>
		</cfif>
		

		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
		
	<cfelseif isdefined("updt_settings")>
		
		<cfif SESSION.USER_PROFILE eq "TRAINER">
			
			<cfif isdefined("user_remind_1d")>
				<cfset SESSION.USER_REMIND_1D = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_1D = "">
			</cfif>
			
			<cfif isdefined("user_remind_3h")>
				<cfset SESSION.USER_REMIND_3H = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_3H = "">
			</cfif>
			
			<cfif isdefined("user_remind_15m")>
				<cfset SESSION.USER_REMIND_15M = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_15M = "">
			</cfif>
			
			<cfif isdefined("user_remind_scheduled")>
				<cfset SESSION.USER_REMIND_SCHEDULED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SCHEDULED = "">
			</cfif>
			
			<cfif isdefined("user_remind_missed")>
				<cfset SESSION.USER_REMIND_MISSED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_MISSED = "">
			</cfif>
			
			<cfif isdefined("user_remind_cancelled")>
				<cfset SESSION.USER_REMIND_CANCELLED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_CANCELLED = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_15m")>
				<cfset SESSION.USER_REMIND_SMS_15M = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_15M = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_missed")>
				<cfset SESSION.USER_REMIND_SMS_MISSED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_MISSED = "">
			</cfif>
			
			<cfif isdefined("user_remind_sms_scheduled")>
				<cfset SESSION.USER_REMIND_SMS_SCHEDULED = 1>
			<cfelse>
				<cfset SESSION.USER_REMIND_SMS_SCHEDULED = "">
			</cfif>
			
			<cfset p_id = SESSION.USER_ID>
			
			<!--- <cfset SESSION.USER_TIMEZONE_ID = timezone_id>
			
			<cfquery name="get_timezone" datasource="#SESSION.BDDSOURCE#">
			SELECT timezone_text FROM settings_timezone WHERE timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#timezone_id#">
			</cfquery>
			<cfset SESSION.USER_TIMEZONE = get_timezone.timezone_text> --->
			
			<cfset SESSION.USER_LANG = user_lang>
			
		</cfif>
		
		
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		<cfif isdefined("user_remind_1d")>
		user_remind_1d = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_1d#">,
		<cfelse>
		user_remind_1d = null,
		</cfif>
		<cfif isdefined("user_remind_3h")>
		user_remind_3h = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_3h#">,
		<cfelse>
		user_remind_3h = null,
		</cfif>
		<cfif isdefined("user_remind_15m")>
		user_remind_15m = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_15m#">,
		<cfelse>
		user_remind_15m = null,
		</cfif>
		<cfif isdefined("user_remind_cancelled")>
		user_remind_cancelled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_cancelled#">,
		<cfelse>
		user_remind_cancelled = null,
		</cfif>	
		<cfif isdefined("user_remind_missed")>
		user_remind_missed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_missed#">,
		<cfelse>
		user_remind_missed = null,
		</cfif>
		<cfif isdefined("user_remind_scheduled")>
		user_remind_scheduled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_scheduled#">,
		<cfelse>
		user_remind_scheduled = null,
		</cfif>	
		<cfif isdefined("user_remind_sms_15m")>
		user_remind_sms_15m = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_15m#">,
		<cfelse>
		user_remind_sms_15m = null,
		</cfif>
		<cfif isdefined("user_remind_sms_missed")>
		user_remind_sms_missed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_missed#">,
		<cfelse>
		user_remind_sms_missed = null,
		</cfif>
		<cfif isdefined("user_remind_sms_scheduled")>
		user_remind_sms_scheduled = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_remind_sms_scheduled#">,
		<cfelse>
		user_remind_sms_scheduled = null,
		</cfif>
		user_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
		<!---timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#timezone_id#">,--->
		user_blocker = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_blocker#">	

		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
	<cfelseif isdefined("updt_personnality")>

		<!--- <cfdump var="#perso_id#"> --->

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
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
	<cfelseif isdefined("updt_misc")>

		<cfif SESSION.USER_PROFILE eq "TRAINER">
			
			<cfif isdefined("interest_id")>
				<cfset SESSION.INTEREST_ID = interest_id>
			<cfelse>
				<cfset SESSION.INTEREST_ID = "">
				<cfset interest_id = "">
			</cfif>
			
			<cfif isdefined("expertise_id")>
				<cfset SESSION.EXPERTISE_ID = expertise_id>
			<cfelse>
				<cfset SESSION.EXPERTISE_ID = "">
				<cfset expertise_id = "">
			</cfif>
			<cfset p_id = SESSION.USER_ID>
		<cfelse>
			<cfif not isdefined("expertise_id")>
				<cfset expertise_id = "">
			</cfif>
			
			<cfif not isdefined("interest_id")>
				<cfset interest_id = "">
			</cfif>
			
			<!--- <cfif not isdefined("perso_id")>
				<cfset perso_id = "">
			</cfif> --->
			
		</cfif>
		
		
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#interest_id#">,
		expertise_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#expertise_id#">
		<!---user_based = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_BASED#">
		user_resume = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_resume#">,
		user_abstract = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_abstract#">--->
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
	<cfelseif isdefined("updt_about")>	
		
		<!--- <cfdump var="#form#">		 --->
		
		<cfloop collection="#form#" item="it">	
		
		<!----- UPDATE ABOUT ----->	
			<cfif find("UPDATE_", it)>
			
				<cfset uaid_tmp = listgetat(it,2,"_")>
			
				<cfset about_desc = #evaluate('update_#uaid_tmp#')#>
			
				<cfquery name="updt_user_about" datasource="#SESSION.BDDSOURCE#">
					UPDATE user_about 
					SET user_about_desc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#about_desc#"> 
					WHERE user_about_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#uaid_tmp#">
				</cfquery>
		
		
		<!----- INSERT NEW ABOUT ----->
			<cfelseif find("INSERT_TYPE", it)>
			
				<cfset count_tmp = listgetat(it,3,"_")>
				
				<cfset about_type = #evaluate('insert_type_#count_tmp#')#>
				<cfset about_desc = #evaluate('insert_desc_#count_tmp#')#>
				
				<cfquery name="about_is_exist" datasource="#SESSION.BDDSOURCE#">
					SELECT * FROM user_about WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND user_about_type = <cfqueryparam cfsqltype="cf_sql_integer" value="#about_type#">
				</cfquery>
				
				<cfif about_desc neq "" AND about_is_exist.recordcount eq 0>
				<cfquery name="add_user_about" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO user_about (user_id, user_about_type, user_about_desc)
					VALUES (#p_id#, '#about_type#', '#about_desc#')
				</cfquery>
				</cfif>
			
		<!----- INSERT PARAGRAPH ----->
			<cfelseif find("PARA_INSERT", it)>
			
				<cfset count_tmp = listgetat(it,3,"_")>
				
				<cfset para_desc = #evaluate('para_insert_#count_tmp#')#>

				<!--- <cfif para_desc neq ""> --->

					<cfquery name="para_is_exist" datasource="#SESSION.BDDSOURCE#">
						SELECT * FROM user_about WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND user_about_type = 0
					</cfquery>
					
					<cfif para_is_exist.recordcount GT 0>
						<!--- <cfset tmp = QueryGetRow(para_is_exist, 1)> --->
						<cfquery>
							UPDATE `user_about` SET 
							`user_about_desc`= '#para_desc#'
							WHERE `user_about_id`= #tmp.user_about_id#,
						</cfquery>
						
					<cfelse>
						<cfquery name="add_user_para" datasource="#SESSION.BDDSOURCE#">
							INSERT INTO user_about (user_id, user_about_type, user_about_desc)
							VALUES (#p_id#, 0, '#para_desc#')
						</cfquery>
					</cfif>


				<!--- </cfif> --->
			</cfif>
		</cfloop>
			
			
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		

	
		
	<cfelseif isdefined("updt_experience")>

		<!---<cfdump var="#form#">--->
		
		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfset p_id = SESSION.USER_ID>
		</cfif>
			
		<cfset list_exists_id ="">
		
		<!--- GET EXISTS VALUE IN DB --->
		<cfquery name="get_experience" datasource="#SESSION.BDDSOURCE#">
		SELECT experience_id FROM user_experience
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		<cfoutput query="get_experience">
			<cfset list_exists_id = listappend(list_exists_id,experience_id)>
		</cfoutput>
		
		
		<!---- BUILD LIST WITH EXISTS FORMFIELDS --->
		<cfset list_experience_id ="">
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,17) eq "EXPERIENCE_TITLE_">
				<cfset list_experience_id = listappend(list_experience_id,listgetat(cor,3,"_"))>
			</cfif>
		</cfloop>
		
		<!--- COMPARE AND GET RID OF NON EXISTING DATA, OR UPDATE --->
		<cfloop list="#list_exists_id#" index="idtemp">
			<cfif not listfind(list_experience_id,idtemp)>
				<cfquery name="remove_experience" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM user_experience
				WHERE experience_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#idtemp#">
				AND user_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>
			<cfelse>
			
				<cfset experience_start = "#evaluate('experience_yeardate_start_#idtemp#')#-#evaluate('experience_monthdate_start_#idtemp#')#-01">
				<cfset experience_end = "#evaluate('experience_yeardate_end_#idtemp#')#-#evaluate('experience_monthdate_end_#idtemp#')#-01">
				<cfif isdefined('experience_today_#idtemp#')>
					<cfset experience_today = "#evaluate('experience_today_#idtemp#')#">
				</cfif>
				
				<cfquery name="updt_experience" datasource="#SESSION.BDDSOURCE#">
				UPDATE user_experience SET
				experience_title_#SESSION.LANG_CODE# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('experience_title_#idtemp#')#">,
				experience_localisation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('experience_localisation_#idtemp#')#">,
				experience_start = <cfqueryparam cfsqltype="cf_sql_date" value="#experience_start#">,				
				experience_description_#SESSION.LANG_CODE# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('experience_description_#idtemp#')#">
				<cfif isdefined("experience_today") AND experience_today eq "1">,experience_today = 1</cfif>
				WHERE experience_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#idtemp#">
				AND user_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>		
			</cfif>
		</cfloop>
		
		<!--- INSERT NEW DATA, FIELDS STARTING BY NEW_ --->
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,21) eq "NEW_EXPERIENCE_TITLE_">
				
				<cfset idtemp = listgetat(cor,4,"_")>
			
				<cfset new_experience_start = "#evaluate('new_experience_yeardate_start_#idtemp#')#-#evaluate('new_experience_monthdate_start_#idtemp#')#-01">
				<cfset new_experience_end = "#evaluate('new_experience_yeardate_end_#idtemp#')#-#evaluate('new_experience_monthdate_end_#idtemp#')#-01">	
		
				<cfquery name="insert_experience" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_experience
				(
				experience_title_#SESSION.LANG_CODE#,
				experience_localisation,
				experience_start,
				experience_end,
				experience_description_#SESSION.LANG_CODE#,
				experience_today,
				user_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('new_experience_title_#idtemp#')#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('new_experience_localisation_#idtemp#')#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#new_experience_start#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#new_experience_end#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('new_experience_description_#idtemp#')#">,
				<cfif isdefined("new_experience_description_#idtemp#")>1,<cfelse>null,</cfif>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				)
				
				</cfquery>	
			</cfif>
		
		</cfloop>
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
		
		
	<cfelseif isdefined("updt_education")>

		<!---<cfdump var="#form#">--->
		
		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfset p_id = SESSION.USER_ID>
		</cfif>
		
		<cfset list_exists_id ="">
		
		<!--- GET EXISTS VALUE IN DB --->
		<cfquery name="get_cursus" datasource="#SESSION.BDDSOURCE#">
		SELECT cursus_id FROM user_cursus
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		<cfoutput query="get_cursus">
			<cfset list_exists_id = listappend(list_exists_id,cursus_id)>
		</cfoutput>
		
		
		<!---- BUILD LIST WITH EXISTS FORMFIELDS --->
		<cfset list_cursus_id ="">
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,13) eq "CURSUS_TITLE_">
				<cfset list_cursus_id = listappend(list_cursus_id,listgetat(cor,3,"_"))>
			</cfif>
		</cfloop>
		
		<!--- COMPARE AND GET RID OF NON EXISTING DATA, OR UPDATE --->
		<cfloop list="#list_exists_id#" index="idtemp">
			<cfif not listfind(list_cursus_id,idtemp)>
				<cfquery name="remove_cursus" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM user_cursus
				WHERE cursus_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#idtemp#">
				AND user_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>
			<cfelse>
			
				<cfset cursus_start = "#evaluate('cursus_yeardate_start_#idtemp#')#-#evaluate('cursus_monthdate_start_#idtemp#')#-01">
				<cfset cursus_end = "#evaluate('cursus_yeardate_end_#idtemp#')#-#evaluate('cursus_monthdate_end_#idtemp#')#-01">
				
				<cfquery name="updt_cursus" datasource="#SESSION.BDDSOURCE#">
				UPDATE user_cursus SET
				cursus_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('cursus_title_#idtemp#')#">,
				cursus_start = <cfqueryparam cfsqltype="cf_sql_date" value="#cursus_start#">,
				cursus_end = <cfqueryparam cfsqltype="cf_sql_date" value="#cursus_end#">,
				cursus_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('cursus_description_#idtemp#')#">
				WHERE cursus_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#idtemp#">
				AND user_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>		
			</cfif>
		</cfloop>
		
		<!--- INSERT NEW DATA, FIELDS STARTING BY NEW_ --->
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,17) eq "NEW_CURSUS_TITLE_">
				
				<cfset idtemp = listgetat(cor,4,"_")>
			
				<cfset new_cursus_start = "#evaluate('new_cursus_yeardate_start_#idtemp#')#-#evaluate('new_cursus_monthdate_start_#idtemp#')#-01">
				<cfset new_cursus_end = "#evaluate('new_cursus_yeardate_end_#idtemp#')#-#evaluate('new_cursus_monthdate_end_#idtemp#')#-01">	
		
				<cfquery name="insert_cursus" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_cursus
				(
				cursus_title,
				cursus_start,
				cursus_end,
				cursus_description,
				user_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('new_cursus_title_#idtemp#')#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#new_cursus_start#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#new_cursus_end#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('new_cursus_description_#idtemp#')#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				)
				
				</cfquery>	
			</cfif>
		
		</cfloop>
		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
		
		
		
	<cfelseif isdefined("updt_speciality")>

		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfif isdefined("method_id")>
				<cfset SESSION.METHOD_ID = method_id>
			<cfelse>
				<cfset SESSION.METHOD_ID = "">
				<cfset method_id = "">
			</cfif>
			
			<cfif isdefined("country_id")>
				<cfset SESSION.COUNTRY_ID = country_id>
			<cfelse>
				<cfset SESSION.COUNTRY_ID = "">
				<cfset country_id = "">
			</cfif>
			
			<cfset SESSION.USER_BASED = user_based>
			<cfset p_id = SESSION.USER_ID>
		<cfelse>
			<cfif not isdefined("method_id")>
				<cfset method_id = "">
			</cfif>
			
			<cfif not isdefined("country_id")>
				<cfset country_id = "">
			</cfif>
		</cfif>


		<cfset get_teaching = obj_query.oget_teaching(p_id="#p_id#")>
		<cfset get_speaking = obj_query.oget_speaking(p_id="#p_id#")>
	
	
	
	
		<!---- BUILD LIST WITH EXISTS FORMATION FORMFIELDS --->
		<cfset list_teaching_formation_id = "">
		
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,18) eq "teaching_formation">
				<cfset list_teaching_formation_id = listappend(list_teaching_formation_id,listgetat(cor,3,"_"))>
			</cfif>
		</cfloop>
		list_teaching_formation_id = <cfoutput>#list_teaching_formation_id#</cfoutput>
		<br>
		<!--- <cfdump var="#get_teaching#"> --->
		
		<!--- PARSE TABLE, DELETE, UPDATE, INSERT IF NEEDED --->
		<cfoutput query="get_teaching">
		
			<!---- IF NOT FOUND, NO NEED ANYMORE --->
			<cfif not listfind(list_teaching_formation_id,#formation_id#)>
				<!--- #formation_id# PAS TROUVE DONC DEGAGE<br> --->
				
				<!--- list_teaching_formation_id est donc maintenant #list_teaching_formation_id#<br><br><br> --->
				
				<cfquery name="del_teaching" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM user_teaching 
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
				</cfquery>
				
			<cfelse>
				
				<!--- #formation_id# TROUVE DONC UPDATE AVEC LA VALUE #evaluate('teaching_level_#formation_id#')#<br><br> --->
				
				<cfset list_teaching_formation_id = listdeleteat(list_teaching_formation_id,listfind(list_teaching_formation_id,#formation_id#))>
				
				<cfquery name="updt_teaching" datasource="#SESSION.BDDSOURCE#">
				UPDATE user_teaching SET
				level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('teaching_level_#formation_id#')#">
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
				</cfquery>
				
			</cfif>
			
		</cfoutput>
		
		<!---- INSERT LATER --->
		<cfif listlen(list_teaching_formation_id) neq "0">
			<cfloop list="#list_teaching_formation_id#" index="cor">
			<!--- <cfoutput>#cor# N'EXISTE PAS DONC INSERT AVEC LA VALEUR #evaluate('teaching_level_#cor#')#<br><br><br><br></cfoutput> --->
				<cfquery name="insert_teaching" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_teaching
				(
				user_id,
				formation_id,
				level_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('teaching_level_#cor#')#">
				)
				</cfquery>
			</cfloop>		
		</cfif>
		
		<br><br><br><br><br><br><br><br>
		
		<!---- BUILD LIST WITH EXISTS FORMATION FORMFIELDS --->
		<cfset list_speaking_formation_id = "">
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,18) eq "speaking_formation">
				<cfset list_speaking_formation_id = listappend(list_speaking_formation_id,listgetat(cor,3,"_"))>
			</cfif>
		</cfloop>
		
		<!--- PARSE TABLE, DELETE, UPDATE, INSERT IF NEEDED --->
		<cfoutput query="get_speaking">
		
			
			<cfif not listfind(list_speaking_formation_id,#formation_id#)>
			
				<cfquery name="del_speaking" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM user_speaking 
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
				</cfquery>
				
			<cfelse>
			
				<cfset list_speaking_formation_id = listdeleteat(list_speaking_formation_id,listfind(list_speaking_formation_id,#formation_id#))>
				
				<cfquery name="updt_speaking" datasource="#SESSION.BDDSOURCE#">
				UPDATE user_speaking SET
				level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#evaluate('speaking_level_#formation_id#')#">
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
				</cfquery>
				
			</cfif>
		</cfoutput>
		
		
		<!---- INSERT LATER --->
		<cfif listlen(list_speaking_formation_id) neq "0">
			<cfloop list="#list_speaking_formation_id#" index="cor">
				<cfquery name="insert_speaking" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_speaking
				(
				user_id,
				formation_id,
				level_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('speaking_level_#cor#')#">
				)
				</cfquery>
			</cfloop>		
		</cfif>
		
		
		
		
		
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET method_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#method_id#">,
		country_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#country_id#">,
		user_based = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_based#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
		
	
	
	
	
	<!---------------------------- REINIT MDP BY CS ------------------------->
	<cfelseif isdefined("updt_mdp")>
	
		<cfset temp = RandRange(100000, 999999)>
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user 
		SET 
		user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
		user_pwd_chg = 0
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
	
		<cfset user_pwd = temp>

		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_gender, user_name, user_firstname, user_email, user_lang
		FROM user u
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
				
		<cfset user_gender = get_user.user_gender>
		<cfset user_firstname = get_user.user_firstname>
		<cfset user_lastname = get_user.user_name>
		<cfset user_email = get_user.user_email>
		<cfset user_lang = get_user.user_lang>
		

		<cfif user_lang eq "fr">
			<cfset subject = "WEFIT | Vos identifiants de connexion">
		<cfelseif user_lang eq "en">
			<cfset subject = "WEFIT | Your connection identifier">
		<cfelseif user_lang eq "de">
			<cfset subject = "WEFIT | Ihre Zugangsdaten">
		<cfelseif user_lang eq "es">
			<cfset subject = "WEFIT | Your connection identifier">
		<cfelseif user_lang eq "it">
			<cfset subject = "WEFIT | Your connection identifier">
		</cfif>	
					
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" cc="trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
			<cfset lang = user_lang>
			<cfinclude template="./email/email_new_pwd.cfm">
		</cfmail>
		
	</cfif>
	
	<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=3">
	
	
	
	
	
	
<cfelseif isdefined("ins_trainer") AND isdefined("FORM")>

	<cfquery name="ins_trainer" datasource="#SESSION.BDDSOURCE#" result="insert_tr">
	INSERT INTO user
	(
	user_firstname,
	user_name,
	user_alias,
	user_temp_alias,
	user_email,
	user_password,
	user_type_id,
	user_create,
	user_status_id,
	method_id,
	user_paid_tva
	)	
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(user_firstname, 2)##left(user_name, 2)#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_firstname)# .">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#user_type_id#">,
	now(),
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_status_id#">,
	1,
	6
	)	
	</cfquery>

	

	<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO user_profile_cor
	(
	user_id,
	profile_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tr.generatedkey#">,
	4
	)
	</cfquery>
	
	<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT max(user_id) as id FROM user
	</cfquery> --->

	
	<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#insert_tr.generatedkey#&k=2">
	
</cfif>
