<cfif isdefined("lg")>
	<cfif lg eq "de">
		<cfset SESSION.LANG = "3">
		<cfset SESSION.LANG_CODE = "de">
		<cfset lang_doc = "de">
	<cfelseif lg eq "en">
		<cfset SESSION.LANG = "2">
		<cfset SESSION.LANG_CODE = "en">
		<cfset lang_doc = "en">
	<cfelseif lg eq "fr">
		<cfset SESSION.LANG = "1">
		<cfset SESSION.LANG_CODE = "fr">
		<cfset lang_doc = "fr">
	<cfelseif lg eq "es">
		<cfset SESSION.LANG = "4">
		<cfset SESSION.LANG_CODE = "es">
		<cfset lang_doc = "es">
	<cfelseif lg eq "it">
		<cfset SESSION.LANG = "5">
		<cfset SESSION.LANG_CODE = "it">
		<cfset lang_doc = "it">
	</cfif>
<cfelse>
	<cfif find("de",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "3">
		<cfset SESSION.LANG_CODE = "de">
		<cfset lang_doc = "de">
	<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "1">
		<cfset SESSION.LANG_CODE = "fr">
		<cfset lang_doc = "fr">
	<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "4">
		<cfset SESSION.LANG_CODE = "es">
		<cfset lang_doc = "es">
	<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "5">
		<cfset SESSION.LANG_CODE = "it">
		<cfset lang_doc = "it">	
	<cfelse>
		<cfset SESSION.LANG = "2">
		<cfset SESSION.LANG_CODE = "en">
		<cfset lang_doc = "en">
	</cfif>	
</cfif>