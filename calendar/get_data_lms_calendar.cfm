<cfset keys = {
    "ID":"id",
    "TITLE":"title",
    "ALLDAY":"allDay",
    "START":"start",
    "END":"end",
    "URL":"url",
    "CLASSNAME":"className",
    "EDITABLE":"editable",
    "STARTEDITABLE":"startEditable",
    "DURATIONEDITABLE":"durationEditable",
    "RESOURCEEDITABLE":"resourceEditable",
    "RENDERING":"rendering",
    "OVERLAP":"overlap",
    "CONSTRAINT":"constraint",
    "RESOURCEid":"resourceId",
    "COLOR":"color",
    "BACKGROUNDCOLOR":"backgroundColor",
    "BORDERCOLOR":"borderColor",
    "TEXTCOLOR":"textColor",
    "TEST":"test",
	"PROFILE_NAME":"profile_name",
	"TASK_GROUP_ALIAS":"task_group_alias",
	"SEATS_TOTAL":"seats_total",
	"SEATS_USED":"seats_used",
	"SEATS_REMAINING":"seats_remaining",
	"PLANNER_ID":"planner_id",
	"TP_ID":"tp_id",
	"TPLEVEL_CSS":"tplevel_css",
	"TPLEVEL_ALIAS":"tplevel_alias",
	"TIMEHOUR":"timehour",
	"TIMEDAY":"timeday",
	"FORMATION_CODE":"formation_code",
	"IS_SUBSCRIBED":"is_subscribed",
	"IS_OUTDATED":"is_outdated",
	"TP_ICON":"tp_icon",
	"TP_COLOR":"tp_color",
	"FORMATION_ID":"formation_id",
    "EVENTTEXTCOLOR":"eventTextColor"
}>

<!------------------------------GET LESSON ----------------------------->
<cfparam name="user_side" default="trainer">

<cfif isdefined("get_lesson")>
<cfsilent>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.*, 
sm.sessionmaster_name, sm.sessionmaster_id,
m.method_name_#SESSION.LANG_CODE# as method_name, 
CONCAT(u1.user_firstname, " ", u1.user_name) as user_contact,
a1.account_name,
u2.user_firstname as planner_contact,
l.method_id,
ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name
FROM lms_lesson2 l
INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id

INNER JOIN lms_tpsession ts ON ts.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ts.sessionmaster_id
left join lms_tpuser tu on tu.tp_id = l.tp_id
LEFT JOIN user u1 ON tu.user_id = u1.user_id
LEFT JOIN account a1 ON a1.account_id = u1.account_id
INNER JOIN user u2 ON l.planner_id = u2.user_id

LEFT JOIN lms_tp t on l.tp_id = t.tp_id
WHERE 1=1

<cfif isdefined("p_id")>
AND (l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
OR l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
</cfif>
<cfif isdefined("u_id")>
AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfif>
AND l.status_id != 3
group by l.lesson_id
</cfquery>

<cfset table_lesson = arraynew(1)>

<cfoutput query="get_lesson">
    <cfset temp = arrayAppend(table_lesson, structNew())>
	<!-- ID -->
    <cfset table_lesson[currentrow].id = lesson_id>
	<!-- RESOURCE ID -->
    <cfif isdefined("get_resource")>
        <cfset table_lesson[currentrow].resourceid = planner_id>
    </cfif>
	<!-- TITLE -->
	<cfset lessonStartTime = TimeFormat(lesson_start, "HH:mm")>
	<cfset lessonEndTime = TimeFormat(lesson_end, "HH:mm")>
    <cfset titlePrefix = (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) ? "" 
	: (isDefined("short")) ? "#lessonEndTime#" 
	: (user_side eq "learner" OR user_side eq "test") ? "[#status_name# #lesson_duration#m #planner_contact#] #sessionmaster_name#" 
	: "[#status_name# #lesson_duration#m]">
    <cfset titleSuffix = (method_id eq 11) ? " #account_name# #method_name#" : (method_id eq 10) ? " Virtual class" : " #user_contact#">
    <cfset table_lesson[currentrow].title = titlePrefix & titleSuffix & " "&"#sessionmaster_name#">
	<cfset titleWithBr = lessonStartTime & "-" & titlePrefix & "<br>" 
	& "#status_name#" & "<br>" 
	& titleSuffix &" "& "<br>"
	& "#sessionmaster_name#">
	<cfset table_lesson[currentrow].titleWithBr = titleWithBr>
	<!-- eventTextColor -->
    <cfset table_lesson[currentrow].eventTextColor = "##000000">
    <cfset table_lesson[currentrow].textColor = "##000000">
	<!-- START -->
    <cfset table_lesson[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd") & "T" & TimeFormat(lesson_start, "HH:mm:ss") & "Z">
	<!-- BG COLOR -->	
    <cfset colorMap = {
        1: (sessionmaster_id eq "769") ? "##9e5bd6" : (method_id eq 11 or method_id eq 10) ? "##da5196" : "##FBC658",
        2: "##51BCDA",
        3: "##EF8157",
        4: "##EF8157",
        5: "##6BD0C6",
        6: "##6BD0C6"
    }>
    <cfset table_lesson[currentrow].color = colorMap[status_id]>
	<!-- END -->	
    <cfset table_lesson[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd") & "T" & TimeFormat(lesson_end, "HH:mm:ss") & "Z">
    <!-- EDITABLE -->
	<cfset table_lesson[currentrow].editable = true>
	<!-- CONSTRAINT -->
    <cfset table_lesson[currentrow].test = "go">
</cfoutput>


<cfset table_js = SerializeJSON(table_lesson)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEST","test","ALL")>
<cfset table_js = replacenocase(table_js,"EVENTTEXTCOLOR","eventTextColor","ALL")>
<cfset table_js = replacenocase(table_js,"TITLEWITHBR","titleWithBr","ALL")>


</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>







<!--------------------- GET BLOCKER ----------------------------->
<cfif isdefined("get_blocker")>
<cfsilent>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.planner_id, l.lesson_name
FROM lms_lesson2 l
WHERE l.blocker_id = 1
<cfif isdefined("p_id")>
AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfif>
<cfif isdefined("u_id")>
AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfif>

</cfquery>

<cfset table_blocker = arraynew(1)>

<cfoutput query="get_lesson">

	<cfset temp = arrayAppend(table_blocker, structNew())>
	
	<!----ID ----->
	<cfset table_blocker[currentrow].id = "blocker">
	
	<!----SECOND ID ----->
	<cfset table_blocker[currentrow].b_id = lesson_id>
	
	<!----PLANNER ID ----->
	<cfset table_blocker[currentrow].p_id = planner_id>
	
	<!----ICON  ----->
	<cfset table_blocker[currentrow].icon = "fas fa-trash-alt">
	
	<!----TITLE ----->
	<cfset table_blocker[currentrow].title = "[#lesson_name#]">
	
	<!--- COLOR --->
	<cfset table_blocker[currentrow].textColor = "##000000">

	<!----START ----->
	<cfset table_blocker[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd")&"T"&TimeFormat(lesson_start, "HH:mm:ss")&"Z">
	
	
	<cfset table_blocker[currentrow].color = "##D9D9D9">
	
	<!----END ----->	
	<cfset table_blocker[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd")&"T"&TimeFormat(lesson_end, "HH:mm:ss")&"Z">

	
</cfoutput>

<cfset table_js = SerializeJSON(table_blocker)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"B_ID","b_id","ALL")>
<cfset table_js = replacenocase(table_js,"P_ID","p_id","ALL")>
<cfset table_js = replacenocase(table_js,"ICON","icon","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEST","test","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>

<!--------------------- GET holiday ----------------------------->
<cfif isdefined("get_holidays")>
	<cfsilent>

		<cfquery name="get_holidays" datasource="#SESSION.BDDSOURCE#">
			SELECT id, holiday_isvalidated, start_date, end_date 
			FROM user_holidays 
			WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">

			</cfquery>  

	<cfset table_holiday = arraynew(1)>

	<cfoutput query="get_holidays">

		<cfset temp = arrayAppend(table_holiday, structNew())>

			<!----ID ----->
			<cfset table_holiday[currentrow].id = id>

		<!----VALIDATED ----->
		<cfset table_holiday[currentrow].holiday_isvalidated = holiday_isvalidated>
		<!----PLANNER ID ----->
		<cfset table_holiday[currentrow].p_id = p_id>


		<!----TITLE ----->
		<cfset table_holiday[currentrow].title = "VACATION">

		<!--- COLOR --->
		<cfset table_holiday[currentrow].textColor = "##000000">

		<!----START ----->
		<cfset table_holiday[currentrow].start = dateformat(start_date, "yyyy-mm-dd")>


		<cfset table_holiday[currentrow].color = "##00BFFF">

		<!----END ----->	
		<cfset table_holiday[currentrow].end = dateformat(end_date, "yyyy-mm-dd")>
	
		
	</cfoutput>
	
	<cfset table_js = SerializeJSON(table_holiday)>

<cfloop item="key" collection="#keys#">
    <cfset table_js = replacenocase(table_js,key,keys[key],"ALL")>
</cfloop>
	
	</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
	</cfif>




<!------------------------------GET AVAILABILITIES ----------------------------->

<cfif isdefined("get_avail") AND isdefined("p_id")>
<cfsilent>

<cfquery name="get_avail" datasource="#SESSION.BDDSOURCE#">
SELECT slot_start, slot_end FROM user_slots
WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>

<cfset table_avail = arraynew(1)>

<cfoutput query="get_avail">
	<cfset temp = arrayAppend(table_avail, structNew())>
	<cfset table_avail[currentrow].id = "trainer_avail">
	
	<cfset table_avail[currentrow].start = dateformat(slot_start, "yyyy-mm-dd")&"T"&TimeFormat(slot_start, "HH:mm:ss")&"Z">
	<cfset table_avail[currentrow].end = dateformat(slot_end, "yyyy-mm-dd")&"T"&TimeFormat(slot_end, "HH:mm:ss")&"Z">

	<cfset table_avail[currentrow].rendering = "inverse-background">
	<cfset table_avail[currentrow].color = "grey">
	<cfset table_avail[currentrow].textColor = "##000000">
</cfoutput>

<cfset table_js = SerializeJSON(table_avail)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"GROUPID","groupId","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEST","test","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>

</cfif>




<!-------------------------- GREY OUT PAST ---------------------------->

<cfif isdefined("get_now")>
<cfoutput>
[{"start":"2016-01-01T00:00:00Z","end":"#dateformat(now(),'yyyy-mm-dd')#T#timeformat(now(),'HH:mm:ss')#Z","id":"nower","color":"grey","rendering":"background"}]
</cfoutput>
</cfif>





<!------------------------------GET AVAILABILITIES ----------------------------->

<cfif isdefined("get_availability") AND isdefined("user_id")>

<cfsilent>
<cfquery name="get_availability" datasource="#SESSION.BDDSOURCE#">
SELECT a.*, u.user_color FROM lms_lesson_availability a
INNER JOIN user u ON u.user_id = a.user_id
WHERE a.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfset table_lesson = arraynew(1)>

<cfoutput query="get_availability">
	<cfset temp = arrayAppend(table_lesson, structNew())>
	<cfset table_lesson[currentrow].id = "trainer_avail">
	<!---<cfset table_lesson[currentrow].groupId = "trainer_avail">--->
	<cfset table_lesson[currentrow].start = dateformat(av_start, "yyyy-mm-dd")&"T"&TimeFormat(av_start, "HH:mm:ss")&"Z">
	<cfset table_lesson[currentrow].end = dateformat(av_end, "yyyy-mm-dd")&"T"&TimeFormat(av_end, "HH:mm:ss")&"Z">

	<cfset table_lesson[currentrow].rendering = "inverse-background">
	<cfset table_lesson[currentrow].color = "grey">
	<cfset table_lesson[currentrow].textColor = "##000000">

	<!---<cfset table_lesson[currentrow].resourceid = "#user_id#">--->
	
	<!---<cfif lesson_end lt now()><cfset table_lesson[currentrow].editable = false></cfif>--->
</cfoutput>

<cfset table_js = SerializeJSON(table_lesson)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"GROUPID","groupId","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEST","test","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>






<!------------------------------GET PLANNER ----------------------------->
<cfif isdefined("get_planner")>

<cfquery name="get_planner" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user WHERE profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4"> AND (user_id = 100 OR user_id = 84 OR user_id = 87 OR user_id = 99)
</cfquery>

<cfset table_user = arraynew(1)>

<cfoutput query="get_planner">

	<cfset temp = arrayAppend(table_user, structNew())>
	
	<!----ID ----->
	<cfset table_user[currentrow].id = user_id>
	
	<!----PROFIL ----->
	<!---<cfset table_user[currentrow].profile_name = profile_name>---->
	
	<!----TITLE ----->
	<cfset table_user[currentrow].title = "#user_name# #user_firstname#">

	<!--- COLOR --->
	<cfset table_user[currentrow].textColor = "##000000">

	<!----EDITABLE ----->
	<cfset table_user[currentrow].editable = true>
	
	
</cfoutput>


<cfset table_js = SerializeJSON(table_user)>

<!------ STANDARD FIELDS ---->
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"SOURCE","source","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>

<!------ CUSTOM FIELDS ---->
<cfset table_js = replacenocase(table_js,"PROFILE_NAME","profile_name","ALL")>

<cfoutput>#table_js#</cfoutput>
</cfif>




<!------------------------------MANAGE TASK ----------------------------->

<cfif isdefined("get_task") <!---AND isdefined("task_group")---> AND isdefined("task_closed")>
<cfsilent>

<cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT
l.log_id, l.log_remind, l.log_status, li.task_type_id,
tt.task_type_name, tt.task_color, tt.task_group_alias, tt.task_group, tt.task_category,  tt.task_group_rank,
u.user_id, u.user_firstname, u.user_name, ut.user_type_name_#SESSION.LANG_CODE# as user_type_name, ut.user_type_id,
up.profile_id, up.profile_name,
t.user_firstname as recipient_firstname, t.user_alias as recipient_alias,

a.account_name, a.account_id,
g.group_name, g.group_id, g.manager_id,
c.country_alpha,
ap.provider_name, ap.provider_code,

al.account_name as account_name_log, al.account_id as account_id_log,
gl.group_name as group_name_log, gl.group_id as group_id_log

FROM logs l
INNER JOIN logs_item li ON li.log_id = l.log_id
INNER JOIN task_type tt ON tt.task_type_id = li.task_type_id
LEFT JOIN user u ON u.user_id = l.user_id
LEFT JOIN user_type ut ON u.user_type_id = ut.user_type_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
LEFT JOIN user t ON l.to_id = t.user_id

LEFT JOIN account a ON a.account_id = u.account_id
LEFT JOIN account_group g ON g.group_id = a.group_id
LEFT JOIN settings_country c ON c.country_id = g.country_id

LEFT JOIN account al ON al.account_id = l.account_id
LEFT JOIN account_group gl ON gl.group_id = l.group_id
LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id

WHERE l.log_remind IS NOT NULL AND (li.log_item_status IS NULL OR li.log_item_status = 0)
AND task_category = "TO DO"
<cfif isdefined("task_group") AND task_group neq "0">AND task_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#"></cfif>
<cfif task_closed eq "1">AND log_status = 1<cfelse>AND log_status IS NULL</cfif>
<cfif isDefined("provider_selected")><cfif provider_selected neq 0> AND ap.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#provider_selected#" list="true">) </cfif></cfif>
GROUP BY l.log_id

ORDER BY <!---l.log_remind,---> tt.task_group_alias, tt.task_type_name, l.to_id
</cfquery>

<cfset table_logs = arraynew(1)>

<cfoutput query="get_task">

	<cfset temp = arrayAppend(table_logs, structNew())>
	
	<!----ID ----->
	<cfset table_logs[currentrow].id = log_id>
	
	<!----LOG ID ----->
	<cfset table_logs[currentrow].log_id = log_id>
	
	<!----USER_ID ----->
	<cfset table_logs[currentrow].user_id = user_id>
	
	<!----ACCOUNT_ID ----->
	<cfset table_logs[currentrow].account_id = account_id>
	<cfset table_logs[currentrow].account_id_log = account_id_log>
	
	<!----GROUP_ID ----->
	<cfset table_logs[currentrow].group_id = group_id>
	<cfset table_logs[currentrow].group_id_log = group_id_log>
	
	<!----ID ----->
	<cfset table_logs[currentrow].task_group_alias = task_group_alias>
	
	<!----TITLE ----->
	<cfset prefix = "#task_group_rank#">

	<cfset prefix = prefix&"<span class='lang-sm' lang='#lcase(provider_code)#'></span> ">

	<cfif user_type_id neq 3>
		<cfset prefix &= "<strong style='color:##FF0000'>(#user_type_name#)</strong>">
	</cfif>

	<cfif profile_id eq 9>
		<cfset prefix &= "<strong style='color:##FF0000'>(#profile_name#)</strong>">
	</cfif>

	
	<!--- <cfif manager_id eq "502" OR manager_id eq "7871"> --->
		<!--- <cfset prefix = prefix&"<span class='lang-sm' lang='#lcase(country_alpha)#'></span> "> --->
	<!--- </cfif> --->
	
	<cfif recipient_alias neq "">
		<cfset prefix = prefix&"<strong style='color:##FF0000'>[#recipient_alias#]</strong> ">
	</cfif>
	
	<cfif task_category eq "TO DO">
		<cfif group_id_log neq "">
			<cfset table_logs[currentrow].title = "#prefix#<strong>#task_type_name#</strong> #group_name_log#">
		<cfelseif account_id_log neq "">
			<cfset table_logs[currentrow].title = "#prefix#<strong>#task_type_name#</strong> #account_name_log#">
		<cfelseif user_id neq "">
			<cfset table_logs[currentrow].title = "#prefix#<strong>#task_type_name#</strong> #user_firstname# #user_name#">
		</cfif>
	<cfelseif task_category eq "FEEDBACK">
		<cfset table_logs[currentrow].title = "#prefix#<strong>#task_category# #task_type_name#</strong> #user_firstname# #user_name#">
	</cfif>

	<!----START ----->
	<cfset table_logs[currentrow].start = dateformat(log_remind, "yyyy-mm-dd")&"T"&TimeFormat(log_remind,"HH:mm:ss")&"Z">
	
	<!----COLOR ----->	
	<cfset table_logs[currentrow].textColor = "##000000">

	<cfif log_status eq "1">
		<cfset table_logs[currentrow].color = "##CCCCCC">
	<cfelse>
		<cfset table_logs[currentrow].color = "###task_color#">
	</cfif>
	
	<cfset table_logs[currentrow].editable = "true">
	
	<!---- ALL DAY OR NOT ----->	
	<cfif task_type_id eq "0">
	<cfset table_logs[currentrow].allday = true>
	<cfelse>
	<cfset table_logs[currentrow].allday = true>
	<!----END ----->	
	<!---<cfset table_logs[currentrow].end = dateformat(log_remind, "yyyy-mm-dd")&"T"&TimeFormat(dateadd("n",30,log_remind),"HH:mm:ss")&"Z">--->
	</cfif>
	
</cfoutput>

<cfset table_js = SerializeJSON(table_logs)>
<cfset table_js = replacenocase(table_js,"USER_ID","user_id","ALL")>
<cfset table_js = replacenocase(table_js,"ACCOUNT_ID","account_id","ALL")>
<cfset table_js = replacenocase(table_js,"GROUP_ID","group_id","ALL")>
<cfset table_js = replacenocase(table_js,"ACCOUNT_ID_LOG","account_id_log","ALL")>
<cfset table_js = replacenocase(table_js,"GROUP_ID_LOG","group_id_log","ALL")>
<cfset table_js = replacenocase(table_js,"LOG_ID","log_id","ALL")>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>

<cfset table_js = replacenocase(table_js,"TASK_GROUP_ALIAS","task_group_alias","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>





<!------------------------------MANAGE SETUP ----------------------------->

<cfif (isdefined("get_setup") OR isdefined("get_certif")) AND isdefined("p_id")>
<cfsilent>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.lesson_start, l.lesson_end, l.lesson_id, l.lesson_duration, l.user_id, l.planner_id,
CONCAT(u1.user_firstname, " ", u1.user_name) as user_contact,
<cfif isdefined("get_certif")>
lc.certif_name,
lt.token_code,
</cfif>
u2.user_firstname as planner_contact,
ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name
FROM lms_lesson2 l
<cfif isdefined("get_certif")>
INNER JOIN lms_tpsession ts ON ts.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ts.sessionmaster_id
INNER JOIN lms_tp tp ON tp.tp_id = ts.tp_id
INNER JOIN lms_list_certification lc ON lc.certif_id = tp.certif_id
LEFT JOIN lms_list_token lt ON tp.token_id = lt.token_id
</cfif>
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
INNER JOIN user u1 ON l.user_id = u1.user_id
INNER JOIN user u2 ON l.planner_id = u2.user_id

WHERE 1=1

<cfif isdefined("p_id")>
AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfif>
<cfif isdefined("u_id")>
AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfif>
AND l.status_id != 3
</cfquery>

<cfset table_lesson = arraynew(1)>

<cfoutput query="get_lesson">

	<cfset temp = arrayAppend(table_lesson, structNew())>
	
	<!----ID ----->
	<cfset table_lesson[currentrow].id = lesson_id>
	
	<!----LESSON ID ----->
	<cfset table_lesson[currentrow].lesson_id = lesson_id>
	
	<!----PLANNER ID ----->
	<cfset table_lesson[currentrow].planner_id = planner_id>
	
	<!----USER ID ----->
	<cfset table_lesson[currentrow].user_id = user_id>
	
	<!----TITLE & COLOR ----->
	<cfset table_lesson[currentrow].textColor = "##000000">

	<cfif isdefined("get_certif")>
		<cfset table_lesson[currentrow].title = "<strong>[#certif_name#]</strong><br>#user_contact#">
		<cfif token_code neq "">
			<cfset table_lesson[currentrow].color = "##9db7cb">
		<cfelse>
			<cfset table_lesson[currentrow].color = "##FFA100">
		</cfif>
		
		<cfset table_lesson[currentrow].calendartype = "1">
	<cfelse>
		<cfset table_lesson[currentrow].title = "<strong>[SETUP]</strong><br>#user_contact#">
		<cfset table_lesson[currentrow].color = "##cbc49d">
		<cfset table_lesson[currentrow].calendartype = "2">
	</cfif>
	
	<!----START ----->
	<cfset table_lesson[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd")&"T"&TimeFormat(lesson_start,"HH:mm:ss")&"Z">
	
	<!----END ----->
	<cfset table_lesson[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd")&"T"&TimeFormat(lesson_end,"HH:mm:ss")&"Z">
	
	
</cfoutput>

<cfset table_js = SerializeJSON(table_lesson)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"USER_ID","user_id","ALL")>
<cfset table_js = replacenocase(table_js,"LESSON_ID","lesson_id","ALL")>
<cfset table_js = replacenocase(table_js,"PLANNER_ID","planner_id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"CALENDARTYPE","calendartype","ALL")>


</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>
















<!------------------------------GET GROUP LESSON ----------------------------->


<cfif isdefined("get_group_lesson")>
<cfsilent>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.*, 
sm.sessionmaster_name, sm.sessionmaster_id,
t.*,
m.method_name_#SESSION.LANG_CODE# as method_name, 
u2.user_firstname as planner_contact,
ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name
FROM lms_lesson2 l
INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
INNER JOIN lms_tpsession ts ON ts.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ts.sessionmaster_id
INNER JOIN lms_tp t ON t.tp_id = ts.tp_id
INNER JOIN user u2 ON l.planner_id = u2.user_id

WHERE 1=1

<cfif isdefined("p_id")>
AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfif>
<cfif isdefined("u_id")>
AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfif>
AND l.status_id != 3
</cfquery>

<cfset table_lesson = arraynew(1)>

<cfoutput query="get_lesson">

	<cfset temp = arrayAppend(table_lesson, structNew())>
	
	<!----ID ----->
	<cfset table_lesson[currentrow].id = lesson_id>
	
	<!----RESOURCE ID ----->
	<cfif isdefined("get_resource")><cfset table_lesson[currentrow].resourceid = planner_id></cfif>	
	
	<!----TITLE ----->
	<cfset table_lesson[currentrow].title = "<strong>#tp_name#</strong><br>#sessionmaster_name#">

	<!----SEATS ----->
	<cfset table_lesson[currentrow].seats_total = "6">

	
	<!----START ----->
	<cfset table_lesson[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd")&"T"&TimeFormat(lesson_start, "HH:mm:ss")&"Z">
	
	<!----COLOR ----->	
	<cfset table_lesson[currentrow].textColor = "##000000">
	
	<!--- <cfif level_alias eq "A1">
		<cfset table_lesson[currentrow].color = "##6BD098">
	</cfif> --->
	
	<!----END ----->	
	<cfset table_lesson[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd")&"T"&TimeFormat(lesson_end, "HH:mm:ss")&"Z">
	
	<!----EDITABLE ----->
	<cfset table_lesson[currentrow].editable = true>
	
	<!--- <cfset table_lesson[currentrow].allday = true> --->

	<!----CONSTRAINT ----->
	<!---<cfset table_lesson[currentrow].constraint = "trainer_available">--->
	
		<!---<cfif lesson_rendering neq ""><cfset table_lesson[currentrow].rendering = lesson_rendering></cfif>--->
	<!---<cfif lesson_end gt now()><cfset table_lesson[currentrow].editable = true></cfif>--->

	<!--- <cfset table_lesson[currentrow].test = "go"> --->
	
</cfoutput>

<cfset table_js = SerializeJSON(table_lesson)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"SEATS_TOTAL","seats_total","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEST","test","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
</cfif>




<!------------------------------GET VIRTUAL LESSON ----------------------------->


<cfif isdefined("get_virtual_lesson")>
	<cfsilent>
	
	<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT l.*, 
	sm.sessionmaster_name, sm.sessionmaster_id,
	t.*,
	m.method_name_#SESSION.LANG_CODE# as method_name, 
	u2.user_firstname as planner_contact,
	lla_v.subscribed,
	ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name,
	lv.level_css AS tplevel_css, lv.level_alias AS tplevel_alias, lv.level_color AS tplevel_color, lv.level_color_light AS tplevel_color_light, t.level_id AS tplevel_id,
	f.formation_id, f.formation_code
	FROM lms_lesson2 l
	LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id	
	LEFT JOIN lms_tpsession ts ON ts.session_id = l.session_id
	LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ts.sessionmaster_id	
	INNER JOIN lms_tp t ON t.tp_id = l.tp_id AND t.method_id = 10
	INNER JOIN lms_lesson_method m ON m.method_id = t.method_id
	INNER JOIN user u2 ON l.planner_id = u2.user_id
	LEFT JOIN lms_level lv ON lv.level_id = t.level_id
	LEFT JOIN lms_formation f ON f.formation_id = t.formation_id	
	
	LEFT JOIN lms_lesson2_attendance lla_v ON lla_v.lesson_id = l.lesson_id AND lla_v.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

	WHERE 1=1
	
	<cfif isdefined("p_id")>
	AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfif>
	<cfif isdefined("u_id")>
	AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfif>
	<cfif isdefined("tp_id")>
	AND t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	</cfif>
	AND l.status_id != 3
	</cfquery>
	
	
	
	<cfset table_lesson = arraynew(1)>
	
	<cfoutput query="get_lesson">

		<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(*) as nb
		FROM lms_lesson2_attendance la 
		LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
		WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
		AND subscribed = 1
		</cfquery>
	
		<cfset temp = arrayAppend(table_lesson, structNew())>
		
		<!----ID ----->
		<cfset table_lesson[currentrow].id = lesson_id>
		
		<!----RESOURCE ID ----->
		<cfif isdefined("get_resource")><cfset table_lesson[currentrow].resourceid = planner_id></cfif>	
		
		<!----TITLE ----->
		<cfset table_lesson[currentrow].title = "<strong>#ucase(tp_name)#</strong><br>#sessionmaster_name#">
	
		<!----SEATS ----->
		<cfif count_participant.nb neq "0">
			<cfset table_lesson[currentrow].seats_total = get_lesson.tp_max_participants>
			<cfset table_lesson[currentrow].seats_used = count_participant.nb>
			<cfset table_lesson[currentrow].seats_remaining = get_lesson.tp_max_participants-count_participant.nb>
		<cfelse>
			<cfset table_lesson[currentrow].seats_total = get_lesson.tp_max_participants>
			<cfset table_lesson[currentrow].seats_used = 0>
			<cfset table_lesson[currentrow].seats_remaining = get_lesson.tp_max_participants>
		</cfif>
		
		<!----PLANNER ID ----->
		<cfset table_lesson[currentrow].planner_id = "#planner_id#">

		<!----TP ID ----->
		<cfset table_lesson[currentrow].tp_id = "#tp_id#">
		
		<!----FORMATION ID ----->
		<cfset table_lesson[currentrow].formation_id = "#formation_id#">

		<!----TP ICON ----->
		<cfset table_lesson[currentrow].tp_icon = "#tp_icon#">

		<!----LEVEL ALIAS ----->
		<cfset table_lesson[currentrow].tplevel_alias = "#tplevel_alias#">

		<!----LEVEL CSS ----->
		<cfset table_lesson[currentrow].tplevel_css = "#tplevel_css#">
	
		<!----LEVEL CSS ----->
		<cfset table_lesson[currentrow].tplevel_color = "#tplevel_color#">

		<!----FORMATION CODE ----->
		<cfset table_lesson[currentrow].formation_code = "#lcase(formation_code)#">

		<!----START ----->
		<cfset table_lesson[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd")&"T"&TimeFormat(lesson_start, "HH:mm:ss")&"Z">
		
		<!----ALL DAY ----->
		<!--- <cfset table_lesson[currentrow].allday = true> --->
		
		<!----TIMEHOUR ----->
		<cfset table_lesson[currentrow].timehour = TimeFormat(lesson_start, "HH:mm")>

		<!----TIMEDAY ----->
		<cfset table_lesson[currentrow].timeday = dateFormat(lesson_start, "dd/mm")>

		<!----OUTDATED ----->
		<cfif lesson_start lt now()>
			<cfset table_lesson[currentrow].is_outdated = "1">
		<cfelse>
			<cfset table_lesson[currentrow].is_outdated = "0">
		</cfif>

		<!---- SUBSCRIBED ---->
		<cfif isdefined("is_subscribed")>
			<cfset table_lesson[currentrow].is_subscribed = "1">
		<cfelse>
			<cfset table_lesson[currentrow].is_subscribed = "0">
		</cfif>

		<cfloop list="A1,A2,B1,B2,C1" index="cor">
			<cfif isdefined("is_subscribed")>
				<cfif lesson_start lt now()>
					<cfset table_lesson[currentrow].color = "###tplevel_color_light#">
					<cfset table_lesson[currentrow].tp_color = "###tplevel_color_light#">
					<cfset table_lesson[currentrow].textColor = "##FFFFFF">
				<cfelse>
					<cfset table_lesson[currentrow].color = "###tplevel_color#">
					<cfset table_lesson[currentrow].tp_color = "###tplevel_color#">
					<cfset table_lesson[currentrow].textColor = "##FFFFFF">
				</cfif>
			<cfelse>
				<cfset table_lesson[currentrow].color = "##ECECEC">
				<cfset table_lesson[currentrow].tp_color = "##999999">
				<cfset table_lesson[currentrow].textColor = "##999999">
			</cfif>
		</cfloop>

		<!----END ----->	
		<cfset table_lesson[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd")&"T"&TimeFormat(lesson_end, "HH:mm:ss")&"Z">
		
		<!----EDITABLE ----->
		<cfset table_lesson[currentrow].editable = true>
		
		<!--- <cfset table_lesson[currentrow].allday = true> --->
	
		<!----CONSTRAINT ----->
		<!---<cfset table_lesson[currentrow].constraint = "trainer_available">--->
		
			<!---<cfif lesson_rendering neq ""><cfset table_lesson[currentrow].rendering = lesson_rendering></cfif>--->
		<!---<cfif lesson_end gt now()><cfset table_lesson[currentrow].editable = true></cfif>--->
	
		<!--- <cfset table_lesson[currentrow].test = "go"> --->
		
	</cfoutput>
	
	<cfset table_js = SerializeJSON(table_lesson)>
	<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
	<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
	<cfset table_js = replacenocase(table_js,"SEATS_TOTAL","seats_total","ALL")>
	<cfset table_js = replacenocase(table_js,"SEATS_USED","seats_used","ALL")>
	<cfset table_js = replacenocase(table_js,"SEATS_REMAINING","seats_remaining","ALL")>
	<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
	<cfset table_js = replacenocase(table_js,"START","start","ALL")>
	<cfset table_js = replacenocase(table_js,"END","end","ALL")>
	<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
	<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
	<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
	<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
	<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
	<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
	<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
	<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
	<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
	<cfset table_js = replacenocase(table_js,"RESOURCEid","resourceId","ALL")>
	<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
	<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
	<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
	<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>
	<cfset table_js = replacenocase(table_js,"PLANNER_ID","planner_id","ALL")>
	<cfset table_js = replacenocase(table_js,"TP_ID","tp_id","ALL")>
	<cfset table_js = replacenocase(table_js,"TPLEVEL_CSS","tplevel_css","ALL")>
	<cfset table_js = replacenocase(table_js,"TPLEVEL_ALIAS","tplevel_alias","ALL")>
	<cfset table_js = replacenocase(table_js,"TIMEHOUR","timehour","ALL")>
	<cfset table_js = replacenocase(table_js,"TIMEDAY","timeday","ALL")>
	<cfset table_js = replacenocase(table_js,"FORMATION_CODE","formation_code","ALL")>
	<cfset table_js = replacenocase(table_js,"IS_SUBSCRIBED","is_subscribed","ALL")>
	<cfset table_js = replacenocase(table_js,"IS_OUTDATED","is_outdated","ALL")>
	<cfset table_js = replacenocase(table_js,"TP_ICON","tp_icon","ALL")>
	<cfset table_js = replacenocase(table_js,"TP_COLOR","tp_color","ALL")>
	<cfset table_js = replacenocase(table_js,"FORMATION_ID","formation_id","ALL")>
	
	</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>
	</cfif>
