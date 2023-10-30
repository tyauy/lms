<!--------------------REMOVE AVAILABILITIES // ADD BLOCKER-------------------------->
<cfif isdefined("updt_avail") AND isdefined("blocker_name") AND isdefined("avail_choice") AND isdefined("form") AND isdefined("p_id") AND isdefined("lesson_st") AND isdefined("lesson_en") AND avail_choice eq "remove">

	<cfif SESSION.USER_PROFILE eq "trainer">
		<cfset p_id = SESSION.USER_ID>
	</cfif>
	
	<cfset l_duration = DateDiff("n", lesson_st, lesson_en)>
	
	<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_lesson2
	(
	blocker_id,
	lesson_name,
	lesson_start,
	lesson_end,
	lesson_duration,
	planner_id,
	booker_id
	)
	VALUES
	(
	1,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#blocker_name#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#lesson_st#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#lesson_en#">,	
	<cfqueryparam cfsqltype="cf_sql_integer" value="#l_duration#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	)	
	</cfquery>

	<cfif SESSION.USER_PROFILE eq "TRAINER">

		<cflocation addtoken="no" url="trainer_calendar.cfm?k=1&picker=#dateformat(lesson_st,'yyyymmdd')#">
	
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

		<cflocation addtoken="no" url="common_trainer_blocker.cfm?p_id=#p_id#&k=1&picker=#dateformat(lesson_st,'yyyymmdd')#">
	
	</cfif>

</cfif>





<!--------------------REMOVE BLOCKER-------------------------->
<cfif isdefined("del_blocker") AND isdefined("b_id") AND isdefined("p_id")>

	<cfif SESSION.USER_PROFILE eq "trainer">
		<cfset p_id = SESSION.USER_ID>
	</cfif>
	
	<cfquery name="get_blocker" datasource="#SESSION.BDDSOURCE#">
	SELECT lesson_start FROM lms_lesson2 WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#b_id#">
	</cfquery>
	
	<cfquery name="del_blocker" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_lesson2
	WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#b_id#">
	AND planner_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#p_id#">
	</cfquery>

	<cfif SESSION.USER_PROFILE eq "trainer">

		<cflocation addtoken="no" url="trainer_calendar.cfm?k=1&picker=#dateformat(get_blocker.lesson_start,'yyyymmdd')#">
	
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

		<cflocation addtoken="no" url="common_trainer_blocker.cfm?p_id=#p_id#&k=1&picker=#dateformat(get_blocker.lesson_start,'yyyymmdd')#">
	
	</cfif>

</cfif>




<!--------------------ADD AVAILABILITIES // CREATE SLOTS-------------------------->
<cfif isdefined("updt_avail") AND isdefined("avail_choice") AND isdefined("form") AND isdefined("p_id") AND isdefined("lesson_en") AND isdefined("lesson_st") AND avail_choice eq "add">
		
	
	<cfset up_avail = obj_user_trainer_post.add_avail_slot(p_id=p_id,lesson_st=lesson_st,lesson_en=lesson_en)>


	<cfif SESSION.USER_PROFILE eq "trainer">

		<cflocation addtoken="no" url="trainer_calendar.cfm?k=1&picker=#dateformat(lesson_st,'yyyymmdd')#">
	
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

		<cflocation addtoken="no" url="common_trainer_blocker.cfm?p_id=#p_id#&k=1&picker=#dateformat(lesson_st,'yyyymmdd')#">
	
	</cfif>

</cfif>



<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	<!--------------------MANAGER AVAILABILITIES-------------------------->
	<cfif isdefined("form") AND isdefined("availability_updt") AND isdefined("p_id") AND isdefined("choice_calendar")>


		<cfif isdefined("choice_calendar") AND (choice_calendar eq "maj_only" OR choice_calendar eq "maj_both")>

			<cfquery name="updt_workinghour" datasource="#SESSION.BDDSOURCE#">
			UPDATE user_workinghour
			SET
			<cfif isdefined("day_mon_start_am") OR isdefined("day_mon_start_pm")>day_mon = 1,<cfelse>day_mon = null,</cfif>
			<cfif isdefined("day_mon_start_am")>day_mon_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_start_am#:00">,<cfelse>day_mon_start_am = null,</cfif>
			<cfif isdefined("day_mon_end_am")>day_mon_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_end_am#:00">,<cfelse>day_mon_end_am = null,</cfif>
			<cfif isdefined("day_mon_start_pm")>day_mon_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_start_pm#:00">,<cfelse>day_mon_start_pm = null,</cfif>
			<cfif isdefined("day_mon_end_pm")>day_mon_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_mon_end_pm#:00">,<cfelse>day_mon_end_pm = null,</cfif>
			<cfif isdefined("day_tue_start_am") OR isdefined("day_tue_start_pm")>day_tue = 1,<cfelse>day_tue = null,</cfif>
			<cfif isdefined("day_tue_start_am")>day_tue_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_start_am#:00">,<cfelse>day_tue_start_am = null,</cfif>
			<cfif isdefined("day_tue_end_am")>day_tue_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_end_am#:00">,<cfelse>day_tue_end_am = null,</cfif>
			<cfif isdefined("day_tue_start_pm")>day_tue_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_start_pm#:00">,<cfelse>day_tue_start_pm = null,</cfif>
			<cfif isdefined("day_tue_end_pm")>day_tue_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_tue_end_pm#:00">,<cfelse>day_tue_end_pm = null,</cfif>
			<cfif isdefined("day_wed_start_am") OR isdefined("day_wed_start_pm")>day_wed = 1,<cfelse>day_wed = null,</cfif>
			<cfif isdefined("day_wed_start_am")>day_wed_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_start_am#:00">,<cfelse>day_wed_start_am = null,</cfif>
			<cfif isdefined("day_wed_end_am")>day_wed_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_end_am#:00">,<cfelse>day_wed_end_am = null,</cfif>
			<cfif isdefined("day_wed_start_pm")>day_wed_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_start_pm#:00">,<cfelse>day_wed_start_pm = null,</cfif>
			<cfif isdefined("day_wed_end_pm")>day_wed_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_wed_end_pm#:00">,<cfelse>day_wed_end_pm = null,</cfif>
			<cfif isdefined("day_thu_start_am") OR isdefined("day_thu_start_pm")>day_thu = 1,<cfelse>day_thu = null,</cfif>
			<cfif isdefined("day_thu_start_am")>day_thu_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_start_am#:00">,<cfelse>day_thu_start_am = null,</cfif>
			<cfif isdefined("day_thu_end_am")>day_thu_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_end_am#:00">,<cfelse>day_thu_end_am = null,</cfif>
			<cfif isdefined("day_thu_start_pm")>day_thu_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_start_pm#:00">,<cfelse>day_thu_start_pm = null,</cfif>
			<cfif isdefined("day_thu_end_pm")>day_thu_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_thu_end_pm#:00">,<cfelse>day_thu_end_pm = null,</cfif>
			<cfif isdefined("day_fri_start_am") OR isdefined("day_fri_start_pm")>day_fri = 1,<cfelse>day_fri = null,</cfif>
			<cfif isdefined("day_fri_start_am")>day_fri_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_start_am#:00">,<cfelse>day_fri_start_am = null,</cfif>
			<cfif isdefined("day_fri_end_am")>day_fri_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_end_am#:00">,<cfelse>day_fri_end_am = null,</cfif>
			<cfif isdefined("day_fri_start_pm")>day_fri_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_start_pm#:00">,<cfelse>day_fri_start_pm = null,</cfif>
			<cfif isdefined("day_fri_end_pm")>day_fri_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_fri_end_pm#:00">,<cfelse>day_fri_end_pm = null,</cfif>
			<cfif isdefined("day_sat_start_am") OR isdefined("day_sat_start_pm")>day_sat = 1,<cfelse>day_sat = null,</cfif>
			<cfif isdefined("day_sat_start_am")>day_sat_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_start_am#:00">,<cfelse>day_sat_start_am = null,</cfif>
			<cfif isdefined("day_sat_end_am")>day_sat_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_end_am#:00">,<cfelse>day_sat_end_am = null,</cfif>
			<cfif isdefined("day_sat_start_pm")>day_sat_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_start_pm#:00">,<cfelse>day_sat_start_pm = null,</cfif>
			<cfif isdefined("day_sat_end_pm")>day_sat_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sat_end_pm#:00">,<cfelse>day_sat_end_pm = null,</cfif>
			<cfif isdefined("day_sun_start_am") OR isdefined("day_sun_start_pm")>day_sun = 1,<cfelse>day_sun = null,</cfif>
			<cfif isdefined("day_sun_start_am")>day_sun_start_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_start_am#:00">,<cfelse>day_sun_start_am = null,</cfif>
			<cfif isdefined("day_sun_end_am")>day_sun_end_am = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_end_am#:00">,<cfelse>day_sun_end_am = null,</cfif>
			<cfif isdefined("day_sun_start_pm")>day_sun_start_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_start_pm#:00">,<cfelse>day_sun_start_pm = null,</cfif>
			<cfif isdefined("day_sun_end_pm")>day_sun_end_pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#day_sun_end_pm#:00"><cfelse>day_sun_end_pm = null</cfif>
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
			</cfquery>

			
			
		</cfif>


	<cfif isdefined("choice_calendar") AND choice_calendar eq "maj_both">


		<!------- 1 - CLEAN ALL ----->
		<cfquery name="clean_all" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

		<!------- 2 - CREATE SLOTS ----->
		
		<!------ CF TRICK FOR DATEPICKER -------------->
		<cfif day(date_schedule_from) lte "12">
			<cfset date_schedule_from = "#dateformat(date_schedule_from,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_schedule_from = "#dateformat(date_schedule_from,'yyyy-mm-dd')#">
		</cfif>	

		<cfif day(date_schedule_to) lte "12">
			<cfset date_schedule_to = "#dateformat(date_schedule_to,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_schedule_to = "#dateformat(date_schedule_to,'yyyy-mm-dd')#">
		</cfif>	
		
		
		<!---- LOOP OVER DATE RANGE --->
		<cfloop index="dtDay" from="#date_schedule_from#" to="#date_schedule_to#" step="#CreateTimeSpan(1,0,0,0)#"> 
			<cfoutput>
			
			<cfset nbday = obj_dater.getdayofweek(dtDay)>
			
			<cfif nbday eq "1">
				<cfset nameday = "mon">
			<cfelseif nbday eq "2">
				<cfset nameday = "tue">
			<cfelseif nbday eq "3">
				<cfset nameday = "wed">
			<cfelseif nbday eq "4">
				<cfset nameday = "thu">
			<cfelseif nbday eq "5">
				<cfset nameday = "fri">
			<cfelseif nbday eq "6">
				<cfset nameday = "sat">
			<cfelseif nbday eq "7">
				<cfset nameday = "sun">
			</cfif>
			
			<cfif isdefined("day_#nameday#_start_am") AND isdefined("day_#nameday#_end_am")>
				On parle du #DateFormat(dtDay)# -     DAY OF WEEK = #nbday# donc #listgetat(SESSION.DAYWEEK_FR,nbday)#<br>
			
				<cfset final_start = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_start_am')#:00">
				<cfset final_end = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_end_am')#:00">

				<!--- <cfquery name="insert_availability" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_slots
				(
				planner_id,
				slot_start,
				slot_end
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_start#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_end#">
				)
				</cfquery> --->
				<cfset up_avail = obj_user_trainer_post.add_avail_slot(p_id=p_id,lesson_st=final_start,lesson_en=final_end)>
			
			</cfif>
			
			<cfif isdefined("day_#nameday#_start_pm") AND isdefined("day_#nameday#_end_pm")>

				On parle du #DateFormat(dtDay)# -     DAY OF WEEK = #nbday# donc #listgetat(SESSION.DAYWEEK_FR,nbday)#<br>
			
				<cfset final_start = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_start_pm')#:00">
				<cfset final_end = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_end_pm')#:00">

				<!--- <cfquery name="insert_availability" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_slots
				(
				planner_id,
				slot_start,
				slot_end
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_start#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_end#">
				)
				</cfquery> --->
				<cfset up_avail = obj_user_trainer_post.add_avail_slot(p_id=p_id,lesson_st=final_start,lesson_en=final_end)>
				
			
			</cfif>
			
			
			</cfoutput>
		</cfloop>



	<cfelseif isdefined("choice_calendar") AND choice_calendar eq "maj_adjust">

		<!------ CF TRICK FOR DATEPICKER -------------->
		<cfif day(date_adjust_from) lte "12">
			<cfset date_adjust_from = "#dateformat(date_adjust_from,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_adjust_from = "#dateformat(date_adjust_from,'yyyy-mm-dd')#">
		</cfif>	

		<cfif day(date_adjust_to) lte "12">
			<cfset date_adjust_to = "#dateformat(date_adjust_to,'yyyy-dd-mm')#">
		<cfelse>
			<cfset date_adjust_to = "#dateformat(date_adjust_to,'yyyy-mm-dd')#">
		</cfif>	
		
		<!------- 1 - ANYWAY, CLEAN PAST AVAILABLE SLOTS ----->
		<cfquery name="clean_past" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND slot_start < now()
		</cfquery>
		
		<!------- 2 - CLEAN AVAILABLE SLOTS INSIDE DATE RANGE FOR TEMP CAL ----->
		<cfloop index="dtDay" from="#date_adjust_from#" to="#date_adjust_to#" step="#CreateTimeSpan(1,0,0,0)#"> 
		<cfset temp_date = "#dateFormat(dtDay,'yyyy-mm-dd')#">
		<cfquery name="clean_temp" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND DATE_FORMAT(slot_start,'%Y-%m-%d') = '#temp_date#' 
		</cfquery>
		</cfloop>
		
		<!------- 3 - CREATE SLOTS ----->
				
		<!---- LOOP OVER DATE RANGE --->
		<cfloop index="dtDay" from="#date_adjust_from#" to="#date_adjust_to#" step="#CreateTimeSpan(1,0,0,0)#"> 
			<cfoutput>
			
			<cfset nbday = obj_dater.getdayofweek(dtDay)>
			
			<cfif nbday eq "1">
				<cfset nameday = "mon">
			<cfelseif nbday eq "2">
				<cfset nameday = "tue">
			<cfelseif nbday eq "3">
				<cfset nameday = "wed">
			<cfelseif nbday eq "4">
				<cfset nameday = "thu">
			<cfelseif nbday eq "5">
				<cfset nameday = "fri">
			<cfelseif nbday eq "6">
				<cfset nameday = "sat">
			<cfelseif nbday eq "7">
				<cfset nameday = "sun">
			</cfif>
			
			<cfif isdefined("day_#nameday#_start_am") AND isdefined("day_#nameday#_end_am")>
				On parle du #DateFormat(dtDay)# -     DAY OF WEEK = #nbday# donc #listgetat(SESSION.DAYWEEK_FR,nbday)#<br>
			
				<cfset final_start = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_start_am')#:00">
				<cfset final_end = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_end_am')#:00">

				<!--- <cfquery name="insert_availability" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_slots
				(
				planner_id,
				slot_start,
				slot_end
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_start#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_end#">
				)
				</cfquery> --->
				<cfset up_avail = obj_user_trainer_post.add_avail_slot(p_id=p_id,lesson_st=final_start,lesson_en=final_end)>
			
			</cfif>
			
			<cfif isdefined("day_#nameday#_start_pm") AND isdefined("day_#nameday#_end_pm")>

				On parle du #DateFormat(dtDay)# -     DAY OF WEEK = #nbday# donc #listgetat(SESSION.DAYWEEK_FR,nbday)#<br>
			
				<cfset final_start = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_start_pm')#:00">
				<cfset final_end = "#dateFormat(dtDay,'yyyy-mm-dd')# #evaluate('day_#nameday#_end_pm')#:00">

				<!--- <cfquery name="insert_availability" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_slots
				(
				planner_id,
				slot_start,
				slot_end
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_start#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#final_end#">
				)
				</cfquery> --->
				<cfset up_avail = obj_user_trainer_post.add_avail_slot(p_id=p_id,lesson_st=final_start,lesson_en=final_end)>
				
			
			</cfif>
			
			</cfoutput>

		</cfloop>
				
	</cfif>

	<cflocation addtoken="no" url="common_trainer_avail.cfm?k=1&p_id=#p_id#">

	</cfif>

</cfif>