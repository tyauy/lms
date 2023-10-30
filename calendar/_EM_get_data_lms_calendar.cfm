<!------------------------------CHANGE KEYS HERE IF NEEDED ----------------------------->
<cfset keys={ 

"CREATED_AT":"created_at",
"UPDATED_AT":"updated_at",
"BUFFER_TIME":"buffer_time",
"SPECIFIC_DATE":"specific_time",
"STATUS":"status", 
"REPEAT_TYPE":"repeat_type", 
"DAYSOFWEEK":"daysOfWeek",
"ID" :"id", 
"TITLE" :"title", 
"ALLDAY" :"allDay", 
"START" :"start", 
"END" :"end", 
"URL" :"url", 
"CLASSNAME" :"className", 
"EDITABLE" :"editable", 
"STARTEDITABLE" :"startEditable", 
"DURATIONEDITABLE" :"durationEditable", 
"RESOURCEEDITABLE" :"resourceEditable", 
"RENDERING" :"rendering", 
"OVERLAP" :"overlap", 
"CONSTRAINT" :"constraint", 
"RESOURCEid" :"resourceId", 
"COLOR" :"color", 
"BACKGROUNDCOLOR" :"backgroundColor", 
"BORDERCOLOR" :"borderColor", 
"TEXTCOLOR" :"textColor", 
"TEST" :"test", 
"PROFILE_NAME" :"profile_name", 
"TASK_GROUP_ALIAS" :"task_group_alias", 
"SEATS_TOTAL" :"seats_total", 
"SEATS_USED" :"seats_used", 
"SEATS_REMAINING" :"seats_remaining", 
"PLANNER_ID" :"planner_id", 
"TP_ID" :"tp_id", 
"TPLEVEL_CSS" :"tplevel_css", 
"TPLEVEL_ALIAS" :"tplevel_alias", 
"TIMEHOUR" :"timehour", 
"TIMEDAY" :"timeday", 
"FORMATION_CODE" :"formation_code", 
"IS_SUBSCRIBED" :"is_subscribed", 
"IS_OUTDATED" :"is_outdated", 
"TP_ICON" :"tp_icon", 
"TP_COLOR" :"tp_color", 
"FORMATION_ID" :"formation_id", 
"EVENTTEXTCOLOR" :"eventTextColor", 
"HOLIDAY_ISVALIDATED" :"holiday_isvalidated", 
"P_ID" :"p_id", 
"WEEK_DAY" :"week_day" }>

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
                        AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                    </cfif>
                    <cfif isdefined("u_id")>
                        AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                    </cfif>
                    AND l.status_id != 3
                    group by l.lesson_id
                </cfquery>

                <cfset table_lesson=arraynew(1)>

                    <cfoutput query="get_lesson">

                        <cfset temp=arrayAppend(table_lesson, structNew())>

                            <!----ID ----->
                            <cfset table_lesson[currentrow].id=lesson_id>

                                <!----RESOURCE ID ----->
                                <cfif isdefined("get_resource")>
                                    <cfset table_lesson[currentrow].resourceid=planner_id>
                                </cfif>

                                <!----TITLE ----->

                                <cfset table_lesson[currentrow].title="[#lesson_duration#m]">

                                    <!--- eventTextColor --->
                                    <cfset table_lesson[currentrow].eventTextColor="##000000">
                                        <cfset table_lesson[currentrow].textColor="##000000">

                                            <!----START ----->
                                            <cfset table_lesson[currentrow].start=dateformat(lesson_start, "yyyy-mm-dd" )&"T"&TimeFormat(lesson_start, "HH:mm:ss" )&"Z">

                                                <!----COLOR ----->

                                                <cfif status_id eq "1">
                                                    <cfif sessionmaster_id eq "769">
                                                        <cfset table_lesson[currentrow].color="##9e5bd6">
                                                            <cfelse>
                                                                <cfif method_id eq 11>
                                                                    <cfset table_lesson[currentrow].color="##da5196">
                                                                        <cfelseif method_id eq 10>
                                                                            <cfset table_lesson[currentrow].color="##da5196">
                                                                                <cfelse>
                                                                                    <cfset table_lesson[currentrow].color="##FBC658">
                                                                </cfif>
                                                    </cfif>
                                                    <cfelseif status_id eq "2">
                                                        <cfset table_lesson[currentrow].color="##51BCDA">
                                                            <cfelseif status_id eq "3">
                                                                <cfset table_lesson[currentrow].color="##EF8157">
                                                                    <cfelseif status_id eq "4">
                                                                        <cfset table_lesson[currentrow].color="##EF8157">
                                                                            <cfelseif status_id eq "5">
                                                                                <cfset table_lesson[currentrow].color="##6BD0C6">
                                                                                    <cfelseif status_id eq "6">
                                                                                        <cfset table_lesson[currentrow].color="##6BD0C6">
                                                </cfif>

                                                <!----END ----->
                                                <cfset table_lesson[currentrow].end=dateformat(lesson_end, "yyyy-mm-dd" )&"T"&TimeFormat(lesson_end, "HH:mm:ss" )&"Z">

                                                    <!----EDITABLE ----->
                                                    <cfset table_lesson[currentrow].editable=false>



                    </cfoutput>
                    <cfset table_js=SerializeJSON(table_lesson)>

                        <cfloop item="key" collection="#keys#">
                            <cfset table_js=replacenocase(table_js,key,keys[key],"ALL")>
                        </cfloop>
            </cfsilent>
            <cfoutput>#table_js#</cfoutput>
            <cfabort>
        </cfif>
        <!---- GET SLOTS---->
        <cfif isDefined("get_slots") or (isDefined("URL.get_slots") AND URL.get_slots EQ 1 and isDefined("URL.p_id"))>
            <cfquery name="getSlots" datasource="#SESSION.BDDSOURCE#">
                SELECT u.user_id,u.user_gender, u.user_firstname,u.user_name, u.user_email, us.planner_id, us.slot_id, us.slot_start, us.slot_end
                FROM user_slots us
                left join user u on us.planner_id=u.user_id
                WHERE planner_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer"> AND
                    WEEK(slot_start) = WEEK(<cfqueryparam value="#weekdate#" cfsqltype="cf_sql_date">) AND
                    YEAR(slot_start) = YEAR(<cfqueryparam value="#weekdate#" cfsqltype="cf_sql_date">)
                ORDER BY slot_start ASC;
            </cfquery>
            <cfdump var="getSlots">
            <cfset table_gs=arraynew(1)>
            <cfoutput query="getSlots">

                <cfset temp=arrayAppend(table_gs, structNew())>

                    <!----ID ----->
                    <cfset table_gs[currentrow].id=slot_id>


                        <!----PLANNER ID ----->
                        <cfset table_gs[currentrow].p_id=planner_id>


                            <!----TITLE ----->
                            <cfset table_gs[currentrow].title="Working Hours">

                                <!--- COLOR --->
                                <cfset table_gs[currentrow].textColor="##000000">

                                    <!----START ----->
                                    <cfset table_gs[currentrow].start=TimeFormat(slot_start, "HH:mm" )>


                                        <cfset table_gs[currentrow].color="##00BFFF">

                                            <!----END ----->
                                            <cfset table_gs[currentrow].end=TimeFormat(slot_end, "HH:mm" )>

                                           
                                                <!----WEEKDAY ----->
                                                    <cfset dow = DayOfWeek(slot_start)>
                                                    <cfset table_gs[currentrow].daysOfWeek = (dow eq 1) ? 6 : dow - 1>

                                              <!---   <!----Status ----->
                                                <cfset table_gs[currentrow].status = status>
                                                
                                                 <!----created_at ----->
                                                 <cfset table_gs[currentrow].created_at = created_at> --->
                                             
                                              


            </cfoutput>

            <cfset table_js=SerializeJSON(table_gs)>

                <cfloop item="key" collection="#keys#">
                    <cfset table_js=replacenocase(table_js,key,keys[key],"ALL")>
                </cfloop>

   
    <cfcontent type="application/json; charset=utf-8">

    <cfoutput>#table_js#</cfoutput>
    <cfabort>
        </cfif>
        <!--------------------- GET WORKINGH ----------------------------->
        <cfif isDefined("get_working_hours") or (isDefined("URL.fetch_working_hours") AND URL.fetch_working_hours EQ 1 and isDefined("URL.p_id"))>
            <cfsilent>
                <cfquery name="get_working_hours" datasource="#SESSION.BDDSOURCE#">
                    SELECT *
                    FROM user_business_hours
                    WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">
                    ORDER BY week_day, start_time
                </cfquery>

                <cfset table_wh=arraynew(1)>

                    <cfoutput query="get_working_hours">

                        <cfset temp=arrayAppend(table_wh, structNew())>

                            <!----ID ----->
                            <cfset table_wh[currentrow].id=id>


                                <!----PLANNER ID ----->
                                <cfset table_wh[currentrow].p_id=p_id>


                                    <!----TITLE ----->
                                    <cfset table_wh[currentrow].title="Working Hours">

                                        <!--- COLOR --->
                                        <cfset table_wh[currentrow].textColor="##000000">

                                            <!----START ----->
                                            <cfset table_wh[currentrow].start=TimeFormat(start_time, "HH:mm" )>


                                                <cfset table_wh[currentrow].color="##00BFFF">

                                                    <!----END ----->
                                                    <cfset table_wh[currentrow].end=TimeFormat(end_time, "HH:mm" )>

                                                        <!----WEEKDAY ----->
                                                        <cfset table_wh[currentrow].daysOfWeek = [week_day]>
                                                        <!----Status ----->
                                                        <cfset table_wh[currentrow].status = status>
                                                        <!----repeat type ----->
                                                        <cfset table_wh[currentrow].repeat_type = repeat_type>
                                                         <!----created_at ----->
                                                         <cfset table_wh[currentrow].created_at = created_at>
                                                     
                                                        <!----specific_date ----->
                                                        <cfset table_wh[currentrow].specific_date = TimeFormat(specific_date, "DD:mm" )>
                                                          


                    </cfoutput>

                    <cfset table_js=SerializeJSON(table_wh)>

                        <cfloop item="key" collection="#keys#">
                            <cfset table_js=replacenocase(table_js,key,keys[key],"ALL")>
                        </cfloop>

            </cfsilent>
            <cfcontent type="application/json; charset=utf-8">

            <cfoutput>#table_js#</cfoutput>
            <cfabort>
        </cfif>

        <!--------------------- GET holiday ----------------------------->
        <cfif isdefined("get_holidays")>
            <cfsilent>

                <cfquery name="get_holidays" datasource="#SESSION.BDDSOURCE#">
                    SELECT id, holiday_isvalidated, start_date, end_date
                    FROM user_holidays
                    WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">

                </cfquery>

                <cfset table_holiday=arraynew(1)>

                    <cfoutput query="get_holidays">

                        <cfset temp=arrayAppend(table_holiday, structNew())>

                            <!----ID ----->
                            <cfset table_holiday[currentrow].id=id>

                                <!----VALIDATED ----->
                                <cfset table_holiday[currentrow].holiday_isvalidated=holiday_isvalidated>
                                    <!----PLANNER ID ----->
                                    <cfset table_holiday[currentrow].p_id=p_id>


                                        <!----TITLE ----->
                                        <cfset table_holiday[currentrow].title="VACATION">

                                            <!--- COLOR --->
                                            <cfset table_holiday[currentrow].textColor="##000000">

                                                <!----START ----->
                                                <cfset table_holiday[currentrow].start=dateformat(start_date, "yyyy-mm-dd" )>


                                                    <cfset table_holiday[currentrow].color="##00BFFF">

                                                        <!----END ----->
                                                        <cfset table_holiday[currentrow].end=dateformat(end_date, "yyyy-mm-dd" )>


                    </cfoutput>

                    <cfset table_js=SerializeJSON(table_holiday)>

                        <cfloop item="key" collection="#keys#">
                            <cfset table_js=replacenocase(table_js,key,keys[key],"ALL")>
                        </cfloop>

            </cfsilent>
            <cfoutput>#table_js#</cfoutput>
            <cfabort>
        </cfif>
        <!--- 
<!--------------------- GET HOLIDAY ----------------------------->
        <cfif isDefined("p_id")>
            <cfquery name="get_holidays" datasource="#SESSION.BDDSOURCE#">
                SELECT id, start_date, end_date, holiday_isvalidated
                FROM user_holidays
                WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
        <cfif isdefined("get_holidays")>
            <cfset table_holiday=StructNew()>
                <cfset array_holiday=getData(get_holidays, table_holiday,"##000000", "VACATION" , "##87CEEB" , "icon" , false, get_holidays.id, "go" , get_holidays.start_date, get_holidays.end_date, get_holidays.holiday_isvalidated)>
                    <!--- <cfset test =getData(query,table,textColor,title,color,tp_icon,formation_id,tp_id,seats_total,seats_used,seats_remaining,tplevel_alias,tplevel_css,tplevel_color,formation_code,timehour,timeday,user_id,lesson_id,editable,rendering,b_id)> --->
                    <cfloop array="#array_holiday#" item="struct">
                        <cfset newStruct=structNew()>
                            <cfloop list="#structKeyList(struct)#" index="oldKey">
                                <cfset newKey=lcase(oldKey)>
                                    <cfset value=struct[oldKey]>
                                        <cfset newStruct[newKey]=value>
                            </cfloop>
                            <cfset arrayAppend(array_holiday, newStruct)>
                    </cfloop>
                    <cfset json_holiday=serializeJSON(array_holiday)>
                        <cfoutput>#json_holiday#</cfoutput>
                        <cfabort>
        </cfif>

        <cffunction name="getData" access="public" returntype="array" output="false" hint="Executes query, creates struct, populates data">
            <cfargument name="query" type="query" required="true" hint="The query to be executed">
                <cfargument name="table" type="struct" required="true" hint="The struct to hold data">
                    <cfargument name="textColor" type="string" required="false" default="##000000" hint="The text color for the event">
                        <cfargument name="title" type="string" required="false" default="BLOCKER" hint="The title for the event">
                            <cfargument name="color" type="string" required="false" default="##D9D9D9" hint="The color for the event">
                                <cfargument name="icon" type="string" required="false" default="" hint="The icon for the event">
                                    <cfargument name="editable" type="string" required="false" default="" hint="The editable thruty for the event">
                                        <cfargument name="id" type="string" required="false" default="" hint="The id  for the event">
                                            <cfargument name="test" type="string" required="false" default="" hint="The test type for the event">
                                                <cfargument name="start_date" type="string" required="false" default="" hint="The test type for the event">
                                                    <cfargument name="end_date" type="string" required="false" default="" hint="The test type for the event">
                                                        <cfargument name="holiday_isvalidated" type="numeric" required="false" default=0 hint="The test type for the event">

                                                            <cfset data=[]>
                                                                <cfdump var="#arguments.query#">
                                                                    <cfoutput query="arguments.query">
                                                                        <cfset temp={}>
                                                                            <cfset temp.p_id=p_id>
                                                                                <cfset temp.title=arguments.title>
                                                                                    <cfset temp.textColor=arguments.textColor>
                                                                                        <cfset temp.start=dateformat(start_date, "yyyy-mm-dd" )&"T"&TimeFormat(start_date, "HH:mm:ss" )&"Z">
                                                                                            <cfset temp.color=arguments.color>
                                                                                                <cfset temp.end=dateformat(end_date, "yyyy-mm-dd" )&"T"&TimeFormat(end_date, "HH:mm:ss" )&"Z">
                                                                                                    <cfset temp.icon=arguments.icon>
                                                                                                        <cfset temp.editable=arguments.editable>
                                                                                                            <cfset temp.id=arguments.id>
                                                                                                                <cfset temp.holiday_isvalidated=arguments.holiday_isvalidated>
                                                                                                                    <cfset temp.test=arguments.test>
                                                                                                                        <cfif isdefined("get_resource")>
                                                                                                                            <cfset temp.resourceid=planner_id>
                                                                                                                        </cfif>

                                                                                                                        <cfset arrayAppend(data, temp)>
                                                                    </cfoutput>
                                                                    <cfreturn data>
        </cffunction> --->