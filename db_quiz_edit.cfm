<!DOCTYPE html>

<cfsilent>	
		
	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>

	<cfquery name="get_mapping" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM lms_mapping
		where formation_id=2
		</cfquery>
	<cfquery name="get_quiz_mapping" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM lms_quiz lq
		INNER JOIN lms_quiz_mapping_cor lqmc ON lqmc.quiz_id = lq.quiz_id
		left join lms_mapping lm on lqmc.mapping_id=lm.mapping_id
		WHERE lq.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>
	<cfquery name="get_questions" datasource="#SESSION.BDDSOURCE#">
	SELECT lm.mapping_name, qq.qu_id, qq.qu_text, qc.qu_ranking, qq.sessionmaster_id, qq.qu_category_id, qu_category, q.quiz_id, qq.qu_timer, qq.qu_type
	FROM lms_quiz_question qq
	INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
	INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
	left join lms_quiz_question_mapping_cor lqqmc on lqqmc.qu_id=qq.qu_id
	left join lms_mapping lm on lm.mapping_id=lqqmc.mapping_id
	WHERE q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	ORDER BY qc.qu_ranking ASC
	</cfquery>
	
	<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
	SELECT material_id, material_url FROM lms_material ORDER BY material_id DESC
	</cfquery>	

	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.*, q.quiz_id, tp.*, m.module_name, m.module_id 
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id
	LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
	INNER JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
	WHERE tp.tpmaster_id <> 15 AND tp.tpmaster_prebuilt = 0
	ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank
	</cfquery>	
	
	<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
	SELECT *
	FROM lms_quiz_question qq
	INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
	INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
	WHERE q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#"> 
	<cfif not isdefined("qu_id")>
	AND qu_ranking = 1
	<cfelse>
	AND qq.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfif>
	ORDER BY qc.qu_ranking ASC
	</cfquery>
	
	<cfif not isdefined("qu_id")>
		<cfset qu_select = get_question.qu_id>
	<cfelse>
		<cfset qu_select = qu_id>
	</cfif>
		
	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.*, q.quiz_id, tp.*, m.module_name, m.module_id 
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id
	LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
	INNER JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
	WHERE tp.tpmaster_id <> 15 AND tp.tpmaster_prebuilt = 0
	ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank
	</cfquery>	
		
		
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>
    <!-- Typeahead CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-typeahead/2.11.0/jquery.typeahead.min.css" rel="stylesheet">

	<!-- Typeahead JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-typeahead/2.11.0/jquery.typeahead.min.js"></script>
	
<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Quiz list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<cfif isdefined("mat_id")>
				<cfquery name="get_mat_uploaded" datasource="#SESSION.BDDSOURCE#">
				SELECT material_url FROM lms_material WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mat_id#">
				</cfquery>
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em><cfoutput>Content correctly uploaded - name of the file : #get_mat_uploaded.material_url#</cfoutput></em></div>
				</div>
			</cfif>
			
			<cfif isdefined("k")>
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em>Question duplicated !</em></div>
				</div>
			</cfif>
			
				<div class="row">
					
					<div class="col-lg-9">
						
						<div class="card border-top border-info">
						
							<div class="card-body">
						
								
								<h5 class="card-title">Quiz : <cfoutput>#get_quiz.quiz_name#</cfoutput></h5>
								
								<button class="btn btn-sm btn-primary pull-right" type="button" data-toggle="collapse" data-target="#collapse_quiz" aria-expanded="false" aria-controls="collapse_search">+</button>
								
								<div class="collapse" id="collapse_quiz">
								<form action="db_updater_quiz.cfm" method="post">
								
								<table class="table table-sm mt-2">
									<tr>
										<td class="bg-light" width="25%">
											Attached to resource
										</td>
										<td>
											<select name="sessionmaster_id" class="form-control form-control-sm">
											<cfoutput query="get_session_access" group="tpmaster_level">
											<optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
											<cfoutput group="tpmaster_id">
											<optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
											<cfoutput group="module_id">
											<optgroup label="------- #ucase(module_name)#">							
											
											<cfoutput>
											<option value="#sessionmaster_id#" <cfif get_quiz.sessionmaster_id eq sessionmaster_id>selected</cfif>>#sessionmaster_id# - #sessionmaster_name#</option>				
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
									<cfoutput query="get_quiz">
									<tr>
										<td class="bg-light" width="25%">Type quiz</td>
										<td>
											<select name="quiz_type" class="form-control form-control-sm">
												<option value="unit" <cfif quiz_type eq "unit">selected</cfif>>Validation Quiz</option>
												<option value="exercice" <cfif quiz_type eq "exercice">selected</cfif>>Exercice</option>
												<option value="toeic" <cfif quiz_type eq "toeic">selected</cfif>>TOEIC</option>
											</select>
										</td>
										<tr>
											<td class="bg-light">Quiz name</td>
											<td>
											<input type="text" name="quiz_name" class="form-control form-control-sm" value="#quiz_name#">
											</td>
										</tr>
										<tr>
											<td class="bg-light">Quiz description</td>
											<td>
											<textarea name="quiz_description" class="form-control form-control-sm">#quiz_description#</textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Is online</td>
											<td>
											<input type="radio" name="quiz_active" value="1" <cfif quiz_active eq "1">checked</cfif>>Online
											&nbsp;&nbsp;&nbsp;
											<input type="radio" name="quiz_active" value="0" <cfif quiz_active eq "0">checked</cfif>>Offline
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="25%">Quiz Mapping</td>
											<td>
												<cfloop query="get_quiz_mapping" group="mapping_id">
													<div>
														<input type="checkbox" id="mapping_#get_quiz_mapping.mapping_id#" name="mapping_#get_quiz_mapping.mapping_id#" value="#get_quiz_mapping.mapping_id#" checked onclick="if(!this.checked){if(confirm('confirmer suppression ?')){document.location.href='db_updater_quiz.cfm?act=del_mapping&mapping_id=#get_quiz_mapping.mapping_id#&quiz_id=#get_quiz_mapping.quiz_id#'}}">
														<label for="mapping_#get_quiz_mapping.mapping_id#">ID: #get_quiz_mapping.mapping_id# - #get_quiz_mapping.mapping_name#</label>
													</div>
													
												</cfloop>
												  
											
													<form id="form-global_search" name="global_search">
														<div class="typeahead__container">
															<div class="typeahead__field">
																<div class="typeahead__query">
																	<input class="js_typeahead_mapping" name="mapping[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
																	</input>
																</div>
															</div>
														</div>
													</form>
											
												
				
											</td>
										</tr>
										
								
									</tr>
								</table>
								
								<div align="center">
									<input type="hidden" name="act" value="updt_quiz">
									<cfif isdefined("qu_id")>
									<input type="hidden" name="qu_id" value="#qu_id#">
									</cfif>
									<input type="hidden" name="quiz_id" value="#quiz_id#">
									<input type="submit" value="Update quiz" class="btn btn-sm btn-info">								
								</div>
								
								</cfoutput>
								</form>
								</div>
								
							</div>
							
						</div>
						
						<div class="card border-top border-info">
						
							<div class="card-body">
								
								<h5 class="card-title d-inline">Question <cfif isdefined("get_question.qu_ranking")><cfoutput>#get_question.qu_ranking#</cfoutput></cfif></h5>
								<button class="btn btn-sm btn-primary pull-right btn_create_question" type="button">Add question</button>
								<cfoutput>
								<button onclick="if(confirm('confirmer suppression ?')){document.location.href='db_updater_quiz.cfm?act=del_qu&quiz_id=#quiz_id#&qu_id=#qu_select#'}" class="btn btn-sm btn-danger pull-right btn_del_question" type="button">Delete question</button>
								</cfoutput>
								<cfif get_question.recordcount neq "0">
								<form action="db_updater_quiz.cfm" method="post">
								<cfoutput query="get_question">								
								<table class="table table-sm mt-2">
									<tr>
										<td class="bg-light">Rank</td>
										<td><input name="qu_ranking" type="number" class="form-control form-control-sm" placeholder="integer value only !!!" value="#qu_ranking#"></input></td>
									</tr>
									<tr>
										<td class="bg-light" width="25%">Category / Competence</td>
										<td>
										<select name="qu_category" class="form-control form-control-sm">
											<optgroup label=" - ">
												<option value="1" <cfif qu_category_id eq 1>selected</cfif>>Grammar</option>
												<option value="2" <cfif qu_category_id eq 2>selected</cfif>>Vocabular</option>
												<option value="3" <cfif qu_category_id eq 3>selected</cfif>>Reading comprehension</option>
												<option value="4" <cfif qu_category_id eq 4>selected</cfif>>Listening comprehension</option>
												<option value="5" <cfif qu_category_id eq 5>selected</cfif>>Comprehension</option>												
											</optgroup>
											<optgroup label="Toiec">
												<option value="6" <cfif qu_category_id eq 6>selected</cfif>>Part 1</option>
												<option value="7" <cfif qu_category_id eq 7>selected</cfif>>Part 2</option>
												<option value="8" <cfif qu_category_id eq 8>selected</cfif>>Part 3</option>
												<option value="9" <cfif qu_category_id eq 9>selected</cfif>>Part 4</option>
												<option value="10" <cfif qu_category_id eq 10>selected</cfif>>Part 5</option>
												<option value="11" <cfif qu_category_id eq 11>selected</cfif>>Part 6</option>
												<option value="12" <cfif qu_category_id eq 12>selected</cfif>>Part 7</option>
											</optgroup>
											<!---
											<optgroup label="Français">
												<option value="Compréhension" <cfif qu_category eq "Compréhension">selected</cfif>>Compréhension</option>
												<option value="Compréhension écrite" <cfif qu_category eq "Compréhension écrite">selected</cfif>>Compréhension écrite</option>
												<option value="Compréhension orale" <cfif qu_category eq "Compréhension orale">selected</cfif>>Compréhension orale</option>
												<option value="Grammaire" <cfif qu_category eq "Grammaire">selected</cfif>>Grammaire</option>
												<option value="Vocabulaire" <cfif qu_category eq "Vocabulaire">selected</cfif>>Vocabulaire</option>							
											</optgroup>
											<optgroup label="English">
												<option value="Comprehension" <cfif qu_category eq "Comprehension">selected</cfif>>Comprehension</option>
												<option value="Reading Comprehension" <cfif qu_category eq "Reading Comprehension">selected</cfif>>Reading Comprehension</option>
												<option value="Listening Comprehension" <cfif qu_category eq "Listening Comprehension">selected</cfif>>Listening Comprehension</option>
												<option value="Grammar" <cfif qu_category eq "Grammar">selected</cfif>>Grammar</option>
												<option value="Vocabulary" <cfif qu_category eq "Vocabulary">selected</cfif>>Vocabulary</option>							
											</optgroup>
											<optgroup label="German">
												<option value="Grammatik" <cfif qu_category eq "Grammatik">selected</cfif>>Grammatik</option>
												<option value="Vokabular" <cfif qu_category eq "Vokabular">selected</cfif>>Vokabular</option>
												<option value="Wortschatz" <cfif qu_category eq "Wortschatz">selected</cfif>>Wortschatz</option>
												<option value="Leseverstehen" <cfif qu_category eq "Leseverstehen">selected</cfif>>Leseverstehen</option>
												<option value="Hörverstehen" <cfif qu_category eq "Hörverstehen">selected</cfif>>Hörverstehen</option>
											</optgroup>
											<optgroup label="Espagnol">
												<option value="Gramática" <cfif qu_category eq "Gramática">selected</cfif>>Gramática</option>
												<option value="Vocabulario" <cfif qu_category eq "Vocabulario">selected</cfif>>Vocabulario</option>
												<option value="Comprensión auditiva" <cfif qu_category eq "Comprensión auditiva">selected</cfif>>Comprensión auditiva</option>
												<option value="Comprensión" <cfif qu_category eq "Comprensión">selected</cfif>>Comprensión</option>
											</optgroup>
											<optgroup label="Portugues">
												<option value="Gramática" <cfif qu_category eq "Gramática">selected</cfif>>Gramática</option>
												<option value="Vocabulário" <cfif qu_category eq "Vocabulário">selected</cfif>>Vocabulário</option>
												<option value="Leitura" <cfif qu_category eq "Leitura">selected</cfif>>Leitura</option>
											</optgroup>
											<optgroup label="Toeic">
												<option value="Part 1" <cfif qu_category eq "Part 1">selected</cfif>>Part 1</option>
												<option value="Part 2" <cfif qu_category eq "Part 2">selected</cfif>>Part 2</option>
												<option value="Part 3" <cfif qu_category eq "Part 3">selected</cfif>>Part 3</option>
												<option value="Part 4" <cfif qu_category eq "Part 4">selected</cfif>>Part 4</option>
												<option value="Part 5" <cfif qu_category eq "Part 5">selected</cfif>>Part 5</option>
												<option value="Part 6" <cfif qu_category eq "Part 6">selected</cfif>>Part 6</option>						
												<option value="Part 7" <cfif qu_category eq "Part 7">selected</cfif>>Part 7</option>
												<option value="Part 8" <cfif qu_category eq "Part 8">selected</cfif>>Part 8</option>																	
											</optgroup>
											--->
										</select>
										</td>
									</tr>
									<tr>
										<td class="bg-light" width="25%">Question type</td>
										<td>
										<select name="qu_type" class="form-control form-control-sm">
											<option value="radio" <cfif qu_type eq "radio">selected</cfif>>Radio (unique possible choice)</option>
											<option value="checkbox" <cfif qu_type eq "checkbox">selected</cfif>>Checkbox (multiple possible choice)</option>
											<option value="text" <cfif qu_type eq "text">selected</cfif>>Text field (1 unique possible choice)</option>
											<option value="select" <cfif qu_type eq "select">selected</cfif>>Dropdown fields (choice in a list)</option>
										</select>
										</td>
									</tr>
									<tr>
										<td class="bg-light">Timer in sec (leave empty if no need)</td>
										<td><input name="qu_timer" type="text" class="form-control form-control-sm" placeholder="integer value only !!!" value="#qu_timer#"></input></td>
									</tr>
									<tr>
										<td class="bg-light">Instruction<br>(top)</td>
										<td><input type="text" name="qu_title" class="form-control form-control-sm" value="#qu_title#"></td>
									</tr>
									<tr>
										<td class="bg-light">Content<br>(text, email, document to read)</td>
										<td><textarea name="qu_text" id="qu_text" class="form-control form-control-sm">#qu_text#</textarea></td>
									</tr>
									<tr>
										<td class="bg-light">Final Question<br>(for blank field, copy paste : _____)</td>
										<td><textarea name="qu_header" id="qu_header" class="form-control form-control-sm">#qu_header#</textarea></td>
									</tr>
									<tr>
										<td class="bg-light">Tip<br>(just before the anwsers)</td>
										<td><input type="text" name="qu_advise" class="form-control form-control-sm" value="#qu_advise#"></td>
									</tr>
									<tr>
										<td class="bg-light">Content 1: material attached</td>
										<td>
											<select name="material_id" class="form-control form-control-sm">
												<option value="0">---no attached material---</option>
												<cfloop query="get_material">
												<option value="#get_material.material_id#" 
												<cfif listlen(get_question.material_id) neq "0">
													<cfif get_material.material_id eq listgetat(get_question.material_id,1)>selected</cfif>
												</cfif>>#get_material.material_url#</option>
												</cfloop>
											</select>
										</td>
										<td width="5%">
										<cfif listlen(get_question.material_id) neq "0">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,1)#.jpg")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,1)#.jpg" target="_blank">
										<img src="./assets/materials/material_#listgetat(get_question.material_id,1)#.jpg" width="40">
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,1)#.png")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,1)#.png" target="_blank">
										<img src="./assets/materials/material_#listgetat(get_question.material_id,1)#.png" width="40">
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,1)#.mp3")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,1)#.mp3" target="_blank">
										mp3
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,1)#.mp4")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,1)#.mp4" target="_blank">
										mp4
										</a>
										</cfif>		
										</cfif>
										</td>
									</tr>
									<tr>
										<td class="bg-light">Content 2: material attached</td>
										<td>
											<select name="material_id" class="form-control form-control-sm">
												<option value="0">---no attached material---</option>
												<cfloop query="get_material">
												<option value="#get_material.material_id#" 
												<cfif listlen(get_question.material_id) eq "2">
													<cfif get_material.material_id eq listgetat(get_question.material_id,2)>selected</cfif>
												</cfif>>#get_material.material_url#</option>
												</cfloop>
											</select>
										</td>
										<td width="5%">
										<cfif listlen(get_question.material_id) eq "2">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,2)#.jpg")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,2)#.jpg" target="_blank">
										<img src="./assets/materials/material_#listgetat(get_question.material_id,2)#.jpg" width="40">
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,2)#.png")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,2)#.png" target="_blank">
										<img src="./assets/materials/material_#listgetat(get_question.material_id,2)#.png" width="40">
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,2)#.mp3")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,2)#.mp3" target="_blank">
										mp3
										</a>
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/material_#listgetat(get_question.material_id,2)#.mp4")>
										<a href="./assets/materials/material_#listgetat(get_question.material_id,2)#.mp4" target="_blank">
										mp4
										</a>
										</cfif>										
										</cfif>
										</td>
									</tr>

								</table>
								
								<div align="center">
								<input type="hidden" name="act" value="updt_qu">
								<input type="hidden" name="quiz_id" value="#quiz_id#">
								<input type="hidden" name="qu_id" value="#qu_select#">
								<input type="submit" value="Update question" class="btn btn-sm btn-info">								
								</div>
								</cfoutput>
								</form>
								</cfif>
								
								<cfif get_question.recordcount neq "0">
								<h5 class="card-title">Answer(s)</h5>
								
									<cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
									SELECT COUNT(DISTINCT(sub_id)) as nbsub
									FROM lms_quiz_answer
									WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_select#">
									</cfquery>
									
									<cfloop from="1" to="#get_sub.nbsub#" index="sub_id">	
									<table class="table table-bordered table-sm table-striped m-0">
										<tr>
											<td colspan="10">Answer set N&deg; <cfoutput>#sub_id#</cfoutput></td>
										</tr>
											<cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
											SELECT ans_id, ans_text, sub_id, ans_iscorrect, ans_gain, ans_type
											FROM lms_quiz_answer
											WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_select#"> AND sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#"> ORDER BY ans_id
											</cfquery>
											
											<cfoutput query="get_answer">
											<form action="db_updater_quiz.cfm" method="post">
											<table class="table table-bordered table-sm table-striped m-0">											
											<tr>
												<td width="5%" align="center"><cfif ans_iscorrect eq "1">
													<i class="fas fa-check" style="color:##1eff00"></i>
													<cfelse>
													<i class="fas fa-times" style="color:##ea1000"></i>
													</cfif>
												</td>
													
												<td width="20%">
												<input type="text" name="ans_text" value="#ans_text#" class="form-control">
												</td>
												
												<!---<td width="15%">
													<select name="attach" class="form-control form-control-sm">
														<option value="0">---attach material---<option>
													</select>
												</td>--->
												
												<td width="10%">
												<select name="ans_iscorrect" class="form-control form-control-sm">
													<option value="0" <cfif ans_iscorrect eq "0">selected</cfif>>false</option>
													<option value="1" <cfif ans_iscorrect eq "1">selected</cfif>>true</option>
												</select>
												</td>
												
												<td width="10%">
												<select name="ans_gain" class="form-control form-control-sm">

													<option value="0" <cfif ans_gain eq 0>selected</cfif>>0 pt</option>
													<option value="0.25" <cfif ans_gain eq "0.25">selected</cfif>>0.25 pt</option>
													<option value="0.33" <cfif ans_gain eq "0.33">selected</cfif>>0.33 pt</option>
													<option value="0.34" <cfif ans_gain eq "0.34">selected</cfif>>0.34 pt</option>
													<option value="0.50" <cfif ans_gain eq "0.50">selected</cfif>>0.50 pt</option>

													<cfloop from="1" to="8" index="cor">
														<option value="#cor#" <cfif ans_gain eq cor>selected</cfif>>#cor# pt</option>
													</cfloop>
												</select>
												</td>
												
												<td width="10%">
												<select name="ans_type" class="form-control form-control-sm">
													<option value="radio" <cfif get_question.qu_type eq "radio">selected<cfelse>disabled</cfif>>Radio</option>
													<option value="checkbox" <cfif get_question.qu_type eq "checkbox">selected<cfelse>disabled</cfif>>Checkbox</option>
													<option value="text" <cfif get_question.qu_type eq "text">selected<cfelse>disabled</cfif>>Text field</option>
													<option value="select" <cfif get_question.qu_type eq "select">selected<cfelse>disabled</cfif>>Dropdown fields</option>
												</select>
												</td>
												
												<td width="10%">
												<input type="hidden" name="act" value="updt_ans">
												<input type="hidden" name="quiz_id" value="#quiz_id#">
												<input type="hidden" name="qu_id" value="#qu_select#">
												<input type="hidden" name="ans_id" value="#ans_id#">
												<input type="submit" class="btn btn-sm btn-info" value="Updt">
								
													<a onclick="if(confirm('confirmer suppression ?')){document.location.href='db_updater_quiz.cfm?act=del_ans&quiz_id=#quiz_id#&qu_id=#qu_select#&ans_id=#ans_id#'}" href="##" class="btn btn-sm btn-danger">DEL</a>
												</td>
												
											</tr>
											</table>
											</form>
											</cfoutput>
											
											
									
									</table>
									</cfloop>
									
									<form action="db_updater_quiz.cfm" method="post">
										<table class="table table-bordered table-sm table-striped m-0">											
										<tr>
											<td width="5%" align="center">ADD</td>
												
											<td width="20%">
											<input type="text" name="ans_text" value="" class="form-control">
											</td>
											
											<!---<td width="15%">
												<select name="attach" class="form-control">
													<option value="0">---attach material---<option>
												</select>
											</td>--->
											
											<td width="10%">
											<select name="ans_iscorrect" class="form-control">
												<option value="0">false</option>
												<option value="1">true</option>
											</select>
											</td>
											
											<td width="10%">
											<select name="ans_gain" class="form-control">
												<cfloop from="0" to="8" index="cor">
												<cfoutput>
													<option value="#cor#">#cor# pt</option>
												</cfoutput>
												</cfloop>
											</select>
											</td>
											
											<td width="10%">
											<select name="ans_type" class="form-control">
												<option value="radio" <cfif get_question.qu_type eq "radio">selected<cfelse>disabled</cfif>>Radio</option>
												<option value="checkbox" <cfif get_question.qu_type eq "checkbox">selected<cfelse>disabled</cfif>>Checkbox</option>
												<option value="text" <cfif get_question.qu_type eq "text">selected<cfelse>disabled</cfif>>Text field</option>
												<option value="select" <cfif get_question.qu_type eq "select">selected<cfelse>disabled</cfif>>Dropdown fields</option>
											</select>
											</td>
											
											<td width="10%">
											<cfoutput>
											<input type="hidden" name="act" value="ins_ans">
											<input type="hidden" name="sub_id" value="1">
											<input type="hidden" name="quiz_id" value="#quiz_id#">
											<input type="hidden" name="qu_id" value="#qu_select#">
											<input type="submit" class="btn btn-sm btn-info" value="INSERT">
											</cfoutput>
											</td>
											
										</tr>
										</table>
										</form>
								</cfif>
								
							</div>
							
						</div>
						
								

						<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title">Full quiz view</h5>
								
								<button class="btn btn-sm btn-primary pull-right" type="button" data-toggle="collapse" data-target="#collapse_fullquiz" aria-expanded="false" aria-controls="collapse_fullquiz">+</button>
								  
								<div class="collapse" id="collapse_fullquiz">
    
								<br><br>	
								<table class="table table-sm">
									<tr bgcolor="#F3F3F3">
										<th>
										ID
										</th>
										<th>
										Comp&eacute;tence
										</th>
										<th>
										N&deg;
										</th>
										<th>
										Question
										</th>
										<th width="40%">
										Analyse r&eacute;ponse
										</th>
										<th>
											Mapping Point
										</th>
											
									</tr>
									<cfset counter = 0>
									<cfloop query="get_questions">
									<cfset counter ++>
									<cfif counter/2 eq round(counter/2)><cfset color_tr = "F2F2F2"><cfelse><cfset color_tr = "FFFFFF"></cfif>
									<tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
										<td><cfoutput>#get_questions.qu_id#</cfoutput></td>
										<td><cfoutput>#get_questions.qu_category#</cfoutput></td>
										<td><cfoutput>#get_questions.qu_ranking#</cfoutput></td>
										<td><cfoutput><strong>#get_questions.qu_timer# sec | #get_questions.qu_type#</strong><br>#get_questions.qu_text#</cfoutput></td>
										<td>

										<cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
										SELECT COUNT(DISTINCT(sub_id)) as nbsub
										FROM lms_quiz_answer
										WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
										</cfquery>
										
											<table class="table table-bordered table-sm">
											<cfloop from="1" to="#get_sub.nbsub#" index="sub_id">	
												<tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
												
													<cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
													SELECT ans_text, sub_id, ans_iscorrect
													FROM lms_quiz_answer
													WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
													</cfquery>
													
													<td width="50%">
													<!---<span class="label label-success">R&eacute;ponse(s) possibles</span><br>--->

													<cfoutput query="get_answer">
														<cfif ans_iscorrect eq "1">
														<i class="fas fa-check" style="color:##1eff00"></i> #ans_text#<br>
														<cfelse>
														<i class="fas fa-times" style="color:##ea1000"></i> #ans_text#<br>
														</cfif>
													</cfoutput>
													</td>
													
						

												</tr>
											
											</cfloop>	
										
											
											</table>
										
										</td>
										<td>
											<!-- Button to Open the Modal -->
											<button type="button" class="btn btn-primary mapping-btn" data-id="<cfoutput>#get_questions.qu_id#</cfoutput>">
												<cfif isDefined("get_questions.mapping_name") AND len(trim(get_questions.mapping_name))>
													<cfoutput>#get_questions.mapping_name#</cfoutput>
												<cfelse>
													N/A
												</cfif>
											</button>
											
										</td>
										
									</tr>
									
									</cfloop>
								</table>
								</div>
								
							</div>	
						</div>
						
					</div>
					<!-- The Modal -->

  
					
					<div class="col-lg-3">
					
						<!---<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title">Quiz</h5>
								
								<button class="btn btn-sm btn-primary pull-right" type="button" data-toggle="collapse" data-target="#collapse_search" aria-expanded="false" aria-controls="collapse_search">+</button>
								
								<div class="collapse" id="collapse_search">
								Validation & Exercice Quiz
								<select name="quiz_id" class="select_quiz form-control">
								
								<cfoutput query="get_session_access" group="tpmaster_level">
								<optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
									<cfoutput group="tpmaster_id">
									<optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
										<cfoutput group="module_id">
										<optgroup label="------- #ucase(module_name)#">										
											<cfoutput>
											<cfif quiz_id neq ""><option value="#quiz_id#" <cfif isdefined("url.quiz_id") AND url.quiz_id eq quiz_id>selected</cfif>>#sessionmaster_id# - #sessionmaster_name#</option></cfif>					
											</cfoutput>								
										</optgroup>
										</cfoutput>								
									</optgroup>
									</cfoutput>								
								</optgroup>
								</cfoutput>								
								</select>
								
								<br>
								
								Test Quiz
								<select name="quiz_id" class="select_quiz form-control">
								
								<cfoutput query="get_session_access" group="tpmaster_level">
								<optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
									<cfoutput group="tpmaster_id">
									<optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
										<cfoutput group="module_id">
										<optgroup label="------- #ucase(module_name)#">										
											<cfoutput>
											<cfif quiz_id neq ""><option value="#quiz_id#" <cfif isdefined("url.quiz_id") AND url.quiz_id eq quiz_id>selected</cfif>>#sessionmaster_id# - #sessionmaster_name#</option></cfif>					
											</cfoutput>								
										</optgroup>
										</cfoutput>								
									</optgroup>
									</cfoutput>								
								</optgroup>
								</cfoutput>								
								</select>
								
								</div>
								
							</div>
						
						</div>
						--->
						
						<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title">Media Library</h5>
								
								<button class="btn btn-sm btn-primary pull-right btn_upload_ressource" type="button">Upload file</button>
								
							</div>
							
						</div>
						
						<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title">Question List</h5>
								
								<table class="table table-sm table-striped mt-2">
									<tr bgcolor="#F3F3F3">
										<th>
										N&deg;
										</th>
										<th>
										Comp&eacute;tence
										</th>
										<th>
										Type
										</th>
										<th>
										Timer
										</th>
										<th>
										Action
										</th>
									</tr>
									<cfoutput query="get_questions">
									<tr <cfif get_questions.qu_id eq qu_select>class="bg-info"</cfif>>
										<td>#qu_ranking#</td>
										<td><small>#qu_category#</small></td>
										<td>#qu_type#</td>
										<td>#qu_timer#</td>
										<td><a onclick="if(confirm('confirme duplicate ?')){document.location.href='db_updater_quiz.cfm?act=duplicate_qu&quiz_id=#quiz_id#&qu_id=#qu_select#'}" href="##" class="btn btn-sm btn-warning"><i class="far fa-copy"></i></a>
										<a href="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#" class="btn btn-sm btn-outline-info float-right"><i class="fas fa-edit"></i></a>
										</td>
									</tr>
									</cfoutput>
								</table>
								
							</div>
							
						</div>
						
					</div>
					
				</div>
				
			</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-typeahead/2.11.0/jquery.typeahead.min.js"></script>


<script>
$( document ).ready(function() {
	

	$('.mapping-btn').on('click', function() {
         
    var qu_id = $(this).attr('data-id');

		<cfoutput>
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Mapping Point Description");
		$('##modal_body_lg').load("modal_window_mapping_description.cfm?qu_id=" + qu_id, function() {});
		</cfoutput>
    });
	var user_id = <cfoutput >
            #SESSION.USER_ID#
           </cfoutput>
	function getQueryParam(url, param) {
  const queryString = url.split('?')[1];
  const queryVars = queryString.split('&');
  
  for (let i = 0; i < queryVars.length; i++) {
    const [key, value] = queryVars[i].split('=');
    if (key === param) {
      return value;
    }
  }
  return null;
}

const url = window.location.href;
const quiz_id = getQueryParam(url, 'quiz_id');


    $.typeahead({
        input: '.js_typeahead_mapping',
        order: "desc",
        minLength: 1,
        maxItem: 15,
        emptyTemplate: 'Pas de resultats pour "{{query}}"',
        dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",
        group: {
            template: "{{group}}"
        },
        source: {
            <cfoutput query="get_mapping" group="mapping_category">
            "#encodeForJavaScript(mapping_category)#": {
                display: "mapping_name",
                href: "",
                data: [
                    <cfoutput>{
                        "mapping_id": #mapping_id#,
                        "mapping_name": "#encodeForJavaScript(trim(mapping_name))#"
                       
                    },</cfoutput>
                ]
            },
            </cfoutput>
        },
        template: function (query, item) {
            return '<input type="checkbox" class="mapping-checkbox" data-mapping-id="' + item.mapping_id + '"'  + '> ' + item.mapping_name;
        },
        callback: {
            onClick: function (node, a, item, event) {
                event.preventDefault();
				console.log(quiz_id)
    
                // Perform your update action using the mappingId and isChecked values
				var isChecked = node.find('input[type="checkbox"]').prop('checked') ? 1 : 0;
            var mappingId = item.mapping_id;

                $.ajax({
                    url: './api/quiz/quiz_post.cfc?method=update_quiz_mapping_cor',
                    method: 'POST',
                    data: {
                        q_id: quiz_id,
                        mapping_id: mappingId,
                        is_correct: isChecked,
                        user_id: user_id
                    },
                    success: function(result, status) {
                        console.log("Server response:", result);
                        alert("Record updated successfully");
                        location.reload(); 
                    },

                    error: function(xhr, status, error) {
                        console.log("Error updating record:", status, error);
                        console.log("Response content:", xhr.responseText);
                    }
                });
            }
        }
    });


	$('.select_quiz').change(function(event) {		
		document.location.href="db_quiz_list.cfm?quiz_id="+$(this).val();	
	});
	
	<cfoutput>
	$('.btn_create_question').click(function(event) {	
		event.preventDefault();		
		/*var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);*/
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Ajouter question");
		$('##modal_body_lg').load("modal_window_ressource.cfm?new_question=1&quiz_id=#quiz_id#", function() {});
	});
	</cfoutput>	
	
	tinymce.init({
		selector:'#qu_text',
		branding: false,
		contextmenu: "link image imagetools table spellchecker",
		contextmenu_never_use_native: true,
		draggable_modal: false,
		menubar: '',	
		toolbar: 'undo redo | bold italic underline numlist bullist forecolor link fontsizeselect | alignleft aligncenter alignright alignjustify | table | code',
		plugins: "lists,link,code,table",
		fontsize_formats: '11px 12px 14p'
	});
	
	
	$('.btn_upload_ressource').click(function(event) {	
		event.preventDefault();		
		<cfoutput>
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Ajouter quiz");
		$('##modal_body_lg').load("modal_window_ressource_upload.cfm?new_file=1&quiz_id=#quiz_id#<cfif isdefined("qu_id")>&qu_id=#qu_id#</cfif>", function() {});
		</cfoutput>
	});

});
</script>
</body>
</html>