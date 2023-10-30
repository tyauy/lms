<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">

<!---<cfdump var="#FORM#">--->


	<cfif isdefined("t_id") AND isdefined("l_id") AND isdefined("u_id") AND isdefined("signature_base64_#l_id#")>

		<cfset myImage = ImageReadBase64(evaluate("signature_base64_#l_id#"))>

		<!--- ALL RIGHT !!! --->
		<!--- <cfimage source="#myImage#" destination="./assets/signature/#l_id#.png" action="write" overwrite="yes" > --->

		<!--- <cfquery name="insert_attendance" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_lesson2_attendance (
				lesson_id, 
				tp_id,
				user_id, 
				lesson_signed, 
				signature_base64
				) 
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
				1,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("signature_base64_#l_id#")#">
				)
			ON DUPLICATE KEY UPDATE 
			signature_base64=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("signature_base64_#l_id#")#">,
			lesson_signed=1
		</cfquery> --->

		<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2_attendance SET 
			signature_base64=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("signature_base64_#l_id#")#">,
			lesson_signed = 1 
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			AND lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>

		<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2 SET lesson_signed = 1 
			WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
			AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
		
	</cfif>
	
	<cflocation addtoken="no" url="learner_sign.cfm?t_id=#t_id#">
	
	
</cfif>