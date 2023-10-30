<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/pack_formation_cpf.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = ",">

<!--- <cfset vartemp = replacenocase(vartemp,"#specialchar##specialchar#","#specialchar# #specialchar#","ALL")> --->

<cfset counter = 0>


<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfset counter ++>



<cfoutput>
<cfset user_name = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>user_name = #user_name#<br>
<cfset user_firstname = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>user_firstname = #user_firstname#<br>
<cfset user_email = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>user_email = #user_email#<br>
<cfset token_code = #replacenocase(listgetat(encours,8,'#specialchar#'),'"','','ALL')#>token_code = #token_code#<br>


<cfset temp = RandRange(100000, 999999)>


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
590,
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
);
</cfquery>

<cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(user_id) as id FROM user
</cfquery>

-- TOKEN ATTRIBUTION --
<cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_list_token SET 
user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_user.id#">,
token_send = now()			
WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_code#">
</cfquery>



</cfoutput>
<br><br>
</cfloop>

<cfoutput>TOTAL : #counter#</cfoutput>