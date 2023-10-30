<cfparam name="URL.tabID" default="0">
<!--- Now use URL.tabID to filter or organize the export data as needed --->

<cfprocessingdirective pageEncoding="utf-8">
<cfif listFindNoCase("TM,CS,SALES,FINANCE,TRAINERMNG,PARTNER", SESSION.USER_PROFILE)>

<cfif isdefined("date_schedule_from") AND isdefined("date_schedule_to") AND (isdefined("a_id") OR isdefined("g_id"))>

	<!------ CF TRICK FOR DATEPICKER -------------->
	<!--- <cfif day(date_schedule_from) lte "12">
		<cfset date_schedule_from = "#dateformat(date_schedule_from,'yyyy-dd-mm')#">
	<cfelse>
	</cfif>	 --->
	<cfset date_schedule_from = "#lsdateformat(date_schedule_from,'yyyy-mm-dd','fr')#">


	<!--- <cfif day(date_schedule_to) lte "12">
		<cfset date_schedule_to = "#dateformat(date_schedule_to,'yyyy-dd-mm')#">
	<cfelse>
	</cfif>	 --->
	<cfset date_schedule_to = "#lsdateformat(date_schedule_to,'yyyy-mm-dd','fr')#">


	<cfif isdefined("g_id")>
		<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",start_range="#date_schedule_from#",end_range="#date_schedule_to#",g_id="#g_id#",orderby="learner_name",tm="1")>
		<cfset get_learner = obj_query.oget_learner(m_id="1,2",g_id="#g_id#")>
	<cfelseif isdefined("a_id")>
		<cfif listLen(a_id) GT 1>
			<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",start_range="#date_schedule_from#",end_range="#date_schedule_to#",list_account="#a_id#",orderby="learner_name",tm="1")>
			<cfset get_learner = obj_query.oget_learner(m_id="1,2",list_account="#a_id#")>
		<cfelse>
			<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",start_range="#date_schedule_from#",end_range="#date_schedule_to#",a_id="#a_id#",orderby="learner_name",tm="1")>
			<cfset get_learner = obj_query.oget_learner(m_id="1,2",a_id="#a_id#")>
		</cfif>
	<cfelse>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>

<cfelseif isdefined("msel") AND isdefined("ysel") AND (isdefined("a_id") OR isdefined("g_id"))>

	<cfif isdefined("g_id")>
		<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",tselect="#ysel#-#msel#",g_id="#g_id#",orderby="learner_name",tm="1")>
		<cfset get_learner = obj_query.oget_learner(m_id="1,2",g_id="#g_id#")>
	<cfelseif isdefined("a_id")>
		<cfif listLen(a_id) GT 1>
			<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",tselect="#ysel#-#msel#",list_account="#a_id#",orderby="learner_name",tm="1")>
			<cfset get_learner = obj_query.oget_learner(m_id="1,2",list_account="#a_id#")>
		<cfelse>
			<cfset get_lessons = obj_query.oget_lessons(st_id="1,2,4,5",tselect="#ysel#-#msel#",a_id="#a_id#",orderby="learner_name",tm="1")>
			<cfset get_learner = obj_query.oget_learner(m_id="1,2",a_id="#a_id#")>
		</cfif>
	<cfelse>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
	
</cfif>


<cfif ((isdefined("date_schedule_from") AND isdefined("date_schedule_to")) OR (isdefined("msel") AND isdefined("ysel"))) AND (isdefined("a_id") OR isdefined("g_id"))>

<cfif isdefined("date_schedule_to")>
<cfset name_tab_1 = "REPORTING #date_schedule_to#"> 
<cfelseif isdefined("msel")>
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#ysel#-#msel#.xls">
<cfset name_tab_1 = "REPORTING #ysel#-#msel#"> 
</cfif>
<cfset name_tab_2 = "VISIO"> 
<cfset name_tab_3 = "ELEARNING"> 







<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
<cfset SpreadsheetCreateSheet(sObj,"#name_tab_2#")>
<cfset SpreadsheetCreateSheet(sObj,"#name_tab_3#")>


<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfif isdefined("date_schedule_to")>
	<cfset listrows_gl = "#obj_translater.get_translate('table_th_learner')#,
	#obj_translater.get_translate('table_th_account')#,
	#lcase(obj_translater.get_translate('shop_menu_funding'))#,
	#obj_translater.get_translate('table_th_launching')#,
	#obj_translater.get_translate('table_th_program_short')#,
	#obj_translater.get_translate('table_th_program_end')#,
	PTA,
	#obj_translater.get_translate('table_th_status')#,
	#obj_translater.get_translate('table_th_trainer')#,
	#obj_translater.get_translate('table_th_period_done')#,
	#obj_translater.get_translate('table_th_total_done')#,
	#obj_translater.get_translate('table_th_period_missed')#,
	#obj_translater.get_translate('table_th_total_missed')#,
	#obj_translater.get_translate('table_th_remaining')#,
	#obj_translater.get_translate('table_th_booked')#,
	#obj_translater.get_translate('table_th_last_lesson')#,
	#obj_translater.get_translate('table_th_next_lesson')#">
<cfelseif isdefined("msel")>
	<cfset listrows_gl = "#obj_translater.get_translate('table_th_learner')#,
	#obj_translater.get_translate('table_th_account')#,
	#lcase(obj_translater.get_translate('shop_menu_funding'))#,
	#obj_translater.get_translate('table_th_launching')#,
	#obj_translater.get_translate('table_th_program_short')#,
	#obj_translater.get_translate('table_th_program_end')#,
	PTA,
	#obj_translater.get_translate('table_th_status')#,
	#obj_translater.get_translate('table_th_trainer')#,
	#obj_translater.get_translate('table_th_months_done')#,
	#obj_translater.get_translate('table_th_total_done')#,
	#obj_translater.get_translate('table_th_months_missed')#,
	#obj_translater.get_translate('table_th_total_missed')#,
	#obj_translater.get_translate('table_th_remaining')#,
	#obj_translater.get_translate('table_th_booked')#,
	#obj_translater.get_translate('table_th_last_lesson')#,
	#obj_translater.get_translate('table_th_next_lesson')#">
</cfif>



<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize = "10">
<cfset FormatStruct.fgcolor = "pale_blue">
<cfset FormatStruct.alignment = "center">
<cfset FormatStruct.textwrap = "false"> 
<cfset FormatStruct.bottomborder ="medium"> 
<cfset FormatStruct.bold = "true"> 
<cfset FormatStruct.verticalalignment = "vertical_center"> 

<cfset SpreadSheetSetColumnWidth (sObj, 1, 30)>
<cfset SpreadSheetSetColumnWidth (sObj, 2, 20)>
<cfset SpreadSheetSetColumnWidth (sObj, 3, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 4, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 5, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 6, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 7, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 8, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 9, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 10, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 11, 15)>


<cfset SpreadSheetSetColumnWidth (sObj, 16, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 17, 15)>

<!--- Add the header row to the spreadsheet and format it --->
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
		oim.order_item_mode_name,
		ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_alias,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2 <cfif isdefined("date_schedule_to")>AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_schedule_to#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_schedule_from#'<cfelseif isdefined("msel")>AND DATE_FORMAT(l.lesson_start, "%Y-%m") <= '#ysel#-#msel#' AND DATE_FORMAT(l.lesson_start, "%Y-%m") >= '#ysel#-#msel#'</cfif>) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3 <cfif isdefined("date_schedule_to")>AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_schedule_to#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_schedule_from#'<cfelseif isdefined("msel")>AND DATE_FORMAT(l.lesson_start, "%Y-%m") <= '#ysel#-#msel#' AND DATE_FORMAT(l.lesson_start, "%Y-%m") >= '#ysel#-#msel#'</cfif>) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4 <cfif isdefined("date_schedule_to")>AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_schedule_to#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_schedule_from#'<cfelseif isdefined("msel")>AND DATE_FORMAT(l.lesson_start, "%Y-%m") <= '#ysel#-#msel#' AND DATE_FORMAT(l.lesson_start, "%Y-%m") >= '#ysel#-#msel#'</cfif>) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5 <cfif isdefined("date_schedule_to")>AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_schedule_to#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_schedule_from#'<cfelseif isdefined("msel")>AND DATE_FORMAT(l.lesson_start, "%Y-%m") <= '#ysel#-#msel#' AND DATE_FORMAT(l.lesson_start, "%Y-%m") >= '#ysel#-#msel#'</cfif>) as tp_completed,
		
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled_total,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress_total,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled_total,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed_total,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed_total,
		
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
		(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
		(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson
		
		FROM lms_tp t 

		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
		LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id

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
		
		<cfif isdefined("date_schedule_to")>
		AND t.tp_date_start <= '#date_schedule_to#'
		<cfelseif isdefined("msel")>
		AND DATE_FORMAT(t.tp_date_start, "%Y-%m") <= '#ysel#-#msel#'
		</cfif>
		
		<!---- DONT DISPLAY FREE REMAIN 
		AND t.order_id <> 3 --->

		<!---- DONT DISPLAY HIDDEN USER  --->
		AND u.user_hide_report_all != 1
		AND !(u.user_hide_report_free_remain = 1 AND t.order_id = 3)

		AND (t.method_id = 1 OR t.method_id = 2)
		
		GROUP BY t.tp_id
		
		</cfquery>
		<cfif isDefined("ysel") AND isDefined("msel")>
			<cfset firstDayOfMonth = CreateDate(ysel, msel, 1)>
			<cfset lastDayOfMonth = CreateDateTime(ysel, msel, DaysInMonth(firstDayOfMonth), 22, 0, 0)>
		<cfelse>
			<cfset firstDayOfMonth = date_schedule_from>
			
			<cfset lastDayOfMonth = CreateDateTime(Year(date_schedule_from), Month(date_schedule_from), DaysInMonth(date_schedule_from), 22, 0, 0)>
		</cfif>
		
		
<cfloop query="get_tp">

	<cfquery name="get_lesson_next" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(lesson_start) as next_lesson FROM lms_lesson2 WHERE tp_id = #tp_id# AND status_id = 1
	</cfquery>


<cfquery name="get_lesson_last" datasource="#SESSION.BDDSOURCE#">
    SELECT lesson_start as last_lesson 
    FROM lms_lesson2 
    WHERE tp_id = #tp_id# 
    AND lesson_start < <cfqueryparam value="#lastDayOfMonth#" cfsqltype="cf_sql_timestamp">
    AND status_id = 5 
    ORDER BY lesson_start DESC 
    LIMIT 1
</cfquery>


	<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
	<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
	<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
	<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>	
	<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
	<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>	
	<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
	
	<cfif tp_scheduled_total eq ""><cfset tp_scheduled_total_go = "0"><cfelse><cfset tp_scheduled_total_go = tp_scheduled_total></cfif>
	<cfif tp_inprogress_total eq ""><cfset tp_inprogress_total_go = "0"><cfelse><cfset tp_inprogress_total_go = tp_inprogress_total></cfif>
	<cfif tp_missed_total eq ""><cfset tp_missed_total_go = "0"><cfelse><cfset tp_missed_total_go = tp_missed_total></cfif>
	<cfif tp_completed_total eq ""><cfset tp_completed_total_go = "0"><cfelse><cfset tp_completed_total_go = tp_completed_total></cfif>	
	<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
	<cfset tp_remain_total_go = tp_duration_go-tp_missed_total_go-tp_completed_total_go-tp_scheduled_total_go-tp_inprogress_total_go>	
	<cfset tp_done_total_go = tp_completed_total_go+tp_inprogress_total_go>
	
	<cfset count_row = count_row+1>

	<cfset _tp_name = tp_name>

	<cfif order_id eq 3>
		<cfset tp_date_start = "#LSdateformat(order_start,'dd/mm/yyyy', 'fr')#">

		<cfset tp_date_end = "#lsDateFormat(order_end,'dd/mm/yyyy', 'fr')#">
<!--- <cfif tp_free_remain_old_id neq "">

			<cfquery name="get_fro" datasource="#SESSION.BDDSOURCE#">
				SELECT t.tp_id, t.method_id, t.tp_duration, f.formation_code
				FROM lms_tp t
				LEFT JOIN lms_formation f ON l.formation_id = f.formation_id
				WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_free_remain_old_id#">
			</cfquery>
	
			<cfset _tp_name = obj_lms.get_tp_text(tp_id="#get_fro.tp_id#",formation_code="#get_fro.formation_code#",method_id="#get_fro.method_id#",tp_duration="#get_fro.tp_duration#",order_id="3")>
			
		</cfif> --->

	<cfelse>
		<cfset tp_date_start = "#LSdateformat(tp_date_start,'dd/mm/yyyy', 'fr')#">

		<cfset tp_date_end = "#lsDateFormat(tp_date_end,'dd/mm/yyyy', 'fr')#">
	</cfif>


	<cfset last_lesson_pta = "">

	<cfif tp_status_id eq "3">
		<cfset last_lesson_pta = last_lesson>
	</cfif>

	<cfif get_lesson_last.last_lesson neq "">
		
		<cfif day(get_lesson_last.last_lesson) lte "12">
			<cfset true_last_lesson = "#dateformat(get_lesson_last.last_lesson,'mm/dd/yyyy')#">
		<cfelse>
			<cfset true_last_lesson = "#dateformat(get_lesson_last.last_lesson,'dd/mm/yyyy')#">
		</cfif>
		
	<cfelse>
		<cfset true_last_lesson = "N/A">
	</cfif>
	<cfif get_lesson_next.next_lesson neq "">
		<cfif day(get_lesson_next.next_lesson) lte "12">
			<cfset next_lesson = "#dateformat(get_lesson_next.next_lesson,'mm/dd/yyyy')#<!--- #timeformat(get_lesson_next.next_lesson,'HH:mm')#--->">
		<cfelse>
			<cfset next_lesson = "#dateformat(get_lesson_next.next_lesson,'dd/mm/yyyy')#<!--- #timeformat(get_lesson_next.next_lesson,'HH:mm')#--->">
		</cfif>
	<cfelse>
		<cfset next_lesson = "">
	</cfif>
	
	<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
	<cfset planner_list = "">
	<cfloop query="tp_trainer">
		<cfif planner_list neq ""><cfset planner_list &= " - "></cfif>
		<cfset planner_list &= "#planner#">
	</cfloop>

	<cfif tp_status_id eq "3" OR tp_status_id eq "4">
		<!---<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#dateformat(tp_date_start,'dd/mm/yyyy')#,#obj_lms.get_tp_text(tp_id,tp_rank,formation_code,method_id,tp_duration)#,#dateformat(tp_date_end,'dd/mm/yyyy')#,#status_name#,#planner_list#,-,-,-,-,-,-",count_row)>	--->
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#order_item_mode_name#,#tp_date_start#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#_tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#,#tp_date_end#,#last_lesson_pta#,#status_name#,#planner_list#,#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_done_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_remain_total_go#",unit="min")#,N/A,N/A,N/A",count_row)>

	<cfelse>
		
		<cfif isdefined("msel") AND isdefined("ysel")>
			<cfset tocompare = "#ysel#-#msel#">
			<cfset tocompare2 = "#year(now())#-#listgetat(SESSION.LISTMONTHS_CODE,month(now()))#">
			<cfif tocompare eq tocompare2>
				<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#order_item_mode_name#,#tp_date_start#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#_tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#,#tp_date_end#,#last_lesson_pta#,#status_name#,#planner_list#,#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_done_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_remain_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#,#true_last_lesson#,#next_lesson#",count_row)>
			<cfelse>
				<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#order_item_mode_name#,#tp_date_start#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#_tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#,#tp_date_end#,#last_lesson_pta#,#status_name#,#planner_list#,#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_done_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_remain_total_go#",unit="min")#,N/A,#true_last_lesson#,N/A",count_row)>
			</cfif>
		<cfelse>
				<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#account_name#,#order_item_mode_name#,#tp_date_start#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#_tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#,#tp_date_end#,#last_lesson_pta#,#status_name#,#planner_list#,#obj_lms.get_format_hms(toformat="#tp_done_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_done_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_missed_total_go#",unit="min")#,#obj_lms.get_format_hms(toformat="#tp_remain_total_go#",unit="min")#,N/A,N/A,N/A",count_row)>
		</cfif>
		
	</cfif>

	<cfif tp_status_id eq "3" OR tp_status_id eq "4" OR tp_status_id eq "11">
	<cfset cell_color = "grey_25_percent">
	<cfelse>
	<cfset cell_color = "">
	</cfif>
	
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,1)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,2)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,3)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",dataformat="dd/mm/yyyy",fgcolor="#cell_color#"}, count_row,4)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="grey_25_percent",fgcolor="#cell_color#"}, count_row,5)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",dataformat="dd/mm/yyyy",fgcolor="#cell_color#"}, count_row,6)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",dataformat="dd/mm/yyyy",fgcolor="#cell_color#"}, count_row,7)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,8)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,9)>
	
	<cfif tp_done_go neq "0" AND tp_done_go neq "-" AND tp_status_id neq "3" AND tp_status_id neq "4" AND tp_status_id neq "11">		
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="light_green"}, count_row,10)>
	<cfelse>
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,10)>
	</cfif>
	
	<cfif tp_done_total_go neq "0" AND tp_done_total_go neq "-" AND tp_status_id neq "3" AND tp_status_id neq "4" AND tp_status_id neq "11">		
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="light_green"}, count_row,11)>
	<cfelse>
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,11)>
	</cfif>
	
	<cfif tp_missed_go neq "0" AND tp_missed_go neq "-" AND tp_status_id neq "3" AND tp_status_id neq "4" AND tp_status_id neq "11">		
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="light_orange"}, count_row,12)>
	<cfelse>
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,12)>
	</cfif>
	
	<cfif tp_missed_total_go neq "0" AND tp_missed_total_go neq "-" AND tp_status_id neq "3" AND tp_status_id neq "4" AND tp_status_id neq "11">		
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="light_orange"}, count_row,13)>
	<cfelse>
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,13)>
	</cfif>
	
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,14)>
	
	<cfif tp_scheduled_go neq "0" AND tp_scheduled_go neq "-" AND tp_status_id neq "3" AND tp_status_id neq "4" AND tp_status_id neq "11">	
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",bold="true",fgcolor="light_yellow"}, count_row,15)>
	<cfelse>
		<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",fgcolor="#cell_color#"}, count_row,15)>
	</cfif>
	
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",dataformat="dd/mm/yyyy",fgcolor="#cell_color#"}, count_row,16)>
	<cfset SpreadsheetFormatCell(sObj,{alignment="center",verticalalignment="vertical_center",dataformat="dd/mm/yyyy",fgcolor="#cell_color#"}, count_row,17)>
	
	
	<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
</cfloop>

	
	
	
</cfoutput>




<!----------------------------2ND SPREADSHEET ------------------->
<cfset SpreadsheetSetActiveSheetNumber(sObj,2)>

<!--- CREATE HEADER FOR DETAILS SHEET --->
<cfset listrows_details = "#obj_translater.get_translate('table_th_learner')#,#obj_translater.get_translate('table_th_date')#,#obj_translater.get_translate('table_th_time')#,#obj_translater.get_translate('table_th_status')#,#obj_translater.get_translate('table_th_trainer')#,#obj_translater.get_translate('table_th_program_short')#,#obj_translater.get_translate('table_th_course_title')#,#obj_translater.get_translate('table_th_method')#,#obj_translater.get_translate('table_th_duration')#">
<cfset SpreadsheetAddRow(sObj,listrows_details)>

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 
<cfset SpreadSheetSetColumnWidth (sObj, 1, 30)>
<cfset SpreadSheetSetColumnWidth (sObj, 2, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 3, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 4, 9)>
<cfset SpreadSheetSetColumnWidth (sObj, 5, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 6, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 7, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 8, 20)>


	<cfset count_row = 1>

	<cfoutput query="get_lessons">
		<cfset count_row = count_row+1>
		<cfset lesson_format = obj_lms.get_format_hms(toformat="#lesson_duration#",unit="min")>
		<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#dateformat(lesson_start,'yyyy-mm-dd')#,#timeformat(lesson_start,'HH:mm')#,#status_name#,#planner_firstname#,#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#_tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",order_id="#order_id#")#,#sessionmaster_name#,#method_alias#,#lesson_format#",count_row)>	
		<cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
		<!---<cfset SpreadsheetFormatCell(sObj,{dataformat="dd/mm/yyyy"}, count_row,2)>--->
	</cfoutput>
	
	
	
	
	
	
<!----------------------------3rd SPREADSHEET ------------------->
<cfset SpreadsheetSetActiveSheetNumber(sObj,3)>

<!--- CREATE HEADER FOR DETAILS SHEET --->
<cfset listrows_details = "#obj_translater.get_translate('table_th_learner')#,#obj_translater.get_translate('table_th_tp_level')#,#obj_translater.get_translate('table_th_course')#,#obj_translater.get_translate('table_th_tests')#,#obj_translater.get_translate('table_th_quizzes')#,#obj_translater.get_translate('tooltip_time_elapsed')#,#obj_translater.get_translate('table_th_last_connect')#">
<cfset SpreadsheetAddRow(sObj,listrows_details)>

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 
<cfset SpreadSheetSetColumnWidth (sObj, 1, 30)>
<cfset SpreadSheetSetColumnWidth (sObj, 2, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 3, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 4, 9)>
<cfset SpreadSheetSetColumnWidth (sObj, 5, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 6, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 7, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 8, 20)>

	
	
<cfoutput query="get_learner">

<cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM user u 
INNER JOIN user_elapsed ue ON ue.user_id = u.user_id
WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="get_mock" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz_user qu 
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
WHERE (q.quiz_type = "toeic" OR q.quiz_type like "%bright%")
AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz_user qu 
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
WHERE (q.quiz_type = "exercice" OR q.quiz_type = "unit")
AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>


<cfif user_qpt neq "">
	<cfif user_qpt_lock neq "0">
		<cfset user_qpt = "#user_qpt# [en cours]">
	<cfelse>
		<cfset user_qpt = "#user_qpt#">
	</cfif>
<cfelse>
	<cfset user_qpt = "-">
</cfif>




<cfset list_mock = "">
<cfloop query="get_mock">
<cfif get_mock.quiz_user_end eq "">
<cfset list_mock = listappend(list_mock,"#ucase(quiz_type)# : Non fini","//")>
<cfelse>
<cfset list_mock = listappend(list_mock,"#ucase(quiz_type)# : ok","//")>
</cfif>
</cfloop>

<cfset SpreadsheetAddRow(sObj,"#user_firstname# #user_name#,#user_qpt#,#get_activity.recordcount#,#list_mock#,#get_quiz.recordcount#,#obj_lms.get_format_hms(toformat="#user_elapsed#")#,#dateformat(user_lastconnect,'dd/mm/yyyy')#",count_row)>

</cfoutput>
	
	
	
<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>

<cfif isdefined("date_schedule_to")>
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#date_schedule_from#_#date_schedule_to#.xls">
	<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
<cfelseif isdefined("msel")>
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#ysel#-#msel#.xls">
	<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
</cfif>
		



<!---
	<cfspreadsheet action="write" name="sObj" format="windows-1252" filename="./Reporting#SESSION.USER#.xls" overwrite="true">



<cflocation addtoken="no" url="./export_lessons2.xls">
---->


</cfif>
</cfif>



