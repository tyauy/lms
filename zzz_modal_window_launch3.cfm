<cfparam name="show_info" default="display_launch">

<cfif show_info eq "display_launch">

	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>	
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>
	
	<cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level = evaluate("SESSION.USER_QPT_#ucase(f_code)#")>
		<cfset u_level_letter = mid(u_level,1,1)>
	<cfelse>
		<cfset u_level = "N/A">
		<cfset u_level_letter = "N/A">
	</cfif>
	
	<cfset list_lang = "fr,en,de,es">
	<cfset list_lang_id = "1,2,3,4">
		
	<cfif isdefined("SESSION.AVAIL_ID") AND SESSION.AVAIL_ID neq "">
		<cfset avail_id = SESSION.AVAIL_ID>
	<cfelse>
		<cfset avail_id = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28">
	</cfif>

	<cfif isdefined("SESSION.USER_NEEDS_NBTRAINER") AND SESSION.USER_NEEDS_NBTRAINER neq "">
		<cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER>
	<cfelse>
		<cfset user_needs_nbtrainer = "2">
	</cfif>

	<cfif isdefined("SESSION.USER_NEEDS_SPEAKING_ID") AND SESSION.USER_NEEDS_SPEAKING_ID neq "">
		<cfset user_needs_speaking_id = SESSION.USER_NEEDS_SPEAKING_ID>
	<cfelse>
		<cfset user_needs_speaking_id = "0">
	</cfif>
	<!--- user_needs_nbtrainer = <cfoutput>#user_needs_nbtrainer#</cfoutput> --->

	<!--- TODO <cfif trainercount GT 3 OR f_id eq 2> --->
	<cfif f_id eq 2>
	<div class="alert bg-light text-dark border" role="alert">
		<div class="media">
			<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
			<div class="media-body">
			<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_trainer')#</cfoutput>
			</div>
		</div>
	</div>
	</cfif>
	
	<div class="accordion mt-4" id="accordion_trainer">
					
		<div class="card border border-info" style="background-color:#FCFCFC">
		
			<div class="card-header">
			
				<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_item_1" aria-expanded="true" aria-controls="collapse_item_1">
					<h5 class="my-1 text-info" align="center">
					<!--- <cfif trainercount GT 3 OR f_id eq 2> --->
					<cfif f_id eq 2>
						<cfoutput>#obj_translater.get_translate('accordion_trainer_choose')#</cfoutput>
					<cfelse>
						<cfoutput>#obj_translater.get_translate('accordion_trainer_choose_ol')#</cfoutput>
					</cfif>
					</h5>
				</button>

				<div id="collapse_item_1" class="collapse show pb-2" data-parent="#accordion_trainer">
				
					<form action="learner_launch_3.cfm" method="post">
					<table class="table table-borderless bg-white m-0">

						<!--- <cfif trainercount GT 3 OR f_id eq 2> --->
						<cfif f_id eq 2>
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_mini_trainer_nb')#<br><small>#obj_translater.get_translate('needs_txt_trainer_advise')#</small></cfoutput></td>
								<td colspan="2">
								<div class="btn-group-toggle" data-toggle="buttons">	
	
									<label class="btn btn-sm btn-outline-info <cfif user_needs_nbtrainer eq "2">active</cfif>"><input type="radio" name="user_needs_nbtrainer" id="user_needs_nbtrainer" value="2" autocomplete="off" <cfif user_needs_nbtrainer eq "2">checked</cfif>> 
									<h2 class="my-2"><i class="fal fa-users-class"></i></h2>
									<h5 class="m-0"><cfoutput>#obj_translater.get_translate('needs_txt_trainer_several')#</cfoutput></h5>
									</label>
									
									<label class="btn btn-sm btn-outline-info <cfif user_needs_nbtrainer eq "1">active</cfif>"><input type="radio" name="user_needs_nbtrainer" id="user_needs_nbtrainer" value="1" autocomplete="off" <cfif user_needs_nbtrainer eq "1">checked</cfif>>
									<h2 class="my-2"><i class="fal fa-chalkboard-teacher"></i></h2>
									<h5 class="m-0"><cfoutput>#obj_translater.get_translate('needs_txt_trainer_mono')#</cfoutput></h5>
									</label>
	
								</div>
								</td>
							</tr>
						
						
						

						
							<!----- GIVE OPTION ONLY FOR LOW LEVEL ---->
							<cfif u_level eq "A0" OR u_level eq "A1" OR u_level eq "A2">
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('needs_trainer_speaks')#<br><small>#obj_translater.get_translate('needs_txt_advise')#</cfoutput></small></td>
								<td colspan="2">
										<label><input type="radio" name="user_needs_speaking_id" value="0" <cfif user_needs_speaking_id eq "0">checked</cfif>> <cfoutput>#obj_translater.get_translate('dont_care')#</cfoutput></label>
									<cfoutput>
									<cfloop list="#list_lang_id#" index="cor">
									<cfif isdefined("f_id")>
										<cfif cor neq f_id>
										<label><input type="radio" name="user_needs_speaking_id" value="#cor#" <cfif listlen(user_needs_speaking_id) neq "" AND listfind(user_needs_speaking_id,cor)>checked</cfif>> <span class="lang-sm lang-lbl" lang="#listgetat(list_lang,cor)#"></span></label>&nbsp;&nbsp;&nbsp;
										</cfif>
									<cfelse>
										<label><input type="radio" name="user_needs_speaking_id" value="#cor#" <cfif listlen(user_needs_speaking_id) neq "" AND listfind(user_needs_speaking_id,cor)>checked</cfif>> <span class="lang-sm lang-lbl" lang="#listgetat(list_lang,cor)#"></span></label>&nbsp;&nbsp;&nbsp;
									</cfif>
									</cfloop>
									</cfoutput>
								</td>
							</tr>
							</cfif>
						<cfelse>
							<input type="hidden" name="user_needs_nbtrainer" id="user_needs_nbtrainer" value="2">
						</cfif>
						
						<tr>
							<td class="bg-light" width="30%">
								<cfoutput>#obj_translater.get_translate('table_th_mini_avail')# </cfoutput> <span style="color:#FF0000">*</span>
								
								<i class="align-self-center fas fa-info-circle fa-lg mr-3 text-info" style="cursor:pointer" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('needs_availability')#</cfoutput>"></i>
								
							</td>
							<td colspan="2">
								<cfset edit_avail = "1">
								<cfset remove_day = "6">
								<cfinclude template="./widget/wid_user_availability.cfm">
							</td>
						</tr>
						
					</table>

					<cfoutput>
					<input type="hidden" name="trainer_choice" value="1">
					<div align="center"><button type="submit" class="btn btn-lg btn-outline-red">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button></div>
					</cfoutput>

					</form>
				
				</div>
			
			</div>
			
		</div>

	</div>

<script>

$('[data-toggle="tooltip"]').tooltip();

</script>
	
	

	

























<cfelseif (show_info eq "choose_trainer" OR show_info eq "chooseforme_trainer") AND isdefined("t_id") AND isdefined("u_id") AND (isdefined("p_list") OR isdefined("t_list")) AND isdefined("user_needs_nbtrainer")>

	<cfif isdefined("t_list")>

		<p class="alert bg-light text-dark border">
		<cfoutput>#obj_translater.get_translate_complex('text_trainer_chosen')#</cfoutput>
		</p>

		<cfoutput>
			<cfif isdefined("ol")>
				<p class="pt-0 mt-0" align="center"><small>#obj_translater.get_translate('title_trainer_chosen_ol')#</small></p>
			<cfelse>
				<p class="pt-0 mt-0" align="center"><small>#obj_translater.get_translate('title_trainer_chosen')#</small></p>
			</cfif>
		</cfoutput>

		<cfif user_needs_nbtrainer eq "1">
			<cfset max_t = "1">
			<cfset tmp_list = "#listgetat(t_list,1)#">
		<cfelseif listlen(t_list) eq "1">
			<cfset max_t = "3">
			<cfset tmp_list = "#listgetat(t_list,1)#">
		<cfelseif listlen(t_list) eq "2">
			<cfset max_t = "3">
			<cfset tmp_list = "#listgetat(t_list,1)#,#listgetat(t_list,2)#">
		<cfelse>
			<cfset max_t = "3">
			<cfset tmp_list = "#listgetat(t_list,1)#,#listgetat(t_list,2)#,#listgetat(t_list,3)#">
		</cfif>
		
		<cfset get_planner = obj_query.oget_planner(p_list="#tmp_list#")>
	
	<cfelse>
	
		<cfoutput>
			<div class="alert bg-light text-dark border" role="alert">
				<div class="media">
					<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
					<div class="media-body">
						<cfif listlen(p_list) eq "1">
						#obj_translater.get_translate('js_modal_title_trainer_choose_solo')#
						<cfelse>
						#obj_translater.get_translate('js_modal_title_trainer_choose')#
						</cfif>
					</div>
				</div>
			</div>
		</cfoutput>
		
		<cfset get_planner = obj_query.oget_planner(p_list="#p_list#")>

	</cfif>
	
	
	
		<cfoutput query="get_planner">
		<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
		<div class="card border">
			<div class="card-body">
				<div class="row align-items-center">
				<div class="col-md-2" align="center">
				<!--- <cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_lg flag-#lcase(country_alpha)#"></cfif> --->
					<!--- <br> --->
					<strong style="font-size:18px" class="text-dark">#user_firstname#</strong>
				</div>
				<div class="col-md-4" align="center">
					<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
						<img src="./assets/user/#user_id#/photo.jpg" class="rounded-circle" width="120">
					<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
						<img src="./assets/user/#user_id#/photo.png" class="rounded-circle" width="120">
					<cfelse>
						<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
							SELECT user_gender FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
						</cfquery>
						<cfif get_gender.user_gender eq "M.">
							<img src="./assets/img/unknown_male.png" class="rounded-circle" width="120">
						<cfelse>
							<img src="./assets/img/unknown_female.png" class="rounded-circle" width="120">
						</cfif>
					</cfif>
					
				
				</div>
				<div class="col-md-6">
					<cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
						<cfinvokeargument name="u_id" value="#user_id#">
					</cfinvoke>
					<cfset planner_view = "view_toggle_vertical_read_tiny">
					<cfset remove_day = "6">
					<cfinclude template="./widget/wid_planner.cfm">
				</div>
				</div>
			</div>
		</div>
		</cfoutput>
		
		<cfif user_needs_nbtrainer eq "2" && get_planner.recordcount lt 3 and not isdefined("ol")>
		<cfset remaining_trainer = 3-get_planner.recordcount>
		
		<cfloop from="1" to="#remaining_trainer#" index="cor">
		<div class="card border">
			<div class="card-body">
				<div class="row align-items-center">
					<div class="col-md-2" align="center">
				
					</div>
					<div class="col-md-4" align="center">
						<i class="fal fa-plus fa-2x bg-light" style="padding:40px; border-radius: 50%;" data-dismiss="modal"></i>
					</div>
					<div class="col-md-6">
					</div>
				</div>
			</div>
		</div>
		</cfloop>
		</cfif>
	

	
	
<cfoutput>
<div class="m-2 p-2 mt-auto" align="center">
<form action="updater_form.cfm" method="post">
<cfif isdefined("t_list")>
<input type="hidden" name="p_list" value="#tmp_list#">
<cfelse>
<input type="hidden" name="p_list" value="#p_list#">
</cfif>
<input type="hidden" name="u_id" value="#u_id#">
<input type="hidden" name="t_id" value="#t_id#">
<input type="hidden" name="form_type" value="affect_trainer">
<button type="submit" class="btn btn-lg btn-outline-red" <cfif get_planner.recordcount eq 0>disabled</cfif>> #obj_translater.get_translate('btn_book_na')# <i class="far fa-chevron-double-right"></i></button>
</form>
</div>
</cfoutput>

</cfif>

<script>
	$(document).ready(function() {
		
		// $('.btn_contact_wefit').hide();
		// ('.btn_contact_wefit_modal').click(function(event) {	

		// 	let go_u = 1;
		// 	let go_o = 1;

		// 	$('#window_item_xl_unclosable').modal('hide');

		// 	$('#window_item_xl_unclosable').on('hidden.bs.modal', function (e) {
		// 		if (go_u) {
		// 			go_u = 0;
		// 			$('#window_item_ctc').modal({keyboard: true});
		// 			$('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
		// 			<cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST">
		// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});
		// 			<cfelseif SESSION.USER_PROFILE eq "TRAINER">
		// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=t", function() {});
		// 			<cfelseif SESSION.USER_PROFILE eq "TM">
		// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=tm", function() {});
		// 			</cfif>
		// 		}
		// 	});

		// 	$('#window_item_ctc').on('hidden.bs.modal', function (e) {
		// 		if (go_o) {
		// 			go_o = 0;
		// 			$('#window_item_xl_unclosable').modal('show');
		// 		}
		// 	});
		// });
	});

</script>