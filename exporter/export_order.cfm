<cfprocessingdirective pageEncoding="windows-1252">
<cfsetting requestTimeOut = "9000" />

<!---  --->

<cfparam name="year" default="">
<cfparam name="manager" default="">
<cfparam name="finance" default="">
<cfparam name="provider" default="">
<cfparam name="status_finance" default="">
<cfparam name="method" default="">
<cfparam name="from_tselect" default="">
<cfparam name="to_tselect" default="">


<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	a.account_name, ap.provider_name,
	o.*, DATE_FORMAT(o.order_date,'%Y') AS order_year,
	oc.context_id ,oc.context_alias, oc.context_name, oc.context_color,
	u.user_id as learner_id, u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
	oim.order_item_mode_name, 
	oip.method_id, oip.hour_qty, oip.certif_id, oip.destination_id, oip.elearning_id, llm.method_name_#SESSION.LANG_CODE# as method_name, llc.certif_name,
	ofi.status_finance_id, ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_tm_#SESSION.LANG_CODE# as status_finance_tm,
	otm.status_tm_name, otm.status_tm_css, 
	oi.order_item_invoice_id, oi.invoice_id, oi.f_account_id, oi.item_inv_nb_users, oi.item_inv_hour, oi.item_inv_unit_price, oi.item_inv_fee, oi.item_inv_total, oi.product_id, oi.product_name, oi.coupon_id, oi.order_item_mode_id,
	a2.account_name as opca_name, 
	u.user_firstname, u.user_name,
	u2.user_firstname as manager_firstname, u2.user_color as manager_color,
	f.formation_id, f.formation_code, f.formation_name_fr as formation_name
	
	FROM orders o

	INNER JOIN account a ON a.account_id = o.account_id
	LEFT JOIN account_provider ap ON ap.provider_id = o.provider_id
	
	LEFT JOIN orders_users ou ON ou.order_id = o.order_id 
	LEFT JOIN user u ON ou.user_id = u.user_id
	
	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
	LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
	
	LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
	LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
	LEFT JOIN order_item_package oip ON oip.order_id = o.order_id
	LEFT JOIN lms_lesson_method llm ON oip.method_id = llm.method_id
	LEFT JOIN lms_list_certification llc ON oip.certif_id = llc.certif_id


	LEFT JOIN order_context oc ON oc.context_id = o.context_id

	INNER JOIN account a2 ON o.account_id = a2.account_id
	LEFT JOIN account_group ag ON ag.group_id = a2.group_id
	LEFT JOIN user u2 ON u2.user_id = a.user_id
	LEFT JOIN lms_formation f ON f.formation_id = o.formation_id
	
	
	WHERE 1 = 1
	<!---<cfif s_id neq "">
		AND o.order_status_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#" list="true">)
	</cfif>--->

	<cfif status_finance neq "">
		AND ofi.status_finance_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#status_finance#" list="true">)
	</cfif>

	<cfif provider neq "">
		AND o.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#provider#" list="true">)
	</cfif>
	
	<cfif manager neq "">
		<cfloop list="#manager#" index="cor">
			AND u2.user_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">
		</cfloop>
	</cfif>
	
	<cfif year neq "">
	  <!--- AND SUBSTRING(o.order_ref, 1, 2) = <cfqueryparam cfsqltype="cf_sql_integer" value="#y_id#"> --->
	  AND DATE_FORMAT(o.order_date,'%Y') IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#year#" list="true">)
	</cfif>

	<cfif finance neq "">
		AND o.context_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#finance#" list="true">)
	</cfif>

	<cfif from_tselect neq "" AND from_tselect neq "null">
		AND o.order_end >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#from_tselect#">
	</cfif>

	<cfif to_tselect neq "" AND to_tselect neq "null">
		AND o.order_end <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#to_tselect#">
	</cfif>

	<cfif method neq "">
		AND oip.method_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#method#" list="true">)
	</cfif>
	
	ORDER BY o.order_id DESC

</cfquery>
<!--- <cfset get_orders = obj_order_get.oget_orders(s_id="4",y_id="22")> --->
<!--- <cfparam name="ts_id"> --->

<!--- <cfdump var="#get_orders#"> --->
<cfset name_tab_1 = "Details"> 
<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
<!--- <cfset SpreadsheetCreateSheet(sObj,"Details")> --->

<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>

<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfset listrows_gl = "id,Provider,Status,Contexte,Closed,Apprenant,Compte,Langue,Payement,Montant,Pack,Heures,Debut,Fin">
<cfset SpreadsheetAddRow(sObj,listrows_gl)>
	

<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize = "10">
<cfset FormatStruct.fgcolor = "pale_blue">
<cfset FormatStruct.alignment = "center">
<cfset FormatStruct.textwrap = "false"> 
<cfset FormatStruct.bottomborder ="medium"> 
<cfset FormatStruct.bold = "true"> 
<cfset FormatStruct.verticalalignment = "vertical_top"> 


<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 
<cfset spreadsheetSetColumnWidth(sObj,1,30)>

	<cfset count_row = 1>

	<cfoutput query="get_orders" group="order_id">
		<cfset count_row = count_row+1>

		<cfset _item_mode_name = "">
		<cfset _inv_total = "">

		<cfoutput group="order_item_invoice_id">
			<cfif _item_mode_name neq "" OR _inv_total neq "">
				<cfset _item_mode_name = _item_mode_name & chr(10)>
				<cfset _inv_total = _inv_total & chr(10)>
			</cfif>
			<cfset _item_mode_name = _item_mode_name & "#order_item_mode_name#">
			<cfset _inv_total = _inv_total & "#item_inv_total#">
		</cfoutput>

		<cfset _item_method_name = "">
		<cfset _item_method_hour = "">

		<cfoutput group="method_id">
			<cfif _item_method_name neq "" OR _item_method_hour neq "">
				<cfset _item_method_name = _item_method_name & chr(10)>
				<cfset _item_method_hour = _item_method_hour & chr(10)>
			</cfif>
			<cfset _item_method_name = _item_method_name & "#method_name#">
			<cfif certif_name neq "">
				<cfset _item_method_name = _item_method_name & " #certif_name#">
			</cfif>
			<cfset _item_method_hour = _item_method_hour & "#hour_qty#">
		</cfoutput>
		<!--- <cfset lesson_format = lesson_duration/60> --->
		<!--- english date format because excel can't filter other format --->
		<cfset SpreadsheetAddRow(sObj,"#order_ref#,#provider_name#,#context_alias#,#status_finance_name#,#lsdateformat(order_date,'mm/dd/yyyy', 'en')#,#user_firstname# #user_name#,#account_name#,#formation_code#,#_item_mode_name#,#_inv_total#,#_item_method_name#,#_item_method_hour#,#lsdateformat(order_start,'mm/dd/yyyy', 'en')#,#lsdateformat(order_end,'mm/dd/yyyy', 'en')#",count_row)>	
		<cfset SpreadSheetSetRowHeight(sObj,count_row,30)>
		<cfset spreadsheetSetColumnWidth(sObj,count_row,20)>
	</cfoutput>
	
<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
	
	
<cfheader name="Content-Disposition" value="inline; filename=WEFIT_test.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
