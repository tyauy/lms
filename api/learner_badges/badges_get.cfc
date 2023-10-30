<cfcomponent name="learner_badges">
    <cffunction name="getUserModuleStats" access="public" returntype="query" output="false">
        <cfargument name="user_id" type="numeric" required="no">
    
        <cfquery name="get_user_module_stats" datasource="#SESSION.BDDSOURCE#">
        SELECT 
            user_id, 
            SUM(sm_elapsed) as total_elapsed, 
            MAX(sm_lastview) as last_view_date 
        FROM 
            user_elapsed 
        <cfif isdefined("arguments.user_id")>
            WHERE 
            user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
        </cfif>
        GROUP BY 
            user_id
        </cfquery>
        
        <cfreturn get_user_module_stats> 
    </cffunction>
    <cffunction name="getUserViewIntervals" access="public" returntype="query" output="false">
        <cfargument name="user_id" type="numeric" required="no">
    
        <cfquery name="get_user_view_intervals" datasource="#SESSION.BDDSOURCE#">
            SELECT 
                t1.user_id, 
                t1.sm_id, 
                DATE(t1.sm_lastview) as sm_lastview_date,
                TIMESTAMPDIFF(SECOND, DATE((SELECT MAX(t2.sm_lastview) FROM user_elapsed t2 WHERE t1.user_id = t2.user_id AND t2.sm_lastview < t1.sm_lastview)), DATE(t1.sm_lastview)) as view_interval 
            FROM 
                user_elapsed t1 
            WHERE 
                t1.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
            ORDER BY 
                t1.user_id, 
                sm_lastview_date ASC
        </cfquery>
        
         
        <cfreturn get_user_view_intervals> 
    </cffunction>
    
    <cffunction name="getWeeklyActivity" access="public" returntype="query" output="false">
        <cfargument name="user_id" type="numeric" required="no">
    
        <cfquery name="get_weeks" datasource="#SESSION.BDDSOURCE#">
            WITH weekly_logs AS (
                SELECT user_id, DATE_TRUNC('week', sm_lastview) AS week
                FROM user_elapsed
                GROUP BY user_id, week
            )

            SELECT user_id
            FROM weekly_logs
            GROUP BY user_id
            HAVING COUNT(*) >= 3

        </cfquery>
        
        
        <cfreturn get_user_view_intervals> 
    </cffunction>

    <cffunction name="getWeeklyLogs" access="public" returntype="query" output="false">
        <cfargument name="user_id" type="numeric" required="no">
    
        <cfquery name="get_connect_intervals" datasource="#SESSION.BDDSOURCE#">
            SELECT 
                t1.user_id, 
                DATE(t1.ulog_date) as connect_date,
                TIMESTAMPDIFF(SECOND, DATE((SELECT MAX(t2.ulog_date) 
                FROM user_log t2 WHERE t1.user_id = t2.user_id AND t2.ulog_date < t1.ulog_date)), DATE(t1.ulog_date)) as connect_interval 
            FROM 
                user_log t1 
            WHERE 
                t1.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
            ORDER BY 
                t1.user_id, 
                connect_date ASC
        </cfquery>
        
        
        
        <cfreturn get_connect_intervals> 
    </cffunction>
</cfcomponent>