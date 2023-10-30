<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/automation/csv/temp_myriam.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = ",">
<cfset a_id = "725">
<cfset counter = 0>

<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfset counter ++>

<cfoutput>

<cfset user_name = #ucase(replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL'))#>user_name = #user_name#<br>
<cfset user_firstname = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>user_firstname = #user_firstname#<br>
<cfset user_email = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>user_email = #lcase(trim(user_email))#<br>
<cfset user_phone = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>user_phone = #lcase(trim(user_phone))#<br>


<cfset temp = RandRange(100000, 999999)>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#"> AND profile_id <> 8
</cfquery>

<cfif get_user.recordcount neq "0">
exists <br>
	
<cfset u_go = get_user.user_id>

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
user_phone,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_phone))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
'fr',			
2,
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


</cfif>


</cfoutput>
<br><br>
</cfloop>

<cfoutput>TOTAL : #counter#</cfoutput>