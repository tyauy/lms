<cfif isdefined("tpmastercor_id")>

<cfquery name="get_tpmastercor" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpmastercor2 WHERE tpmastercor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmastercor_id#">
</cfquery>



<cfif get_tpmastercor.tpmastercor_mapping_id eq "">
	<cfset m_id = 0>
<cfelse>
	<cfset m_id = get_tpmastercor.tpmastercor_mapping_id>
</cfif>

<form action="updater_session.cfm" method="post">

	

<table class="table m-0">
	<tr>
		<td class="bg-light" width="15%">
			<cfoutput>Rename <span style="color:##FF0000">*</span></cfoutput>
		</td>
		<td>
			<cfoutput>
			<input type="text" name="tpmastercor_name" class="form-control" value="#get_tpmastercor.tpmastercor_name#">
			</cfoutput>
		</td>
	</tr>	
	<tr>
		<td class="bg-light" width="15%">
			Language Map
		</td>
		<td valign="top">
			
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
						
						<cfoutput><label class="btn btn-lg btn-outline-#css#" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <!---required--->> #cor#</label></cfoutput>
					
					</cfloop>
				</div>
			</div>
			
			<cfloop list="A1,A2,B1,B2,C1" index="cor">
				<cfoutput>
				<div id="collapse_grammar_sub_#cor#" class="collapse <!---<cfif cor eq "A1">show</cfif>---> p-2" data-parent="##accordion_grammar_top">	
					
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
					<!--- <cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#"> --->
					<!--- SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'vocabulary' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> --->
					<!--- </cfquery> --->
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
							<div class="card border h-100">
								<h3 align="center" class="text-#css# m-0 font-weight-bold">#replace(cor2,"_",".")#</h3>
							
								<div class="card-body">
								
								<table class="table table-sm">
									<tr class="bg-#css#">
										<td><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
									</tr>
								<cfloop query="get_mapping_grammar">
									<tr class="table-#css#">
										<td>
											<label class="text-dark"><input type="checkbox" name="tpmastercor_mapping_id" <cfif listfind(m_id,mapping_id)>checked</cfif> value="#mapping_id#"> #mapping_name#</label>
										</td>
										<!--- <td width="20%"> --->
										<!--- <div class="progress" style="height: 5px;"> --->
										  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
										<!--- </div> --->
										<!--- </td> --->
									</tr>
								</cfloop>
								</table>
								
								<!--- <table class="table table-sm"> --->
									<!--- <tr class="bg-#css#"> --->
										<!--- <td><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td> --->
									<!--- </tr> --->
								<!--- <cfloop query="get_mapping_vocabulary"> --->
									<!--- <tr class="table-#css#"> --->
										<!--- <td> --->
											<!--- <label class="text-dark"><input type="checkbox" name="tpmastercor_mapping_id" <cfif listfind(m_id,mapping_id)>checked</cfif> value="#mapping_id#"> #mapping_name#</label> --->
										<!--- </td> --->
									<!--- </tr> --->
								<!--- </cfloop> --->
								<!--- </table> --->
								
								</div>
							</div>													
						</div>
					</cfloop>
					
					</div>
					
				</div>
				</cfoutput>
				
			</cfloop>
			</div>
		</td>
	</tr>
			
	
	<tr>
		<td colspan="2" align="center">
		<cfoutput>
		<input type="hidden" name="f_id" value="#f_id#">
		<input type="hidden" name="tpmastercor_id" value="#tpmastercor_id#">
		<input type="submit" class="btn btn-success" value="#obj_translater.get_translate('btn_validate')#">
		</cfoutput>
		</td>
	</tr>
	
</table>

</form>


<cfelseif isdefined("s_id")>
		
<cfset get_session = obj_query.oget_session_solo(s_id)>

<cfif u_id eq "11743"
OR u_id eq "11744"
OR u_id eq "25911"
OR u_id eq "25913"
OR u_id eq "11745"
OR u_id eq "11746"
OR u_id eq "11747"
OR u_id eq "4348"
OR u_id eq "4841"
OR u_id eq "7767">

	<cfset get_tp = obj_tp_get.oget_tp(get_session.tp_id)>

<cfelse>

    <cfset get_tp = obj_tp_get.oget_tp(get_session.tp_id)>

</cfif>



		
<cfif get_session.keyword_id eq "">
	<cfset k_id = 0>
<cfelse>
	<cfset k_id = get_session.keyword_id>
</cfif>

<cfif get_session.skill_id eq "">
	<cfset sk_id = 0>
<cfelse>
	<cfset sk_id = get_session.skill_id>
</cfif>

<cfif get_session.expertise_id eq "">
	<cfset exp_id = 0>
<cfelse>
	<cfset exp_id = get_session.expertise_id>
</cfif>

<cfif get_session.grammar_id eq "">
	<cfset gr_id = 0>
<cfelse>
	<cfset gr_id = get_session.grammar_id>
</cfif>

<cfif get_session.level_id eq "">
	<cfset l_id = "">
<cfelse>
	<cfset l_id = get_session.level_id>
</cfif>

<cfif get_session.mapping_id eq "">
	<cfset m_id = 0>
<cfelse>
	<cfset m_id = get_session.mapping_id>
</cfif>

<cfif get_session.origin_id eq "">
	<cfset o_id = 0>
<cfelse>
	<cfset o_id = get_session.origin_id>
</cfif>




<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#SESSION.LANG_CODE# as skill_objectives FROM lms_skill WHERE skill_major = 1
</cfquery>


<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_keyword_function" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_expertise" datasource="#SESSION.BDDSOURCE#">
SELECT expertise_id, expertise_name_#SESSION.LANG_CODE# as expertise_name FROM user_expertise_index
</cfquery>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_css, level_alias, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level ORDER BY level_alias
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = 2
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(level_id) as level_id FROM lms_grammar WHERE formation_id = 2
</cfquery>

<cfquery name="get_lesson_origin" datasource="#SESSION.BDDSOURCE#">
SELECT origin_id, origin_name_#SESSION.LANG_CODE# as origin_name FROM lms_lesson_origin
</cfquery>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_level ORDER BY level_alias
</cfquery>

<form action="updater_session.cfm" method="post">



<table class="table m-0">
	<tr>
		<td class="bg-light" width="15%">
			<cfoutput>Rename lesson<span style="color:##FF0000">*</span></cfoutput>
		</td>
		<td>
			<cfoutput>
			<input type="text" name="session_name" class="form-control" value="#get_session.session_name#">
			</cfoutput>
		</td>
	</tr>
	
	
	
	<tr>
		<td class="bg-light" width="15%">
			<cfoutput>#obj_translater.get_translate('level')#<!--- <span style="color:##FF0000">*</span>---></cfoutput>
		</td>
		<td>
		

			<div class="btn-group-toggle" data-toggle="buttons">
			<cfoutput query="get_level">
			<label class="btn btn-sm btn-outline-#level_css# <cfif level_id eq l_id>active</cfif>">
			<input type="radio" name="level_id" id="level_id" value="#level_id#" autocomplete="off" <cfif level_id eq l_id>checked</cfif> <!---required--->> #level_alias#<br>#level_name#
			</label>
			 </cfoutput>
			</div>
		</td>
	</tr>

	<tr>
		<td class="bg-light" width="15%">
			Language Map<br><em>Grammar points</em>
		</td>
		<td valign="top">
			<cfif isDefined("new_grammar_point")>
				
				<div class="accordion_int" id="accordion_int">
					<cfquery name="get_mapping_level" datasource="#SESSION.BDDSOURCE#">
						SELECT l.level_id, l.level_alias, l.level_css, ls.level_sub_id, ls.level_sub_name, ls.level_sub_css, lm.mapping_name, lm.mapping_id, lm.mapping_category
						FROM lms_level l
						INNER JOIN lms_level_sub ls ON ls.level_id = l.level_id
						INNER JOIN lms_mapping lm ON lm.level_sub_id = ls.level_sub_id AND lm.formation_id = 2
						WHERE l.level_id NOT IN (6) AND mapping_category <> 'NA'
						ORDER BY ls.level_id ASC,  ls.level_sub_id ASC, lm.mapping_category, lm.mapping_name ASC 
					</cfquery>

					<div id="accordion_mapping">
						<div class="btn-group-toggle" data-toggle="buttons">
							<cfoutput query="get_mapping_level" group="level_id">
								<label class="btn btn-lg btn-outline-#level_alias# <cfif level_id eq "1">active</cfif>" data-toggle="collapse" data-target="##collapselevel_#level_id#" <cfif level_id eq "1">aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
									<input type="radio" name="level_id" id="level_id" value="1" autocomplete="off">
									<img src="./assets/img_level/#level_alias#.svg" width="30">
								</label>
							</cfoutput>	
						</div>

						<cfoutput query="get_mapping_level" group="level_id">
							<div id="collapselevel_#level_id#" class="<cfif level_id neq "1">collapse<cfelse>collapse show</cfif> pt-2" data-parent="##accordion_mapping">
								<div class="row">
								<cfoutput group="level_sub_id">
									<div class="col-md-4">
										<div class="card border h-100 bg-white">
											<div class="card-title bg-#level_alias#">
												<h5 align="center" class="text-white m-0 font-weight-bold">#level_sub_name#</h5>
											</div>
											<table class="table table-sm">
											<cfoutput group="mapping_category">
												<tr>
													<td>
														<label class="text-dark">
															<strong>#ucase(mapping_category)#</strong>
														</label>
													</td>
												</tr>
												<cfoutput>
												<tr>
													<td>
														<label class="text-dark">
															<input type="checkbox" name="mapping_id" value="#mapping_id#" <cfif listfind(m_id,mapping_id)>checked</cfif>> #mapping_name#
														</label>
													</td>
												</tr>
												</cfoutput>
											</cfoutput>
											</table>
										</div>
									</div>
								</cfoutput>
								</div>
							</div>
						</cfoutput>	
					</div>
				</div>
			<cfelse>
			
			
			<div id="accordion_grammar_top">
			<div class="mb-3">
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
						
						<cfoutput><label class="btn btn-outline-#css#" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="grammar_id" id="grammar_id" value="1" autocomplete="off" <!---required--->> #cor#</label></cfoutput>
					
					</cfloop>
				</div>
			</div>
			
			<cfloop list="A1,A2,B1,B2,C1" index="cor">
				<cfoutput>
				<div id="collapse_grammar_sub_#cor#" class="collapse <!---<cfif cor eq "A1">show</cfif>---> p-2" data-parent="##accordion_grammar_top">	
					
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
					SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'grammar' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#">
					</cfquery>
					<!--- <cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#"> --->
					<!--- SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'vocabulary' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#"> --->
					<!--- </cfquery> --->
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
							<div class="card border h-100">
								<h4 align="center" class="text-#css# m-0 font-weight-bold">#replace(cor2,"_",".")#</h4>
							
								<div class="card-body">
								
								<table class="table table-sm">
									<tr class="bg-#css#">
										<td><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
									</tr>
								<cfloop query="get_mapping_grammar">
									<tr class="table-#css#">
										<td>
											<label class="text-dark"><input type="checkbox" name="mapping_id" <cfif listfind(m_id,mapping_id)>checked</cfif> value="#mapping_id#"> #mapping_name#</label>
										</td>
										<!--- <td width="20%"> --->
										<!--- <div class="progress" style="height: 5px;"> --->
										  <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
										<!--- </div> --->
										<!--- </td> --->
									</tr>
								</cfloop>
								</table>
								
								<!--- <table class="table table-sm"> --->
									<!--- <tr class="bg-#css#"> --->
										<!--- <td><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td> --->
									<!--- </tr> --->
								<!--- <cfloop query="get_mapping_vocabulary"> --->
									<!--- <tr class="table-#css#"> --->
										<!--- <td> --->
											<!--- <label class="text-dark"><input type="checkbox" name="mapping_id" <cfif listfind(m_id,mapping_id)>checked</cfif> value="#mapping_id#"> #mapping_name#</label> --->
										<!--- </td> --->
									<!--- </tr> --->
								<!--- </cfloop> --->
								<!--- </table> --->
								
								</div>
							</div>													
						</div>
					</cfloop>
					
					</div>
					
				</div>
				</cfoutput>
				
			</cfloop>
			</div>
			</cfif>

		</td>
	</tr>
			
			
		
	
	<tr>
		<td class="bg-light" width="15%">
			Material Origin<br><em>Web lesson</em>
		</td>
		<td>
			<div class="btn-group-toggle" data-toggle="buttons">	
			<cfoutput query="get_lesson_origin">
				<label class="btn btn-sm btn-outline-info <cfif listfind(o_id,origin_id)>active</cfif>">
				<input type="checkbox" name="origin_id" value="#origin_id#" <cfif listfind(o_id,origin_id)>checked</cfif>>
				#origin_name#
				</label>
			</cfoutput>
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="bg-light" width="15%">
			<cfoutput>#obj_translater.get_translate('table_th_mini_hobbies')# </cfoutput>
		</td>
		<td valign="top">
			<div class="accordion_int" id="accordion_int">
				<cfloop query="get_keyword_cat">
				<div class="card border border-info mb-1">
				
					<div class="card-header">
						
						<cfoutput><button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="##collapse_#keyword_cat_id#"></cfoutput>
							
							<h6 class="my-1 text-info">
							<cfoutput>#keyword_cat_name#</cfoutput>
							</h6>
						</button>
						
					</div>

					<cfoutput><div id="collapse_#keyword_cat_id#" class="collapse <cfif keyword_cat_id eq "1">show</cfif> p-2" data-parent="##accordion_int"></cfoutput>
								
						<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
						SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> ORDER BY keyword_name
						</cfquery>
						
						<cfif get_keyword.recordcount gt 3>
						<div class="row">
							<div class="col-md-4">
							
							<cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>							
							</cfoutput>
							</div>
							
							<div class="col-md-4">
							<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
							</cfoutput>
							</div>
							
							<div class="col-md-4">
							<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
							</cfoutput>
							</div>
							
						</div>
						</cfif>
					
					</div>
					
					
				</div>
				</cfloop>
			</div>
				
		</td>
		
	</tr>
	<tr>
		<td class="bg-light" width="15%">
			Job skills
		</td>
		<td valign="top">
			<div class="accordion_int" id="accordion_int">
				<cfloop query="get_keyword_function">
				<div class="card border border-info mb-1">
				
					<div class="card-header">
						
						<cfoutput><button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="##collapse_#keyword_cat_id#"></cfoutput>
							
							<h6 class="my-1 text-info">
							<cfoutput>#keyword_cat_name#</cfoutput>
							</h6>
						</button>
						
					</div>

					<cfoutput><div id="collapse_#keyword_cat_id#" class="collapse <cfif keyword_cat_id eq "1">show</cfif> p-2" data-parent="##accordion_int"></cfoutput>
								
						<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
						SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_function.keyword_cat_id#"> ORDER BY keyword_name
						</cfquery>
						
						<cfif get_keyword.recordcount gt 3>
						<div class="row">
							<div class="col-md-4">
							
							<cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>							
							</cfoutput>
							</div>
							
							<div class="col-md-4">
							<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
							</cfoutput>
							</div>
							
							<div class="col-md-4">
							<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
							<label><input type="checkbox" name="keyword_id" id="keyword_id" class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
							</cfoutput>
							</div>
							
						</div>
						</cfif>
					
					</div>
					
					
				</div>
				</cfloop>
			</div>
				
		</td>
		
	</tr>
	<tr>
		<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_mini_needs')# <span style="color:##FF0000">*</span></cfoutput></td>
		<td valign="top">
			<div class="row">

				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
				<label><input type="checkbox" name="skill_id" id="user_needs_learn" value="#skill_id#" <cfif listfind(sk_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>							
				</cfoutput>
				</div>
				
				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
				<label><input type="checkbox" name="skill_id" id="user_needs_learn" value="#skill_id#" <cfif listfind(sk_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>				
				</cfoutput>
				</div>
				
			</div>
			
		</td>
	</tr>
	<!--- <tr> --->
		<!--- <td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_certification')#</cfoutput></td> --->
		<!--- <td valign="top"> --->
			<!--- <div class="row"> --->
				<!--- <div class="col-md-6"> --->
				<!--- <cfoutput query="get_expertise" startrow="1" maxrows="4"> --->
				<!--- <label><input type="checkbox" name="expertise_id" id="expertise_id" value="#expertise_id#" <cfif listfind(exp_id,expertise_id)>checked</cfif>> #expertise_name#</label><br> --->
				<!--- </cfoutput> --->
				<!--- </div> --->
				<!--- <div class="col-md-6"> --->
				<!--- <cfoutput query="get_expertise" startrow="5" maxrows="4"> --->
				<!--- <label><input type="checkbox" name="expertise_id" id="expertise_id" value="#expertise_id#" <cfif listfind(exp_id,expertise_id)>checked</cfif>> #expertise_name#</label><br> --->
				<!--- </cfoutput> --->
				<!--- </div> --->
			<!--- </div> --->
		<!--- </td> --->
	<!--- </tr> --->
	<!--- <tr> --->
		<!--- <td colspan="2"> --->
		<!--- <small><span style="color:#FF0000">* <cfoutput>#obj_translater.get_translate('tooltip_required_field')#</cfoutput></small></span> --->
		<!--- </td> --->
	<!--- </tr> --->
	
	<tr>
		<td colspan="2" align="center">
		<cfoutput>
		<input type="hidden" name="t_id" value="#t_id#">
		<input type="hidden" name="u_id" value="#u_id#">
		<input type="hidden" name="s_id" value="#s_id#">		
		<input type="submit" class="btn btn-success" value="#obj_translater.get_translate('btn_validate')#">
		</cfoutput>
		</td>
	</tr>
	
</table>

</form>

<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->

<!--- <table class="table m-0">
	<tr>
		<td class="bg-light" width="15%">
			<!--- PI&Egrave;CE JOINTE<br><small>pdf / doc / docx / jpg / jpeg / png</small><br><small>3 max</small> --->
			<cfoutput>#obj_translater.get_translate_complex(id_translate="pj_notice")#</cfoutput>
		</td>
		<td valign="top">
			<div class="row">

				<!--- ! BO_ROOT_URL --->
				<cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	

				<div class="col-md-6">
					<table class="table table-sm table-bordered" id="file_holder">

						<!--- <tr>
							<th class="bg-light" colspan="2">
							<div align="center"><label>PI&Egrave;CE JOINTE</label></div>
							</th>
						</tr> --->
							
						<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
						
						<cfif dirQuery.recordcount eq "0">
							<tr id="file_none">
								<td colspan="2" align="center"><em>Aucun fichier</em></td>
							</tr>
						<cfelse>
						
							<cfoutput>
							<cfloop query="dirQuery">
							<tr id="file_#dirQuery.currentRow#">
								<!--- <th class="bg-light" width="30%">
								<label>Fichier</label>
								</th> --->
								<td colspan="2">
								<a href="./assets/lessons/#t_id#/#s_id#/#name#" target="_blank">#name#</a>
								<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
								<!---  --->
								<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="#name#" id="delete_doc_#dirQuery.currentRow#"><i class="fal fa-trash-alt"></i></i></a>
							</td>
							</tr>
							
							</cfloop>
							</cfoutput>
						
						</cfif>
				
					</table>
				</div>
				
				<div class="col-md-6">

					<form method="post" id="form_doc" name="form_doc" onsubmit="return submit_form_doc();">

					<table class="table table-sm table-bordered">
	
						<tr>
							<td>

								<input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc,.pptx" <cfif dirQuery.recordcount GTE "3">disabled</cfif> >

							</td>
							<td>
								<!--- <input type="hidden" name="t_id" value="<cfoutput>#t_id#</cfoutput>">
								<input type="hidden" name="s_id" value="<cfoutput>#s_id#</cfoutput>"> --->
								<input type="hidden" name="dir_go" value="<cfoutput>#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#</cfoutput>">
								<input type="submit" class="btn btn-info btn-sm" id="doc_upload_submit" value="upload" <cfif dirQuery.recordcount GTE "3">disabled</cfif>>
							</td>
							
						</tr>
						<tr>
							<td colspan="2">
								<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_doc" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</td>
						</tr>
					</table>

					</form>

				</div>
				
			</div>
			
		</td>
	</tr>
</table>
<!--- </cfif> --->

<script>

var handler_remove = function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            idtemp = idtemp.split("delete_doc_");
		    var doc_pos = idtemp[1];
			var doc_name = $(this).attr("name");
            console.log("hello", doc_pos, doc_name);

			var fd = new FormData();
			fd.set("name", doc_name);
			fd.set("t_id", <cfoutput>#t_id#</cfoutput>);
			fd.set("s_id", <cfoutput>#s_id#</cfoutput>);

			$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=delete_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			success    : function ( data )
			{

				console.log("yeah", data)
				// console.log(obj.CLIENTFILE)
				$("#file_" + doc_pos ).remove();

			}
		});

    };
    $(".remove_doc").bind("click",handler_remove);

function submit_form_doc() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_doc"));

		$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=upload_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_doc").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_doc").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{

				var doc_length = $('#file_holder tr').length;
				const obj = JSON.parse(data);
				// console.log("yeah", data)
				console.log(doc_length)
				console.log(obj)

				setTimeout(function (){

					if (!obj.FILEWASOVERWRITTEN) {
						$("#file_none").empty();
						var new_doc = '<tr id="file_'+ (doc_length + 1) + '"><td colspan="2">';
						new_doc += '<a href="./assets/lessons/<cfoutput>#t_id#/#s_id#</cfoutput>/'+ obj.CLIENTFILE + '" target="_blank">'+ obj.CLIENTFILE + '</a>';
						<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
						new_doc += '<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="'+ obj.CLIENTFILE + '" id="delete_doc_'+ (doc_length + 1) + '">';
						new_doc += '<i class="fal fa-trash-alt"></i></i></a></td></tr>;';
						$("#file_holder").append(new_doc);

						$(".remove_doc").bind("click",handler_remove);
					}

					if ((doc_length + 1) > 3)  {
						$("#doc_upload_submit").prop("disabled",true);
						$("#doc_attach").prop("disabled",true);
					}
					

					$("#progress_doc").css("width","0%");	
				}, 1000);

			}
		});
			
					
	};


</script> --->


</cfif>