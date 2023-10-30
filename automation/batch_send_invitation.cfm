<cfabort>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_gender, user_name, user_firstname, user_email, user_lang
FROM user u
WHERE u.account_id = 107
AND u.user_id > 7064
ORDER BY user_id ASC
LIMIT 100
</cfquery>

<cfoutput query="get_user">
<cfset user_gender = user_gender>
<cfset user_firstname = user_firstname>
<cfset user_lastname = user_name>
<cfset user_email = user_email>
<!--- // !! --->
<cfset user_pwd = ""> 
<!--- // !! --->
<cfset profile_id = profile_id>

<cfset get_tps = obj_tp_get.oget_tps(u_id="#user_id#",st_id="2")>

<cfset send_reset = "1">
<cfset lang = "fr">
<cfset subject = "WEFIT | Votre espace eLearning">

<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
	
	<cfinclude template="../email/email_new_formation.cfm">
</cfmail>
</cfoutput>