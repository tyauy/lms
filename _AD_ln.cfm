<cfsilent>

<cfparam name="f_id" default="2">

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
</cfquery>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id <= 4
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

.collapsing {
    <!--- -webkit-transition: none; --->
    <!--- transition: none; --->
    <!--- display: none; --->
}
<!--- .card { --->
	<!--- border-radius: 2px !important; --->
	<!--- box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important; --->
<!--- } --->
<!--- .card:hover{ --->
	 <!--- cursor: pointer; --->
	 <!--- transform: scale(1.05); --->
	 <!--- box-shadow: 0 6px 10px rgba(0,0,0,.08), 0 0 6px rgba(0,0,0,.05); --->
	<!--- box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06); --->
<!--- } --->
</style>
</head>


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "GLOBAL LANGUAGE ASSESSMENT">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
			
			<div class="row">
				<div class="col-md-12">		
					<cfoutput query="get_formation">
					<!--- <div class="col-md-1 p-1"> --->
					<a href="_AD_ln.cfm?f_id=#formation_id#" class="btn <cfif isdefined("f_id") AND f_id eq formation_id>btn-outline-info active<cfelse>btn-link</cfif>">
					<img src="./assets/img/training_#lcase(formation_code)#.png" width="40" height="40"><br><cfif len(formation_name) gt 8><small>#formation_name#</small><cfelse>#formation_name#</cfif>
					</a>
					<!--- </div> --->
					</cfoutput>
				</div>
			</div>


			<div class="row">
				<div class="col-md-12">

					<div class="accordion" id="skills_accordion">
						
						<cfloop query="get_skill">
						
						<cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
						SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
						FROM lms_skill_sub 
						WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
						</cfquery>



<!--- <cfdump var="#get_skill_sub#"> --->

						<div class="card">
							<div class="card-header" id="<cfoutput>skill_#get_skill.skill_id#</cfoutput>">
								<h5 class="mb-0">
								<button class="btn btn-link btn-block text-left font-weight-light" type="button" data-toggle="collapse" data-target="#div_<cfoutput>#get_skill.skill_id#</cfoutput>" aria-expanded="true" aria-controls="div_<cfoutput>#get_skill.skill_id#</cfoutput>">
								<i class="<cfoutput>#get_skill.skill_icon#</cfoutput> fa-lg"></i> <cfoutput>#get_skill.skill_name#</cfoutput>
								</button>
								</h5>
							</div>

							<div id="div_<cfoutput>#get_skill.skill_id#</cfoutput>" class="collapse <cfif get_skill.skill_id eq "1">show</cfif>" aria-labelledby="skill_<cfoutput>#get_skill.skill_id#</cfoutput>" data-parent="#skill_accordion">
								<div class="card-body">
								
									<table class="table bg-white table-bordered">
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
										<cfset counter = 2>
										
										<cfloop query="get_skill_sub">
										
										<!--- <cfquery name="get_feedback" datasource="#SESSION.BDDSOURCE#"> --->
										<!--- SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 0 --->
										<!--- </cfquery> --->
										
										<!--- <cfquery name="get_feedback_custom" datasource="#SESSION.BDDSOURCE#"> --->
										<!--- SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 1 --->
										<!--- </cfquery> --->
										
										<tr align="center">
											<!--- <td rowspan="4"><cfoutput>#get_skill_sub.skill_sub_name#</cfoutput></td> --->
											<td class="bg-light"><strong>Niveau d'entrée</strong></td>
											<cfset counter ++>
											<td align="left">
											<div class="btn-group-toggle" data-toggle="buttons">			
											<label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> A1.1</label>
											<label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.2</label>
											<label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.3</label>
											<label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.1</label>
											<label class="btn btn-sm btn-outline-primary <cfif counter eq "3">active</cfif>"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <cfif counter eq "3">checked</cfif>> A2.2</label>
											<label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.3</label>
											<label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.1</label>
											<label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.2</label>
											<label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.3</label>
											<label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.1</label>
											<label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.2</label>
											<label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.3</label>
											<label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.1</label>
											<label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.2</label>
											<label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.3</label>
											</div>
											</td>			
										</tr>
										<tr align="center">
											<td class="bg-light"><strong>Niveau de sortie</strong></td>
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
												
												<label class="btn btn-sm btn-outline-#css#"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label>
												
												</cfoutput>
											
												</cfloop>
												
												<!--- <label class="btn btn-sm btn-outline-success"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="2" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> A1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-success"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="3" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> A1.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="4" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> A2.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="5" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> A2.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-primary"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="6" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> A2.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-info"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="7" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B1.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-info"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="8" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-info"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="9" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B1.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="10" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B2.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="11" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B2.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-warning"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="12" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> B2.3</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="13" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> C1.1</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="14" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> C1.2</label> --->
												<!--- <label class="btn btn-sm btn-outline-danger"><input type="radio" name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="15" autocomplete="off" id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> C1.3</label> --->
												</div>
											</td>			
										</tr>
										<tr align="center">
											<td class="bg-light"><strong>CECR Feedback</strong></td>
											<td>
											<!--- <select name="scale_2" class="change_feedback form-control" id="<cfoutput>feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
											<!--- <option value="0">---Choose feedback---</option> --->
											<!--- <cfoutput query="get_feedback"> --->
											<!--- <option value="#feedback_id#">#feedback_title#</option> --->
											<!--- </cfoutput> --->
											<!--- </select> --->
											
											<textarea readonly class="form-control" name="" rows="7" id="feedtext_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>">
											
											</textarea>
											</td>
										</tr>
										<!--- <tr align="center"> --->
											<!--- <td class="bg-light"><strong>Trainer Feedback</strong></td> --->
											<!--- <td> --->
											<!--- <select name="scale_2" class="change_feedback_custom form-control" id="<cfoutput>feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
											<!--- <option value="0">---Choose feedback---</option> --->
											<!--- <cfoutput query="get_feedback_custom"> --->
											<!--- <option value="#feedback_id#">#feedback_title#</option> --->
											<!--- </cfoutput> --->
											<!--- </select> --->
											
											<!--- <textarea class="form-control" name="" rows="7" id="feedtextcustom_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
											
											<!--- </textarea> --->
											<!--- </td> --->
										<!--- </tr> --->
										</cfloop>
										
									</table>







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
							<div class="card-header" id="skill_grammar">
								<h5 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed font-weight-light" type="button" data-toggle="collapse" data-target="#div_grammar" aria-expanded="false" aria-controls="div_grammar">
								<cfoutput><img src="./assets/img/training_#lcase(get_formations_solo.formation_code)#.png" width="30" height="30"></cfoutput> SPECIFIC GRAMMAR & VOCABULARY
								</button>
								</h5>
							</div>
							<div id="div_grammar" class="collapse" aria-labelledby="skill_grammar" data-parent="#skill_accordion">
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
												
												<cfoutput><label class="btn btn-lg btn-outline-#css#" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> #cor#</label></cfoutput>
											
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
											
											<div class="row">
											
												
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
												<div class="col-md-4">
													<!--- <div class="card border"> --->
														<!--- <button class="btn btn-outline-#css# bg-white" data-toggle="collapse" data-target="##collapse_grammar_#cor2#">#replace(cor2,"_",".")#</button> --->
													
														<!--- <div class="card-body"> --->
														
														<table class="table">
															<tr class="bg-#css#">
																<td colspan="2"><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
															</tr>
														<cfloop query="get_mapping_grammar">
															<tr class="table-#css#">
																<td>
																	<input type="checkbox" name="mapping_id"> #mapping_name#
																</td>
																<td width="20%">
																<div class="progress" style="height: 5px;">
																  <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
																</div>
																</td>
															</tr>
														</cfloop>
														</table>
														
														<table class="table">
															<tr class="bg-#css#">
																<td colspan="2"><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td>
															</tr>
														<cfloop query="get_mapping_vocabulary">
															<tr class="table-#css#">
																<td>
																	<input type="checkbox" name="mapping_id"> #mapping_name#
																</td>
																<td width="20%">
																<div class="progress" style="height: 5px;">
																  <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
																</div>
																</td>
															</tr>
														</cfloop>
														</table>
														
														<!--- </div> --->
													<!--- </div>													 --->
												</div>
											</cfloop>
											
											</div>
											
										</div>
										</cfoutput>
										
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