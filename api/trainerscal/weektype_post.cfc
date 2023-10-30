<cfcomponent>
    <cfset serverTimeZoneOffset = getTimeZoneInfo().utctotaloffset / 60>
    <cfset parisTimeZoneOffset = 1 * 60> 

    
    <cffunction name="insertAvails" access="remote">
        <cfargument name="p_id" required="yes" >
        <cfargument name="workingHours" required="yes">
        <cfargument name="from" required="yes">
        <cfargument name="to" required="yes">

        <cfset workingHours = DeserializeJSON(arguments.workingHours)>
        <!---   <cfdump var="#workingHours#"> --->
    
           <!------ CF TRICK FOR DATEPICKER -------------->
		<cfif day(arguments.from) lte "12">
			<cfset date_schedule_from = "#dateformat(arguments.from,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_schedule_from = "#dateformat(arguments.from,'yyyy-mm-dd')#">
		</cfif>	

		<cfif day(arguments.to) lte "12">
			<cfset date_schedule_to = "#dateformat(arguments.to,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_schedule_to = "#dateformat(arguments.to,'yyyy-mm-dd')#">
		</cfif>	
		
      <!------- 1 - SELECT SLOTS TO BE DELETED ---->
    <cfquery name="select_deleted_rows" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM user_slots
        WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        AND slot_start >= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_from#">
        AND slot_start <= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_to#">
    </cfquery>

   <!------- 2 - CLEAN THE SELECTED SLOTS ----->
   `<cfquery name="clean_all" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        and slot_start >= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_from#">
        and slot_start <= <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_to#">
    </cfquery>
   <!------- 3 - CHECK EXISTING VACATION ----->

    <cfquery name="getUserVacationDates" datasource="#SESSION.BDDSOURCE#">
        SELECT start_date, end_date FROM user_holidays
        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        AND (
            (start_date BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_from#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_to#">)
            OR 
            (end_date BETWEEN <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_from#"> AND <cfqueryparam cfsqltype="cf_sql_date" value="#date_schedule_to#">)
        )
    </cfquery>

    

        <!------- 4 - CREATE AND INSERT NEW SLOTS ----->

     
		
		<!---- LOOP OVER DATE RANGE --->
		<cfloop from="#date_schedule_from#" to="#date_schedule_to#" index="currentDate" step="#CreateTimeSpan(1,0,0,0)#"> 
			<cfset currentDayOfWeek = (DayOfWeek(currentDate) - 1) mod 7>

             <!-- Check if the currentDate falls within any vacation period -->
            <cfset isVacationDay = false>
            <cfloop query="getUserVacationDates">
                <cfif currentDate gte start_date AND currentDate lte end_date>
                    <cfset isVacationDay = true>
                    <cfbreak>
                </cfif>
            </cfloop>
              <!--- Loop over the result set and insert into user_schedule --->
              <cfloop array="#workingHours#" index="d">
                <cfset weekday =d.day>  
               
                <cfset startTime =LStimeformat(d.start_send, "HH:mm", "fr")>
                <cfset endTime =LStimeformat(d.end_send, "HH:mm", "fr")>
                <cfif weekday eq currentDayOfWeek AND NOT isVacationDay> 
                  <!---   <cfdump var="weekday:#weekday#" >
                    <cfdump var="currentDayOfWeek:#currentDayOfWeek#">
                    <cfdump var="weekday and time #DateFormat(currentDate, 'yyyy-mm-dd')# #TimeFormat(startTime, 'HH:mm')#" > --->
                <cfquery name="insertSchedule" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_slots(planner_id, slot_start, slot_end)
                    VALUES (
                        <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#DateFormat(currentDate, 'yyyy-mm-dd')# #TimeFormat(startTime, 'HH:mm')#" cfsqltype="cf_sql_timestamp">,
                        
                        <cfqueryparam value="#DateFormat(currentDate, 'yyyy-mm-dd')# #TimeFormat(endTime, 'HH:mm')#" cfsqltype="cf_sql_timestamp">
         
                    )
                </cfquery>
                </cfif>
            </cfloop>
        </cfloop>
       
    
   
        <!--  return the result of this query -->
        <cfreturn "avail ok">
    </cffunction>
    

    <cffunction name="insertWorkingHours" access="remote" >
        <cfargument name="p_id" required="yes" >
        <cfargument name="workingHours" required="yes">
        <cfargument name="repeat_type" required="yes">
        <cfargument name="status" required="yes">
        <cfargument name="from" required="yes">
        <cfargument name="to" required="yes">


        <cfquery name="clean_business_hours" datasource="#SESSION.BDDSOURCE#">
            DELETE FROM user_business_hours WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        </cfquery>

            <!------- 2 - INSERT IN USER_BUSINESS_HOURS ----->
                <!--- Deserialize the JSON data --->
            <cfset workingHours = DeserializeJSON(arguments.workingHours)>
            <!--- <cfdump var="#workingHours#"> --->
             <!--- Loop to get all working hours slots --->
            <cfloop array="#workingHours#" index="d">
                <cfset weekday =d.day>
                <cfset endTime =LStimeformat(d.end_send, "HH:mm", "fr")>
                <cfset startTime =LStimeformat(d.start_send, "HH:mm", "fr")>
                    <!--- <cfdump var="#weekday#"> --->
            
                <cfquery name="insertWork" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_business_hours (user_id, start_time, end_time, repeat_type, status, week_day, created_at)
                    VALUES (
                        <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#startTime#" cfsqltype="cf_sql_time">,
                        <cfqueryparam value="#endTime#" cfsqltype="cf_sql_time">,
                        <cfqueryparam value="#repeat_type#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#status#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#weekday#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
                    )
                </cfquery> 
            </cfloop>
      
    <cfreturn "ok business hours"> 
    </cffunction>

    
    <!--- <cffunction name="deleteWorkingHours" access="remote" returntype="void">
        <cfargument name="id" type="numeric" required="yes" nullable="yes">
    
        <cftry>
            <!--- Fetch the user_id and week_day associated with the record being deleted --->
            <cfquery name="getBusinessHourDetails" datasource="#SESSION.BDDSOURCE#">
                SELECT user_id, week_day
                FROM user_business_hours
                WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
            </cfquery>
    
            <!--- Delete the matching record from user_business_hours --->
            <cfquery name="deleteWork" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM user_business_hours 
                WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
            </cfquery>
    
            <!--- Delete the matching entries in user_slots --->
            <cfquery name="deleteMatchingSlots" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM user_slots
                WHERE planner_id = <cfqueryparam value="#getBusinessHourDetails.user_id#" cfsqltype="cf_sql_integer">
                AND DAYOFWEEK(slot_start) = <cfqueryparam value="#((getBusinessHourDetails.week_day + 1) % 7)#" cfsqltype="cf_sql_integer">
                AND DATE(slot_start) >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
                AND DATE(slot_start) < <cfqueryparam value="#DateAdd('yyyy', 2, Now())#" cfsqltype="cf_sql_date">
            </cfquery>
            
            
    
            <cfcatch type="any">
                <!--- Output error message to screen or log file --->
                <cfdump var="#cfcatch#">
            </cfcatch>
        </cftry>
    </cffunction>
     --->

    <cffunction name="updateUserAvailability" access="remote" returntype="void" output="true">
        <cfargument name="p_id" type="numeric" required="yes">
        <cfargument name="newAvailability" type="struct" required="yes">
    
        <!--- Loop through the newAvailability struct --->
        <cfloop collection="#newAvailability#" item="week_day">
            <cfset timeSlots = newAvailability[week_day]>
          <cfdump var="#timeSlots#">
            <!--- First, delete existing user_slots for this week_day --->
            <cfquery name="deleteUserSlotsByWeekDay" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM user_slots
                WHERE planner_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">
                AND DAYOFWEEK(slot_start) = <cfqueryparam value="#week_day#" cfsqltype="cf_sql_integer">
            </cfquery>
                <!--- Debugging: Output the timeSlots array --->
            <cfset writeDump(var=timeSlots, label="timeSlots array")>
            <cfset writeLog(file="debug", text="timeSlots array: #serializeJSON(timeSlots)#")>
            <!--- Now, insert new time slots for this week_day --->
            <cfloop array="#timeSlots#" index="timeSlot">
                <cfset start_time = timeSlot.slot_start>
                <cfset end_time = timeSlot.slot_end>
                <!--- Debugging: Output the start_time and end_time variables --->
                <cfset writeDump(var=start_time, label="start_time")>
                <cfset writeDump(var=end_time, label="end_time")>
                <cfset writeLog(file="debug", text="start_time: #start_time#; end_time: #end_time#")>
                    
                <cfquery name="insertUserSlots" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_slots (planner_id, slot_start, slot_end)
                    VALUES (
                        <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#start_time#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#end_time#" cfsqltype="cf_sql_timestamp">
                    )
                </cfquery>
            </cfloop>
        </cfloop>
    </cffunction>
        
</cfcomponent>
    

