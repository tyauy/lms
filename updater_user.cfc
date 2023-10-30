<cfcomponent>

	<cffunction name="updt_user_launching" access="remote" httpmethod="POST" output="false" returntype="any" returnformat="json">

		<cfargument name="user_jobtitle" type="any" required="yes">
		<cfargument name="keyword_id" type="numeric" required="yes">
		<cfargument name="user_phone" type="any" required="yes">
		<cfargument name="user_phone_code" type="any" required="yes">
		<cfargument name="user_phone_2" type="any" required="yes">
		<cfargument name="user_phone_2_code" type="any" required="yes">
		<cfargument name="user_email_2" type="any" required="yes">
		<cfargument name="user_needs_complement" type="any" required="yes">
		
		<cfset SESSION.USER_CHARTER = "1">
		
		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET
		user_jobtitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_jobtitle#">,
		business_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#keyword_id#">,
		<cfif user_phone neq "">
			user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
			user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
		</cfif>
		<cfif user_phone_2 neq "">
			user_phone_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2#">,
			user_phone_2_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2_code#">,
		</cfif>
		user_email_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_2#">,
		user_needs_complement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_complement#">,
		user_charter = 1
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		
		<cfreturn "ok">
	</cffunction>
	
</cfcomponent>