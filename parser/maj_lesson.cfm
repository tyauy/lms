<!---
<cfset dir_go = "#SESSION.BO_ROOT#/assets/signature/">
<cfset dir_rel = "../assets/signature/">
<cfoutput>#dir_go#</cfoutput>

<table>
<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
		
		<cfif dirQuery.recordcount eq "0">
			<tr>
				<td colspan="2" align="center"><em>Aucun fichier</em></td>
			</tr>
		<cfelse>
		
			<cfoutput>
			<cfloop query="dirQuery">
			<cfset name_go = listgetat(name,1,".")>
			
			<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_lesson2 SET lesson_signed = 1 WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#name_go#">
			</cfquery>
			
			<tr>
				<th class="bg-light" width="30%">
				<label>Fichier</label>
				</th>
				<td colspan="2">
				<a href="#dir_rel#/#name#" target="_blank">#name_go#</a>
				</td>
			</tr>
			
			</cfloop>
			</cfoutput>
		
		</cfif>
		
		
</table>



<cfabort>--->


<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT l.lesson_id, tps.sessionmaster_id FROM lms_lesson2 l
INNER JOIN lms_tpsession tps ON tps.session_id = l.session_id
INNER JOIN lms_tp tp ON tp.tp_id = tps.tp_id
WHERE l.session_id IS NOT NULL AND tp.user_id = 712
LIMIT 100
</cfquery>


<cfoutput query="get_lesson">
<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_lesson2 SET sm_id = #sessionmaster_id# WHERE lesson_id = #lesson_id#
</cfquery>
</cfoutput>

