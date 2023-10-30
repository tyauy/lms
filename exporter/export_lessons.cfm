<cfset SESSION.LANG_CODE = "en">
<cfset SESSION.LANG = "2">
<!--- https://lms.wefitgroup.com/exporter/export_lessons.cfm?start_range=2021-08-01&end_range=2022-07-31		 --->
				
<cfif isdefined("tselect")>

	<cfset get_lessons = obj_query.oget_lessons(st_id="5",period_month="#tselect#",orderby="trainer_firstname",pmissed="1",invoicing="1")>

	<!--- <cfdump var="#get_lessons#"> --->

<cfelseif isdefined("start_range") AND isdefined("end_range")>
<cfset ghosted = "0">

		<cfset get_lessons = obj_query.oget_lessons(st_id="5",start_range="2021-08-01",end_range="2022-07-31",orderby="trainer_firstname",pmissed="1",invoicing="1")>

</cfif>

<cfset listrows = "Instructor,Learner,Learner Status,Company,Entity,Schedule,Completed,Duration,Lesson,Status,Training Program,Order Id,Is test,Is group,Attendess,hours,rates">

<table>
<tr>
<cfloop list="#listrows#" index="pop">
<td><cfoutput>#pop#</cfoutput></td>
</cfloop>
<cfoutput query="get_lessons">
<tr>
<td>#planner_temp_firstname#<!--- // #planner_firstname#---></td>
<td>#user_firstname# #user_name#</td>
<td>-</td>
<td>#account_name#</td>
<td>#provider_name#</td>
<td>#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#</td>
<td>#dateformat(completed_date,'dd/mm/yyyy')#</td>
<td>#lesson_duration#</td>
<td>#sessionmaster_name#</td>
<td>#status_name#</td>
<td>#obj_lms.get_tp_icon_ll(tp_id,tp_rank,formation_code,method_id,tp_duration)#</td>
<td>#order_ref#</td>
<td>-</td>
<td>-</td>
<td>-</td>
<td>#replacenocase(lesson_duration/60,".",",","ALL")#</td>
<td>#pricing_amount#</td>
</tr>
</cfoutput>









<cfabort>


<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfif isdefined("tselect")>

<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",period_month="#tselect#")>


<!--- CREATE SPREADSHEET --->
<cfset sObj=SpreadsheetNew()>

<!--- CREATE HEADER ROW --->
<cfset listrows = "Instructor,Learner,Learner Status,Company,Schedule,Duration,Lesson,Status,Training Program,Is test,Attendess,hours">

<cfset SpreadsheetAddRow(sObj,listrows)>
	
<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize="10">
<cfset FormatStruct.fgcolor="pale_blue">
<cfset FormatStruct.alignment="center">
<cfset FormatStruct.textwrap="false"> 

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 

<cfset count_row = 2>
						


	<cfoutput query="get_lessons">
		<cfset count_row = count_row+1>
		<cfset lesson_format = lesson_duration/60>
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#,#lesson_format#,#sessionmaster_name#,#status_name#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#",count_row)>	
	</cfoutput>
	
	<!---<cfset count_row = count_row+1>
	
	<cfset SpreadsheetAddRow(sObj,"TOTAL,,,,,#count_done#,#count_abs#",count_row)>
	<cfset SpreadsheetMergeCells(sObj,count_row,count_row,1,5)>
	
	
	
	<cfset SpreadSheetSetRowHeight(sObj,count_row,25)> 
	<cfset SpreadsheetFormatRow(sObj,{bold=TRUE, alignment="right", fgcolor="light_turquoise"},count_row)>
	
	<cfset count_row = count_row+1>--->
	



<cfspreadsheet action="write" name="sObj" filename="./export_lessons.xls" overwrite="true">

<cflocation addtoken="no" url="./export_lessons.xls">





















</cfif>



</cfif>
