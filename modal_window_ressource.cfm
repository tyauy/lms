


<cfif isdefined("new_quiz")>

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.*, m.module_name, m.module_id 
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id
LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
WHERE tp.tpmaster_id <> 15 AND tp.tpmaster_prebuilt = 0
ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank
</cfquery>	

<form action="db_updater_quiz.cfm">
<table class="table">
	<tr>
		<td>Resource</td>
		<td>
		<select name="sessionmaster_id" class="form-control">	
		<cfoutput query="get_session_access" group="tpmaster_level">
		<optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
			<cfoutput group="tpmaster_id">
			<optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
				<cfoutput group="module_id">
				<optgroup label="------- #ucase(module_name)#">
					<cfoutput>						
					<option value="#sessionmaster_id#">#sessionmaster_id# - #sessionmaster_name#</option>				
					</cfoutput>
				</optgroup>
				</cfoutput>
			</optgroup>
			</cfoutput>
		</optgroup>
		</cfoutput>
		</select>
		</td>
	</tr>
	<tr>
		<td>Type quiz</td>
		<td>
		<select name="quiz_type" class="form-control">	
			<option value="unit">Validation Quiz</option>
			<option value="exercice">Exercice</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Quiz name</td>
		<td>
		<input type="text" name="quiz_name" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Quiz description</td>
		<td>
		<textarea name="quiz_description" class="form-control"></textarea>
		</td>
	</tr>
</tr>
<tr>
<td colspan="2" align="center">
	<input type="hidden" name="act" value="ins_quiz">
	<input type="submit" class="btn btn-info" value="Save">
</td>
</tr>
</table>
</form>

<cfelseif isdefined("new_question")>

<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
SELECT material_id, material_url FROM lms_material ORDER BY material_id DESC
</cfquery>	

<form action="db_updater_quiz.cfm">

	<table class="table table-sm mt-2">
		<tr>
			<td class="bg-light" width="25%">Category / Competence</td>
			<td>
			<select name="qu_category" class="form-control form-control-sm">
				<optgroup label=" - ">
					<option value="1" selected>Grammar</option>
					<option value="2"> Vocabular</option>
					<option value="3"> Reading comprehension</option>
					<option value="4"> Listening comprehension</option>
					<option value="5"> Comprehension</option>												
				</optgroup>
				<optgroup label="Toiec">
					<option value="6">Part 1</option>
					<option value="7">Part 2</option>
					<option value="8">Part 3</option>
					<option value="9">Part 4</option>
					<option value="10">Part 5</option>
					<option value="11">Part 6</option>
					<option value="12">Part 7</option>
				</optgroup>
			</select>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%">Question type</td>
			<td>
			<select name="qu_type" class="form-control form-control-sm">
				<option value="radio" selected>Radio (unique possible choice)</option>
				<option value="checkbox"> Checkbox (multiple possible choice)</option>
				<option value="text">Text field (1 unique possible choice)</option>
				<option value="select">Dropdown fields (choice in a list)</option>
			</select>
			</td>
		</tr>
		<tr>
			<td class="bg-light">Timer in sec (leave empty if no need)</td>
			<td><input name="qu_timer" type="text" class="form-control form-control-sm" placeholder="integer value only !!!" value="60"></input></td>
		</tr>
		<tr>
			<td class="bg-light">Instruction</td>
			<td><textarea name="qu_title" class="form-control form-control-sm"></textarea></td>
		</tr>
		<tr>
			<td class="bg-light">Content<br>For blank field, copy paste : _____</td>
			<td><textarea name="qu_text" id="qu_text" class="form-control form-control-sm"></textarea></td>
		</tr>
		<tr>
			<td class="bg-light">Content 1 : material attached</td>
			<td>
				<select name="material_id" class="form-control form-control-sm">
					<option value="0">---no attached material---</option>
					<cfoutput query="get_material">
					<option value="#material_id#">#material_url#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<td class="bg-light">Content 2 : material attached</td>
			<td>
				<select name="material_id" class="form-control form-control-sm">
					<option value="0">---no attached material---</option>
					<cfoutput query="get_material">
					<option value="#material_id#">#material_url#</option>
					</cfoutput>
				</select>
			</td>
		</tr>

	</table>
	
	<div align="center">
	<input type="hidden" name="act" value="ins_question">
	<cfoutput>
	<input type="hidden" name="quiz_id" value="#quiz_id#">
	</cfoutput>
	<input type="submit" value="Insert question" class="btn btn-sm btn-info">								
	</div>
								
		
</form>

<cfelseif isdefined("new_resource")>

<cfquery name="get_tp_master" datasource="#SESSION.BDDSOURCE#">
SELECT tpmaster_id, CONCAT(tpmaster_level, " - ", tpmaster_name) as tpmaster_name FROM lms_tpmaster2 
WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
AND tpmaster_prebuilt = 0
ORDER BY tpmaster_level
</cfquery>

<cfform action="db_updater_syllabus.cfm">
<table class="table">
<tr>
<td>Category</td>
<td>
<cfselect class="form-control" name="tpmaster_id" query="get_tp_master" display="tpmaster_name" value="tpmaster_id">
</cfselect>
</td>
</tr>
<tr>
<td>Name</td>
<td><input type="text" name="sessionmaster_name" class="form-control"></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" class="btn btn-info" value="Save"></td>
</tr>
</table>
</cfform>

<cfelseif isdefined("new_vocab")>
<form action="db_updater_resource.cfm">
<table class="table">
	<tr>
		<td>Vocab list default (EN)</td>
		<td>
		<input type="text" name="voc_cat_name" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Vocab list FR</td>
		<td>
		<input type="text" name="voc_cat_name_fr" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Vocab list EN</td>
		<td>
		<input type="text" name="voc_cat_name_en" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Vocab list DE</td>
		<td>
		<input type="text" name="voc_cat_name_de" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Vocab list ES</td>
		<td>
		<input type="text" name="voc_cat_name_es" class="form-control">
		</td>
	</tr>
	<tr>
		<td>Vocab list IT</td>
		<td>
		<input type="text" name="voc_cat_name_it" class="form-control">
		</td>
	</tr>
	
</tr>
<tr>
<td colspan="2" align="center">
	<input type="hidden" name="act" value="ins_voc_cat">
	<input type="submit" class="btn btn-info" value="Save">
</td>
</tr>
</table>
</form>
</cfif>