<!---- JUST CLEAN SESSION AND BOOT USER ---->
<cfif not isdefined("incl")>
	<cfset tmp_url = SESSION.BO_ROOT_URL>
	<cfif isdefined("SESSION.BO_ROOT")>
		<cfset temp = structdelete(SESSION, "BO_ROOT")>
	</cfif>
	<cfif isdefined("SESSION.BO_ROOT_URL")>
		<cfset temp = structdelete(SESSION, "BO_ROOT_URL")>
	</cfif>
	<cfif isdefined("SESSION.DAYWEEK_EN")>
		<cfset temp = structdelete(SESSION, "DAYWEEK_EN")>
	</cfif>
	<cfif isdefined("SESSION.DAYWEEK_FR")>
		<cfset temp = structdelete(SESSION, "DAYWEEK_FR")>
	</cfif>
	<cfif isdefined("SESSION.GLOBAL_USER_ID")>
		<cfset temp = structdelete(SESSION, "GLOBAL_USER_ID")>
	</cfif>
	<cfif isdefined("SESSION.LANG")>
		<cfset temp = structdelete(SESSION, "LANG")>
	</cfif>
	<cfif isdefined("SESSION.LANG_CODE")>
		<cfset temp = structdelete(SESSION, "LANG_CODE")>
	</cfif>
	<cfif isdefined("SESSION.LIST_HOURS")>
		<cfset temp = structdelete(SESSION, "LIST_HOURS")>
	</cfif>
	<cfif isdefined("SESSION.LIST_LANGUAGES")>
		<cfset temp = structdelete(SESSION, "LIST_LANGUAGES")>
	</cfif>
	<cfif isdefined("SESSION.LIST_LANGUAGES_SHORT")>
		<cfset temp = structdelete(SESSION, "LIST_LANGUAGES_SHORT")>
	</cfif>
	<cfif isdefined("SESSION.MASTER_ID")>
		<cfset temp = structdelete(SESSION, "MASTER_ID")>
	</cfif>
	<cfif isdefined("SESSION.MENU")>
		<cfset temp = structdelete(SESSION, "MENU")>
	</cfif>
	<cfif isdefined("SESSION.USER_CSS")>
		<cfset temp = structdelete(SESSION, "USER_CSS")>
	</cfif>
	<cfif isdefined("SESSION.USER_ID")>
		<cfset temp = structdelete(SESSION, "USER_ID")>
	</cfif>
	<cfif isdefined("SESSION.USER_NAME")>
		<cfset temp = structdelete(SESSION, "USER_NAME")>
	</cfif>
	<cfif isdefined("SESSION.USER_PROFILE")>
		<cfset temp = structdelete(SESSION, "USER_PROFILE")>
	</cfif>
	<cfif isdefined("SESSION.VIEW_SELECT")>
		<cfset temp = structdelete(SESSION, "VIEW_SELECT")>
	</cfif>
	<cfif isdefined("SESSION.VIEW_WID")>
		<cfset temp = structdelete(SESSION, "VIEW_WID")>
	</cfif>
	<cfif isdefined("SESSION.STEP")>
		<cfset temp = structdelete(SESSION, "STEP")>
	</cfif>
	<cfif isdefined("SESSION.ALERT_WELCOME")>
		<cfset temp = structdelete(SESSION, "ALERT_WELCOME")>
	</cfif>
	<cfset structclear(SESSION)>
	<cflocation addtoken="no" url="#tmp_url#">
<cfelse>
<!---- JUST CLEAN BEFORE RECONNEXION ---->
	<cfif isdefined("SESSION.MASTER_ID")>
		<cfset temp = structdelete(SESSION, "MASTER_ID")>
	</cfif>
	<cfif isdefined("SESSION.CONNECT_ID")>
		<cfset temp = structdelete(SESSION, "CONNECT_ID")>
	</cfif>
	<cfif isdefined("SESSION.USER_ID")>
		<cfset temp = structdelete(SESSION, "USER_ID")>
	</cfif>
	<cfif isdefined("SESSION.GLOBAL_USER_ID")>
		<cfset temp = structdelete(SESSION, "GLOBAL_USER_ID")>
	</cfif>
	<cfif isdefined("SESSION.ALERT_WELCOME")>
		<cfset temp = structdelete(SESSION, "ALERT_WELCOME")>
	</cfif>
</cfif>