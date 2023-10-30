
<cfabort>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_lesson2 l
	LEFT JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id
	WHERE la.attendance_id IS NULL AND l.tp_id IS NOT NULL 
	AND l.status_id IN (1,5,2)
	GROUP BY l.tp_id
</cfquery>
<!--- AND l.lesson_start > now() --->

<!--- <cfoutput query="get_lesson" >
    <cftry>
		<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
			
			INSERT INTO `lms_lesson2_attendance`(`lesson_id`, `user_id`, lesson_signed) VALUES (
				#get_lesson.lesson_id#,
				#get_lesson.user_id#,
				#get_lesson.lesson_signed#
				)
		</cfquery>
    <cfcatch type="any"></cfcatch>
    </cftry>
</cfoutput> --->


<cfdump var="#get_lesson#">

<cfoutput query="get_lesson" >

	
    <cftry>
		#tp_id#
		<!--- <cfquery name="insert_attendance" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_lesson2_attendance(
				lesson_id, 
				tp_id,
				user_id
				) 
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				)
		</cfquery> --->
		<cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_lesson2_attendance(lesson_id, tp_id, user_id)
			SELECT 
			lesson_id,
			tp_id,
			user_id
			FROM lms_lesson2 
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
			AND status_id IN (1,5,2)
		</cfquery>
		<!--- <cfif lesson_signed eq 1>
			<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_lesson2_attendance SET
				lesson_signed = 1
				WHERE lesson_id = #lesson_id#
			</cfquery>
		</cfif> --->
		<!--- <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2_attendance SET
			tp_id = #get_lesson.tp_id#
			WHERE lesson_id = #get_lesson.lesson_id#
		</cfquery> --->
    <cfcatch type="any"></cfcatch>
    </cftry>
</cfoutput>