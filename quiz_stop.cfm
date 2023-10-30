<cfif isdefined("current_countdown") AND isdefined("quiz_user_id")>

	<cfquery name="updt_time" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_quiz_user SET current_countdown = <cfqueryparam cfsqltype="cf_sql_integer" value="#current_countdown#">
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>

	<cflocation addtoken="no" url="index.cfm?stop=1">

</cfif>


