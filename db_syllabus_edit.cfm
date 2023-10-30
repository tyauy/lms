<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,4,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT sm.*, tp.formation_id, tp.tpmaster_id as tpm_id, tp.tpmaster_biglevel
FROM lms_tpsessionmaster2 sm
LEFT JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
LEFT JOIN lms_tpmaster2 tp ON tp.tpmaster_id = tpm.tpmaster_id
WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
AND tp.tpmaster_prebuilt = 0
</cfquery>

<cfset f_id = get_sessionmaster.formation_id>
<cfset m_id = get_sessionmaster.mapping_id>

<cfswitch expression="#get_sessionmaster.formation_id#">
<cfcase value="1"><cfset lang_temp = "fr"></cfcase>
<cfcase value="2"><cfset lang_temp = "en"></cfcase>
<cfcase value="3"><cfset lang_temp = "de"></cfcase>
<cfcase value="4"><cfset lang_temp = "es"></cfcase>
<cfcase value="5"><cfset lang_temp = "it"></cfcase>
</cfswitch>

<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpmodulemaster2 ORDER BY module_name
</cfquery>	

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_skill
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #get_sessionmaster.formation_id#
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #get_sessionmaster.formation_id#
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#lang_temp# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id <> 1 
</cfquery>

<cfquery name="get_tp_master" datasource="#SESSION.BDDSOURCE#">
SELECT tpmaster_id, CONCAT(tpmaster_level, " - ", tpmaster_name) as tpmaster_name FROM lms_tpmaster2 
WHERE tpmaster_prebuilt = 0
ORDER BY tpmaster_level
</cfquery>

<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_material
WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
SELECT voc_cat_id, voc_cat_name FROM lms_vocabulary_category ORDER BY voc_cat_name
</cfquery>
	
<cfquery name="get_chapter" datasource="#SESSION.BDDSOURCE#">
SELECT * 
FROM lms_tpchaptermaster2 ch
WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
ORDER BY chapter_rank
</cfquery>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_css, level_alias, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level ORDER BY level_alias
</cfquery>

<cfquery name="get_kwid" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_sessionmaster_keywordid_cor WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>


		
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>

</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : #obj_translater.get_translate('title_page_common_materials')#">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<cfif isdefined("k")>
			
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em>Modifications effectu&eacute;es.</em></div>
			</div>
		
			
			</cfif>	
			<!--- <button id="nextButton">NEXT</button> --->
			<div class="row">
			
				<div class="col-md-12">
				
					<div class="card">	

						<div class="card-title p-2 bg-light" align="center">
							<h6 style="font-size:20px !important">
							<cfoutput>#get_sessionmaster.sessionmaster_name#</cfoutput>
							</h6>
						</div>
					
						<div class="card-body">
							<cfform action="db_updater_syllabus.cfm">
							
							<div class="row">
							
								
								<div class="col-md-4">
									
									<cfoutput query="get_sessionmaster" group="sessionmaster_id">
									
									<table class="table table-sm table-bordered bg-white w-50" align="center">
										<tr>
											<td>
												VISIO<br>THUMB
												<!--- #obj_lms.get_thumb_session(sessionmaster_id="#get_sessionmaster.sessionmaster_id#",sessionmaster_code="#get_sessionmaster.sessionmaster_code#",size="200")# --->
												<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
													<img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
												<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
													<img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
												<cfelse>
													<img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
												</cfif>
												<br>
												<a href="##" class="btn btn-sm btn-outline-danger btn-block btn_upl_thumb p-1"><i class="fa fa-upload" aria-hidden="true"></i></a>
											</td>
											<td>
												EL<br>THUMB
												<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
													<img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
												<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
													<img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
												<cfelse>
													<img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
												</cfif>
												<br>
												<a href="##" class="btn btn-sm btn-outline-danger btn-block btn_upl_thumb p-1"><i class="fa fa-upload" aria-hidden="true"></i></a>
											</td>
										</tr>
											
									</table>
								</cfoutput>

									<cfoutput>
									<h5 class="d-inline">MAIN DETAILS (<a href="#SESSION.BO_ROOT_URL#/learner_practice.cfm?sm_id=#sm_id#&u_id=4348">view online</a>)</h5>
									</cfoutput>
									
									<div class="bg-light p-2 m-1 border">
										<h6>Lesson title</h6>
										
										<br>
										<ul class="nav nav-tabs" id="title_list" role="tablist">
											<li class="nav-item">		
											<a href="#smtitle_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<li class="nav-item">		
											<a href="##smtitle_#lg#" class="nav-link" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfoutput>
											</cfloop>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smtitle_0" style="margin-top:15px;">
												<cfoutput><input type="text" class="form-control" name="sessionmaster_name" value="#get_sessionmaster.sessionmaster_name#"></cfoutput>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane" id="smtitle_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="sessionmaster_name_#lg#" value="#evaluate('get_sessionmaster.sessionmaster_name_#lg#')#">
											</div>
											</cfoutput>
											</cfloop>											
										</div>
										
										<br>
										<h6>VISIO STATUS</h6>
										<label><input type="radio" name="sessionmaster_online_visio" value="0" <cfif get_sessionmaster.sessionmaster_online_visio eq "0">checked="checked"</cfif>> OFFLINE</label>
										&nbsp;&nbsp;&nbsp;
										<label><input type="radio" name="sessionmaster_online_visio" value="1" <cfif get_sessionmaster.sessionmaster_online_visio eq "1">checked="checked"</cfif>> ONLINE</label>
										&nbsp;&nbsp;&nbsp;
										<label><input type="radio" name="sessionmaster_online_visio" value="2" <cfif get_sessionmaster.sessionmaster_online_visio eq "2">checked="checked"</cfif>> TO REVIEW</label>
										<br><br>


										<h6>EL STATUS</h6>
										<label><input type="radio" name="sessionmaster_online_el" value="0" <cfif get_sessionmaster.sessionmaster_online_el eq "0">checked="checked"</cfif>> OFFLINE</label>
										&nbsp;&nbsp;&nbsp;
										<label><input type="radio" name="sessionmaster_online_el" value="1" <cfif get_sessionmaster.sessionmaster_online_el eq "1">checked="checked"</cfif>> ONLINE</label>
										&nbsp;&nbsp;&nbsp;
										<label><input type="radio" name="sessionmaster_online_el" value="2" <cfif get_sessionmaster.sessionmaster_online_el eq "2">checked="checked"</cfif>> TO REVIEW</label>
										<br><br>

										<h6>ORIENTATION</h6>
										<label><input type="radio" name="tp_orientation_id" value="1" <cfif get_sessionmaster.tp_orientation_id eq "1">checked="checked"</cfif>> General</label>
										&nbsp;
										<label><input type="radio" name="tp_orientation_id" value="2" <cfif get_sessionmaster.tp_orientation_id eq "2">checked="checked"</cfif>> Business</label>
										&nbsp;
										<label><input type="radio" name="tp_orientation_id" value="3" <cfif get_sessionmaster.tp_orientation_id eq "3">checked="checked"</cfif>> Grammar</label>
										&nbsp;
										<label><input type="radio" name="tp_orientation_id" value="4" <cfif get_sessionmaster.tp_orientation_id eq "4">checked="checked"</cfif>> Certif</label>
										&nbsp;
										<label><input type="radio" name="tp_orientation_id" value="6" <cfif get_sessionmaster.tp_orientation_id eq "6">checked="checked"</cfif>> Video</label>
										<br><br>

										
										<h6>Level</h6>
										<select name="level_id" class="form-control">
											<cfloop query="get_level">
												<cfoutput>
												<option value="#level_id#" <cfif get_sessionmaster.level_id eq level_id>selected</cfif>>#level_alias#</option>
												</cfoutput>
											</cfloop>
										</select>
										<br>
										<h6>ADMIN NOTE</h6>
										<textarea name="sessionmaster_admin_note" id="sessionmaster_admin_note" class="form-control" rows="4"><cfoutput>#get_sessionmaster.sessionmaster_admin_note#</cfoutput></textarea>
										<br>
										<h6>Attachment name  </h6>
										<small>No special char, no file format, just : 694_Attending_Meetings</small>
										<input type="text" class="form-control" name="sessionmaster_ressource" value="<cfoutput>#get_sessionmaster.sessionmaster_ressource#</cfoutput>">
										<br>
										<h6>Estimated time</h6>
										<select name="sessionmaster_duration" class="form-control">
											<option value="15" <cfif get_sessionmaster.sessionmaster_duration eq "15">selected</cfif>>15 min</option>
											<option value="30" <cfif get_sessionmaster.sessionmaster_duration eq "30">selected</cfif>>30 min</option>
											<option value="45" <cfif get_sessionmaster.sessionmaster_duration eq "45">selected</cfif>>45 min</option>
											<option value="60" <cfif get_sessionmaster.sessionmaster_duration eq "60">selected</cfif>>60 min</option>
										</select>
										<br>
										<h6>e-Learning Estimated time</h6>
										<select name="sessionmaster_el_duration" class="form-control">
											<option value="15" <cfif get_sessionmaster.sessionmaster_el_duration eq "15">selected</cfif>>15 min</option>
											<option value="30" <cfif get_sessionmaster.sessionmaster_el_duration eq "30">selected</cfif>>30 min</option>
											<option value="45" <cfif get_sessionmaster.sessionmaster_el_duration eq "45">selected</cfif>>45 min</option>
											<option value="60" <cfif get_sessionmaster.sessionmaster_el_duration eq "60">selected</cfif>>60 min</option>
											<option value="60" <cfif get_sessionmaster.sessionmaster_el_duration eq "90">selected</cfif>>90 min</option>
											<option value="60" <cfif get_sessionmaster.sessionmaster_el_duration eq "120">selected</cfif>>120 min</option>
										</select>
										<br>
										<h6>Category</h6>						
										<cfselect class="form-control" name="tpmaster_id" query="get_tp_master" display="tpmaster_name" value="tpmaster_id" selected="#get_sessionmaster.tpm_id#"></cfselect>
										<br>
										<h6>Module</h6>						
										<cfselect name="module_id" query="get_module" display="module_name" value="module_id" selected="#get_sessionmaster.module_id#" class="form-control">
										<option value="" <cfif get_sessionmaster.module_id eq "">selected</cfif>>---N/A----</option>
										</cfselect>
										<br>
										
										

									</div>

								</div>
									
									
									
								
								<div class="col-md-8">
								
									<cfoutput><h5>ADDITIONNAL CONTENT [<a href="./tpl/test_ln_container.cfm?sm_id=#sm_id#" target="_blank">Overview</a>]</h5></cfoutput>
												
								
									<cfif get_sessionmaster.sessionmaster_ressource neq "">
									<div class="row">
										<div class="col-md-6">
										<table class="table table-sm table-bordered bg-white">
											<tr bgcolor="#ECECEC">
												<td align="center" colspan="8"><strong>MAIN ATTACHMENT</strong></td>
											</tr>
											<cfoutput>
											<tr>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WS.pdf")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WS.pdf" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>WS<br><span style="font-weight:normal;">PDF</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>WS<br><span style="font-weight:normal;">PDF</span></a>
													</cfif>
												</td>
												<td width="13%">	
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WSK.pdf")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WSK.pdf" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>WS+K<br><span style="font-weight:normal;">PDF</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>WS+K<br><span style="font-weight:normal;">PDF</span></a>
													</cfif>
												</td>
												<td width="13%">	
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_K.pdf")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_K.pdf" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>KEYS<br><span style="font-weight:normal;">PDF</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>KEYS<br><span style="font-weight:normal;">PDF</span></a>
													</cfif>
												</td>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WS.pptx")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WS.pptx" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>WS<br><span style="font-weight:normal;">PPTX</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>WS<br><span style="font-weight:normal;">PPTX</span></a>
													</cfif>
												</td>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WSK.pptx")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_WSK.pptx" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>WS+K<br><span style="font-weight:normal;">PPTX</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>WS+K<br><span style="font-weight:normal;">PPTX</span></a>
													</cfif>
												</td>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_K.pptx")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_K.pptx" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>KEYS<br><span style="font-weight:normal;">PPTX</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>KEYS<br><span style="font-weight:normal;">PPTX</span></a>
													</cfif>
												</td>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_AUDIO1.mp3")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_AUDIO1.mp3" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>AUDIO<br><span style="font-weight:normal;">MP3</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>AUDIO<br><span style="font-weight:normal;">MP3</span></a>
													</cfif>
												</td>
												<td width="13%">
													<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_VIDEO1.mp4")>
														<a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_VIDEO1.mp4" target="_blank" class="btn btn-sm btn-success btn-block"><i class="fas fa-check"></i><br>VIDEO<br><span style="font-weight:normal;">MP4</span></a>
													<cfelse>
														<a href="##" class="btn btn-sm btn-outline-danger btn-block"><i class="fas fa-times"></i><br>VIDEO<br><span style="font-weight:normal;">MP4</span></a>
													</cfif>
												</td>
											</tr>
											</cfoutput>
											<tr>
												<td width="100%" colspan="8"><a href="##" class="btn btn-sm btn-outline-danger btn-block btn_upl_core p-1"><i class="fa fa-upload" aria-hidden="true"></i></a></td>
											</tr>
												
										</table>
										</div>
										
										<div class="col-md-6">
										<table class="table table-sm table-bordered bg-white">
											<tr bgcolor="#ECECEC">
												<td align="center" colspan="7"><strong>ELEARNING ATTACHMENT</strong></td>
											</tr>
											<cfoutput query="get_material">
											<tr>
												<td width="10%"><small>FILE ###material_id#</small></td>		
												<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#material_id#.pdf")>
												<td><a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#material_id#.pdf" target="_blank">#material_name#</a></td>
												<td><small>#mid(material_description,1,30)# [...]</small></td>
												<td width="10%">pdf</td>
												<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#material_id#.jpg")>
												<td><a href="/assets/materials/#get_sessionmaster.sessionmaster_ressource#_#material_id#.jpg" target="_blank">#material_name#</a></td>
												<td><small>#mid(material_description,1,30)# [...]</small></td>
												<td width="10%">jpg</td>
												</cfif>		
												<td width="10%"><a href="updater_upload_ressource.cfm?misc_material=1&act=delete&sm_id=#sm_id#&material_id=#material_id#&sessionmaster_ressource=#get_sessionmaster.sessionmaster_ressource#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
											</tr>	
											</cfoutput>
											<tr>
												<td width="100%" colspan="7"><a href="##" class="btn btn-sm btn-outline-danger btn-block btn_upl_misc p-1"><i class="fa fa-upload" aria-hidden="true"></i></a></td>
											</tr>
										</table>
										</div>
									</div>
									</cfif>

									<h5>GLOBAL MAPPING</h5>

									<div class="bg-light p-2 m-1 mt-3 border">
									<h6>Interests (English for Life)<a class="btn btn-sm btn-primary" data-toggle="collapse" href="#interest_div" role="button" aria-expanded="false" aria-controls="interest_div"><i class="fas fa-chevron-down"></i></a></h6>
		
										<div class="collapse show" id="interest_div">
										
											<!--- <ul class="nav nav-tabs" id="keyword_list" role="tablist">
												<cfoutput query="get_keyword_cat">
													<cfif keyword_cat_id eq "3">
														<li class="nav-item">		
														<a href="##k_#keyword_cat_id#" class="nav-link <cfif keyword_cat_id eq "3">active</cfif>" role="tab" data-toggle="tab">
														#keyword_cat_name#
														</a>
														</li>
													</cfif>
												</cfoutput>
											</ul>

											<div class="tab-content"> --->
												
												<cfloop query="get_keyword_cat">
													<cfif keyword_cat_id eq "3">
														<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
														SELECT k.keyword_id, k.keyword_name_#lang_temp# as keyword_name FROM lms_keyword2 k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> AND is_active = 1 AND parent_id = 0 ORDER BY keyword_name
														</cfquery>

														<div role="tabpanel" class="tab-pane <cfif keyword_cat_id eq "3">active show</cfif>" id="k_<cfoutput>#get_keyword_cat.keyword_cat_id#</cfoutput>" style="margin-top:15px;">
															
															<div class="row">
																<div class="col-md-4">
																<cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
																<label><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label><br>							
																</cfoutput>
																</div>
																
																<div class="col-md-4">
																<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
																<label><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label><br>				
																</cfoutput>
																</div>

																<div class="col-md-4">
																<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
																<label><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label><br>				
																</cfoutput>
																</div>
																
															</div>
															
														</div>
													</cfif>
												</cfloop>


												<div id="container_kw_children" class="border bg-white p-2 rounded">
												
												<cfinclude template="./incl/incl_kw_filler.cfm">
												
												</div>
												
											<!--- </div> --->
										
										</div>
									</div>

									<div class="bg-light p-2 m-1 mt-3 border">
									<h6>Keywords<a class="btn btn-sm btn-primary" data-toggle="collapse" href="#keyword_div" role="button" aria-expanded="false" aria-controls="keyword_div"><i class="fas fa-chevron-down"></i></a></h6>
		
										<div class="collapse show" id="keyword_div">
										
											
											<ul class="nav nav-tabs" id="keyword_list" role="tablist">
												<cfoutput query="get_keyword_cat">
													<cfif keyword_cat_id neq "3">
														<li class="nav-item">		
														<a href="##k_#keyword_cat_id#" class="nav-link <cfif keyword_cat_id eq "4">active</cfif>" role="tab" data-toggle="tab">
															#keyword_cat_name#
														</a>
														</li>
													</cfif>
												</cfoutput>
											</ul>

											<div class="tab-content">
												
												<cfloop query="get_keyword_cat">
												
													<cfif keyword_cat_id neq "3">
														<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
														SELECT k.keyword_id, k.keyword_name_#lang_temp# as keyword_name FROM lms_keyword2 k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> ORDER BY keyword_name
														</cfquery>

														<div role="tabpanel" class="tab-pane <cfif keyword_cat_id eq "4">active show</cfif>" id="k_<cfoutput>#get_keyword_cat.keyword_cat_id#</cfoutput>" style="margin-top:15px;">
															
															<div class="row">
																<div class="col-md-6">
																<cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/2)#">
																<label><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label><br>							
																</cfoutput>
																</div>
																
																<div class="col-md-6">
																<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/2)+1#" maxrows="#get_keyword.recordcount#">
																<label><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label><br>				
																</cfoutput>
																</div>
																
															</div>
															
														</div>
													</cfif>
												</cfloop>
												
											</div>
										
										</div>
									</div>

									<div class="bg-light p-2 m-1 mt-3 border">
									
										<h6>Mapping points (Mandatory)<a class="btn btn-sm btn-primary" data-toggle="collapse" href="#mapping_div" role="button" aria-expanded="false" aria-controls="mapping_div"><i class="fas fa-chevron-down"></i></a></h6>
										
										<div class="collapse show" id="mapping_div">

											<cfinclude template="./incl/incl_mapping_edit.cfm">
										
										</div>

									</div>

									<div class="bg-light p-2 m-1 mt-3 border">
									
										<h6>Vocabulary list (eLearning)<a class="btn btn-sm btn-primary" data-toggle="collapse" href="#voc_div" role="button" aria-expanded="false" aria-controls="voc_div"><i class="fas fa-chevron-down"></i></a></h6>
										
										<div class="collapse" id="voc_div">
										
											<div class="row">
												<div class="col-md-4">
													<cfoutput query="get_category" startrow="1" maxrows="#ceiling(get_category.recordcount/3)#">
													<label><input type="checkbox" name="voc_cat_id" value="#voc_cat_id#" <cfif listfind(get_sessionmaster.voc_cat_id,get_category.voc_cat_id)>checked</cfif>> #voc_cat_name#</label><br>
													</cfoutput>
												</div>
												<div class="col-md-4">
													<cfoutput query="get_category" startrow="#ceiling(get_category.recordcount/3)+1#" maxrows="#ceiling(get_category.recordcount/3)#">
													<label><input type="checkbox" name="voc_cat_id" value="#voc_cat_id#" <cfif listfind(get_sessionmaster.voc_cat_id,get_category.voc_cat_id)>checked</cfif>> #voc_cat_name#</label><br>
													</cfoutput>
												</div>
												<div class="col-md-4">
													<cfoutput query="get_category" startrow="#ceiling(get_category.recordcount/3)*2+1#" maxrows="#get_category.recordcount#">
													<label><input type="checkbox" name="voc_cat_id" value="#voc_cat_id#" <cfif listfind(get_sessionmaster.voc_cat_id,get_category.voc_cat_id)>checked</cfif>> #voc_cat_name#</label><br>
													</cfoutput>
												</div>
											</div>
											
										</div>
										
									</div>

													
									<!--- <div class="bg-light p-2 m-1 mt-3 border">
										<h6>Skills covered</h6>
										<div class="row">
															
											<div class="col-md-6">
											<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
											<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(get_sessionmaster.skill_id,skill_id)>checked</cfif>> #skill_name#</label><br>							
											</cfoutput>
											</div>
											
											<div class="col-md-6">
											<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
											<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(get_sessionmaster.skill_id,skill_id)>checked</cfif>> #skill_name#</label><br>				
											</cfoutput>
											</div>
											
										</div>
									
									</div> --->
									
									


									<!--- <div class="bg-light p-2 m-1 mt-3 border">
									
									<h6>Grammar points (old)<a class="btn btn-sm btn-primary" data-toggle="collapse" href="#grammar_div" role="button" aria-expanded="false" aria-controls="grammar_div"><i class="fas fa-chevron-down"></i></a></h6>
									
									<div class="collapse" id="grammar_div">
									
										<ul class="nav nav-tabs" id="grammar_list" role="tablist">
											<cfset counter = 0>
											<cfoutput query="get_grammar_level">
											<cfset counter ++>
											<li class="nav-item">		
											<a href="##g_#counter#" class="nav-link <cfif counter eq "1">active</cfif>" role="tab" data-toggle="tab">
											#grammar_level#
											</a>
											</li>
											</cfoutput>
										</ul>

										<div class="tab-content">
											<cfset counter = 0>
											<cfloop query="get_grammar_level">
											<cfset counter ++>
											
											<div role="tabpanel" class="tab-pane <cfif counter eq "1">active show</cfif>" id="g_<cfoutput>#counter#</cfoutput>" style="margin-top:15px;">
												
												<div class="row">
												
													<cfloop query="get_grammar_cat">
													
													<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
													SELECT * FROM lms_grammar WHERE grammar_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_grammar_cat.grammar_cat_id#"> AND grammar_level = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_grammar_level.grammar_level#"> ORDER BY grammar_name
													</cfquery>
												
													<div class="col-md-3">
													<strong><cfoutput>#get_grammar_cat.grammar_cat_name#</cfoutput></strong><br>
													<cfoutput query="get_grammar">
													<label><input type="checkbox" name="grammar_id" id="grammar_id" value="#grammar_id#" <cfif listfind(get_sessionmaster.grammar_id,grammar_id)>checked</cfif>> #grammar_name#</label><br>							
													</cfoutput>
													</div>
													
													</cfloop>
													
													
													
												</div>
												
											</div>
											</cfloop>
											
										</div>
									
									</div>
									
									</div> --->
									
									<br>
									<cfoutput query="get_sessionmaster">
									<h5>MAIN DESCRIPTION</h5>
									
									<div class="bg-light p-2 m-1 border">									
										<h6>Main description</h6>						
										
										<ul class="nav nav-tabs" id="description_list" role="tablist">
											<li class="nav-item">		
											<a href="##smdesc_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<li class="nav-item">		
											<a href="##smdesc_#lg#" class="nav-link" role="tab" data-toggle="tab">
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfloop>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smdesc_0" style="margin-top:15px;">
												<textarea name="sessionmaster_description" id="sessionmaster_description" class="form-control" rows="4">#sessionmaster_description#</textarea>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<div role="tabpanel" class="tab-pane" id="smdesc_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
												<textarea name="sessionmaster_description_#lg#" id="sessionmaster_description_#lg#" class="form-control" rows="4">#evaluate("sessionmaster_description_#lg#")#</textarea>
											</div>
											</cfloop>											
										</div>
									
									</div>


									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>Objectives</h6>						
									
										<ul class="nav nav-tabs" id="objectives_list" role="tablist">
											<li class="nav-item">		
											<a href="##smobj_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<li class="nav-item">		
											<a href="##smobj_#lg#" class="nav-link" role="tab" data-toggle="tab">
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfloop>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smobj_0" style="margin-top:15px;">
												<textarea name="sessionmaster_objectives" id="sessionmaster_objectives" class="form-control" rows="3">#sessionmaster_objectives#</textarea>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<div role="tabpanel" class="tab-pane" id="smobj_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
												<textarea name="sessionmaster_objectives_#lg#" id="sessionmaster_objectives_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_objectives_#lg#")#</textarea>
											</div>
											</cfloop>											
										</div>
									
									</div>

									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>Grammar</h6>						
										
										<ul class="nav nav-tabs" id="grammar_list" role="tablist">
											<li class="nav-item">		
											<a href="##smgr_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<li class="nav-item">		
											<a href="##smgr_#lg#" class="nav-link" role="tab" data-toggle="tab">
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfloop>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smgr_0" style="margin-top:15px;">
												<textarea name="sessionmaster_grammar" id="sessionmaster_grammar" class="form-control" rows="3">#sessionmaster_grammar#</textarea>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<div role="tabpanel" class="tab-pane" id="smgr_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
												<textarea name="sessionmaster_grammar_#lg#" id="sessionmaster_grammar_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_grammar_#lg#")#</textarea>
											</div>
											</cfloop>											
										</div>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>Vocabulary</h6>						
										
										<ul class="nav nav-tabs" id="vocabulary_list" role="tablist">
											<li class="nav-item">		
											<a href="##smvoc_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<li class="nav-item">		
											<a href="##smvoc_#lg#" class="nav-link" role="tab" data-toggle="tab">
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfloop>
										</ul>
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smvoc_0" style="margin-top:15px;">
												<textarea name="sessionmaster_vocabulary" id="sessionmaster_vocabulary" class="form-control" rows="3">#sessionmaster_vocabulary#</textarea>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<div role="tabpanel" class="tab-pane" id="smvoc_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
												<textarea name="sessionmaster_vocabulary_#lg#" id="sessionmaster_vocabulary_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_vocabulary_#lg#")#</textarea>
											</div>
											</cfloop>											
										</div>
									
									</div>
									
									</cfoutput>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>GRAMMAR POINTS (Lesson note + eLearning)</h6>						
										<cfoutput><textarea name="sessionmaster_ln_grammar" id="sessionmaster_ln_grammar" class="form-control" rows="4">#get_sessionmaster.sessionmaster_ln_grammar#</textarea></cfoutput>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>VOCABULARY POINTS (Lesson note + eLearning)</h6>								
										<cfoutput><textarea name="sessionmaster_ln_vocabulary" id="sessionmaster_ln_vocabulary" class="form-control" rows="4">#get_sessionmaster.sessionmaster_ln_vocabulary#</textarea></cfoutput>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>Video content (eLearning)</h6>								
										<cfoutput><textarea name="sessionmaster_video" id="sessionmaster_video" class="form-control" rows="4">#get_sessionmaster.sessionmaster_video#</textarea></cfoutput>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>Exercices HTML (eLearning)</h6>								
										<cfoutput><textarea name="sessionmaster_exercice" id="sessionmaster_exercice" class="form-control" rows="4">#get_sessionmaster.sessionmaster_exercice#</textarea></cfoutput>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
										<h6>TRANSCRIPT (eLearning)</h6>	
										<cfoutput>
										<ul class="nav nav-tabs" id="transcript_list" role="tablist">
											<li class="nav-item">		
											<a href="##smtranscript_0" class="nav-link active" role="tab" data-toggle="tab">
											Default
											</a>
											</li>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<li class="nav-item">		
											<a href="##smtranscript_#lg#" class="nav-link" role="tab" data-toggle="tab">
											<span class="lang-sm" lang="#lg#"></span>
											</a>
											</li>
											</cfloop>
										</ul>
										
										<div class="tab-content">
											<div role="tabpanel" class="tab-pane active show" id="smtranscript_0" style="margin-top:15px;">
												<textarea class="sessionmaster_transcript" name="sessionmaster_transcript" id="sessionmaster_transcript" class="form-control" rows="3">#get_sessionmaster.sessionmaster_transcript#</textarea>
											</div>
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<div role="tabpanel" class="tab-pane" id="smtranscript_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
												<textarea class="sessionmaster_transcript" name="sessionmaster_transcript_#lg#" id="sessionmaster_transcript_#lg#" class="form-control" rows="3">#evaluate("get_sessionmaster.sessionmaster_transcript_#lg#")#</textarea>
											</div>
											</cfloop>											
										</div>
										</cfoutput>


										<!--- <cfoutput><textarea name="sessionmaster_transcript" id="sessionmaster_transcript" class="form-control" rows="4">#get_sessionmaster.sessionmaster_transcript#</textarea></cfoutput> --->
									</div>
									
								</div>
								
							</div>
							
							<cfoutput>
							<input type="hidden" name="sm_id" value="#sm_id#">
							<input type="hidden" name="updt_sm" value="1">
							</cfoutput>
							<div align="center"><input type="submit" class="btn btn-info" value="Save"></div>
							
							</cfform>
							
							<!--- <div class="row">
								
								<div class="col-12">
								
									<div class="bg-light p-2 m-1 mt-3 border">
									<div id="accordion_chapter">
										
										<cfoutput query="get_chapter">
										<form action="db_updater_syllabus.cfm" method="post">
										<div class="card mb-1">
											<div class="card-header p-1 m-1">
											<h6 class="mb-0"><a class="btn btn-link" data-toggle="collapse" data-target="##ch_#chapter_id#" aria-expanded="true" aria-controls="ch_#chapter_id#">
											CHAPTER #chapter_rank# : #chapter_name#
											</a></h6>
											</div>

											<div id="ch_#chapter_id#" class="collapse <cfif chapter_rank eq "1">show</cfif>" data-parent="##accordion_chapter">
											<div class="card-body">
											<textarea class="form-control chapter_content" rows="15">#chapter_content#</textarea>
											<input type="hidden" name="sm_id" value="#sm_id#">
											<input type="hidden" name="ch_id" value="#chapter_id#">
											<input type="hidden" name="updt_chapter" value="1">
											<div align="center"><input type="submit" class="btn btn-info" value="Save chapter"></div>
											</div>
											</div>
										</div>
										</form>
										</cfoutput>
										
									</div>
									</div>
								
								</div>
								
							</div> --->
							
							
							
							
						</div>
					</div>
				</div>			
			</div>
				
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>

$('#nextButton').click(function() {
        // Get the current URL
        var url = window.location.href;

        // Extract the sm_id parameter
        var sm_id = url.match(/sm_id=(\d+)/)[1];

        // Increment the sm_id
        var next_sm_id = parseInt(sm_id) + 1;

        // Replace the sm_id in the URL
        var nextUrl = url.replace(/sm_id=\d+/, 'sm_id=' + next_sm_id);

        // Navigate to the next URL
        window.location.href = nextUrl;
    });
	$('.btn_upl_core').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&core_material=1"</cfoutput>, function() {});
	});

	var handler_click_kw = function affect_kw(){
		event.preventDefault();

		kw_name = $('#kw_name').val();

		$.ajax({
			url: 'api/keyword/keyword_post.cfc?method=insert_kw',
			type: 'POST',
			data : {
                kw_name: kw_name,
                sm_id: <cfoutput>#sm_id#</cfoutput>
            },
			datatype : "html", 
			success : function(result, status){
				
				$('#container_kw_children').empty();

				$.ajax({
					url: 'incl/incl_kw_filler.cfm',
					type: 'POST',
					data : {
						lang_temp: "<cfoutput>#lang_temp#</cfoutput>",
						sm_id: <cfoutput>#sm_id#</cfoutput>
					},
					datatype : "html", 
					success : function(result, status){
							$('#container_kw_children').append(result);
							
                    	$(".btn_kw_submit").bind("click",handler_click_kw);
					}

				})
			}
		});

	}
    $(".btn_kw_submit").bind("click",handler_click_kw);

	
	$('.btn_upl_misc').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&misc_material=1"</cfoutput>, function() {});
	});
	
	$('.btn_upl_thumb').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&thumb_material=1"</cfoutput>, function() {});
	});
</script>


	<script>

	tinymce.init({
	
	selector:'#sessionmaster_ln_grammar,#sessionmaster_ln_vocabulary,.sessionmaster_transcript,#sessionmaster_exercice,.chapter_content',
	branding: false,
	contextmenu: "link image imagetools table spellchecker",
	contextmenu_never_use_native: true,
	draggable_modal: false,
	menubar: '',	
	toolbar: 'undo redo | bold italic underline numlist bullist forecolor link fontsizeselect | alignleft aligncenter alignright alignjustify | table | code',
	plugins: "lists,link,code,table",
	fontsize_formats: '11px 12px 14px'
	/*file: { title: 'File', items: '' },
    edit: { title: 'Edit', items: '' },
    view: { title: 'View', items: '' },
    insert: { title: 'Insert', items: '' },
    format: { title: 'Format', items: '' },
    tools: { title: 'Tools', items: 'spellchecker spellcheckerlanguage | code wordcount' },
    table: { title: 'Table', items: 'inserttable tableprops deletetable row column cell' },
    help: { title: 'Help', items: 'help' }*/
  
	
	});
	</script>

	
<div id="window_item_xl" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_xl" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_xl" class="modal-body">
			
			</div>
        </div>
    </div>
</div>
	
</body>
</html>