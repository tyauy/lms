<cfprocessingdirective pageEncoding="utf-8">
<cfif listFindNoCase("TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfif isdefined("date_schedule_from") AND isdefined("date_schedule_to") AND (isdefined("a_id") OR isdefined("g_id"))>


	<cfset date_schedule_from = "#lsdateformat(date_schedule_from,'yyyy-mm-dd','fr')#">
	<cfset date_schedule_to = "#lsdateformat(date_schedule_to,'yyyy-mm-dd','fr')#">


	<cfif isdefined("g_id")>
		<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
			SELECT 
			r.*,
			u.user_id, u.user_firstname, u.user_name,
			u2.user_id as trainer_id, u2.user_firstname as trainer_firstname,
			sm.sessionmaster_name,
			a.account_name, a.account_id,
			l.lesson_start,
			COALESCE(r.rating_date, l.lesson_start) as filtered_date
			FROM lms_rating r
			INNER JOIN user u ON u.user_id = r.user_id
			INNER JOIN user u2 ON u2.user_id = r.trainer_id
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN lms_lesson2 l ON r.lesson_id = l.lesson_id
			INNER JOIN lms_tpsession s ON s.session_id = l.session_id
			INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
			<cfif isdefined("g_id") AND g_id neq "0">
			AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
			</cfif>
			<cfif isdefined("t_id") AND t_id neq "0">
			AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfif>
			AND COALESCE(r.rating_date, l.lesson_start) >= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_from#">
			AND COALESCE(r.rating_date, l.lesson_start) <= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_to#">
			ORDER BY rating_id DESC 
		</cfquery>
		
	<cfelse>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>

</cfif>

<cfif ((isdefined("date_schedule_from") AND isdefined("date_schedule_to")) OR (isdefined("msel") AND isdefined("ysel"))) AND (isdefined("a_id") OR isdefined("g_id"))>

<cfif isdefined("date_schedule_to")>
<cfset name_tab_1 = "FEEDBACK #date_schedule_to#"> 
</cfif>



<!----------------------------1ST SPREADSHEET ------------------->
<cfset sObj = SpreadsheetNew("#name_tab_1#",false)>

<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
<!--- CREATE HEADER FOR GLOBAL SHEET --->
<cfif isdefined("date_schedule_to")>
	<cfset listrows_gl = "#obj_translater.get_translate('table_th_learner')#,
	#obj_translater.get_translate('table_th_account')#,
	#obj_translater.get_translate('table_th_date')#,
	#obj_translater.get_translate('table_th_program_short')#,
	#obj_translater.get_translate('table_th_trainer')#,
	#obj_translater.get_translate('table_th_rating_techno')#,
	#obj_translater.get_translate('table_th_rating_teaching')#,
	#obj_translater.get_translate('table_th_support')#,
	#obj_translater.get_translate('rating_badge_title')#,
	#obj_translater.get_translate('table_th_personnality')#">

</cfif>

<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize = "10">
<cfset FormatStruct.fgcolor = "pale_blue">
<cfset FormatStruct.alignment = "center">
<cfset FormatStruct.textwrap = "false"> 
<cfset FormatStruct.bottomborder ="medium"> 
<cfset FormatStruct.bold = "true"> 
<cfset FormatStruct.verticalalignment = "vertical_center"> 

<cfset SpreadSheetSetColumnWidth (sObj, 1, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 2, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 3, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 4, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 5, 13)>
<cfset SpreadSheetSetColumnWidth (sObj, 6, 35)>
<cfset SpreadSheetSetColumnWidth (sObj, 7, 35)>
<cfset SpreadSheetSetColumnWidth (sObj, 8, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 9, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 10, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 11, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 14, 15)>
<cfset SpreadSheetSetColumnWidth (sObj, 15, 15)>
<cfset SpreadsheetAddRow(sObj,listrows_gl)>
<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 
<cfset count_row = 1>

<cfoutput query="get_notation">
    <!--- Invoke the badges_get component to fetch the badge titles --->
    <cfinvoke component="api/ratings/badges_get" method="oread_badges_bylesson" returnvariable="badges">
        <cfinvokeargument name="l_id" value="#get_notation.lesson_id#">
    </cfinvoke>
    <cfset badge_names = []>
    <cfloop query="badges">
        <cfset ArrayAppend(badge_names, badges["BADGE_NAME"])>
    </cfloop>
    <cfset badge_titles = ArrayToList(badge_names, " & ")>

    <!--- Invoke the ratings_personality_get component to fetch the trainer personalities --->
    <cfinvoke component="api/ratings/ratings_personality_get" method="oread_trainer_personality" returnvariable="perso">
        <cfinvokeargument name="tr_id" value="#get_notation.trainer_id#">
        <cfinvokeargument name="u_id" value="#get_notation.user_id#">
    </cfinvoke>
    <cfset trainer_personalities = []>
    <cfloop query="perso">
        <cfset ArrayAppend(trainer_personalities, perso["PERSO_NAME"])>
    </cfloop>
    <cfset trainer_personality_list = ArrayToList(trainer_personalities, " & ")>

    <cfset current_row = count_row + 1>
    <cfset rowData = [
        get_notation.user_firstname & " " & get_notation.user_name,
        get_notation.account_name,
		DateFormat(get_notation.filtered_date, 'dd/mm/yyyy'),
        get_notation.sessionmaster_name,
        get_notation.trainer_firstname,
        get_notation.rating_techno,
        get_notation.rating_teaching,
        get_notation.rating_support,
        badge_titles,
		trainer_personality_list
    ]>
    <cfset SpreadsheetAddRow(sObj, arrayToList(rowData))>
    <cfset count_row++>
</cfoutput>







	
<cfset SpreadsheetSetActiveSheetNumber(sObj,1)>

<cfif isdefined("date_schedule_to")>
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#date_schedule_from#_#date_schedule_to#.xls">
	<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
<cfelseif isdefined("msel")>
	<cfheader name="Content-Disposition" value="inline; filename=WEFIT_Report_#ysel#-#msel#.xls">
	<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
</cfif>

</cfif>
</cfif>



