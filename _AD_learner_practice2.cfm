<!DOCTYPE html>

<cfsilent>

<!--- <cfset secure = "3,7,8,9,5"> --->
<!--- <cfinclude template="./incl/incl_secure.cfm">	 --->
<cfset access_el = 1>


<cfset sm_rec_time = "1">

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
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

<cfquery name="get_chapter_session" datasource="#SESSION.BDDSOURCE#">
SELECT * 
FROM lms_tpchaptermaster2 ch
WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
ORDER BY chapter_rank
</cfquery>

<cfparam name="ch_id" default="0">

<cfif isdefined("ch_id") AND ch_id neq "0">

	<cfquery name="get_glossary" datasource="#SESSION.BDDSOURCE#">
	SELECT v.voc_id, v.voc_word_en
	FROM lms_vocabulary_glossary vg
	INNER JOIN lms_vocabulary v ON v.voc_id = vg.voc_id
	WHERE vg.chapter_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ch_id#">
	</cfquery>

	<cfquery name="get_chapter_solo" datasource="#SESSION.BDDSOURCE#">
	SELECT * 
	FROM lms_tpchaptermaster2 ch
	WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	AND ch.chapter_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ch_id#">
	</cfquery>
	
	<cfquery name="get_next_chapter_solo" datasource="#SESSION.BDDSOURCE#">
	SELECT chapter_id 
	FROM lms_tpchaptermaster2 ch
	WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	AND ch.chapter_rank > <cfqueryparam cfsqltype="cf_sql_integer" value="#get_chapter_solo.chapter_rank#">
	ORDER BY chapter_rank ASC LIMIT 1
	</cfquery>
	
	<cfquery name="get_prev_chapter_solo" datasource="#SESSION.BDDSOURCE#">
	SELECT chapter_id 
	FROM lms_tpchaptermaster2 ch
	WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	AND ch.chapter_rank < <cfqueryparam cfsqltype="cf_sql_integer" value="#get_chapter_solo.chapter_rank#">
	ORDER BY chapter_rank DESC LIMIT 1
	</cfquery>
<cfelse>
	<cfquery name="get_chapter_solo" datasource="#SESSION.BDDSOURCE#">
	SELECT * 
	FROM lms_tpchaptermaster2 ch
	WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	ORDER BY chapter_rank ASC LIMIT 1
	</cfquery>
	<cfset ch_intro = get_chapter_solo.chapter_id>
</cfif>

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
<cfif isdefined("SESSION.USER_EL_LIST") AND SESSION.USER_EL_LIST neq "">
AND sm.sessionmaster_id IN (#SESSION.USER_EL_LIST#)
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
	<link href="./assets/js/stepper/bs-stepper.css" rel="stylesheet" />

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
      
		<cfset title_page = "e-Learning Essential">  
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
		
			<cfif not isdefined("access_el")>
				<div class="alert alert-warning mt-3" role="alert" align="center">
					<strong><cfoutput>#obj_translater.get_translate('alert_title_no_access_page')#</cfoutput></strong>
					<br>
					<cfoutput>#obj_translater.get_translate('alert_no_access_page')#</cfoutput>
					<br>
					<button class="btn btn-info btn_contact_wefit"><i class="fal fa-unlock"></i> <cfoutput>#obj_translater.get_translate('btn_unlock')#</cfoutput></button>						
				</div>
			<cfelse>
		
			<cfoutput query="get_session_description">
			
			<ul class="nav nav-pills" role="tablist" id="tabs_content">
					
				<li class="nav-item mx-2">
					<a class="nav-link <cfif isdefined("ch_id") AND not isdefined("tab_VOCLIST")>active</cfif>" href="##tab_WORK" role="tab" data-toggle="pill" id="title_WORK">
						<div align="center"><i class="fal fa-laptop fa-2x"></i> <br><strong>Let's go</strong></div>											
					</a>
				</li>
				
				<cfif sessionmaster_video neq "">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_VIDEO" role="tab" data-toggle="pill" id="title_VIDEO">
						<div align="center"><i class="fal fa-video fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_video')#</strong></div>											
					</a>
				</li>
				</cfif>
								
				<cfif sessionmaster_ln_grammar neq "">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_GRAM" role="tab" data-toggle="pill" id="title_GRAM">
						<div align="center"><i class="fal fa-book fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_grammar_points')#</strong></div>												
					</a>
				</li>
				</cfif>
				
				<cfif sessionmaster_ln_vocabulary neq "">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_VOC" role="tab" data-toggle="pill" id="title_VOC">
						<div align="center"><i class="fal fa-comments fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_voc_points')#</strong></div>
					</a>
				</li>
				</cfif>
				
				<cfif voc_cat_id neq "">
				<li class="nav-item mx-2">
					<a class="nav-link <cfif isdefined("tab_VOCLIST")>active</cfif>" href="##tab_VOCLIST" role="tab" data-toggle="pill" id="title_VOC">
						<div align="center"><i class="fal fa-list fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_vocab_list')#</strong></div>
					</a>
				</li>
				</cfif>
				
				<cfif sessionmaster_transcript neq "">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_TRANS" role="tab" data-toggle="pill" id="title_TRANS">
						<div align="center"><i class="fal fa-file-alt fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_transcript')#</strong></div>											
					</a>
				</li>
				</cfif>
				
				<cfif sessionmaster_exercice neq "">
				<li class="nav-item">
					<a class="nav-link" href="##tab_EX" role="tab" data-toggle="pill" id="title_EX">
						<div align="center"><i class="fal fa-edit fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_exercices')#</strong></div>											
					</a>
				</li>
				</cfif>
				
				<cfif get_material.recordcount neq "0">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_DL" role="tab" data-toggle="pill" id="title_DL">
						<div align="center"><i class="fal fa-arrow-down fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_resources')#</strong></div>
					</a>
				</li>
				</cfif>
				
				<cfif get_quiz_unit.recordcount neq "0" OR get_quiz_exercice.recordcount neq "0">
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_QUIZ" role="tab" data-toggle="pill" id="title_QUIZ">
						<div align="center"><i class="fal fal fa-medal fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_practice')#</strong></div>
					</a>
				</li>
				</cfif>
				
				<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_WS" role="tab" data-toggle="pill" id="title_WS">
					<div align="center"><i class="fal fa-file-alt fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_support')#</strong></div>
					</a>
				</li>
				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_WSK" role="tab" data-toggle="pill" id="title_WSK">
					<div align="center"><i class="fal fa-file-alt fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_support')#</strong></div>
					</a>
				</li>
				</cfif>
				
				<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
				<li class="nav-item mx-2">
					<a class="nav-link" href="##tab_K" role="tab" data-toggle="pill" id="title_K">
					<div align="center"><i class="fal fa-file-alt fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_el_keys')#</strong></div>
					</a>
				</li>
				</cfif>
														
			</ul>
		
		
			<div class="row mt-3">
				<div class="col-md-12">
					<div class="card border-top border-info">
						<div class="card-body">
						
						
							<div class="tab-content">

								<div class="tab-pane <cfif isdefined("ch_id") AND not isdefined("tab_VOCLIST")>show active</cfif>" id="tab_WORK" role="tabpanel" id="title_WORK">
									
										<div class="row">
										
											<div class="col-3">
												<div id="stepper4" class="bs-stepper vertical linear">
													<div class="bs-stepper-header bg-light" role="tablist">
													
														<div class="step <cfif isdefined("ch_id") AND ch_id eq "0">text-info</cfif>" data-target="##test-vl-1">
														<a href="_AD_learner_practice2.cfm?sm_id=#sm_id#&ch_id=0" type="button" class="step-trigger p-2 btn-block text-left" style="justify-content:left">
														<span class="bs-stepper-circle <cfif isdefined("ch_id") AND ch_id eq 0>bg-info text-white</cfif>"><i class="fal fa-home"></i></span>
														<span class="bs-stepper-label <cfif isdefined("ch_id") AND ch_id eq 0>text-info</cfif>">Get start</span>
														</a>
														</div>
														
												
														<div class="bs-stepper-line"></div>
														
													<cfloop query="get_chapter_session">
														<div class="step" data-target="##test-vl-1">
														<a href="_AD_learner_practice2.cfm?sm_id=#sm_id#&ch_id=#chapter_id#" type="button" class="step-trigger p-2 btn-block text-left" style="justify-content:left">
														<span class="bs-stepper-circle <cfif isdefined("ch_id") AND ch_id eq chapter_id>bg-info text-white</cfif>"><i class="fal #chapter_icon#"></i></span>
														<span class="bs-stepper-label <cfif isdefined("ch_id") AND ch_id eq chapter_id>text-info</cfif>">#chapter_name#</span>
														</a>
														</div>
												
														<cfif currentrow neq recordcount>
														<div class="bs-stepper-line"></div>
														</cfif>
														
													</cfloop>
														
													</div>
											
												</div>
												
											</div>
											
										<!--- <div class="bs-stepper-content"> --->
											<!--- <form onsubmit="return false"> --->
												<!--- <div id="test-vl-1" role="tabpanel" class="bs-stepper-pane fade active dstepper-block" aria-labelledby="stepper4trigger1"> --->
												<!--- <div class="form-group"> --->
												<!--- <label for="exampleInputEmailV1">Email address</label> --->
												<!--- <input type="email" class="form-control" id="exampleInputEmailV1" placeholder="Enter email"> --->
												<!--- </div> --->
												<!--- <button class="btn btn-primary" onclick="stepper4.next()">Next</button> --->
												<!--- </div> --->
												<!--- <div id="test-vl-2" role="tabpanel" class="bs-stepper-pane fade" aria-labelledby="stepper4trigger2"> --->
												<!--- <div class="form-group"> --->
												<!--- <label for="exampleInputPasswordV1">Password</label> --->
												<!--- <input type="password" class="form-control" id="exampleInputPasswordV1" placeholder="Password"> --->
												<!--- </div> --->
												<!--- <button class="btn btn-primary" onclick="stepper4.previous()">Previous</button> --->
												<!--- <button class="btn btn-primary" onclick="stepper4.next()">Next</button> --->
												<!--- </div> --->
												<!--- <div id="test-vl-3" role="tabpanel" class="bs-stepper-pane fade" aria-labelledby="stepper4trigger3"> --->
												<!--- <button class="btn btn-primary mt-5" onclick="stepper4.previous()">Previous</button> --->
												<!--- <button type="submit" class="btn btn-primary mt-5">Submit</button> --->
												<!--- </div> --->
											<!--- </form> --->
										<!--- </div> --->
									
									
								
							
										<div class="col-9">
											<cfif isdefined("ch_id") AND ch_id eq "0">
											
												<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
												<h6 style="color:##CF223A; font-size:18px" class="my-2">GET START</h6>
												
												<div class="row mt-5">
												
													<div class="col-md-4">
														#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#	
													</div>
													
													<div class="col-md-8">
														<table class="table bg-white table-bordered m-0">
															
															<cfif sessionmaster_el_duration neq "">
															<tr>
																<td width="20%"><i class="fal fa-clock fa-lg text-info"></i> <small>#obj_translater.get_translate('table_th_recommended_time')#</small></td>
																<td>
																	#obj_translater.get_translate('text_about')# #sessionmaster_el_duration# m
																</td>
															</tr>
															</cfif>	
															
															<cfif sessionmaster_description neq "">
															<tr>
																<td width="20%"><i class="fal fa-book fa-lg text-info"></i> <small>#obj_translater.get_translate('table_th_el_description')#</small></td>
																<td>
																	#sessionmaster_description#
																</td>
															</tr>
															</cfif>
															
															<cfif sessionmaster_objectives neq "">
															<tr>
																<td width="20%"><i class="fal fa-book fa-lg text-info"></i> <small>#obj_translater.get_translate('table_th_course_objectives')#</small></td>
																<td>
																	#sessionmaster_objectives#
																</td>
															</tr>
															</cfif>
															
															<cfif sessionmaster_grammar neq "">
															<tr>
																<td width="20%"><i class="fal fa-book fa-lg text-info"></i> <small>#obj_translater.get_translate('table_th_course_grammar')#</small></td>
																<td>
																	#sessionmaster_grammar#
																</td>
															</tr>
															</cfif>
															
															<cfif sessionmaster_vocabulary neq "">
															<tr>
																<td width="20%"><i class="fal fa-book fa-lg text-info"></i> <small>#obj_translater.get_translate('table_th_course_vocabulary')#</small></td>
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
																<td width="20%"><i class="fal fa-key fa-lg text-info"></i> <small>#obj_translater.get_translate('card_keywords')#</small></td>
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
																<td width="20%"><i class="fal fa-bookmark fa-lg text-info"></i> <small>#obj_translater.get_translate('card_grammar')#</small></td>
																<td>
																	<cfloop query="get_grammar"><span class="badge badge-info">#grammar_name#</span> </cfloop>
																</td>
															</tr>
															</cfif>

														</table>
													</div>
													
												</div>
												
												<div align="center" class="mt-5">
													
													<a href="_AD_learner_practice2.cfm?sm_id=#sm_id#&ch_id=#ch_intro#" class="btn btn-info btn-lg">START</a>
												
												</div>									
											
											<cfelse>
											
												<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
												<h6 style="color:##CF223A; font-size:18px" class="my-2">#get_chapter_solo.chapter_header#</h6>
											
												<div class="row mt-5">
												
													<div class="col-12">
												
													<cfif get_chapter_solo.chapter_type eq "discussion">
													<div class="d-flex justify-content-center">
														<div class="border bg-success p-2 m-3">
															<i class="fal fa-3x fa-volume-up text-white"></i>
															<audio controls="controls">
															<source src="./assets/materials/728_Building_Business_Relationships_Describing_Routines_AUDIO1.mp3" type="audio/mp3">
															Votre navigateur n'est pas compatible
															</audio>
														</div>
													</div>
													<cfelseif get_chapter_solo.chapter_type eq "intro">
														<img src="../assets/img_material/#sm_id#.jpg">
													<cfelseif get_chapter_solo.chapter_type eq "exercice">
														<iframe  scrolling="no" src="#SESSION.BO_ROOT_URL#/quiz_content.cfm?quiz_id=#get_chapter_solo.quiz_id#&new_quiz=1" width="100%" height="500" style="border:0px"></iframe>
													<cfelseif get_chapter_solo.chapter_type eq "video">
														<video class="mt-0" width="70%" controls poster="
														<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
														./assets/img_material/#sessionmaster_code#.jpg
														<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
														./assets/img_material/#sm_id#.jpg
														<cfelse>
														./assets/img/wefit_lesson.jpg
														</cfif>">
														<source src="./assets/materials/at-a-hotel_VIDEO1.mp4" type="video/mp4">
														Your browser does not support the video tag or the file format of this video.
														</video>
													</cfif>
												
										<cfset chapter_content = get_chapter_solo.chapter_content>
								
										<cfloop query="get_glossary">
										<cfset transform_string = "<span class='badge badge-pill badge-primary'><a href='' style='font-weight:bold;cursor:pointer; color:##FFFFFF' class='btn_voc' id='voc_#get_glossary.voc_id#'>#get_glossary.voc_word_en#</a></span>">
										<cfset chapter_content = replacenocase(chapter_content,get_glossary.voc_word_en,transform_string,"ALL")>
										</cfloop>
													#chapter_content#
														
														<div class="w-100 d-flex justify-content-center mt-5">
															<cfif get_prev_chapter_solo.recordcount neq "0" AND get_chapter_solo.chapter_type neq "exercice">
															<a href="_AD_learner_practice2.cfm?sm_id=#sm_id#&ch_id=#get_prev_chapter_solo.chapter_id#" class="btn btn-info btn-lg text-white"><i class="fal fa-backward"></i> PREV</a>
															<cfelse>
															<a href="##" class="btn btn-info btn-lg text-white" disabled><i class="fal fa-backward"></i> PREV</a>
															</cfif>
															
															<cfif get_next_chapter_solo.recordcount neq "0" AND get_chapter_solo.chapter_type neq "exercice">
															<a href="_AD_learner_practice2.cfm?sm_id=#sm_id#&ch_id=#get_next_chapter_solo.chapter_id#" class="btn btn-info btn-lg text-white"><i class="fal fa-forward"></i> NEXT</a>
															<cfelse>
															<a href="##" class="btn btn-info btn-lg text-white" disabled><i class="fal fa-forward"></i> NEXT</a>
															</cfif>
														</div>
													
													</div>
													
												</div>
													
											</cfif>										
										</div>
									</div>
								</div>
								
								
								<cfif sessionmaster_video neq "">
								<div class="tab-pane" id="tab_VIDEO" role="tabpanel" id="title_VIDEO">
									<div class="row mt-2">
										<div class="col-md-12">
											<div align="center">
											#sessionmaster_video#
											</div>
										</div>
									</div>				
								</div>
								</cfif>
								
								<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
								<div class="tab-pane" id="tab_WS" role="tabpanel" id="title_WS">
									<div class="row mt-2">
										<div class="col-md-12">
											<iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WS"></iframe>
										</div>
									</div>								
								</div>
								<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
								<div class="tab-pane" id="tab_WSK" role="tabpanel" id="title_WSK">
								
									<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
									<h6 style="color:##CF223A; font-size:18px" class="my-2">#obj_translater.get_translate('btn_el_support')#</h6>
										
									<div class="row mt-5">
										
										<div class="col-md-3">
											<div class="card shadow border-0 h-100">
											
												<img class="card-img-top" width="100%" src="../assets/img_material/#sm_id#.jpg">
												<div class="card-body p-3 d-flex flex-column bg-light">
												
													<h4 class="mt-0">#sessionmaster_name#</h4>
													<p class="card-text">
													Support de cours au format PDF utilisable en VISIO CONFÉRENCE avec un Trainer WEFIT
													<br>
													<div class="m-2 p-2 mt-auto" align="center">
														<button type="button" href="##" class="btn btn-sm btn-info">Télécharger</button>
													</div>
												
												</div>
											</div>
										</div>
										
										<div class="col-md-3">
											<div class="card shadow border-0 h-100">
											
												<img class="card-img-top" width="100%" src="../assets/img_material/#sm_id#.jpg">
												<div class="card-body p-3 d-flex flex-column bg-light">
												
													<h4 class="mt-0">#sessionmaster_name#</h4>
													<p class="card-text">
													Support de cours au format PDF comprenant les réponses aux exercices
													<br>
													<div class="m-2 p-2 mt-auto" align="center">
														<button type="button" href="##" class="btn btn-sm btn-info">Télécharger</button>
													</div>
												
												</div>
											</div>
										</div>
										
										<cfif voc_cat_id neq "">
								
										<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
										SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (#voc_cat_id#) ORDER BY voc_cat_name
										</cfquery>
										
										<cfloop query="get_category">
										<div class="col-md-3">
											<div class="card shadow border-0 h-100">
											
												<img class="card-img-top" width="100%" src="../assets/img_material/c809bb46588e69099e513f36277cba3e.jpg">
												<div class="card-body p-3 d-flex flex-column bg-light">
												
													<h4 class="mt-0">#voc_cat_name#</h4>
													<p class="card-text">
													Liste de vocabulaire
													<br>
													<div class="m-2 p-2 mt-auto" align="center">
														<button type="button" href="##" class="btn btn-sm btn-info">Télécharger</button>
													</div>
												
												</div>
											</div>
										</div>
										</cfloop>
										
										</cfif>
										
										
										
										<!--- <div class="col-md-12"> --->
										<!--- <iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WSK"></iframe> --->
										<!--- </div> --->
									</div>
									
								</div>
								</cfif>
								
								<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
								<div class="tab-pane" id="tab_K" role="tabpanel" id="title_K">
									<div class="row mt-2">
										<div class="col-md-12">
										<iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=K"></iframe>
										</div>
									</div>
								</div>
								</cfif>
								
								<cfif voc_cat_id neq "">
								
								<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
								SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (#voc_cat_id#) ORDER BY voc_cat_name
								</cfquery>
												
								<div class="tab-pane <cfif isdefined("tab_VOCLIST")>show active</cfif>" id="tab_VOCLIST" role="tabpanel" id="title_VOCLIST">
								
									<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
									<h6 style="color:##CF223A; font-size:18px" class="my-2">#obj_translater.get_translate('btn_el_vocab_list')#</h6>
									
									
									<div class="row mt-5">
										<div class="col-md-12">
																				
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
											<a target="_blank" href="./tpl/vocablist_container.cfm?voc_cat_id=#voc_cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-sm btn-primary float-right"><i class="fal fa-file-pdf btn_export_list" id="export_#voc_cat_id#"></i> #obj_translater.get_translate('btn_export')#</a>
											
											
											<div class="table-responsive">
											<table class="table">
												<tr class="bg-light">
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
													<th width="20%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th>
													</cfif>
													</cfloop>
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
														<cfif evaluate('voc_word_#lang_select#') neq ""><strong>#evaluate('voc_word_#lang_select#')#<cfelse><em>Comming soon</em></cfif></strong>
													</td>
													<td bgcolor="###td_color#">
														<cfif evaluate('voc_type_name_#lang_select#') neq "">#evaluate('voc_type_name_#lang_select#')#<cfelse><em>Comming soon</em></cfif>
													</td>
													<td bgcolor="###td_color#">
														<cfif evaluate('voc_desc_#lang_select#') neq "">#evaluate('voc_desc_#lang_select#')#<cfelse><em>Comming soon</em></cfif>
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
													<td bgcolor="###td_color#">
														#evaluate('voc_desc_#cor#')#
													</td>
													</cfif>
													</cfloop>
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
								</cfif>
								
								<cfif sessionmaster_ln_grammar neq "">
								<div class="tab-pane" id="tab_GRAM" role="tabpanel" id="title_GRAM">
									
									<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
									<h6 style="color:##CF223A; font-size:18px" class="my-2">#obj_translater.get_translate('btn_el_grammar_points')#</h6>
									
									<div class="row mt-5">
										<div class="col-md-12">									
										#sessionmaster_ln_grammar#
										</div>
									</div>
								
								</div>
								</cfif>
								
								<cfif sessionmaster_ln_vocabulary neq "">
								<div class="tab-pane" id="tab_VOC" role="tabpanel" id="title_VOC">
								
									<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
									<h6 style="color:##CF223A; font-size:18px" class="my-2">#obj_translater.get_translate('btn_el_voc_points')#</h6>
									
									<div class="row mt-5">
										<div class="col-md-12">
										#sessionmaster_ln_vocabulary#
										</div>
									</div>
																		
								</div>
								</cfif>
								
								<cfif sessionmaster_exercice neq "">
								<div class="tab-pane" id="tab_EX" role="tabpanel" id="title_EX">
								
									<div class="row mt-2">
										<div class="col-md-12">
										#sessionmaster_exercice#
										</div>
									</div>
																		
								</div>
								</cfif>
								
								<cfif sessionmaster_transcript neq "">
								<div class="tab-pane" id="tab_TRANS" role="tabpanel" id="title_TRANS">
								
									<div class="row mt-2">
										<div class="col-md-12">
										#sessionmaster_transcript#
										</div>
									</div>
																		
								</div>
								</cfif>
								
								<cfif get_material.recordcount neq "0">
								<div class="tab-pane" id="tab_DL" role="tabpanel" id="title_DL">
									
									<div class="row mt-5">
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
											<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.pdf" target="_blank" class="btn btn-info"><i class="fal fa-file-pdf"></i></a></td>
											<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg")>
											<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg" target="_blank">#material_name#</a></td>
											<td>#material_description#</td>
											<td><a href="/assets/materials/#get_session_description.sessionmaster_ressource#_#material_id#.jpg" target="_blank" class="btn btn-info"><i class="fal fa-file-image"></i></a></td>
											</cfif>		
											</tr>	
											</cfloop>
										</table>
										</div>
									</div>
																		
								</div>
								</cfif>
																		
								<cfif get_quiz_unit.recordcount neq "0" OR get_quiz_exercice.recordcount neq "0">
								<div class="tab-pane" id="tab_QUIZ" role="tabpanel" id="title_QUIZ">
								
									<h3 class="my-0 font-weight-bold">#ucase(sessionmaster_name)#</h3>
									<h6 style="color:##CF223A; font-size:18px" class="my-2">#obj_translater.get_translate('btn_el_practice')#</h6>
									
									<div class="row mt-5">
											
										<cfif get_quiz_exercice.recordcount neq "0">
										<div class="col-md-6">
											<h6 class="text-info" align="center">#obj_translater.get_translate('table_th_training_exercices')#</h6>
											
											<cfloop query="get_quiz_exercice">
												<cfquery name="get_result_exercice" datasource="#SESSION.BDDSOURCE#">
												SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
												</cfquery>
												
												<div class="border-top bg-light mt-3 p-2">
													<div class="media">
														<img src="./assets/img/wefit_lesson.jpg" width="120" class="align-self-center mr-3">
														<div class="media-body">
															<h6 class="mt-1">#quiz_name#</h6>
															<em><small>#quiz_description#</small></em>
															<div class="clearfix"></div>
															<div class="float-right">											
																<cfif get_result_exercice.recordcount eq "0">																			
																	<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																<cfelse>
																	<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fal fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																	<cfif get_result_exercice.recordcount neq "0" AND get_result_exercice.quiz_user_end neq "">
																		<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quiz_#get_result_exercice.quiz_user_id#"><i class="fal fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																	</cfif>																		
																</cfif>
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
														<img src="./assets/img/wefit_lesson.jpg" width="120" class="align-self-center mr-3">
														<div class="media-body">
															<h6 class="mt-1">#quiz_name#</h6>
															<em><small>#quiz_description#</small></em>
															<div class="clearfix"></div>
															<div class="float-right">
																<cfif get_result_unit.recordcount eq "0">
																	<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
																<cfelse>
																	<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fal fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
																	<cfif get_result_unit.recordcount neq "0" AND get_result_unit.quiz_user_end neq "">
																		<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quiz_#get_result_unit.quiz_user_id#"><i class="fal fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
																	</cfif>
																</cfif>
															</div>
														</div>
													</div>
												</div>
											</cfloop>
											
										</div>
										</cfif>
									</div>
								</div>
								</cfif>
								
							</div>
							
						</div>
					</div>
				</div>
			</div>
		
			</cfoutput>
		
			</cfif>
			
		</div>
	
	</div>
	  
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script src="./assets/js/stepper/bs-stepper.min.js"></script>

<script>
$(document).ready(function() {

	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	

		<cfoutput>
		if(confirm('#encodeForJavaScript(trim(obj_translater.get_translate_complex('js_restart_quiz_confirm')))#')){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		</cfoutput>
	

	})
	
	
	$('.lang_translate').click(function(event) {	

		var lang_translate = [];
		if($('#lang_en').is(":checked")){lang_translate.push("en")}
		if($('#lang_fr').is(":checked")){lang_translate.push("fr")}
		if($('#lang_de').is(":checked")){lang_translate.push("de")}

		<cfoutput>
		document.location.href="_AD_learner_practice2.cfm?sm_id=#sm_id#&lang_translate="+lang_translate+"&tab_VOCLIST=1";
		</cfoutput>
		
	});
	
	<!--- $('.btn_export_list').click(function(event) {	 --->

		<!--- event.preventDefault(); --->
		<!--- var idtemp = $(this).attr("id"); --->
		<!--- var idtemp = idtemp.split("_"); --->
		<!--- var voc_cat_id = idtemp[1];	 --->
		

		
	<!--- }); --->
	
	
	$('.btn_voc').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var voc_id = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Vocab list");
		$('#modal_body_lg').load("modal_window_word.cfm?voc_id="+voc_id, function() {});
	

	})
	
	
	
})
</script>


</body>
</html>


