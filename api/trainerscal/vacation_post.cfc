  <cfcomponent>
    <cffunction name="addHolidays" access="remote" returntype="string">
   
 <cfargument name="formDataJson" required="yes">
   <!--- Deserialize the JSON data --->
   <cfset formData = DeserializeJSON(arguments.formDataJson)>
   <cfset p_id=formData.p_id>



        <!--- create an empty response dictionary and set default status to "success" --->
        <cfset response = {}>
        <cfset response["status"] = "success">
         <!--- create an empty list to store added days --->
        <cfset addedDays = "">
     
        <cftry>
            <cfset start_send=formData.start>
            <cfset end_send=formData.end>
            <cfset start_send = ParseDateTime(start_send)>
            <cfset end_send = ParseDateTime(end_send)>
            
            <cfset dateDiffDays = DateDiff("d", start_send, end_send) +1>
            
            <cfloop from="1" to="#dateDiffDays#" index="i"><!--- check if the current date already exists in the user_holidays table --->
                <cfset currentDate = DateAdd("d", i-1, start_send)>
                   <cfoutput> #DateFormat(currentDate, "dd/mm/yyyy")#<br></cfoutput>
            <cfquery name="checkHoliday" datasource="#SESSION.BDDSOURCE#">
                SELECT * FROM user_holidays 
                WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer"> 
                AND start_date = <cfqueryparam value="#currentDate#" cfsqltype="cf_sql_date">
            </cfquery>
             <!--- if the date does not exist, insert it into the user_holidays table --->
             <cfif checkHoliday.recordcount eq 0>

                    <cfquery name="addHoliday" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO user_holidays (user_id, start_date, end_date) 
                        VALUES (
                        <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#currentDate#" cfsqltype="cf_sql_date">,
                        <cfqueryparam value="#currentDate#" cfsqltype="cf_sql_date">)
                    </cfquery>
                     <!-- Add the currentDate to the addedDays list -->
                <cfset addedDays = ListAppend(addedDays, DateFormat(currentDate, "dd/mm/yyyy"))>
              </cfif>  

              <!--- Delete slots for the added holiday day --->
              <cfquery name="deleteHolidaySlots" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM user_slots
                WHERE planner_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">
                AND DATE(slot_start) = <cfqueryparam value="#currentDate#" cfsqltype="cf_sql_date">
            </cfquery>
            </cfloop>
         
              
                
            <cfmail from="service@wefitgroup.com" to="efiliondonato@wefitgroup.com" subject="Holiday Insert Successful" type="html" server="localhost">
                "The following days have been added as holidays: #addedDays# for trainer id: #p_id#" 
            </cfmail>
               <!--- send an email with the list of added days --->
                <cfset emailAddress = "efiliondonato@wefitgroup.com, trainer@wefitgroup.com">
                <cfset subject = "Holiday Insert Successful">
                <cfset message = "The following days have been added as holidays: #addedDays#">
                <cfset fromEmail = "service@wefitgroup.com">
                
                <cfset sendEmail(emailAddress, subject, message, fromEmail)>
                <!--- catch any errors and update the response dictionary with an "error" status and the error message --->
                <cfcatch>
                <cfset response["status"] = "error">
                <cfset response["message"] = "An error occurred while inserting the holiday days into the database: #cfcatch.message#">
                </cfcatch>
                </cftry>
                <!--- return the response dictionary as a JSON string --->
                <cfreturn SerializeJSON(response)> 
               




</cffunction>

                <cffunction name="deleteHolidays" access="remote" returntype="string">
                    <cfargument name="id" required="yes">
                    <cfargument name="p_id" required="yes">
                    
                    <cfset response = {}>
                    <cfset response["status"] = "success">
                    <cftry>
                        <cfquery name="checkHoliday" datasource="#SESSION.BDDSOURCE#">
                            SELECT * FROM user_holidays 
                            WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
                        </cfquery>
                        <cfif checkHoliday.recordcount gt 0>
                            <cfquery name="deleteHoliday" datasource="#SESSION.BDDSOURCE#">
                                DELETE FROM user_holidays
                                WHERE id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
                            </cfquery>
                             <cfset dayOfWeek = (DayOfWeek(checkHoliday.start_date)-1)mod 7>
                             <cflog text="Day of week: #dayOfWeek#" type="information" application="yes" file="BO_LMS_LIVE">
                             
                            <cfdump var="#dayOfWeek#" >
                            <!-- Fetch the working hours for the user -->
                            <cfquery name="getUserWorkingHours" datasource="#SESSION.BDDSOURCE#">
                                SELECT * FROM user_business_hours
                                WHERE user_id = <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">
                                AND week_day = <cfqueryparam value="#DayOfWeek(dayOfWeek)#" cfsqltype="cf_sql_integer">
                            </cfquery>
                             <cfdump var="#getUserWorkingHours#" >
                            <cflog text="User working hours fetched: #getUserWorkingHours.recordcount#" type="information" application="yes" file="BO_LMS_LIVE">
                            <!-- Check if the day is part of the business days -->
                            <cfif getUserWorkingHours.recordcount gt 0>
                                <!-- Insert slots for the deleted holiday day -->
                                <cfloop query="getUserWorkingHours">
                                    <cfquery name="insertHolidaySlots" datasource="#SESSION.BDDSOURCE#">
                                        INSERT INTO user_slots (planner_id, slot_start, slot_end)
                                        VALUES (
                                            <cfqueryparam value="#p_id#" cfsqltype="cf_sql_integer">,
                                            <cfqueryparam value="#DateFormat(checkHoliday.start_date, 'yyyy-mm-dd')# #TimeFormat(getUserWorkingHours.start_time, 'HH:mm')#" cfsqltype="cf_sql_timestamp">,
                                            <cfqueryparam value="#DateFormat(checkHoliday.start_date, 'yyyy-mm-dd')# #TimeFormat(getUserWorkingHours.end_time, 'HH:mm')#" cfsqltype="cf_sql_timestamp">
                                        )
                                    </cfquery>
                                    <cflog text="Inserted slot for user: #p_id# start: #DateFormat(dayOfWeek, 'yyyy-mm-dd')# #TimeFormat(getUserWorkingHours.start_time, 'HH:mm')# end: #DateFormat(checkHoliday.start_date, 'yyyy-mm-dd')# #TimeFormat(getUserWorkingHours.end_time, 'HH:mm')#" type="information" application="yes" file="BO_LMS_LIVE">
                                </cfloop>
                            </cfif>
                        </cfif>
                        
                        <cfcatch>
                            <cfset response["status"] = "error">
                            <cfset response["message"] = "An error occurred while deleting the holiday days from the database: #cfcatch.message#">
                        </cfcatch>
                    </cftry>
                    <cfreturn SerializeJSON(response)>
                </cffunction>
                
        </cfcomponent>
        