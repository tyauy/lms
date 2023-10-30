<!DOCTYPE html>

<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
		
	<cfset tp_choice = "prefilled">

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

	<cfif not isdefined("tp_session_duration")>
		<cfset tp_session_duration = get_tp.tp_session_duration>
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
		
    <!---- GET PREFILLED TP, IF COMPLIANT 5/10/15/20/25/30 ---->

    <cfquery name="get_prefilled" datasource="#SESSION.BDDSOURCE#">
    SELECT tc.*, tc.tpmastercor_name_#SESSION.LANG_CODE# as tpmastercor_name, tc.tpmastercor_desc_#SESSION.LANG_CODE# as tpmastercor_desc,
    tp.tpmaster_id, tp.tpmaster_level, tp.tpmaster_hour, tp.tpmaster_img, tp.tpmaster_lesson_duration,
    sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.module_id, sm.keyword_id, sm.sessionmaster_cat_id,

    (CASE WHEN tp.tpmaster_name_#SESSION.LANG_CODE# <> "" THEN tp.tpmaster_name_#SESSION.LANG_CODE# ELSE tp.tpmaster_name END) AS tpmaster_name, 
    
    (CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sm.sessionmaster_name END) AS sessionmaster_name, 
    (CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sm.sessionmaster_description END) AS sessionmaster_description, 

    (CASE WHEN tm.module_name_#SESSION.LANG_CODE# <> "" THEN tm.module_name_#SESSION.LANG_CODE# ELSE tm.module_name END) AS module_name, 
    (CASE WHEN tm.module_description_#SESSION.LANG_CODE# <> "" THEN tm.module_description_#SESSION.LANG_CODE# ELSE tm.module_description END) AS module_description

    FROM lms_tpmaster2 tp
    INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
    LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
    
    WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    AND tp.tpmaster_prebuilt = 1
    AND tp.tpmaster_lesson_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_session_duration#">
    AND sm.sessionmaster_online_visio = 1
    
    AND tp.tpmaster_level like '%#u_level_letter#%'

    AND tp.tpmaster_hour = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_master_hour#">

    GROUP BY tc.tpmaster_id, tc.sessionmaster_rank, tc.sessionmaster_id
    ORDER BY tc.tpmaster_id, tc.sessionmaster_rank, sm.sessionmaster_name
    </cfquery>	

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

				<cfinclude template="./incl/incl_nav_learner.cfm">

				<div class="mt-3">
					
					<div id="container_choice" class="collapse show">

						<div class="card shadow-sm mb-2 border-bottom border-info">
	
							<div class="card-header" align="center">
								<cfoutput>
								<button class="btn btn-info font-weight-normal p-2 p-xl-3 btn_choice_tp" style="text-transform:none !important">	
									<h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_ichoose')# : </h6><span class="choice_text"><cfoutput>#obj_translater.get_translate('btn_prefilled_tp')#</cfoutput></span>
								</button>
								<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_length" aria-expanded="false" aria-controls="collapse_length">				
									<h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_choose_course_duration')# : </h6><span class="length_text">#tp_session_duration# #obj_translater.get_translate('short_minute')#</span>
								</button>
								</cfoutput>
							</div>
							
							
									
							<div class="card-body pt-0 pb-0">
								<div class="collapse collapse_length mb-2" data-parent="#container_choice">
									<div class="row">
										<div class="col-12">
											<div class="p-2 border-top" align="center">	
												<cfoutput>
													<cfloop list="30,45,60" index="cor">
														<button id="choice_len_#cor#" class="btn btn-outline-info <cfif tp_session_duration eq cor>active</cfif> font-weight-normal select_session_length" value="#cor#" <cfif SESSION.USER_PROFILE eq "Test" AND cor neq "45">disabled</cfif>>		
															<h6 class="d-inline">#cor# #obj_translater.get_translate('short_minute')#</h6>
														</button>
													</cfloop>
												</cfoutput>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
					
					
					
					<cfset css="info">	
					<div id="container_prefilled" class="collapse show">

						<div class="row justify-content-md-center pt-2">

							<div class="col-md-12">

								<div id="accordion_prefilled">
								
									<cfoutput query="get_prefilled" group="tpmaster_id">
									<div class="row">
										<div class="col-md-12">
											<div class="card border mb-3 bg-white">
												<div class="card-body">

													<div class="p-3" id="containersssm_#cor#">
														<div class="row">
														
															<div class="col-1 px-0" align="center">
																<cfif fileexists("#SESSION.BO_ROOT#/assets/img_tpmaster/#tpmaster_img#")>
																	<img src="./assets/img_tpmaster/#tpmaster_img#">
																<cfelse>
																	<img src="./assets/img/wefit_lesson.jpg">
																</cfif>
															</div>
											
															<div class="col-8">

																<h6 class="mt-0 d-inline">#tpmaster_name#</h6>
																<br>
																
																<h6 class="mt-0 d-inline"><span class="mt-2 badge badge-pill bg-white border px-3 py-3 badge-light font-weight-normal">#obj_translater.get_translate('table_th_language')# : <span class="lang-xs" lang="#f_code#" style="top:0px !important"></span></span></h6>
																<h6 class="mt-0 d-inline"><span class="mt-2 badge badge-pill bg-white border px-3 py-3 badge-light font-weight-normal">#obj_translater.get_translate('level')# : <strong class="text-#level_css#">#tpmaster_level#</strong></span></h6>
																<h6 class="mt-0 d-inline"><span class="mt-2 badge badge-pill bg-white border px-3 py-3 badge-light font-weight-normal">#obj_translater.get_translate('table_th_duration_short')# : <strong>#tpmaster_hour#h</strong></span></h6>
																<h6 class="mt-0 d-inline"><span class="mt-2 badge badge-pill bg-white border px-3 py-3 badge-light font-weight-normal">#obj_translater.get_translate('lesson')# : <strong>#tpmaster_lesson_duration# #__shortminute#</strong></span></h6>
															
															</div>

															<div class="col-3">
																<button name="btntppb_#tpmaster_id#" id="btntppb_#tpmaster_id#" class="btn btn-outline-red btn_add_prefilled pull-right">
																#obj_translater.get_translate('btn_choose_program')#  <i class="far fa-chevron-double-right"></i>
																</button>
															</div>
														</div>
													
													</div>
													
													<div class="row justify-content-center">
														<a class="btn btn-sm btn-outline-info font-weight-normal p-1 m-1" data-toggle="collapse" href="##tppb_#tpmaster_id#" role="button" aria-expanded="false" aria-controls="tppb_#tpmaster_id#"><i class="far fa-chevron-double-down"></i> #obj_translater.get_translate('card_details')#</a>
													</div>
													
													<div class="collapse mt-3" id="tppb_#tpmaster_id#" data-parent="##accordion_prefilled">

													<cfoutput>
													<div class="border-top p-3 bg-white" id="container_#sessionmaster_id#">
														<div class="row">
														
															<div class="col-1">
																#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="100")#
															</div>
															
															<div class="col-2">
																<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
																	<i class="fal fa-book fa-lg text-#css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
																<cfelse>
																	<i class="fal fa-book fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
																</cfif>

																<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
																	<i class="fal fa-volume-up fa-lg text-#css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
																<cfelse>
																	<i class="fal fa-volume-up fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
																</cfif>

																<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
																	<i class="fal fa-film fa-lg text-#css# m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
																<cfelse>
																	<i class="fal fa-film fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
																</cfif>

																		<!--- <cfif quiz_id neq "" AND quiz_id neq "0"> --->
																		<!--- <i class="fal fa-tasks fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i> --->
																		<!--- <cfelse> --->
																		<!--- <i class="fal fa-tasks fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#" style="color:##ECECEC"></i> --->
																		<!--- </cfif> --->
															</div>
															
															<div class="col-8">
																<strong>#sessionmaster_rank# - <cfif tpmastercor_name neq "">#tpmastercor_name#<cfelse>#sessionmaster_name#</cfif></strong>
																<br>
																<cfif tpmastercor_desc neq "">#tpmastercor_desc#<cfelse><small>#sessionmaster_description#</small></cfif>
																<!--- <small>#mid(sessionmaster_description,1,120)# [...]</small> --->
																<!--- <span class="btn_view_session" id="sm_#sessionmaster_id#"> --->
																	<!---<small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small>--->
																<!--- </span> --->
																
																
																<cfif sessionmaster_cat_id eq "1">
																
																	<cfif keyword_id neq "">
																		<br>
																		<small>#__card_keywords# :</small>
																		<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
																			SELECT keyword_id as k_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
																		</cfquery>
																		<cfloop query="get_keyword">
																		<cfif listfind(tp_interest_select,k_id) OR listfind(tp_function_select,k_id)>
																		<span class="badge badge-pill border border-#css# cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_keyword_connected#"></i> <i class="fas fa-star text-warning"></i> #keyword_name#</span> 
																		<cfelse>
																		<span class="badge badge-pill border">#keyword_name#</span> 
																		</cfif>
																		</cfloop>
																	</cfif>
																
																<cfelse>
																
																	<div class="row mt-4">
																	
																	<cfif tpmastercor_mapping_id neq "">
																		<!--- <br> --->
																		<!--- <small>#__card_keywords# :</small> --->
																		<cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
																			SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#tpmastercor_mapping_id#) AND mapping_category = 'grammar'
																		</cfquery>
																		
																		<cfif get_mapping_grammar.recordcount neq "0">
																		<div class="col-md-4">	
																			<div class="card border bg-light">
																				
																				<div class="card-body">
																					<h6 class="card-title">Grammar</h6>
																					<br>
																					<cfloop query="get_mapping_grammar">
																					
																					<cfif findnocase("A1",level)>
																						<cfset css = "success">
																					<cfelseif findnocase("A2",level)>
																						<cfset css = "primary">
																					<cfelseif findnocase("B1",level)>
																						<cfset css = "info">
																					<cfelseif findnocase("B2",level)>
																						<cfset css = "warning">
																					<cfelseif findnocase("C1",level)>
																						<cfset css = "danger">
																					</cfif>
																					
																					<span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
																					</cfloop>
																				</div>
																			</div>
																		</div>
																		</cfif>
																	</cfif>
																		
																	<cfif tpmastercor_skill_id neq "">
																		
																		<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
																			SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name FROM lms_skill WHERE skill_id IN (#tpmastercor_skill_id#)
																		</cfquery>
																		
																		<cfif get_skill.recordcount neq "0">
																		<div class="col-md-4">	
																			<div class="card border bg-light">
																				<div class="card-body">
																					<cfif get_skill.recordcount neq "0">Skill<br></cfif>
																					
																					<cfloop query="get_skill">
																					<span class="badge font-weight-normal" style="font-size:13px">#skill_name#</span><br>
																					</cfloop>
																				</div>
																			</div>
																		</div>
																		</cfif>
																		
																	</cfif>
																		
																	</div>
																	
																</cfif>
																
															</div>
																
															<div class="col-1">

																<a href="##" class="badge badge-pill p-2 badge-info text-white">#sessionmaster_schedule_duration# min</strong></a>

															</div>

														</div>
													</div>
													</cfoutput>		
													
												</div>	
													
											</div>
										</div>
									</div>	
                                
                                </div>
								</cfoutput>	
								
								
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
		$('##modal_body_xl').load("modal_window_launch2.cfm?show_info=tp_type", function() {});
		
	})
		
	<!------------------ BTN FOR AUTO TP BUILDING ---------->
	$('.btn_add_prefilled').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tpmaster_id = idtemp[1];	
		$('##window_item_xl').modal({backdrop: 'static',keyboard: false});
		$('##modal_title_xl').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl').empty();		
		$('##modal_body_xl').load("modal_window_tpview.cfm?t_id=#t_id#&tpmaster_id="+tpmaster_id+"&u_id=#u_id#", function() {});
		
	});
		
	<!------------------ BTN FOR VIEWING TP---------->
	$('.btn_view_tp').click(function(event) {
		event.preventDefault();		
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_validate_program')))#");
		$('##modal_body_xl').empty();
		$('##modal_body_xl').load("modal_window_tpview.cfm?t_id=#t_id#&u_id=#u_id#", function() {});
	});
	

	</cfoutput>
	

		
    
    $(".select_session_length").click(function() {

        window.location.href="learner_launch_2_prefilled.cfm?tp_choice=prefilled&tp_session_duration="+$(this).val();
       
    });


});
</script>
</body>
</html>