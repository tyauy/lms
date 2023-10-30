<cfprocessingdirective pageEncoding="windows-1252">
<cfif listFindNoCase("TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfif isdefined("tselect")>

<cfset m_go = listgetat(SESSION.LISTMONTHS_CODE,listgetat(tselect,"2","_"))>
<cfset y_go = listgetat(tselect,"1","_")>

<cfif isdefined("g_id")>
	<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",period_month="#y_go#-#m_go#",g_id="#g_id#",orderby="learner_name")>
	<cfset get_learner = obj_query.oget_learner(m_id="1,2",g_id="#g_id#")>
<cfelseif isdefined("a_id")>
	<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",period_month="#y_go#-#m_go#",a_id="#a_id#",orderby="learner_name")>
	<cfset get_learner = obj_query.oget_learner(m_id="1,2",a_id="#a_id#")>
<cfelse>
	<cflocation addtoken="no" url="index.cfm">
</cfif>


<cfset name_tab_1 = "Reporting #tselect#"> 
<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
<cfset SpreadsheetCreateSheet(sObj,"Details")>

<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfset listrows_gl = "Apprenant,Compte,Lancement,Parcours,Fin parcours,Statut,Formateur,Planifi�,R�alis�,Manqu�,Restant,Dernier cours,Prochain Cours">


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
	
	<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name, ts.tp_status_css,
		SUM(s.session_duration) as session_duration,
		o.order_id, o.order_ref, o.order_start, o.order_end,
		ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_alias,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2 AND DATE_FORMAT(lesson_start,"%Y-$m") < '#y_go#-#m_go#') as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3 AND DATE_FORMAT(lesson_start,"%Y-$m") < '#y_go#-#m_go#') as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4 AND DATE_FORMAT(lesson_start,"%Y-$m") < '#y_go#-#m_go#') as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5 AND DATE_FORMAT(lesson_start,"%Y-$m") < '#y_go#-#m_go#') as tp_completed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 6 AND DATE_FORMAT(lesson_start,"%Y-$m") < '#y_go#-#m_go#') as tp_signed,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
		(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson
		
		FROM lms_tp t 

		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
				
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE 1 = 1
		
		AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			
		AND (t.method_id = 1 OR t.method_id = 2)
		
		GROUP BY t.tp_id
		
		</cfquery>
		
	
<cfloop query="get_tp">

	<cfquery name="get_lesson_next" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(lesson_start) as next_lesson FROM lms_lesson2 WHERE tp_id = #tp_id# AND status_id = 1
	</cfquery>

	<cfquery name="get_lesson_last" datasource="#SESSION.BDDSOURCE#">
	SELECT lesson_start as last_lesson FROM lms_lesson2 WHERE tp_id = #tp_id# AND lesson_start < now() AND status_id = 5 ORDER BY lesson_start DESC LIMIT 1
	</cfquery>

	<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
	<cfset planner_list = "">
	<cfloop query="tp_trainer">
		<cfif planner_list neq ""><cfset planner_list &= " - "></cfif>
		<cfset planner_list &= "#planner#">
	</cfloop>

	<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled/60></cfif>
	<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress/60></cfif>
	<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed/60></cfif>
	<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed/60></cfif>	
	<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration/60></cfif>
	<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>	
	<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
	
	<cfset count_row = count_row+1>

	<cfif tp_status_id eq "3" OR tp_status_id eq "4">
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#dateformat(tp_date_start,'dd/mm/yyyy')#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#,#dateformat(tp_date_end,'dd/mm/yyyy')#,#status_name#,#planner_list#,-,-,-,-,-,-",count_row)>	
		<cfset SpreadsheetFormatRow(sObj,{fgcolor="grey_25_percent"},count_row)>
	<cfelse>
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#dateformat(tp_date_start,'dd/mm/yyyy')#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#,#dateformat(tp_date_end,'dd/mm/yyyy')#,#status_name#,#planner_list#,#tp_scheduled_go#,#tp_done_go#,#tp_missed_go#,#tp_remain_go#,#dateformat(get_lesson_last.last_lesson,'dd/mm/yyyy')# #timeformat(get_lesson_last.last_lesson,'HH:mm')#,#dateformat(get_lesson_next.next_lesson,'dd/mm/yyyy')# #timeformat(get_lesson_next.next_lesson,'HH:mm')#",count_row)>	
	</cfif>
	
	

	<cfif tp_scheduled_go neq "0" AND tp_scheduled_go neq "-">	
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="light_yellow"}, count_row,8)>
	</cfif>
	
	<cfif tp_done_go neq "0" AND tp_done_go neq "-">	
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="light_green"}, count_row,9)>
	</cfif>
	
	<cfif tp_missed_go neq "0" AND tp_missed_go neq "-">	
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="light_orange"}, count_row,10)>
	</cfif>
	
	<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
	<cfset SpreadsheetFormatCell(sObj,{verticalalignment="TOP",bold="true",fgcolor="grey_25_percent"}, count_row,4)>
	
</cfloop>

	
	
	
</cfoutput>




<!----------------------------2ND SPREADSHEET ------------------->
<cfset SpreadsheetSetActiveSheetNumber(sObj,2)>

<!--- CREATE HEADER FOR DETAILS SHEET --->
<cfset listrows_details = "Apprenant,Date,Heure,Statut,Formateur,Parcours,Intitul�,M�thode,Dur�e">
<cfset SpreadsheetAddRow(sObj,listrows_details)>

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 

	<cfset count_row = 1>

	<cfoutput query="get_lessons">
		<cfset count_row = count_row+1>
		<cfset lesson_format = lesson_duration/60>
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#dateformat(lesson_start,'dd/mm/yyyy')#,#timeformat(lesson_start,'HH:mm')#,#status_name#,#planner_firstname#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#,#sessionmaster_name#,#method_alias#,#lesson_format#",count_row)>	
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



