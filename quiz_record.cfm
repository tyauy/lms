<cfdump var="#form#">

<cfif isdefined("form.eval_email") AND isdefined("form.eval_mdp") AND isdefined("form.eval_name") AND isdefined("form.eval_firstname") AND isdefined("form.eval_tel")>

<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_email#">
</cfquery>

<cfif check_user.recordcount eq "0">
<!---<cfquery name="ins_user_tool" datasource="bddtool">
INSERT INTO user_tool
(
master_id,
abo_create,
abo_end,
user_email,
user_md5
)
VALUES
(
1,
now(),
#dateadd('y',+2,now())#,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_email#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(eval_mdp)#">
)
</cfquery>

<cfquery name="get_max" datasource="bddtool">
SELECT max(global_user_id) as maxid FROM user_tool
</cfquery>--->

<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user
(
profile_id,
user_firstname,
user_name,
user_email,
user_password,
user_phone,
user_create,
user_lang
)
VALUES
(
7,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_firstname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_email#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(eval_mdp)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#eval_tel#">,
now(),
'fr'
)

</cfquery>

	<cflocation addtoken="no" url="connect_gateway.cfm?user_email=#eval_email#&user_password=#eval_mdp#">		
	
<cfelse>
<cflocation addtoken="no" url="connect.cfm?e=3">		
		
</cfif>

</cfif>