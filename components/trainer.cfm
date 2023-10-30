<cfif isdefined("SESSION.USER_ID") AND isdefined("form")>

<cfquery name="updt_status" datasource="#SESSION.BDDSOURCE#">
	UPDATE user SET user_status_id = 2
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM user
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>


<cfset SESSION.USER_STATUS_ID = 2>

<cfmail from="W-LMS <service@wefitgroup.com>" to="rremacle@wefitgroup.com" subject="WEFIT | Completed trainer profil #get_user.user_firstname# #get_user.user_name#" type="html" server="localhost">
<table>
	<tr>
		<td>Trainer</td>
		<td>#get_user.user_firstname# #get_user.user_name#</td>
	</tr>
	<tr>
		<td>Email</td>
		<td>#get_user.user_email#</td>
	</tr>
</table>
</cfmail>

<cflocation addtoken="no" url="../common_trainer_account.cfm?view=confirm">


</cfif>