<cfif isdefined("form.user_email") 
AND isdefined("form.user_password") 
AND isdefined("form.user_name") 
AND isdefined("form.user_firstname") 
AND isdefined("form.user_phone")
>

<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
</cfquery>

<cfif check_user.recordcount eq "0">

<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user
(
profile_id,
account_id,
user_status_id,
user_type_id,
user_firstname,
user_name,
user_email,
user_password,
user_pwd_chg,
<cfif user_phone neq "">
	user_phone,
	user_phone_code,
</cfif>
user_create,
user_lang,
situation_id,
user_ctc_cpf,
user_ctc_formation
)
VALUES
(
7,
<cfif situation_id eq "3">239<cfelse>47</cfif>,
4,
3,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_password)#">,
1,
<cfif user_phone neq "">
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
</cfif>
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_cpf#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_search#">
)
</cfquery>

<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(user_id) as id FROM user
</cfquery>

<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
</cfquery>

<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user_profile_cor
(
user_id,
profile_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
7
)
</cfquery>

<cfquery name="get_situation" datasource="#SESSION.BDDSOURCE#">
SELECT situation_name_fr FROM user_situation WHERE situation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id#">
</cfquery>
		
<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tp
(
user_id,
tp_status_id,
formation_id,
method_id,
tp_date_start,
tp_date_end,
tp_rank,
elearning_id,
elearning_duration,
tp_duration
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
2,
2,
3,
now(),
#DateAdd("h",6,now())#,
1,
1,
0,
0
)
</cfquery>

<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Creation de compte GUEST B2C" type="html" server="localhost">
<table>
	<tr>
		<td>Contact</td>
		<td>#user_firstname# #user_name#</td>
	</tr>
	<tr>
		<td>Situation</td>
		<td>#get_situation.situation_name_fr#</td>
	</tr>
	<tr>
		<td>Email</td>
		<td>#user_email#</td>
	</tr>
	<tr>
		<td>T&eacute;l&eacute;phone</td>
		<td>#user_phone#</td>
	</tr>
	
	<tr>
		<td>Dispose de droits</td>
		<td><cfif isdefined("user_cpf")>#user_cpf#<cfelse>NC</cfif></td>
	</tr>
	
	<tr>
		<td>Recherche d'une formation</td>
		<td><cfif isdefined("user_search")>#user_search#<cfelse>NC</cfif></td>
	</tr>
	
	
</table>
</cfmail>
	
	<cflocation addtoken="no" url="#SESSION.BO_ROOT_URL#?user_name=#user_email#&upass=#hash(user_password)#">		
	
<cfelse>
	
	<cflocation addtoken="no" url="_subscribe.cfm?e=1">		
		
</cfif>

</cfif>