<!DOCTYPE html>

<cfparam name="m_id" default="10">
<cfparam name="st_id" default="1,2">

<cfsilent>
	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">	
		
	<cfset get_tp_group = obj_tp_get.oget_tps(st_id=st_id,m_id="11",no_users="1")>
	<cfset get_tp_virtual = obj_tp_get.oget_tps(st_id=st_id,m_id="10",no_users="1")>

	<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
		SELECT tp_status_id , tp_status_name_#SESSION.USER_LANG# as status_name FROM lms_tpstatus
	</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
		.tp_row {
			display:none;
		}
	</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Liste TP">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content" id="container_main">

			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item">
					<a href="#tp_virtual" class="nav-link <cfif m_id eq 10>active</cfif>" role="tab" data-toggle="tab" <cfif m_id eq 10>aria-selected="true"</cfif> align="center">
						<i class="fa-light fa-screen-users"></i><br>VIRTUAL CLASSROOM
					</a>
				</li>
				<li class="nav-item">		
					<a href="#tp_group" class="nav-link <cfif m_id eq 11>active</cfif>" role="tab" data-toggle="tab" <cfif m_id eq 11>aria-selected="true"</cfif>  align="center">
						<i class="fa-light fa-users"></i><br>TP GROUP
					</a>
				</li>
				<!---<li class="nav-item">
					<button class="btn btn-success btn_learner_add_tp p-2 p-xl-3" align="center"><i class="fal fa-plus"></i></button>
				</li>--->
				<li class="nav-item">
					<button class="btn btn-info font-weight-normal p-2 p-xl-3" style="text-transform:none !important" data-toggle="collapse" data-target=".collapse_setting" aria-expanded="false" aria-controls="collapse_setting">
						<i class="fal fa-gear"></i>
					</button>
				</li>
			</ul>

			<div class="tab-content">

				<div class="collapse collapse_setting mb-2" data-parent="#container_main">
					<div class="row">
						<div class="col-12">
							<div class="p-2 border-top" align="center">
								<cfform action="cs_list_tp.cfm" method="post">
									<div class="row">	

										<div class="col-md-3">
											<div class="card">
												<div class="card-body">
													<cfselect name="st_id" id="st_id" class="form-control" query="get_status" display="status_name" value="tp_status_id" multiple="yes" size="1" selected="#st_id#"></cfselect>
												</div>
											</div>
										</div>
					
										<div class="col-md-1">	
											<input type="submit" class="btn btn-success" value="Go">
										</div>
					
									</div>
								</cfform>
							</div>		
						</div>											
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade <cfif m_id eq 11>active show</cfif>" id="tp_group" style="margin-top:15px">
				
					<table class="table table-bordered">						
						<tr class="bg-light">
							<td><strong>ORDER ID</strong></td>
							<td><strong>TP</strong></td>
							<td><strong>COMPTE</strong></td>
							<td><strong>TP NAME</strong></td>
							<td><strong>TP STATUS</strong></td>
							<td><strong>TP END</strong></td>
							<td><strong>HOUR</strong></td>
							<td><strong>PROGRESS</strong></td>
							<td><strong>DEADLINE</strong></td>
							<td><strong>COMMENTS</strong></td>
							<td><strong>BETA</strong></td>
							<td><strong>+</strong></td>
						</tr>
						
						
						
						<cfoutput query="get_tp_group">
							<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
							<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
							<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
							<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
							<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
							<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
							<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
							<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
							<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
							
							<tr class="bg-white">
								<td>
									<span class="badge badge-pill text-white badge-#status_finance_css#">#order_ref# - #status_finance_name#</span>
								</td>
								<td>
									<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
									<cfloop query="tp_trainer">
										#obj_lms.get_thumb(planner_id,30)#
									</cfloop>
									<img src="./assets/img_formation/#formation_id#.png" width="30" class="border_thumb mr-1"> 
                        			<cfif method_id eq "10"><img src="./assets/img_level/#tplevel_alias#.svg" width="30"></cfif>
									<span class="badge badge-pill bg-white border border-dark font-weight-normal p-2 cursored btn_edit_tpgroup" id="group_#tp_id#_0"><strong>Group</strong><br><i class="fal fa-users"></i></span>
								</td>
								<td>
									<small>#mid(account_name,1,20)#</small>
								</td>
								<td>
									<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a>
								</td>
								<td>
									<span class="badge badge-info bg-#tp_status_css#">#status_name#</span>
								</td>
								<td>
									#dateformat(tp_date_end,'dd/mm/yyyy')#
								</td>
								<td>
									#tp_duration/60#
								</td>
								
								<td>
									#obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")#
								</td>
								
								
								<td>
									<cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif>
								</td>
			
								<td>
									<cfif order_id neq "">
									<button type="button" class="btn <cfif nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="u_#user_id#">
									<i class="fas fa-sticky-note"></i> 
									</button>
									</cfif>
									<a target="_blank" class="btn btn-sm btn-success" href="./tpl/as_group_container.cfm?t_id=#tp_id#">AS</a>
								</td>
								<td>
									<a href="common_tp_multi2.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="EDIT" class="btn btn-success btn-sm my-0">BOOK</i></a>
								</td>
								
								<td>
									<button id="tp_#tp_id#_#order_id#" class="btn btn-success btn-sm btn_learner_edit_tp my-0" data-toggle="tooltip" data-placement="top" title="EDIT"><i class="fal fa-edit"></i></button>	
									<a href="common_tp_builder.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="BUILD" class="btn btn-success btn-sm my-0"><i class="fal fa-wrench"></i></a>
									<a href="common_tp_details.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="BOOK" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
								</td>

							</tr>						
							</cfoutput>
						
						
					</table>
			
				</div>

				<div role="tabpanel" class="tab-pane fade <cfif m_id eq 10>active show</cfif>" id="tp_virtual" style="margin-top:15px">

					<!--- <cfdump var="#get_tp_virtual#"> --->

					<!--- <form action="cs_list_tp.cfm" method="post">
                        <div class="row">
                            <div class="col-md-2">
                                <!--- <cfselect id="lmethod" class="lmethod p-2 m-1 mb-3 form-select-sm" name="lmethod" query="get_lesson_method" display="method_alias_fr" queryposition="below" selected="#lmethod#" value="method_id">
                                    <option <cfif lmethod eq 0>selected </cfif>value = 0>Pack: All</option>
                                </cfselect> --->
                            </div>
                            <div class="col-md-4">
                                <div class="controls">
                                    <div class="input-group">
                                        <input id="end_date" name="end_date" type="text" class="datepicker form-control" value="" />
                                        <label for="end_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                    </div>
                                </div>	
                            </div>
                            <div class="col-md-2">
								<input type="hidden" id="m_id" name="m_id" value="10">
								<input type="submit" class="btn btn-info" value="Appliquer">
                            </div>
                        </div>
                        
                    </form> --->
					








					<div class="accordion" id="accordion_virtual">

						<cfoutput query="get_tp_virtual">

							<cfquery name="get_tpuser" datasource="#SESSION.BDDSOURCE#">
							SELECT count(user_id) as nb FROM lms_tpuser where tp_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#tp_id#"> AND tpuser_active = 1
							</cfquery>

							
							<cfset get_session = obj_tp_get.oget_session(t_id="#tp_id#", g_by="s_id")>
							<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
							<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
							<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
							<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
							<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
							<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
							<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
							<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
							<cfset tp_done_go = tp_completed_go+tp_inprogress_go>


							<div class="card">
							<div class="card-header">
								<div role="button" class="p-2 w-100 cursored" type="button" data-toggle="collapse" data-target="##tp_head_#tp_id#" aria-expanded="true" aria-controls="tp_head_#tp_id#">
									<div class="d-flex text-left justify-content-between w-100">
										
										<!--- <div><button data-tid="#tp_id#" class="btn btn-success show_tp_detail btn-sm my-0" data-placement="top"><i class="fal fa-angle-down"></i></button>								</div> --->
										<div>#tp_id#</div>
										<div>
											<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
											<cfloop query="tp_trainer">
												#obj_lms.get_thumb(planner_id,30)#
											</cfloop>
											<img src="./assets/img_formation/#formation_id#.png" width="30" class="border_thumb mr-1"> 
											<cfif method_id eq "10"><img src="./assets/img_level/#tplevel_alias#.svg" width="30"></cfif>
											<span class="badge badge-pill bg-white border border-dark font-weight-normal p-2 cursored" id="group_#tp_id#_0"><strong>#method_name#</strong></span>
										</div>
										<div>
											<h6>#get_tpuser.nb# <i class="fal fa-users"></i></h6>
										</div>
										<div>
											<h6><a href="common_tp_details.cfm?t_id=#tp_id#">#tp_name#</a></h6>
										</div>
										<div>
											<span class="badge badge-info bg-#tp_status_css#">#status_name#</span>
										</div>
										<div>
											#dateformat(tp_date_end,'dd/mm/yyyy')#
										</div>
										<!--- <div>
											#tp_duration/60#
										</div> --->
										
										<!--- <div>
											#obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")#
										</div> --->


										
					
										<!--- <div>
											<cfif order_id neq "">
											<button type="button" class="btn <cfif nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="u_#user_id#">
											<i class="fas fa-sticky-note"></i> 
											</button>
											</cfif>
										</div> --->
			
										<div>
											<a href="common_tp_multi2.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="EDIT" class="btn btn-success btn-sm my-0">MULTI</i></a>
											<button id="tp_#tp_id#_#order_id#" class="btn btn-success btn-sm btn_learner_edit_tp my-0" data-toggle="tooltip" data-placement="top" title="EDIT"><i class="fal fa-edit"></i></button>	
											<a href="common_tp_builder.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="BUILD" class="btn btn-success btn-sm my-0"><i class="fal fa-wrench"></i></a>
											<a href="common_tp_details.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="BOOK" class="btn btn-success btn-sm my-0"><i class="fal fa-calendar-alt"></i></a>
											<button id="tp_#tp_id#" class="btn btn-success btn-sm btn_dup_tp my-0" data-toggle="tooltip" data-placement="top" title="DUP VC"><i class="fa-sharp fa-regular fa-copy"></i></button>
										</div>

										
									</div>
								</div>
							</div>
					  
						  
							<div id="tp_head_#tp_id#" class="collapse" data-parent="##accordion_virtual">
								<div class="card-body">
								
									<table class="table">
										<tr class="bg-light">
											<td></td>
											<td><strong>ID</strong></td>
											<td><strong>NAME</strong></td>
											<td><strong>DATE</strong></td>
											<td><strong>STATUS</strong></td>
											<td><strong>TOTAL SEATS</strong></td>
											<td><strong>COMFIRMED</strong></td>
											<td><strong>ATTENDED</strong></td>
											<!--- <td><strong>%</strong></td> --->
											<td><strong>+</strong></td>
										</tr>

									<cfloop query="get_session">

										<cfif get_session.lesson_id neq "">
											<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
												SELECT u.user_firstname, u.user_id
												FROM lms_lesson2_attendance la
												INNER JOIN user u ON u.user_id = la.user_id
												WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.lesson_id#"> 
												AND subscribed = 1
											</cfquery>

											<cfquery name="count_participant_att" datasource="#SESSION.BDDSOURCE#">
												SELECT u.user_firstname, u.user_id
												FROM lms_lesson2_attendance la
												INNER JOIN user u ON u.user_id = la.user_id
												WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.lesson_id#"> 
												AND subscribed = 1 AND lesson_signed = 1
											</cfquery>
										</cfif>

										<tr>
											<td>
												<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
													<img src="./assets/img_material/#sessionmaster_code#.jpg" width="100" align="left" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
												<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
													<img src="./assets/img_material/#sessionmaster_id#.jpg" width="100" align="left" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
												</cfif>
											</td>
											<td>
												#lesson_id#
											</td>
											<td>
												#cat_name#
											</td>
											<td>
												#lesson_start#
											</td>
											<td>
												#status_name#
											</td>
											<td>
												#get_tp_virtual.tp_max_participants#
											</td>
											<td>
												<cfif get_session.lesson_id neq "">
													<cfloop query="count_participant">
														<a href="common_learner_account.cfm?u_id=#count_participant.user_id#">#count_participant.user_firstname#</a><br>
													</cfloop>
												<cfelse>
													-
												</cfif>
											</td>
											<td>
												<cfif get_session.lesson_id neq "">
													<cfloop query="count_participant_att">
														<a href="common_learner_account.cfm?u_id=#count_participant_att.user_id#">#count_participant_att.user_firstname#</a><br>
													</cfloop>
												<cfelse>
													-
												</cfif>
											</td>
											<!--- <td>
												<cfif get_session.lesson_id neq "">
													<cfif count_participant_att.nb neq 0 AND count_participant.recordCount neq 0>
														#count_participant_att.nb / count_participant.recordCount#
													<cfelse>
														0
													</cfif>
												<cfelse>
													-
												</cfif>
											</td> --->
											<td>
												<span class="badge badge-pill bg-info border font-weight-normal p-2 cursored btn_edit_tpgroup_vc" id="class_#tp_id#_#lesson_id#"><strong>VClass</strong><br><i class="fal fa-users"></i></span>
											</td>
										</tr>
									</cfloop>
									</table>

								</div>
							</div> 
						</div>
					</cfoutput>






					<!--- <table class="table">						
						<tr class="bg-light">
							<td><strong>DETAILS</strong></td>
							<td><strong>TP ID</strong></td>
							<td><strong>TP</strong></td>
							<td><strong>COMPTE</strong></td>
							<td><strong>TP NAME</strong></td>
							<td><strong>TP STATUS</strong></td>
							<td><strong>TP END</strong></td>
							<td><strong>HOUR</strong></td>
							<td><strong>PROGRESS</strong></td>
							<td><strong>COMMENTS</strong></td>
							<td><strong>BETA</strong></td>
							<td><strong>+</strong></td>
						</tr> --->
						
						

							
						



						

						<!--- <cfdump var="#get_session#"> --->

						<!---  --->

						

						

				</div>
				
				
			</div>


	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>


<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
	$(document).ready(function() {

		$('#st_id').multiselect({	
			numberDisplayed: 1
		});

		$("#end_date").datepicker({	
			weekStart: 1,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {
				end_date = $('#end_date').datepicker("getDate");
				end_date = moment(end_date).format('YYYY-MM-DD');
			}		
		});
	
		/******************** VIEW LOG *****************************/	
		$('.btn_view_log').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var u_id = idtemp[1];
			// console.log(u_id);
			$('#modal_title_xl').text("Follow-Up Learner");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_log.cfm?u_id="+u_id, function() {})
		});


		$('.show_tp_detail').click(function(event){
			// console.log($(this));
			$('#tp_head_' + event.target.dataset.tid).nextUntil('.tp_head').slideToggle('normal');
		});

		$('.btn_learner_add_tp').click(function(event) {
			event.preventDefault();
			$('#modal_title_lg').text("Cr\u00e9er parcours");
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_body_lg').load("modal_window_tp.cfm?create_tp=1&group=1&u_id=0", function() {});
		});		

		$('.btn_edit_tpgroup').click(function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var l_id = idtemp[2];
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("TP group");
			$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
		});

		$('.btn_edit_tpgroup_vc').click(function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var l_id = idtemp[2];
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("TP group");
			$('#modal_body_xl').load("modal_window_tpgroup_attendance.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
		});


		$('.btn_learner_edit_tp').click(function(event) {		
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var o_id = idtemp[2];
			/*alert(t_id);
			alert(o_id);*/
			$('#modal_title_xl').text("Editer parcours");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_tp.cfm?vc=1&t_id="+t_id+"&o_id="+o_id, function() {});
		});
		
		$('.btn_dup_tp').click(function(event) {		
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];

			if(confirm("Confirmer la duplication du TP?")) {
		
				$.ajax({
					url: 'api/tp/tp_post.cfc?method=dup_virtual_class',
					type : 'POST',
					data : {
						t_id:t_id
					},				
					success : function(result, status) {
						// console.log(result)
						if (result == "ok") {
							window.location.reload(true);
						} else {
							alert("Attention ! une erreur est survenue.");
						}
					}
				});
			}
			

		});
		
	 })
	</script>

</body>
</html>