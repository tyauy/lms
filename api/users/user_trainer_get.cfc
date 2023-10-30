<cfcomponent displayname="user_trainer_get" hint="ColdFusion Component page for fetching data for trainer users">

	<cffunction name="get_trainer_techno" access="public" returntype="query" description="get trainer visio techno">
        <cfargument name="user_id" type="numeric" required="yes">

        <cftry>

            <!--- adobe & webex & skype & wherby are excluded for now --->
            <cfquery name="select_tech" datasource="#SESSION.BDDSOURCE#">
                SELECT `lms_list_techno`.`techno_id`, `lms_list_techno`.`techno_active`, `lms_list_techno`.`techno_alias`, `lms_list_techno`.`techno_tooltip`, 
                `lms_list_techno`.`techno_icon`, `lms_list_techno`.`techno_name_#SESSION.LANG_CODE#` ,
                `user_techno`.`user_techno_preferred`, `user_techno`.`user_techno_link`, `user_techno`.`user_techno_key` 
                FROM `lms_list_techno` LEFT JOIN `user_techno` ON `lms_list_techno`.`techno_id` = `user_techno`.`techno_id` 
                AND `user_techno`.`user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                WHERE `lms_list_techno`.`techno_id` NOT IN (2,9,11) ORDER BY `lms_list_techno`.`techno_id` ASC
            </cfquery>
        
            <!--- TODO remove return or put a meaningfull return message --->
            <cfreturn select_tech>
            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
                <!--- <cfreturn 0> --->
            </cfcatch>
        </cftry>
	</cffunction>

    <!--- ! --->

    <cffunction name="get_trainer_teach_ready" access="public" returntype="query" description="get trainer teachning ready by lang">
        <cfargument name="user_id" type="numeric" required="yes">

        <cftry>

            <cfquery name="select_rdy" datasource="#SESSION.BDDSOURCE#">
                SELECT t.teaching_id, t.speciality_id, t.teaching_level, t.level_id , f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_id, f.formation_code, 
                ur.ready_id, ur.user_ready_test, ur.user_ready_france, ur.user_ready_germany, ur.user_ready_group,ur.user_ready_classic, ur.user_ready_tm, 
                ur.user_ready_vip, ur.user_ready_children, ur.user_ready_partner, ur.user_ready_assessment
                FROM user_teaching t INNER JOIN lms_formation f ON f.formation_id = t.formation_id 
                LEFT JOIN user_ready ur ON t.formation_id = ur.formation_id AND t.user_id = ur.user_id 
                WHERE t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            </cfquery>
        
            <cfreturn select_rdy>
            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
                <!--- <cfreturn 0> --->
            </cfcatch>
        </cftry>
	</cffunction>

    <!--- ! --->

    <cffunction name="get_accent" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="formation_teaching_id" type="numeric" required="yes">
        <cfargument name="formation_accent_vocab" type="numeric" required="no" default="">
		
		<!----- ADD TAUGHT LANGUAGE ----------->
		<cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">
			SELECT formation_accent_id, formation_accent_name_#SESSION.LANG_CODE# as formation_accent_name FROM `lms_formation_accent` 
			WHERE `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_teaching_id#">
            <cfif formation_accent_vocab neq "">AND formation_accent_vocab = 1</cfif>
		</cfquery>
		
		<cfprocessingdirective suppresswhitespace="yes">
          <cfset result = SerializeJSON(get_accent, "struct")>
        </cfprocessingdirective>
    
		<cfreturn result>
		
		
	</cffunction>


    <cffunction name="get_calendar_dispo" access="remote" returntype="array" >
        <cfargument name="date_link" type="date" required="yes">
        <cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="s_dur" type="numeric" required="yes" default="60">


        <cfset available_date_list = []>


        <!--- <cfif LStimeformat(now(),'HH:mm:00', 'fr') LT "18:00:00" OR !(SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST")> --->

        <cfquery name="get_trainer_solo" datasource="#SESSION.BDDSOURCE#">
            SELECT user_blocker FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
        </cfquery>

        <!--- ! 1 day  --->

        <cfquery name="get_single_slot" datasource="#SESSION.BDDSOURCE#">
            SELECT CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) as fulldate, usai.slot
            FROM `user_slot_avail_index` usai 
            INNER JOIN user_slots s ON usai.slot >= DATE_FORMAT(s.slot_start,'%H:%i:%S') 
            AND usai.slot <= DATE_FORMAT(DATE_ADD(s.slot_end, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#s_dur * -1#"> MINUTE),'%H:%i:%S') 
            WHERE s.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND DATE_FORMAT(s.slot_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">

            AND usai.slot NOT IN (
                SELECT usai.slot FROM `user_slot_avail_index` usai 
                INNER JOIN lms_lesson2 l2 ON 
                usai.slot >= DATE_FORMAT(DATE_ADD(l2.lesson_start, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#(get_trainer_solo.user_blocker + s_dur - 15) * -1#"> MINUTE),'%H:%i:%S') 
                AND usai.slot <= DATE_FORMAT(DATE_ADD(l2.lesson_end, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#get_trainer_solo.user_blocker - 15#"> MINUTE),'%H:%i:%S') 
                WHERE (l2.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> OR l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">)
                AND ((l2.user_id IS NOT NULL AND l2.status_id <> 3 
                <cfif listFindNoCase("LEARNER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                AND l2.status_id <> 4
                </cfif>
                ) OR l2.blocker_id IS NOT NULL)
                AND DATE_FORMAT(l2.lesson_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">
                )

            <cfif LSDateFormat(now(),'yyyy-mm-dd', 'fr') eq date_link AND (SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST")>
                AND usai.slot > DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 6 HOUR),'%H:%i:%S')
                AND DATE_FORMAT(NOW(),'%H:%i:%S') < "18:00:00"
            </cfif>

            ORDER BY `usai`.`slot` ASC
        </cfquery>

        <!--- <cfif >
                    AND CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) > CONCAT(DATE_FORMAT(now(),'%Y-%m-%d'), " ", DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 6 HOUR),'%H:%i:%S'))
                </cfif> --->

        <!--- <cfdump var="#get_single_slot#"> --->
        <cfloop query="get_single_slot">
            <cfscript>
                ArrayAppend(available_date_list,fulldate,"true");
            </cfscript>
        </cfloop>
        <!--- </cfif> --->


		<cfreturn available_date_list>
		
		
	</cffunction>

    <cffunction name="get_calendar_dispo_certif" access="remote" returntype="array" >
        <cfargument name="date_link" type="date" required="yes">
        <cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="s_dur" type="numeric" required="yes" default="60">


        <cfset available_date_list = []>

            <!--- ! 1 day  --->

        <cfquery name="get_single_slot" datasource="#SESSION.BDDSOURCE#">
            SELECT CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) as fulldate, usai.slot
            FROM `user_slot_avail_index` usai 
            INNER JOIN user_slots s ON usai.slot >= DATE_FORMAT(s.slot_start,'%H:%i:%S') 
            AND usai.slot <= DATE_FORMAT(DATE_ADD(s.slot_end, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#s_dur * -1#"> MINUTE),'%H:%i:%S') 
            WHERE s.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND DATE_FORMAT(s.slot_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">

            <cfif LSDateFormat(now(),'yyyy-mm-dd', 'fr') eq date_link AND (SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST")>
                AND usai.slot > DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 6 HOUR),'%H:%i:%S')
                AND DATE_FORMAT(NOW(),'%H:%i:%S') < "18:00:00"
            </cfif>

            ORDER BY `usai`.`slot` ASC
        </cfquery>

        <cfloop query="get_single_slot">
            <cfscript>
                ArrayAppend(available_date_list,fulldate,"true");
            </cfscript>
        </cfloop>
        <!--- </cfif> --->


		<cfreturn available_date_list>
		
		
	</cffunction>

    
    
    <cffunction name="get_calendar_dispo_cs" access="remote" returntype="array" >
        <cfargument name="date_link" type="date" required="yes">
        <cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="s_dur" type="numeric" required="yes" default="15">


        <cfset available_date_list = []>


        <cfquery name="get_single_slot" datasource="#SESSION.BDDSOURCE#">
            SELECT CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) as fulldate, usai.slot
            FROM `user_slot_avail_index` usai 
            INNER JOIN user_slots s ON usai.slot >= DATE_FORMAT(s.slot_start,'%H:%i:%S') 
            AND usai.slot <= DATE_FORMAT(DATE_ADD(s.slot_end, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#s_dur * -1#"> MINUTE),'%H:%i:%S') 
            WHERE s.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            AND DATE_FORMAT(s.slot_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">

            AND usai.slot NOT IN (
                SELECT usai.slot FROM `user_slot_avail_index` usai 
                INNER JOIN lms_lesson2 l2 ON 
                usai.slot >= DATE_FORMAT(DATE_ADD(l2.lesson_start, INTERVAL <cfqueryparam cfsqltype="cf_sql_integer" value="#(s_dur - 15) * -1#"> MINUTE),'%H:%i:%S') 

                INNER JOIN (
                    SELECT lesson_id, lesson_start FROM `lms_lesson2` 
                    WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">  
                    AND DATE_FORMAT(lesson_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">
                    HAVING COUNT(*) > 1
                ) l3 ON l2.lesson_id = l3.lesson_id

                AND usai.slot <= DATE_FORMAT(DATE_ADD(l2.lesson_end, INTERVAL '#15#' MINUTE),'%H:%i:%S') 
                WHERE l2.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
                AND ((l2.user_id IS NOT NULL AND l2.status_id <> 3 
                <cfif listFindNoCase("LEARNER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                AND l2.status_id <> 4
                </cfif>
                ) OR l2.blocker_id IS NOT NULL)
                AND DATE_FORMAT(l2.lesson_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">
            )

            <cfif LSDateFormat(now(),'yyyy-mm-dd', 'fr') eq date_link AND (SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST")>
                AND usai.slot > DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 6 HOUR),'%H:%i:%S')
            </cfif>
            

            ORDER BY `usai`.`slot` ASC
        </cfquery>

        <!--- <cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST">
                AND CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ", usai.slot) > CONCAT(DATE_FORMAT(now(),'%Y-%m-%d'), " ", DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 6 HOUR),'%H:%i:%S'))
            </cfif> --->

            
        <!--- <cfdump var="#get_single_slot#"> --->
        <cfloop query="get_single_slot">
            <cfscript>
                ArrayAppend(available_date_list,fulldate,"true");
            </cfscript>
        </cfloop>

		<cfreturn available_date_list>
		
		
	</cffunction>
    






    <cffunction name="get_trainer_links" access="public" returntype="query" description="Get trainer follow up links">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>

            <cfquery name="get_trainer_links" datasource="#SESSION.BDDSOURCE#">
                SELECT * FROM user_link WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>
        
            <cfreturn get_trainer_links>

            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>

        </cftry>
        
	</cffunction>






    <cffunction name="get_trainer_businesshour" access="public" returntype="query" description="Get trainer theorical business hours">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>

            <cfquery name="get_trainer_businesshour" datasource="#SESSION.BDDSOURCE#">
                SELECT ubh.*
                FROM user_business_hours ubh
                INNER JOIN user u on u.user_id = ubh.user_id
                WHERE ubh.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                ORDER BY week_day
            </cfquery>
        
            <cfreturn get_trainer_businesshour>

            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>

        </cftry>
        
	</cffunction>








</cfcomponent>