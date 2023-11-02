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

            <cfif IsDefined("Arguments.get_language_taught_id") || IsDefined("Arguments.get_lms_level_id")>
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

            <!---- PROFIL TRAINER, ACTIVE --->
            WHERE up.profile_id = 4 
            AND u.user_status_id = 4
            <cfif IsDefined("Arguments.get_language_taught_id")>
                AND t.formation_id IN (#get_language_taught_id#)
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
    
</cfcomponent>
