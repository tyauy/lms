<!--- <cfparam name="ts_id"> --->

<cfprocessingdirective pageEncoding="windows-1252">

<cfif isdefined("ts_id") OR isdefined("a_id")>

	<cfquery name="get_token_attributed" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		lt.token_id, lt.user_id, lt.certif_id, lt.token_creation, lt.token_send, lt.token_code, lt.token_login, lt.token_end, lt.token_status_id, lt.token_use, lt.token_level, lt.token_start,
		ltss.token_session_name,
		lts.token_status_name, lts.token_status_css,
		u.user_id as id, u.user_firstname, u.user_name, u.user_email
		FROM user u
		LEFT JOIN lms_list_token lt ON lt.user_id = u.user_id
		LEFT JOIN lms_list_token_session ltss ON ltss.token_session_id = lt.token_session_id
		LEFT JOIN lms_list_token_status lts ON lts.token_status_id = lt.token_status_id
		<cfif isdefined("ts_id")>
			WHERE lt.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
		</cfif>
		<cfif isdefined("a_id")>
			WHERE ltss.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>
		ORDER BY lt.token_id ASC
	</cfquery>

	<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
		SELECT token_status_id, token_status_name, token_status_css 
		FROM lms_list_token_status 
		ORDER BY lms_list_token_status.token_status_id ASC
	</cfquery>

<cfset name_tab_1 = "Details"> 
<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
<!--- <cfset SpreadsheetCreateSheet(sObj,"Details")> --->

<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>

<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfset listrows_gl = "Session,Nom,Pr#chr(233)#nom,Statut,Code entry,Envoy#chr(233)#,Passage,Niveau">
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

	<cfoutput query="get_token_attributed">
		<cfset count_row = count_row+1>
		<!--- <cfset lesson_format = lesson_duration/60> --->
		<cfset SpreadsheetAddRow(sObj,"#token_session_name#, #ucase(user_name)#, #user_firstname#, #token_status_name#, #token_code#, #dateformat(token_send,'dd/mm/yyyy')#, #dateformat(token_use,'dd/mm/yyyy')#, #token_level#",count_row)>	
		<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
		<cfset spreadsheetSetColumnWidth(sObj,count_row,20)>
	</cfoutput>
	
<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
	
	
<cfheader name="Content-Disposition" value="inline; filename=WEFIT_#get_token_attributed.token_session_name#.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">


</cfif>
