<!DOCTYPE html>

<cfsilent>

	<cfset secure = "3,7,9,5,8">
	<cfinclude template="./incl/incl_secure.cfm">

	<!--- DEFAULT VAR ---->
	<cfset step = "2">

	<cfset t_id = "4203">
	<cfset u_id = "411">
	<cfset kwish_id = "1,6,4,9,12,16,18,19">
	<cfparam name="session_length" default="60">
	<cfset f_id = "2">
	<cfset lev_id = "A">

	<cfset get_session = obj_tp_get.oget_session(t_id=#t_id#,user_id=#u_id#)>
	<cfset array_session_tp = obj_core.QueryToArray(get_session)>
	<cfset get_tp = obj_tp_get.oget_tp(t_id=#t_id#,user_id=#u_id#)>
	
	
	<cfset tp_duration_min = get_tp.tp_duration>
	<cfset tp_booked_min = get_tp.session_duration>
	<cfset tp_duration_h = tp_duration_min/60>
	<cfset tp_booked_h = tp_booked_min/60>
	<cfset progress_completed = round((tp_booked_min/tp_duration_min)*100)>


	<!--- GET LIST OF TP CATEGORIES FOR DISPLAY ---->
	<cfquery name="get_tpmaster" datasource="#SESSION.BDDSOURCE#">
		SELECT tpmaster_id, tpmaster_name_#SESSION.LANG_CODE# as tpmaster_name FROM lms_tpmaster2 
		WHERE tpmaster_level like '%#lev_id#%' AND tpmaster_prebuilt = 0 AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> 
		ORDER BY tpmaster_rank
	</cfquery>

	<cfloop query="get_tpmaster">
		<cfquery name="get_session_access_#tpmaster_id#" datasource="#SESSION.BDDSOURCE#">
			SELECT tc.*, tp.*,
			sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.module_id, sm.keyword_id,

			(CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sm.sessionmaster_name END) AS sessionmaster_name, 
			(CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sm.sessionmaster_description END) AS sessionmaster_description, 

			(CASE WHEN tm.module_name_#SESSION.LANG_CODE# <> "" THEN tm.module_name_#SESSION.LANG_CODE# ELSE tm.module_name END) AS module_name, 
			(CASE WHEN tm.module_description_#SESSION.LANG_CODE# <> "" THEN tm.module_description_#SESSION.LANG_CODE# ELSE tm.module_description END) AS module_description, 
			COUNT(q.quiz_id) as quiz_id,
			(SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm2 WHERE sm2.module_id = tm.module_id) as nb
			FROM lms_tpmaster2 tp
			INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
			INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
			LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
			LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
			WHERE sm.sessionmaster_online_visio = 1
			AND tp.tpmaster_id = #get_tpmaster.tpmaster_id#
			<!---
				<cfif lev_id eq "fav">
					<cfif isdefined("SESSION.USER_SHORTLIST") AND SESSION.USER_SHORTLIST neq "">
						AND sm.sessionmaster_id IN (#SESSION.USER_SHORTLIST#)
					<cfelse>
						AND 1 = 2
					</cfif>
				<cfelseif lev_id eq "el">
					<cfif isdefined("SESSION.USER_EL_LIST") AND SESSION.USER_EL_LIST neq "">
						AND sm.sessionmaster_id IN (#SESSION.USER_EL_LIST#)
					<cfelse>
						AND 1 = 2
					</cfif>
				<cfelse>
					AND tp.tpmaster_level like '%#lev_id#%'		
				</cfif>


				<cfif isdefined("kwish_id") AND listlen("kwish_id") gt 0>
					AND (1 = 2
					<cfloop list="#kwish_id#" index="cor">
						OR FIND_IN_SET(#cor#,sm.keyword_id)
					</cfloop>
					)
				</cfif>
			--->


			GROUP BY sm.sessionmaster_id
			ORDER BY tp.tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
		</cfquery>
	</cfloop>





	<cfset __text_about = obj_translater.get_translate('text_about')>
	<cfset __lesson = obj_translater.get_translate('lesson')>

	<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
	<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
	<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
	<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
	<cfset __tooltip_add_favourite = obj_translater.get_translate('tooltip_add_favourite')>
	<cfset __tooltip_remove_favourite = obj_translater.get_translate('tooltip_remove_favourite')>

	<cfset __card_keywords = obj_translater.get_translate('card_keywords')>
	<cfset __card_grammar = obj_translater.get_translate('card_grammar')>
	<cfset __btn_details = "Details">





</cfsilent>
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
		.btn-outline-info {
			text-transform:none !important; 
			border: 1px solid #51bcda !important;
		}
		.btn-outline-danger {
			text-transform:none !important; 
			border: 1px solid #ef8157 !important;
		}		


		.card_module img {

			-webkit-filter: grayscale(90%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(90%); /* Firefox */

		}
		.card_module img:hover {

			-webkit-filter: grayscale(0%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(0%); /* Firefox */
		}
		.card_module:hover {
			border-color:#FFA100
		}
		.card_module {
			border:1px solid #ECECEC
		}

	</style>

</head>


<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
			<cfset help_page = "help_lstep2">

			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">

				<cfinclude template="./incl/incl_nav_learner.cfm">

				<div id="container_choice" class="collapse show mt-3">

					<div class="card mb-2">

						<button class="btn btn-link text-left" data-toggle="collapse" data-target="#collapse_choice" aria-expanded="true" aria-controls="collapse_choice">
							<div class="card-header">Je choisis : <span class="choice_text text-info">UN PARCOURS SUR MESURE</span>
								<span class="text_choice float-right font-weight-normal"><i class="fal fa-chevron-square-down"></i> changer</span>
							</div>
						</button>


						<div id="collapse_choice" class="collapse">
							<div class="card-body pt-0">
								<div class="row">
									<div class="col-sm-12 col-md-4">
										<a href="#" class="btn btn-outline-info choice_prefilled btn-block border p-3 font-weight-normal" <cfif not isdefined("tp_prefilled_compliant")>disabled</cfif>>			
											<h5 class="d-inline"><i class="fal fa-books fa-lg" id="icon_solo"></i> un parcours pré-construit</h5>
										</a>
									</div>
									<div class="col-sm-12 col-md-4">
										<a href="#" class="btn btn-outline-info choice_solo btn-block border p-3 font-weight-normal">		
											<h5 class="d-inline"><i class="fal fa-pencil-ruler fa-lg" id="icon_solo"></i> un parcours sur-mesure</h5>
										</a>
									</div>
									<div class="col-sm-12 col-md-4">
										<a href="#" class="btn btn-outline-info choice_trainer btn-block border p-3 font-weight-normal">						
											<h5 class="d-inline"><i class="fal fa-hands-helping fa-lg" id="icon_solo"></i> un parcours collaboratif</h5>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div class="row mt-4">
					<div class="col-md-7">
						<div class="card">
							<div class="card-body">
								<div align="center">
									<h5 class="d-inline"><i class="fal fa-books"></i> Bibliothèque</h5><br>
								</div>



								<!--- <button id="choice_solo_0" class="btn btn-outline-info font-weight-normal" style="text-transform:none !important" value="Free lessons">					
									<h5 class="d-inline" style="font-size:16px">Free lessons</h5><br>
								</button>
								<cfoutput query="get_tpmaster">
									<button id="choice_solo_#tpmaster_id#" class="btn btn-outline-info font-weight-normal" style="text-transform:none !important" value="#tpmaster_name#">					
										<h5 class="d-inline" style="font-size:16px">#tpmaster_name#</h5><br>
									</button>
								</cfoutput> --->
								<cfdirectory action="list" directory="#SESSION.BO_ROOT#/assets/img_module" recurse="false" name="myList" type="file">
								<!--- <cfdump var="#listgetat(myList,randrange(1,15))#"> --->
								<cfset listgo = "">
								<cfloop query="myList">
									<cfset listgo = listAppend(listgo, mid(name,1,findNoCase(".",name)-1))>
								</cfloop>



								<div class="card-deck mt-3">

									<div class="card card_module" id="choice_solo_0" style="cursor:pointer;">
										<img src="../assets/img/wefit_lesson_square.jpg">
										<h6 class="text-center mt-2">Open / Workshop</h6>
									</div>

									<cfoutput query="get_tpmaster">

										<div class="card card_module" id="choice_solo_#tpmaster_id#" style="cursor:pointer;">
											<img src="../assets/img_module/#listgetat(listgo,randrange(1,30))#.jpg">
											<h6 class="text-center mt-2">#tpmaster_name#</h6>
										</div>
									</cfoutput>


								</div>

								<div id="container_solo_0" class="collapse mt-3">
									<cfoutput>
										<cfloop list="696,697" index="cor">

											<cfset get_session_description = obj_query.oget_session_description(sm_id="#cor#")>
											<div class="row">
												<div class="col-md-12">
													<div class="card border mb-3 bg-white">
														<div class="card-body">

															<div class="p-3 <!---<cfif session_status eq 1>bg-info-select<cfelse>bg-white</cfif>--->" id="containersssm_#cor#">
																<div class="row">
																	<div class="col-1">
																		<img src="./assets/img/wefit_lesson.jpg" width="100" class="mr-3">
																	</div>
																	<div class="col-2">
																		<i class="fal fa-book fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
																		<i class="fal fa-volume-up fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
																		<i class="fal fa-film fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
																		<i class="fal fa-tasks fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#" style="color:##ECECEC"></i>
																	</div>
																	<div class="col-7">
																		<strong>#get_session_description.sessionmaster_name#</strong>
																		<br>
																		<small>#get_session_description.sessionmaster_description#</small>
																	</div>


																	<div class="col-2">
																		<div id="container_book_#cor#">

																			<!---------- DETERMINE SESSION STATUS ------------------>
																			<cfset session_status = 0>																
																			<cfloop from="1" to="#arrayLen(array_session_tp)#" index="counter">
																				<cfif array_session_tp[counter].sessionmaster_id IS cor>
																					<cfset session_status = 1>
																					<cfset session_index = counter>


																					<div id="containers_#array_session_tp[session_index].session_id#" class="border p-2 bg-white">
																						<h5 class="d-inline">
																							<span class="badge border font-weight-normal display_text_action d-block">
																								<span class="badge badge-pill badge-danger" id="sr_#array_session_tp[session_index].session_id#">
																									<small>Cours</small>
																									#array_session_tp[session_index].session_rank#
																								</span>
																								<small><strong>#array_session_tp[session_index].session_duration#min</strong></small>
																							</span>
																						</h5>

																						<button class="btn btn-sm btn-outline-danger btn-block font-weight-normal selector btn_del_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btns_#cor#_#array_session_tp[session_index].session_id#">
																							Retirer
																						</button>
																					</div>

																				</cfif>
																			</cfloop>



																			<div id="containersm_#cor#" class="border p-2 bg-white">
																				<select class="form-control form-control-sm session_length_solo" id="len_#cor#">
																					<cfloop list="15,30,45,60,75,90" index="cor2">
																						<option <cfif session_length eq cor2>selected</cfif> value="#cor2#">#cor2#min</option>
																					</cfloop>
																				</select>

																				<button class="btn btn-sm btn-outline-info btn-block font-weight-normal selector btn_add_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btnsm_#cor#">Ajouter</button>

																			</div>
																		</div>
																	</div>

																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</cfloop>
									</cfoutput>
								</div>
								<cfloop query="get_tpmaster">



									<cfoutput><div id="container_solo_#tpmaster_id#" class="collapse"></cfoutput>

										<div align="center" class="mb-2">
											<div class="btn-group-toggle" data-toggle="buttons">
												<label class="btn btn-sm btn-outline-info font-weight-normal collapse_all">
													<input type="checkbox" autocomplete="off" value="1"> <i class="fal fa-chevron-square-down"></i> Tout déplier
												</label>
											</div>
										</div>

										<div class="row">

											<div class="col-md-12">

												<cfset css = "success">

												<cfoutput><div id="accordion_#tpmaster_id#"></cfoutput>

													<cfoutput query="get_session_access_#tpmaster_id#" group="tpmaster_id">

														<cfoutput group="module_id">												
															<div class="card border mb-3 bg-white">
																<div class="card-body">
																	<div class="row">
																		<!--- <div class="d-flex justify-content-between"> --->
																			<div class="col-10">
																				<div class="media">

																					<cfif fileexists("#SESSION.BO_ROOT#/assets/img_module/#module_id#.jpg") AND tpmaster_is_modular eq "1">
																						<img src="./assets/img_module/#module_id#.jpg" width="80" class="mr-3">
																					</cfif>
																					<cfset module_name_format = replacenocase(module_name,"A1/A2 - ","","ALL")>
																					<cfset module_name_format = replacenocase(module_name_format,"A2 - ","","ALL")>
																					<cfset module_name_format = replacenocase(module_name_format,"B1/B2 - ","","ALL")>
																					<cfset module_name_format = replacenocase(module_name_format,"C1/C2 - ","","ALL")>
																					<cfset module_name_format = replacenocase(module_name_format,"B1 - ","","ALL")>
																					<!--- #module_id# --->
																					<div class="media-body">
																						<span class="d-inline"><a class="badge badge-pill bg-white border p-2 badge-light font-weight-light">Langue : <span class="lang-xs" lang="en" style="top:0px !important"></span></a></span>
																						<span class="d-inline"><a class="badge badge-pill bg-white border p-2 badge-light font-weight-light">Niveau : <strong><span class="badge badge-pill badge-success">#tpmaster_level#</span></strong></a></span>
																						<h6 class="mt-0 d-inline">#module_name_format#</h6>
																						<p class="text-muted mt-2">#module_description#</p>
																					</div>
																				</div>
																			</div>
																			<div class="col-2">
																				<span class="d-inline">
																					<a class="btn btn-sm btn-block btn-outline-info font-weight-normal" data-toggle="collapse" href="##m_#module_id#" role="button" aria-expanded="false" aria-controls="m_#module_id#">Module :<br><strong>#nb# cours</strong>
																					</a>
																				</span>
																			</div>


																		</div>

																		<div class="row collapse_module collapse mt-3" id="m_#module_id#" data-parent="##accordion_#tpmaster_id#">
																			<cfoutput>


																				<div class="border-top p-3" id="containersssm_#sessionmaster_id#">
																					<div class="row">
																						<div class="col-1">
																							#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="100")#
																						</div>
																						<div class="col-2">
																							<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
																								<i class="fal fa-book fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
																							<cfelse>
																								<i class="fal fa-book fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
																							</cfif>

																							<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
																								<i class="fal fa-volume-up fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
																							<cfelse>
																								<i class="fal fa-volume-up fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
																							</cfif>

																							<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
																								<i class="fal fa-film fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
																							<cfelse>
																								<i class="fal fa-film fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
																							</cfif>

																							<cfif quiz_id neq "" AND quiz_id neq "0">
																								<i class="fal fa-tasks fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
																							<cfelse>
																								<i class="fal fa-tasks fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#" style="color:##ECECEC"></i>
																							</cfif>
																						</div>
																						<div class="col-7">
																							<strong>#sessionmaster_name#</strong>
																							<br>
																							<small>#sessionmaster_description#</small>
																							<!--- <small>#mid(sessionmaster_description,1,120)# [...]</small> --->
																							<span class="btn_view_session" id="sm_#sessionmaster_id#">
																								<!---<small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small>--->
																							</span>
																							<cfif keyword_id neq "">
																								<br>
																								<small>#__card_keywords# :</small>
																								<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
																									SELECT keyword_id as k_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
																								</cfquery>
																								<cfloop query="get_keyword"><span class="badge badge-pill <cfif listfind(kwish_id,k_id)>badge-#css#<cfelse>border</cfif>">#keyword_name#</span> </cfloop>
																								</cfif>
																							</div>


																							<div class="col-2">


																								<div id="containersm_#sessionmaster_id#" class="border p-2 bg-white">
																									<select class="form-control form-control-sm session_length_solo" id="len_#sessionmaster_id#">
																										<cfloop list="15,30,45,60,75,90" index="cor">
																											<option <cfif session_length eq cor>selected</cfif> value="#cor#">#cor#min</option>
																										</cfloop>
																									</select>
																									<button class="btn btn-sm btn-outline-info btn-block font-weight-normal selector btn_add_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btnsm_#sessionmaster_id#">
																										Ajouter
																									</button>
																								</div>

																							</div>

																						</div>
																					</div>
																				</cfoutput>		
																			</div>			
																		</div>	
																	</div>	
																</cfoutput>	

															</cfoutput>
														</div>	
													</div>
												</div>	

											</div>	
										</cfloop>


									</div>
								</div></div>
								<div class="col-md-5">
									<div class="card border border-success">
										<div class="card-body">
											<div align="center">
												<h5 class="d-inline"><i class="fal fa-road" aria-hidden="true"></i> Mon parcours</h5><br>
											</div>

											<div class="row">
												<div class="col-lg-3">
													<span class="btn btn-link text-info">
														<cfoutput query="get_tp">
															#obj_lms.get_tp_text(tp_id="#t_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
														</cfoutput>
													</span>
												</div>
												<div class="col-lg-9">
													<cfoutput>
														<div class="row">
															<div class="col-lg-8">
																<div class="progress mt-2" style="height:25px">
																	<div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated display_tp_progress" role="progressbar" aria-valuenow="#progress_completed#" aria-valuemin="0" aria-valuemax="100" style="width: #progress_completed#%">#tp_booked_h#h planifiée(s) / #tp_duration_h#h</div>
																</div>
															</div>
															<div class="col-lg-4">
																<a href="##" class="btn btn-success btn_validate_tp" id="tp_#t_id#"><i class="fal fa-check"></i> Valider</a>
															</div>
														</div>
													</cfoutput>		
												</div>
											</div>

											<cfform action="updater_tp2.cfm" method="post" id="tp_build">

												<!---
													<div class="row">
														<div class="col-md-12">
															<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_program')#</cfoutput></h6>
															<cfoutput>
																<cfif SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES" OR SESSION.USER_PROFILE eq "FINANCE" OR SESSION.USER_PROFILE eq "TRAINER">
																	<div class="float-right"><a href="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-calendar-alt"></i> BOOK</a></div>
																</cfif>
																<cfif SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES" OR SESSION.USER_PROFILE eq "FINANCE">
																	<div class="float-right"><a href="common_learner_account.cfm?u_id=#u_id#&tab=3" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-edit"></i> EDIT</a></div>
																</cfif>
															</cfoutput>

															<br><br>

															<div class="input-group">
																<input type="text" class="form-control" disabled value="<cfoutput>#obj_lms.get_formath(tp_session_duration)#</cfoutput>" id="tp_duration" style="text-align:right; background-color:##FFFFFF; min-width:80px">
																<div class="input-group-append">
																	<cfif obj_lms.get_formath(tp_session_duration) eq obj_lms.get_formath(get_tp.tp_duration)>
																		<div id="pindic" class="input-group-text bg-success text-white">&nbsp;&nbsp;<strong>/ <cfoutput>#obj_lms.get_formath(get_tp.tp_duration)#</cfoutput> h</strong></div>
																	<cfelse>
																		<div id="pindic" class="input-group-text bg-warning text-white">&nbsp;&nbsp;<strong>/ <cfoutput>#obj_lms.get_formath(get_tp.tp_duration)#</cfoutput> h</strong></div>
																	</cfif>												
																</div>
															</div>	
															<div class="progress" style="margin:0px; width:100%">	
																<cfif tp_session_duration neq "0">
																	<cfset pource = round(tp_session_duration/get_tp.tp_duration*100)>
																<cfelse>
																	<cfset pource = 0>
																</cfif>
																<cfif obj_lms.get_formath(tp_session_duration) eq obj_lms.get_formath(get_tp.tp_duration)>
																	<div id="pbar" class="progress-bar progress-bar-striped bg-success progress-bar-animated" style="width:<cfoutput>#pource#</cfoutput>%">
																	<cfelse>
																		<div id="pbar" class="progress-bar progress-bar-striped bg-warning progress-bar-animated" style="width:<cfoutput>#pource#</cfoutput>%">
																		</cfif>		
																	</div>
																</div>	

																<div class="float-right">
																	<input type="submit" class="btn btn-outline-success btn-sm btn_saver" value="Sauvegarder">											
																</div>

															</div>
														</div>
													--->
													<div class="row">
														<div class="col-md-12">		

															<div id="div_content">
																<table id="table_tp" class="table table-sm mt-3" width="100%">
																	<thead>
																		<tr bgcolor="#F3F3F3">
																			<th width="1%"></th>
																			<th width="3%"><label>N&deg;</label></th>
																			<!--- <th width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_course_type')#</cfoutput></label></th> --->
																			<th width="10%"><label><cfoutput>#obj_translater.get_translate('table_th_duration_short')#</cfoutput></label></th>
																			<th><label><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></label></th>
																			<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
																			<th width="12%"></th>
																		</tr>
																	</thead>
																	<tbody id="tbody_sortable">
																		<cfif get_session.recordcount neq "0">

																			<cfoutput query="get_session" group="session_id">

																				<!--- IF LESSON BOOKED, UNSORTABLE--->
																				<cfif lesson_id neq "">
																					<tr class="unsortable bg-light" id="tr_#session_rank#">
																						<td></td>
																						<!--- IF NA, UNSORTABLE--->
																					<cfelseif sessionmaster_id eq "695">
																						<tr class="unsortable bg-light" id="tr_#session_rank#">
																							<td></td>
																							<!--- IF PTA, UNSORTABLE--->
																						<cfelseif sessionmaster_id eq "694">
																							<tr class="unsortable bg-light last_tr" id="tr_#session_rank#">
																								<td></td>
																							<cfelse>
																								<tr id="tr_#session_rank#">
																									<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>
																								</cfif>
																								<td>	
																									<h5 class="d-inline"><span class="badge badge-pill badge-secondary">#session_rank#</span></h5>
																								</td>
																								<!---<td>
																									<small>#cat_name#</small>
																								</td>
																							--->
																							<td>
																								<small>#session_duration# min</small>
																							</td>
																							<td>									
																								#sessionmaster_name#
																							</td>
																							<td>
																								<cfif lesson_id neq "">
																									<cfoutput group="lesson_id">
																										<span class="badge badge-#status_css# btn_view_lesson" id="l_#lesson_id#" style="cursor:pointer">#status_name#</span>															
																									</cfoutput>
																								</cfif>
																							</td>
																							<td>
																								<cfif cat_id eq "4">

																									<cfif lesson_id eq "" AND (SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES")>
																										<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>
																									<cfelse>
																										<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm disabled"><i class="far fa-trash-alt"></i></a>
																									</cfif>
																								<cfelse>												
																									<cfif lesson_id neq "">
																										<div class="btn-group" role="group">
																											<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm disabled"><i class="far fa-trash-alt"></i></a>

																											<!---- DISPLAY SWITCH BUTTON IF THERE IS A SCHEDULED ONE ON THE LIST ---->
																											<cfif SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES" OR SESSION.USER_PROFILE eq "FINANCE" OR SESSION.USER_PROFILE eq "TRAINER">
																												<cfoutput group="lesson_id">
																													<cfif status_id eq "1">
																														<a class="btn btn-warning btn-sm btn_switch ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#"><i class="fas fa-random"></i></a>
																													</cfif>
																												</cfoutput>
																											</cfif>
																										</div>

																									<cfelse>
																										<div class="btn-group" role="group">
																											<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>

																											<cfif SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES" OR SESSION.USER_PROFILE eq "FINANCE" OR SESSION.USER_PROFILE eq "TRAINER">
																												<a class="btn btn-warning btn-sm btn_switch ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#"><i class="fas fa-random"></i></a>
																											</cfif>
																										</div>
																									</cfif>		

																								</cfif> 

																								<input type="hidden" class="session_final_rank" name="S_#session_id#" value="#session_rank#_#sessionmaster_id#_#session_duration#_#cat_id#_#session_rank#">
																							</td>
																						</tr>

																						<cfif currentrow eq recordcount AND sessionmaster_id neq "694">
																							<tr class="unsortable bg-light last_tr"></tr>
																						</cfif>

																					</cfoutput>
																				<cfelse>
																					<tr class="unsortable bg-light last_tr" id="tr_0"></tr>
																				</cfif>


																			</tbody>
																		</table>
																	</div>
																	<cfoutput>
																		<input type="hidden" name="t_id" value="#t_id#">
																		<input type="hidden" name="u_id" value="#u_id#">
																	</cfoutput>
																	<input type="hidden" name="updt_tp" value="1">
																</cfform>
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


						<script>
							$(document).ready(function() {


								$('#tbody_sortable').sortable({
									items: "tr:not(.unsortable)",
									update: function(e, ui) {
										$("tr td:nth-child(2)").empty();
										reorder();			
									}
								});
								$("#tbody_sortable").disableSelection();

								function reorder()
								{
									$("#table_tp tr td:nth-child(2)").empty();
									$("#table_tp tr td:nth-child(2)").html(function() {
										return '<h5 class="d-inline"><span class="badge badge-pill badge-secondary">'+$(this).parent().index("#table_tp tr")+'</span></h5>';
									});

									$("#table_tp tr td:nth-child(2)").each(function( index ) {
										var valtemp = $(this).parent().find(".session_final_rank").val();
										/*alert(valtemp);*/
										var valtemp = valtemp.split("_");
										var idgo = valtemp[0];		
										var durtemp = valtemp[1];
										var sessiomaster_id = valtemp[2];	
										var session_cat = valtemp[3];
										var session_rank = $(this).parent().index("#table_tp tr");

										$(this).parent().find(".session_final_rank").val(idgo+"_"+durtemp+"_"+sessiomaster_id+"_"+session_cat+"_"+session_rank)

										/*console.log($(this).parent().find(".session_final_rank").val());*/
									});	
								}		
								$('#choice_solo_0').click(function(event) {		

									$(".category_text").html("<span class='text-info'>"+$(this).val()+"</span>");

									<!--- $("##collapse_category").collapse("hide");		 --->
									$('#container_solo').collapse("show");

									<cfloop query="get_tpmaster">
										<cfoutput>
											$('##container_solo_#tpmaster_id#').hide();
											$('##choice_solo_#tpmaster_id#').removeClass("active");
										</cfoutput>
									</cfloop>

									$('#container_solo_0').show();
									$(this).addClass("active");


								});
								<cfoutput query="get_tpmaster">
									$('##choice_solo_#tpmaster_id#').click(function(event) {		

										$(".category_text").html("<span class='text-info'>"+$(this).val()+"</span>");

										<!--- $("##collapse_category").collapse("hide");		 --->
										$('##container_solo').collapse("show");

										$('##container_solo_0').hide();
										$('##choice_solo_0').removeClass("active");
										<cfloop query="get_tpmaster">
											$('##container_solo_#tpmaster_id#').hide();
											$('##choice_solo_#tpmaster_id#').removeClass("active");
										</cfloop>

										$('##container_solo_#tpmaster_id#').show();
										$(this).addClass("active");


									});
								</cfoutput>	

								$('.collapse_all').click(function(event) {	
									event.preventDefault();
									if($(this).find("input").prop("checked"))
									{
										$('.collapse_module').collapse("hide");
									}
									else
									{
										$('.collapse_module').collapse("show");
									}

								})
							});
						</script>
					</body>
					</html>