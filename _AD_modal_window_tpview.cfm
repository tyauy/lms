<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
a.account_name, 
t.*, t.method_id, t.techno_id as tp_techno_id,
lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
tpd.*,
tpc.*,
ts.tp_status_name_#SESSION.LANG_CODE# as tp_status_name,
q.quiz_id,
sm.sessionmaster_name_#SESSION.LANG_CODE# as sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code,
l.*,
ln.note_id,
tl1.user_firstname as planner_firstname,
ls.status_css, ls.status_name_#SESSION.LANG_CODE# as l_status_name,
tm.module_name,
cat.cat_id,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id) as tp_lesson_duration,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id IS NULL) as tp_toschedule,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
(SELECT SUM(lesson_duration) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 6) as tp_signed,
(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 5 OR status_id = 6)) as first_lesson,
(SELECT MAX(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW()) as last_lesson,
(SELECT MIN(lesson_start) FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND lesson_start > NOW()) as next_lesson

FROM lms_tp t 

INNER JOIN user u ON t.user_id = u.user_id
INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
LEFT JOIN account a ON a.account_id = u.account_id
	
LEFT JOIN lms_lesson2 l ON t.tp_id = l.tp_id
LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
LEFT JOIN user tl1 ON l.planner_id  = tl1.user_id

LEFT JOIN lms_tpsession s ON s.session_id = l.session_id

LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
LEFT JOIN lms_tpsession_category cat ON cat.cat_id = sm.sessionmaster_cat_id AND cat.cat_public = 1
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	

LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id

LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id

WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">

ORDER BY l.lesson_rank ASC
</cfquery>

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

<cfset tp_id = "4203">
<cfset tp_duration_min = "1200">
<cfset tp_booked_min = "540">
<cfset tp_duration_h = tp_duration_min/60>
<cfset tp_booked_h = tp_booked_min/60>
<cfset progress_completed = round((tp_booked_min/tp_duration_min)*100)>
<cfset session_length = "60">

	
	<cfoutput query="get_tp" group="tp_id">
		
		<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
		<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
		<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
		<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
		<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
		<cfif tp_toschedule eq ""><cfset tp_toschedule_go = "0"><cfelse><cfset tp_toschedule_go = tp_toschedule></cfif>
		
		<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
		<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go-tp_toschedule_go>
		
		<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
		
		<table class="table bg-white table-bordered m-0">
				
				<tr>
					<td width="20%" class="bg-light">#obj_translater.get_translate('table_th_program_short')#</td>
					<td>
						#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#
					</td>
				</tr>
				<!--- <tr> --->
					<!--- <td class="bg-light">#obj_translater.get_translate('table_th_trainer')#</td> --->
				<!--- </tr> --->
				<tr>
					<td class="bg-light">#obj_translater.get_translate('table_th_start')#</td>
					<td>#dateformat(tp_date_start,'dd/mm/yyyy')#</td>
				</tr>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('table_th_end')#</td>
					<td>#dateformat(tp_date_end,'dd/mm/yyyy')#</td>
				</tr>
				<!--- <tr> --->
					<!--- <td class="bg-light"><span style="cursor:pointer" class="btn_help badge badge-info">?</span> Planifi&eacute;</td> --->
					<!--- <td> --->
						<!--- <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-info" id="nb_toschedule"><cfif tp_toschedule_go neq "0">#obj_lms.get_formath(tp_toschedule_go)#h<cfelse>-</cfif></span></h6> --->
					<!--- </td> --->
				<!--- </tr> --->
				<!--- <tr> --->
					<!--- <td class="bg-light"><span style="cursor:pointer" class="btn_help badge badge-warning text-white">?</span> R&eacute;serv&eacute;</td> --->
					<!--- <td> --->
						<!--- <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-warning text-white" id="nb_scheduled"><cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#h<cfelse>-</cfif></span></h6> --->
					<!--- </td> --->
				<!--- </tr> --->
				<!--- <tr> --->
					<!--- <td class="bg-light"><span style="cursor:pointer" class="btn_help badge badge-success">?</span> Compl&eacute;t&eacute;</td> --->
					<!--- <td> --->
						<!--- <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-success" id="nb_completed"><cfif tp_completed_go neq "0">#obj_lms.get_formath(tp_completed_go)#h<cfelse>-</cfif></span></h6> --->
					<!--- </td> --->
				<!--- </tr> --->
				<!--- <tr> --->
					<!--- <td class="bg-light"><span style="cursor:pointer" class="btn_help badge badge-danger">?</span> Manqu&eacute;</td> --->
					<!--- <td> --->
						<!--- <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_missed"><cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#h<cfelse>-</cfif></span></h6> --->
					<!--- </td> --->
				<!--- </tr> --->
				<!--- <tr> --->
					<!--- <td class="bg-light"><span style="cursor:pointer" class="btn_help badge badge-primary">?</span> Cr&eacute;dits restants</td> --->
					<!--- <td> --->
						<!--- <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-primary" id="nb_remain"><cfif tp_remain_go neq "0">#obj_lms.get_formath(tp_remain_go)#h<cfelse>-</cfif></span></h6> --->
					<!--- </td> --->
				<!--- </tr> --->
			</table>
			
	</cfoutput>

<cfoutput>
<div class="row mt-4">
												
	<div class="col-8">

		<div class="shadow-sm">
			
			<div class="progress" style="height:40px">
			<div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="#progress_completed#" aria-valuemin="0" aria-valuemax="100" style="width: #progress_completed#%">#tp_booked_h#h planifiée(s) / #tp_duration_h#h</div>
			</div>
			
		</div>
	</div>
	
	<div class="col-4">
		<a href="##" class="btn btn-success"><i class="fal fa-check"></i> Valider l'étape "mon parcours"</a>
	</div>				
	
</div>
</cfoutput>



<!--- <cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#")> --->









				
					<!--- <cfoutput query="get_tp" group="tp_id"> --->
						<!--- <cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif> --->
						<!--- <cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif> --->
						<!--- <cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif> --->
						<!--- <cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif> --->
						<!--- <cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif> --->
						<!--- <cfif tp_toschedule eq ""><cfset tp_toschedule_go = "0"><cfelse><cfset tp_toschedule_go = tp_toschedule></cfif> --->
						
						<!--- <cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif> --->
						<!--- <cfset tp_done_go = tp_completed_go+tp_inprogress_go> --->
						<!--- <cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_done_go-tp_scheduled_go-tp_toschedule_go> --->
						
						
						<!--- <div class="alert alert-info mt-3 <cfif tp_remain_go eq "0">d-none</cfif>" id="alert_remain" role="alert"> --->
							<!--- <div class="media"> --->
								<!--- <cfif get_tp.method_id eq "1"> --->
								<!--- <i class="fas fa-video fa-3x mr-3"></i> --->
								<!--- <cfelseif get_tp.method_id eq "2"> --->
								<!--- <i class="fas fa-user-friends fa-3x mr-3"></i> --->
								<!--- </cfif> --->
								<!--- <div class="media-body"> --->
									<!--- <strong>Votre parcours est incomplet ( il vous reste <span id="span_remain">#obj_lms.get_formath(tp_remain_go)#</span> cr&eacute;dits &agrave; planifier)</strong> --->
									<!--- <br> --->
									<!--- Vous pouvez le compl&eacute;ter &agrave; l'aide de la fen&ecirc;tre &quot;Ajouter des cours&quot; ou vous r&eacute;f&eacute;rer &agrave; votre formateur. --->
								<!--- </div> --->
							<!--- </div>								 --->
						<!--- </div> --->
						
						<!--- <ul id="sortable" class="tp_content p-0" style="list-style:none;"> --->
						<!--- <cfset count = "0"> --->
						<!--- <cfoutput> --->
							<!--- <li class="mt-3 border w-100 bg-light <cfif sessionmaster_id neq "695" AND sessionmaster_id neq "694">active</cfif>" id="LR_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#"> --->
							<!--- <cfset count++>	 --->
								<!--- <div class="container"> --->
								
								<!--- <div class="row" style="background-color:##ECECEC"> --->
									<!--- <div class="col-md-11 p-1" align="center"> --->
										<!--- <cfif sessionmaster_id neq "695" AND sessionmaster_id neq "694"> --->
										<!--- <div class="btn btn-sm pull-left p-0 m-0 handle" style="border:1px solid ##000; min-width:20px !important"><i class="fas fa-arrows-alt"></i></div> --->
										<!--- </cfif>							 --->
										<!--- <cfif module_name neq "">#module_name#<cfelse>Diverse</cfif> --->
									<!--- </div> --->
									<!--- <div class="col-md-1 p-1 pull-right"> --->
										<!--- <cfif lesson_start eq ""> --->
										<!--- <cfif (sessionmaster_id neq "695" AND sessionmaster_id neq "694") OR SESSION.USER_PROFILE eq "CS" OR SESSION.USER_PROFILE eq "SALES"> --->
										<!--- <a href="##" class="btn btn-sm btn-secondary del_liner pull-right p-0 m-0" style="border:1px solid ##000; min-width:20px !important" id="LTD_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#"><i class="fas fa-times"></i></a> --->
										<!--- </cfif> --->
										<!--- </cfif> --->
									<!--- </div> --->
								<!--- </div> --->
								
								<!--- <div class="row p-2"> --->
									<!--- <div class="col-md-2" align="center"> --->
									<!--- #obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="100")# --->
									<!--- </div> --->
									
									<!--- <div class="col-md-5"> --->
									<!--- #sessionmaster_name#<!--- - #lesson_id# - #lesson_rank#---> --->
									<!--- <br> --->
									<!--- <span class="btn_view_lesson_work" id="l_#lesson_id#" role="button" <!---data-toggle="collapse" data-target="##collapse_#lesson_id#" aria-expanded="true" aria-controls="collapse_#lesson_id#"--->> --->
									<!--- <small style="cursor:pointer"><strong>[more info]</strong></small> --->
									<!--- </span> --->
									<!--- </div> --->
									
									<!--- <cfif lesson_start neq ""> --->
									<!--- <div class="col-md-3"> --->
										<!--- <div class="p-1 border border-#status_css# bg-white h-100" align="center"> --->
											<!--- <div><span class="badge badge-#status_css# btn_view_lesson text-white" id="lesson_#lesson_id#" style="cursor:pointer"><cfif method_id eq "1"><i class="fas fa-video"></i><cfelseif method_id eq "2"><i class="fas fa-user-friends"></i></cfif><cfif lesson_duration neq ""> #lesson_duration#min</cfif> : <cfif status_id eq "1">R&eacute;serv&eacute;<cfelse>#l_status_name#</cfif></span></div> --->
											<!--- <cfif status_id eq "1"> --->
												<!--- <a class="btn btn-sm btn-outline-#status_css# btn_view_lesson pull-right" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate('tooltip_cancel_lesson')#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i></a> --->
											<!--- </cfif> --->
											<!--- <cfif status_id eq "5"><!--- AND note_id neq "">---> --->
												<!--- <a class="btn btn-sm btn-outline-#status_css# pull-right" target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#"><i class="fas fa-file-pdf"></i></a> --->
											<!--- </cfif> --->
											
											<!--- <strong>#dateformat(lesson_start,'dd/mm/yyyy')# --->
											<!--- #timeformat(lesson_start,'HH:mm')#-#timeformat(lesson_end,'HH:mm')#</strong><br> --->
											<!--- #obj_translater.get_translate('with')# #planner_firstname#										 --->
										<!--- </div> --->
									<!--- </div> --->
									<!--- <cfelse> --->
									<!--- <div class="col-md-3" align="center"> --->
										<!--- <div class="p-1 border" style="border:1px dashed ##CCC !important"> --->
											<!--- <span class="badge badge-warning text-white"><cfif method_id eq "1"><i class="fas fa-video"></i> #lesson_duration#min : VISIO<cfelseif method_id eq "2"><i class="fas fa-user-friends"></i> #lesson_duration#min : F2F</cfif></span> --->
											<!--- <br> --->
											<!--- <button class="btn btn-sm btn-outline-warning btn_edit_calendar m-1" id="LTB_#lesson_id#_#sessionmaster_id#_#lesson_duration#_#lesson_rank#"><i class="far fa-calendar-plus"></i> <div class="d-none d-lg-block">R&eacute;server</div></button> --->
										<!--- </div> --->
									<!--- </div> --->
									<!--- </cfif> --->
								
									
									<!--- </div> --->
									
								<!--- </div> --->
								
								
							<!--- </li> --->
						<!--- </cfoutput> --->
						<!--- </cfoutput> --->
						
						
						
						
						
						
						
						
						
						
		<cfset get_session = obj_tp_get.oget_session(t_id="#tp_id#")>				
						
						
						
						
												<div id="sortable">
						
													<!--- <table class="table bg-white mt-2" style="margin-bottom:0px !important"> --->
													<cfset css= "info">  
													<cfoutput query="get_session" group="session_id">
													<div class="row border-top p-2 sort s_#session_id#">
														<div class="col-1 d-none d-sm-block">
															<i class="far fa-arrows-alt fa-lg handle text-info"></i>
														</div>
														<div class="col-1 d-none d-sm-block">
														#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#
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
														<div class="col-1 d-none d-sm-block">
														#session_duration#min
														</div>
														<div class="col-5">
															<strong>#sessionmaster_name#</strong>
															<br>
															<span class="d-block d-sm-none">
															#session_duration#min
															</span>
															<span style="font-size:11px">#mid(sessionmaster_description,1,120)# [...]</span>
															
															<!--- <span class="btn_view_session" id="sm_#sessionmaster_id#"> --->
															
															<!--- <small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small> --->
															<!--- </span> --->
														</div>
														
														<!---<td>
															<cfif sessionmaster_rank neq "">
															<span class="badge">#__lesson# #sessionmaster_rank#</span>
															</cfif>
														</td>--->
														<!---<td width="5%">
															<small>#__text_about# #sessionmaster_duration# m</small>
														</td>--->
															
															
															<!--- <cfif keyword_id neq ""> --->
															<!--- <br> --->
															<!--- <small>#__card_keywords# :</small> --->
															<!--- <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#"> --->
															<!--- SELECT keyword_id as k_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#) --->
															<!--- </cfquery> --->
															<!--- <cfloop query="get_keyword"><span class="badge badge-pill <cfif listfind(kwish_id,k_id)>badge-danger<cfelse>border</cfif>">#keyword_name#</span> </cfloop> --->
															<!--- </cfif> --->


															<!--- <cfif grammar_id neq ""> --->
															<!--- <br> --->
															<!--- <small>#__card_grammar# :</small> --->
															<!--- <cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#"> --->
															<!--- SELECT grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#) --->
															<!--- </cfquery> --->
															<!--- <cfloop query="get_grammar"><span class="badge badge-info">#grammar_name#</span> </cfloop> --->
															<!--- </cfif>		 --->
														<div class="col-2">
															
															
																<a href="##" class="btn btn-sm p-2 btn-danger text-white selector btn_add_session" data-toggle="tooltip" data-placement="right" data-html="true" title="Training Program" id="btns_#session_id#"><span class="font-weight-normal display_text_action">Retirer cours</span><br><strong><span class="display_session_length">#session_length#min</span></strong></a>
																
																
																
															<!--- <a class="btn btn-sm btn-outline-#css# btn_view_session" id="sm_#sessionmaster_id#" href="##"><i class="fas fa-eye"></i> #__btn_details#</a> --->
															<!---<a class="btn btn-sm btn-outline-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"<!--- data-toggle="tooltip" data-placement="top" title="WeLearning"--->><i class="fas fa-laptop"></i> WeLearning</a>--->
															
																<!--- <span class="d-inline"><a class="badge badge-pill p-2 badge-danger font-weight-normal text-white del_liner" id="s_#session_id#">Retirer cours<br><strong>#session_duration#min</strong></a></span> --->
													
													
															<!--- <cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sessionmaster_id#)> --->
															<!--- <div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_remove_favourite#"><i class="fas fa-heart fa-lg red"></i></div> --->
															<!--- <cfelse> --->
															<!--- <div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_add_favourite#"><i class="far fa-heart fa-lg grey"></i></div> --->
															<!--- </cfif> --->
															<!---
															<cfif isdefined("SESSION.USER_EL_LIST") AND listfind(SESSION.USER_EL_LIST,#sessionmaster_id#)>
															<div class="p-1 pull-right cursored btn_el_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="Envoyer vers Mon eLearning"><i class="fas fa-laptop fa-lg blue"></i></div>
															<cfelse>
															<div class="p-1 pull-right cursored btn_el_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="Envoyer vers Mon eLearning"><i class="fas fa-laptop fa-lg grey"></i></div>
															</cfif>--->
														</div>
													</div>
													</cfoutput>			
											</div>
											



	
<script>
$(document).ready(function() {
	

	session_length_min = 60;

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
		$(this).tooltip({    content: '<div class="progress" style="height:20px"><div class="progress_completed_bar progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="'+progress_completed+'" aria-valuemin="0" aria-valuemax="100" style="width: '+progress_completed+'%"></div></div><span class="display_tp_booked">'+tp_booked_h+'</span>h planifiée(s) / <span class="display_tp_duration">'+tp_duration_h+'</span>h'         });
		}
	});
		
	$(".select_session_length").change(function() {

		session_length_min = $(this).val();
		progress_delta = parseInt((session_length_min/tp_duration_min)*100);
		$(".display_session_length").text(session_length_min+"min");
		
	});
	
	
	$('.btn_add_session').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var s_id = idtemp[1];
		
		
		$(this).toggleClass("btn-danger");
		
		<!--- alert(sm_id); --->
		
		
			$(".s_"+s_id).remove();
			
			tp_booked_min -= session_length_min;
			tp_left_min = parseInt(tp_duration_min-tp_booked_min);
			
			tp_booked_h = tp_booked_min/60;
			tp_left_h = tp_left_min/60;

			progress_completed -= progress_delta; 
			
			$(".progress_completed_general_bar").css("width",progress_completed+"%");
			
		
		<!--- $('.display_tp_booked_button').text(tp_booked_h); --->
		<!--- $('.display_tp_booked').text(tp_booked_h); --->
		<!--- $('.progress_completed_bar').css('width',progress_completed + '%'); --->
		<!--- $('.progress_completed_delta').css('width','0%'); --->
		
	});
	

	
		
	<!--- <cfoutput> --->
	<!--- total_duration = #get_tp.tp_duration#; --->
	<!--- total_booked = #get_tp.tp_lesson_duration#; --->
	<!--- t_id = #t_id#; --->
	<!--- u_id = #u_id#; --->
	<!--- </cfoutput> --->

	<!--- function param_attach(){ --->
		<!--- event.preventDefault(); --->
		<!--- var idtemp = $(this).attr("id"); --->
		<!--- var idtemp = idtemp.split("_"); --->
		<!--- var l_id = idtemp[1];		 --->
		<!--- var sm_id = idtemp[2]; --->
		<!--- var l_dur = idtemp[3]; --->

		<!--- <cfoutput> --->
		<!--- $('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_book')# - "+l_dur+" min"); --->
		<!--- $('##window_item_lg').modal({keyboard: true}); --->
		<!--- $('##modal_body_lg').load("modal_window_calendar3.cfm?t_id=#t_id#&u_id=#u_id#&l_id="+l_id+"&l_dur="+l_dur+"&sm_id="+sm_id, function() {}); --->
		<!--- </cfoutput> --->
	<!--- } --->
	
	<!--- $(".btn_edit_calendar").bind("click",param_attach); --->
	
	
	$("#sortable").sortable({
		items: "div.sort",
		opacity: 0.5,
		containment: "parent",
		cursor: "move",
		scroll: true,
		handle: ".handle",
		/*revert: true,*/
		axis: "y",
		update: function (event, ui) {
			var lesson_rank_table = $(this).sortable("toArray");
			//alert(data);
			// POST to server using $.post or $.ajax
			
			/* data : { a: "add", sm_id: sessionmaster_id, t_id:#t_id#, u_id:#u_id#, lesson_duration: lesson_duration}, */
			 
			$.ajax({				 
				url: 'updater_tp3.cfc?method=updt_rank',
				type: 'POST',				
				data : "lesson_rank_table="+lesson_rank_table,
				datatype : "html",
				success : function(resultat, statut){
					console.log(resultat);
				},
				error : function(resultat, statut, erreur){
					/*console.log(resultat);*/
				},
				complete : function(resultat, statut){
					/*console.log(resultat);*/
				}	
			});
		}
	});
    $("#sortable").disableSelection();




	function del_line(){

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];	
		var sm_id = idtemp[2];
		var l_dur = idtemp[3];
				
		var temp_obj = $(this).parent().parent().parent().parent();
		
		<!--- $.ajax({ --->
			<!--- url : 'updater_tp3.cfc?method=del', --->
			<!--- type : 'POST', --->
			<!--- <cfoutput> --->
			<!--- data : {act:"del", l_id:l_id, t_id:#t_id#, u_id:#u_id#, l_dur:l_dur}, --->
			<!--- </cfoutput> --->
			<!--- success : function(code_html, statut){ --->
				
				
				<!--- total_booked -= parseInt(l_dur); --->
				<!--- var total_booked_hour = parseFloat(total_booked/60); --->
				<!--- $("#tp_duration").val(total_booked_hour); --->
				<!--- var pource = (+total_booked/+total_duration)*100; --->
				<!--- $("#pbar").css('width', pource+'%'); --->
				
				<!--- /*if($(".session_adder").hasClass("d-none")){$(".session_adder").toggleClass("d-none");};*/ --->
				
				
				<!--- /*if($(".btn_saver").hasClass("btn-info")){$(".btn_saver").removeClass("btn-info").addClass("btn-success");};*/ --->
				
				<!--- if($("#pbar").hasClass("bg-success")){$("#pbar").toggleClass("bg-success");$("#pbar").toggleClass("bg-warning");}; --->
				<!--- if($("#pindic").hasClass("bg-success")){$("#pindic").toggleClass("bg-success");$("#pindic").toggleClass("bg-warning")}; --->
				<!--- temp_obj.remove();				 --->
				<!--- retrieve_value(); --->
								
				<!--- $("#alert_remain").show("fast"); --->
				
			<!--- }, --->
			<!--- error : function(resultat, statut, erreur){ --->
				<!--- alert("Probleme lors de la suppression du cours, veuillez recharger la page SVP.") --->
			<!--- }, --->
			<!--- complete : function(resultat, statut){ --->

			<!--- } --->
		<!--- }); --->

	};
	$(".del_liner").bind("click",del_line);
	
})

</script>