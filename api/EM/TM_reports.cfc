<cfcomponent>

    <cffunction name="ogetEmployees" access="remote" returnType="any" returnFormat="json">
        <cfargument name="accountIds" type="string" required="no" default="">
        
        <cfquery name="getData" datasource="#SESSION.BDDSOURCE#">
            SELECT user_id, CONCAT(user_name, ' ', user_firstname) AS employee_name FROM user
            WHERE 1=1
            <cfif trim(ARGUMENTS.accountIds) neq "">
                AND account_id IN 
                (<cfqueryparam value="#ARGUMENTS.accountIds#" cfsqltype="CF_SQL_INTEGER" list="yes">)
            </cfif>
            order by user_name
        </cfquery>
        
        <cfset jsonData = serializeJSON(getData)>
        
        <cfreturn jsonData>
    </cffunction>
 
    
    
    <cffunction name="ogetDetailedLearningPlans" access="remote" returnType="any" returnFormat="json">
        <cfargument name="accountIds" type="string" required="no" default="">
        <cfargument name="employee" type="numeric" required="no" default="0">
        <cfargument name="startDate" type="date" required="no" default="#createDate(1900,1,1)#">
        <cfargument name="endDate" type="date" required="no" default="#createDate(2999,12,31)#">
        <cfargument name="status" type="numeric" required="no" default="0">
      
        <cfquery name="getDetailedData" datasource="#SESSION.BDDSOURCE#">
        SELECT 
            CONCAT(u.user_name, ' ', u.user_firstname) AS employee_name, 
            u2.user_firstname as trainer_name, 
            l.lesson_id, 
            l.STATUS_ID,
            u.USER_ID,  
            l.PLANNER_ID,
            l.LESSON_START,
            l.LESSON_END,
            l.LESSON_NAME,
            l.LESSON_DURATION,
            ls.STATUS_NAME_#SESSION.LANG_CODE# as status_name,
            ls.STATUS_CSS,
            l.method_id,
            sm.SESSIONMASTER_NAME,
            f.formation_name_#SESSION.LANG_CODE# as formation_name,
            lm.METHOD_NAME_#SESSION.LANG_CODE# as method_name
        FROM 
            lms_lesson2 l  
        INNER JOIN lms_tpsession s ON s.session_id = l.session_id
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
        LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
        LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
        INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
        INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
        INNER JOIN 
            user u ON u.user_id = l.user_id
        INNER JOIN 
            user u2 ON u2.user_id = l.planner_id
        WHERE 
            1=1 
    
        <cfif ARGUMENTS.employee NEQ 0>
            AND u.user_id = <cfqueryparam value="#ARGUMENTS.employee#" cfsqltype="CF_SQL_INTEGER">
            <cfelseif ARGUMENTS.accountIds NEQ 0>
                AND u.account_id IN 
                (<cfqueryparam value="#ARGUMENTS.accountIds#" cfsqltype="CF_SQL_INTEGER" list="yes">)
        </cfif>
        
        AND l.lesson_start BETWEEN <cfqueryparam value="#ARGUMENTS.startDate#" cfsqltype="CF_SQL_DATE"> 
                                AND <cfqueryparam value="#ARGUMENTS.endDate#" cfsqltype="CF_SQL_DATE">
        <cfif ARGUMENTS.status NEQ 0>
            AND l.status_id = <cfqueryparam value="#ARGUMENTS.status#" cfsqltype="CF_SQL_INTEGER"> 
       
        </cfif> 
        </cfquery>
    
        <!-- Convert the query to a JSON string -->
        <cfset jsonData = serializeJSON(getDetailedData)>
    
        <!-- Ensure only the JSON string is returned -->
        <cfcontent type="application/json; charset=utf-8">
        <cfoutput>#jsonData#</cfoutput>
        <cfabort> <!-- Ensure nothing else is processed or outputted after this point -->
    </cffunction>
    
    
    

<cffunction name="ogetLearningPlans" access="remote" returntype="query" output="false">
    <cfargument name="u_id" type="numeric" required="no" default="0">
    <cfargument name="p_id" type="numeric" required="no" default="0">
    <cfargument name="tselect" type="string" required="no" default="">
    <cfargument name="yselect" type="string" required="no" default="">
    <cfargument name="startDate" type="date" required="no" default="">
    <cfargument name="endDate" type="date" required="no" default="">
    <cfargument name="a_id" type="numeric" required="no" default="0">
    <cfargument name="status_id" type="numeric" required="no" default="0">
    
    <cfquery name="get_lessons" datasource="#SESSION.BDDSOURCE#">
        SELECT COUNT(l.lesson_id) as nb, 
               SUM(lesson_duration/60) as h, 
               SUM(lesson_duration) as m
        FROM lms_lesson2 l
        INNER JOIN lms_tpsession s ON s.session_id = l.session_id
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
        LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
        LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
        INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
        INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
        INNER JOIN user u ON u.user_id = l.user_id
        INNER JOIN user u2 ON u2.user_id = l.planner_id
        WHERE l.user_id IS NOT NULL 
          AND l.session_id IS NOT NULL 
          AND l.blocker_id IS NULL
          <cfif status_id neq 0>
            AND l.status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#status_id#">
          </cfif>
          <cfif p_id neq 0>
            AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
          </cfif>
          <cfif tselect neq "">
            AND DATE_FORMAT(l.lesson_start, "%Y-%m") = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
          </cfif>
          <cfif yselect neq "">
            AND DATE_FORMAT(l.lesson_start, "%Y") = <cfqueryparam cfsqltype="cf_sql_varchar" value="#yselect#">
          </cfif>
          <cfif startDate neq "" AND endDate neq "">
            AND l.lesson_start BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#startDate#"> 
            AND <cfqueryparam cfsqltype="cf_sql_date" value="#endDate#">
          </cfif>
    </cfquery>
    
    <cfreturn get_lessons> 
</cffunction>


    <cffunction name="exportToExcel" access="public" returntype="void" output="yes">
        <cfargument name="startDate" type="string" required="no" default="">
        <cfargument name="endDate" type="string" required="no" default="">
        <cfargument name="employee" type="string" required="no" default="">
        <cfargument name="status" type="string" required="no" default="">
        
        <!--- Query the database to get the filtered data --->
        <cfquery name="getData" datasource="#SESSION.BDDSOURCE#">
            SELECT * FROM lms_lesson2
            WHERE 1=1
            <cfif ARGUMENTS.startDate neq "">
                AND date >= <cfqueryparam value="#ARGUMENTS.startDate#" cfsqltype="CF_SQL_DATE">
            </cfif>
            <cfif ARGUMENTS.endDate neq "">
                AND date <= <cfqueryparam value="#ARGUMENTS.endDate#" cfsqltype="CF_SQL_DATE">
            </cfif>
            <cfif ARGUMENTS.employee neq "">
                AND employee = <cfqueryparam value="#ARGUMENTS.employee#" cfsqltype="CF_SQL_VARCHAR">
            </cfif>
            <cfif ARGUMENTS.status neq "">
                AND status = <cfqueryparam value="#ARGUMENTS.status#" cfsqltype="CF_SQL_VARCHAR">
            </cfif>
        </cfquery>

        <!--- Create a new Excel spreadsheet --->
        <cfspreadsheet action="write" overwrite="true" query="getData" filename="export.xlsx" sheetname="Data">
        
        <!--- Set the content type and file name for the download --->
        <cfheader name="Content-Disposition" value="attachment; filename=export.xlsx">
        <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="export.xlsx" deletefile="yes">
    </cffunction>
    
</cfcomponent>
