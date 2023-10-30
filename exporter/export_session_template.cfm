<cfparam name="a_id">

<cfprocessingdirective pageEncoding="windows-1252">

<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
	SELECT `token_session_id`, `token_session_name` FROM `lms_list_token_session` WHERE `account_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> AND token_session_status <> "CLOSE"
</cfquery>

<!--- <cfdump var="#get_session#">

<cfabort> --->



<!--- <cfset s_listing = []>
<cfloop query="get_session">
    <cfset arrayAppend(s_listing, token_session_name)>
</cfloop> --->
	



<!--- CREATING SHEET --->
<cfset sObj = SpreadsheetNew("data")>
<cfset workbook = sObj.getWorkBook()>
<cfset sheet = workbook.getSheet("data")>


<!--- DROPDOWN SESSION --->
<cfset dvconstraint = createObject("java","org.apache.poi.hssf.usermodel.DVConstraint")>
<cfset cellRangeList = createObject("java","org.apache.poi.ss.util.CellRangeAddressList")>
<cfset dataValidation = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataValidation")>

<cfset hidden = workbook.createSheet("hidden")>

<cfset count_row = 0>
<cfoutput query="get_session">
	<cfset count_row = count_row+1>
	<!--- <cfset lesson_format = lesson_duration/60> --->
	<cfset row = hidden.createRow(count_row)>
	<cfset cell = row.createCell(0)>
	<cfset cell.setCellValue(token_session_name)>
</cfoutput>

<cfset count_row = count_row+1>

<cfset namedCell = workbook.createName()>
<cfset namedCell.setNameName("hidden")>	
<cfset namedCell.setRefersToFormula("hidden!$A$1:$A$" & count_row)>







<!--- Define cell list rowstart, rowend, column start, column end --->
<cfset addressList = cellRangeList.init(2, 9, 5, 5)> <!--- From 2 to 10th row in second column --->
<cfset s_constraint = dvconstraint.createFormulaListConstraint("hidden")> <!--- set contraint value --->
<cfset s_validation = dataValidation.init(addressList, s_constraint)> <!--- apply validation on address list --->
<cfset s_validation.setSuppressDropDownArrow(false)> <!--- Enable/disable dropdown arrow. --->
<cfset workbook.setSheetHidden(1, true)>
<cfset sheet.addValidationData(s_validation)> <!--- Add validation to sheet. --->


<!--- Define cell list rowstart, rowend, column start, column end --->
<cfset addressList = cellRangeList.init(2, 9, 6, 6)> <!--- From 2 to 10th row in second column --->
<cfset m_constraint = dvconstraint.createExplicitListConstraint(['DISTANCIEL','PRESENTIEL'])> <!--- set contraint value --->
<cfset m_validation = dataValidation.init(addressList, m_constraint)> <!--- apply validation on address list --->
<cfset m_validation.setSuppressDropDownArrow(false)> <!--- Enable/disable dropdown arrow. --->
<cfset sheet.addValidationData(m_validation)> <!--- Add validation to sheet. --->

<!--- Define cell list rowstart, rowend, column start, column end --->
<cfset addressList = cellRangeList.init(2, 9, 7, 7)> <!--- From 2 to 10th row in second column --->
<cfset v_constraint = dvconstraint.createExplicitListConstraint(['GENERAL','BUSINESS'])> <!--- set contraint value --->
<cfset v_validation = dataValidation.init(addressList, v_constraint)> <!--- apply validation on address list --->
<cfset v_validation.setSuppressDropDownArrow(false)> <!--- Enable/disable dropdown arrow. --->
<cfset sheet.addValidationData(v_validation)> <!--- Add validation to sheet. --->


<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>

<!--- STYLE --->
<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize = "10">
<cfset FormatStruct.fgcolor = "pale_blue">
<cfset FormatStruct.alignment = "center">
<cfset FormatStruct.textwrap = "false"> 
<cfset FormatStruct.bottomborder ="medium"> 
<cfset FormatStruct.bold = "true"> 
<cfset FormatStruct.verticalalignment = "vertical_top"> 

<!--- TITLE --->
<cfset SpreadsheetAddRow(sObj,"WEFIT TEMPLATE")>
<cfset SpreadsheetMergeCells(sObj,1,1,1,8)>

<!--- ROW TITLE --->
<cfset listrows_gl = "Date D#chr(233)#but#chr(13)#DD/MM/YYYY,Date Butoir#chr(13)#DD/MM/YYYY,#chr(201)#mail,Nom,Pr#chr(233)#nom,Session,M#chr(233)#thode,Version">
<cfset SpreadsheetAddRow(sObj,listrows_gl)>
	
<!--- APPLY STYLE --->
<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadsheetFormatRow(sObj,FormatStruct,2)>

<cfset SpreadSheetSetRowHeight(sObj,1,25)> 
<cfset SpreadSheetSetRowHeight(sObj,2,25)> 

<cfset spreadsheetSetColumnWidth(sObj,1,15)>
<cfset spreadsheetSetColumnWidth(sObj,2,20)>
<cfset spreadsheetSetColumnWidth(sObj,3,15)>
<cfset spreadsheetSetColumnWidth(sObj,4,15)>
<cfset spreadsheetSetColumnWidth(sObj,5,25)>
<cfset spreadsheetSetColumnWidth(sObj,6,15)>
<cfset spreadsheetSetColumnWidth(sObj,7,15)>

<!--- COMMENT --->

<cfset comment1= structNew() >
<cfset comment1.anchor="0,0,5,8">
<!--- <cfset comment1.author="Adobe Systems"> --->
<!--- <cfset comment1.bold="true"> --->
<!--- <cfset comment1.color="dark_green"> --->
<cfset comment1.comment="You can input a custom session name by delete the dropdown menu and inputing a new name#chr(13)#A new session with this name and the 'Date buttoir' will be created">
<!--- <cfset comment1.fillcolor="light_gray"> --->
<cfset comment1.font="Courier">
<cfset comment1.horizontalalignment="left">
<cfset comment1.linestyle="dashsys">
<cfset comment1.size="10">
<cfset comment1.verticalalignment="top">
     
    <!--- //Set the comment.  --->
<cfset SpreadsheetSetCellComment(sObj,comment1,2,6)>





<cfheader name="Content-Disposition" value="inline; filename=WEFIT_template.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
