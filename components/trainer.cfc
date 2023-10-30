<cfcomponent>

	<cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
	<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">


	<cffunction name="upload_picture" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="file_picture" type="any" required="yes">
		<cfargument name="p_id" type="any" required="yes">

		<cfif isdefined("file_picture") AND file_picture neq "">
				
			<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#p_id#">	
				
			<cfif not directoryExists(dir_go)>
			
				<cfdirectory directory="#dir_go#" action="create" mode="777">
			
			</cfif>
				
			<cffile action = "upload" 
			filefield = "file_picture" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777"
			result="uploaded_file"
			>			
			<cfif uploaded_file.FileWasSaved>		
				<cfif fileexists("#dir_go#/photo.jpg")>
					<cffile action="delete" file="#dir_go#/photo.jpg">
				</cfif>
				<cffile action="rename" 
				source = "#dir_go#/#uploaded_file.ClientFile#" 
				destination = "#dir_go#/photo.jpg" 
				attributes="normal"> 
			</cfif>
			
			<cfreturn uploaded_file>
			
			
		</cfif>
		
	</cffunction>


		
	<cffunction name="upload_video" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="file_video" type="any" required="yes">
		<cfargument name="p_id" type="any" required="yes">

		<cfif isdefined("file_video") AND file_video neq "">
				
			<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#p_id#">	
				
			<cfif not directoryExists(dir_go)>
			
				<cfdirectory directory="#dir_go#" action="create" mode="777">
			
			</cfif>
				
			<cffile action = "upload" 
			filefield = "file_video" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777"
			result="uploaded_file"
			>			
			<cfif uploaded_file.FileWasSaved>		
				<cfif fileexists("#dir_go#/video.mp4")>
					<cffile action="delete" file="#dir_go#/video.mp4">
				</cfif>
				<cffile action="rename" 
				source = "#dir_go#/#uploaded_file.ClientFile#" 
				destination = "#dir_go#/video.mp4" 
				attributes="normal"> 
			</cfif>
			
			<cfreturn uploaded_file>
			
			
		</cfif>
		
	</cffunction>

	



	<cffunction name="upload_cursus" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="file_cursus" type="any" required="yes">
		<cfargument name="p_id" type="any" required="yes">
		<cfargument name="cursus_id" type="any" required="yes">

		<cfif file_cursus neq "">
				
			<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#p_id#">	
				
			<cfif not directoryExists(dir_go)>			
				<cfdirectory directory="#dir_go#" action="create" mode="777">			
			</cfif>
				
			<cffile action = "upload" 
			allowedExtensions=".pdf,.jpg,.jpeg,.JPG,.JPEG"
			filefield = "file_cursus" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777"
			result="uploaded_file"
			>			
			<cfif uploaded_file.FileWasSaved>		
				
				<cfif fileexists("#dir_go#/certif_#cursus_id#.#uploaded_file.clientFileExt#")>
					<cffile action="delete" file="#dir_go#/certif_#cursus_id#.#uploaded_file.clientFileExt#">
				</cfif>

				<cfif uploaded_file.clientFileExt eq "jpeg" OR uploaded_file.clientFileExt eq "JPG" OR uploaded_file.clientFileExt eq "JPEG" OR uploaded_file.clientFileExt eq "jpg">
					
					<cfset final_file="certif_#cursus_id#.jpg">
					
					<cfimage name = "pic_read" source="#dir_go#/#uploaded_file.ClientFile#">
	
					<cfset pic_info = ImageInfo(pic_read)>

						<cfif pic_info.height gt "1200" OR pic_info.width gt "1600">

							<cfif pic_info.height gt "1200">

								<cfimage 
								action="resize" 
								height="1200" 
								width="#round(pic_info.width/(pic_info.height/1200))#"
								source="#dir_go#/#uploaded_file.ClientFile#" 
								destination="#dir_go#/#final_file#" 
								interpolation="mediumPerformance" 
								>

							<cfelse>

								<cfimage 
								action="resize" 
								height="#round(pic_info.height/(pic_info.width/1200))#" 
								width="1600" 
								source="#dir_go#/#uploaded_file.ClientFile#" 
								destination="#dir_go#/#final_file#" 
								interpolation="mediumPerformance" 
								>

							</cfif>

						</cfif>


					
					<cffile action="delete" file="#dir_go#/#uploaded_file.ClientFile#">

					
				<cfelse>
					<cfset final_file = "certif_#cursus_id#.#uploaded_file.clientFileExt#">
					<cffile action="rename" 
					source = "#dir_go#/#uploaded_file.ClientFile#" 
					destination = "#dir_go#/#final_file#" 
					attributes="normal"> 
				</cfif>
				
			</cfif>
			
			<cfreturn uploaded_file>
			
		</cfif>
		
	</cffunction>



	<cffunction name="ins_teaching" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="formation_teaching_id" type="numeric" required="yes">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="level_teaching_id" type="any" required="yes">
		<cfargument name="formation_accent_id" type="any" required="no">
		
		<!----- ADD TAUGHT LANGUAGE ----------->
		<cfquery name="ins_teaching" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_teaching 
			(
			user_id, 
			formation_id, 
			level_id,
			accent_id
			) 
			VALUES 
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#formation_teaching_id#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#level_teaching_id#">,
			<cfif isdefined("formation_accent_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#formation_accent_id#"><cfelse>null</cfif>
			)
		</cfquery>
		
		<cfquery name="get_max_teaching" datasource="#SESSION.BDDSOURCE#">
			SELECT f.formation_code, t.teaching_id, f.formation_name_#SESSION.LANG_CODE# as formation_name,
			lfa.formation_accent_id, lfa.formation_accent_name_#SESSION.LANG_CODE# as formation_accent_name
			FROM user_teaching t
			INNER JOIN lms_formation f ON f.formation_id = t.formation_id
			LEFT JOIN lms_formation_accent lfa ON lfa.formation_accent_id = t.accent_id
			WHERE teaching_id = last_insert_id()
		</cfquery>
		
		
		<!----- ADD SPOKEN LANGUAGE AS WELL ----------->
		<cfquery name="ins_speaking" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_speaking
			(
			user_id, 
			formation_id, 
			level_id
			) 
			VALUES 
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#formation_teaching_id#">,
			6
			)
		</cfquery>
		
		<cfquery name="get_max_speaking" datasource="#SESSION.BDDSOURCE#">
			SELECT f.formation_code, s.speaking_id, f.formation_name_#SESSION.LANG_CODE# as formation_name FROM user_speaking s
			INNER JOIN lms_formation f ON f.formation_id = s.formation_id
			WHERE speaking_id = last_insert_id()
		</cfquery>
		
		<cfset result = StructNew()>
		<cfset result[0] = get_max_teaching.teaching_id>
		<cfset result[1] = lcase(get_max_teaching.formation_code)>
		<cfset result[2] = get_max_teaching.formation_name>
		<cfset result[3] = level_teaching_id>
		
		<cfset result[4] = get_max_speaking.speaking_id>
		<cfset result[5] = lcase(get_max_speaking.formation_code)>
		<cfset result[6] = get_max_speaking.formation_name>
		<cfset result[7] = "6">
		<cfset result[8] = get_max_teaching.formation_accent_id>
		<cfset result[9] = get_max_teaching.formation_accent_name>
		<cfreturn result>
		
		
	</cffunction>


	<cffunction name="del_teaching" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="teaching_id" type="numeric" required="yes">
		
		<cfquery name="get_teaching" datasource="#SESSION.BDDSOURCE#">
			SELECT formation_id FROM user_teaching t
			WHERE teaching_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_id#">
		</cfquery>
		
		<cfquery name="del_teaching" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_teaching WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND teaching_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_id#">
		</cfquery>
		
		<!----- DELETE SPOKEN LANGUAGE AS WELL ----------->
		<cfquery name="del_speaking" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_speaking WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_teaching.formation_id#">
		</cfquery>
		
		
		<cfset result = StructNew()>
		<cfset result[0] = get_teaching.formation_id>
		
		<cfreturn result>

	</cffunction>
	
	
	
	<cffunction name="ins_speaking" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="formation_speaking_id" type="numeric" required="yes">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="level_speaking_id" type="any" required="yes">
		
		
		<cfquery name="ins_speaking" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_speaking 
			(
			user_id, 
			formation_id, 
			level_id
			) 
			VALUES 
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#formation_speaking_id#">,
			'#level_speaking_id#'
			)
		</cfquery>
		
		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT f.formation_code, t.speaking_id, f.formation_name_#SESSION.LANG_CODE# as formation_name FROM user_speaking t
			INNER JOIN lms_formation f ON f.formation_id = t.formation_id
			WHERE speaking_id = last_insert_id()
		</cfquery>
		
		<cfset result = StructNew()>
		<cfset result[0] = get_max.speaking_id>
		<cfset result[1] = lcase(get_max.formation_code)>
		<cfset result[2] = get_max.formation_name>
		<cfset result[3] = level_speaking_id>
		<cfreturn result>
		
		
	</cffunction>


	<cffunction name="del_speaking" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="speaking_id" type="numeric" required="yes">
		
		<cfquery name="get_speaking" datasource="#SESSION.BDDSOURCE#">
			SELECT formation_id FROM user_speaking t
			WHERE speaking_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#speaking_id#">
		</cfquery>
		
		<cfquery name="del_speaking" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_speaking WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND speaking_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#speaking_id#">
		</cfquery>
		
		<cfset result = StructNew()>
		<cfset result[0] = get_speaking.formation_id>
		
		<cfreturn result>

	</cffunction>
	

	
	<cffunction name="updt_nationality" access="remote" returntype="any">
		<cfargument name="country_id" type="numeric" required="no">
		<cfargument name="user_based" type="any" required="no">
		<cfargument name="p_id" type="any" required="no">
		
		<cfquery name="updt_nationality" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET country_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#country_id#">,
			user_based = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_based#">
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#isDefined("p_id") ? p_id : SESSION.USER_ID#">
		</cfquery>
		
		<cfreturn "ok">

	</cffunction>
	
	
	
	<cffunction name="updt_perso" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="perso_id" type="any" required="yes">
		
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
		
		<cfreturn "ok">

	</cffunction>












	<cffunction name="del_expertise_business" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="exp_id" type="numeric" required="yes">
	
		<cfquery name="del_expertise_business" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_expertise_business WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND expertise_business_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#exp_id#">
		</cfquery>		
		
		<cfreturn "ok">

	</cffunction>


	<cffunction name="ins_expertise_business" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="keyword_id" type="numeric" required="yes">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="expertise_business_practical_duration" type="any" required="yes">
		<cfargument name="expertise_business_teaching_duration" type="any" required="yes">
		
		<cfquery name="ins_expertise_business" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_expertise_business
			(
			user_id, 
			keyword_id,
			expertise_business_practical_duration,
			expertise_business_teaching_duration
			) 
			VALUES 
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#keyword_id#">,
			<cfif expertise_business_practical_duration neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#expertise_business_practical_duration#"><cfelse>null</cfif>,
			<cfif expertise_business_teaching_duration neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#expertise_business_teaching_duration#"><cfelse>null</cfif>
			)
		</cfquery>
	
		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT eb.*, kw.keyword_name_#SESSION.LANG_CODE# as keyword_name
			FROM user_expertise_business eb
			INNER JOIN lms_keyword kw on kw.keyword_id = eb.keyword_id
			WHERE eb.expertise_business_id = last_insert_id()
		</cfquery>
		
		<cfset result = StructNew()>
		<cfset result[0] = get_max.expertise_business_id>
		<cfset result[1] = get_max.keyword_name>
		<cfif get_max.expertise_business_practical_duration neq "1"><cfset result[2] = "#get_max.expertise_business_practical_duration# #obj_translater.get_translate('short_years')#"><cfelse><cfset result[2] = "#get_max.expertise_business_practical_duration# #obj_translater.get_translate('short_year')#"></cfif>
		<cfif get_max.expertise_business_teaching_duration neq "1"><cfset result[3] = "#get_max.expertise_business_teaching_duration# #obj_translater.get_translate('short_years')#"><cfelse><cfset result[3] = "#get_max.expertise_business_teaching_duration# #obj_translater.get_translate('short_year')#"></cfif>

		<cfreturn result>
		
	</cffunction>


	<cffunction name="updt_certif" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="certif_id" type="any" required="yes">
		
		<cfquery name="del_user_certif" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM `user_certif` WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		<cfloop list="#certif_id#" delimiters="," index="name">
			<cftry>
			
				<cfquery name="insert_user_certif" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `user_certif`(
						`user_id`, 
						`certif_id`
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

		<!--- <cfquery name="updt_certif" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET certif_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_id#">
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery> --->
		
		<cfreturn "ok">

	</cffunction>





	<cffunction name="updt_interest" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="interest_id" type="any" required="no">
		<cfargument name="function_id" type="any" required="no">
		
		<cfif isDefined("interest_id")>
			<cfquery name="updt_interest" datasource="#SESSION.BDDSOURCE#">
				UPDATE user 
				SET interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#interest_id#">
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
			</cfquery>
		<cfelse>
			<cfquery name="updt_function" datasource="#SESSION.BDDSOURCE#">
				UPDATE user 
				SET interest_id = null
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
			</cfquery>
		</cfif>
		<cfif isDefined("function_id")>
				<cfquery name="updt_function" datasource="#SESSION.BDDSOURCE#">
					UPDATE user 
					SET function_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#function_id#">
					WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
				</cfquery>
		<cfelse>
			<cfquery name="updt_function" datasource="#SESSION.BDDSOURCE#">
				UPDATE user 
				SET function_id = null
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
			</cfquery>
		</cfif>
		<!--- <cfif interest_id neq "" OR function_id neq "">
		<cfquery name="updt_interest" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET 
			<cfif interest_id neq "" AND function_id neq "">
				interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#interest_id#">,
				function_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#function_id#">
			<cfelse>
				<cfif interest_id neq "">interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#interest_id#"></cfif>
				<cfif function_id neq "">function_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#function_id#"></cfif>
			</cfif>
			
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		</cfif> --->
		
		<cfreturn "ok">

	</cffunction>







	<cffunction name="updt_settings" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">

		<cfargument name="user_remind_1d" type="numeric" required="no">
		<cfargument name="user_remind_3h" type="numeric" required="no">
		<cfargument name="user_remind_15m" type="numeric" required="no">
		<cfargument name="user_remind_cancelled" type="numeric" required="no">
		<cfargument name="user_remind_missed" type="numeric" required="no">
		<cfargument name="user_remind_scheduled" type="numeric" required="no">
		<cfargument name="user_remind_sms_15m" type="numeric" required="no">
		<cfargument name="user_remind_sms_missed" type="numeric" required="no">
		<cfargument name="user_remind_sms_scheduled" type="numeric" required="no">
		<cfargument name="user_lang" type="any" required="no">
		<cfargument name="timezone_id" type="numeric" required="no">
		<cfargument name="user_blocker" type="numeric" required="no">
		<cfargument name="user_add_weight" type="numeric" required="no">
		
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
		<cfif isdefined("user_send_late_canceled_24h")>
		user_send_late_canceled_24h = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_send_late_canceled_24h#">,
		<cfelse>
		user_send_late_canceled_24h = 0,
		</cfif>
		<cfif isdefined("user_send_late_canceled_6h")>
		user_send_late_canceled_6h = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_send_late_canceled_6h#">,
		<cfelse>
		user_send_late_canceled_6h = 0,
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
		<cfif isdefined("user_add_weight")>
			user_add_weight = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_add_weight#">,
		<cfelse>
			user_add_weight = null,
		</cfif>
		user_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
		user_blocker = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_blocker#">	

		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<!--- timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#timezone_id#">, --->

		<cfreturn "ok">

	</cffunction>








	
	<cffunction name="updt_workinghour" access="remote" returntype="any">
	
		<cfargument name="day_mon_start_am" type="any" required="no">
		<cfargument name="day_mon_start_pm" type="any" required="no">
		<cfargument name="day_mon_end_am" type="any" required="no">
		<cfargument name="day_mon_end_pm" type="any" required="no">
		
		<cfargument name="day_tue_start_am" type="any" required="no">
		<cfargument name="day_tue_start_pm" type="any" required="no">
		<cfargument name="day_tue_end_am" type="any" required="no">
		<cfargument name="day_tue_end_pm" type="any" required="no">
		
		<cfargument name="day_wed_start_am" type="any" required="no">
		<cfargument name="day_wed_start_pm" type="any" required="no">
		<cfargument name="day_wed_end_am" type="any" required="no">
		<cfargument name="day_wed_end_pm" type="any" required="no">
		
		<cfargument name="day_thu_start_am" type="any" required="no">
		<cfargument name="day_thu_start_pm" type="any" required="no">
		<cfargument name="day_thu_end_am" type="any" required="no">
		<cfargument name="day_thu_end_pm" type="any" required="no">
		
		<cfargument name="day_fri_start_am" type="any" required="no">
		<cfargument name="day_fri_start_pm" type="any" required="no">
		<cfargument name="day_fri_end_am" type="any" required="no">
		<cfargument name="day_fri_end_pm" type="any" required="no">
		
		<cfargument name="day_sat_start_am" type="any" required="no">
		<cfargument name="day_sat_start_pm" type="any" required="no">
		<cfargument name="day_sat_end_am" type="any" required="no">
		<cfargument name="day_sat_end_pm" type="any" required="no">
		
		<cfargument name="day_sun_start_am" type="any" required="no">
		<cfargument name="day_sun_start_pm" type="any" required="no">
		<cfargument name="day_sun_end_am" type="any" required="no">
		<cfargument name="day_sun_end_pm" type="any" required="no">
		
		<cfquery name="get_workinghour" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM user_workinghour WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfif get_workinghour.recordcount eq "0">
		
			<cfquery name="ins_workinghour" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_workinghour 
			(
			user_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			)
			</cfquery>
			
		</cfif>
		
		<cfquery name="updt_workinghour" datasource="#SESSION.BDDSOURCE#">
		UPDATE user_workinghour
		SET
		<cfif isdefined("day_mon_start_am") OR isdefined("day_mon_start_pm")>day_mon = 1,<cfelse>day_mon = null,</cfif>
		<cfif isdefined("day_mon_start_am")>day_mon_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_start_am#:00">,<cfelse>day_mon_start_am = null,</cfif>
		<cfif isdefined("day_mon_end_am")>day_mon_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_end_am#:00">,<cfelse>day_mon_end_am = null,</cfif>
		<cfif isdefined("day_mon_start_pm")>day_mon_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_start_pm#:00">,<cfelse>day_mon_start_pm = null,</cfif>
		<cfif isdefined("day_mon_end_pm")>day_mon_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_end_pm#:00">,<cfelse>day_mon_end_pm = null,</cfif>
		<cfif isdefined("day_tue_start_am") OR isdefined("day_tue_start_pm")>day_tue = 1,<cfelse>day_tue = null,</cfif>
		<cfif isdefined("day_tue_start_am")>day_tue_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_start_am#:00">,<cfelse>day_tue_start_am = null,</cfif>
		<cfif isdefined("day_tue_end_am")>day_tue_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_end_am#:00">,<cfelse>day_tue_end_am = null,</cfif>
		<cfif isdefined("day_tue_start_pm")>day_tue_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_start_pm#:00">,<cfelse>day_tue_start_pm = null,</cfif>
		<cfif isdefined("day_tue_end_pm")>day_tue_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_end_pm#:00">,<cfelse>day_tue_end_pm = null,</cfif>
		<cfif isdefined("day_wed_start_am") OR isdefined("day_wed_start_pm")>day_wed = 1,<cfelse>day_wed = null,</cfif>
		<cfif isdefined("day_wed_start_am")>day_wed_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_start_am#:00">,<cfelse>day_wed_start_am = null,</cfif>
		<cfif isdefined("day_wed_end_am")>day_wed_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_end_am#:00">,<cfelse>day_wed_end_am = null,</cfif>
		<cfif isdefined("day_wed_start_pm")>day_wed_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_start_pm#:00">,<cfelse>day_wed_start_pm = null,</cfif>
		<cfif isdefined("day_wed_end_pm")>day_wed_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_end_pm#:00">,<cfelse>day_wed_end_pm = null,</cfif>
		<cfif isdefined("day_thu_start_am") OR isdefined("day_thu_start_pm")>day_thu = 1,<cfelse>day_thu = null,</cfif>
		<cfif isdefined("day_thu_start_am")>day_thu_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_start_am#:00">,<cfelse>day_thu_start_am = null,</cfif>
		<cfif isdefined("day_thu_end_am")>day_thu_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_end_am#:00">,<cfelse>day_thu_end_am = null,</cfif>
		<cfif isdefined("day_thu_start_pm")>day_thu_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_start_pm#:00">,<cfelse>day_thu_start_pm = null,</cfif>
		<cfif isdefined("day_thu_end_pm")>day_thu_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_end_pm#:00">,<cfelse>day_thu_end_pm = null,</cfif>
		<cfif isdefined("day_fri_start_am") OR isdefined("day_fri_start_pm")>day_fri = 1,<cfelse>day_fri = null,</cfif>
		<cfif isdefined("day_fri_start_am")>day_fri_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_start_am#:00">,<cfelse>day_fri_start_am = null,</cfif>
		<cfif isdefined("day_fri_end_am")>day_fri_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_end_am#:00">,<cfelse>day_fri_end_am = null,</cfif>
		<cfif isdefined("day_fri_start_pm")>day_fri_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_start_pm#:00">,<cfelse>day_fri_start_pm = null,</cfif>
		<cfif isdefined("day_fri_end_pm")>day_fri_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_end_pm#:00">,<cfelse>day_fri_end_pm = null,</cfif>
		<cfif isdefined("day_sat_start_am") OR isdefined("day_sat_start_pm")>day_sat = 1,<cfelse>day_sat = null,</cfif>
		<cfif isdefined("day_sat_start_am")>day_sat_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_start_am#:00">,<cfelse>day_sat_start_am = null,</cfif>
		<cfif isdefined("day_sat_end_am")>day_sat_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_end_am#:00">,<cfelse>day_sat_end_am = null,</cfif>
		<cfif isdefined("day_sat_start_pm")>day_sat_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_start_pm#:00">,<cfelse>day_sat_start_pm = null,</cfif>
		<cfif isdefined("day_sat_end_pm")>day_sat_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_end_pm#:00">,<cfelse>day_sat_end_pm = null,</cfif>
		<cfif isdefined("day_sun_start_am") OR isdefined("day_sun_start_pm")>day_sun = 1,<cfelse>day_sun = null,</cfif>
		<cfif isdefined("day_sun_start_am")>day_sun_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_start_am#:00">,<cfelse>day_sun_start_am = null,</cfif>
		<cfif isdefined("day_sun_end_am")>day_sun_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_end_am#:00">,<cfelse>day_sun_end_am = null,</cfif>
		<cfif isdefined("day_sun_start_pm")>day_sun_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_start_pm#:00">,<cfelse>day_sun_start_pm = null,</cfif>
		<cfif isdefined("day_sun_end_pm")>day_sun_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_end_pm#:00"><cfelse>day_sun_end_pm = null</cfif>
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		

	</cffunction>
	
	
	
	
	


	



	<cffunction name="del_experience" access="remote" returntype="any" httpMethod="POST">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="experience_id" type="numeric" required="yes">
		
		<cfquery name="del_experience" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_experience WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND experience_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#experience_id#">
		</cfquery>
		
		<cfreturn "ok">

	</cffunction>



	<cffunction name="ins_experience" access="remote" returntype="any" httpMethod="POST">
		<cfargument name="p_id" type="numeric" required="yes">
		
		<cfset experience_start = "#experience_yeardate_start#-#experience_monthdate_start#-01">
		<cfset experience_end = "#experience_yeardate_end#-#experience_monthdate_end#-01">	

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
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#experience_title#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#experience_localisation#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#experience_start#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#experience_end#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#experience_description#">,
		<cfif isdefined("experience_today")>1,<cfelse>null,</cfif>
		<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		)
		</cfquery>

		<cfquery name="get_experience" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM user_experience WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND experience_id = last_insert_id()
		</cfquery>
		
		<cfreturn get_experience>

	</cffunction>






















	<cffunction name="del_cursus" access="remote" returntype="any" httpMethod="POST">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="cursus_id" type="numeric" required="yes">
		
		<cfquery name="del_cursus" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_cursus WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND cursus_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cursus_id#">
		</cfquery>
		
		<cfreturn "ok">

	</cffunction>



	<cffunction name="ins_cursus" access="remote" returntype="any" httpMethod="POST">
		<cfargument name="p_id" type="numeric" required="yes">
		
		<cfset cursus_start = "#cursus_yeardate_start#-#cursus_monthdate_start#-01">
		<cfset cursus_end = "#cursus_yeardate_end#-#cursus_monthdate_end#-01">	

		<cfquery name="insert_cursus" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO user_cursus
		(
		cursus_title,
		cursus_localisation,
		cursus_start,
		cursus_end,
		cursus_description,
		cursus_today,
		user_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cursus_title#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cursus_localisation#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#cursus_start#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#cursus_end#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cursus_description#">,
		<cfif isdefined("cursus_today")>1,<cfelse>null,</cfif>
		<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		)
		</cfquery>

		<cfquery name="get_cursus" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM user_cursus WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND cursus_id = last_insert_id()
		</cfquery>
		
		<cfreturn get_cursus>

	</cffunction>
	
	
	
</cfprocessingdirective>

</cfcomponent>