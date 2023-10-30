<cfabort>


<cfspreadsheet 
	action="read" 
	src="/home/www/wnotedev1/www/manager/lms/automation/csv/InscriptionanglaisResponses.xlsx" 
	query="qData" 
	sheet="1"/>
	
<!--- <cfset qData = queryDeleteRow(qData,1)> --->
<cfset qData = queryDeleteRow(qData,1)>
<cfdump var="#qData#">

<cfoutput query="qData">

	<cfset user_name = qData['col_2'][currentRow]>
	<cfset user_firstname = qData['col_3'][currentRow]>
	<cfset user_email = qData['col_4'][currentRow]>

	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#"> LIMIT 1
	</cfquery>

	<cfif get_user.recordCount neq 0>

	<cfset u_id = get_user.user_id>


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
		'2023-09-12',
		'2024-07-12',
		1,

		1200,
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
		6,
		2,
		3,
		'2023-09-12',
		'2024-07-12',
		1,
		1,
		360,
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

	<cfquery name="ins_toeic" datasource="#SESSION.BDDSOURCE#" result="insert_toeic">
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
		certif_id,
		token_id,
		elearning_duration,

		techno_id,            
		tp_rank,
		tp_vip,
		
		creator_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		6,
		'2023-09-12',
		'2024-07-12',
		1,

		30,
		2,
		7,
		4,
		0,
		30,

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
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_toeic.generatedkey#">
		)
	</cfquery>

	</cfif>



</cfoutput>