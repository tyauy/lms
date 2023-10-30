<cfsetting requestTimeOut = "9000" />

<cfparam name="from_tselect">
<cfparam name="to_tselect">
				
<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
	SELECT user_id, user_firstname, user_name FROM user u
	INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
	INNER JOIN user_profile up ON up.profile_id = upc.profile_id AND upc.profile_id = 4
	WHERE user_paid_global = 1
	ORDER BY user_firstname
</cfquery>

<cfset sObj=SpreadsheetNew()>

<cfset listrows = "Trainer,Date,Category,Method,Formation,Duration,'Price/H',Total">

<cfset SpreadsheetAddRow(sObj,listrows)>

<cfset FormatStruct = {}>
<cfset FormatStruct.fontsize="10">
<cfset FormatStruct.fgcolor="pale_blue">
<cfset FormatStruct.alignment="center">
<cfset FormatStruct.textwrap="false"> 

<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
<cfset SpreadSheetSetRowHeight(sObj,1,25)> 

<cfset count_row = 2>

<cfloop query="get_trainers">

	<cfquery name="get_total" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		DATE_FORMAT(l.completed_date, "%Y-%m") as `Date`,
		cat.cat_name_#SESSION.LANG_CODE# as cat_name,
		lm.method_name_#SESSION.LANG_CODE# as method_name, f.formation_code as Formation,
		SUM(l.lesson_duration / 60) as `Duration`, 
		pricing_amount,
		SUM( (pricing_amount * (l.lesson_duration / 60) )) as Total
		FROM lms_lesson2 l
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
		INNER JOIN lms_lesson_method lm ON lm.method_id = tp.method_id
		INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
		INNER JOIN user u2 ON u2.user_id = l.planner_id
		INNER JOIN user_pricing uprice ON uprice.user_id = u2.user_id 
		INNER JOIN lms_tpsession_category cat ON cat.cat_id = sm.sessionmaster_cat_id AND cat.cat_public = 1
		AND uprice.formation_id = tp.formation_id
		AND uprice.pricing_cat = sm.sessionmaster_cat_id
		AND uprice.pricing_method = l.method_id
	
		WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
	
		AND (lesson_ghost != 1 OR lesson_ghost IS NULL)
	
		AND ( l.status_id = 5 OR (l.status_id = 4 AND u2.user_paid_missed = 1))
	
		AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_trainers.user_id#">
	
		AND DATE_FORMAT(l.completed_date, "%Y-%m") BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#from_tselect#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#to_tselect#">
	
		GROUP BY `Date`, cat.cat_id, tp.formation_id, tp.method_id
		ORDER BY `Date` ASC
	</cfquery>


	<cfoutput query="get_total">
		<cfset count_row = count_row+1>
		<!--- <cfset lesson_format = lesson_duration/60> --->
		<cfset SpreadsheetAddRow(sObj,"#get_trainers.user_firstname# #uCase(get_trainers.user_name)#,#Date#,#cat_name#,#method_name#,#Formation#,#Duration#,#pricing_amount#,#Total#",count_row)>	
	</cfoutput>

</cfloop>


<cfspreadsheet action="write" name="sObj" filename="./export_in_all.xls" overwrite="true">
<!--- <cfspreadsheet action="write" query="get_total" filename="./export_in.xls"  overwrite="true"> --->
<cflocation addtoken="no" url="./export_in_all.xls">

