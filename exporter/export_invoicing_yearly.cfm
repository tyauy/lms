
<cfparam name="from_tselect">
<cfparam name="to_tselect">
<cfparam name="p_id">
				

<cfquery name="get_total" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	DATE_FORMAT(l.completed_date, "%Y-%m") as `Date`,
	cat.cat_name_#SESSION.LANG_CODE# as cat_name,
	lm.method_name_#SESSION.LANG_CODE# as method_name, f.formation_code as Formation,
	SUM(l.lesson_duration / 60) as `Duration`, 
	pricing_amount as `Price/H`,
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

	AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">

	AND DATE_FORMAT(l.completed_date, "%Y-%m") BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#from_tselect#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#to_tselect#">

	GROUP BY `Date`, cat.cat_id, tp.formation_id, tp.method_id
	ORDER BY `Date` ASC
</cfquery>


<cfspreadsheet action="write" query="get_total" filename="./export_in.xls"  overwrite="true">
<cflocation addtoken="no" url="./export_in.xls">

