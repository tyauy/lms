<cfparam name="l_id">

<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>

<cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
    <cfinvokeargument name="l_id" value="#l_id#">
</cfinvoke>

<cfinvoke component="api/tp/tp_get" method="oget_tp" returnvariable="get_tp">
    <cfinvokeargument name="t_id" value="#get_lessonnote.tp_id#">
</cfinvoke>

<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>

<cfinvoke component="components/functions" method="get_dateformat" returnvariable="lesson_date_start">
    <cfinvokeargument name="datego" value="#get_lesson.lesson_start#">
    <cfinvokeargument name="lang" value="#lang_temp#">
</cfinvoke>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #formation_id# ORDER BY grammar_cat_name
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #formation_id#
</cfquery>

<cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
SELECT e.eval_id, eq.equ_name_#lang_temp# as equ_name, eq.equ_group_#lang_temp# as equ_group, eq.equ_id, er.equ_result
FROM lms_eval e
INNER JOIN lms_eval_question eq ON eq.eval_id = e.eval_id
LEFT JOIN lms_eval_result er ON er.equ_id = eq.equ_id
WHERE e.eval_id = 1 AND (er.note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#"> OR er.note_id IS NULL)
ORDER BY equ_group
</cfquery>

<cfset lesson_intro = get_lessonnote.lesson_intro>
<cfset lesson_footer = obj_translater.get_translate("ln_title_ending",formation_id)>

<cfset sm_description = get_lessonnote.sessionmaster_description>
<cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
<cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
<cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>

<cfset lesson_open_main = get_lessonnote.lesson_open_main>
<cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
<cfset lesson_add_misc = get_lessonnote.lesson_add_misc>
<cfset lesson_feedback = get_lessonnote.lesson_feedback>
<cfset lesson_grammar = get_lessonnote.lesson_grammar>
<cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>
<cfset lesson_add_vocabulary = get_lessonnote.lesson_add_vocabulary>
<cfset lesson_open_ressources = get_lessonnote.lesson_open_ressources>							
<cfset lesson_add_correction = get_lessonnote.lesson_add_correction>
<cfset lesson_homework = get_lessonnote.lesson_homework>

<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
<cfset lesson_na_improve = get_lessonnote.lesson_na_improve>
<cfset lesson_na_workon = get_lessonnote.lesson_na_workon>

<cfset lesson_formation = get_lessonnote.formation_name>
<cfset lesson_pta_initial = get_lessonnote.lesson_pta_initial>
<cfset lesson_pta_achievement = get_lessonnote.lesson_pta_achievement>


<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
<cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>	
	
<cfif get_lessonnote.sessionmaster_id eq "695">

	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_fullname, u.*,
	a.account_name, g.group_name, s.user_status_name_fr as user_status_name
	
	FROM user u
	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
	LEFT JOIN account a ON a.account_id = u.account_id
	LEFT JOIN account_group g ON g.group_id = a.group_id
	
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
	</cfquery>

	<cfset account_name = get_user.account_name>
	<cfset group_name = get_user.group_name>
	
	<cfset user_steps = get_user.user_steps>
	<cfset user_qpt = get_user.user_qpt>
	<cfset user_qpt_lock = get_user.user_qpt_lock>
	<cfset user_lst = get_user.user_lst>
	
	<cfset user_email = get_user.user_email>
	<cfset user_phone = get_user.user_phone>
	<cfset user_alias = get_user.user_alias>
	
	<cfset avail_id = get_user.avail_id>
	<cfset interest_id = get_user.interest_id>
			
	<cfset user_jobtitle = get_user.user_jobtitle>
	<cfset user_needs_course = get_user.user_needs_course>
	<cfset user_needs_frequency = get_user.user_needs_frequency>
	<cfset user_needs_trainer = get_user.user_needs_trainer>
	<cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
	<cfset user_needs_learn = get_user.user_needs_learn>
	<cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement>
	<cfset user_needs_complement = get_user.user_needs_complement>
	<cfset user_needs_theme = get_user.user_needs_theme>
	<cfset user_needs_duration = get_user.user_needs_duration>
	
	<cfset user_remind_1d = get_user.user_remind_1d>
	<cfset user_remind_3h = get_user.user_remind_3h>
	<cfset user_remind_15m = get_user.user_remind_15m>
	
	<cfset user_status_name = get_user.user_status_name>

</cfif>

	<div class="card border h-100">
		<div class="card-body">

			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-notes text-danger fa-lg mr-2"></i><cfoutput>#get_lessonnote.sessionmaster_name#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>
			<cfoutput query="get_lesson">
			<div class="row mt-3">

				<div class="col-md-3">	
								
					<div class="card">
						
						<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
							<img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
						<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
							<img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
						<cfelse>
							<img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
						</cfif>

						<cfif isDefined("sessionmaster_ressource")>
						<div class="card-body">
							<div class="d-flex w-100 justify-content-center">
								<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
									<i class="fal fa-book fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
								<cfelse>
									<i class="fal fa-book fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
								</cfif>

								<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
									<i class="fal fa-volume-up fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
								<cfelse>
									<i class="fal fa-volume-up fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
								</cfif>

								<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
									<i class="fal fa-film fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
								<cfelse>
									<i class="fal fa-film fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
								</cfif>
							</div>
							
							
						</div>
						</cfif>

					</div>
					
				</div>

				<div class="col-md-9">	
					#obj_function.get_thumb_border(user_id="#get_lessonnote.planner_id#",size="40",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#
                
					<img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mr-1"> 

					<br>
					
					<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-calendar"></i> #lesson_date_start#</span> 

					<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-clock"></i> #timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</span> 

					<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-users"></i> #get_tp.method_name#</span> 
				
					<span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-hourglass-start"></i> #session_duration# min</span> 
						
					
					<p class="mt-2">
    
						<cfif isDefined("sessionmaster_description")>
							#sessionmaster_description#
						</cfif>
						
					</p>


					<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
						
						<cfif sm_objectives neq "">
							<tr>
								<td>
								<h5><u>#obj_translater.get_translate('ln_title_objectives',formation_id)#</u></h5>
								<p style="margin-top:10px">
								#sm_objectives#
								</p>
								</td>
							</tr>
						</cfif>
						<cfif sm_grammar neq "">
							<tr>
								<td>
								<h5><u>#obj_translater.get_translate('ln_title_grammar',formation_id)#</u></h5>
								<p style="margin-top:10px">
								#sm_grammar#
								</p>
								</td>
							</tr>
						</cfif>
						<cfif sm_vocabulary neq "">
							<tr>
								<td>
								<h5><u>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</u></h5>
								<p style="margin-top:10px">
								#sm_vocabulary#
								</p>
								</td>
							</tr>
						</cfif>
					</table>
				</div>

			</div>
			</cfoutput>

		</div>
	</div>





	<!----------------------------- NEEDS ASSESSMENTS 1ST LESSON ------------------------------------->
	<cfif get_lessonnote.sessionmaster_id eq "695">

		<div class="card border h-100">
			<div class="card-body">
	
				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-bullseye-arrow text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h5>
					<hr class="border-danger mb-1 mt-2">
				</div>
					
				<cfoutput>
				<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
					
					<cfif listlen(lesson_skill_id) neq "0">
					<tr>
						<td>
						<h5><u>#obj_translater.get_translate('ln_title_want_to',formation_id)#</u></h5>
						<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
						SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
						</cfquery>
						<ul>
						<cfloop query="get_skill">
						<li>#get_skill.skill_objectives#</li>
						</cfloop>
						</ul>
						</td>
					</tr>
					</cfif>
					
					<cfif lesson_na_needs neq "">
					<tr>
						<td>
						<h5><u>#obj_translater.get_translate('ln_title_initial',formation_id)#</u></h5>
						#replacenocase(lesson_na_needs,chr(10),"<br>","ALL")#
						</td>
					</tr>			
					
					</cfif>
				
				</table>
				</cfoutput>
			</div>
		</div>

		<div class="card border h-100">
			<div class="card-body">
	
				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-chess-knight text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_strategy_analysis',formation_id)#</cfoutput></h5>
					<hr class="border-danger mb-1 mt-2">
				</div>
				<cfoutput>
				<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
					
					<tr>
						<td>
							<h5><u>#ucase(obj_translater.get_translate('ln_title_how',formation_id))#</u></h5>
							
							<cfif listlen(user_needs_course) neq "0">
							<strong>#obj_translater.get_translate('table_th_mini_course_pref',formation_id)#</strong><br>
							<ul>
							<cfloop list="#user_needs_course#" index="cor">
								<cfif cor eq "1"><li>Structural lessons</li></cfif>
								<cfif cor eq "2"><li>Open lessons</li></cfif>
								<cfif cor eq "3"><li>Workshop</li></cfif>
							</cfloop>
							</ul>
							</cfif>
						
							<cfif user_needs_duration neq "">
							<br>
							<strong>#obj_translater.get_translate('table_th_mini_course_duration',formation_id)#</strong><br>
							<ul>
								<li>#user_needs_duration# min</li>
							</ul>
							</cfif>
							
							<cfif user_needs_frequency neq "">
							<br>
							<strong>#obj_translater.get_translate('table_th_mini_course_freq',formation_id)#</strong><br>
							<ul>	
							<cfif user_needs_frequency eq "1"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('day',formation_id)#</li></cfif>
							<cfif user_needs_frequency eq "2"><li>3 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
							<cfif user_needs_frequency eq "3"><li>2 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
							<cfif user_needs_frequency eq "4"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
							</ul>
							</cfif>
							
							<cfif user_needs_trainer neq "">
							<br>
							<strong>#obj_translater.get_translate('table_th_mini_trainer_franco',formation_id)#</strong><br>
							<ul>
								<cfif user_needs_trainer eq "1"><li>#obj_translater.get_translate('yes',formation_id)#</li></cfif>
								<cfif user_needs_trainer eq "0"><li>#obj_translater.get_translate('no',formation_id)#</li></cfif>
							</ul>
							</cfif>
							
							<cfif user_needs_nbtrainer neq "">
							<br>							
							<strong>#obj_translater.get_translate('table_th_mini_trainer_nb',formation_id)#</strong><br>							
							<ul>
								<cfif user_needs_nbtrainer eq "1"><li>#obj_translater.get_translate('needs_txt_trainer_mono',formation_id)#</li></cfif>
								<cfif user_needs_nbtrainer eq "2"><li>#obj_translater.get_translate('needs_txt_trainer_several',formation_id)#</li></cfif>
							</ul>
							</cfif>
							
						</td>
					</tr>
						
						
				</table>
				</cfoutput>

			</div>

		</div>

		<div class="card border h-100">
			<div class="card-body">

				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-head-side-brain text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_learner_profile',formation_id)#</cfoutput></h5>
					<hr class="border-danger mb-1 mt-2">
				</div>

				
				<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
				
					<tr>
						<td>
							
							<cfif listlen(interest_id) neq "0">
							<h5><u><cfoutput>#obj_translater.get_translate('ln_title_interests',formation_id)#</cfoutput></u></h5>
							<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
							SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
							FROM lms_keyword k 
							INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
							WHERE keyword_id IN (#interest_id#) ORDER BY k.keyword_cat_id DESC
							</cfquery>

							<cfoutput query="get_keywords" group="keyword_cat_id">
								<strong>#keyword_cat_name#</strong>
								<br>
								<cfoutput>
								#keyword_name#<br>
								</cfoutput>
							</cfoutput>		
											
							</cfif>
							
							<!---	fetching user test for TP	--->
							<cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
								SELECT qu.quiz_global_level,
								lv.level_desc_#lang_temp# as level_desc, lv.level_name_#lang_temp# as level_name
								FROM lms_quiz_user_score qu
								INNER JOIN lms_quiz_user_tp qutp ON qu.quiz_user_group_id = qutp.quiz_user_group_id
                                LEFT JOIN lms_level lv ON lv.level_alias LIKE LEFT( qu.quiz_global_level, 2)
								WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
								AND qutp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.tp_id#">
                                AND qu.quiz_global_level IS NOT NULL
							</cfquery>
							
							
							
							<cfif get_eval.recordcount GT 0 >
							<cfoutput query="get_eval">
							<h5><u>#ucase(obj_translater.get_translate('ln_title_level',formation_id))#</u></h5>

								#obj_translater.get_translate('ln_lesson_level_intro',formation_id)# #get_eval.quiz_global_level# - #get_eval.level_name#

								#get_eval.level_desc#
							</cfoutput>					
							</cfif>
													
						</td>
						
					</tr>
				</table>

			</div>
		</div>
	
	<!----------------------------- PTA LAST LESSON ------------------------------------->
	<cfelseif get_lessonnote.sessionmaster_id eq "694">

	<div class="card border h-100">
		<div class="card-body">

			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-bullseye-arrow text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>

			<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							
				<tr>
					<td>
					
					<cfif listlen(lesson_skill_id) neq "0">
					<h5><u>YOU WANTED TO LEARN <cfoutput>#ucase(lesson_formation)#</cfoutput> TO:</u></h5>
					<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
					SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
					</cfquery>
					<ul>
					<cfoutput>
					<cfloop query="get_skill">
					<li>#get_skill.skill_objectives#</li>
					</cfloop>
					</cfoutput>
					</ul>
					</cfif>
					
					
					<cfif lesson_pta_initial neq "">
					<br>
					
					<h5><u><cfoutput>#obj_translater.get_translate('ln_title_initial',formation_id)#</cfoutput></u></h5>
					<cfoutput>#replacenocase(lesson_pta_initial,chr(10),"<br>","ALL")#</cfoutput>
					</cfif>
					
					</td>
				</tr>
			</table>

		</div>
	</div>

	<div class="card border h-100">
		<div class="card-body">
			
			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-trophy text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_achievement',formation_id)#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>

			<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							
				<tr>
					<td>

					<cfif lesson_pta_achievement neq "">
					<h5><u><cfoutput>#obj_translater.get_translate('ln_title_now_able',formation_id)#</cfoutput></u></h5>
					<cfoutput>#replacenocase(lesson_pta_achievement,chr(10),"<br>","ALL")#</cfoutput>
					</cfif>
					
					<cfif lesson_feedback neq "">
					<br>
					
					<h5><u><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback_tips',formation_id)#</cfoutput></u></h5>
					<cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#</cfoutput>
					</cfif>
					
					</td>
				</tr>
			</table>

		</div>
	</div>


	<div class="card border h-100">
		<div class="card-body">

			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-ranking-star text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_performance',formation_id)#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>
			
			<em>5: Excellent&nbsp;&nbsp;&nbsp;4: Very good&nbsp;&nbsp;&nbsp;3: Good&nbsp;&nbsp;&nbsp;2: Satisfactory&nbsp;&nbsp;&nbsp;1: Poor</em>
				

			<table bgcolor="#CCCCCC" style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:20px" width="100%" cellpadding="10" cellspacing="1">	

				<cfoutput query="get_eval" group="equ_group">
								
				<tr bgcolor="##ECECEC">
					<td><strong>#ucase(equ_group)#</strong></td>
					<td width="10"><span class="badge badge-pill badge-secondary">1</span></td>
					<td width="10"><span class="badge badge-pill badge-secondary">2</span></td>
					<td width="10"><span class="badge badge-pill badge-secondary">3</span></td>
					<td width="10"><span class="badge badge-pill badge-secondary">4</span></td>
					<td width="10"><span class="badge badge-pill badge-secondary">5</span></td>
					<td width="10"><span class="badge badge-pill badge-secondary">NA</span></td>
				</tr>
				
				<cfoutput>
				
				<tr bgcolor="##FFFFFF">
					<td>
						#equ_name#
					</td>
					<cfif isdefined("equ_result") AND equ_result eq "1">
					<td width="10" bgcolor="##ff7c7c">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
					<cfif isdefined("equ_result") AND equ_result eq "2">
					<td width="10" bgcolor="##fbb962">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
					<cfif isdefined("equ_result") AND equ_result eq "3">
					<td width="10" bgcolor="##e7ef00">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
					<cfif isdefined("equ_result") AND equ_result eq "4">
					<td width="10" bgcolor="##c6e885">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
					<cfif isdefined("equ_result") AND equ_result eq "5">
					<td width="10" bgcolor="##49b734">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
					<cfif isdefined("equ_result") AND equ_result eq "0">
					<td width="10" bgcolor="##ECECEC">
						X
					</td>
					<cfelse>
					<td width="10" bgcolor="##FFF">
						
					</td>								
					</cfif>
				</tr>
				
				</cfoutput>
				
				</cfoutput>

			</table>

		</div>
	</div>




	
	<cfelse>
	<!----------------------------- ORTHERS LESSON ------------------------------------->
	
	<div class="card border h-100">
		<div class="card-body">

			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-spell-check text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_today_teaching_points',formation_id)#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>

			<cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "697" OR listlen(lesson_skill_id) neq "0" OR lesson_add_misc neq "">
				<cfoutput>
				<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
					<cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "1181" OR get_lessonnote.sessionmaster_id eq "1183">
						<tr>
							<td>
							<h5><u>#obj_translater.get_translate('ln_title_main_discussion',formation_id)#</u></h5>
							<p style="margin-top:10px">
							#replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
							</p>
							<cfif lesson_open_ressources neq "">
								
								<p style="margin-top:10px">
								#replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#
								</p>
							
							</cfif>
							</td>
						</tr>
					
					<cfelseif get_lessonnote.sessionmaster_id eq "697">
						<tr>
							<td>
							<h5><u>#obj_translater.get_translate('ln_title_did_work_on',formation_id)#</u></h5>
							<p style="margin-top:10px">
							#replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
							</p>
							
							<cfif lesson_open_ressources neq "">
								
								<p style="margin-top:10px">
								#replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#
								</p>
							
							</cfif>
								
							</td>
						</tr>
					</cfif>
					<cfif listlen(lesson_skill_id) neq "0">
						<tr>
							<td>
							<h5><u>#obj_translater.get_translate('ln_title_today_work_on',formation_id)#</u></h5>
							<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
							SELECT skill_name_#lang_temp# as skill_name FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
							</cfquery>
							<ul>
							<cfloop query="get_skill">
							<li>#get_skill.skill_name#</li>
							</cfloop>
							</ul>
							</td>
						</tr>
					</cfif>
					<cfif lesson_add_misc neq "">
						<tr>
							<td>
							<p style="margin-top:10px">
							#replacenocase(lesson_add_misc,chr(10),"<br>","ALL")#
							</p>
							</td>
						</tr>
					
					</cfif>
				</table>
				</cfoutput>
			</cfif>
			
			
			
			
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
			
				<tr>
					<td width="100%" align="center" style="padding:20px 20px 0px 20px">
							
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="left">
									
									<cfif lesson_grammar neq "" OR lesson_vocabulary neq "" OR lesson_add_vocabulary neq "" OR lesson_add_correction neq "" OR lesson_homework neq "">
									
									<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
										<tr>
											<td>
												<cfif listfind(get_lessonnote.ln_skill_id,"5") AND listlen(get_lessonnote.ln_grammar_id) neq "0">
													
													<h5><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_covered',formation_id)#</cfoutput></u></h5>
													
													<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
													SELECT grammar_name, grammar_level, grammar_cat_name, g.grammar_cat_id
													FROM lms_grammar g INNER JOIN lms_grammar_category gc ON gc.grammar_cat_id = g.grammar_cat_id WHERE g.grammar_id IN (#get_lessonnote.ln_grammar_id#)
													</cfquery>										
													
													<cfoutput query="get_grammar" group="grammar_cat_id">
													<strong>#grammar_cat_name# (#grammar_level#)</strong>
													<ul>
													<cfoutput>
													<li>#get_grammar.grammar_name#</li>
													</cfoutput>
													</ul>
													</cfoutput>
													
			
												</cfif>
										
										
												<cfif lesson_grammar neq "">
													<h5><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_explanation',formation_id)#</cfoutput></u></h5>
													<p style="margin-top:10px">
													<cfoutput>#replacenocase(lesson_grammar,chr(10),"<br>","ALL")#</cfoutput>
													</p>
												</cfif>
										
												<cfif lesson_vocabulary neq "">
												
													<h5><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h5>
													<p style="margin-top:10px">
													<cfoutput>#replacenocase(lesson_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
													</p>
												
												</cfif>
												
												<cfif lesson_add_vocabulary neq "">
												
													<h5><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h5>
													<p style="margin-top:10px">
													<cfoutput>#replacenocase(lesson_add_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
													</p>
												
												</cfif>
												
												<cfif lesson_add_correction neq "">
												
													<p style="margin-top:10px">
													<cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
													</p>
												
												</cfif>
												
												<cfif lesson_homework neq "">
												
													<p style="margin-top:10px">
													<cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
													</p>
												
												</cfif>
											
											</td>
										
										</tr>
										
									</table>
									
									</cfif>
			
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>      

		</div>
	</div>

	<cfif lesson_feedback neq "">
	<div class="card border h-100">
		<div class="card-body">

			<div class="w-100">
				<h5 class="d-inline"><i class="fa-thin fa-message-check text-danger fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback',formation_id)#</cfoutput></h5>
				<hr class="border-danger mb-1 mt-2">
			</div>

			<p>

				<cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#	</cfoutput>		
				
			</p>
			
		</div>
	</div>
	</cfif>

	</cfif>

	<div align="center">
		<cfoutput>
			<div>
				<a style="min-height:82px !important;" target="_blank" class="text-secondary" href="./tpl/ln_container.cfm?l_id=#l_id#">
					<i class="fal fa-download fa-2x mt-2"></i> PDF
				</a>
			</div>
		<em style="font-size:13px">#lesson_footer#</em>
		<br>#get_lessonnote.planner_firstname#
		</cfoutput>
		
	</div>


</body>
</html>

<script>
$(document).ready(function() {

	
});
</script>


