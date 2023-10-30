<cfcomponent>


    <cffunction name="test_insertAvails" access="public" output="false">
        <cfset local.p_id = 140>
        <cfset local.workingHours = SerializeJSON([{ "day": 1, "start_send": "08:00", "end_send": "17:00" }, { "day": 2, "start_send": "08:00", "end_send": "17:00" }, { "day": 1, "start_send": "18:00", "end_send": "20:00" }])>
        <cfset local.from = "2023-06-01">
        <cfset local.to = "2023-07-02">
    
        <!--- Get initial count of slots for the specified user --->
        <cfquery name="initialCount" datasource="#SESSION.BDDSOURCE#">
            SELECT COUNT(*) AS count FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.p_id#">
        </cfquery>
    
        <cfset result = insertAvails(local.p_id, local.workingHours, local.from, local.to)>
    
        <!--- Get the count of slots after the operation --->
        <cfquery name="finalCount" datasource="#SESSION.BDDSOURCE#">
            SELECT COUNT(*) AS count FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.p_id#">
        </cfquery>
    
        <!--- Assert that the function returns "ok insert avails" --->
        <cfassert condition="result EQ 'ok insert avails'">
    
        <!--- Calculate the expected number of inserted slots --->
        <cfset workingHoursArray = DeserializeJSON(local.workingHours)>
        <cfset expectedSlots = 0>
        <cfloop from="#local.from#" to="#local.to#" index="currentDate" step="#CreateTimeSpan(1,0,0,0)#"> 
            <cfset currentDayOfWeek = (DayOfWeek(currentDate) - 1) mod 7>
            <cfloop array="#workingHoursArray#" index="d">
                <cfset weekday = d.day>  
                <cfif weekday eq currentDayOfWeek>
                    <cfset expectedSlots = expectedSlots + 1>
                </cfif>
            </cfloop>
        </cfloop>
    
        <!--- Assert that there are slots inserted for the given planner_id by comparing initial and final counts --->
        <cfassert condition="finalCount.count - initialCount.count EQ expectedSlots">
    </cffunction>
    
</cfcomponent>
