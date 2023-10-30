<!--- TODO --->
<!--- <cfif not isdefined("hide_filter")> --->
<div id="container_trainer_select">

	<div class="row justify-content-md-center mt-3">

		<div class="col-md-12">

			<div class="card mb-2 border-bottom border-info">

				<div class="card-header" align="center">
					<cfoutput>
					<!--- <button class="btn btn-link d-none d-sm-block"> --->
						<!--- #obj_translater.get_translate('btn_choose_trainer')# --->
					<!--- </button> --->
					<!--- <button class="btn disabled btn-outline-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important">	 --->
						<!--- <h6 class="d-none d-sm-block">#obj_translater.get_translate('table_th_teaches')# : </h6><cfif teaching_criteria_id neq "0"><span class="lang-sm" lang="#teaching_criteria_code#"></span><cfelse>#obj_translater.get_translate('dont_care')#</cfif> --->
					<!--- </button> --->
					<!--- <button class="btn disabled btn-outline-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important">		 --->
						<!--- <h6 class="d-none d-sm-block">#obj_translater.get_translate('level')# : </h6><cfoutput>#u_level#</cfoutput> --->
					<!--- </button> --->
					<cfif (StructKeyExists(SESSION.USER_LEVEL,f_code) AND listFindNoCase("1,2", SESSION.USER_LEVEL[f_code].level_id) AND teaching_criteria_id eq 2) OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
						<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_speaking" aria-expanded="false" aria-controls="collapse_speaking">				
							<h6 class="d-none d-sm-block">#obj_translater.get_translate('table_th_speaks')# : </h6><cfif speaking_criteria_id neq "0"><span class="lang-sm" lang="<cfif isdefined("speaking_criteria_code")>#speaking_criteria_code#</cfif>"></span><cfelse>#obj_translater.get_translate('dont_care')#</cfif>
						</button>
					</cfif>
					<cfif SESSION.USER_ID==202>
					<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_expertise" aria-expanded="false" aria-controls="collapse_expertise">				
						<h6 class="d-none d-sm-block">expertise: </h6><i class="fa-light fa-screwdriver-wrench"></i>
					</button>
					</cfif>
					<!--- <cfif  teaching_criteria_id eq 2 AND not isdefined("hide_filter")>
					<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_nbtrainer" aria-expanded="false" aria-controls="collapse_nbtrainer">				
						<h6 class="d-none d-sm-block">#obj_translater.get_translate('table_th_mini_trainer_nb')# : </h6><cfif user_needs_nbtrainer eq "1">#obj_translater.get_translate('needs_txt_trainer_mono')#<cfelse>#obj_translater.get_translate('needs_txt_trainer_several')#</cfif>
					</button>
					</cfif> --->
					<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_avail" aria-expanded="false" aria-controls="collapse_avail">				
						<h6 class="d-none d-sm-block">#obj_translater.get_translate('table_th_availabilities')# : </h6><i class="fal fa-calendar-alt"></i><!---<cfoutput>#listlen(avail_id)#</cfoutput>--->
					</button>
					<cfif not isdefined("hide_filter")>
					<button class="btn btn-success btn_whotochoose p-2 p-xl-3">				
						<h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_whotochoose')#</h6>
						<i class="fal fa-thumbs-up"></i>
					</button>
					</cfif>
					<!--- <button class="btn btn-success btn_validate_step p-2 p-xl-3" disabled>				 --->
						<!--- <h6 class="d-none d-sm-block">#obj_translater.get_translate('btn_validate')#</h6> --->
						<!--- <i class="fal fa-check"></i> --->
					<!--- </button> --->
				
					</cfoutput>
				</div>
				
				<div class="card-body pt-0 pb-0">

					<cfif teaching_criteria_id eq 2 AND not isdefined("hide_filter")>
					<div class="collapse collapse_nbtrainer mb-2" data-parent="#container_trainer_select">
						<div class="row">
							<div class="col-12">
								<div class="p-2 border-top" align="center">
									<form id="form_user_need_nb">
										
										<label class="my-2"><input type="radio" name="user_needs_nbtrainer" id="user_needs_nbtrainer" value="1" <cfif user_needs_nbtrainer eq "1">checked</cfif> <cfif SESSION.USER_PROFILE eq "Test">disabled</cfif>> <cfoutput>#obj_translater.get_translate('needs_txt_trainer_mono')#</cfoutput></label>
										<label class="my-2"><input type="radio" name="user_needs_nbtrainer" id="user_needs_nbtrainer" value="2" <cfif user_needs_nbtrainer eq "2">checked</cfif>> <cfoutput>#obj_translater.get_translate('needs_txt_trainer_several')# (3 max.)</cfoutput></label>
										
										<input type="hidden" name="step" value="3">
										<input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>">
										<input type="hidden" name="speaking_criteria_id" value="<cfoutput>#speaking_criteria_id#</cfoutput>">
										<input type="hidden" name="avail_id" value="<cfoutput>#avail_id#</cfoutput>">
										<input type="submit" class="btn btn-info m-0" id="btn_update_need_nb" value="<cfoutput>#obj_translater.get_translate('btn_apply')#</cfoutput>">
										
									</form>	
								</div>
							</div>
						</div>
					</div>
					</cfif>
				
					<cfif (StructKeyExists(SESSION.USER_LEVEL,f_code) AND listFindNoCase("1,2", SESSION.USER_LEVEL[f_code].level_id)) OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<div class="collapse collapse_speaking mb-2" data-parent="#container_trainer_select">
						<div class="row">
							<div class="col-12">
								<div class="p-2 border-top" align="center">
									<form id="form_user_need_speak">
										<!--- <div class="float-left mr-3"> --->
										<label class="my-2"><input type="radio" name="speaking_criteria_id" id="speaking_criteria_id" value="0" <cfif speaking_criteria_id eq "0">checked</cfif>> <cfoutput>#obj_translater.get_translate('dont_care')#</cfoutput></label>
										<!--- </div> --->
										<cfoutput query="get_speaking_available">
										<!--- <div class="float-left mr-3"> --->
										<label class="my-2"><input type="radio" name="speaking_criteria_id" id="speaking_criteria_id" value="#formation_id#" <cfif listfind(formation_id,speaking_criteria_id)>checked</cfif>> <span class="lang-lg lang-lbl" lang="#formation_code#"></span></label>
										<!--- </div> --->
										</cfoutput>
										<!--- <div class="float-right"> --->
										<input type="hidden" name="step" value="3">
										<input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>">
										<input type="hidden" name="user_needs_nbtrainer" value="<cfoutput>#user_needs_nbtrainer#</cfoutput>">
										<input type="hidden" name="avail_id" value="<cfoutput>#avail_id#</cfoutput>">
										<input type="submit" class="btn btn-info m-0" id="btn_update_need_speak" value="<cfoutput>#obj_translater.get_translate('btn_apply')#</cfoutput>">
										<!--- </div> --->
									</form>	
								</div>
							</div>
						</div>									
					</div>
					</cfif>
			
			
					<div class="collapse collapse_avail mb-2" data-parent="#container_trainer_select">
						<div class="row">
							<div class="col-12">
								<div class="p-2 border-top" align="center">
									<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#")>
									<form id="form_user_avail">
										<div class="d-flex justify-content-center">
										<table class="table table-borderless w-50">
											<tr>
												<th></th>
												<cfoutput>
													<cfset day_avoid = 0> 
													<cfloop list="#listgo#" index="cor">
														<cfset day_avoid ++>
														<cfif day_avoid neq "7">
															<th align="center" class="text-center"><h5 class="m-0 d-inline"><span class="badge badge-info">#cor#</span></h5></th>
														</cfif>
													</cfloop>
												</cfoutput>
											</tr>
											<tr>
												<th class="font-weight-normal"><i class="fal fa-sunrise fa-lg text-info mr-2"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_morning')#</cfoutput></label></th>
												<td class="text-center"><input type="checkbox" name="avail_id" value="1" <cfif listfind(avail_id,"1")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="5" <cfif listfind(avail_id,"5")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="9" <cfif listfind(avail_id,"9")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="13" <cfif listfind(avail_id,"13")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="17" <cfif listfind(avail_id,"17")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="21" <cfif listfind(avail_id,"21")>checked</cfif>></td>
												<!--- <td class="text-center"><input type="checkbox" name="avail_id" value="25" <cfif listfind(avail_id,"25")>checked</cfif>></td> --->
											</tr>
											<tr>
												<th class="font-weight-normal"><i class="fal fa-sun-cloud fa-lg text-info mr-1"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_lunch')#</cfoutput></label></th>
												<td class="text-center"><input type="checkbox" name="avail_id" value="2" <cfif listfind(avail_id,"2")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="6" <cfif listfind(avail_id,"6")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="10" <cfif listfind(avail_id,"10")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="14" <cfif listfind(avail_id,"14")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="18" <cfif listfind(avail_id,"18")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="22" <cfif listfind(avail_id,"22")>checked</cfif>></td>
												<!--- <td class="text-center"><input type="checkbox" name="avail_id" value="26" <cfif listfind(avail_id,"26")>checked</cfif>></td> --->
											</tr>
											<tr>
												<th class="font-weight-normal"><i class="fal fa-sunset fa-lg text-info mr-2"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_afternoon')#</cfoutput></label></th>
												<td class="text-center"><input type="checkbox" name="avail_id" value="3" <cfif listfind(avail_id,"3")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="7" <cfif listfind(avail_id,"7")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="11" <cfif listfind(avail_id,"11")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="15" <cfif listfind(avail_id,"15")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="19" <cfif listfind(avail_id,"19")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="23" <cfif listfind(avail_id,"23")>checked</cfif>></td>
												<!--- <td class="text-center"><input type="checkbox" name="avail_id" value="27" <cfif listfind(avail_id,"27")>checked</cfif>></td> --->
											</tr>
											<tr>
												<th class="font-weight-normal"><i class="fal fa-house-night fa-lg text-info mr-1"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_evening')#</cfoutput></label></th>
												<td class="text-center"><input type="checkbox" name="avail_id" value="4" <cfif listfind(avail_id,"4")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="8" <cfif listfind(avail_id,"8")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="12" <cfif listfind(avail_id,"12")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="16" <cfif listfind(avail_id,"16")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="20" <cfif listfind(avail_id,"20")>checked</cfif>></td>
												<td class="text-center"><input type="checkbox" name="avail_id" value="24" <cfif listfind(avail_id,"24")>checked</cfif>></td>
												<!--- <td class="text-center"><input type="checkbox" name="avail_id" value="28" <cfif listfind(avail_id,"28")>checked</cfif>></td> --->
											</tr>
										</table>
										</div>

										<!--- <div class="float-right"> --->
											<input type="hidden" name="step" value="3">
											<input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>">
											<input type="hidden" name="speaking_criteria_id" value="<cfoutput>#speaking_criteria_id#</cfoutput>">
											<input type="hidden" name="user_needs_nbtrainer" value="<cfoutput>#user_needs_nbtrainer#</cfoutput>">
											<input type="submit" class="btn btn-info" id="btn_update_avail" value="<cfoutput>#obj_translater.get_translate('btn_apply')#</cfoutput>">
										<!--- </div> --->
									</form>
								</div>		
							</div>											
						</div>
					</div>

				</div>

			</div>

		</div>

	</div>

</div>
<!--- </cfif> --->

<div id="container_trainer_list">

	<cfif get_trainer.recordcount eq "0" OR t_list eq "">

		<div class="alert bg-dark" role="alert">
			<div class="text-center">
			<em><cfoutput>#obj_translater.get_translate('alert_no_trainer_corresponding')#</cfoutput></em>
			<br><br>
			<span class="badge badge-pill badge-info p-2 text-white btn_contact_wefit cursored"><i class="fas fa-phone" aria-hidden="true"></i>&nbsp; <cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput></span>
			</div>
		</div>

	<cfelse>

		<cfquery name="get_trainer_go" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
		c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
		s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
		FROM user u
		LEFT JOIN settings_country c ON c.country_id = u.country_id
		LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
		WHERE user_id IN (#t_list#) ORDER BY FIELD(user_id,#t_list#)
		</cfquery>

		<div class="row justify-content-md-center mt-3 mb-1">
			<div class="col-md-12">

				<!--- <div align="center"> --->
					<!--- <cfoutput> --->
						<!--- <a class="btn btn-link <cfif display eq "video">text-info</cfif>" href="learner_launch_3.cfm?teaching_criteria_id=#teaching_criteria_id#&speciality_criteria_id=#speciality_criteria_id#&display=video" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('trainer_view_video')#"><i class="fal fa-photo-video fa-2x"></i></a> --->
						<!--- <a class="btn btn-link <cfif display eq "aboutme">text-info</cfif>" href="learner_launch_3.cfm?teaching_criteria_id=#teaching_criteria_id#&speciality_criteria_id=#speciality_criteria_id#&display=aboutme" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('trainer_view_about')#"><i class="fal fa-align-justify fa-2x"></i></a> --->
						<!--- <a class="btn btn-link <cfif display eq "agenda">text-info</cfif>" href="learner_launch_3.cfm?teaching_criteria_id=#teaching_criteria_id#&speciality_criteria_id=#speciality_criteria_id#&display=agenda" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('trainer_view_avails')#"><i class="fal fa-calendar-alt fa-2x"></i></a> --->
					<!--- </cfoutput> --->
				<!--- </div> --->
				
				<h5 align="center"> 
					<cfoutput>#obj_translater.get_translate('title_trainer_selection')#</cfoutput> : <span style="cursor:pointer" class="badge badge-info" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('text_trainer_chosen')#</cfoutput>">?</span>
				</h5>

				<cfoutput query="get_trainer_go">

					<cfinclude template="./wid_trainer_details.cfm">

				</cfoutput>		
				
			</div>
		</div>

	</cfif>
						
</div>