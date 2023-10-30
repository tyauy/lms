<!DOCTYPE html>

<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
		
	<cfset tp_choice = "solo">

	<cfset step = "2">
	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>	
	<cfset a_id = SESSION.ACCOUNT_ID>
	<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>	
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>	
	<cfset tp_master_hour = get_tp.tp_duration/60>		
	<cfset tp_orientation_select = get_tp.tp_orientation_id>
	<cfset tp_interest_select = get_tp.tp_interest_id>
	<cfset tp_function_select = get_tp.tp_function_id>	

	<cfset session_length = get_tp.tp_session_duration>

	<!---- GET KEYWORDS FOR DISPLAY ---->
	<cfif tp_interest_select neq "">
		<cfquery name="get_tp_interest_wish" datasource="#SESSION.BDDSOURCE#">
			SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#tp_interest_select#)
		</cfquery>
	</cfif>
	
	<cfif tp_function_select neq "">
		<cfquery name="get_tp_function_wish" datasource="#SESSION.BDDSOURCE#">
			SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#tp_function_select#)
		</cfquery>
	</cfif>
		
	<cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level = evaluate("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level_letter = mid(u_level,1,1)>
	<cfelse>
		<cfset u_level = "N/A">
		<cfset u_level_letter = "N/A">
	</cfif>
	
	<cfif u_level_letter eq "A">
		<cfset level_css = "success">
	<cfelseif u_level_letter eq "B">
		<cfset level_css = "info">
	<cfelseif u_level_letter eq "C">
		<cfset level_css = "danger">
	<cfelse>
		<cfset level_css = "info">
	</cfif>
	
	<cfquery name="get_tporientation" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_orientation_id, tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc, tp_orientation_src FROM lms_tporientation
	</cfquery>
	
	<!---- OBJ QUERIES ---->
	<cfset get_session = obj_tp_get.oget_session(t_id=#t_id#,u_id=#u_id#)>
	<cfset array_session_tp = obj_core.QueryToArray(get_session)>

	<cfset tp_duration_min = get_tp.tp_duration>
	<cfset tp_booked_min = get_tp.session_duration>
	<cfset tp_duration_h = tp_duration_min/60>
	<cfif tp_booked_min neq "">
		<cfset tp_booked_h = tp_booked_min/60>
		<cfset progress_completed = round((tp_booked_min/tp_duration_min)*100)>
	<cfelse>
		<cfset tp_booked_min = 0>
		<cfset tp_booked_h = 0>
		<cfset progress_completed = 0>
	</cfif>
	
	<cfoutput query="get_tporientation">
	<cfquery name="get_session_access_suggested_#get_tporientation.tp_orientation_id#" datasource="#SESSION.BDDSOURCE#">
		SELECT tc.*,
		tp.tpmaster_id, tp.tpmaster_level, tp.tpmaster_hour,
		sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.module_id, sm.keyword_id, sm.sessionmaster_new,
		tm.module_level,
		
		(CASE WHEN tp.tpmaster_name_#SESSION.LANG_CODE# <> "" THEN tp.tpmaster_name_#SESSION.LANG_CODE# ELSE tp.tpmaster_name END) AS tpmaster_name, 
	
	
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
		
		AND tp.tpmaster_level like '%#u_level_letter#%'
		
		AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">  
		
		<!----------- NO KW CONDITION FOR GRAMMAR -------------->
		<cfif get_tporientation.tp_orientation_id eq "1">
		AND (1 = 2
		<cfloop list="#tp_interest_select#" index="cor">
			OR FIND_IN_SET(#cor#,sm.keyword_id)
		</cfloop>
		)
		<cfelseif get_tporientation.tp_orientation_id eq "1">
		AND (1 = 2
		<cfloop list="#tp_function_select#" index="cor">
			OR FIND_IN_SET(#cor#,sm.keyword_id)
		</cfloop>
		)
		</cfif>
		
		AND sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tporientation.tp_orientation_id#">  
		
		GROUP BY sm.sessionmaster_id
		ORDER BY tp.tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
	</cfquery>
	</cfoutput>

    <cfset __text_about = obj_translater.get_translate('text_about')>
    <cfset __lesson = obj_translater.get_translate('lesson')>
    <cfset __shortminute = obj_translater.get_translate('short_minute')>
    <cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
    <cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
    <cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
    <cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
    <cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>		
    <cfset __card_keywords = obj_translater.get_translate('card_keywords')>
    <cfset __card_grammar = obj_translater.get_translate('card_grammar')>
    <cfset __btn_details = "Details">
    <cfset __btn_remove = obj_translater.get_translate('btn_remove')>
    <cfset __btn_add = obj_translater.get_translate('btn_add')>
	

</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

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
		.btn-outline-success {
			text-transform:none !important; 
			border: 1px solid #6bd098 !important;
		}
		.btn-outline-warning {
			text-transform:none !important; 
			border: 1px solid #fbc658 !important;
		}	
		.btn-outline-primary {
			text-transform:none !important; 
			border: 1px solid #51cbce !important;
		}
		.btn-outline-secondary {
			text-transform:none !important; 
			border: 1px solid #ECECEC !important;
		}
		
		.card_module:hover {
			border-color:#FFA100;
			-webkit-filter: grayscale(0%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(0%); /* Firefox */
		}
		.card_module {
			border:1px solid #ECECEC;
			-webkit-filter: grayscale(90%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(90%); /* Firefox */
		}
		.sidebar-outer {
			position: relative;
		}
		.fixed {
			position: fixed;
		}
		.tp_type_id,.tp_orientation_id{
			display: inline-block;
			-webkit-appearance: none;
			-moz-appearance: none;
			-o-appearance: none;
			appearance: none;
		}
	</style>
	
	<script type = "text/javascript" >  
		function preventBack() { window.history.forward(); }  
		setTimeout("preventBack()", 0);  
		window.onunload = function () { null };  
	</script> 


</head>


<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">

			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">
<!--- u_level >>> <cfoutput>#u_level#</cfoutput> --->
<!--- t_id >>> <cfoutput>#t_id#</cfoutput> --->
<!--- <cfoutput>#REMOTE_ADDR#</cfoutput> --->

				<cfinclude template="./incl/incl_nav_learner.cfm">

				<div class="mt-3">
					
					<div id="container_choice" class="collapse show">

						<div class="card shadow-sm mb-2 border-bottom border-info">
	
							<div class="card-header" align="center">
								<cfoutput>
								
								<button class="btn btn-info font-weight-normal p-2 p-xl-3 btn_choice_tp" style="text-transform:none !important">	
									<h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_ichoose')# : </h6> <span class="choice_text">#obj_translater.get_translate('btn_solo_tp')#</span>
								</button>
																
								<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_length" aria-expanded="false" aria-controls="collapse_length">				
									<h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_choose_course_duration')# : </h6><span class="length_text">#session_length# #__shortminute#</span>
								</button>
								
								<!--- <button class="btn btn-outline-info font-weight-normal p-2 p-xl-3 disabled" style="text-transform:none !important">		 --->
									<!--- <h6 class="d-none d-sm-block">#obj_translater.get_translate('level')# : </h6>#u_level# --->
								<!--- </button> --->
								
								</cfoutput>
							</div>
									
							<div class="card-body pt-0 pb-0" align="center">
							
								<div class="collapse collapse_length mb-2" data-parent="#container_choice">
									<div class="row">
										<div class="col-12">
											<div class="p-2 border-top">	
												<cfoutput>
													<cfloop list="15,30,45,60,75,90" index="cor">
														<button id="choice_len_#cor#" class="btn btn-outline-info <cfif session_length eq cor>active</cfif> font-weight-normal select_session_length" value="#cor#" <cfif SESSION.USER_PROFILE eq "Test" AND cor neq "45">disabled</cfif>>		
															<h6 class="d-inline">#cor# #__shortminute#</h6>
														</button>
													</cfloop>
													<button id="choice_len_0" class="btn btn-outline-info <cfif session_length eq cor>active</cfif> font-weight-normal select_session_length" value="0" <cfif SESSION.USER_PROFILE eq "Test">disabled</cfif>>		
														<h6 class="d-inline">#obj_translater.get_translate('var_duration')#</h6>
													</button>
												</cfoutput>
											</div>
										</div>
									</div>
								</div>
								
							</div>
							
						</div>

					</div>
					
					<div id="container_solo" class="collapse show">
						<div class="row mt-4">
							<div class="col-md-8">
							
								<div class="card-deck btn-group-toggle" data-toggle="buttons">
								
									<cfoutput query="get_tporientation">
										<label class="btn btn-lg card p-2 m-2 btn-outline-info cursored font-weight-normal <cfif tp_orientation_id eq tp_orientation_select>active focus<cfelse>collapsed</cfif>" data-toggle="collapse" data-target="##container_solo_suggested_#tp_orientation_id#" aria-expanded="<cfif tp_orientation_select eq tp_orientation_id>true<cfelse>false</cfif>" aria-controls="container_solo_suggested_#tp_orientation_id#">
											<input type="radio" name="tp_orientation_id" class="tp_orientation_id" value="#tp_orientation_id#" autocomplete="off" <cfif tp_orientation_id eq tp_orientation_select>checked<cfelse></cfif>>		
						
												<img src="./assets/img/#tp_orientation_src#" width="100" class="card-img-top">
												<div class="badge badge-#level_css#">#u_level#</div>
												<br>
												<small>#tp_orientation_name#</small>
												
										</label>
									</cfoutput>
										<label class="btn btn-lg card p-2 m-2 btn-outline-info cursored font-weight-normal collapsed" data-toggle="collapse" data-target="#container_solo_0" aria-expanded="false" aria-controls="container_solo_0">
											<input type="radio" name="tp_orientation_id" class="tp_orientation_id" value="0" autocomplete="off">		
						
											<img src="./assets/img/support_all.jpg" width="100" class="card-img-top">
											<small>
											Web Lesson<br>
											Discussion<br>
											Workshop
											</small>
										</label>
								
								</div>


								<div id="container_solo_0" class="collapse mb-3" data-parent="#container_solo">
									<cfoutput>
									<cfloop list="1181,1183,697" index="cor">
									<cfset get_session_description = obj_query.oget_session_description(sm_id="#cor#")>

									<div class="card border mt-2 bg-white" id="containersssm_#cor#">
										<div class="card-body">

											<div class="p-2 w-100">
												<div class="row">
												
													<div class="col-2 px-0" align="center">
														#obj_lms.get_thumb_mini_session(sessionmaster_id="#get_session_description.sessionmaster_id#",sessionmaster_code="#get_session_description.sessionmaster_code#")#
													</div>
													
													<div class="col-1">
													
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
																		<h5 class="d-inline" style="font-size:16px">
																			<span class="badge badge-danger display_text_action d-block" id="sr_#array_session_tp[session_index].session_id#">
																				<small>#obj_translater.get_translate('table_th_course')#</small>
																				<strong>#array_session_tp[session_index].session_rank#</strong>
																				<br>
																				<strong>#array_session_tp[session_index].session_duration# #__shortminute#</strong>
																			</span>
																		</h5>

																		<button class="btn btn-sm btn-outline-danger btn-block font-weight-normal selector <cfif isdefined("sessionmaster_id") AND !listfindnocase("694,695", sessionmaster_id)>btn_del_session<cfelse>disabled</cfif> mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btns_#cor#_#array_session_tp[session_index].session_id#_#array_session_tp[session_index].session_rank#">
																			#__btn_remove#
																		</button>
																	</div>

																</cfif>
															</cfloop>

															<div id="containersm_#cor#" class="border mt-2 p-2 bg-white">
																<select class="form-control form-control-sm session_length_solo" id="len_#cor#">
																	<cfloop list="15,30,45,60,75,90" index="cor2">
																		<option <cfif session_length eq cor2>selected</cfif> <cfif cor2 gt tp_duration_min OR (SESSION.USER_PROFILE eq "Test" AND cor2 neq "45")>disabled</cfif> value="#cor2#">#cor2##__shortminute#</option>
																	</cfloop>
																</select>

																<button class="btn btn-sm btn-outline-info btn-block font-weight-normal selector btn_add_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btnsm_#cor#">
																<span class="d-none d-sm-inline">#__btn_add# </span><span class="fas fa-plus-circle"></span>
																</button>

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
								
								<cfloop query="get_tporientation">
								<div id="container_solo_suggested_<cfoutput>#get_tporientation.tp_orientation_id#</cfoutput>" class="collapse  <cfif get_tporientation.tp_orientation_id eq tp_orientation_select>show</cfif>" data-parent="#container_solo">
															

									<cfif tp_orientation_id eq "1">
										<strong><cfoutput>#obj_translater.get_translate('table_th_interests')#</cfoutput> :</strong>
										<cfif tp_interest_select neq "">
										<cfoutput query="get_tp_interest_wish">
										<span class="badge badge-pill border cursored bg-white p-2 mb-3 btn_choice_kw" data-toggle="tooltip" data-placement="top" title="#__tooltip_keyword_connected#"></i> <i class="fas fa-star text-warning"></i> #keyword_name#</span> 
										</cfoutput>
										</cfif>
										<span class="badge badge-pill border cursored bg-info p-2 mb-3 btn_choice_kw text-white"></i> <i class="fas fa-plus"></i> <cfoutput>#obj_translater.get_translate('btn_modif')#</cfoutput></span> 
										
									<cfelseif tp_orientation_id eq "2">
										
										<strong><cfoutput>#obj_translater.get_translate('table_th_business')#</cfoutput> :</strong>
										<cfif tp_function_select neq "">
										<cfoutput query="get_tp_function_wish">
										<span class="badge badge-pill border cursored bg-white p-2 mb-3 btn_choice_kw" data-toggle="tooltip" data-placement="top" title="#__tooltip_keyword_connected#"></i> <i class="fas fa-star text-warning"></i> #keyword_name#</span> 
										</cfoutput>
										</cfif>
										<span class="badge badge-pill border cursored bg-info p-2 mb-3 btn_choice_kw text-white"></i> <i class="fas fa-plus"></i> <cfoutput>#obj_translater.get_translate('btn_modif')#</cfoutput></span> 
										
									</cfif>
								
									
									
								<cfoutput query="get_session_access_suggested_#tp_orientation_id#">
								
								<cfif findnocase("A",tpmaster_level)>
									<cfset level_css = "success">
								<cfelseif findnocase("B",tpmaster_level)>
									<cfset level_css = "info">
								<cfelseif findnocase("C",tpmaster_level)>
									<cfset level_css = "danger">
								<cfelse>
									<cfset level_css = "info">
								</cfif>
								
								<!---------- DETERMINE SESSION STATUS ------------------>
								<cfset session_status = 0>																
								<cfloop from="1" to="#arrayLen(array_session_tp)#" index="counter">
									<cfif array_session_tp[counter].sessionmaster_id IS sessionmaster_id>
										<cfset session_status = 1>
										<cfset session_index = counter>
									</cfif>
								</cfloop>
								
								<div class="card border mt-2 <cfif session_status eq "1">bg-info-select<cfelse>bg-white</cfif>" id="containersssm_#sessionmaster_id#">
									<div class="card-body">
								
										<div class="p-2 w-100">
											<div class="row">
											
												<div class="col-2 px-0" align="center">
													#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#
													<cfif sessionmaster_new eq "1">
													<br>
													<h5 class="m-0"><div class="badge badge-success">New !</div> </h5>
													</cfif>
												
												</div>
												
												<div class="col-1">
													<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
														<i class="fal fa-book fa-lg text-#level_css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
													<cfelse>
														<i class="fal fa-book fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
													</cfif>

													<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
														<i class="fal fa-volume-up fa-lg text-#level_css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
													<cfelse>
														<i class="fal fa-volume-up fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
													</cfif>

													<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
														<i class="fal fa-film fa-lg text-#level_css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
													<cfelse>
														<i class="fal fa-film fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
													</cfif>

													<cfif quiz_id neq "" AND quiz_id neq "0">
														<i class="fal fa-tasks fa-lg text-#level_css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
													<cfelse>
														<i class="fal fa-tasks fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#" style="color:##ECECEC"></i>
													</cfif>
												</div>
												
												<div class="col-7">
												
													<strong><!---#sessionmaster_id# / ---><h6 class="m-0 d-inline"><div class="badge badge-#level_css#">#tpmaster_level#</div></h6> #sessionmaster_name#</strong>
													<br>
													<small>#sessionmaster_description#</small>
													<!--- <small>#mid(sessionmaster_description,1,120)# [...]</small> --->
													<span class="btn_view_session" id="sm_#sessionmaster_id#">
														<!---<small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small>--->
													</span>
													<cfif keyword_id neq "">
														<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
														SELECT keyword_id as k_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#) <cfif get_tporientation.tp_orientation_id eq "1">AND keyword_cat_id = 3<cfelseif get_tporientation.tp_orientation_id eq "2">AND (keyword_cat_id = 4 OR keyword_cat_id = 5)<cfelse>AND 1 = 2</cfif>
														</cfquery>
														<cfif get_keyword.recordcount neq "0">
															<small>#__card_keywords# :</small>


														


															<br>
														
														
														<cfloop query="get_keyword">
														<cfif listfind(tp_interest_select,k_id) OR listfind(tp_function_select,k_id)>
														<span class="badge badge-pill border border-#level_css# cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_keyword_connected#"></i> <i class="fas fa-star text-warning"></i> #keyword_name#</span> 
														<cfelse>
														<span class="badge badge-pill border">#keyword_name#</span> 
														</cfif>
														</cfloop>
													</cfif>
													</cfif>
												</div>

												<div class="col-2">
													<div id="container_book_#sessionmaster_id#">

														<cfif session_status eq 1>

															<div id="containers_#array_session_tp[session_index].session_id#" class="border p-2 bg-white">
																<h5 class="d-inline" style="font-size:16px">
																	
																	<span class="badge badge-danger display_text_action d-block" id="sr_#array_session_tp[session_index].session_id#">
																		<small>#obj_translater.get_translate('table_th_course')#</small>
																		<strong>#array_session_tp[session_index].session_rank#</strong>
																		<br>
																		<strong>#array_session_tp[session_index].session_duration# #__shortminute#</strong>
																	</span>
																	
																</h5>
																<button class="btn btn-sm btn-outline-danger btn-block font-weight-normal selector <cfif isdefined("sessionmaster_id") AND !listfindnocase("694,695", sessionmaster_id)>btn_del_session<cfelse>disabled</cfif> mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btns_#sessionmaster_id#_#array_session_tp[session_index].session_id#_#array_session_tp[session_index].session_rank#">
																	#__btn_remove#
																</button>
															</div>

														<cfelse>

															<div id="containersm_#sessionmaster_id#" class="border p-2 bg-white">
																<select class="form-control form-control-sm session_length_solo" id="len_#sessionmaster_id#">
																	<cfloop list="15,30,45,60,75,90" index="cor">
																		<option <cfif session_length eq cor>selected</cfif> <cfif cor gt tp_duration_min OR(SESSION.USER_PROFILE eq "Test" AND cor neq "45")>disabled</cfif> value="#cor#">#cor# min</option>
																	</cfloop>
																</select>
																<button class="btn btn-sm btn-outline-info btn-block font-weight-normal selector btn_add_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btnsm_#sessionmaster_id#">
																	<span class="d-none d-sm-inline">#__btn_add# </span><span class="fas fa-plus-circle"></span>
																</button>
															</div>

														</cfif>
													</div>
												</div>
											</div>
										</div>
										
										</div>
									
									</div>
									</cfoutput>		

								</div>
								</cfloop>

							</div>
									
							<div class="col-md-4" style="padding-left: 0px !important; padding-right: 0px !important;">
								<div class="card border">
									<div class="card-body">
										<div class="row">
											<div class="col-12">
											
											<h6 align="center"><cfoutput>#obj_translater.get_translate('sidemenu_learner_tp')#</cfoutput></h6>
											
											<cfoutput>
											<div class="row">
												<div class="col-9">
													<div class="progress mt-2" style="height:35px">
														<div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated display_tp_progress text-dark" role="progressbar" aria-valuenow="#progress_completed#" aria-valuemin="0" aria-valuemax="100" style="width: #progress_completed#%;"> &nbsp;<cfif tp_duration_min-tp_booked_min gt 0>#obj_lms.get_format_hms(tp_duration_min-tp_booked_min,"h")# #lcase(obj_translater.get_translate('badge_remaining_f_p'))#<cfelse>0 #__shortminute# #lcase(obj_translater.get_translate('badge_remaining_f_s'))#</cfif></div>
													</div>
												</div>
												<div class="col-3">
													<a href="##" class="btn btn-success btn_view_tp mt-2 <cfif tp_booked_min eq "0">disabled</cfif>" id="tp_#t_id#">#obj_translater.get_translate('btn_validate')#</a>
												</div>
											</div>
											</cfoutput>
												
											</div>
										</div>

										<div class="row">
											<div class="col-md-12">		

												<div id="div_content">
													<table id="table_tp" class="table table-sm mt-3" width="100%">
														<!--- <thead> --->
															<!--- <tr bgcolor="#F3F3F3"> --->
																<!--- <th width="1%"></th> --->
																<!--- <th width="3%"><label>N&deg;</label></th> --->
																<!--- <th width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_course_type')#</cfoutput></label></th> --->
																<!--- <th width="10%"><label><cfoutput>#obj_translater.get_translate('table_th_duration_short')#</cfoutput></label></th> --->
																<!--- <th><label><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></label></th> --->
																<!--- <th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th> --->
																<!--- <th width="12%"></th> --->
															<!--- </tr> --->
														<!--- </thead> --->
														 <tbody id="tbody_sortable"> 
														<!--- <cfdump var="#get_session#"> --->
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
																			<td style="cursor:pointer"><!---<i class="fas fa-arrows-alt-v"></i>---></td>
																	</cfif>
																	<td>	
																		<h5 class="d-inline" style="font-size:16px">
																		<span class="badge badge-danger display_text_action d-block font-weight-normal">
																			<small>#obj_translater.get_translate('table_th_course')#</small>
																			<strong>#session_rank#</strong>
																			<br>
																			<strong>#session_duration# #__shortminute#</strong>
																		</span>
																		</h5>
																	</td>
																	<!---<td>
																		<small>#cat_name#</small>
																	</td>
																--->
																<!--- <td> --->
																	<!--- <small>#session_duration# min</small> --->
																<!--- </td> --->
																<td>									
																	<span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 32ch;">#sessionmaster_name#</span>
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

																		<cfif lesson_id eq "" AND (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
																			<a id="btns_#sessionmaster_id#_#session_id#_#session_rank#_#session_duration#" class="btn btn-danger btn-sm btn_del_session"><i class="far fa-times"></i></a>
																		<cfelse>
																			<a id="btns_#sessionmaster_id#_#session_id#_#session_rank#_#session_duration#" class="btn btn-warning btn-sm disabled"><i class="far fa-times"></i></a>
																		</cfif>
																	<cfelse>												
																		<cfif lesson_id neq "">
																			<div class="btn-group" role="group">
																				<a id="btns_#sessionmaster_id#_#session_id#_#session_rank#_#session_duration#" class="btn btn-danger btn-sm disabled"><i class="far fa-times"></i></a>

																				<!---- DISPLAY SWITCH BUTTON IF THERE IS A SCHEDULED ONE ON THE LIST ---->
																				<!--- <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																					<cfoutput group="lesson_id">
																						<cfif status_id eq "1">
																							<a class="btn btn-warning btn-sm btn_switch ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#"><i class="fas fa-random"></i></a>
																						</cfif>
																					</cfoutput>
																				</cfif> --->
																			</div>

																		<cfelse>
																			<div class="btn-group" role="group">
																				<a id="btns_#sessionmaster_id#_#session_id#_#session_rank#_#session_duration#" class="btn btn-danger btn-sm <cfif isdefined("sessionmaster_id") AND !listfindnocase("694,695", sessionmaster_id)>btn_del_session<cfelse>disabled</cfif>"><i class="far fa-times"></i></a>

																				<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																					<!--- <a class="btn btn-warning btn-sm btn_switch ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#"><i class="fas fa-random"></i></a> --->
																				</cfif>
																			</div>
																		</cfif>		

																	</cfif> 

																	<!--- <input type="hidden" class="session_final_rank" name="S_#session_id#" value="#session_rank#_#sessionmaster_id#_#session_duration#_#cat_id#_#session_rank#"> --->
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

<cfinclude template="./incl/incl_scripts_modal.cfm">


<script>
$(document).ready(function() {

	$('[data-toggle="tooltip"]').tooltip();

	<cfoutput>	

	<cfif not isdefined("tp_choice")>
		$('##window_item_xl_unclosable').modal({backdrop: 'static',keyboard: false});
		$('##modal_title_xl_unclosable').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl_unclosable').empty();
		$('##modal_body_xl_unclosable').load("modal_window_launch2.cfm?view=param_tp", function() {});
	<cfelse>
		<cfif isdefined("kw_choice")>
		$('##window_item_xl_unclosable').modal({keyboard: false});
		$('##modal_title_xl_unclosable').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl_unclosable').empty();
		$('##modal_body_xl_unclosable').load("modal_window_launch2.cfm?view=param_themes&tp_choice=#tp_choice#", function() {});
		</cfif>
	</cfif>	
		
	
	$('.btn_choice_tp').click(function(event) {	
		event.preventDefault();
		$('##window_item_xl').modal({keyboard: false});
		$('##modal_title_xl').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl').empty();
		$('##modal_body_xl').load("modal_window_launch2.cfm?show_info=tp_type&tp_choice=#tp_choice#", function() {});
		
	})
	
	$('.btn_choice_kw').click(function(event) {	
		event.preventDefault();
		$('##window_item_xl').modal({keyboard: false});
		$('##modal_title_xl').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl').empty();
		$('##modal_body_xl').load("modal_window_launch2.cfm?view=param_themes&tp_choice=#tp_choice#", function() {});
		
	})
		
	<!------------------ BTN FOR VIEWING TP---------->
	$('.btn_view_tp').click(function(event) {
		event.preventDefault();		
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_validate_program')))#");
		$('##modal_body_xl').empty();
		$('##modal_body_xl').load("modal_window_tpview.cfm?t_id=#t_id#&u_id=#u_id#", function() {});
	});
	

	</cfoutput>
	
	
		<!--- </cfif> --->

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
				return '<h5 class="d-inline" style="font-size:16px"><span class="badge badge-danger border font-weight-normal display_text_action d-block font-weight-normal" id="sr_'+$(this).parent().index("#table_tp tr")+'">'+$(this).parent().index("#table_tp tr")+'<small><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></small><strong>xxx</strong><br><strong>xxx <cfoutput>#__shortminute#</cfoutput></strong></span></h5>';
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



		<!--- INIT --->
		session_length_min = <cfoutput>#session_length#</cfoutput>;

		tp_duration_min = <cfoutput>#tp_duration_min#</cfoutput>;
		tp_duration_h = tp_duration_min/60;

		tp_booked_min = <cfoutput>#tp_booked_min#</cfoutput>;
		tp_left_min = parseInt(tp_duration_min-tp_booked_min);

		tp_booked_h = tp_booked_min/60;
		tp_left_h = tp_left_min/60;

		progress_completed = parseInt((tp_booked_min/tp_duration_min)*100);
		progress_delta = parseInt((session_length_min/tp_duration_min)*100);


		$(".selector").tooltip({
			classes: {"ui-tooltip": "ui-corner-all"},
			open: function( event, ui ) {
				<!--- <div class="progress_completed_delta progress-bar bg-warning" role="progressbar" style="width: '+progress_delta+'%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div> --->
				$(this).tooltip({    content: '<div class="progress" style="height:20px"><div class="progress_completed_bar progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="'+progress_completed+'" aria-valuemin="0" aria-valuemax="100" style="width: '+progress_completed+'%"></div></div><span class="display_tp_booked">'+tp_booked_h+'</span>h <cfoutput>#obj_translater.get_translate('badge_planned_f_p')#</cfoutput> / <span class="display_tp_duration">'+tp_duration_h+'</span>h'         });
			}
		});

		var handler_add = function add_session(){
			event.preventDefault();
			var obj = $(this);
			
			<!---- ENABLE TP VALIDATION --->
			$(".btn_view_tp").removeClass("disabled");
			
			var idtemp = obj.attr("id");
			var idtemp = idtemp.split("_");
			var sm_id = idtemp[1];

			var sm_length = $("#len_"+sm_id).val();

			
			<!---- CHECK MAX --->
			var temp_delta = parseInt(tp_booked_min)+parseInt(sm_length);
			temp_delta = tp_duration_min-temp_delta;
			
			if(temp_delta < 0)
			{
				alert('<cfoutput>#encodeForJavaScript(trim(obj_translater.get_translate('js_book_credential')))#</cfoutput>');
			}
			else
			{
				$.ajax({
					url : 'updater_tp.cfc?method=add_session',
					type : 'GET',
					<cfoutput>data : 'sm_id='+sm_id+'&t_id=#t_id#&s_duration='+sm_length,</cfoutput>
					success : function(result, statut){

						<!---- STORE JSON --->
						var obj_result = jQuery.parseJSON(result);

						tp_booked_min += parseInt(sm_length);
						tp_left_min = parseInt(tp_duration_min-tp_booked_min);

						tp_booked_h = tp_booked_min/60;
						tp_left_h = tp_left_min/60;
						
						progress_delta = parseInt((sm_length/tp_duration_min)*100);
						progress_completed += progress_delta; 
		
						if(tp_left_h == 0)
						{
						$('#window_item_xl').modal({keyboard: true});
						$('#modal_title_xl').text("<cfoutput>#obj_translater.get_translate('js_modal_title_validate_program')#</cfoutput>");
						$('#modal_body_xl').empty();
						<cfoutput>
						$('##modal_body_xl').load("modal_window_tpview.cfm?t_id=#t_id#&u_id=#u_id#", function() {});
						</cfoutput>
						}
						
						if(tp_left_h == parseInt(tp_left_h))
						{
							var txt_remain = tp_left_h+"H";
						}
						else
						{
							n = Math.abs(tp_left_h);
							var decimal = n - Math.floor(n);
							if(decimal == "0.25")
							{
							var txt_remain = parseInt(tp_left_h)+"H15min";
							}
							else if(decimal == "0.5")
							{
							var txt_remain = parseInt(tp_left_h)+"H30min";
							}
							else if(decimal == "0.75")
							{
							var txt_remain = parseInt(tp_left_h)+"H45min";
							}
							
						}
						

						<!--- RECREATE CONTAINER --->
						if(sm_id != "1181" && sm_id != "1183" && sm_id != "697")
						{
							$('#containersm_'+sm_id).remove();
						}

						<!----- CREATE ROW IN TPVIEW ---->														
						var container_add = '<div id="containers_'+obj_result[0]+'" class="border p-2 bg-white">';
						container_add += '<h5 class="d-inline" style="font-size:16px"><span class="badge badge-danger border font-weight-normal display_text_action d-block font-weight-normal" id="sr_'+obj_result[0]+'">';
						<!--- container_add += '<span class="badge badge-pill badge-danger" id="sr_'+obj_result[0]+'">'; --->
						container_add += '<small><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></small>';
						container_add += '<strong>'+obj_result[1]+'</strong>';
						container_add += '<br><strong>'+sm_length+' <cfoutput>#__shortminute#</cfoutput></strong>';
						container_add += '</span></h5>';
						container_add += '<button class="btn btn-sm btn-outline-danger btn-block font-weight-normal selector <cfif isdefined("sessionmaster_id") AND !listfindnocase("694,695", sessionmaster_id)>btn_del_session<cfelse>disabled</cfif> mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btns_'+sm_id+'_'+obj_result[0]+'_'+obj_result[1]+'_'+sm_length+'"><cfoutput>#__btn_remove#</cfoutput></button>';
						container_add += '</div>';
						$('#container_book_'+sm_id).prepend(container_add);

						
						$('#containersssm_'+sm_id).removeClass("bg-white");
						$('#containersssm_'+sm_id).addClass("bg-info-select");


						<!---- CREATE ROW IN TPVIEW --->
						var liner = '<tr id="tr_'+obj_result[1]+'">';
						<!--- liner += '<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>'; --->
						liner += '<td></td>';		
						liner += '<td><h5 class="d-inline" style="font-size:16px"><span class="badge badge-danger display_text_action d-block font-weight-normal"><small><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></small> <strong>'+obj_result[1]+'<br>'+sm_length+' <cfoutput>#__shortminute#</cfoutput></strong></span></h5></td>';
						liner += '<td>'+obj_result[4]+'</td>';
						liner += '<td></td>';
						liner += '<td><a id="btns_'+sm_id+'_'+obj_result[0]+'_'+obj_result[1]+'_'+sm_length+'" class="btn btn-danger btn-sm <cfif isdefined("sessionmaster_id") AND !listfindnocase("694,695", sessionmaster_id)>btn_del_session<cfelse>disabled</cfif>"><i class="far fa-times"></i></a></td>';
						liner += '</tr>';								
						$(".last_tr").before(liner);

						<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
						$(".btn_del_session").off("click");
						$(".btn_del_session").bind("click",handler_del);
					
					
						<!----- ADAPT DOM ---->
						$('.display_tp_booked_button').text(tp_booked_h);
						$('.display_tp_booked').text(tp_booked_h);
						$('.progress_completed_bar').css('width',progress_completed + '%');
						$(".progress_completed_general_bar").css("width",progress_completed+"%");

						<!--- $('.display_tp_progress').html(tp_booked_h+"h <cfoutput>#obj_translater.get_translate('badge_planned_f_p')#</cfoutput> / "+tp_duration_h+"h"); --->
						$('.display_tp_progress').html(txt_remain+" <cfoutput>#lcase(obj_translater.get_translate('badge_remaining_f_p'))#</cfoutput>");

						
					},

					error : function(result, statut, erreur){
						<!--- alert("pbl"); --->
					}
				})
			}
		}
		$(".btn_add_session").bind("click",handler_add);



		var handler_del = function del_session(){
			event.preventDefault();
			var obj = $(this);

			var idtemp = obj.attr("id");
			var idtemp = idtemp.split("_");
			var sm_id = idtemp[1];
			var s_id = idtemp[2];
			var s_rank = idtemp[3];
			var s_duration = idtemp[4];
			
			$.ajax({
				url : 'updater_tp.cfc?method=del_session',
				type : 'GET',
				<cfoutput>data : 's_id='+s_id+'&sm_id='+sm_id+'&t_id=#t_id#',</cfoutput>
				success : function(result, statut){

					<!---- STORE JSON --->
					var obj_result = jQuery.parseJSON(result);

					tp_booked_min -= parseInt(s_duration);
					tp_left_min = parseInt(tp_duration_min-tp_booked_min);

					tp_booked_h = tp_booked_min/60;
					tp_left_h = tp_left_min/60;

					progress_delta = parseInt((s_duration/tp_duration_min)*100);
					progress_completed -= progress_delta; 
						
					if(tp_left_h == parseInt(tp_left_h))
					{
						var txt_remain = tp_left_h+"H";
					}
					else
					{
						n = Math.abs(tp_left_h);
						var decimal = n - Math.floor(n);
						if(decimal == "0.25")
						{
						var txt_remain = parseInt(tp_left_h)+"H15min";
						}
						else if(decimal == "0.5")
						{
						var txt_remain = parseInt(tp_left_h)+"H30min";
						}
						else if(decimal == "0.75")
						{
						var txt_remain = parseInt(tp_left_h)+"H45min";
						}
						
					}

					<!--- REMOVE ROW --->
					$("#tr_"+s_rank).remove();
					
					<!--- RECREATE CONTAINER --->
					$('#containers_'+s_id).remove();

					var container_add = '<div id="containersm_'+sm_id+'" class="border p-2 bg-white">';
					container_add += '<select class="form-control form-control-sm session_length_solo" id="len_'+sm_id+'">';
					<cfloop list="15,30,45,60,75,90" index="cor"><cfoutput>
					if(s_duration == #cor#)
					{container_add += '<option value="#cor#" selected>#cor##__shortminute#</option>';}
					else
					{container_add += '<option value="#cor#">#cor##__shortminute#</option>';}
					</cfoutput></cfloop>
					container_add += '</select>';
					container_add += '<button class="btn btn-sm btn-outline-info btn-block font-weight-normal selector btn_add_session mb-0" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btnsm_'+sm_id+'"><cfoutput><span class="d-none d-sm-inline">#__btn_add# </span><span class="fas fa-plus-circle"></span></cfoutput></button>';
					container_add += '</div>';		

					<!--- RECREATE CONTAINER --->
					if(sm_id != "1181" && sm_id != "1183" && sm_id != "697")
					{
						$('#container_book_'+sm_id).prepend(container_add);
						$('#btnsm_'+sm_id).bind("click",handler_add);
					}

					$('#containersssm_'+sm_id).toggleClass("bg-white");
					$('#containersssm_'+sm_id).toggleClass("bg-info-select");

					$('.display_tp_booked_button').text(tp_booked_h);
					$('.display_tp_booked').text(tp_booked_h);

					<!--- $('.display_tp_progress').html(tp_booked_h+"h <cfoutput>#obj_translater.get_translate('badge_planned_f_p')#</cfoutput> / "+tp_duration_h+"h"); --->
					$('.display_tp_progress').html(txt_remain +" <cfoutput>#lcase(obj_translater.get_translate('badge_remaining_f_p'))#</cfoutput>");


					$('.progress_completed_bar').css('width',progress_completed + '%');
					$(".progress_completed_general_bar").css("width",progress_completed+"%");



					/*console.log(result);*/

				},

				error : function(result, statut, erreur){
					<!--- alert("pbl"); --->
				}
			})
		}
		$(".btn_del_session").bind("click",handler_del);



		
		
		$(".select_session_length").click(function() {

			$(".collapse_length").collapse("hide");
			$(".select_session_length").removeClass("active");
			$(this).addClass("active");

			session_length_min = $(this).val();
			if(session_length_min == 0)
			{
				$(".length_text").html("Durée variable");
				$("session_length_solo option[value='0']").prop('selected', true);
			}
			else
			{
				$(".length_text").html(session_length_min+"<cfoutput>#__shortminute#</cfoutput>");
				$(".session_length_solo option[value='"+session_length_min+"']").prop('selected', true);			
			}

			$("#collapse_length").collapse("hide");		
			$("#container_category").collapse("show");
			$("#collapse_category").collapse("show");

			progress_delta = parseInt((session_length_min/tp_duration_min)*100);
			

		});

		

	});
	</script>
</body>
</html>