<cfif isdefined("form.account_name") AND isdefined("form.user_email") AND isdefined("form.user_name") AND isdefined("form.user_firstname") AND isdefined("form.user_phone")>

<cfquery name="check_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_name FROM account WHERE account_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_name#">
</cfquery>

<cfquery name="check_group" datasource="#SESSION.BDDSOURCE#">
SELECT group_name FROM account_group WHERE group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_name#">
</cfquery>

<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
SELECT group_name FROM account_group WHERE group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_name#">
</cfquery>

<cfif check_user.recordcount neq "0" OR check_user.recordcount neq "0" check_user.recordcount neq "0">

	<cflocation addtoken="no" url="_subscribe_pro.cfm?e=1">		

<cfelse>

	<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO user
	(
	profile_id,
	user_status_id,
	user_type_id,
	user_firstname,
	user_name,
	user_email,
	user_password,
	user_pwd_chg,
	user_phone,
	user_create,
	user_lang
	)
	VALUES
	(
	7,
	4,
	3,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_password)#">,
	1,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
	now(),
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">
	)
	</cfquery>

	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(user_id) as id FROM user
	</cfquery>

	<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
	UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
	</cfquery>
	

	<cfmail from="W-LMS <service@wefitgroup.com>" to="service@wefitgroup.com,start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Creation de compte PRO" type="html" server="localhost">
	<!---<table>
		<tr>
			<td>Contact</td>
			<td>#user_firstname# #user_name#</td>
		</tr>
		<tr>
			<td>Email</td>
			<td>#user_email#</td>
		</tr>
		<tr>
			<td>T&eacute;l&eacute;phone</td>
			<td>#user_phone#</td>
		</tr>
	</table>--->
	</cfmail>
	
	<cflocation addtoken="no" url="#SESSION.BO_ROOT_URL#?user_name=#user_email#&upass=#hash(user_password)#">		
	

		
</cfif>

</cfif>