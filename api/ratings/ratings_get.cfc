<!---------------------------- Get Trainer Raiting from DB //!don't show avg techno on rtainer 's 
page' ------------------------------------->
<cfcomponent name="rating">


    <cffunction name="oget_avg_rating" access="remote" returntype="query">
        <cfargument name="tr_id" type="numeric" required="no"/>
    
        <cfquery name="avg_rating" datasource="#SESSION.BDDSOURCE#">
            SELECT AVG(rating_support) as r_support, AVG(rating_techno) as r_techno 
         
            FROM lms_rating
            WHERE trainer_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">
        </cfquery>
    
        <cfreturn avg_rating><!--- <cfdump var=#get_avg_rating#> <cfqueryparam value="#tr_id#" cfsqltype="cf_sql_integer"/>--->
    </cffunction>

    <cffunction name="oget_user_rating" access="remote" returntype="any">
        <cfargument name="l_id" type="numeric" required="no"/>
     
    
        <cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
            SELECT rating_support, rating_techno, rating_description, rating_teaching
            FROM lms_rating
            WHERE lesson_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
         
        </cfquery>
    
        <cfreturn get_rating>

    </cffunction>

    <cffunction name="oget_lesson_rating" access="remote" returntype="any">
        <cfargument name="l_id" type="numeric" required="no"/>
     
    
        <cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
            SELECT *
            FROM lms_rating
            WHERE lesson_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            AND (rating_support IS NOT NULL OR rating_techno IS NOT NULL OR rating_teaching IS NOT NULL)
        </cfquery>
    
        <cfreturn get_rating>

    </cffunction>

    <cffunction name="oget_rating_detail" access="remote" returntype="any">
        <cfargument name="l_id" type="numeric" required="no"/>

        <cfquery name="get_detail" datasource="#SESSION.BDDSOURCE#">
            SELECT *
            FROM lms_rating
            WHERE lesson_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            AND (rating_support IS NOT NULL OR rating_techno IS NOT NULL OR rating_teaching IS NOT NULL OR rating_description IS NOT NULL)
        </cfquery>
    
        <cfreturn get_detail>

    </cffunction>
    
    <cffunction name="oget_notation" access="remote" returntype="any">
        <cfargument name="l_id" type="numeric" required="no"/>
        <cfargument name="type" type="numeric" required="yes"/>
        <cfif type eq "learner">

            <cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_id, u.user_firstname, u.user_name FROM user u
            INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
            WHERE upc.profile_id = 4
            AND u.user_status_id = 4
            ORDER BY u.user_firstname
            </cfquery>
        
            <cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
            SELECT DISTINCT
            r.*,
            u.user_id, u.user_firstname, u.user_name,
            u2.user_id as trainer_id, u2.user_firstname as trainer_firstname,
            sm.sessionmaster_name,
            a.account_name, a.account_id,
            l.lesson_start,
            f.formation_id,
            COALESCE(r.rating_date, l.lesson_start) as filtered_date
        
            FROM lms_rating r
        
            INNER JOIN user u ON u.user_id = r.user_id
            INNER JOIN user u2 ON u2.user_id = r.trainer_id
        
            INNER JOIN account a ON a.account_id = u.account_id
        
            INNER JOIN lms_lesson2 l ON r.lesson_id = l.lesson_id
            INNER JOIN lms_tpsession s ON s.session_id = l.session_id
            INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
            
            left join user_teaching t on u2.user_id=t.user_id
            INNER JOIN lms_formation f ON f.formation_id = t.formation_id 
            
            <cfif SESSION.USER_PROFILE eq "TRAINER">
            WHERE u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            <cfelseif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id"))>
            WHERE u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            <cfelseif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND not isdefined("u_id"))>
            WHERE 1 = 1
            <cfelse>
            WHERE 1 = 0
            </cfif>
        
            <cfif isdefined("g_id") AND g_id neq "0">
            AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
            </cfif>
        
            <cfif isdefined("t_id") AND t_id neq "0">
            AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfif>
        
            <cfif isdefined("f_id") AND f_id neq "0">
            AND t.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
            </cfif>
        
            ORDER BY rating_id DESC limit 100
            GROUP BY r.rating_id

            </cfquery>
        
            <cfquery name="get_rating_trainer_lang" datasource="#SESSION.BDDSOURCE#">
            SELECT g.group_id, g.group_name, COUNT(rating_id) as nb
            FROM account_group g
            
            LEFT JOIN account a ON a.group_id = g.group_id
            LEFT JOIN user u ON u.account_id = a.account_id
            LEFT JOIN lms_rating r ON u.user_id = r.user_id
            
            GROUP BY group_id
            ORDER BY g.group_name
            </cfquery>
        
        <cfelseif type eq "tm">
        
            <cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
            SELECT 
            r.*
            FROM lms_rating_tm r
            ORDER BY rating_tm_id DESC
            </cfquery>
        
        </cfif>
        <cfreturn get_notation>
    </cffunction>

</cfcomponent>