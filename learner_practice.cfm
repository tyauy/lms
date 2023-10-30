<!DOCTYPE html>

<cfsilent>

<!--- <cfset secure = "3,7,8,9,5,12">
<cfinclude template="./incl/incl_secure.cfm">	 --->

<cfset sm_rec_time = "1">

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<cfset u_id = u_id>
	<cfset p_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
</cfif>

<cfset get_session_description = obj_query.oget_session_description(sm_id="#sm_id#")>

<cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#">
SELECT tp.formation_id, f.formation_code
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
INNER JOIN lms_formation f ON f.formation_id = tp.formation_id	
WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.*, tm.module_name, ue.sm_elapsed, ue.sm_lastview
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
LEFT JOIN user_elapsed ue ON ue.sm_id = sm.sessionmaster_id	AND ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation_solo.formation_id#">
AND tp.tpmaster_prebuilt = 0
AND sm.sessionmaster_online_el = 1
<cfif isdefined("SESSION.USER_EL_LIST") AND SESSION.USER_EL_LIST neq "" AND listlen(SESSION.USER_EL_LIST) gt 0>
AND sm.sessionmaster_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_EL_LIST#" list="true">)
<cfelse>
AND 1 = 2
</cfif>
GROUP BY sm.sessionmaster_id
ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
</cfquery>

<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_material
WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_quiz_unit" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz
WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> AND quiz_type = 'unit'
AND quiz_active = 1
</cfquery>

<cfquery name="get_quiz_exercice" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_quiz
WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#"> AND quiz_type = 'exercice'
AND quiz_active = 1
</cfquery>


<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
	
<cfset lang_select = lcase(get_formation_solo.formation_code)>
<cfset lang_select_id = lcase(get_formation_solo.formation_id)>
<cfparam name="lang_translate" default="">
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style type="text/css">
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	
}
</style>
	
<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "e-Learning Essential">  
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
			
			<cfoutput>
			<a class="btn btn-link" type="button" href="common_practice.cfm?f_id=#get_formation_solo.formation_id#"><i class="fa-light fa-lg fa-folder-open"></i> <br>#obj_translater.get_translate('btn_my_e_program')#</a>
			<a class="btn btn-link" type="button" href="common_practice.cfm"><i class="fa-light fa-lg fa-book"></i> <br>e-Learning Resources</a>
			</cfoutput>
			
			<div class="row">
				
				<div class="col-md-8">

					<div class="card border-top border-red">
						<div class="card-body">	
								
								
							<cfoutput query="get_session_description">
							
							<h5 align="center">#sessionmaster_name#</h5>
							
							<cfif not isdefined("SESSION.ACCESS_EL")>
								<div class="alert alert-warning mt-3" role="alert" align="center">
									<strong><cfoutput>#obj_translater.get_translate('alert_title_no_access_page')#</cfoutput></strong>
									<br>
									<cfoutput>#obj_translater.get_translate('alert_no_access_page')#</cfoutput>
									<br>
									<button class="btn btn-info btn_contact_wefit"><i class="fa-light fa-lg fa-unlock"></i> <cfoutput>#obj_translater.get_translate('btn_unlock')#</cfoutput></button>						
								</div>
							<cfelse>
							
								<div class="row">
								
									<div class="col-md-3">
										#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#	
									</div>
									
									<div class="col-md-9">
										<table class="table bg-white table-bordered m-0">
											
											<cfif sessionmaster_el_duration neq "">
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-clock"></i> <small>#obj_translater.get_translate('table_th_recommended_time')#</small></td>
												<td>
													#obj_translater.get_translate('text_about')# #sessionmaster_el_duration# m
												</td>
											</tr>
											</cfif>	
											
											<cfif sessionmaster_description neq "">
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-book"></i> <small>#obj_translater.get_translate('table_th_el_description')#</small></td>
												<td>
													#sessionmaster_description#
												</td>
											</tr>
											</cfif>
											
											<cfif sessionmaster_objectives neq "">
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-book"></i> <small>#obj_translater.get_translate('table_th_course_objectives')#</small></td>
												<td>
													#sessionmaster_objectives#
												</td>
											</tr>
											</cfif>
											
											<cfif sessionmaster_grammar neq "">
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-book"></i> <small>#obj_translater.get_translate('table_th_course_grammar')#</small></td>
												<td>
													#sessionmaster_grammar#
												</td>
											</tr>
											</cfif>
											
											<cfif sessionmaster_vocabulary neq "">
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-book"></i> <small>#obj_translater.get_translate('table_th_course_vocabulary')#</small></td>
												<td>
													#sessionmaster_vocabulary#
												</td>
											</tr>
											</cfif>
											
											<cfif keyword_id neq "">
											<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
											SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
											</cfquery>
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-key"></i> <small>#obj_translater.get_translate('card_keywords')#</small></td>
												<td>
													<cfloop query="get_keyword"><span class="badge badge-info">#keyword_name#</span> </cfloop>
												</td>
											</tr>
											</cfif>

											<cfif grammar_id neq "">
											<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
											SELECT grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#)
											</cfquery>
											<tr>
												<td width="20%"><i class="fa-light fa-lg fa-bookmark"></i> <small>#obj_translater.get_translate('card_grammar')#</small></td>
												<td>
													<cfloop query="get_grammar"><span class="badge badge-info">#grammar_name#</span> </cfloop>
												</td>
											</tr>
											</cfif>

										</table>
									</div>
									
								</div>
							
								<br>
							
								<div class="row">
									
									<div class="col-md-12">
										
										<ul class="nav nav-tabs" role="tablist" id="tabs_content">
											
											<cfif sessionmaster_video neq "">
											<li class="nav-item">
												<a class="nav-link active" href="##tab_VIDEO" role="tab" data-toggle="tab" id="title_VIDEO">
													<div align="center"><i class="fa-light fa-lg fa-video"></i> <br>#obj_translater.get_translate('btn_el_video')#</div>											
												</a>
											</li>
											</cfif>
											
											<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
											<li class="nav-item">
												<a class="nav-link <cfif sessionmaster_video eq "" AND not isdefined("tab_VOCLIST")>active</cfif>" href="##tab_WS" role="tab" data-toggle="tab" id="title_WS">
												<div align="center"><i class="fa-light fa-lg fa-file-alt"></i> <br>#obj_translater.get_translate('btn_el_support')#</div>
												</a>
											</li>
											<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
											<li class="nav-item">
												<a class="nav-link <cfif sessionmaster_video eq "" AND not isdefined("tab_VOCLIST")>active</cfif>" href="##tab_WSK" role="tab" data-toggle="tab" id="title_WSK">
												<div align="center"><i class="fa-light fa-lg fa-file-alt"></i> <br>#obj_translater.get_translate('btn_el_support')#</div>
												</a>
											</li>
											</cfif>
											
											<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
											<li class="nav-item">
												<a class="nav-link" href="##tab_K" role="tab" data-toggle="tab" id="title_K">
												<div align="center"><i class="fa-light fa-lg fa-file-alt"></i> <br>#obj_translater.get_translate('btn_el_keys')#</div>
												</a>
											</li>
											</cfif>
											
											<cfif sessionmaster_ln_grammar neq "">
											<li class="nav-item">
												<a class="nav-link" href="##tab_GRAM" role="tab" data-toggle="tab" id="title_GRAM">
													<div align="center"><i class="fa-light fa-lg fa-book"></i> <br>#obj_translater.get_translate('btn_el_grammar_points')#</div>												
												</a>
											</li>
											</cfif>
											
											<cfif sessionmaster_ln_vocabulary neq "">
											<li class="nav-item">
												<a class="nav-link" href="##tab_VOC" role="tab" data-toggle="tab" id="title_VOC">
													<div align="center"><i class="fa-light fa-lg fa-comments"></i> <br>#obj_translater.get_translate('btn_el_voc_points')#</div>
												</a>
											</li>
											</cfif>
											
											<cfif voc_cat_id neq "">
											<li class="nav-item">
												<a class="nav-link <cfif isdefined("tab_VOCLIST")>active</cfif>" href="##tab_VOCLIST" role="tab" data-toggle="tab" id="title_VOC">
													<div align="center"><i class="fa-light fa-lg fa-list"></i> <br>#obj_translater.get_translate('btn_el_vocab_list')#</div>
												</a>
											</li>
											</cfif>
											
											<cfif sessionmaster_transcript neq "">
											<li class="nav-item">
												<a class="nav-link" href="##tab_TRANS" role="tab" data-toggle="tab" id="title_TRANS">
													<div align="center"><i class="fa-light fa-lg fa-file-alt"></i> <br>#obj_translater.get_translate('btn_el_transcript')#</div>											
												</a>
											</li>
											</cfif>
											
											<cfif sessionmaster_exercice neq "">
											<li class="nav-item">
												<a class="nav-link" href="##tab_EX" role="tab" data-toggle="tab" id="title_EX">
													<div align="center"><i class="fa-light fa-lg fa-edit"></i> <br>#obj_translater.get_translate('btn_el_exercices')#</div>											
												</a>
											</li>
											</cfif>
											
											<cfif get_material.recordcount neq "0">
											<li class="nav-item">
												<a class="nav-link" href="##tab_DL" role="tab" data-toggle="tab" id="title_DL">
													<div align="center"><i class="fa-light fa-lg fa-arrow-down"></i> <br>#obj_translater.get_translate('btn_el_resources')#</div>
												</a>
											</li>
											</cfif>
											
											<cfif get_quiz_unit.recordcount neq "0" OR get_quiz_exercice.recordcount neq "0">
											<li class="nav-item">
												<a class="nav-link" href="##tab_QUIZ" role="tab" data-toggle="tab" id="title_QUIZ">
													<div align="center"><i class="fa-light fa-lg fa-light fa-lg fa-medal"></i> <br>#obj_translater.get_translate('btn_el_practice')#</div>
												</a>
											</li>
											</cfif>
																					
										</ul>

										<div class="tab-content">
											
											<cfif sessionmaster_video neq "">
											<div class="tab-pane show active" id="tab_VIDEO" role="tabpanel" id="title_VIDEO">
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
															<div align="center">
															#sessionmaster_video#
															</div>
														</div>
													</div>
												</div>							
											</div>
											</cfif>
											
											<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
											<div class="tab-pane <cfif sessionmaster_video eq "" AND not isdefined("tab_VOCLIST")>show active</cfif>" id="tab_WS" role="tabpanel" id="title_WS">
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														<iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WS"></iframe>
														</div>
													</div>
												</div>											
											</div>
											<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
											<div class="tab-pane <cfif sessionmaster_video eq "" AND not isdefined("tab_VOCLIST")>show active</cfif>" id="tab_WSK" role="tabpanel" id="title_WSK">
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														<iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WSK"></iframe>
														</div>
													</div>
												</div>
											</div>
											</cfif>
											
											<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
											<div class="tab-pane" id="tab_K" role="tabpanel" id="title_K">
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														<iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=K"></iframe>
														</div>
													</div>
												</div>
											</div>
											</cfif>
											
											<cfif voc_cat_id neq "">
											
											<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
											SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (#voc_cat_id#) ORDER BY voc_cat_name
											</cfquery>
															
											<div class="tab-pane <cfif isdefined("tab_VOCLIST")>show active</cfif>" id="tab_VOCLIST" role="tabpanel" id="title_VOCLIST">
											
												<div class="container">
													<div class="row mt-3">
														<div class="col-md-12">
															<cfoutput>
															<table class="table table-borderless">
																<tr>
																	<td width="140">
																		#obj_translater.get_translate('table_th_translation')# :
																	</td>
																	<td>
																		<cfloop list="en,fr,de" index="cor">
																		<cfif cor neq lang_select>
																		<label><input type="radio" name="lang_translate" class="lang_translate" id="lang_#cor#" value="#cor#" <cfif listfind(lang_translate,"#cor#")>checked</cfif>> <span class="lang-sm lang-lbl" lang="#cor#"></span></label> &nbsp;&nbsp;&nbsp;
																		</cfif>
																		</cfloop>
																	</td>
																</tr>
																<tr>
																	<td>
																		#obj_translater.get_translate('btn_el_vocab_list')# :
																	</td>
																	<td>
																		<ul class="nav nav-pills" role="tablist">
																		<cfset counter = 0>
																		<cfloop query="get_category">
																		<li class="nav-item">
																		<cfset counter++>
																		<a class="nav-link <cfif counter eq "1">active</cfif>" data-toggle="pill" href="##collapse_#voc_cat_id#" role="button" aria-expanded="false" aria-controls="collapse_#voc_cat_id#">#voc_cat_name#</a>
																		</cfloop>
																		</li>
																		</ul>
																	</td>
																</tr>
															</table>
															</cfoutput>
														</div>
													</div>
										
													<!---<div class="row mt-3">
														<div class="col-md-12">
														<cfoutput>#obj_translater.get_translate('table_th_language')#</cfoutput> : 
														<label><input type="checkbox" class="lang_select" id="lang_en" value="en" <cfif listfind(list_lang,"en")>checked</cfif>> <span class="lang-sm" lang="en"></span></label> &nbsp;&nbsp;&nbsp;
														<label><input type="checkbox" class="lang_select" id="lang_fr" value="fr" <cfif listfind(list_lang,"fr")>checked</cfif>> <span class="lang-sm" lang="fr"></span></label> &nbsp;&nbsp;&nbsp;
														<label><input type="checkbox" class="lang_select" id="lang_de" value="de" <cfif listfind(list_lang,"de")>checked</cfif>> <span class="lang-sm" lang="de"></span></label> &nbsp;&nbsp;&nbsp;
														</div>
													</div>--->
														
													<div class="row mt-2">
														<div class="col-md-12">
															<div id="accordion_voc">			
															
															<cfset counter = 0>
															<cfloop query="get_category">
															<cfset counter++>
															<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
															
															SELECT v.*,
															vtfr.voc_type_name_fr as voc_type_name_fr,
															vten.voc_type_name_en as voc_type_name_en,
															vtde.voc_type_name_de as voc_type_name_de
															
															FROM lms_vocabulary v
															
															LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
															LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
															LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
															
															WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#"> ORDER BY voc_word_#lang_select#
															</cfquery>
															
															
															<div class="collapse <cfif counter eq "1">show active</cfif>" id="collapse_#voc_cat_id#" data-parent="##accordion_voc">
															<cfoutput><a target="_blank" href="./tpl/vocablist_container.cfm?voc_cat_id=#voc_cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-sm btn-primary float-right"><i class="fad fa-file-pdf btn_export_list" id="export_#voc_cat_id#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
															
															
															<div class="table-responsive">
															<table class="table">
																<tr class="bg-light">
																	<cfoutput>
																	<th width="2%"></th>
																	<th width="16%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select_id#")#</label></th>
																	<th width="10%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select_id#")#</label></th>
																	<th width="20%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select_id#")#</label></th>
																	
																	
																	
																	<cfloop list="en,fr,de" index="cor">
																	<cfif listfind(lang_translate,cor)>
																	<cfif cor eq "en">
																		<cfset lg_translate = "2">
																	<cfelseif cor eq "fr">
																		<cfset lg_translate = "1">
																	<cfelseif cor eq "de">
																		<cfset lg_translate = "3">
																	</cfif>
																	<th width="2%"></th>
																	<th width="16%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate#")#</label></th>
																	<th width="10%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate#")#</label></th>
																	<!--- <th width="20%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th> --->
																	</cfif>
																	</cfloop>
																	</cfoutput>
																	<th width="2%"></th>
																</tr>
																	
															<cfloop query="get_vocabulary">
																<tr>
																
																	<cfif lang_select eq "en">
																		<cfset td_color = "ecd9d9">
																	<cfelseif lang_select eq "fr">
																		<cfset td_color = "c6cbe1">
																	<cfelseif lang_select eq "de">
																		<cfset td_color = "c8d4ca">
																	</cfif>
																	
																	<td bgcolor="###td_color#">
																		<span class="lang-sm" lang="#lang_select#"></span>
																	</td>
																	<td bgcolor="###td_color#">
																		<cfif evaluate('voc_word_#lang_select#') neq ""><strong>#evaluate('voc_word_#lang_select#')#<cfelse><em>Coming soon</em></cfif></strong>
																	</td>
																	<td bgcolor="###td_color#">
																		<cfif evaluate('voc_type_name_#lang_select#') neq "">#evaluate('voc_type_name_#lang_select#')#<cfelse><em>Coming soon</em></cfif>
																	</td>
																	<td bgcolor="###td_color#">
																		<cfif evaluate('voc_desc_#lang_select#') neq "">#evaluate('voc_desc_#lang_select#')#<cfelse><em>Coming soon</em></cfif>
																	</td>
																	
																	
																	<cfloop list="en,fr,de" index="cor">
																	<cfif listfind(lang_translate,cor)>
																	<cfif cor eq "en">
																		<cfset td_color = "ecd9d9">
																	<cfelseif cor eq "fr">
																		<cfset td_color = "c6cbe1">
																	<cfelseif cor eq "de">
																		<cfset td_color = "c8d4ca">
																	</cfif>
																	<td bgcolor="###td_color#">
																		<span class="lang-sm" lang="#cor#"></span>
																	</td>
																	<td bgcolor="###td_color#">
																		<strong>#evaluate('voc_word_#cor#')#</strong>
																	</td>
																	<td bgcolor="###td_color#">
																		#evaluate('voc_type_name_#cor#')#
																	</td>
																	<!--- <td bgcolor="###td_color#"> --->
																		<!--- #evaluate('voc_desc_#cor#')# --->
																	<!--- </td> --->
																	</cfif>
																	</cfloop>
																	
																	<td class="bg-white">
																		<cfsilent>
																			<cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">SELECT * FROM user_vocablist WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#voc_id#></cfquery>
																		</cfsilent>
																		<cfif check_uvoc.recordcount neq 0>
																			<i class="fa-light fa-lg fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
																		<cfelse>
																			<i class="fa-light fa-lg fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
																		</cfif>
																	</td>
																	
																	
																</tr>
																</cfloop>
															</table>
															</div>
															</div>
															</cfloop>
															
															</div>
														</div>
													</div>
												</div>
																					
											</div>
											</cfif>
											
											<cfif sessionmaster_ln_grammar neq "">
											<div class="tab-pane" id="tab_GRAM" role="tabpanel" id="title_GRAM">
											
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														#sessionmaster_ln_grammar#
														</div>
													</div>
												</div>
											
											</div>
											</cfif>
											
											<cfif sessionmaster_ln_vocabulary neq "">
											<div class="tab-pane" id="tab_VOC" role="tabpanel" id="title_VOC">
											
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														#sessionmaster_ln_vocabulary#
														</div>
													</div>
												</div>
																					
											</div>
											</cfif>
											
											<cfif sessionmaster_exercice neq "">
											<div class="tab-pane" id="tab_EX" role="tabpanel" id="title_EX">
											
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														#sessionmaster_exercice#
														</div>
													</div>
												</div>
																					
											</div>
											</cfif>
											
											<cfif sessionmaster_transcript neq "">
											<div class="tab-pane" id="tab_TRANS" role="tabpanel" id="title_TRANS">
											
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														#sessionmaster_transcript#
														</div>
													</div>
												</div>
																					
											</div>
											</cfif>
											
											<cfif get_material.recordcount neq "0">
											<div class="tab-pane" id="tab_DL" role="tabpanel" id="title_DL">
												<br>
												<div class="container">
													<div class="row mt-2">
														<div class="col-md-12">
														<table class="table bg-white">
															<tr class="bg-light">	
																<th>Resource</th>
																<th>Description</th>
																<th>Download</th>
															</tr>
															<cfloop query="get_material">
															<tr>	
															<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.pdf")>
															<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.pdf" target="_blank">#material_name#</a></td>
															<td>#material_description#</td>
															<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.pdf" target="_blank" class="btn btn-info"><i class="fa-light fa-lg fa-file-pdf"></i></a></td>
															<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg")>
															<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg" target="_blank">#material_name#</a></td>
															<td>#material_description#</td>
															<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg" target="_blank" class="btn btn-info"><i class="fa-light fa-lg fa-file-image"></i></a></td>
															</cfif>		
															</tr>	
															</cfloop>
														</table>
														</div>
													</div>
												</div>
																					
											</div>
											</cfif>
																					
											<cfif get_quiz_unit.recordcount neq "0" OR get_quiz_exercice.recordcount neq "0">
											<div class="tab-pane" id="tab_QUIZ" role="tabpanel" id="title_QUIZ">
											
												<div class="container">
													<div class="row mt-4">
														
														<cfif get_quiz_exercice.recordcount neq "0">
														<div class="col-md-6">
															<h6 class="text-info" align="center">#obj_translater.get_translate('table_th_training_exercices')#</h6>
															
															<cfloop query="get_quiz_exercice">
																<cfquery name="get_result_exercice" datasource="#SESSION.BDDSOURCE#">
																SELECT * FROM lms_quiz_user 
																WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
																AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
																</cfquery>
																
																<div class="border-top bg-light mt-3 p-2">
																	<div class="media">
																		<div class="row">
																		<div class="col-md-5">
																		<img src="./assets/img/wefit_lesson.jpg" width="120" class="align-self-center mr-3">
																		</div>
																		<div class="col-md-7">
																		<div class="media-body">
																			<h6 class="mt-1">#quiz_name#</h6>
																			<em><small>#quiz_description#</small></em>
																			<div class="clearfix"></div>
																			<div class="float-right">											
																				<cfif get_result_exercice.recordcount eq "0">																			
																					<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																				<cfelse>
																					<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-red float-right btn_restart_quiz"><i class="fa-light fa-lg fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																					<cfif get_result_exercice.recordcount neq "0" AND get_result_exercice.quiz_user_end neq "">
																						<a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quiz_#get_result_exercice.quiz_user_id#"><i class="fa-light fa-lg fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																					</cfif>																		
																				</cfif>
																			</div>
																		</div>
																		</div>
																		</div>
																	</div>
																</div>
															</cfloop>
														</div>
														</cfif>
														
														<cfif get_quiz_unit.recordcount neq "0">
														<div class="col-md-6">
															
															<h6 class="text-info" align="center">#obj_translater.get_translate('table_th_validation_quiz')#</h6>
															
															<cfloop query="get_quiz_unit">
																<cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
																SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
																</cfquery>
																	
																<div class="border-top bg-light mt-3 p-2">
																	<div class="media">
																		<div class="row">
																		<div class="col-md-5">
																		<img src="./assets/img/wefit_lesson.jpg" width="120" class="align-self-center mr-3">
																		</div>
																		<div class="col-md-7">
																		<div class="media-body">
																			<h6 class="mt-1">#quiz_name#</h6>
																			<em><small>#quiz_description#</small></em>
																			<div class="clearfix"></div>
																			<div class="float-right">
																				<cfif get_result_unit.recordcount eq "0">
																					<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																				<cfelse>
																					<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-red float-right btn_restart_quiz"><i class="fa-light fa-lg fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																					<cfif get_result_unit.recordcount neq "0" AND get_result_unit.quiz_user_end neq "">
																						<a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quiz_#get_result_unit.quiz_user_id#"><i class="fa-light fa-lg fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																					</cfif>
																				</cfif>
																			</div>
																		</div>
																		</div>
																		</div>
																	</div>
																</div>
															</cfloop>
															
														</div>
														</cfif>
													</div>
												</div>
											</div>
											</cfif>
											
										</div>
										
										
									</div>
								</div>
							</cfif>
							
							</cfoutput>
							
						</div>
						
					</div>
					
				</div>	

				<div class="col-md-4">
					
					<div class="card border-top border-red">
					
						<div class="card-body">
													
							<div class="row">
								<div class="col-md-12">
									<h6 class="text-red"><cfoutput>#obj_translater.get_translate('card_activity')#</cfoutput></h6>
										
										<cfoutput query="get_session_description">
										<br>
										<table class="table bg-white table-bordered m-0">
											<tr>
												<td width="40%"><i class="fa-light fa-lg fa-clock"></i> <small>#obj_translater.get_translate('table_th_elapsed_time_course')#</small></td>
												<td>
													<cfif sm_elapsed neq "">#obj_lms.get_format_hms(toformat="#sm_elapsed#")#<cfelse>-</cfif>
												</td>
											</tr>
											<tr>
												<td width="40%"><i class="fa-light fa-lg fa-user-clock"></i> <small>#obj_translater.get_translate('table_th_last_connect_course')#</small></td>
												<td>
													<cfif sm_lastview neq "">
														<cfif SESSION.LANG_CODE eq "de">
															#dateformat(sm_lastview,'dd.mm.yyyy')#
														<cfelse>
															#dateformat(sm_lastview,'dd/mm/yyyy')#
														</cfif>
													<cfelse>-</cfif>
												</td>
											</tr>
											
											<tr>
												<td width="40%"><i class="fa-light fa-lg fa-history"></i> <small>#obj_translater.get_translate('table_th_total_lms')#</small></td>
											
												<td>
													<cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
													#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#
													<cfelse>
													-
													</cfif>
												</td>
											</tr>
										</table>
										</cfoutput>
										
									<!---<button class="btn btn-sm btn-info pull-right m-0 p-1" type="button" data-toggle="collapse" data-target="#col_el" aria-expanded="false" aria-controls="col_el">+</button>
									<div class="clearfix mt-2"></div>--->
									
								</div>
							</div>
						</div>
					</div>
							
							<!----<div class="collapse" id="col_el">
							<cfoutput query="get_session_access" group="module_id">
							
								<div class="mt-3 border-bottom w-100">
									
									
									<div class="container">
									
										<cfoutput>
										<div class="row p-1">
											<div class="col-md-3" align="center">
											#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#
											</div>
											<cfif sessionmaster_id neq "694" AND sessionmaster_id neq "695" AND sessionmaster_id neq "696" AND sessionmaster_id neq "697" AND sessionmaster_id neq "769">
											<div class="col-md-9">
												<a href="learner_practice.cfm?sm_id=#sessionmaster_id#">#sessionmaster_name#</a>
												<br>
												<small><strong><cfif module_name neq "">[#module_name#]<cfelse>[Diverse]</cfif></strong></small>
											</div>
											<cfelse>
											<div class="col-md-9">
												#sessionmaster_name#
											</div>
											</cfif>
										</div>
										</cfoutput>
									
									</div>
									
								</div>
							</cfoutput>	---->		
	
					
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_AUDIO1.mp3")>
					<div class="card border-top border-danger">
					
						<div class="card-body">
						
							<div class="row">
								<div class="col-md-12">
									<h6 class="text-danger"><cfoutput>#obj_translater.get_translate('modal_support_audio')#</cfoutput></h6>
									
									<div align="center">
										<cfoutput>
										<cfloop from="1" to="5" index="cor">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_AUDIO#cor#.mp3")>
										<div class="m-2">
										<audio controls="controls">
										  <source src="./assets/materials/#get_session_description.sessionmaster_ressource#_AUDIO#cor#.mp3" type="audio/mp3" />
										  Votre navigateur n'est pas compatible
										</audio>
										</div>
										</cfif>
										</cfloop>
										</cfoutput>
									</div>
								</div>
								
							</div>
							
						</div>
						
					</div>
					</cfif>
					
					
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO1.mp4")>
					<div class="card border-top border-warning">
					
						<div class="card-body">
						
							<div class="row">
								<div class="col-md-12">
									<h6 class="text-warning"><cfoutput>#obj_translater.get_translate('modal_support_video')#</cfoutput></h6>
									<div align="center">
								
										<cfoutput>
										<cfloop from="1" to="5" index="cor">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO#cor#.mp4")>
										<!--- <a class="btn btn-warning" target="_blank" href="#SESSION.BO_ROOT_URL#/assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO#cor#.mp4"><i class="fa-light fa-lg fa-play-circle"></i> VIDEO #cor#</a> --->

										<video width="100%" height="200" controls poster="
										<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_session_description.sessionmaster_code#.jpg")>			
										./assets/img_material/#get_session_description.sessionmaster_code#.jpg
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_session_description.sessionmaster_id#.jpg")>			
										./assets/img_material/#sm_id#.jpg
										<cfelse>
										./assets/img/wefit_lesson.jpg
										</cfif>">
										<source src="./assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO#cor#.mp4" type="video/mp4">
										Your browser does not support the video tag or the file format of this video.
										</video>
										</cfif>
										</cfloop>
										</cfoutput>
									</div>
								</div>
							</div>
							
						</div>
						
					</div>
					</cfif>
					
				</div>				

			</div>
			
		</div>
	
	</div>
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">


<script>
$(document).ready(function() {

	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	
		<cfoutput>
		if(confirm("#obj_translater.get_translate('js_restart_quiz_confirm')#")){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		</cfoutput>
	})
	
	<cfoutput>
	$('.btn_view_quiz').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("Exercice");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})
	</cfoutput>
	
	$('.lang_translate').click(function(event) {	

		var lang_translate = [];
		if($('#lang_en').is(":checked")){lang_translate.push("en")}
		if($('#lang_fr').is(":checked")){lang_translate.push("fr")}
		if($('#lang_de').is(":checked")){lang_translate.push("de")}

		<cfoutput>
		document.location.href="learner_practice.cfm?sm_id=#sm_id#&lang_translate="+lang_translate+"&tab_VOCLIST=1";
		</cfoutput>
		
	});
	

	
	$( ".btn_add_uvoc" ).click(function() {

		var id_temp = $(this).attr("id");
		
			<!-- $('#'+id_temp).append("<div class='spinner-border' role='status'></div>"); -->
			
			var idtemp = id_temp.split("_");
			var uid = idtemp[0];
			var vid = idtemp[1];
			
			var c = $(this).attr("class");
			
			
			$.ajax({
				url : './components/vocabulary_perso.cfc?method=add_user_voc',
				type : 'POST',
				data : {act:"add_user_voc", uid:uid, vid:vid},
				red : function(resultat, status) {
				}
			});
			$(this).attr('class', 'fa-light fa-lg fa-heart-square fa-2x btn_add_uvoc cursored');
			
			
			if ( c != "fa-light fa-lg fa-heart-square fa-2x btn_add_uvoc cursored") {
			$.ajax({
				url : './components/vocabulary_perso.cfc?method=rm_user_voc',
				type : 'POST',
				data : {act:"rm_user_voc", uid:uid, vid:vid},
				red : function(resultat, status) {
				}
			});
			$(this).attr('class', 'fa-light fa-lg fa-heart-square fa-2x btn_add_uvoc cursored');
			}
		
	});
	
	
	
	
})
</script>

</body>
</html>