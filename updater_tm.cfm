<cfif isdefined("widget_id")>
<cfquery name="updt_tm" datasource="#SESSION.BDDSOURCE#">
	UPDATE user
	SET user_widget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#widget_id#">
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>
<cfset SESSION.USER_WIDGET = widget_id>
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
</cfif>

	