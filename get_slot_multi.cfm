<cfparam name="t_id">
<cfsilent>

	<cfset SESSION.TP_ID = t_id>
	<!------- SCAN ALREADY ATTACHED Ts ------>
	<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>

	<cfif get_trainer.recordCount eq 0>

		<cfif SESSION.USER_PROFILE eq "TEST" AND SESSION.USER_TYPE_ID eq 8>

			<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
				SELECT u.user_id as planner_id, u.user_firstname as planner, u.user_shortlist as planner_shortlist, u.user_email as planner_email
				FROM user u
				INNER JOIN user_ready ur ON ur.user_id = u.user_id
				WHERE user_ready_assessment = 1
				AND u.user_status_id = 4
			</cfquery>
		<cfelseif SESSION.USER_PROFILE eq "TEST">

			<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
				SELECT u.user_id as planner_id, u.user_firstname as planner, u.user_shortlist as planner_shortlist, u.user_email as planner_email
				FROM user u
				INNER JOIN user_ready ur ON ur.user_id = u.user_id
				WHERE user_ready_test = 1
				AND u.user_status_id = 4
			</cfquery>

		</cfif>

	</cfif>

	<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#",m_id="1,2,7,10,11")>

	<!--- <cfset tp_date_start = dateformat(get_tp.tp_date_start,'yyyy-mm-dd')>
	<cfset tp_date_end = dateformat(get_tp.tp_date_end,'yyyy-mm-dd')> --->

	<cfset SESSION.tp_date_start = dateformat(get_tp.tp_date_start,'yyyy-mm-dd')>
	<cfset SESSION.tp_date_end = dateformat(get_tp.tp_date_end,'yyyy-mm-dd')>

	<cfset session_length = get_tp.tp_session_duration>

	<cfset __shortminute = obj_translater.get_translate('short_minute')>

	<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#",l_by="yes")>

	<cfset SESSION.booking_array = {}>
	<cfset nodeletelist = "">

	<cfset s_dur = 30>
	<cfoutput query="get_session" group="session_id">
		<cfif s_dur lt get_session.session_duration>
			<cfset s_dur = get_session.session_duration>
		</cfif>
		<cfoutput group="lesson_id">
			<cfif lesson_id neq "">
				
				<cfif !listFindNoCase(nodeletelist, planner_id)>
					<cfset nodeletelist = listAppend(nodeletelist, planner_id)>
				</cfif>

				<cfif not structKeyExists(SESSION.booking_array, dateformat(lesson_start,'yyyy-mm-dd'))>
					<cfset SESSION.booking_array[dateformat(lesson_start,"yyyy-mm-dd")] = [{
						date: '#dateformat(lesson_start,"yyyy-mm-dd")#',
						hour: '#timeformat(lesson_start,'HH')#',
						min: '#timeformat(lesson_start,'mm')#',
						id: planner_id,
						l_id: lesson_id
					}]>
				<cfelse>
					<cfset arrayAppend(SESSION.booking_array[dateformat(lesson_start,"yyyy-mm-dd")], {
						date: '#dateformat(lesson_start,"yyyy-mm-dd")#',
						hour: '#timeformat(lesson_start,'HH')#',
						min: '#timeformat(lesson_start,'mm')#',
						id: planner_id,
						l_id: lesson_id
					})>

					<cfscript>
                        arraySort(SESSION.booking_array[dateformat(lesson_start,"yyyy-mm-dd")], function (e1, e2){
                            return compare("#e1.hour#:#e1.min#", "#e2.hour#:#e2.min#");
                        });
                    </cfscript>
				</cfif>

				
			</cfif>
		</cfoutput>
	</cfoutput>

	<!--- <cfset s_dur = get_session.session_duration>
	<cfif s_dur eq "">
		<cfset s_dur = 60>
	</cfif> --->

	<cfset interval = "2,3,4,5,6">

	<!--- // TODO --->
	

</cfsilent>

<head>

	<style>
		
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
		.selected_rk {
			border-bottom: solid;
			border-bottom-width: 5px;
			border-bottom-color: #fbc658;
		}
		.card {
			border-radius: 2px !important;
			box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
		}

		#sortable { 
			list-style-type: none !important; 
			margin: 0  !important; 
			padding: 0  !important; 
			width: 100%;  
		}
		#sortable li {
			float:left; 
			min-width:70px; 
			text-align:center
		}
	</style>
	
</head>



	<!--- <i class="fal fa-sunrise fa-lg text-info mr-2" aria-hidden="true"></i> <label>Matin : 7h/12h</label></th>
		
			
			<i class="fal fa-sun-cloud fa-lg text-info mr-1" aria-hidden="true"></i> <label>Midi : 12h/15h</label></th>
			
			<i class="fal fa-sunset fa-lg text-info mr-2" aria-hidden="true"></i> <label>Après-midi : 15h/19h</label></th>
			
			<i class="fal fa-house-night fa-lg text-info mr-1" aria-hidden="true"></i> <label>Soirée : 19h/22h</label></th> --->
					
					
			
						<!--- // TODO look into why btn-group-toggle does not work  --->
						
						<!--- <div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-sm btn-outline-info font-weight-normal active">
							<input class="day_interval" type="checkbox" name="day_interval" checked value="2"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],1)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal active">
							<input class="day_interval" type="checkbox" name="day_interval" checked value="3"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],2)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal active">
							<input class="day_interval" type="checkbox" name="day_interval" checked value="4"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],3)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal active">
							<input class="day_interval" type="checkbox" name="day_interval" checked value="5"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],4)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal active">
							<input class="day_interval" type="checkbox" name="day_interval" checked value="6"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],5)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal">
							<input class="day_interval" type="checkbox" name="day_interval" value="7"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],6)#
							</label>
							<label class="btn btn-sm btn-outline-info font-weight-normal">
							<input class="day_interval" type="checkbox" name="day_interval" value="1"> #listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],7)#
							</label>
						</div>
						<button type="submit" class="btn btn-sm btn-info mb-0" id="btn_update_day_interval"><i class="fa-light fa-arrows-rotate"></i></button> --->






<div id="container_solo" class="collapse show">
	<div class="row">
		<div class="col-md-12" style="padding-right: 0px !important">

			<cfoutput query="get_trainer">

				<cfset user_id = planner_id>
				<cfset user_firstname = planner>

				<cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE) OR SESSION.USER_PROFILE eq "trainer" AND user_id eq SESSION.USER_ID>
			
				<cfset "date_ref_#user_id#" = now()>
		
				<!---- OBJ QUERIES--->
				<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
				<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
				<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
				
				<!---- HARD QUERIES--->
				<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
					SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
				</cfquery>

				<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
					SELECT COUNT(tpp.planner_id) as nb FROM lms_tpplanner tpp WHERE tpp.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				</cfquery>
				<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
					SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				</cfquery>

				<cfquery name="get_stats" datasource="#SESSION.BDDSOURCE#">
					SELECT ls.status_name_fr, b.nb FROM lms_lesson_status ls
					LEFT JOIN (

						SELECT COUNT(*) as nb, l.status_id
						FROM lms_lesson2 l
						WHERE l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">

						GROUP BY l.status_id

					) b ON b.status_id = ls.status_id

					ORDER BY ls.status_id
				</cfquery>
		
				
				<div class="card border">
					<div class="card-body" style="min-height: 250px">
						<div class="row">
							<div class="col-md-2">
								<div class="p-2">
											

									<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>
										<div align="center">#obj_lms.get_thumb_border(user_id="#user_id#",size="100",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#</div>
										<!--- <video controls width="100%" height="180" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>poster="./assets/user/#user_id#/photo.jpg"</cfif>>
											<source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4"> --->
												<!--- <p> --->
												<!--- <cfset user_id = get_trainer_go.user_id> --->
												<!--- <cfset arr = ['SESSION.BO_ROOT_URL', 'user_id']> --->
												<!--- <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->
												<!--- #obj_translater.get_translate_complex(id_translate="download_trainer_video", argv="#argv#")#</p> --->
										<!--- </video> --->
									<cfelse>
										<div align="center" class="mt-4">
											<h2 class="text-muted"><i class="fal fa-stopwatch fa-lg"></i></h2>																							
											#obj_translater.get_translate('coming_soon')#
										</div>
									</cfif>
									<div align="center" class="mt-1">
										<strong style="font-size:18px" class="text-dark">#user_firstname# </strong>
										<!--- <br>
										<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> Corporate Trainer --->
									</div>
									<cfif isDefined("SESSION.show_delete_trainer") AND SESSION.show_delete_trainer eq 1>
										<div align="center" class="mt-1">
											<!--- <a class="btn btn-outline-red btn-sm btn_del_trainer" id="trainer_#user_id#"><i class="fa fa-times" aria-hidden="true"></i> </a> --->
											
											<cfif isDefined("step") AND step eq "3">
												<!--- <button class="btn btn-outline-red btn-sm btn_view_trainer" id="trainerdetail_#user_id#">
													<i class="fal fa-address-card"></i> --->


													
													<a class="btn btn-sm btn-link text-info btn_view_trainer m-0 p-0 pt-1" id="trainerdetail_#user_id#">
														[Info]
													</a>


													<!--- #obj_translater.get_translate('btn_view_profile')#
												</button>											 --->
											</cfif>
											

											<cfif (listFindNoCase("1,2,3,4", get_tp.formation_id)) AND get_tp.method_id neq "11">
												<cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE) AND (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND get_tp.method_id neq "2">
													<a class="btn btn-sm btn-link text-red <cfif listFindNoCase(nodeletelist, user_id)>disabled<cfelse>btn_del_trainer</cfif> m-0 p-0 pt-1" id="trainer_#user_id#"> [#obj_translater.get_translate("btn_remove")#] </a>
													
													
													
													<!--- <button class="btn btn-outline-red btn-sm <cfif listFindNoCase(nodeletelist, user_id)>
														disabled
													<cfelse>
														btn_del_trainer
													</cfif>" id="trainer_#user_id#">#obj_translater.get_translate('btn_remove')#</button> --->
												</cfif>
											</cfif>
										</div>
									</cfif>
								</div>
							</div>
							<div class="col-md-10 col-12">
								<div class="p-2">

									<div id="avail_container_#user_id#">			
										<cfinclude template="./incl/incl_calendar_week_slot.cfm">
									</div>
									
								</div>
							</div>	
						</div>
					</div>
				</div>
			</cfif>

			</cfoutput>

	</div>


	<!--- <div class="col-md-3" style="max-width: 100% !important;">

		
		<div class="card border">
			<div class="card-body">

				<div class="row">
					<div class="col-md-12">		

						<div id="div_content">
							<table id="table_tp" class="table table-sm mt-3" width="100%">
								<tbody id="tbody_sortable"> 
									<cfif get_session.recordcount neq "0">

										<cfoutput query="get_session" group="session_id">

											<cfif lesson_id neq "">
												<tr id="tr_#session_rank#">
													<!--- <td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td> --->
													<td>	
														<h5 class="d-inline" style="font-size:16px">
															<span <cfif status_id eq 1 OR status_id eq "">id="rkl_#session_rank#"</cfif> class="badge <cfif status_id eq 1 OR status_id eq "">badge-warning btn_display_session<cfelse>disabled badge-primary</cfif> text-white display_text_action font-weight-normal pr-3" style="cursor:pointer;">
																<img src="./assets/user/#planner_id#/photo.jpg" class="tthumb_#session_rank#" width="30" title="" style="border-radius:50%; border: 2px solid ##8A2128 !important; margin-right:3px" align="left">
																<small>#obj_translater.get_translate('table_th_course')#</small>
																<span id="rkl_textnb_#session_rank#"><strong>#session_rank#</strong></span> 
																<br>
																<strong>#session_duration# #__shortminute#</strong>
															</span>
														</h5>
													</td>
													<td>									
														<span <cfif status_id eq 1 OR status_id eq "">id="rkl_text_#session_rank#"</cfif> style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 32ch;">
															#lsDateTimeFormat(lesson_start,'dd/mm ', 'fr')#
														<!--- </br> --->
															#lsDateTimeFormat(lesson_start,'HH:nn', 'fr')#
														</span>
													</td>
													<td>
														<a <cfif status_id eq 1 OR status_id eq "">id="btns_#session_rank#"</cfif> class="btn <cfif status_id eq 1 OR status_id eq "">btn-warning btn_del_session<cfelse>disabled btn-secondary</cfif> btn-sm float-right"><i class="far fa-times"></i></a>
													</td>
												</tr>
											<cfelse>
												<tr id="tr_#session_rank#">
													<!--- <td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td> --->
													<td>	
														<h5 class="d-inline" style="font-size:16px">
															<span id="rkl_#session_rank#" class="badge display_text_action font-weight-normal btn_display_session pr-3" style="cursor:pointer;">
																<img src="./assets/img/unknown_male.png" class="tthumb_#session_rank#" width="30" title="" style="border-radius:50%; border: 2px solid ##8A2128 !important; margin-right:3px" align="left">
																
																<small>#obj_translater.get_translate('table_th_course')#</small>
																<span id="rkl_textnb_#session_rank#"><strong>#session_rank#</strong></span> 
																<br>
																<strong>#session_duration# #__shortminute#</strong>
															</span>
														</h5>
													</td>
													<td>
														<span id="rkl_text_#session_rank#"  style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 32ch;">
														</span>
													</td>
													<td>
														<a id="btns_#session_rank#" class="btn btn-warning btn_del_session disabled btn-secondary btn-sm float-right"><i class="far fa-times"></i></a>
													</td>
												</tr>
											</cfif>
											

											<!--- <cfif currentrow eq recordcount AND sessionmaster_id neq "694">
												<tr class="unsortable bg-light last_tr"></tr>
											</cfif> --->

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
	</div> --->
</div>