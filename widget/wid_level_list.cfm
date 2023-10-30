<cfparam name="_skill_id">
<cfparam name="u_id">
<cfparam name="formation_id" default="2">
<cfparam name="formation_code" default="EN">
<cfparam name="show_desc" default="1">


<cfquery name="get_level_list" datasource="#SESSION.BDDSOURCE#">
	SELECT l.level_alias, ls.level_sub_name, ls.level_sub_id, ls.level_sub_css
	FROM lms_level_sub ls
	INNER JOIN lms_level l ON l.level_id = ls.level_id
	WHERE l.level_id NOT IN (6)
</cfquery>

<cfloop list="#_skill_id#" index="skill_cor">

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
	SELECT l.level_alias, ls.level_sub_name, ls.level_sub_css, ls.level_sub_id, lf.feedback_text_#SESSION.LANG_CODE# as feedback_text, 
	lskill.skill_name_#SESSION.LANG_CODE# as skill_name
	FROM user_level ul
	INNER JOIN lms_level_sub ls ON ul.level_sub_id = ls.level_sub_id
	INNER JOIN lms_level l ON l.level_id = ls.level_id
	LEFT JOIN lms_feedback lf ON lf.level_sub_id = ul.level_sub_id AND lf.skill_sub_id = ul.skill_id
	LEFT JOIN lms_skill lskill ON lskill.skill_id = lf.skill_id
	WHERE ul.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	AND ul.skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#skill_cor#">
	AND ul.formation_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
</cfquery>

<!--- <cfdump var="#get_level_list#">
<cfdump var="#get_level#"> --->

<!--- <cfoutput query="get_level">
	<cfset css = "#level_sub_css#">

		<label class="btn btn-sm btn-#level_alias#">
			<input type="radio" name="level_id" value="#level_sub_id#" autocomplete="off" required id="level_sub_id_#level_sub_id#">
			#level_sub_name#
		</label>

</cfoutput> --->


<table class="table bg-white table-borderless border border-info borderless">

	<tr align="center">
		<td class="bg-white text-info" rowspan="2" width="150">

		<cfoutput><img src="./assets/img/qpt_#formation_code#.jpg" align="center"></cfoutput>
		
		<br>Niveau</td>

		<td align="left">
			<div class="btn-group-toggle" data-toggle="buttons">

				<cfoutput query="get_level_list">
					<cfset css = "#level_sub_css#">

					<cfif level_sub_id eq get_level.level_sub_id>
						<label class="btn btn-sm btn-#css# text-white active">
							<input type="radio" checked name="level_id" id="feedid_#_skill_id#_selected" value="#level_sub_name#" autocomplete="off" required> 
							#replace(level_sub_name,"_",".")#
						</label>
					<cfelse>
						<label class="btn btn-sm btn-outline-#css# <cfif get_level.recordCount neq 0>disabled</cfif>">
							<input type="radio" name="level_id" id="feedid_#_skill_id#_#level_sub_id#" class="level_select" value="#level_sub_name#" autocomplete="off" required> 
							#replace(level_sub_name,"_",".")#
						</label>
					</cfif>
					
				</cfoutput>
			</div>
		</td>	
		
	</tr>
</table>


<cfif show_desc eq 1 AND get_level.feedback_text neq "">
	<table class="table bg-light table-borderless border">
		<tr align="center">
		
			<td class="bg-light text-muted" width="150">
			<!--- <img src="./assets/img/support_all.jpg" align="center"> --->
			<!--- <i class="fal fa-hiking fa-2x"></i> --->
			<i class="fa-thin fa-chart-user fa-2x"></i>
			
			<br>Aptitudes</td>
			<td align="left">	
				<!--- <strong>Spoken Interaction</strong>
				<p>
					Can easily give brief reasons for opinions<br>
					Can easily discuss family, hobbies, work, travel and news/current affairs<br>
				</p> --->
				<strong><cfoutput>#get_level.skill_name#</cfoutput></strong>
				<p>
					<cfoutput>#replacenocase(get_level.feedback_text,chr(10),"<br>")#</cfoutput>
				</p>
			</td>
		</tr>
	</table>
</cfif>
</cfloop>