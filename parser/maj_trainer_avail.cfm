<!--- <cfset startTime = createDateTime(2020,1,1,0,0,0)>  
<cfset endTime = createDateTime(2020,1,31,23,59,59)> --->
<cfset startTime = createTime(0,0,0)>  
<cfset endTime = createTime(23,59,59)>

<cfloop index="temp" from="#startTime#" to="#endTime#" step="#CreateTimeSpan(0,0,15,0)#">
    <cfdump var="#timeformat(temp,'HH:mm:ss')#">
    <!--- <cfdump var="#lsDateTimeFormat(temp,'yyyy-mm-dd HH:nn:ss')#"> --->
    </br>

    <!--- TODO ON 1 month / years ? --->
    <!--- <cfset date_link = dateformat(dateadd("n",15,date_ref),'yyyy-mm-dd')> --->

    <cfquery name="user_slot_avail_index" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO `user_slot_avail_index`(
            `slot`
            )
        VALUES (
            <cfqueryparam cfsqltype="cf_sql_TIME" value="#lsTimeFormat(temp,'HH:mm:ss')#">
            )
    </cfquery>
    <!--- <cfqueryparam cfsqltype="cf_sql_TIMESTAMP" value="#lsDateTimeFormat(temp,'yyyy-mm-dd HH:nn:ss')#"> --->

</cfloop>

<!--- lsDateTimeFormat min -> nn / timeformat min -> mm --->

<!--- ! 1 day  --->
<!--- SELECT usai.slot FROM `user_slot_avail_index` usai INNER JOIN user_slots s ON usai.slot >= DATE_FORMAT(s.slot_start,'%H:%i:%S') AND usai.slot <= DATE_FORMAT(s.slot_end,'%H:%i:%S') WHERE s.planner_id = 8039 AND DATE_FORMAT(s.slot_start,'%Y-%m-%d') = '2022-01-28' AND usai.slot NOT IN (SELECT usai.slot FROM `user_slot_avail_index` usai INNER JOIN lms_lesson2 l2 ON usai.slot >= DATE_FORMAT(l2.lesson_start,'%H:%i:%S') AND usai.slot <= DATE_FORMAT(l2.lesson_end,'%H:%i:%S') WHERE l2.planner_id = 8039 AND DATE_FORMAT(l2.lesson_start,'%Y-%m-%d') = '2022-01-28') ORDER BY `usai`.`slot` ASC --->
<!--- ! any nb of day --->
<!--- SELECT usai.slot, DATE_FORMAT(s.slot_start,'%Y-%m-%d') as date, CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) as fulldate
FROM `user_slot_avail_index` usai 
INNER JOIN user_slots s ON usai.slot >= DATE_FORMAT(s.slot_start,'%H:%i:%S') AND usai.slot <= DATE_FORMAT(s.slot_end,'%H:%i:%S') 
WHERE s.planner_id = 8039 AND s.slot_start BETWEEN '2022-01-24' AND '2022-01-30'
AND CONCAT(DATE_FORMAT(s.slot_start,'%Y-%m-%d'), " ",usai.slot) NOT IN (
    SELECT CONCAT(DATE_FORMAT(l2.lesson_start ,'%Y-%m-%d'), " ",usai.slot) as fulldate2 FROM `user_slot_avail_index` usai 
    INNER JOIN lms_lesson2 l2 ON usai.slot >= DATE_FORMAT(l2.lesson_start,'%H:%i:%S') AND usai.slot <= DATE_FORMAT(l2.lesson_end,'%H:%i:%S') 
    WHERE l2.planner_id = 8039 AND l2.lesson_start BETWEEN '2022-01-24' AND '2022-01-30')
ORDER BY `usai`.`slot` ASC, date --->

