<!--- <cffile action="read" file="/home/www/wnotedev1/www/manager/lms/automation/csv/Anmeldungwefit2023_Kopie.xlsx" variable="vartemp" charset="utf-8"> --->

<!--- <cfabort> --->
<cfspreadsheet 
	action="read" 
	src="/home/www/wnotedev1/www/manager/lms/automation/csv/Anmeldeliste_WEFIT_2023_09.xlsx" 
	query="qData" 
	sheet="1"/>
	
<!--- <cfset qData = queryDeleteRow(qData,1)> --->
<cfset qData = queryDeleteRow(qData,1)>

<!--- <cfdump var="#qData#"> --->

<cfoutput query="qData">

	<cfset user_name = qData['col_4'][currentRow]>
	<cfset user_firstname = qData['col_3'][currentRow]>
	<cfset user_email = qData['col_5'][currentRow]>
	<cfset user_phone = qData['col_6'][currentRow]>

	<cfif user_email neq "">

	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">
	</cfquery>


	<cfif get_user.recordcount eq "0">
		<cfdump var="#user_email#">
		<cfset temp = RandRange(100000, 999999)>

		<cfquery name="i_user" datasource="#SESSION.BDDSOURCE#" result="ins_user">
			INSERT INTO user
			(
			account_id,
			profile_id,
			timezone_id,
			user_firstname,
			user_name,
			<cfif user_phone neq "">user_phone,</cfif>
			user_email,
			user_password,
			user_create,
			user_lang,
			user_status_id,
			user_type_id
			)
			VALUES
			(
			704,
			3,
			6,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name)#">,
			<cfif user_phone neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,</cfif>
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
			'de',			
			2,
			3
			)
		</cfquery>

		<cfset u_id = ins_user.generatedkey>

		<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_profile_cor
			(
			user_id,
			profile_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#ins_user.generatedkey#">,
			3
			)
		</cfquery>

	<cfelse>
		<cfset u_id = get_user.user_id>

	</cfif>

	<cfdump var="#u_id#">

	<cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp">
		INSERT INTO lms_tp
		(
		user_id,
		tp_status_id,
		tp_date_start,
		tp_date_end,
		order_id,

		tp_duration,
		formation_id,
		method_id,
		
		techno_id,            
		tp_rank,
		tp_vip,
		
		creator_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		6,
		'2023-09-01',
		'2024-03-01',
		1,

		600,
		2,
		1,

		3,
		1,
		0,
		
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		)
	</cfquery>


	<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpuser
		(
			user_id,
			tp_id
		)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
		)
	</cfquery>


	<cfquery name="ins_el_tp" datasource="lms-1" result="new_tp">
		INSERT INTO lms_tp
		(
		user_id,
		order_id,
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
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		1,
		2,
		2,
		3,
		now(),
		#DateAdd("m",6,now())#,
		1,
		1,
		180,
		0
		)
	</cfquery>

	<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpuser
		(
			user_id,
			tp_id
		)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
		)
	</cfquery>

	</cfif>

</cfoutput>