<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">

<cfif isdefined("SESSION.USER_EMAIL") AND isdefined("SESSION.USER_ID")>
	<cfset user_email = SESSION.USER_EMAIL>
</cfif>

<cfif isdefined("user_email") AND isdefined("reinit")>

	<cfquery name="get_email" datasource="#SESSION.BDDSOURCE#">
	SELECT user_id, user_lang FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
	</cfquery>

	<cfif get_email.recordcount eq "0">
		<cflocation addtoken="no" url="connect.cfm?error=4">
	<cfelse>

		<cfset temp = RandRange(100000, 999999)>
		<cfset temp = hash(temp)>
		
		<cfquery name="insert_link" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO user_temp_mdp
		(
		user_id,
		mdp_temp,
		mdp_date
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_email.user_id#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#temp#">,
		now()
		)
		</cfquery>
		
		<cfif get_email.user_lang eq "fr">
			<cfset subject = "WEFIT | Oubli de mot de passe">
		<cfelseif get_email.user_lang eq "en">
			<cfset subject = "WEFIT | Forgotten password">
		<cfelseif get_email.user_lang eq "de">
			<cfset subject = "WEFIT: Passwort vergessen">
		<cfelseif get_email.user_lang eq "es">
			<cfset subject = "WEFIT | Forgotten password">
		<cfelseif get_email.user_lang eq "it">
			<cfset subject = "WEFIT | Forgotten password">
		</cfif>
		
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" subject="#subject#" type="html" server="localhost">
			<cfset lang = get_email.user_lang>
			<cfinclude template="./email/email_reset_mdp.cfm">		
		</cfmail>
		
		<cfif isdefined("SESSION.USER_EMAIL") AND isdefined("SESSION.USER_ID")>
			<cflocation addtoken="no" url="connect_out.cfm">
		<cfelse>
			<cflocation addtoken="no" url="connect.cfm?k=1">
		</cfif>

	</cfif>

</cfif>



<cfif isdefined("user_pwd") AND isdefined("user_pwd2") AND isdefined("valid_maj") AND isdefined("u_id") AND isdefined("phsh")>

	<cfset tmp = hash(user_pwd)>

	<cfquery name="get_email" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id FROM user u
	INNER JOIN user_temp_mdp m ON m.user_id = u.user_id
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	AND m.mdp_temp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#phsh#">
	AND m.mdp_date > #dateadd('d','-1',now())#
	</cfquery>

	<cfif get_email.recordcount neq "0">


	<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
	UPDATE user SET
	user_password = '#tmp#'
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cflocation addtoken="no" url="connect.cfm?k=2">

	</cfif>
	
	
</cfif>


</cfprocessingdirective>