<cfprocessingdirective pageEncoding="windows-1252">
<cfif SESSION.USER_PROFILE eq "TM">

<cfif isdefined("tselect")>

<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",period_month="#tselect#",a_id="#SESSION.ACCOUNT_ID#",orderby="learner_name")>
<cfset get_learner = obj_query.oget_learner(m_id="1",list_learner_account="#SESSION.LIST_LEARNER_ACCOUNT#")>

<cfset name_tab_1 = "Reporting #tselect#"> 
<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
<cfset SpreadsheetCreateSheet(sObj,"Details")>

<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfset listrows_gl = "Apprenant,Compte,Lancement,Parcours,Statut,Formateur,Planifi�,R�alis�,Manqu�,Restant,Dernier cours,Prochain Cours">


	

<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize = "10">
<cfset FormatStruct.fgcolor = "pale_blue">
<cfset FormatStruct.alignment = "center">
<cfset FormatStruct.textwrap = "false"> 
<cfset FormatStruct.bottomborder ="medium"> 
<cfset FormatStruct.bold = "true"> 
<cfset FormatStruct.verticalalignment = "vertical_top"> 


<cfset SpreadsheetAddRow(sObj,listrows_gl)>
<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 


<cfset count_row = 1>

<cfoutput query="get_learner">
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#user_id#")>
	
	
<cfloop query="get_tp">

	<cfquery name="get_lesson_next" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(lesson_start) as next_lesson FROM lms_lesson2 WHERE tp_id = #tp_id# AND status_id = 1
	</cfquery>

	<cfquery name="get_lesson_last" datasource="#SESSION.BDDSOURCE#">
	SELECT lesson_start as last_lesson FROM lms_lesson2 WHERE tp_id = #tp_id# AND lesson_start < now() AND (status_id = 1 OR status_id = 2) ORDER BY lesson_start
	</cfquery>

	<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled/60></cfif>
	<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress/60></cfif>
	<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled/60></cfif>
	<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed/60></cfif>
	<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed/60></cfif>	
	<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration/60></cfif>
	<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>	
	<cfset tp_done_go = tp_completed_go+tp_inprogress_go>


	<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
	<cfset planner_list = "">
	<cfloop query="tp_trainer">
		<cfif planner_list neq ""><cfset planner_list &= " - "></cfif>
		<cfset planner_list &= "#planner#">
	</cfloop>
	
	<cfset count_row = count_row+1>

	<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#dateformat(tp_date_start,'dd/mm/yyyy')#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#,#status_name#,#planner_list#,#tp_scheduled_go#,#tp_done_go#,#tp_missed_go#,#tp_remain_go#,#dateformat(get_lesson_last.last_lesson,'dd/mm/yyyy')# #timeformat(get_lesson_last.last_lesson,'hh:mm')#,#dateformat(get_lesson_next.next_lesson,'dd/mm/yyyy')# #timeformat(get_lesson_next.next_lesson,'hh:mm')#",count_row)>	
	
		<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="grey_25_percent"}, count_row,4)>
	
	<cfif tp_missed_go neq "0">	
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="light_orange"}, count_row,9)>
	</cfif>
	
	<cfif tp_done_go neq "0">	
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="light_green"}, count_row,8)>
	</cfif>
</cfloop>

	
	
	
</cfoutput>




<!----------------------------2ND SPREADSHEET ------------------->
<cfset SpreadsheetSetActiveSheetNumber(sObj,2)>

<!--- CREATE HEADER FOR DETAILS SHEET --->
<cfset listrows_details = "Apprenant,Date,Statut,Formateur,Parcours,Intitul�,M�thode,Dur�e">
<cfset SpreadsheetAddRow(sObj,listrows_details)>

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,20)> 

	<cfset count_row = 1>

	<cfoutput query="get_lessons">
		<cfset count_row = count_row+1>
		<cfset lesson_format = lesson_duration/60>
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#,#status_name#,#planner_firstname#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#,'#sessionmaster_name#',#method_alias#,#lesson_format#",count_row)>	
		<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
	</cfoutput>
	
	<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
	
	
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#tselect#.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">

<!---
	<cfspreadsheet action="write" name="sObj" format="windows-1252" filename="./Reporting#SESSION.USER#.xls" overwrite="true">



<cflocation addtoken="no" url="./export_lessons2.xls">
---->


</cfif>
</cfif>



