<cfcomponent>

    <cffunction name="filter" access="remote" method="POST" returntype="any" returnformat="JSON">

    
        <cfif IsDefined("Arguments.get_lms_level_id")>
            <cfset lms_level = Arguments.get_lms_level_id.split(",")>
        </cfif>
        <cfif IsDefined("Arguments.get_lms_skills_id")>
            <cfset lms_skills = Arguments.get_lms_skills_id.split(",")>
        </cfif>

        <cfquery name="get_filtered_trainers" datasource="#SESSION.BDDSOURCE#">

            SELECT u.user_id, 
            
                <cfif IsDefined("Arguments.get_user_personality_id")>
                    COUNT(p.personality_id) AS count_perso,
                </cfif>

                <cfif IsDefined("Arguments.get_lms_badge_id")>
                    COUNT(lba.badge_id) AS count_badge,
                </cfif>
                u.profile_id
                FROM user u
                LEFT JOIN settings_country c ON c.country_id = u.country_id
                LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
                LEFT JOIN user_profile_cor up ON up.user_id = u.user_id

            <cfif IsDefined("Arguments.get_language_taught_id") || IsDefined("Arguments.get_lms_level_id") || IsDefined("Arguments.get_accent_spoken_id")>
                INNER JOIN user_teaching t ON t.user_id = u.user_id
            </cfif>
            <cfif IsDefined("Arguments.get_language_spoken_id")>
                INNER JOIN user_speaking sp ON sp.user_id = u.user_id
            </cfif>
            <cfif IsDefined("Arguments.get_user_personality_id")>
                INNER JOIN user_personality p ON p.user_id = u.user_id
            </cfif>
            <cfif IsDefined("Arguments.get_lms_business_area_id") || IsDefined("Arguments.get_lms_skills_id")>
                INNER JOIN user_expertise_business eb ON eb.user_id = u.user_id
            </cfif>
            <cfif IsDefined("Arguments.get_lms_badge_id")>
                INNER JOIN lms_badge_attribution lba ON lba.badge_trainer_id = u.user_id
            </cfif>
            <cfif IsDefined("Arguments.avail_id")>
                INNER JOIN user_business_hours ubh ON ubh.user_id = u.user_id
            </cfif>

            <!---- PROFIL TRAINER, ACTIVE --->
            WHERE up.profile_id = 4 
            AND u.user_status_id = 4
            <cfif IsDefined("Arguments.get_language_taught_id")>
                AND t.formation_id IN (#get_language_taught_id#)
            </cfif>
            <cfif IsDefined("Arguments.get_accent_spoken_id")>
                AND t.accent_id IN (#get_accent_spoken_id#)
            </cfif>
            <cfif IsDefined("Arguments.get_language_spoken_id")>
                AND sp.formation_id IN (#get_language_spoken_id#)
            </cfif>
            <cfif IsDefined("Arguments.get_user_personality_id")>
                AND p.personality_id IN (<cfqueryparam value="#Arguments.get_user_personality_id#" list="yes" cfsqltype="CF_SQL_INTEGER">)
            </cfif>
            <cfif IsDefined("Arguments.get_lms_business_area_id")>
                AND eb.keyword_id IN (#get_lms_business_area_id#)
            </cfif>
            <cfif IsDefined("Arguments.get_lms_level_id")>
                <cfloop array="#lms_level#" index="idx" item="item">
                    <cfif idx == 1>
                        AND (t.level_id LIKE ("%#item#%")
                    <cfelseif idx GT 1 && ArrayLen(lms_level) GT 1 >
                        OR t.level_id LIKE ("%#item#%")
                    </cfif>
                </cfloop>
                        )
            </cfif>
            <cfif IsDefined("Arguments.get_lms_skills_id")>
            
                <cfloop array="#lms_skills#" index="idx" item="item">
                    <cfif idx == 1>
                        AND (u.expertise_id LIKE ("%#item#%")
                    <cfelseif idx GT 1 && ArrayLen(lms_skills) GT 1 >
                        OR u.expertise_id  LIKE ("%#item#%")
                    </cfif>
                </cfloop>
                        )
            </cfif>
            <cfif IsDefined("Arguments.avail_id")>
                AND u.user_id IN (
                    SELECT user_id FROM user_business_hours ubh, user_availability ua 
                    WHERE (ua.hour_start BETWEEN ubh.start_time AND DATE_ADD(ubh.end_time, INTERVAL -45 MINUTE) 
                    OR ua.hour_end BETWEEN DATE_ADD(ubh.start_time, INTERVAL 45 MINUTE)  AND ubh.end_time)
                    AND ua.avail_id IN (#avail_id#)
                    AND ubh.status = "available"
                    AND ((ua.avail_day = "mon" AND ubh.week_day = 1)
                        OR(ua.avail_day = "tue" AND ubh.week_day = 2)
                        OR(ua.avail_day = "wed" AND ubh.week_day = 3)
                        OR(ua.avail_day = "thu" AND ubh.week_day = 4)
                        OR(ua.avail_day = "fri" AND ubh.week_day = 5)
                        OR(ua.avail_day = "sat" AND ubh.week_day = 6)
                        OR(ua.avail_day = "sun" AND ubh.week_day = 0)
                        )
                )
            </cfif>
            <cfif IsDefined("Arguments.get_lms_badge_id")>
                AND lba.badge_id IN (<cfqueryparam value="#Arguments.get_lms_badge_id#" list="yes" cfsqltype="CF_SQL_INTEGER">)
            </cfif> 

            <!---- VISIO --->
            AND FIND_IN_SET(1,method_id)

            <!---- REMOVE FAKE TRAINERS --->
            AND u.user_id <> 2656 AND u.user_id <> 4784 AND u.user_id <> 4785 AND u.user_id <> 201 

            GROUP BY u.user_id
            
            <cfif IsDefined("Arguments.get_user_personality_id") && IsDefined("Arguments.get_lms_badge_id")>
                ORDER BY count_perso DESC, count_badge DESC
            <cfelseif IsDefined("Arguments.get_user_personality_id")>
                ORDER BY count_perso DESC
            <cfelseif IsDefined("Arguments.get_lms_badge_id")>
                ORDER BY count_badge DESC
            </cfif>

        </cfquery>
    
        <cfreturn get_filtered_trainers>
    </cffunction>

    <cffunction name="get_user_about" access="remote">
        <cfquery name="get_user_about" datasource="#SESSION.BDDSOURCE#">
            SELECT ua.*, uaq.about_question_#SESSION.LANG_CODE# as quest 
            FROM user_about ua 
            INNER JOIN user_about_question uaq ON uaq.user_about_question_id = ua.user_about_type 
            WHERE ua.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
            ORDER BY RAND()
            LIMIT 5
        </cfquery>
        <cfreturn get_user_about>
    </cffunction>

    <cffunction name="get_user_paragraph" access="remote">
        <cfquery name="get_user_paragraph" datasource="#SESSION.BDDSOURCE#">
        SELECT *
        FROM user_about
        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> and user_about_type = 0
        </cfquery>
        <cfreturn get_user_paragraph>
    </cffunction>
        
    <cffunction name="get_user_personality" access="remote">
        <cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
            SELECT perso_id, COUNT(up.personality_id) AS count, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index upi
            INNER JOIN user_personality up ON up.personality_id = upi.perso_id
            WHERE up.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            GROUP BY up.personality_id
            ORDER BY count DESC
            LIMIT 3
        </cfquery>
        <cfreturn get_user_personality>
    </cffunction>

    <cffunction name="get_user_badge" access="remote">
        <cfquery name="get_user_badge" datasource="#SESSION.BDDSOURCE#">
            SELECT lbi.badge_id, COUNT(lba.badge_id) AS count, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index lbi
            INNER JOIN lms_badge_attribution lba ON lba.badge_id = lbi.badge_id
            WHERE lba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            GROUP BY lba.badge_id
            ORDER BY count DESC
            LIMIT 3
        </cfquery>
        <cfreturn get_user_badge>
    </cffunction>

        
    <cffunction name="get_user_teaching_level" access="remote">
        <cfquery name="get_user_teaching_level" datasource="#SESSION.BDDSOURCE#">
            SELECT lbi.badge_id, COUNT(lba.badge_id) AS count, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index lbi
            INNER JOIN lms_badge_attribution lba ON lba.badge_id = lbi.badge_id
            WHERE lba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            GROUP BY lba.badge_id
            ORDER BY count DESC
            LIMIT 3
        </cfquery>
        <cfreturn get_user_teaching_level>
    </cffunction>

                                        
    <!---- HARD QUERIES--->
    <cffunction name="get_lesson" access="remote">
        <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
        SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
        </cfquery>
        <cfreturn get_lesson>
    </cffunction>

    <cffunction name="get_learner" access="remote">
        <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
        SELECT COUNT(DISTINCT(t.user_id)) as nb FROM lms_tp t
        INNER JOIN lms_tpplanner p ON p.tp_id = t.tp_id
        WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
        </cfquery>
        <cfreturn get_learner>
    </cffunction>

    <cffunction name="get_rating" access="remote">
        <cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
            SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
        </cfquery>
        <cfreturn get_rating>
    </cffunction>
    
</cfcomponent>
