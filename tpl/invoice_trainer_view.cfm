<!--- <cfsetting requestTimeOut = "9000" /> --->

<cfparam name="export_all" default="0">
<cfparam name="pdf_id" default="0">
<cfparam name="dwl" default="0">

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfparam name="p_id" default="#listGetAt(SESSION.TRAINER_EXPORT_LIST, 1)#">

<cfparam name="start_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="end_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="use_date" default="0">

<cfif use_date eq 0>
	<cfset periode_name = "#msel##ysel#">
<cfelse>
	<cfset periode_name = "#start_date#">
</cfif>

<cfset dir_go = "/home/www/wnotedev1/admin/trainer_inv/#periode_name#">

<cfif export_all eq 1>

<cfset fileName = periode_name />

	<cfdirectory action = "list" directory = "#dir_go#" name = "getAllFiles"  type="file" />
	<cfzip action="zip" file="#dir_go#/#fileName#.zip" overwrite="yes" >
		<cfloop query="getAllFiles">    
			<cfzipparam  source="#dir_go#/#getAllFiles.name#">
		</cfloop>
	</cfzip>

	<cfheader name = "Content-disposition" value = 'attachment; filename="#fileName#.zip"'>
	<cfcontent deleteFile="yes" file="#dir_go#/#fileName#.zip" type="application/x-zip-compressed" >

<cfelse>
	
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_firstname, u.user_name, u.user_temp_alias, u.user_alias, u.user_email, ii.user_invoice_info_path, ii.user_invoice_info_selector
		FROM user u
		LEFT JOIN user_invoice_info ii ON u.user_id = ii.user_invoice_info_user AND user_invoice_info_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pdf_id#">
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		LIMIT 1
	</cfquery>
	

	<cfif pdf_id neq 0>
		<cfset periode_name = "#get_user.user_invoice_info_selector#">
		<cfset pdf_path = "#get_user.user_invoice_info_path#">
	<cfelse>
		<cfset pdf_path = "#dir_go#/pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf">
	</cfif>

	<cfset pdf_name = "pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf">

	<cftry>

		<cfif dwl eq 1>
			<cfheader name="Content-Disposition" value='attachment; filename="#pdf_name#"'>
			<cfcontent type="application/pdf" deleteFile="no" file="#pdf_path#">
		<cfelse>
			<cfcontent type="application/pdf" file="#pdf_path#">
		</cfif>


	<cfcatch type="any">
		No PDF for <cfoutput>#get_user.user_firstname# on the period #periode_name#</cfoutput>
	</cfcatch>
	</cftry>

	

</cfif>

