
<!--- RETRIEVE TP DETAILS--->
<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>	
<cfset f_id = get_tp.formation_id>
<cfset f_code = get_tp.formation_code>

<!--- RETRIEVE USER DETAILS--->
<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.account_id, u.user_qpt_#ucase(f_code)# as user_qpt, u.user_needs_nbtrainer, u.avail_id, u.user_needs_speaking_id,
    u.user_type_id,
    a.provider_id,
    up.profile_name as user_profile 
    FROM user u 
    INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
    INNER JOIN account a ON a.account_id = u.account_id
    INNER JOIN user_profile up ON up.profile_id = upc.profile_id
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>

<cfset a_id = get_user.account_id>	

<!--- DEFINE LANGUAGE LIST AND IDS--->
<cfset list_lang = "fr,en,de,es">
<cfset list_lang_id = "1,2,3,4">

<!--- CHECK IF USER HAS A PT RESULT--->
<!--- <cfif get_user.user_qpt neq "">
    <cfset u_level = get_user.user_qpt>
    <cfset u_level_letter = mid(u_level,1,1)>
    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_level#">
    </cfquery>
    <cfset level_criteria_id = get_level.level_id>
<cfelse>
    <cfset u_level = "N/A">
    <cfset u_level_letter = "N/A">
    <cfset level_criteria_id = 0>
</cfif> --->
<cfif StructKeyExists(SESSION.USER_LEVEL,'#f_code#')>
    <cfset u_level = SESSION.USER_LEVEL['#f_code#'].level_code>
    <cfset u_level_letter = mid(SESSION.USER_LEVEL['#f_code#'].level_code,1,1)>
    <cfset level_criteria_id = SESSION.USER_LEVEL['#f_code#'].level_id>
<cfelse>
    <cfset u_level = "N/A">
    <cfset u_level_letter = "N/A">
    <cfset level_criteria_id = 0>
</cfif>

<!--- ASSIGN CSS CLASSES BASED ON USER'S PT RESULT--->
<cfif u_level_letter eq "A">
    <cfset level_css = "success">
<cfelseif u_level_letter eq "B">
    <cfset level_css = "info">
<cfelseif u_level_letter eq "C">
    <cfset level_css = "danger">
<cfelse>
    <cfset level_css = "info">
</cfif>

<!--- SET DEFAULT VALUES--->
<cfparam name="user_needs_speaking_id" default="0">
<cfparam name="s" default="0">

<cfparam name="speaking_criteria_id" default="0">
<cfparam name="speaking_criteria_code" default="">
<cfparam name="display" default="video">
<cfparam name="user_needs_nbtrainer" default="0">
<cfif step eq "3">
    <!------- RECORD SESSION FROM MODAL ------>
 <!---    <cfif SESSION.USER_NEEDS_NBTRAINER neq "">
        <cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER>
    <cfelseif not isDefined("user_needs_nbtrainer")>
        <cfset user_needs_nbtrainer = 0>
    </cfif>
 --->
    <!--- CHECK IF USER AVAIL IS DEFINED, IF NOT SET TO ALL AVAILS--->
    <cfif not isDefined("avail_id") OR avail_id eq "">
        <cfif SESSION.AVAIL_ID neq "">
            <cfset avail_id = SESSION.AVAIL_ID>
        <cfelse>
            <cfset avail_id = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28">
        </cfif>
    </cfif>

    <!--- SET LANG CRITERIA IF NOT ALREADY SET--->
    <cfif SESSION.USER_NEEDS_SPEAKING_ID neq "" AND speaking_criteria_id eq 0>
        <cfset speaking_criteria_id = SESSION.USER_NEEDS_SPEAKING_ID>
    </cfif>
<cfelse>
    <cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
    <!--- <cfset user_needs_speaking_id = get_user.user_needs_speaking_id> --->
    <cfset avail_id = get_user.avail_id>
    <cfset speaking_criteria_id = get_user.user_needs_speaking_id eq "" ? "0" : get_user.user_needs_speaking_id>
    <cfif avail_id eq "">
        <cfset avail_id = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28">
    </cfif>
</cfif>

<cfset user_type_id = get_user.user_type_id>
<cfset user_profile = get_user.user_profile>
<cfset provider_id = get_user.provider_id>


<cfset teaching_criteria_id = f_id>
<cfset teaching_criteria_code = f_code>

<cftry>
    <cfif speaking_criteria_id neq "0" AND speaking_criteria_id neq "">
        <cfset speaking_criteria_code = listgetat(list_lang,speaking_criteria_id)>
    </cfif>
    <cfcatch type="any">
    </cfcatch>
</cftry>


<cfquery name="get_speaking_available" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name, formation_code FROM lms_formation WHERE formation_id IN (#list_lang_id#)
</cfquery>

<!------ CREATE AN AVAIL LIST OF HOUR WANTED BY THE LEARNER ----->
<!--- <cfif isdefined("avail_id")> --->
    <cfquery name="get_avail" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM user_availability WHERE avail_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#avail_id#" list="true">)
    </cfquery>

    <cfset delta_quarter = CreateTimeSpan(0,0,15,0)>
    <cfset criteria_hour_list = "">

    <cfoutput>
        <cfloop query="get_avail">
            <cfloop index="dtTime" from="#hour_start#" to="#hour_end#" step="#delta_quarter#">
                <cfset criteria_hour_list = listappend(criteria_hour_list,"#ucase(avail_day)# #TimeFormat(dtTime,'HH:mm')#")>
                <!--- #avail_day# - #TimeFormat( dtTime, "hh:mm TT" )#<br /> --->
            </cfloop>
        </cfloop>
    </cfoutput>

<!--- </cfif> --->

<!--- CREATE AN ARRAY FOR STORING VALUES --->
<cfset array_t = ArrayNew(1)>


<cfset array_t_attached = "">

<!--- CREATE A LIST WITH TRAINER ALREADY SELECTED --->
<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#get_tp.tp_id#")>
<!--- <cfdump var="#tp_trainer#"> --->
<cfloop query="tp_trainer">
    <cfset array_t_attached = listAppend(array_t_attached, planner_id, ',')>
</cfloop>

<!--- <cfdump var="#array_t_attached#"> --->

<!------ LAUNCH A FIRST QUERY WITH FIXED CRITERAS ----->
<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
    SELECT u.user_id, u.user_add_weight

    FROM user u
    LEFT JOIN settings_country c ON c.country_id = u.country_id
    LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
    LEFT JOIN user_ready ur ON u.user_id = ur.user_id AND ur.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#">
    INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = 4
    
    <!---- PROFIL TRAINER, ACTIVE --->
    WHERE u.user_status_id = 4

    <!---- VISIO --->
    AND FIND_IN_SET(1,method_id)


    <!---- NOT ALREADY ATTACHED --->
    AND u.user_id NOT IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#array_t_attached#" list="true">)



    <!---- READY TO TAKE TEST L --->
    <cfif user_profile eq "test">
    AND ur.user_ready_test = 1
    
    <!---- READY TO TAKE NEW L --->
    <cfelseif user_profile eq "learner">
    
    <cfif provider_id eq "2">
    AND ur.user_ready_germany = 1
    <cfelse>
    AND ur.user_ready_france = 1
    </cfif> 
        

        <!---<cfif a_id eq "346" 
        OR a_id eq "351"
        OR a_id eq "47"
        OR a_id eq "239"
        OR a_id eq "432"
        OR a_id eq "86"
        OR a_id eq "87"
        OR a_id eq "623"
        OR a_id eq "624"
        OR a_id eq "673"
        OR a_id eq "674"
        OR a_id eq "675"
        OR a_id eq "732">
            AND ur.user_ready_b2c = 1
        <cfelse>
            AND ur.user_ready_b2b = 1
        </cfif>--->
    
    </cfif>

    <cfif (u_level eq "A0" OR u_level eq "A1" OR u_level eq "A2") AND teaching_criteria_id eq 2>
        <!---- SPOKEN LANGUAGE --->
        <cfif speaking_criteria_id neq "0" AND speaking_criteria_id neq "">
            AND u.user_id IN (SELECT user_id FROM user_speaking WHERE (formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#speaking_criteria_id#">))
        </cfif>
    </cfif>
    
    <!---- TAUGHT LANGUAGE --->
    <cfif teaching_criteria_id neq "0" AND teaching_criteria_id neq "">
        AND u.user_id IN (SELECT user_id FROM user_teaching WHERE (formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#teaching_criteria_id#"> <cfif level_criteria_id neq "0" AND level_criteria_id neq "">AND FIND_IN_SET(#level_criteria_id#,level_id)</cfif>))
    </cfif>


    <!---- REMOVE FAKE TRAINERS --->
    AND u.user_id <> 2656 AND u.user_id <> 4784 AND u.user_id <> 4785 AND u.user_id <> 201

    <!---- TRAINER WHO ACCEPT THIS TYPE OF USER --->
    <cfif user_type_id eq 4>
        AND ur.user_ready_tm = 1
    <cfelseif user_type_id eq 5>
        AND ur.user_ready_vip = 1
    <cfelseif user_type_id eq 6>
        AND ur.user_ready_children = 1
    <cfelse>
        AND ur.user_ready_classic = 1
    </cfif>
</cfquery>

<!--- ! OL COND --->
<cfif teaching_criteria_id eq 2>

    <!--- MATCH THE T LIST WITH L LIST AND DEFINE ORDER --->
    <cfoutput query="get_trainer">

                <!---- OBJ QUERIES ---->
                <cfinvoke component="api/trainerscal/weektype_get" method="get_trainer_businesshour" returntype="any" returnvariable="get_trainer_businesshour">
                    <cfinvokeargument name="u_id" value="#user_id#">
                </cfinvoke>
            
            <!--- Create a list of weekday strings --->
        <cfset weekdays = "SUN,MON,TUE,WED,THU,FRI,SAT">

        <!--- BUILD A LIST WORKING HOURS --->
        <cfset trainer_hour_list = "">
        <cfif get_trainer_businesshour.recordcount neq "0">
            <cfloop query="get_trainer_businesshour">
                <!--- Get the weekday string corresponding to the numeric weekday value --->
                <cfset weekday_str = listGetAt(weekdays, get_trainer_businesshour.week_day + 1)>

                <!--- Now you can compare weekday_str with SESSION.DAYWEEK_EN --->
                <cfif listFind(SESSION.DAYWEEK_EN, weekday_str)>
                    <cfloop index="dtTime" from="#get_trainer_businesshour.start_time#" to="#get_trainer_businesshour.end_time#" step="#delta_quarter#">
                        <cfset trainer_hour_list = listappend(trainer_hour_list,"#weekday_str# #TimeFormat(dtTime,'HH:mm')#")>
                    </cfloop>
                </cfif>
            </cfloop>
        <cfdump var="#trainer_hour_list#" ><br><br>
            <!--- COMPARE LIST AND AFFECT SCORE --->
            <cfset max_stat = 0>
            <cfloop list="#criteria_hour_list#" index="cor">
                <cfif listfind(trainer_hour_list,cor)>
                    <cfset max_stat ++>
                </cfif>
            </cfloop>
        </cfif>
        <cfset score_accuracy = round((max_stat/listlen(criteria_hour_list))*100)>

        <!---- CALCULATE GLOBAL NB HOUR A WEEK--->
        <cfset h_business = 0>
        <cfloop query="get_trainer_businesshour">
            <cfset weekday_str = listGetAt(weekdays, get_trainer_businesshour.week_day + 1)>
            <cfif listFind(SESSION.DAYWEEK_EN, weekday_str)>
                <cfset h_diff = datediff('h', get_trainer_businesshour.start_time, get_trainer_businesshour.end_time)>
                <cfset h_business = h_business + h_diff>
            </cfif>
        </cfloop>
        <cfdump var="#h_business#" >

        <!---- CALCULATE ACTIVITY--->
        <cfquery name="get_slot" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(slot_end) - TIME_TO_SEC(slot_start)) as s_avail
            FROM user_slots 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND YEAR(slot_start) = YEAR(CURDATE())
            AND WEEK(slot_start) = WEEK(CURDATE())
        </cfquery>

        <cfquery name="get_lesson_week" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_activity 
            FROM lms_lesson2 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND (status_id <> 3 AND status_id IS NOT NULL)
            AND YEAR(lesson_start) = YEAR(CURDATE())
            AND WEEK(lesson_start) = WEEK(CURDATE())
        </cfquery>

        <cfquery name="get_blocker_week" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_blocker
            FROM lms_lesson2 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND status_id IS NULL
            AND YEAR(lesson_start) = YEAR(CURDATE())
            AND WEEK(lesson_start) = WEEK(CURDATE())
        </cfquery>

        <!--- IF NO ACTIVITY SET ACTIVITY AT 0 --->
        <cfif get_lesson_week.s_activity eq "">
            <cfset s_activity = 0>
        <cfelse>
            <cfset s_activity = get_lesson_week.s_activity>
        </cfif>
        <!--- <br> --->
    <!--- <cfif SESSION.USER_PROFILE eq "test"> --->
    <!--- #user_id#<br> --->
    <!--- s_activity = #s_activity#<br> --->
    <!--- get_slot.s_avail = #get_slot.s_avail#<br> --->
    <!--- h_business = #h_business#<br><br> --->
    <!--- </cfif> --->

        <!--- IF VARIABLES ARE SET CORRECTLY --->
        <cfif h_business neq "" AND get_slot.s_avail neq "">
            <cfset h_business = h_business/3600>
            <cfset h_slot = get_slot.s_avail/3600>
            
            <!--- <cfif get_lesson_week.s_activity neq ""> --->
                <cfset h_activity = s_activity/3600>
                <cfset h_activity_rate = round((h_activity/h_slot)*100)>
            <!--- <cfelse> --->
                <!--- <cfset h_activity = 0> --->
                <!--- <cfset h_activity_rate = "-"> --->
            <!--- </cfif> --->
            <cfif get_blocker_week.s_blocker neq "">
                <cfset h_blocker = get_blocker_week.s_blocker/3600>
                <cfset h_blocker_rate = round((h_blocker/h_slot)*100)>
            <cfelse>
                <cfset h_blocker = 0>
                <cfset h_blocker_rate = "-">
            </cfif>
            <cfset score_charge = (100-round((h_activity+h_blocker)/h_slot*100))>
            
            <cfset score_global = round(((score_charge)+score_accuracy)/2)>

            <cfif get_trainer.user_add_weight neq "">
                <cfset score_global = score_global + get_trainer.user_add_weight>
            </cfif>

            <cfif score_global gte 10>
            <!--- BUILD NEW STRUCTURE IN ARRAY, IF AT LEAST ONE SCORE POSITIVE --->
            <cfif <!---score_charge gt 0 AND --->score_accuracy gt 0>
                <cfset arrayAppend(array_t, structNew())>

                <cfset array_t[arraylen(array_t)].planner_id = user_id> 
                <cfset array_t[arraylen(array_t)].score_accuracy = score_accuracy> 
                <cfset array_t[arraylen(array_t)].h_business = h_business>
                <cfset array_t[arraylen(array_t)].h_slot = h_slot>
                <cfset array_t[arraylen(array_t)].h_activity = h_activity>
                <cfset array_t[arraylen(array_t)].h_activity_rate = h_activity_rate>
                <cfset array_t[arraylen(array_t)].h_blocker = h_blocker>
                <cfset array_t[arraylen(array_t)].h_blocker_rate = h_blocker_rate>
                <cfset array_t[arraylen(array_t)].score_charge = score_charge>
                <cfset array_t[arraylen(array_t)].score_global = score_global>
            </cfif>
            </cfif>
            
        <cfelse>
                
            
            <cfset arrayAppend(array_t, structNew())>

            <cfset array_t[arraylen(array_t)].planner_id = user_id> 
            <cfset array_t[arraylen(array_t)].score_accuracy = 0> 
            <cfset array_t[arraylen(array_t)].h_business = 0>
            <cfset array_t[arraylen(array_t)].h_slot = 0>
            <cfset array_t[arraylen(array_t)].h_activity = 0>
            <cfset array_t[arraylen(array_t)].h_activity_rate = 0>
            <cfset array_t[arraylen(array_t)].h_blocker = 0>
            <cfset array_t[arraylen(array_t)].h_blocker_rate = 0>
            <cfset array_t[arraylen(array_t)].score_charge = 0>
            <cfset array_t[arraylen(array_t)].score_global = 0>
            
        </cfif>




    </cfoutput>



    <!--- SMART SORTING FOR ARRAY OF T --->
    <cfset array_t = obj_function.arrayOfStructsSort(array_t,"score_global","asc")>


    <!--- <cfset array_t = arrayOfStructsSort(array_t,"score_charge","asc")> --->
    <!--- <cfset array_t = arrayOfStructsSort(array_t,"score_accuracy","desc")> --->

    <!--- BUILD A LIST FOR ORDERING GET TRAINER 2ND QUERY --->
    <cfset t_list = "">
    <cfloop array="#array_t#" index="item">
        <cfset t_list = listappend(t_list,item.planner_id)>
    </cfloop>


<!--- ! OL --->
<cfelse>

    
    <cfoutput query="get_trainer">
        <!---- OBJ QUERIES ---->
        <cfinvoke component="api/trainerscal/weektype_get" method="get_trainer_businesshour" returntype="any" returnvariable="get_trainer_businesshour">
            <cfinvokeargument name="u_id" value="#user_id#">
        </cfinvoke>
      
       <!--- Create a list of weekday strings --->
        <cfset weekdays = "SUN,MON,TUE,WED,THU,FRI,SAT">

            <!--- BUILD A LIST WORKING HOURS --->
            <cfset trainer_hour_list = "">
            <cfif get_trainer_businesshour.recordcount neq "0">
                <cfloop query="get_trainer_businesshour">
                    <!--- Get the weekday string corresponding to the numeric weekday value --->
                    <cfset weekday_str = listGetAt(weekdays, get_trainer_businesshour.week_day + 1)>

                    <!--- Now you can compare weekday_str with SESSION.DAYWEEK_EN --->
                    <cfif listFind(SESSION.DAYWEEK_EN, weekday_str)>
                        <cfloop index="dtTime" from="#get_trainer_businesshour.start_time#" to="#get_trainer_businesshour.end_time#" step="#delta_quarter#">
                            <cfset trainer_hour_list = listappend(trainer_hour_list,"#weekday_str# #TimeFormat(dtTime,'HH:mm')#")>
                        </cfloop>
                    </cfif>
                </cfloop>
            <cfdump var="#trainer_hour_list#" ><br><br>
                <!--- COMPARE LIST AND AFFECT SCORE --->
                <cfset max_stat = 0>
                <cfloop list="#criteria_hour_list#" index="cor">
                    <cfif listfind(trainer_hour_list,cor)>
                        <cfset max_stat ++>
                    </cfif>
                </cfloop>
            </cfif>
            <cfset score_accuracy = round((max_stat/listlen(criteria_hour_list))*100)>

            <!---- CALCULATE GLOBAL NB HOUR A WEEK--->
            <cfset h_business = 0>
            <cfloop query="get_trainer_businesshour">
                <cfset weekday_str = listGetAt(weekdays, get_trainer_businesshour.week_day + 1)>
                <cfif listFind(SESSION.DAYWEEK_EN, weekday_str)>
                    <cfset h_diff = datediff('h', get_trainer_businesshour.start_time, get_trainer_businesshour.end_time)>
                    <cfset h_business = h_business + h_diff>
                </cfif>
            </cfloop>

                    <!---- CALCULATE ACTIVITY--->
        <cfquery name="get_slot" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(slot_end) - TIME_TO_SEC(slot_start)) as s_avail
            FROM user_slots 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND YEAR(slot_start) = YEAR(CURDATE())
            AND WEEK(slot_start) = WEEK(CURDATE())
        </cfquery>

        <cfquery name="get_lesson_week" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_activity 
            FROM lms_lesson2 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND (status_id <> 3 AND status_id IS NOT NULL)
            AND YEAR(lesson_start) = YEAR(CURDATE())
            AND WEEK(lesson_start) = WEEK(CURDATE())
        </cfquery>

        <cfquery name="get_blocker_week" datasource="#SESSION.BDDSOURCE#">
            SELECT SUM(TIME_TO_SEC(lesson_end) - TIME_TO_SEC(lesson_start)) as s_blocker
            FROM lms_lesson2 
            WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND status_id IS NULL
            AND YEAR(lesson_start) = YEAR(CURDATE())
            AND WEEK(lesson_start) = WEEK(CURDATE())
        </cfquery>

        <!--- IF NO ACTIVITY SET ACTIVITY AT 0 --->
        <cfif get_lesson_week.s_activity eq "">
            <cfset s_activity = 0>
        <cfelse>
            <cfset s_activity = get_lesson_week.s_activity>
        </cfif>

        <cfset h_business = h_business/3600>
        
        <cfif get_slot.s_avail neq "">
            <cfset h_slot = get_slot.s_avail/3600>
        <cfelse>
            <cfset h_slot = 1>
        </cfif>
        
            
        <!--- <cfif get_lesson_week.s_activity neq ""> --->
        <cfset h_activity = s_activity/3600>
        <cfset h_activity_rate = round((h_activity/h_slot)*100)>
        <cfif get_blocker_week.s_blocker neq "">
            <cfset h_blocker = get_blocker_week.s_blocker/3600>
            <cfset h_blocker_rate = round((h_blocker/h_slot)*100)>
        <cfelse>
            <cfset h_blocker = 0>
            <cfset h_blocker_rate = "-">
        </cfif>
        <cfset score_charge = (100-round((h_activity+h_blocker)/h_slot*100))>
            
        <cfset score_global = round(((score_charge)+score_accuracy)/2)>

        <cfif get_trainer.user_add_weight neq "">
            <cfset score_global = score_global + get_trainer.user_add_weight>
        </cfif>
        
        <cfif score_global gte 10>
            <cfset arrayAppend(array_t, structNew())>

            <cfset array_t[arraylen(array_t)].planner_id = user_id> 
            <cfset array_t[arraylen(array_t)].score_accuracy = score_accuracy> 
            <cfset array_t[arraylen(array_t)].h_business = h_business>
            <cfset array_t[arraylen(array_t)].h_slot = h_slot>
            <cfset array_t[arraylen(array_t)].h_activity = h_activity>
            <cfset array_t[arraylen(array_t)].h_activity_rate = h_activity_rate>
            <cfset array_t[arraylen(array_t)].h_blocker = h_blocker>
            <cfset array_t[arraylen(array_t)].h_blocker_rate = h_blocker_rate>
            <cfset array_t[arraylen(array_t)].score_charge = score_charge>
            <cfset array_t[arraylen(array_t)].score_global = score_global>
        </cfif>
            
    </cfoutput>

    <!--- SMART SORTING FOR ARRAY OF T --->
    <cfset array_t = obj_function.arrayOfStructsSort(array_t,"score_global","asc")>


    <!--- BUILD A LIST FOR ORDERING GET TRAINER 2ND QUERY --->
    <cfset t_list = "">
    <cfloop array="#array_t#" index="item">
        <cfset t_list = listappend(t_list,item.planner_id)>
    </cfloop>
    
</cfif>