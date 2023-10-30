<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/automation/csv/20220622_CNAM.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = ",">
<cfset a_id = "589">
<cfset counter = 0>
<cfset certif_id = 23>

<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfset counter ++>

<cfoutput>

<cfset user_name = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>user_name = #user_name#<br>
<cfset user_firstname = #replacenocase(listgetat(encours,5,'#specialchar#'),'"','','ALL')#>user_firstname = #user_firstname#<br>
<cfset user_email = #replacenocase(listgetat(encours,7,'#specialchar#'),'"','','ALL')#>user_email = #lcase(trim(user_email))#<br>
<cfset token_code = #replacenocase(listgetat(encours,9,'#specialchar#'),'"','','ALL')#>token_code = #trim(token_code)#<br>


<cfset temp = RandRange(100000, 999999)>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#"> AND profile_id <> 8
</cfquery>

<cfif get_user.recordcount neq "0">
exists <br>
	<cfset u_go = get_user.user_id>
	<cfset user_pwd = "Vous seul le connaissez, car vous avez déjà un compte sur WEFIT ;)">
<cfelse>
existe pas <br>
<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user
(
account_id,
profile_id,
timezone_id,
user_firstname,
user_name,
user_email,
user_password,
user_create,
user_lang,
user_status_id,
user_type_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">,
9,
6,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
'fr',			
4,
3
)
</cfquery>

<cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(user_id) as id FROM user
</cfquery>

<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user_profile_cor
(
user_id,
profile_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_user.id#">,
9
)
</cfquery>

<cfset u_go = get_max_user.id>
<cfset user_pwd = temp>

</cfif>

<cfquery name="ins_token" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_list_token 
(
	tp_id,
	certif_id,
	user_id,
	token_send,
	token_creation,
	token_code
)
VALUES
(
	0,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#u_go#">,
	now(),
	now(),
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#token_code#">	
)
</cfquery>

<cfquery name="get_max_token" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(token_id) as id FROM lms_list_token
</cfquery>

<cfquery name="insert_tp" datasource="#SESSION.BDDSOURCE#">		
	INSERT INTO lms_tp
	(
	user_id,
	tp_status_id,
	tp_date_start,
	tp_date_end,
	tp_duration,
	order_id,
	formation_id,
	method_id,
	elearning_id,
	elearning_duration
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#u_go#">,
	2,
	now(),
	#DateAdd("m",2,now())#,
	'2022-03-18 00:00:00',
	1,
	1,
	2,
	3,
	1,
	1
	)
</cfquery>

<!--- ! TO DO ---->
<!--- <cfquery name="insert_cor" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpuser 
	(tp_id, user_id)
	VALUES
	<cfoutput query="get_tp">
	<cfif get_tp.user_id neq "">
	(#get_tp.tp_id#, #get_tp.user_id#)<cfif get_tp.recordcount neq get_tp.currentRow>,</cfif>
	</cfif>
	</cfoutput>
	</cfquery> --->



<cfset subject = "WEFIT | Passage de votre certification">

<cfset user_create_el = "1">
<cfset user_email = lcase(trim(user_email))>


<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_list_token t
INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_token.id#">
</cfquery>

<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
	<cfset lang = "fr">
	<cfset display_warning = "1">
	<cfinclude template="../email/email_token.cfm">
</cfmail>


</cfoutput>
<br><br>
</cfloop>

<cfoutput>TOTAL : #counter#</cfoutput>