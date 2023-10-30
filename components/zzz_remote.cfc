<cfcomponent output="false">

	<!--- i set returnformat to plain and do my own serialization.  im sure CF's would work, but this is working for me
	so i'm not gonna change it now, make sure the access is set to remote. --->
	<cffunction name="getEvents" access="remote" output="false" returntype="string" returnformat="json">

		<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT l.*, m.method_name_#SESSION.LANG_CODE# as method_name, t.type_name_#SESSION.LANG_CODE# as type_name, (SELECT COUNT(user_id) as nb FROM lms_lesson_participant WHERE lesson_id = l.lesson_id) as nb_user
		FROM lms_lesson l
		INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
		INNER JOIN lms_lesson_type t ON t.type_id = l.type_id
		</cfquery>
		
		<!---<cfquery name="get_tz" datasource="#SESSION.BDDSOURCE#">
		SELECT timezone_lag FROM settings_timezone WHERE timezone_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tz_id#">
		</cfquery>--->

				<!--- an array to hold the items --->
		<cfset var result = [] />

		<cfoutput query="get_lesson">

			<cfset var obj = {} />

			<cfset obj["id"] = lesson_id>

			<cfset obj["title"] = method_name>

			<cfset obj["allDay"] = false>

			<cfset obj["editable"] = false>

			<!--- if its an all day event, I set the start time to midnight and end time to 11:23:59 PM, otherwise I use
			the start/end times from the DB --->
			<!--- also, format the dates in the proper format --->
			
			<cfif obj["allDay"]>
				<cfset obj["start"] = dateFormat(lesson_start,'yyyy-mm-dd') & 'T00:00:00Z' />
				<cfset obj["end"] = dateFormat(dateAdd('d',-1,lesson_end),'yyyy-mm-dd') & "T23:59:59Z" />
			<cfelse>
				<cfset obj["start"] = dateFormat(lesson_start,'yyyy-mm-dd') & 'T' & timeFormat(lesson_start,'HH:mm:ss') & 'Z' />
				<cfset obj["end"] = dateFormat(lesson_end,'yyyy-mm-dd') & 'T' & timeFormat(lesson_end,'HH:mm:ss') & 'Z' />
			</cfif>

			<!--- set a URL for the event --->
			<cfset obj["url"] = "">

			<!--- append each event object to the array --->
			<cfset arrayAppend(result,duplicate(obj)) />

		</cfoutput>

		<!--- full calendar expects JSON so serialize it --->
		<cfreturn serializeJson(result) />

	</cffunction>

</cfcomponent>