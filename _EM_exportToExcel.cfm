
<cfprocessingdirective pageEncoding="utf-8">

<!--- Your existing ColdFusion code for generating the spreadsheet goes here --->
<!--- Include all the necessary code for processing and creating the spreadsheet --->

<cfset sObj = SpreadsheetNew("#name_tab_1#", false)>
<cfset SpreadsheetCreateSheet(sObj, "#name_tab_2#")>
<cfset SpreadsheetCreateSheet(sObj, "#name_tab_3#")>

<!--- Add data and formatting to the spreadsheet (similar to your existing code) --->

<!--- Save the spreadsheet to a temporary file --->
<cfset tempFileName = ExpandPath("/path/to/your/temporary/directory/filename.xlsx")>
<cfset SpreadsheetWrite(sObj, tempFileName, true)>

<!--- Offer the file as a download to the user --->
<cfheader name="Content-Disposition" value="attachment; filename=your-exported-file.xlsx">
<cfcontent type="application/msexcel" file="#tempFileName#" deleteFile="true">

</cfprocessingdirective>
