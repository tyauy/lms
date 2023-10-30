<cfsilent>

<cfparam name="f_id" default="2">
<cfparam name="u_id" default="#SESSION.USER_ID#">

<cfparam name="subm" default="home">


<cfset lang_select = "en">

<!--- <cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",m_id="1,2,7")>

<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
	
<cfset lang_select = lcase(get_tp.formation_code)> --->

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
</cfquery>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
</cfquery>

<cfquery name="get_formations_solo" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_fr as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(level_id) as level_id FROM lms_grammar WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

<cfset gr_id = 0>

<cfset list_level="A1_1,A1_2,A1_3,A2_1,A2_2,A2_3,B1_1,B1_2,B1_3,B2_1,B2_2,B2_3,C1_1,C1_2,C1_3">


<!--- <cfloop list="start,end" index="typecor">
<cfquery name="get_result_qpt_solo_#lang_select#_#typecor#" datasource="#SESSION.BDDSOURCE#">
SELECT qu.quiz_user_id, qu.quiz_success, q.quiz_id, q.quiz_alias, SUM(qr.ans_gain) as score, q.quiz_rank
FROM lms_quiz_result qr
INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
AND q.quiz_type = 'qpt_#lang_select#'
GROUP BY qu.quiz_user_id
ORDER BY quiz_rank DESC LIMIT 1
</cfquery>

<cfquery name="get_result_qpt_grammar_#lang_select#_#typecor#" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(qr.ans_gain) as score
FROM lms_quiz_result qr
INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
AND (que.qu_category_id = 1 OR que.qu_category_id = 2) 
AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
AND q.quiz_type = 'qpt_#lang_select#'
AND qu.quiz_user_end IS NOT NULL
GROUP BY qu.user_id
ORDER BY quiz_alias
</cfquery>

<cfquery name="get_result_qpt_writing_#lang_select#_#typecor#" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(qr.ans_gain) as score
FROM lms_quiz_result qr
INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
AND que.qu_category_id = 3
AND q.quiz_type = 'qpt_#lang_select#'
AND qu.quiz_user_end IS NOT NULL
GROUP BY qu.user_id
ORDER BY quiz_alias
</cfquery>

<cfquery name="get_result_qpt_listening_#lang_select#_#typecor#" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(qr.ans_gain) as score
FROM lms_quiz_result qr
INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
INNER JOIN lms_quiz_question que ON que.qu_id = qr.qu_id
WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
AND qu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
AND que.qu_category_id = 4
AND q.quiz_type = 'qpt_#lang_select#'
AND qu.quiz_user_end IS NOT NULL
GROUP BY qu.user_id
ORDER BY quiz_alias
</cfquery>
</cfloop>




<cfset temp = evaluate("get_result_qpt_grammar_#lang_select#_start")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/50)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_grammar_start = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	
<cfset temp = evaluate("get_result_qpt_listening_#lang_select#_start")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/25)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_listening_comprehension_start = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	
<cfset temp = evaluate("get_result_qpt_writing_#lang_select#_start")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/25)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_written_comprehension_start = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	







<cfset temp = evaluate("get_result_qpt_grammar_#lang_select#_end")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/50)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_grammar_end = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	
<cfset temp = evaluate("get_result_qpt_listening_#lang_select#_end")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/25)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_listening_comprehension_end = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	
<cfset temp = evaluate("get_result_qpt_writing_#lang_select#_end")>
<cfif temp.score neq "">																					
	<cfset temp = round((temp.score*15)/25)>
	<cfif temp gt 0 AND temp lte 15>
	<cfset level_written_comprehension_end = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
	</cfif>
</cfif>	 --->








</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
<style>
.card{

  cursor: pointer;
}

.btn-outline-info {color:#51bcda !important;}
.btn-outline-success {color:#6bd098  !important;}
.btn-outline-primary {color:#51cbce  !important;}
.btn-outline-danger {color:#ef8157  !important;}
.btn-outline-warning {color:#fbc658  !important;}

	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	#sortable { list-style-type: none; margin: 0; padding: 0; }

	.nav-link {
		color: #999 !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}
	</style>

	<style>
	.nav-link {
		color: #999 !important;
	}
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link
	{
	color:#FFFFFF !important;
	background-color:#51BCDA !important;
	}

	</style>


</head>


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "GLOBAL LANGUAGE ASSESSMENT">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<cfinclude template="./incl/incl_nav_elearning.cfm">

			<div class="row mt-3">
				<div class="col-md-12">
<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT l.level_alias, ls.level_sub_name, ls.level_sub_id
FROM lms_level_sub ls
INNER JOIN lms_level l ON l.level_id = ls.level_id
WHERE l.level_id NOT IN (6)
</cfquery>
<div class="btn-group-toggle" data-toggle="buttons">
<cfoutput query="get_level">
		<label class="btn btn-sm btn-#level_alias#"><input type="radio" name="level_id" value="#level_sub_id#" autocomplete="off" required id="level_sub_id_#level_sub_id#"> #level_sub_name#</label>

</cfoutput></div>

	<!--- <label class="btn btn-sm <cfif findnocase("B1_3",cor)>btn-#css# text-white<cfelse>btn-outline-#css# <cfif status_scale neq cor>disabled</cfif></cfif> <cfif status_scale eq cor>active</cfif> "><input type="radio" <cfif status_scale eq cor>checked</cfif> name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label> --->


					<div class="accordion" id="skills_accordion">
						
						<cfloop query="get_skill">
						
						<cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
						SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
						FROM lms_skill_sub 
						WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
						</cfquery>



<!--- <cfdump var="#get_skill_sub#"> --->

						<div class="card border">
							<div class="card-header p-4" id="<cfoutput>skill_#get_skill.skill_id#</cfoutput>" data-toggle="collapse" data-target="#div_<cfoutput>#get_skill.skill_id#</cfoutput>" aria-expanded="true" aria-controls="div_<cfoutput>#get_skill.skill_id#</cfoutput>">
								<h6 class="mb-0">
								<!--- <button class="btn btn-link btn-block text-left font-weight-light" type="button"> --->
								<i class="<cfoutput>#get_skill.skill_icon#</cfoutput> fa-lg"></i> <cfoutput>#get_skill.skill_name#</cfoutput>
								<!--- </button> --->
								</h6>
							</div>

							<div id="div_<cfoutput>#get_skill.skill_id#</cfoutput>" class="collapse <cfif get_skill.skill_id eq "1">show</cfif>" aria-labelledby="skill_<cfoutput>#get_skill.skill_id#</cfoutput>" data-parent="#skills_accordion">
								
								<div class="card-body">
								
									<cfset counter = 2>
										
									<cfloop query="get_skill_sub">

										<cfset _skill_id = get_skill_sub.skill_sub_id>
										<cfinclude template="./widget/wid_level_list.cfm">
									
									<!--- <table class="table bg-white table-borderless border border-info borderless">
										<!--- <tr align="center"> --->
											<!--- <td></td> --->
											<!--- <td></td> --->
													
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.2</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.3</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.2</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.3</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.2</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.3</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.1</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.2</span></h5></td> --->
											<!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.3</span></h5></td> --->
										<!--- </tr> --->
										
										
										<cfif isdefined("level_#get_skill.skill_code#_start")>
											<cfset status_scale = replace(evaluate("level_#get_skill.skill_code#_start"),".","_")>
											<!--- status_scale == #status_scale# // #cor# --->
											<cfquery name="get_feedback_#get_skill.skill_code#" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 0 AND level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("level_#get_skill.skill_code#_start")#">
											</cfquery>
											
										<cfelse>
											<cfset status_scale = 0>
										</cfif>
										
										<!--- <cfquery name="get_feedback_custom" datasource="#SESSION.BDDSOURCE#"> --->
										<!--- SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 1 --->
										<!--- </cfquery> --->
										
										<tr align="center">
											<!--- <td rowspan="4"><cfoutput>#get_skill_sub.skill_sub_name#</cfoutput></td> --->
											<td class="bg-white text-info" rowspan="2" width="150">

											<cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" align="center"></cfoutput>
											
											<br>Niveau d'entrée</td>
											
											<td align="left">
												<div class="btn-group-toggle" data-toggle="buttons">	
												<cfloop list="#list_level#" index="cor">
													
													<cfif findnocase("A1_",cor)>
														<cfset css = "success">
													<cfelseif findnocase("A2_",cor)>
														<cfset css = "primary">
													<cfelseif findnocase("B1_",cor)>
														<cfset css = "info">
													<cfelseif findnocase("B2_",cor)>
														<cfset css = "warning">
													<cfelseif findnocase("C1_",cor)>
														<cfset css = "danger">
													</cfif>

													<cfoutput>
													<label class="btn btn-sm <cfif findnocase("B1_3",cor)>btn-#css# text-white<cfelse>btn-outline-#css# <cfif status_scale neq cor>disabled</cfif></cfif> <cfif status_scale eq cor>active</cfif> "><input type="radio" <cfif status_scale eq cor>checked</cfif> name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label>
													</cfoutput>
												
												</cfloop>
												</div>
											</td>	
											
											
											
											
												
											<!--- <cfset counter ++> --->
											<!--- <td align="left"> --->
											<!--- <div class="btn-group-toggle" data-toggle="buttons">			 --->
											<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> A1.1</label> --->
											<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.2</label> --->
											<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.3</label> --->
											<!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.1</label> --->
											<!--- <label class="btn btn-sm btn-outline-primary <cfif counter eq "3">active</cfif>"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <cfif counter eq "3">checked</cfif>> A2.2</label> --->
											<!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.3</label> --->
											<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.1</label> --->
											<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.2</label> --->
											<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.3</label> --->
											<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.1</label> --->
											<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.2</label> --->
											<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.3</label> --->
											<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.1</label> --->
											<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.2</label> --->
											<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.3</label> --->
											<!--- </div> --->
											<!--- </td>			 --->
										</tr>
										<tr>
											<td>
											<cfif isdefined("get_feedback_#get_skill.skill_code#")>
											<cfoutput>#replacenocase(evaluate("get_feedback_#get_skill.skill_code#").feedback_text,chr(10),"<br>")#</cfoutput>
											</cfif>
											</td>
										</tr>
										
									</table>
									
									
									
									<table class="table bg-light table-borderless border">
										<tr align="center">
										
											<td class="bg-light text-muted" width="150">
											<!--- <img src="./assets/img/support_all.jpg" align="center"> --->
											<!--- <i class="fal fa-hiking fa-2x"></i> --->
											<i class="fa-thin fa-chart-user fa-2x"></i>
											
											<br>Aptitudes</td>
											<td align="left">	
												<strong>Spoken Interaction</strong>
												<p>
													Can easily give brief reasons for opinions<br>
													Can easily discuss family, hobbies, work, travel and news/current affairs<br>
												</p>
												<strong>Spoken Production</strong>
												<p>
													
													Can tell a story or explain narrative of book/film with ease<br>
												</p>
											</td>
										</tr>
									</table>
									<!--- <tr align="center"> --->
											<!--- <td class="bg-light"><strong>Feedback</strong></td> --->
											<!--- <td> --->
											<!--- <select name="scale_2" class="change_feedback form-control" id="<cfoutput>feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
											<!--- <option value="0">---Choose feedback---</option> --->
											<!--- <cfoutput query="get_feedback"> --->
											<!--- <option value="#feedback_id#">#feedback_title#</option> --->
											<!--- </cfoutput> --->
											<!--- </select> --->
											
											<!--- <textarea readonly class="form-control" name="" rows="7" id="feedtext_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
											
											<!--- </textarea> --->
											<!--- </td> --->
										<!--- </tr> --->
										
									
										<table class="table bg-light table-borderless border">
											
											
											<cfif isdefined("level_#get_skill.skill_code#_end")>
												<cfset status_scale = replace(evaluate("level_#get_skill.skill_code#_end"),".","_")>
												<!--- status_scale == #status_scale# // #cor# --->
												<cfquery name="get_feedback_#get_skill.skill_code#" datasource="#SESSION.BDDSOURCE#">
												SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 0 AND level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("level_#get_skill.skill_code#_end")#">
												</cfquery>
												
											<cfelse>
												<cfset status_scale = 0>
											</cfif>
											
											
											<tr align="center">
												<td class="bg-white text-info" rowspan="2" width="150">
	
												<cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" align="center"></cfoutput>
												
												<br>Niveau de sortie</td>
												
												<td align="left">
													<div class="btn-group-toggle" data-toggle="buttons">	
													<cfloop list="#list_level#" index="cor">
														
														<cfif findnocase("A1_",cor)>
															<cfset css = "success">
														<cfelseif findnocase("A2_",cor)>
															<cfset css = "primary">
														<cfelseif findnocase("B1_",cor)>
															<cfset css = "info">
														<cfelseif findnocase("B2_",cor)>
															<cfset css = "warning">
														<cfelseif findnocase("C1_",cor)>
															<cfset css = "danger">
														</cfif>
	
														<cfoutput>
														<label class="btn btn-sm btn-outline-#css# <cfif status_scale eq cor>active</cfif>" <cfif status_scale neq cor>disabled</cfif>><input type="radio" <cfif status_scale eq cor>checked</cfif> name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label>
														</cfoutput>
													
													</cfloop>
													</div>
												</td>	
												
												
												
												
													
												<!--- <cfset counter ++> --->
												<!--- <td align="left"> --->
												<!--- <div class="btn-group-toggle" data-toggle="buttons">			 --->
												<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> A1.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary <cfif counter eq "3">active</cfif>"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <cfif counter eq "3">checked</cfif>> A2.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.3</label> --->
												<!--- </div> --->
												<!--- </td>			 --->
											</tr>
											<tr>
												<td>
												<cfif isdefined("get_feedback_#get_skill.skill_code#")>
												<cfoutput>#replacenocase(evaluate("get_feedback_#get_skill.skill_code#").feedback_text,chr(10),"<br>")#</cfoutput>
												</cfif>
												</td>
											</tr>
											
										</table> --->
										

								</cfloop>






								</div>
							</div>
						</div>
						</cfloop>
						
						
						<!--- <div class="card"> --->
							<!--- <div class="card-header" id="skill_reading"> --->
								<!--- <h5 class="mb-0"> --->
								<!--- <button class="btn btn-link btn-block text-left collapsed font-weight-light" type="button" data-toggle="collapse" data-target="#div_reading" aria-expanded="false" aria-controls="div_reading"> --->
								<!--- <i class="fal fa-books fa-lg"></i> READING (WRITING COMPREHENSION) --->
								<!--- </button> --->
								<!--- </h5> --->
							<!--- </div> --->
							<!--- <div id="div_reading" class="collapse" aria-labelledby="skill_reading" data-parent="#skill_accordion"> --->
								<!--- <div class="card-body"> --->
								<!--- Some placeholder content for the second accordion panel. This panel is hidden by default. --->
								<!--- </div> --->
							<!--- </div> --->
						<!--- </div> --->
						<!--- <div class="card"> --->
							<!--- <div class="card-header" id="skill_speaking"> --->
								<!--- <h5 class="mb-0"> --->
								<!--- <button class="btn btn-link btn-block text-left collapsed font-weight-light" type="button" data-toggle="collapse" data-target="#div_speaking" aria-expanded="false" aria-controls="div_speaking"> --->
								<!--- <i class="fal fa-comments fa-lg"></i> SPEAKING (ORAL EXPRESSION) --->
								<!--- </button> --->
								<!--- </h5> --->
							<!--- </div> --->
							<!--- <div id="div_speaking" class="collapse" aria-labelledby="skill_speaking" data-parent="#skill_accordion"> --->
								<!--- <div class="card-body"> --->
								<!--- Some placeholder content for the second accordion panel. This panel is hidden by default. --->
								<!--- </div> --->
							<!--- </div> --->
						<!--- </div> --->
						<!--- <div class="card"> --->
							<!--- <div class="card-header" id="skill_writing"> --->
								<!--- <h5 class="mb-0 "> --->
								<!--- <button class="btn btn-link btn-block text-left font-weight-light collapsed" type="button" data-toggle="collapse" data-target="#div_writing" aria-expanded="false" aria-controls="div_writing"> --->
								<!--- <i class="fal fa-edit fa-lg"></i> WRITING (WRITING EXPRESSION) --->
								<!--- </button> --->
								<!--- </h5> --->
							<!--- </div> --->
							<!--- <div id="div_writing" class="collapse" aria-labelledby="skill_writing" data-parent="#skill_accordion"> --->
								<!--- <div class="card-body"> --->
								<!--- Some placeholder content for the second accordion panel. This panel is hidden by default. --->
								<!--- </div> --->
							<!--- </div> --->
						<!--- </div> --->
						
						
						
						
				<!--- <cfset counter_gr = 0> --->
				<!--- <cfloop query="get_grammar_level"> --->
				<!--- <cfoutput> --->
				
				<!--- <cfquery name="get_level_cor" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- SELECT level_alias, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level WHERE level_id IN (#level_id#)  --->
				<!--- </cfquery> --->
				
				<!--- <cfset counter_gr ++> --->
				
				<!--- <div class="card border border-info mb-1"> --->
				
					<!--- <div class="card-header"> --->
						
						<!--- <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="##collapse_grammar_#counter_gr#"> --->
							
							<!--- <h6 class="my-1 text-info"> --->
							<!--- <cfloop query="get_level_cor">#get_level_cor.level_alias# </cfloop> --->
							<!--- </h6> --->
						<!--- </button> --->
						
					<!--- </div> --->
					
					<!--- <div id="collapse_grammar_#counter_gr#" class="collapse <cfif counter_gr eq "1">show</cfif> p-2" data-parent="##accordion_grammar"> --->
						
						<!--- <div class="row"> --->
						<!--- <cfloop query="get_grammar_cat"> --->
						
						<!--- <cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#"> --->
						<!--- SELECT * FROM lms_grammar  --->
						<!--- WHERE level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_grammar_level.level_id#">  --->
						<!--- AND grammar_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_grammar_cat.grammar_cat_id#">  --->
						<!--- AND formation_id = 2 ORDER BY grammar_name --->
						<!--- </cfquery> --->
					
						<!--- <cfif get_grammar.recordcount neq "0"> --->
						<!--- <div class="col-md-3"> --->
						<!--- <strong>#get_grammar_cat.grammar_cat_name#</strong><br> --->
						<!--- <cfloop query="get_grammar"> --->
						<!--- <label><input type="checkbox" name="grammar_id" id="grammar_id" value="#grammar_id#" <cfif listfind(gr_id,grammar_id)>checked</cfif>> #grammar_name#</label><br>							 --->
						<!--- </cfloop> --->
						<!--- </div> --->
						<!--- </cfif> --->
						
						<!--- </cfloop> --->
						<!--- </div> --->
						
					<!--- </div> --->
				
				<!--- </div> --->
				
				<!--- </cfoutput> --->
				<!--- </cfloop> --->
				
				
					<div class="accordion_grammar" id="accordion_grammar">
						<div class="card">
							<div class="card-header p-4" id="skill_grammar" type="button" data-toggle="collapse" data-target="#div_grammar" aria-expanded="false" aria-controls="div_grammar">
								<h6 class="mb-0">
								<!--- <button class="btn btn-link btn-block text-left collapsed font-weight-light"> --->
									<i class="fal fa-spell-check" aria-hidden="true"></i> SPECIFIC GRAMMAR
								<!--- </button> --->
								</h6>
							</div>
							<div id="div_grammar" class="collapse" aria-labelledby="skill_grammar" data-parent="#skills_accordion">
								<div class="card-body">
								
								
								<div id="accordion_grammar_top">
									<div align="center" class="mb-3">
										<div class="btn-group-toggle" data-toggle="buttons">	
											<cfloop list="A1,A2,B1,B2,C1" index="cor">
												<cfif findnocase("A1",cor)>
													<cfset css = "success">
												<cfelseif findnocase("A2",cor)>
													<cfset css = "primary">
												<cfelseif findnocase("B1",cor)>
													<cfset css = "info">
												<cfelseif findnocase("B2",cor)>
													<cfset css = "warning">
												<cfelseif findnocase("C1",cor)>
													<cfset css = "danger">
												</cfif>
												
												<cfoutput><label class="btn btn-lg btn-outline-#css# <cfif cor eq "A1">active</cfif>" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> #cor#</label></cfoutput>
											
											</cfloop>
										</div>
									</div>
									
									<cfloop list="A1,A2,B1,B2,C1" index="cor">
										<cfoutput>
										<div id="collapse_grammar_sub_#cor#" class="collapse <cfif cor eq "A1">show</cfif> p-2" data-parent="##accordion_grammar_top">	
											
											<cfif cor eq "A1">	
												<cfset list_level = "A1_1,A1_2,A1_3">
											<cfelseif cor eq "A2">	
												<cfset list_level = "A2_1,A2_2,A2_3">
											<cfelseif cor eq "B1">
												<cfset list_level = "B1_1,B1_2,B1_3">
											<cfelseif cor eq "B2">
												<cfset list_level = "B2_1,B2_2,B2_3">
											<cfelseif cor eq "C1">
												<cfset list_level = "C1_1,C1_2,C1_3">
											</cfif>
											
											<table class="table table-sm">
											
											<tr>
												<td></td>
												<td align="center">Trainer Validated</td>
												<td align="center">eLearning Validated</td>
												<td align="center">Keep training</td>
											</tr>
											
												
											<cfloop list="#list_level#" index="cor2">
											<cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'grammar' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
											</cfquery>
											<cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'vocabulary' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
											</cfquery>
											<!--- <cfdump var="#get_mapping_grammar#"> --->
												<cfif findnocase("A1_",cor2)>
													<cfset css = "success">
												<cfelseif findnocase("A2_",cor2)>
													<cfset css = "primary">
												<cfelseif findnocase("B1_",cor2)>
													<cfset css = "info">
												<cfelseif findnocase("B2_",cor2)>
													<cfset css = "warning">
												<cfelseif findnocase("C1_",cor2)>
													<cfset css = "danger">
												</cfif>			
												<!--- <div class="col-md-4"> --->
													<!--- <div class="card border"> --->
														<!--- <button class="btn btn-outline-#css# bg-white" data-toggle="collapse" data-target="##collapse_grammar_#cor2#">#replace(cor2,"_",".")#</button> --->
													
														<!--- <div class="card-body"> --->
														
														
															<tr class="bg-#css#">
																<td colspan="4"><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
															</tr>
														<cfloop query="get_mapping_grammar">
															<tr>
																<td>
																	<!---<input type="checkbox" name="mapping_id">---> #mapping_name#
																</td>
																<td align="center">
																<cfset test = randrange(0,3)>
																<!--- test == #test# --->
																<cfif test eq "0">
																
																<cfelse>
																	<cfloop from="1" to="#test#" index="cor">
																	<cfif test eq "3">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "2">
																		<cfset cssgo = "warning">
																	<cfelseif test eq "1">
																		<cfset cssgo = "danger">
																	</cfif>
																	<i class="fas fa-star text-#cssgo#"></i>
																	</cfloop>
																</cfif>
																
																
																</td>
																<td>
																	<!--- <div class="progress" style="height: 5px;"> --->
																	  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
																	<!--- </div> --->
																</td>
																<td align="center">
																<a type="button" class="btn btn-sm btn-#css#" href="_AD_learner_practice2.cfm?sm_id=" ><i class="fal fa-laptop"></i></a>
																		
																</td>
															</tr>
														</cfloop>
														
														
														<!--- <table class="table"> --->
															<!--- <tr class="bg-#css#"> --->
																<!--- <td colspan="2"><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td> --->
															<!--- </tr> --->
														<!--- <cfloop query="get_mapping_vocabulary"> --->
															<!--- <tr class="table-#css#"> --->
																<!--- <td> --->
																	<!--- <input type="checkbox" name="mapping_id"> #mapping_name# --->
																<!--- </td> --->
																<!--- <td width="20%"> --->
																<!--- <div class="progress" style="height: 5px;"> --->
																  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
																<!--- </div> --->
																<!--- </td> --->
															<!--- </tr> --->
														<!--- </cfloop> --->
														<!--- </table> --->
														
														<!--- </div> --->
													<!--- </div>													 --->
												
											</cfloop>
											</table>
											
											
										</div>
										</cfoutput>
										
									</cfloop>
									
																		
											
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					<div class="accordion_job" id="accordion_job">
						<div class="card">
							<div class="card-header p-4" id="skill_job" type="button" data-toggle="collapse" data-target="#div_job" aria-expanded="false" aria-controls="div_job">
								<h6 class="mb-0">
								<!--- <button class="btn btn-link btn-block text-left collapsed font-weight-light"> --->
								<cfoutput><img src="./assets/img/training_#lcase(get_formations_solo.formation_code)#.png" width="30" height="30"></cfoutput> JOB SPECIFIC SKILLS
								<!--- </button> --->
								</h6>
							</div>
							<div id="div_job" class="collapse" aria-labelledby="skill_job" data-parent="#skills_accordion">
								<div class="card-body">
								
								<cfloop query="get_keyword_cat">
											
									<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
									SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
									FROM lms_keyword k 
									WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> 
									GROUP BY keyword_id
									ORDER BY rand()
									LIMIT 10
									</cfquery>
										
										<table class="table table-sm">
											
											<tr>
												<td></td>
												<td align="center">Trainer Validated</td>
												<td align="center">eLearning Validated</td>
												<td align="center">Keep training</td>
											</tr>
											
										<cfoutput query="get_keyword">
										
										<cfset test = randrange(100,118)>
											<tr>
												<td>
													<div class="media">
														<img class="align-self-center mr-2" src="./assets/img_module/#test#.jpg" width="40">
														<div class="media-body">
														<cfif get_keyword_cat.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif>
														</div>
													</div>
												</td>
												<td align="center">
													<cfset test = randrange(0,3)>
													<!--- test == #test# --->
													<cfif test eq "0">
													
													<cfelse>
														<cfloop from="1" to="#test#" index="cor">
														<cfif test eq "3">
															<cfset cssgo = "warning">
														<cfelseif test eq "2">
															<cfset cssgo = "warning">
														<cfelseif test eq "1">
															<cfset cssgo = "danger">
														</cfif>
														<i class="fas fa-star text-#cssgo#"></i>
														</cfloop>
													</cfif>
													
													
													</td>
													<td>
														<!--- <div class="progress" style="height: 5px;"> --->
														  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
														<!--- </div> --->
													</td>
													<td align="center">
													<a type="button" class="btn btn-sm btn-#css#" href="_AD_learner_practice2.cfm?sm_id=" ><i class="fal fa-laptop"></i></a>
															
													</td>
											</tr>
											
										</cfoutput>
										
										</table>
										
								</cfloop>
					
								
								</div>
							</div>
							
						</div>
					
					</div>
					
					</div>
						</div>
					
				</div>			
			</div>
				
		</div>
		
		
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
	 </div>
	 
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<!--- <cfset result = StructNew()> --->
		<!--- <cfset result[0] = get_max_id.maxid> --->
		<!--- <cfset result[1] = session_rank> --->
		<!--- <cfset result[2] = get_module> --->
		<!--- <cfset result[3] = get_session_order> --->
		<!--- <cfset result[4] = get_sm.sessionmaster_name> --->
		<!--- <cfreturn result> --->
		
		
		<!--- <cfset table_data = arraynew(1)> --->

<!--- <cfoutput query="get_tp"> --->
	
	<!--- <cfif tp_toschedule eq "" OR tp_toschedule eq "0"><cfset tp_toschedule_go = "0"><cfelse><cfset tp_toschedule_go = tp_toschedule/60></cfif> --->
	<!--- <cfif tp_scheduled eq "" OR tp_scheduled eq "0"><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled/60></cfif> --->
	<!--- <cfif tp_completed_full eq "" OR tp_completed_full eq "0"><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed_full/60></cfif> --->
	<!--- <cfif tp_missed eq "" OR tp_missed eq "0"><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed/60></cfif> --->
	<!--- <cfif tp_remain eq "" OR tp_remain eq "0"><cfset tp_remain_go = "0"><cfelse><cfset tp_remain_go = tp_remain/60></cfif> --->
	
	<!--- <cfset temp = arrayAppend(table_data, structNew())> --->
	<!--- <cfset table_data[1] = tp_toschedule_go> --->
	<!--- <cfset temp = arrayAppend(table_data, structNew())> --->
	<!--- <cfset table_data[2] = tp_scheduled_go> --->
	<!--- <cfset temp = arrayAppend(table_data, structNew())> --->
	<!--- <cfset table_data[3] = tp_completed_go> --->
	<!--- <cfset temp = arrayAppend(table_data, structNew())> --->
	<!--- <cfset table_data[4] = tp_missed_go> --->
	<!--- <cfset temp = arrayAppend(table_data, structNew())> --->
	<!--- <cfset table_data[5] = tp_remain_go> --->
	
<!--- </cfoutput> --->

<!--- <cfset table_js = SerializeJSON(table_data)> --->

<script>
$(function() {


	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
	$( ".level_select").change(function(event) {

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");

		$.ajax({
			url : './api/users/user_post.cfc?method=up_user_level_ln',
			type : 'POST',
			data : {
				user_id: <cfoutput>#u_id#</cfoutput>,
				formation_id: <cfoutput>#f_id#</cfoutput>,
				skill_id: idtemp[1],
				level_sub_id: idtemp[2]
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
	});
	</cfif>




<cfloop query="get_skill">

	<cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
	SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
	FROM lms_skill_sub 
	WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
	</cfquery>
	
	<cfloop query="get_skill_sub">
	
	<cfquery name="get_feedback_solo" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_feedback WHERE skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#">
	</cfquery>
	
	$('.level_select_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>').change(function(event) {
		var go = $(this).val();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var skill_id = idtemp[1];	
		var skill_sub_id = idtemp[2];
		<!--- alert(go); --->
		<cfoutput query="get_feedback_solo">
		if (skill_sub_id == "#skill_sub_id#" && go == "#replace(level_id,".","_")#")
		{
			$('##feedtext_'+skill_id+'_'+skill_sub_id).val("#encodeforjavascript(feedback_text)#");
		}
		</cfoutput>
		
	})
	</cfloop>
	</cfloop>
	
	$('.change_feedback_custom').change(function(event) {
		var go = $(this).val();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var skill_id = idtemp[1];	
		var skill_sub_id = idtemp[2];

		<!--- <cfoutput query="get_feedback_all"> --->
		<!--- if (skill_sub_id == "#skill_sub_id#" && go == #feedback_id#) --->
		<!--- { --->
			<!--- $('##feedtextcustom_'+skill_id+'_'+skill_sub_id).val("#encodeforjavascript(feedback_text)#"); --->
		
		<!--- } --->
		<!--- </cfoutput> --->
	
	})
	
	
	

	<!--- $('.btn_create_ressource').click(function(event) {	 --->
		<!--- event.preventDefault();		 --->
		<!--- var idtemp = $(this).attr("id"); --->
		<!--- var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50); --->
		<!--- $('#window_item_lg').modal({keyboard: true}); --->
		<!--- $('#modal_title_lg').text("Ajouter ressource"); --->
		<!--- $('#modal_body_lg').load("modal_window_ressource.cfm?new_resource=1&f_id="+idtemp, function() {}); --->
	<!--- }); --->
	
})

</script>

</body>
</html>