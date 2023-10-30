<!------------------------------GET ACCOUNT ----------------------------->
<cfif isdefined("type_id") AND isdefined("get_account")>
<cfoutput>#obj_provider.get_account(type_id)#</cfoutput>
</cfif>

<!------------------------------GET OPPORT ----------------------------->
<cfif isdefined("task_type_id") AND isdefined("get_opport")>
<cfoutput>#obj_provider.get_opport(task_type_id)#</cfoutput>
</cfif>

<!------------------------------GET CONTACT ----------------------------->
<cfif isdefined("get_contact")>
<cfoutput>#obj_provider.get_contact()#</cfoutput>
</cfif>

<!------------------------------GET ORDER ----------------------------->
<cfif isdefined("status_id") AND isdefined("get_invoice")>
<cfoutput>#obj_provider.get_order(status_id)#</cfoutput>
</cfif>

<!------------------------------GET LOGS ----------------------------->
<cfif isdefined("get_log")>
<cfoutput>#obj_provider.get_log()#</cfoutput>
</cfif>


<!------------------------------GET LESSON ----------------------------->
<cfif isdefined("get_lesson")>

<cfsilent>

<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT s.*, st.lesson_type_name, (SELECT COUNT(user_id) as nb FROM lms_lesson_participant WHERE lesson_id = s.lesson_id) as nb_user
FROM lms_lesson s
INNER JOIN lms_lesson_type st ON st.lesson_type_id = s.lesson_type_id
WHERE lesson_status = "planned" OR lesson_status = "absent"
</cfquery>

<cfset table_lesson = arraynew(1)>

<cfoutput query="get_lesson">

	<cfset temp = arrayAppend(table_lesson, structNew())>
	<cfset table_lesson[currentrow].lesson_id = lesson_id>
	<cfset table_lesson[currentrow].id = lesson_id>
	<!---<cfset table_lesson[currentrow].title = lesson_type_name>--->
	<cfset table_lesson[currentrow].trainer_name = "#nb_user#">
	<cfset table_lesson[currentrow].title = lesson_name>
	
	<cfset table_lesson[currentrow].start = dateformat(lesson_start, "yyyy-mm-dd")&"T"&TimeFormat(lesson_start, "HH:mm:ss")>
	<cfset table_lesson[currentrow].end = dateformat(lesson_end, "yyyy-mm-dd")&"T"&TimeFormat(lesson_end, "HH:mm:ss")>
		
	<cfif lesson_status eq "absent">	
		<cfset table_lesson[currentrow].color = "##d9534f">
		<cfset table_lesson[currentrow].status = "<span class=\'label label-danger label-as-badge\'>Absent</span>">
	<cfelse>
		<cfif lesson_end gt now()>	
			<cfset table_lesson[currentrow].color = lesson_color>
			<cfset table_lesson[currentrow].status = "<span class=\'label label-success label-as-badge\'>Programm&eacute;</span>">
		<cfelse>
			<cfset table_lesson[currentrow].color = "##CCCCCC">
			<cfset table_lesson[currentrow].status = "<span class=\'label label-gray label-as-badge\'>Consomm&eacute;</span>">					
		</cfif>
	</cfif>
	<!---<cfif lesson_rendering neq ""><cfset table_lesson[currentrow].rendering = lesson_rendering></cfif>--->
	<!---<cfif lesson_end gt now()><cfset table_lesson[currentrow].editable = true></cfif>--->
	<cfset table_lesson[currentrow].editable = true>
	<cfset table_lesson[currentrow].constraint = "trainer_available">
	
</cfoutput>

<cfset table_js = SerializeJSON(table_lesson)>
<cfset table_js = replacenocase(table_js,"LESSON_ID","LESSON_ID","ALL")>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>

</cfsilent><cfoutput>#table_js#</cfoutput><cfabort>

</cfif>