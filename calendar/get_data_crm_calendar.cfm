<!------------------------------GET TASK & OPPORT ----------------------------->
<cfif isdefined("get_task") OR isdefined("get_opport") OR isdefined("a_id")>
<cfsilent>
<cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
SELECT t.task_id, tt.task_type_name, tt.task_group, t.task_date_start, t.task_date_end, t.task_date_close, t.account_id, a.account_name
FROM task t
INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
INNER JOIN account a ON a.account_id = t.account_id
WHERE (1 = 2
<cfif isdefined("get_task")> OR tt.task_group = "task"</cfif>
<cfif isdefined("get_opport")> OR tt.task_group = "opport"</cfif>
<!---<cfif isdefined("account_id")> OR account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#"></cfif>--->
) 
</cfquery>

<cfset table_task = arraynew(1)>

<cfoutput query="get_task">
	<cfset temp = arrayAppend(table_task, structNew())>
	
	<!----ID ----->
	<cfset table_task[currentrow].id = task_id>
	
	<!----TITLE ----->
	<cfset table_task[currentrow].title = account_name&" - "&task_type_name>
	
	<!----START ----->
	<cfset table_task[currentrow].start = dateformat(task_date_start, "yyyy-mm-dd")&"T"&TimeFormat(task_date_start, "HH:mm:ss")>
	
	<!----COLOR ----->	
	<cfif task_group eq "task">
		<cfif isdefined("a_id") AND a_id neq account_id>
			<cfset table_task[currentrow].color = "##333333">
		<cfelse>
			<cfif task_date_close eq "">
				<cfset table_task[currentrow].color = "##f0ad4e">
			<cfelse>
				<cfset table_task[currentrow].color = "##ECECEC">
			</cfif>
		</cfif>
	<cfelseif task_group eq "opport">
		<cfset table_task[currentrow].allDay = true>
		<cfif isdefined("a_id") AND a_id neq account_id>
			<cfset table_task[currentrow].color = "##333333">
		<cfelse>
			<cfif task_date_close eq "">
				<cfset table_task[currentrow].color = "##5cb85c">
			<cfelse>
				<cfset table_task[currentrow].color = "##ECECEC">
			</cfif>
		</cfif>			
	</cfif>
		
	<!----END ----->	
	<cfset table_task[currentrow].end = dateformat(task_date_end, "yyyy-mm-dd")&"T"&TimeFormat(task_date_end, "HH:mm:ss")>
	
	<!----EDITABLE ----->
	<cfset table_task[currentrow].editable = true>
	
</cfoutput>

<cfset table_js = SerializeJSON(table_task)>
<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"ALLDAY","allDay","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"URL","url","ALL")>
<cfset table_js = replacenocase(table_js,"CLASSNAME","className","ALL")>
<cfset table_js = replacenocase(table_js,"EDITABLE","editable","ALL")>
<cfset table_js = replacenocase(table_js,"STARTEDITABLE","startEditable","ALL")>
<cfset table_js = replacenocase(table_js,"DURATIONEDITABLE","durationEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEEDITABLE","resourceEditable","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"OVERLAP","overlap","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"SOURCE","source","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"BACKGROUNDCOLOR","backgroundColor","ALL")>
<cfset table_js = replacenocase(table_js,"BORDERCOLOR","borderColor","ALL")>
<cfset table_js = replacenocase(table_js,"TEXTCOLOR","textColor","ALL")>

</cfsilent>
<cfoutput>#table_js#</cfoutput>
</cfif>
