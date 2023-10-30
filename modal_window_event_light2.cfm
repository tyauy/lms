
	<cfif not isDefined("SESSION.TP_CANCEL_PTA")>
		<cfset SESSION.TP_CANCEL_PTA = 0>
	</cfif>

	<cfset get_lesson = obj_query.oget_lesson(l_id="#lesson_id#")>

	<cfset get_cancel_count = obj_tp_get.oget_tp_cancel_today(t_id="#get_lesson.tp_id#")>
	
	<!--- * getting redirect url - former lesson_link  --->
	<cfif get_lesson.lesson_redirect neq "">
		<cfset _lesson_redirect = get_lesson.lesson_redirect>
		<cfset _lesson_redirect_key = get_lesson.lesson_redirect_key>
		<cfset _lesson_techno_name = get_lesson.tech_name>
		<cfset _lesson_techno_icon = get_lesson.techno_icon>
	<cfelse>
		<cfset get_lesson_tech = obj_query.oget_lesson_default_tech(u_id="#SESSION.USER_ID#")>
		<cfset _lesson_redirect = get_lesson_tech.lesson_redirect>
		<cfset _lesson_redirect_key = get_lesson_tech.lesson_redirect_key>
		<cfset _lesson_techno_name = get_lesson_tech.tech_name>
		<cfset _lesson_techno_icon = get_lesson_tech.techno_icon>
	</cfif>

	<cfset p_id = get_lesson.planner_id>
	<cfset u_id = get_lesson.user_id>
	
	<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>	
	<cfset get_user = obj_tp_get.oget_tp_user(t_id="#get_lesson.tp_id#")>

	<cfset get_session_description = obj_query.oget_session_description(sm_id="#get_lesson.sessionmaster_id#")>
	
	<cfif get_lesson.sessionmaster_id eq 694>
		<cfset SESSION.TP_CANCEL_PTA = get_lesson.tp_id>
	</cfif>
	<!--- <cfdump var="#get_lesson#"> --->
<cfform>
<cfoutput>
<table class="table table-sm">
	<tr>
		<th class="bg-light" width="25%">
			<label>#obj_translater.get_translate('table_th_status')#</label> 
		</td>
		<td>
			<cfif get_lesson.status_id eq "1">
						
			<cfset text_invite = encodeForURL("WEFIT LESSON with #ucase(get_planner.user_firstname)#")>
			<cfset desc_invite = encodeForURL("
			#obj_translater.get_translate('table_th_method')# : #ucase(get_lesson.method_name)#
			#obj_translater.get_translate('table_th_trainer')# : #ucase(get_planner.user_firstname)#
			#obj_translater.get_translate('table_th_duration_short')# : #get_lesson.lesson_duration#min 
			#obj_translater.get_translate('table_th_course')# : #get_lesson.sessionmaster_name#
			")>
			<cfset start_invite = encodeForURL(dateformat(get_lesson.lesson_start,'yyyymmdd')&"T"&timeformat(get_lesson.lesson_start,'HHnnss')&"/"&dateformat(get_lesson.lesson_end,'yyyymmdd')&"T"&timeformat(get_lesson.lesson_end,'HHnnss'))>
			<cfset end_invite = "">
			<cfset link_go = "https://www.google.com/calendar/render?action=TEMPLATE&text=#text_invite#&details=#desc_invite#&dates=#start_invite#">

			&nbsp;
			<div class="pull-right"><a href="#link_go#" target="_blank"><img src="./assets/img/invite_gg.gif"></a></div>
			<!---&nbsp;
			<div class="pull-right"><a href="./invite/invite_ics.cfm?l_id=#lesson_id#" class="btn btn-sm btn-info" target="_blank">+iCal</a></div>
--->
			</cfif>
			<span class="badge badge-#get_lesson.status_css#" style="font-size:14px">#get_lesson.status_name#</span>
		</td>
	</tr>				
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_learner')#</label> 
		</th>
		<td colspan="2">
			<cfif get_lesson.method_id neq 12>
				
				<cfloop query="#get_user#">
					<cfif currentrow GT 1> - </cfif>
					<a href="common_learner_account.cfm?u_id=#get_user.user_id#">#get_user.user_firstname# #get_user.user_name#</a>
				</cfloop>

			<cfelse>
				<cfquery name="get_user_ops" datasource="#SESSION.BDDSOURCE#">
					SELECT user_id, user_firstname, user_name FROM `user` WHERE `user_id` = #get_lesson.user_id#
				 </cfquery>
				 <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<a href="common_trainer_account.cfm?p_id=#get_user_ops.user_id#">#get_user_ops.user_firstname# #get_user_ops.user_name#</a>
				 <cfelse>
					#get_user_ops.user_firstname# #get_user_ops.user_name#
				 </cfif>
			</cfif>
		</td>
	</tr>
	<cfif get_user.user_type_id eq "7">
	<tr>
		<th class="bg-light">
			<label>Gymglish link</label> 
		</th>
		<td colspan="2">
			<a target="_blank" href="#get_planner.user_gymglish_link#">#get_planner.user_gymglish_link#</a>
		</td>
	</tr>
	</cfif>
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_trainer')#</label> 
		</th>
		<td colspan="2">
			#obj_lms.get_thumb(user_id="#get_planner.user_id#",size="30")# #UCASE(get_planner.user_firstname)#
		</td>
	</tr>		
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_method')#</label> 
		</th> 
		<td colspan="2">
			#get_lesson.method_name#
		</td>
	</tr>
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_date')#</label>
		</th>
		<td colspan="2">
			#dateformat(get_lesson.lesson_start,'dd/mm/yyyy')#
		</td>
	</tr>
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_time')#</label>
		</th>
		<td colspan="2">
			#TimeFormat(get_lesson.lesson_start, "HH:mm")# - #TimeFormat(get_lesson.lesson_end, "HH:mm")#
		</td>
	</tr>
	<tr>
		<th class="bg-light">
			<label>#obj_translater.get_translate('table_th_duration')#</label>
		</th> 
		<td colspan="2">
			#get_lesson.lesson_duration#min
		</td>
	</tr>
	<tr>
		<th class="bg-light">
			<label><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></label>
		</th>
		<td colspan="2">
			#get_lesson.sessionmaster_name#
		</td>
	</tr>
	<tr>
		<th class="bg-light">
			<label><cfoutput>#obj_translater.get_translate('table_th_bookedby')#</cfoutput></label>
		</th>
		<td colspan="2">
			#get_lesson.booker_firstname#
			<cfif get_lesson.booker_date neq "">
			 - #obj_dater.get_dateformat(get_lesson.booker_date)# - #timeFormat(get_lesson.booker_date,'HH:mm')#
			</cfif>
		</td>
	</tr>
	<cfif get_lesson.updater_date neq "">
	<tr>
		<th class="bg-light">
			<label><cfoutput>#obj_translater.get_translate('table_th_updatedby')#</cfoutput></label>
		</th>
		<td colspan="2">
			#get_lesson.updater_firstname# - #obj_dater.get_dateformat(get_lesson.updater_date)# - #timeFormat(get_lesson.updater_date,'HH:mm')#
		</td>
	</tr>
	</cfif>

	<cfif get_lesson.method_id eq 12>
		<tr>
			<th class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_completedthe')#</cfoutput></label>
			</th>
			<td colspan="2">
				<cfif get_lesson.completed_date neq "">
					<cfif get_lesson.method_id eq 12>
						<div class="controls">
							<div class="input-group">
								<input id="ops_completed_date" name="ops_completed_date" type="text" class="datepicker form-control" value="#LSdatetimeformat(get_lesson.completed_date,'dd/mm/yyyy HH:nn', 'fr')#" />
								<label for="ops_completed_date" class="input-group-addon btn"><i class="fal fa-calendar-alt"></i></label>
							</div>
						</div>
					<cfelse>
						#dateformat(get_lesson.completed_date,'dd/mm/yyyy')#
					</cfif>
				<cfelse>
					-
				</cfif>
				
			</td>
		</tr>
	</cfif>

	


	<cfif _lesson_redirect neq "" AND get_lesson.method_id neq "2">
		<tr>
			<th class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_techno')#</cfoutput></label>
			</th>
			<td colspan="2">
				<i class="#_lesson_techno_icon#"></i>
				#_lesson_techno_name#
			</td>
		</tr>
	</cfif>
	<cfif _lesson_redirect_key neq "" AND get_lesson.method_id neq "2">
		<tr>
			<th class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_techno_key')#</cfoutput></label>
			</th>
			<td colspan="2">
				#_lesson_redirect_key#
			</td>
		</tr>
	</cfif>
	<cfif get_lesson.method_id eq "2">
	<tr>
		<th class="bg-light">
			<label><cfoutput>#ucase(obj_translater.get_translate('tooltip_view_ln'))#</cfoutput></label>
		</th>
		<td colspan="2">
			<a href="./tpl/ln_f2f_container.cfm?l_id=#lesson_id#" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> Lesson notes template</a><br>
		</td>
	</tr>
	</cfif>
	<tr>
		<th class="bg-light">
			<label><cfoutput>#obj_translater.get_translate('table_th_support')#</cfoutput></label>
		</th>
		<td colspan="2">
			<div class="row">
				<div class="col-md-4">
					<h6 class="text-info">#obj_translater.get_translate('modal_supports')#</h6>
					<cfset material_exists = 0>
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_WS.pdf")>
						<cfset material_exists = 1>
						<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_WS.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
					</cfif>
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_WSK.pdf")>
						<cfset material_exists = 1>
						<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_wsk')#</a><br>
					</cfif>	
					<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_WS.pptx")>
						<cfset material_exists = 1>
						<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_WS.pptx" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
					</cfif>
					</cfif>
					<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_WS.ppt")>
						<cfset material_exists = 1>
						<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_WS.ppt" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
					</cfif>
					<cfif material_exists eq "0">
						<span class="text-info"><em><small>#obj_translater.get_translate('alert_no_support')#</small></em></span>
					</cfif>
				</div>
				<div class="col-md-4">
					<h6 class="text-warning">#obj_translater.get_translate('modal_support_video')#</h6>
					<cfloop from="1" to="5" index="cor">
						<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO#cor#.mp4")>
							<cfset video = "1">
							<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_VIDEO#cor#.mp4" class="text-warning" target="_blank"><i class="fas fa-video"></i> #obj_translater.get_translate('modal_link_video')# #cor#</a><br>
						</cfif>
					</cfloop>
					<cfif not isdefined("video")>
					<span class="text-warning"><em><small>#obj_translater.get_translate('alert_no_video')#</small></em></span>
					</cfif>
				</div>
				<div class="col-md-4">
					<h6 class="text-danger">#obj_translater.get_translate('modal_support_audio')#</h6>
					<cfloop from="1" to="5" index="cor">
						<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_session_description.sessionmaster_ressource#_AUDIO#cor#.mp3")>
							<cfset audio = "1">
							<a href="./assets/materials/#get_session_description.sessionmaster_ressource#_AUDIO#cor#.mp3" class="text-danger" target="_blank"><i class="fas fa-volume-up"></i> #obj_translater.get_translate('modal_link_audio')# #cor#</a><br>
						</cfif>
					</cfloop>
					<cfif not isdefined("audio")>
					<span class="text-danger"><em><small>#obj_translater.get_translate('alert_no_audio')#</small></em></span>
					</cfif>
				</div>
			</div>
		</td>
	</tr>
</table>

<cfif SESSION.TP_CANCEL_PTA eq get_lesson.tp_id AND get_lesson.sessionmaster_id neq 694 AND (get_lesson.method_id neq "11" AND get_lesson.method_id neq "10")>
	<div style="color:red" >
		<strong>#obj_translater.get_translate('alert_pta_cancel_warning')#</strong>
	</div>
</cfif>



</cfoutput>


<cfoutput>

	<cfif SESSION.USER_PROFILE eq "TRAINER">	
		
		<cfif get_lesson.status_id eq "1">
			
			<div align="center">
			
			<cfif get_lesson.method_id neq "2">
				<!--- EVERY METHOD EXCEPT F2F --->
				<cfif get_lesson.lesson_start lt dateadd("h",+6,now())>
					<!--- <cfset rule_1 = "1"> --->
					<a href="##" class="btn btn-outline-red btn_force_cancel disabled" role="button">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				<cfelse>				
					<a href="updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&cancel=1" class="btn btn-outline-info <cfif get_cancel_count GTE 4 OR get_lesson.sessionmaster_id eq "695">disabled</cfif>" role="button">#obj_translater.get_translate('btn_cancel_slot')#</a>
				</cfif>
			
				<cfif now() gte dateadd("n",-15,get_lesson.lesson_start) AND now() lte dateadd("n",+15,get_lesson.lesson_start)>				
					<a href="gateway.cfm?token=1&lesson_id=#lesson_id#&ugo=#_lesson_redirect#" class="btn btn-outline-info" target="_blank">#obj_translater.get_translate('btn_launch_lesson')#**</a>
				<cfelse>
					<cfset rule_2 = "1">
					<a href="gateway.cfm?token=1&lesson_id=#lesson_id#&ugo=#_lesson_redirect#" class="btn btn-outline-info disabled" target="_blank">#obj_translater.get_translate('btn_launch_lesson')#**</a>
				</cfif>
			<cfelse>
			<!---- F2F --->
				<cfif get_lesson.lesson_start lt dateadd("h",+48,now())>
					<cfset rule_1 = "1">
					<a href="##" class="btn btn-outline-red btn_force_cancel" role="button">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				<cfelse>				
					<a href="updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&cancel=1" class="btn btn-outline-info <cfif get_cancel_count GTE 4>disabled</cfif>" role="button">#obj_translater.get_translate('btn_cancel_slot')#</a>
				</cfif>
				
			</cfif>
			</div>

			<cfif get_lesson.method_id neq "2">
			
				<cfif isdefined("rule_1")>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_6h_malus')#
					</cfoutput>
					
				<cfelse>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_before_6h')#
					</cfoutput>
					
				</cfif>
				
				<cfif isdefined("rule_2")>
					
					<cfoutput>
					<br>
					*#obj_translater.get_translate_complex('course_rule_launch')#
					</cfoutput>
					
				</cfif>
			
			<cfelse>
				
				<cfif isdefined("rule_1")>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_48h_malus')#
					</cfoutput>
					
				<cfelse>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_before_48h')#
					</cfoutput>
					
				</cfif>
			
			</cfif>

			<cfif get_cancel_count GTE 3>
				
				<!--- !! too many cancel message --->

			</cfif>
			
		</cfif>

	<cfelseif listFindNoCase("LEARNER,TEST", SESSION.USER_PROFILE)>
	
		<cfif (get_lesson.status_id eq "1" OR get_lesson.status_id eq "2") AND (get_lesson.method_id neq "11" AND get_lesson.method_id neq "10")>
			
			<div align="center">
			<cfif get_lesson.method_id neq "2">
			
				<cfif get_lesson.lesson_start lt dateadd("h",+6,now())>
					<cfset rule_1 = "1">
					<a href="##" class="btn btn-outline-red btn_force_cancel" role="button">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				<cfelse>
					<a href="updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&cancel=1" class="btn btn-outline-info">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				</cfif>
				
			<cfelse>
				
				<cfif get_lesson.lesson_start lt dateadd("h",+48,now())>
					<cfset rule_1 = "1">
					<a href="##" class="btn btn-outline-red btn_force_cancel" role="button">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				<cfelse>
					<a href="updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&cancel=1" class="btn btn-outline-info">#obj_translater.get_translate('btn_cancel_slot')#*</a>
				</cfif>
			
			</cfif>
		
			<!---<cfif now() gte dateadd("n",-15,get_lesson.lesson_start) AND now() lte dateadd("n",+15,get_lesson.lesson_start)>				
				<a href="gateway.cfm?token=1&lesson_id=#lesson_id#&ugo=#get_lesson.lesson_link#" class="btn btn-outline-info" target="_blank">#obj_translater.get_translate('btn_launch_lesson')#**</a>
			<cfelse>
				<cfset rule_2 = "1">
				<a href="gateway.cfm?token=1&lesson_id=#lesson_id#&ugo=#get_lesson.lesson_link#" class="btn btn-outline-info disabled" target="_blank">#obj_translater.get_translate('btn_launch_lesson')#**</a>
			</cfif>--->
			</div>

			
			<cfif get_lesson.method_id neq "2">
				<cfif isdefined("rule_1")>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_6h_lrn')#
					</cfoutput>
					
				<cfelse>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_before_6h')#
					</cfoutput>
					
				</cfif>
				
			<!----- F2F Rule --->
			<cfelse>
				<cfif isdefined("rule_1")>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_48h_lrn')#
					</cfoutput>
					
				<cfelse>
					
					<cfoutput>
					#obj_translater.get_translate_complex('cancel_course_before_48h')#
					</cfoutput>
					
				</cfif>			
			</cfif>
			
			<!---<cfif isdefined("rule_2")>
				<cfif SESSION.LANG_CODE eq "fr">
				<br><small><em>** Vous ne pouvez lancer un cours que 15 minutes avant et jusqu'&agrave; 15 minutes apr&egrave;s le cours.</em></small>
				<cfelseif SESSION.LANG_CODE eq "en">
				<br><small><em>** Starting the lesson is only possible 15 min before and 15 min after the expected time.</em></small>
				<cfelseif SESSION.LANG_CODE eq "es">
				<br><small><em>** Vous ne pouvez lancer un cours que 15 minutes avant et jusqu'&agrave; 15 minutes apr&egrave;s le cours.</em></small>
				<cfelseif SESSION.LANG_CODE eq "de">
				<br><small><em>** Die Stunde kann maximal 15 Minuten vor und nach der gebuchten Zeit in Anspruch genommen werden.</em></small>
				<cfelseif SESSION.LANG_CODE eq "it">
				<br><small><em>** Vous ne pouvez lancer un cours que 15 minutes avant et jusqu'&agrave; 15 minutes apr&egrave;s le cours.</em></small>
				</cfif>
			</cfif>--->
			
		</cfif>
		
		
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
			Action CS : 
			<select name="" class="form-control" id="select_action">
				<option value="">---Select---</option>
				<option value="scheduled" title="Schedules a lesson, making it active and booked to the date of its first booking." <cfif get_lesson.status_id eq "1">disabled</cfif>>Forcer schedule</option>
				<!---<option value="missed" <cfif get_lesson.status_id eq "4">disabled</cfif>>Forcer missed</option>---->
				<option value="missed_unbookable" title="Forces a lesson to be missed. Learner penalized. Time will be deduced from learner's TP."<cfif get_lesson.status_id eq "4">disabled</cfif>>Forcer missed</option>
				<option value="completed" title="Forces a lesson to be completed, regardless of whether it has actually been completed." <cfif get_lesson.status_id eq "5">disabled</cfif>>Forcer completed </option>
				<option value="cancelled" title="Cancels a lesson. When cancelled by CS, the 6hrs deadline doesnt apply. If you want to pass the lesson to missed, use 'forcer missed'."<cfif get_lesson.status_id eq "3">disabled</cfif>>Cancelled by learner</option>
				<option value="inprogress" title="Forces a lesson to be in progress: use this when a trainer forgets to press the launch button. Removes the launch button for learners and trainers."<cfif get_lesson.status_id eq "2">disabled</cfif>>Forcer in progress</option>
				<option value="erase" title="Cancels a lesson and the lesson information is erased and cannot be recovered!">Cancelled by trainer</option>

			</select>			
	
	</cfif>
	
</cfoutput>
</div>	


</cfform>

<cfif get_lesson.method_id eq "10">
	<div align="center">
	<cfoutput>
		<cfif isDefined("get_lesson.subscribed") AND get_lesson.subscribed eq 1>
			<button class="btn btn-sm btn-success float-right py-2 btn_join_class" data-tid="#get_lesson.tp_id#" data-lid="#lesson_id#">#obj_translater.get_translate('vc_unfollow_tp')#</button>
		<cfelse>
			<button class="btn btn-sm btn-warning float-right py-2 btn_join_class" data-tid="#get_lesson.tp_id#" data-lid="#lesson_id#">#obj_translater.get_translate('vc_comfirm_attendance')#</button>
		</cfif>
	</cfoutput>
	</div>
</cfif>

<script>

$(document).ready(function() {

	$("#ops_completed_date").datetimepicker({
		defaultDate: "+1w",
		changeMonth: true,
		dateFormat:"dd/mm/yy",
		timeFormat: "HH:mm",
		hourGrid:1,
		stepMinute:15,
		numberOfMonths: 3,
		firstDay: 1, 
		onClose: function(dateText) { 
			
			$.ajax({
			url: './api/users/user_trainer_post.cfc?method=update_completed_ops',
			type: 'POST',
			data: {
				l_id: <cfoutput>#lesson_id#</cfoutput>,
				date: dateText
			},
			success : function(result, status){
				alert("date modified");
			}
		});
		}
	})
	// .on('change', function (e) { 
	// 	console.log(e);
	// });


<cfif SESSION.USER_PROFILE eq "trainer">
	<cfif get_lesson.method_id neq "2">
		<cfif get_lesson.status_id eq "1" AND get_lesson.lesson_start lt dateadd("h",+6,now())>
		$('.btn_force_cancel').click(function(event) {			
			event.preventDefault();
			if(confirm("<cfoutput>#obj_translater.get_translate('js_cancel_confirm_trainer')#</cfoutput>"))
			{			
				<cfoutput>
				document.location.href='updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&fcancel=1';
				</cfoutput>		
			}		
		})
		</cfif>
	<cfelse>
		<cfif get_lesson.status_id eq "1" AND get_lesson.lesson_start lt dateadd("h",+6,now())>
		$('.btn_force_cancel').click(function(event) {			
			event.preventDefault();
			if(confirm("<cfoutput>#obj_translater.get_translate('js_cancel_confirm_trainer')#</cfoutput>"))
			{			
				<cfoutput>
				document.location.href='updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&fcancel=1';
				</cfoutput>		
			}		
		})
		</cfif>
	</cfif>
		
<cfelseif SESSION.USER_PROFILE eq "learner">
	
	<cfif get_lesson.method_id neq "2">
		<cfif get_lesson.status_id eq "1" AND get_lesson.lesson_start lt dateadd("h",+6,now())>
		$('.btn_force_cancel').click(function(event) {			
			event.preventDefault();
			if(confirm("<cfoutput>#obj_translater.get_translate('js_cancel_confirm_learner')#</cfoutput>"))
			{			
				<cfoutput>
				document.location.href='updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&fcancel=1';
				</cfoutput>		
			}		
		})	
		</cfif>
	<cfelse>
		<cfif get_lesson.status_id eq "1" AND get_lesson.lesson_start lt dateadd("h",+48,now())>
		$('.btn_force_cancel').click(function(event) {			
			event.preventDefault();
			if(confirm("<cfoutput>#obj_translater.get_translate('js_cancel_confirm_learner')#</cfoutput>"))
			{			
				<cfoutput>
				document.location.href='updater_lesson.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&fcancel=1';
				</cfoutput>		
			}
		
		})	
		</cfif>
	</cfif>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
	$('#select_action').change(function(event) {	
		var temp = $(this).val();

		var txt = "Confirmer action ?";
		<cfif SESSION.TP_CANCEL_PTA eq get_lesson.tp_id AND get_lesson.sessionmaster_id neq 694 AND (get_lesson.method_id neq "11" AND get_lesson.method_id neq "10")>
		if (temp == "cancelled") {
			txt += " Cela supprimera le PTA !"
		}
		</cfif>
		
		if(confirm(txt))
		{
			if(temp != "")
			{
				<cfoutput>
				document.location.href='updater_lesson_quick.cfm?t_id=#get_lesson.tp_id#&u_id=#u_id#&p_id=#p_id#&l_id=#lesson_id#&faction='+temp;
				</cfoutput>
			}	
		}
		
	});
	
</cfif>

})
	
</script>