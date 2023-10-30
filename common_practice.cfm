<!DOCTYPE html>

<cfsilent>

<!--- <cfset secure = "2,3,4,5,7,8,9,12">
<cfinclude template="./incl/incl_secure.cfm">	 --->

<cfif isdefined("SESSION.ACCESS_EL") AND listlen(SESSION.LIST_ACCESS_EL) gte "1">
<cfparam name="f_id" default="#listgetat(SESSION.LIST_ACCESS_EL,1)#">
<cfelse>
<cfparam name="f_id" default="3">
</cfif>

<cfswitch expression="#f_id#">
<cfcase value="1"><cfset lang_temp = "fr"></cfcase>
<cfcase value="2"><cfset lang_temp = "en"></cfcase>
<cfcase value="3"><cfset lang_temp = "de"></cfcase>
<cfcase value="4"><cfset lang_temp = "es"></cfcase>
<cfcase value="5"><cfset lang_temp = "it"></cfcase>
</cfswitch>

<cfparam name="subm" default="el_active">
<cfparam name="display_type" default="el">

<cfif subm eq "el_ressource">
	<cfparam name="lev_id" default="A">
</cfif>

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

<cfif isdefined("SESSION.ACCESS_EL")>		
	
<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.*, tm.module_name, (SELECT COUNT(quiz_id) as quiz_id FROM lms_quiz WHERE sessionmaster_id = sm.sessionmaster_id) AS quiz_id,
ue.sm_elapsed, ue.sm_lastview
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
LEFT JOIN user_elapsed ue ON ue.sm_id = sm.sessionmaster_id	AND ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
AND tp.tpmaster_prebuilt = 0

AND (sm.sessionmaster_online_el = 1 OR sm.sessionmaster_online_visio = 1)

<cfif subm eq "el_active">	
	<cfif isdefined("SESSION.USER_EL_LIST") AND SESSION.USER_EL_LIST neq "">
	AND sm.sessionmaster_id IN (#SESSION.USER_EL_LIST#)
	<cfelse>
	AND 1 = 2
	</cfif>	
<cfelseif subm eq "el_ressource">
	AND tp.tpmaster_level like '%#lev_id#%'	
</cfif>

GROUP BY sm.sessionmaster_id
ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
</cfquery>

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE <cfif listlen(SESSION.LIST_ACCESS_EL) gte "1">formation_id IN (#SESSION.LIST_ACCESS_EL#)<cfelse>formation_id <= 5</cfif>
</cfquery>	

<cfset __text_about = obj_translater.get_translate('text_about')>
<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>

<cfset __tooltip_time_elapsed = obj_translater.get_translate('tooltip_time_elapsed')>
<cfset __tooltip_last_connect = obj_translater.get_translate('tooltip_last_connect')>
<cfset __tooltip_score_quiz = obj_translater.get_translate('tooltip_score_quiz')>
<cfset __tooltip_remove_elearning = obj_translater.get_translate('tooltip_remove_elearning')>

<cfset __card_keywords = obj_translater.get_translate('card_keywords')>
<cfset __card_grammar = obj_translater.get_translate('card_grammar')>
<cfset __card_activity = obj_translater.get_translate('card_activity')>

<cfset __btn_more_info = obj_translater.get_translate('btn_more_info')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_continue = obj_translater.get_translate('btn_continue')>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id <> "2"
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

</cfif>
									
</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
h1,h2,h3,h4,h5,h6{
	font-family: 'Titillium Web', sans-serif;
}
</style>


<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "e-Learning Essential">
		<cfset help_page = "help_el">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<!--- <cfinclude template="./incl/incl_nav_el_temp.cfm"> --->

					
			<cfif isdefined("SESSION.ACCESS_EL")>	
			
			<cfif SESSION.USER_PROFILE eq "TM" OR SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "GUEST">
			
			<cfquery name="get_quizzes" datasource="#SESSION.BDDSOURCE#">
			SELECT COUNT(quiz_user_id) as nb FROM lms_quiz_user qu
			INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
			WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			AND (q.quiz_type = "unit" OR q.quiz_type = "exercice")
			</cfquery>

			<cfquery name="get_mock_tests" datasource="#SESSION.BDDSOURCE#">
			SELECT COUNT(quiz_user_id) as nb FROM lms_quiz_user qu
			INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
			WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			AND (q.quiz_type like "%bright%" OR q.quiz_type like "%toeic%")
			</cfquery>
			
			<div class="row">
				<div class="col-md-12">
					
					

					<div class="card border">
						<div class="card-body">

							<div class="w-100">
								<h5 class="d-inline"><i class="fa-thin fa-phone-laptop fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_activity')#</cfoutput></h5>
								<hr class="border-dark mb-3 mt-2">
							</div>
						
										
							<table class="table table-sm bg-white m-0 mt-2">
								
								<cfoutput>
								<tr>
									<td width="15%"><i class="fas fa-history"></i> <small><cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput></small></td>
								
									<td>
										<cfif isdefined("SESSION.ACCESS_EL")>
											<cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
											#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#
											<cfelse>
											-
											</cfif>
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
								<tr>
									<td><i class="far fa-clock"></i> <small><cfoutput>#obj_translater.get_translate('table_th_e_program')#</cfoutput></small></td>
								
									<td>
										<cfif isdefined("SESSION.ACCESS_EL")>
											<cfif listlen(SESSION.USER_EL_LIST) eq ""> 
											-
											<cfelse>
												<cfoutput>
												<cfif listlen(SESSION.USER_EL_LIST) gt "1">
													#listlen(SESSION.USER_EL_LIST)# lessons
												<cfelse>
													#listlen(SESSION.USER_EL_LIST)# lesson
												</cfif>
												</cfoutput>
											</cfif>
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
								
								<tr>
									<td><i class="fa fa-tasks"></i> <small><cfoutput>#obj_translater.get_translate('table_th_quizzes')#</cfoutput></small></td>
								
									<td>
										<cfif isdefined("SESSION.ACCESS_EL")>
											<cfif get_quizzes.nb eq "0">
											-
											<cfelse>
												<cfif get_quizzes.nb gt "1">
													#get_quizzes.nb# quizzes
												<cfelse>
													#get_quizzes.nb# quiz
												</cfif>
											</cfif>
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
								
								<tr>
									<td><i class="fas fa-medal" aria-hidden="true"></i> <small><cfoutput>#obj_translater.get_translate('table_th_mock_tests')#</cfoutput></small></td>
								
									<td>
										<cfif isdefined("SESSION.ACCESS_EL")>
											<cfif get_mock_tests.nb eq "0">
											-
											<cfelse>
												<cfif get_mock_tests.nb gt "1">
													#get_mock_tests.nb# tests
												<cfelse>
													#get_mock_tests.nb# test
												</cfif>
											</cfif>
										<cfelse>
										-
										</cfif>
									</td>
								</tr>
								
								</cfoutput>
							</table>
					
						</div>
					</div>
				</div>
			</div>
			
			</cfif>
			<div class="row">
				<div class="col-md-12">
					<!---<h5 class="d-inline mr-4"><cfoutput>#obj_translater.get_translate('card_media_library')#</cfoutput> : </h5>--->
					<cfoutput>			
					<a class="btn <cfif subm eq "el_active">btn-primary active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?subm=el_active&f_id=#f_id#"><i class="far fa-folder-open"></i> <br>#obj_translater.get_translate('btn_my_e_program')#</a></a>
					<a class="btn <cfif isdefined("lev_id") AND lev_id eq "A">btn-A2 active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?subm=el_ressource&f_id=#f_id#&lev_id=A">#obj_translater.get_translate('level')# A<br>(#obj_translater.get_translate('l_beginner')# )</a>
					<a class="btn <cfif isdefined("lev_id") AND lev_id eq "B1">btn-B1 active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?subm=el_ressource&f_id=#f_id#&lev_id=B1">#obj_translater.get_translate('level')# B1<br>(#obj_translater.get_translate('l_preintermediate')# )</a>
					<a class="btn <cfif isdefined("lev_id") AND lev_id eq "B2">btn-B2 active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?subm=el_ressource&f_id=#f_id#&lev_id=B2">#obj_translater.get_translate('level')# B2<br>(#obj_translater.get_translate('l_intermediate')# )</a>
					<a class="btn <cfif isdefined("lev_id") AND lev_id eq "C">btn-C1 active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?subm=el_ressource&f_id=#f_id#&lev_id=C">#obj_translater.get_translate('level')# C<br>(#obj_translater.get_translate('l_advanced')# )</a>
					
					<!--- <a href="##" class="btn btn-outline-warning btn_view_tuto" type="button">
						<i class="fal fa-hands-helping fa-lg"></i><br><cfoutput>#ucase(obj_translater.get_translate('btn_help'))#</cfoutput>
					</a> --->
					
					<!--- <a class="btn <cfif lev_id eq "search">btn-warning active<cfelse>btn-link</cfif>" type="button" href="common_practice.cfm?f_id=#f_id#&lev_id=search"><i class="fas fa-search"></i> <br>Recherche</a> --->
					</cfoutput>
					
					<div class="pull-right">			
					<select class="form-control" onChange="document.location.href='common_practice.cfm?f_id='+$(this).val()">
					<cfoutput query="get_formation">
					<cfif formation_id eq "3">
					<option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
					</cfif>
					</cfoutput>
					<select>
					</div>
					
				</div>
			</div>
			</cfif>
							
			<div class="row">
				<div class="col-md-12">
					
					<div class="card border-top border-success">
						<div class="card-body">

							
									
							<div class="row">
						
								<div class="col-md-12">
									
							<cfif subm eq "el_active">
								
								<cfif not isdefined("SESSION.ACCESS_EL")>
								<div class="row">
									<div class="col-xl-10">
										<h5 class="d-inline mr-4"><cfoutput>#obj_translater.get_translate('sidemenu_learner_myeprogram')#</cfoutput></h5>
									</div>
								</div>
			
									<div class="alert alert-success mt-3" role="alert" align="center">
										<strong><cfoutput>#obj_translater.get_translate('alert_title_no_access_page')#</cfoutput></strong>
										<br>
										<cfoutput>#obj_translater.get_translate('alert_no_access_page')#</cfoutput>
										<br>
										<button class="btn btn-secondary btn_contact_wefit"><i class="fas fa-unlock"></i> <cfoutput>#obj_translater.get_translate('btn_unlock')#</cfoutput></button>						
									</div>
								<cfelse>
									<cfif not isdefined("SESSION.USER_EL_LIST") OR listlen("SESSION.USER_EL_LIST") eq "0" OR SESSION.USER_EL_LIST eq "">
									
									<div class="alert bg-dark mt-3" role="alert">
										<div class="media">
											<i class="fal fa-folder-open fa-3x mr-3"></i>
											<div class="media-body">
												<strong><cfoutput>#obj_translater.get_translate('alert_title_elearning')#</cfoutput></strong>
												<br>
												<cfoutput>#obj_translater.get_translate('alert_body_elearning')#</cfoutput>
												<br>
												<br>
												<div align="center">
												<a href="#" role="button" class="btn btn-success btn_edit_needs"><cfoutput>#obj_translater.get_translate('btn_build_tp')#</cfoutput></a>
												</div>		
											</div>
										</div>								
									</div>
									<cfelse>
												
										<cfoutput query="get_session_access">
										
										<cfif tpmaster_biglevel eq "A">
											<cfset id_acc = "A">
											<cfset css = "A2">
										<cfelseif tpmaster_biglevel eq "A1">
											<cfset id_acc = "A1">
											<cfset css = "A1">
										<cfelseif tpmaster_biglevel eq "A2">
											<cfset id_acc = "A2">
											<cfset css = "A2">
										<cfelseif tpmaster_biglevel eq "B1">
											<cfset id_acc = "B1">
											<cfset css = "B1">
										<cfelseif tpmaster_biglevel eq "B2">
											<cfset id_acc = "B2">
											<cfset css = "B2">
										<cfelseif tpmaster_biglevel eq "C">
											<cfset id_acc = "C">
											<cfset css = "C1">
										</cfif>
								
											<div class="container-fluid border mb-3 bg-light">
											
												<div class="row" style="background-color:##ECECEC">
													<div class="col-md-11 p-1" align="center">				
														<cfif module_name neq "">#module_name#<cfelse>VARIETY</cfif>
													</div>
													<div class="col-md-1 p-1 pull-right">
														<a href="##" class="btn btn-sm btn-secondary pull-right p-0 m-0 btn_el_session_del" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_remove_elearning#" style="border:1px solid ##000; min-width:20px !important"><i class="fas fa-times"></i></a>
													</div>
												</div>
												
												<div class="row p-2">
													<div class="col-md-1" align="center">
														#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="120")#
														<br>
														<h6 style="font-size:16px"><span class="badge badge-#css#">#tpmaster_level#</span></h6>
													</div>
													<div class="col-md-2">
														<cfif sessionmaster_support_bool eq "1">
															<i class="m-2 fas fa-book text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>																	
														</cfif>
														<cfif sessionmaster_audio_bool eq "1">
															<i class="m-2 fas fa-volume-up text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>																		
														</cfif>
														<cfif sessionmaster_video_bool eq "1">
															<i class="m-2 fas fa-video text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>																		
														</cfif>
														<cfif quiz_id neq "" AND quiz_id neq "0">
															<i class="m-2 fas fa-tasks text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>													
														</cfif>
													</div>
													<div class="col-md-5">
													
														<strong>#sessionmaster_name#</strong> 
														<br>
														<span class="btn_view_session" id="sm_#sessionmaster_id#">
														<small style="cursor:pointer"><strong>[#__btn_more_info#]</strong></small>
														</span>
														<br>
																														

														<cfif keyword_id neq "">
														<br>
														<small>#__card_keywords# :</small>
														<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
														SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
														</cfquery>
														<cfloop query="get_keyword"><span class="badge border <cfif isdefined("SESSION.INTEREST_ID") AND listfind(SESSION.INTEREST_ID,get_keyword.keyword_id)>badge-#css#</cfif>"><cfif isdefined("SESSION.INTEREST_ID") AND listfind(SESSION.INTEREST_ID,get_keyword.keyword_id)><i class="fas fa-exclamation-triangle text-warning"></i> </cfif>#keyword_name#</span> </cfloop>
														</cfif>


														<cfif grammar_id neq "">
														<br>
														<small>#__card_grammar# :</small>
														<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
														SELECT grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#)
														</cfquery>
														<cfloop query="get_grammar"><span class="badge border">#grammar_name#</span> </cfloop>
														</cfif>	
														
													</div>
													<div class="col-md-2">
														<table class="table table-sm bg-white table-bordered m-0">
															<tr>
																<td colspan="2" class="p-0" align="center">#__card_activity#</td>
															</tr>
															<tr>
																<td width="10"><i class="far fa-clock" data-toggle="tooltip" data-placement="top" title="#__tooltip_time_elapsed#"></i></td>
																<td>
																	<small><cfif sm_elapsed neq "">#obj_lms.get_format_hms(toformat="#sm_elapsed#")#<cfelse>-</cfif></small>
																</td>
															</tr>
															<tr>
																<td width="10"><i class="fas fa-user-clock" data-toggle="tooltip" data-placement="top" title="#__tooltip_last_connect#"></i></td>
																<td>
																	<small><cfif sm_lastview neq "">#dateformat(sm_lastview,'dd/mm/yyyy')#<cfelse>-</cfif></small>
																</td>
															</tr>
															
															<cfif quiz_id neq "">
																		
																<cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
																SELECT q.quiz_id, q.quiz_name, qu.quiz_user_id
																FROM lms_quiz q														
																INNER JOIN lms_quiz_user qu ON q.quiz_id = qu.quiz_id
																WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">
																</cfquery>
																
																<cfif get_result_unit.recordcount neq "0">
																													
																	<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
																	SELECT SUM(ans_gain) as score
																	FROM lms_quiz_result
																	WHERE quiz_user_id = #get_result_unit.quiz_user_id#
																	</cfquery>
																																	
																	<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
																	SELECT SUM(ans_gain) as quiz_score
																	FROM lms_quiz_answer a 
																	INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
																	INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
																	WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_unit.quiz_id#">
																	</cfquery>
																	
																	<cfif get_result_score.score neq "">
																		<cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
																	<cfelse>
																		<cfset global_note = "0">
																	</cfif>

																	<cfif global_note gte 80>
																		<cfset cssgo = "success">
																	<cfelseif global_note gt 20 AND global_note lt 80>
																		<cfset cssgo = "warning">
																	<cfelseif global_note lte 20>
																		<cfset cssgo = "danger">
																	</cfif>
																	
																	<tr>
																		<td width="10"><i class="fas fa-tasks" data-toggle="tooltip" data-placement="top" title="#__tooltip_score_quiz#"></i></td>
																		<td>
																		<span class="badge badge-pill badge-#cssgo# text-white">#global_note# %</span>
																		</td>
																	</tr>
																	
																<cfelse>
																
																	<tr>
																		<td width="10"><i class="fas fa-tasks" title="Score Quiz"></i></td>
																		<td>
																		<small>-</small>
																		</td>
																	</tr>

																</cfif>		

															</cfif>														
														
															
														</table>
													</div>		
													<div class="col-md-2 align-self-end">
														<cfif sm_elapsed eq "" AND sm_lastview eq "">
														<a class="btn pull-right btn-sm btn-outline-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"><i class="fas fa-play"></i><br>#__btn_start#</a>
														<cfelse>
														<a class="btn pull-right btn-sm btn-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"><i class="fas fa-play"></i><br>#__btn_continue#</a>
														</cfif>
													</div>
												</div>
												
											</div>
											
										</cfoutput>			
										
									</cfif>
								</cfif>
								
							<cfelseif subm eq "el_ressource">
							
								<cfif not isdefined("SESSION.ACCESS_EL")>
									<div class="alert alert-success mt-3" role="alert" align="center">
										<strong><cfoutput>#obj_translater.get_translate('alert_title_no_access_page')#</cfoutput></strong>
										<br>
										<cfoutput>#obj_translater.get_translate('alert_no_access_page')#</cfoutput>
										<br>
										<button class="btn btn-secondary btn_contact_wefit"><i class="fas fa-unlock"></i> <cfoutput>#obj_translater.get_translate('btn_unlock')#</cfoutput></button>						
									</div>
								<cfelse>
								
									<cfif get_session_access.recordcount eq "0">
									
										<div class="alert alert-info mt-3" role="alert">
											<div class="media">
												<i class="fas fa-laptop fa-3x mr-3"></i>
												<div class="media-body">
													
													<cfoutput>#obj_translater.get_translate_complex('no_access_library')#</cfoutput>

												</div>
											</div>						
										</div>
										
									<cfelse>
									
									<div class="row">
									
										<div class="col-md-2">
										<cfset counter = 0>
										<cfoutput query="get_session_access" group="tpmaster_biglevel">
											
											<cfif tpmaster_biglevel eq "A">
												<cfset id_acc = "A">
												<cfset css = "A2">
											<cfelseif tpmaster_biglevel eq "A1">
												<cfset id_acc = "A1">
												<cfset css = "A1">
											<cfelseif tpmaster_biglevel eq "A2">
												<cfset id_acc = "A2">
												<cfset css = "A2">
											<cfelseif tpmaster_biglevel eq "B1">
												<cfset id_acc = "B1">
												<cfset css = "B1">
											<cfelseif tpmaster_biglevel eq "B2">
												<cfset id_acc = "B2">
												<cfset css = "B2">
											<cfelseif tpmaster_biglevel eq "C">
												<cfset id_acc = "C">
												<cfset css = "C1">
											</cfif>
											
											<cfoutput group="tpmaster_id">
											<cfset counter++>
											
												<button class="btn btn-outline-#css# btn-submenu btn-block <cfif counter eq "1">active collapsed</cfif>" data-toggle="collapse" data-target="##tp_#tpmaster_id#" aria-expanded="true" style="text-align:center">
												<span class="badge" style="font-size:12px">#tpmaster_level#</span><br>#tpmaster_name# 
												</button>
												
											</cfoutput>										
												
										</cfoutput>

										</div>
										
										<div class="col-md-10">
										
											<cfset counter = 0>
											<cfoutput query="get_session_access" group="tpmaster_biglevel">
											
												<div class="collapse show" id="collapse_#id_acc#">
																					
												<cfoutput group="tpmaster_id">
												<cfset counter++>
													
													<div id="tp_#tpmaster_id#" class="collapse <cfif counter eq "1">show</cfif>" data-parent="##collapse_#id_acc#">
														
														<cfoutput group="module_id">												
														<div class="border mb-3 bg-light">
															<div class="card-body">
																<div class="card-title"><strong><cfif module_id neq "">#ucase(module_name)#<cfelse>VARIETY</cfif></strong></div>
														
																<!---<div class="table table-responsive mt-2" style="margin-bottom:0px !important">--->
																<table class="table bg-white mt-2" style="margin-bottom:0px !important">
																<cfoutput>
																<tr>	
																	<td class="d-none d-lg-table-cell" width="120">
																	#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="120")#
																	</td>
																	<td width="2%">
																		<cfif sessionmaster_support_bool eq "1">
																		<i class="fas fa-book text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif sessionmaster_audio_bool eq "1">
																		<i class="fas fa-volume-up text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif sessionmaster_video_bool eq "1">
																		<i class="fas fa-video text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif quiz_id neq "">
																		<i class="fas fa-tasks text-#css#" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
																		</cfif>
																	</td>
																	<td width="20%" class="sessionmaster_title">
																		#sessionmaster_name#
																		<br>
																		<span class="btn_view_session" id="sm_#sessionmaster_id#">
																		<small style="cursor:pointer;" class="text-red"><strong>[#__btn_more_info#]</strong></small>
																		</span>
																	</td>
																	
																	<!---<td>
																		<cfif sessionmaster_rank neq "">
																		<span class="badge">#__lesson# #sessionmaster_rank#</span>
																		</cfif>
																	</td>--->
																	<!---<td width="5%">
																		<small>#__text_about# #sessionmaster_duration# m</small>
																	</td>--->
																	<td>
																		<span style="font-size:12px">#mid(sessionmaster_description,1,90)# [...]</span>
																		
																		<cfif keyword_id neq "">
																		<br>
																		<small>#__card_keywords# :</small>
																		<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
																		SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
																		</cfquery>
																		<cfloop query="get_keyword"><span class="badge badge-info" <cfif isdefined("k_id") AND get_keyword.keyword_id eq k_id>style="background-color:##FF0000"</cfif>>#keyword_name#</span> </cfloop>
																		</cfif>


																		<cfif grammar_id neq "">
																		<br>
																		<small>#__card_grammar# :</small>
																		<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
																		SELECT grammar_id, grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#)
																		</cfquery>
																		<cfloop query="get_grammar"><span class="badge badge-info" <cfif isdefined("g_id") AND get_grammar.grammar_id eq g_id>style="background-color:##FF0000"</cfif>>#grammar_name#</span> </cfloop>
																		</cfif>	
																	</td>
																	<!---<td width="15%">
																		
																		<a class="btn btn-sm btn-outline-#css# btn_view_session" id="sm_#sessionmaster_id#" href="##"<!--- data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"--->><i class="fas fa-eye"></i> Details</a>
																		<!---<a class="btn btn-sm btn-outline-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"<!--- data-toggle="tooltip" data-placement="top" title="WeLearning"--->><i class="fas fa-laptop"></i> WeLearning</a>--->
																		
																	</td>--->
																	<td width="5%">
																		<!---<cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sessionmaster_id#)>
																		<div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="Envoyer vers Mes favoris"><i class="fas fa-heart fa-lg red"></i></div>
																		<cfelse>
																		<div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="Envoyer vers Mes favoris"><i class="far fa-heart fa-lg grey"></i></div>
																		</cfif>--->
																		<cfif isdefined("SESSION.USER_EL_LIST") AND listfind(SESSION.USER_EL_LIST,#sessionmaster_id#)>
																		<a class="btn btn-sm btn-primary pull-right btn_el_session" id="sm_#sessionmaster_id#" <!---data-toggle="tooltip" data-placement="top" title="Remove from e-Program"---> href="##"><i class="far fa-thumbs-up"></i> <br>E-PROGRAM</div>
																		<cfelse>
																		<a class="btn btn-sm btn-outline-primary pull-right btn_el_session" id="sm_#sessionmaster_id#"  <!---data-toggle="tooltip" data-placement="top" title="Send to e-Program"---> href="##"><i class="fas fa-folder-plus"></i> <br>E-PROGRAM</i></div>
																		</cfif>
																		
																	</td>
																	<td width="5%">
																		<cfif sm_elapsed eq "" AND sm_lastview eq "">
																		<a class="btn pull-right btn-sm btn-outline-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"><i class="fas fa-play"></i><br>#__btn_start#</a>
																		<cfelse>
																		<a class="btn pull-right btn-sm btn-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"><i class="fas fa-play"></i><br>#__btn_continue#</a>
																		</cfif>
																
																	</td>
																</tr>
																</cfoutput>			
																</table>
																<!---</div>--->
															</div>	
														</div>	
														</cfoutput>	
													</div>
													
												</cfoutput>
												
												</div>
												
											</cfoutput>	
									
										</div>
										
									</div>	
									
									</cfif>
									
								</cfif>
								
							</cfif>
									
								</div>		
							</div>		
						</div>		
					</div>		
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script>
$(document).ready(function() {

	
	/****** INIT BOOSTRAP COMPONENTS *******/	
	$('[data-toggle="popover"]').popover({
	  trigger: 'focus',
	  html: true
	});
	$('[data-toggle="tooltip"]').tooltip({html: true});
		
	
	<cfoutput>
	/******************** VIEW SESSION DETAILS *****************************/
	$('.btn_view_session').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var sgo = idtemp.substr(0,2);
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_session')#");
		if(sgo == "sm")
		{$('##modal_body_lg').load("modal_window_session.cfm?sm_id="+idtemp, function() {});}
		else
		{$('##modal_body_lg').load("modal_window_session.cfm?s_id="+idtemp, function() {});}
	});
	
	$('.btn_edit_needs').click(function(event) {
		event.preventDefault();		
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_na'))#");
		$('##modal_body_xl').load("modal_window_needs.cfm?view=light", function() {});
	});
	
	</cfoutput>
	
	$('.btn_el_session').click(function(event) {		
		event.preventDefault();
		var sm_id = $(this).attr("id");
		var sm_id = sm_id.substr(sm_id.indexOf("_")+1,50);
		var obj_cor = $(this);
		obj_cor.empty();
		obj_cor.append('<i class="fas fa-spinner fa-spin fa-lg"></i>');
		
		$.ajax({
			url : 'updater.cfc?method=el_list',
			type : 'POST',	   
			<cfoutput>
			data : {sm_id: sm_id},
			</cfoutput>

			success : function(resultat, statut){
				obj_cor.empty();
				if(resultat == "off"){
					obj_cor.toggleClass("btn-outline-primary");
					obj_cor.toggleClass("btn-primary");
					obj_cor.append('<i class="fas fa-folder-plus"></i> <br>E-PROGRAM');
				}
				else
				{
					obj_cor.toggleClass("btn-outline-primary");
					obj_cor.toggleClass("btn-primary");
					obj_cor.append('<i class="far fa-thumbs-up"></i> <br>E-PROGRAM');
				}
			},
			error : function(resultat, statut, erreur){
			alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
			},
			complete : function(resultat, statut){}
		})
	});
	
	$('.btn_el_session_del').click(function(event) {		
		event.preventDefault();
		var sm_id = $(this).attr("id");
		var sm_id = sm_id.substr(sm_id.indexOf("_")+1,50);
		var temp_obj = $(this).parent().parent().parent();
		
		$.ajax({
			url : 'updater.cfc?method=el_list',
			type : 'POST',	   
			<cfoutput>
			data : {sm_id: sm_id},
			</cfoutput>
			success : function(resultat, statut){
				temp_obj.hide("fast");
			},
			error : function(resultat, statut, erreur){
				alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
			},
			complete : function(resultat, statut){}
		})
	});
	
	
	
	<cfoutput>
	// $('.btn_view_tuto').click(function(event) {	
	// 	event.preventDefault();
	// 	$('##modal_title_lg').text("#encodeForJavaScript(obj_translater.get_translate('btn_help_page'))#");
	// 	$('##window_item_lg').modal({keyboard: true});
	// 	$('##modal_body_lg').load("modal_window_info.cfm?show_info=elearning", function() {});
	// })
					
	// $('##window_item_lg').on('hidden.bs.modal', function () {
	// 	$('##modal_body_lg').empty();
	// });
	</cfoutput>
})

</script>

</body>
</html>