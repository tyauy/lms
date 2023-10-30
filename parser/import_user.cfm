C'est fini ce temps-là....<cfabort>
<cfoutput>

	<cfset u_gender = URLDecode(u_gender)>
	<cfset u_fname = URLDecode(u_fname)>
	<cfset u_name = URLDecode(u_name)>
	<cfset u_email = URLDecode(u_email)>
	<cfset u_type = URLDecode(u_type)>
	<cfset u_email2 = URLDecode(u_email2)>
	<cfset u_tel1 = URLDecode(u_tel1)>
	<cfset u_tel2 = URLDecode(u_tel2)>
	<cfset u_ind_tel1 = replacenocase(URLDecode(u_ind_tel1)," ","","ALL")>
	<cfset u_ind_tel2 = replacenocase(URLDecode(u_ind_tel2)," ","","ALL")>
	<cfset u_jobtitle = URLDecode(u_jobtitle)>
	<cfset a_id = URLDecode(a_id)>
	<cfset u_lang = URLDecode(u_lang)>
	
	<cfif u_ind_tel1 eq "FR33">
		<cfset u_ind_tel1 = "33">
	<cfelseif u_ind_tel1 eq "UK44">
		<cfset u_ind_tel1 = "44">
	<cfelseif u_ind_tel1 eq "DE49">
		<cfset u_ind_tel1 = "49">
	<cfelseif u_ind_tel1 eq "ES34">
		<cfset u_ind_tel1 = "34">
	<cfelseif u_ind_tel1 eq "IT39">
		<cfset u_ind_tel1 = "39">
	<cfelse>
		<cfset u_ind_tel1 = "">
	</cfif>

	<cfif u_ind_tel2 eq "FR33">
		<cfset u_ind_tel2 = "33">
	<cfelseif u_ind_tel2 eq "UK44">
		<cfset u_ind_tel2 = "44">
	<cfelseif u_ind_tel2 eq "DE49">
		<cfset u_ind_tel2 = "49">
	<cfelseif u_ind_tel2 eq "ES34">
		<cfset u_ind_tel2 = "34">
	<cfelseif u_ind_tel2 eq "IT39">
		<cfset u_ind_tel2 = "39">
	<cfelse>
		<cfset u_ind_tel2 = "">
	</cfif>


<cfif u_email eq "">
EMAIL MANQUANT....
<cfelse>

<cfif isdefined("c_id")>

	<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, a.account_name FROM user u
	LEFT JOIN account a ON a.account_id = u.account_id
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_id#"> AND u.user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_email#">
	</cfquery>
	
	<cfif check_user.recordcount eq "0">
	
	L'utilisateur #u_fname# #u_name# (#u_email#) n'existe pas en base de donn&eacute;e
	
	<cfelse>
	
	<cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#">		
		UPDATE user SET
		user_gender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_gender#">,
		user_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_fname#">,
		user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(u_name)#">,
		user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(lcase(u_email))#">,
		user_email_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_email2#">,

		<cfif user_phone neq "">
			user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_tel1#">,
			<cfif u_ind_tel1 neq "">
			user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_ind_tel1#">,
			<cfelse>
			user_phone_code = null,
			</cfif>
		</cfif>

		<cfif user_phone_2 neq "">
			user_phone_2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_tel2#">,
			<cfif u_ind_tel2 neq "">
			user_phone_2_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_ind_tel2#">,
			<cfelse>
			user_phone_2_code = null,
			</cfif>
		</cfif>


		user_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(u_lang)#">,
		account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_id#">
	</cfquery>
	
	L'utilisateur #u_fname# #u_name# (#u_email#) a &eacute;t&eacute; updat&eacute;
		
	</cfif>
	
<cfelse>

	<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, a.account_name FROM user u
	LEFT JOIN account a ON a.account_id = u.account_id
	WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_email#">
	</cfquery>

	<cfif check_user.recordcount eq "0">

		u_gender =#u_gender#<br>
		u_lang =#u_lang#<br>
		u_fname =#u_fname#<br>
		u_name =#u_name#<br>
		u_email =#u_email#<br>
		u_type =#u_type#<br>
		u_email2 =#u_email2#<br>
		u_tel1 =#u_tel1#<br>
		u_tel2 =#u_tel2#<br>
		u_jobtitle =#u_jobtitle#<br>
		a_id =#a_id#<br>

		<cfset temp = RandRange(100000, 999999)>
		<cfif u_type eq "TM">
			<cfset u_type = "4">
		<cfelseif u_type eq "VIP">
			<cfset u_type = "5">
		<cfelseif u_type eq "LEARNER">
			<cfset u_type = "3">
		<!--- <cfelseif u_type eq "TEST">
			<cfset u_type = "7"> --->
		<cfelse>
			<cfset u_type = "3">
		</cfif>
		<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_name FROM account a WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
		</cfquery>
		
		<cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#">		
		INSERT INTO user
		(
		account_id,
		profile_id,
		timezone_id,
		user_status_id,
		user_type_id,
		user_gender,
		user_firstname,
		user_name,
		user_email,
		user_email_2,
		user_password,
		user_pwd_chg,

		<cfif user_phone neq "">
			user_phone,
			user_phone_code,
		</cfif>
		<cfif user_phone_2 neq "">
			user_phone_2,
			user_phone_2_code,
		</cfif>

		user_jobtitle,
		user_create,
		user_lang,
		user_remind_3h,
		user_remind_1d,
		user_remind_scheduled,
		user_remind_cancelled,
		user_remind_missed
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="3">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="6">,
		<cfif isdefined("create_el")>2,<cfelse><cfqueryparam cfsqltype="cf_sql_integer" value="1">,</cfif>		
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_type#">,	
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_gender#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_fname#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(u_name)#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(lcase(u_email))#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_email2#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
		0,

		<cfif u_tel1 neq "">
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_tel1#">,
			<cfif u_ind_tel1 neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#u_ind_tel1#">,<cfelse>null,</cfif>
		</cfif>
		<cfif u_tel2 neq "">
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_tel2#">,
			<cfif u_ind_tel2 neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#u_ind_tel2#">,<cfelse>null,</cfif>
		</cfif>

		<cfqueryparam cfsqltype="cf_sql_varchar" value="#u_jobtitle#">,
		now(),
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(u_lang)#">,
		1,
		1,
		1,
		1,
		1
		)
		</cfquery>


		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT max(user_id) as id FROM user
		</cfquery>

		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
		</cfquery>
		
		L'utilisateur #u_fname# #u_name# a &eacute;t&eacute; cr&eacute;&eacute; et est rattach&eacute; au compte #get_account.account_name# avec l'ID #get_max.id#
		
		<cfif isdefined("create_el")>
		
		<cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#">		
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
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
		now(),
		#DateAdd("m",1,now())#,
		1,
		1,
		2,
		3,
		1,
		1
		)
		</cfquery>
		
		<br><br>Un TP EL essential a &eacute;t&eacute; &eacute;galement cr&eacute;&eacute;
		
		</cfif>
		
	<cfelse>

		L'utilisateur #u_fname# #u_name# existe d&eacute;ja (avec l'email : #u_email#) et est rattach&eacute; au compte #check_user.account_name# avec l'ID #check_user.user_id#

	</cfif>




	

</cfif>
	
	</cfif>
	
</cfoutput>


<!---
<cfset toparse = URLDecode(CGI.QUERY_STRING)>
<cfoutput>

<cfset order_start = dateformat(order_start,'yyyy-mm-dd')>
<cfset order_end = dateformat(order_end,'yyyy-mm-dd')>
order_start = #order_start# <br>
order_end = #order_end# <br><br>

<cfloop list="#toparse#" delimiters="&" index="cor">


#cor#<br>
</cfloop>
</cfoutput>
--->