<cfif isdefined("lesson_id") AND isdefined("token") AND isdefined("ugo")>

	<!--- <cfquery name="get_lesson_ap" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT is_t_approved, is_l_approved FROM lms_lesson2 WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
	</cfquery> --->

	<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
		<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET
		<cfif get_lesson_ap.is_l_approved eq 1>
			status_id = 2,
		</cfif>
		is_t_approved = 1
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery>	 --->

		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2 SET status_id = "2" WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery>
		
	</cfif>


	<cfif SESSION.USER_PROFILE neq "TRAINER">


		<!--- <cfif signature_base64 neq "">
			<cfset myImage = ImageReadBase64(signature_base64)>

			<cfimage source="#myImage#" destination="./assets/signature/#lesson_id#.png" action="write" overwrite="yes" >
		</cfif> --->


		<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2_attendance SET 
			<cfif isdefined("signature_base64")>signature_base64=<cfqueryparam cfsqltype="cf_sql_varchar" value="#signature_base64#">,</cfif>
			lesson_signed = 1 
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			AND lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery>

		<!--- <cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET
		<cfif get_lesson_ap.is_t_approved eq 1>
			status_id = 2,
		</cfif>
		is_l_approved = 1,
		lesson_signed = 1 
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery> --->

		<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2 SET lesson_signed = 1 WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery>
		
	</cfif>

	<cflocation addtoken="no" url="#ugo#">

<cfelseif isdefined("lesson_id") AND isdefined("method_id") AND isdefined("ugo")>

	<cfif SESSION.USER_PROFILE eq "learner">

		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET status_id = "2" WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
		</cfquery>
		
		<cflocation addtoken="no" url="#ugo#">
		
	</cfif>

</cfif>
