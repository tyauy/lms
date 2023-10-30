<cfif not listfind(secure,SESSION.USER_PROFILE_ID)>
	<cflocation addtoken="no" url="index.cfm?pconnect=1">
</cfif>