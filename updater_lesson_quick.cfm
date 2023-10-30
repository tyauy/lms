<cfif isdefined("faction") AND isdefined("l_id") AND (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>

	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
	<cfset date_select = dateformat(get_lesson.lesson_start,'yyyy-mm-dd')>

	<cfif faction eq "scheduled">

		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2
		SET	status_id = 1,
		updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		updater_date = now()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
	<cfelseif faction eq "cancelled">


		<cfinvoke component="api/tp/tp_post" method="cancel_tp" returnvariable="res">
			<cfinvokeargument name="l_id" value="#l_id#">
		</cfinvoke>
			

	<cfelseif faction eq "missed">

		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2
		SET	status_id = 4,
		updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		updater_date = now(),
		completed_date = now()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

	<cfelseif faction eq "missed_unbookable">

		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2
		SET	status_id = 4, lesson_unbookable = 1,
		updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		updater_date = now(),
		completed_date = now()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
		<cfif get_lesson.sessionmaster_id eq "694" OR get_lesson.sessionmaster_id eq "695">
		
			<cfif get_lesson.sessionmaster_id eq "694">
				<cfset subject = "[LMS] | Forced missed PTA | #get_lesson.learner_firstname# #get_lesson.learner_lastname#">

				<cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
					<cfinvokeargument name="task_type_id" value="240">
					<cfinvokeargument name="u_id" value="#u_id#">
					<cfinvokeargument name="task_channel_id" value="6">
				</cfinvoke>

				
			<cfelseif get_lesson.sessionmaster_id eq "695">
				<cfset subject = "[LMS] | Forced missed 1st Lesson | #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
			</cfif>
			
			<cfmail from="W-LMS <service@wefitgroup.com>" to="rremacle@wefitgroup.com,service@wefitgroup.com,finance@wefitgroup.com,trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = "fr">
				<cfset status = "missed">
				<cfset recipient = "learner">
				<cfinclude template="./email/email_lesson_status.cfm">
			</cfmail>
		
		</cfif>
		
	<cfelseif faction eq "inprogress">

		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2
		SET	status_id = 2,
		updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		updater_date = now()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
		
	<cfelseif faction eq "completed">

		<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2
		SET	status_id = 5,
		updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		updater_date = now(),
		completed_date = now()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>

	<cfelseif faction eq "erase">
		
		<cfquery name="del_lesson" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_lesson2	WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>
		
		<cfquery name="del_lessonnote" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_lesson_note WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>

		<cfquery name="del_lessonatt" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_lesson2_attendance WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>
	</cfif>

	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&p_id=#p_id#&date_select=#date_select#">

</cfif>