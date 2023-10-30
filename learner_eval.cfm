<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,7,9">
<cfinclude template="./incl/incl_secure.cfm">


<cfif isdefined("SESSION.TP_ID")>
	<cfset temp = structdelete(SESSION, "TP_ID")>
</cfif>

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<!--- <cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke> --->

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

<cfif SESSION.USER_ID eq "411" OR SESSION.USER_ID eq "533" OR SESSION.USER_ID eq "2030" OR SESSION.USER_ID eq "4348" OR SESSION.USER_ID eq "4841" OR SESSION.USER_ID eq "7767">
	<cfset list_lang = "en,de,fr,es,it,ru,zh,pt,nl">
<cfelse>
	<cfset list_lang = "en,de,fr,es,it,zh,pt">
</cfif>

<cfloop list="#SESSION.LIST_PT#" index="cor">
<cfset "user_qpt_#cor#" = evaluate("get_user.user_qpt_#cor#")>
<cfset "user_qpt_lock_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>
</cfloop>

	<!--- <cfloop list="#list_lang#" index="cor">
	
	<cfquery name="get_result_qpt_#cor#" datasource="#SESSION.BDDSOURCE#">
	SELECT qu.quiz_user_id, qu.quiz_success, q.quiz_id, q.quiz_alias, SUM(qr.ans_gain) as score
	FROM lms_quiz_result qr
	INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND q.quiz_type = 'qpt_#cor#' AND quiz_active = 1
	GROUP BY qu.quiz_user_id
	ORDER BY quiz_alias
	</cfquery>

	<cfset "list_qpt_success_#cor#" = "">
	<cfloop query="get_result_qpt_#cor#">
		<cfif evaluate("get_result_qpt_#cor#.score") eq ""><cfset score = 0><cfelse><cfset score = evaluate("get_result_qpt_#cor#.score")></cfif>
		<cfset "list_qpt_success_#cor#" = listappend(evaluate("list_qpt_success_#cor#"),quiz_success)>
	</cfloop>
	
	</cfloop> --->

	<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 3
	</cfquery>
	
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT user_needs FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>

</head>



<style>

	h1,h2,h3,h4,h5,h6{
		font-family: 'Titillium Web', sans-serif;
	}

	<!---.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}

	.btn-outline-info {
		text-transform:none !important; 
		border: 1px solid #51bcda !important;
	}
	.btn-outline-danger {
		text-transform:none !important; 
		border: 1px solid #ef8157 !important;
	}	
	.btn-outline-warning {
		text-transform:none !important; 
		border: 1px solid #fbc658 !important;
	}	
	.btn-outline-success {
		text-transform:none !important; 
		border: 1px solid #6bd098 !important;
	}			

	.card_module {
		-webkit-filter: grayscale(90%) !important;
		filter: grayscale(90%) !important;
	}

	.btn-outline-info {color:#51bcda !important;}
	.btn-outline-success {color:#6bd098 !important;}
	.btn-outline-primary {color:#51cbce !important;}
	.btn-outline-danger {color:#ef8157 !important;}
	.btn-outline-warning {color:#fbc658 !important;}--->

</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<!--- <cfset title_page = "#obj_translater.get_translate('title_page_tests')#"> --->
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">
			
		<div class="content">

			<cfinclude template="./incl/incl_nav_test.cfm">

			<div class="row mt-3">
				<div class="col-md-12">
				
					<div class="card mb-3 border">
						<div class="card-body">
							
							<!--- <div class="w-100">
								<h5 class="d-inline"><i class="fa-thin fa-medal fa-lg mr-2"></i> Wefit <strong>Tests</strong></h5>
								<hr class="bg-danger border-dark mb-1 mt-2 mb-3">
							</div> --->
					
							<nav>
								<div class="nav nav-tabs" role="tablist">
									<a class="nav-item nav-link active" id="nav-pt" data-toggle="tab" href="#pt" role="tab" aria-controls="pt" aria-selected="true"><cfoutput>#obj_translater.get_translate('card_learner_pt')#</cfoutput></a>
									<a class="nav-item nav-link" id="nav-lst" data-toggle="tab" href="#lst" role="tab" aria-controls="lst" aria-selected="false">Learning Style Test</a>
									<!--- <a class="nav-item nav-link" id="nav-needs" data-toggle="tab" href="#needs" role="tab" aria-controls="needs" aria-selected="false">Needs Form</a> --->
								</div>
							</nav>
							
							<div class="tab-content">
								<div class="tab-pane fade show active" id="pt" role="tabpanel" aria-labelledby="nav-pt">
									<cfloop list="#list_lang#" index="lang_select">
									<div class="border mt-3 p-3 bg-light">
										<div class="row">
											<div class="col-md-5">
												
												<h5 class="text-left m-0"><cfoutput>#obj_translater.get_translate('card_learner_pt')# WEFIT - #obj_translater.get_translate('lang_#lang_select#')#</cfoutput></h5>
													

												<div class="media">
													<cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" class="align-self-center mr-3" width="170"></cfoutput>
													<div class="media-body">
													<p>
													<ul class="m-0">
													
													<cfoutput>#obj_translater.get_translate_complex('intro_eval_lrn')#</cfoutput>
													
													</ul>							
													</p>
													</div>
												</div>

											</div>

											<div class="col-md-7">
												
												<!--- attributed=0 --->
												<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",tp_id="", group=1)>
												<cfset _lg_rep = "">

												<!--- <cfdump var="#get_pt#"> --->
												<!--- <cfif get_pt.recordCount eq 0> --->
													
													<cfoutput>
														<div class="row d-flex align-items-end justify-content-md-end justify-content-sm-center w-100">

															<div class="card">
																<div class="card-body">
																	<h6><i class="fal fa-clock"></i> #obj_translater.get_translate('timing_ten_to_fifty_min')#</h6>
																	
																	<a href="##" class="btn btn-success p-2 m-2 cursored btn_pass_fpt" id="fcode_#lang_select#">
																		<i class="fal fa-arrow-right"></i>	#obj_translater.get_translate('btn_fpt')#
																	</a>
																</div>
															</div>
														</div>
													</cfoutput>

												<!--- <cfelse> --->

													<cfloop query="get_pt">

														<cfif get_pt.quiz_global_score eq "">

															<cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
																<cfinvokeargument name="u_id" value="#u_id#">
																<cfinvokeargument name="quiz_user_group_id" value="#get_pt.quiz_user_group_id#">
															</cfinvoke>
											
															<cfset reload_pt = true>

														</cfif>
											
													</cfloop>

													<cfif isDefined("reload_pt")>
														<!--- attributed=0 --->
														<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",tp_id="", group=1)>
													</cfif>
												
													<div class="row">
														<div class="col-md-12">
															<div class="card border">

																<!--- <cfdump var="#get_pt#"> --->
																<!--- ! here loopin on PT --->
																<cfoutput query="get_pt" group="quiz_user_group_id">

																	<cfif quiz_user_group_id neq "">
																		<div class="d-flex align-items-center">
																			<div class="m-2" align="center">
																				<img src="./assets/img_formation/#get_pt.quiz_formation_id#.png" class="border_thumb" width="50"></span>
																				<br>
																				#obj_dater.get_dateformat(quiz_user_start)#
																			</div>
																			<div class="m-2">
																				<cfif pt_speed eq "fpt">
																					<!--- FULL PLACEMENT TEST --->
																					<span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
																				<cfelseif pt_speed eq "qpt">
																					<!--- QUICK PLACEMENT TEST --->
																					<span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
																				</cfif>
																			</div>
																			<div class="m-2">
																				<!--- <cfset get_pt = obj_query.oget_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",quiz_user_group_id="#quiz_user_group_id#")>
																				<cfset quiz_type = get_pt.quiz_type> --->
																				<cfset _lg_rep = listAppend(_lg_rep, get_pt.formation_code)>
																				<cfinclude template="./incl/incl_pt_result.cfm">
																			</div>	
																			<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																			<div class="m-2">
																				<cfoutput>
																				<a href="updater_quiz.cfm?del_qpt_#lCase(get_pt.formation_code)#=1&u_id=#u_id#&quiz_user_group_id=#quiz_user_group_id#" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-trash-alt"></i></a>
																				</cfoutput>	
																			</div>		
																			</cfif>																 --->
																		</div>
																	</cfif>

																</cfoutput>

															</div>
														</div>
													</div>
												<!--- </cfif> --->

												<cfif not listFindNoCase(_lg_rep, lang_select)>
													<cfif evaluate("user_qpt_#lang_select#") neq "" AND (evaluate("user_qpt_lock_#lang_select#") eq "0" OR evaluate("user_qpt_lock_#lang_select#") eq "")>
														<div class="row d-flex align-items-end justify-content-md-end justify-content-sm-center w-100">
															<div class="col-md-12">
																<div class="card border">
																	<cfoutput>
																		<cfif findnocase("A0",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "success">
																		<cfelseif findnocase("A1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "success">
																		<cfelseif findnocase("A2",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "primary">
																		<cfelseif findnocase("B1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "info">
																		<cfelseif findnocase("B2",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "warning">
																		<cfelseif findnocase("C1",evaluate("user_qpt_#lang_select#"))>
																			<cfset css = "danger">
																		</cfif>
																		<div class="d-flex align-items-center">
																			<div class="m-2">
																				<img src="./assets/img/training_#lang_select#.png" width="50"></span>
																			</div>
																			<div class="m-2">
																				#obj_translater.get_translate('text_not_verified')#
																			</div>
																			<div class="m-2">
																				<a class="badge badge-#css# badge-pill p-3 mt-2 font-weight-normal text-white" style="font-size:14px">
																				#obj_translater.get_translate('table_th_global_level')#
																				<br>
																				<h6 class="mt-1 mb-0">#evaluate("user_qpt_#lang_select#")#</h6>
																				</a>
																			</div>
																		</div>
																	</cfoutput>		
																</div>
															</div>
														</div>
													</cfif>
												</cfif>
												
											</div>
										</div>
									</div>
									</cfloop>
								</div>


								<div class="tab-pane fade" id="lst" role="tabpanel" aria-labelledby="nav-lst">
									<div class="border mt-3 p-3 bg-light">
										<div class="row">
											<div class="col-md-8">
											
												<div class="media">
												
													<img src="./assets/img_material/a265417047adfd29c84ff53a33aedbe0.jpg" class="align-self-center mr-3" width="200">
													<div class="media-body">
													<h5 class="text-left mt-2"><cfoutput>#obj_translater.get_translate('card_learner_lst')#</cfoutput></h5>
													<p>
													
													<cfoutput>#obj_translater.get_translate_complex('learning_style_test')#</cfoutput>
													
													</p>
													</div>
												</div>
												
											</div>
											<div class="col-md-4 d-flex align-items-end justify-content-md-end justify-content-sm-center">
												
												<cfif get_result_lst.recordcount eq "0">
												
													<a href="quiz_start.cfm?t=lst" class="btn btn-sm btn-outline-info"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
													
												<cfelse>
												
													<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
														<cfoutput><a href="##" class="btn btn-sm btn-success btn_view_quiz" id="quser_#get_result_lst.quiz_user_id#">#obj_translater.get_translate('btn_results_test')#</a></cfoutput>
													<cfelseif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end eq "">
														<cfoutput><a href="./quiz.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-danger">#obj_translater.get_translate('btn_continue')# test</a></cfoutput>												
													</cfif>
											
												</cfif>		
											</div>
										</div>
									</div>
							
								</div>
								<!--- <div class="tab-pane fade" id="needs" role="tabpanel" aria-labelledby="nav-needs">
									
									<div class="border mt-3 p-3 bg-light">
										<div class="row">
											<div class="col-md-8">
											
												<div class="media">
													
													<img src="./assets/img_material/2758d0b6ee2f0381c0fbb178411268dd.jpg" class="align-self-center mr-3" width="200">
													<div class="media-body">
													<h6 class="text-left mt-2"><cfoutput>#obj_translater.get_translate('accordion_needs')#</cfoutput></h6>
													<p>
													
													<cfoutput>#obj_translater.get_translate_complex('intro_accordion_needs')#</cfoutput>
													
													</p>
													</div>
												</div>
											</div>
											
											<div class="col-md-4 d-flex align-items-end justify-content-md-end justify-content-sm-center">
												
												<button class="btn btn-sm btn-outline-info btn_learner_edit_profile"><cfoutput>#obj_translater.get_translate('btn_go_needs')#</cfoutput></button>

											</div>
										</div>
									</div>
							
								</div> --->
							</div>


					



							
			
							
							
							
						
						</div>
						
					</div>		
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	

		<cfoutput>
		if(confirm("#obj_translater.get_translate('js_restart_quiz_confirm')#")){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
		</cfoutput>
	

	})

	<cfoutput>
	$('.btn_view_qpt').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_group_id = idtemp[1];	
		var quiz_user_id = idtemp[2];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&u_id=#u_id#", function() {});
	})

	$('.btn_view_quiz').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})


	$('.btn_pass_qpt').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var f_code = idtemp[1];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code="+f_code+"&choice=qpt", function() {});
	})

	$('.btn_pass_fpt').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var f_code = idtemp[1];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code="+f_code+"&choice=fpt", function() {});
	})
	</cfoutput>

	$('.btn_learner_edit_profile').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Editer profil");		
		$('#modal_body_xl').load("modal_window_needs.cfm?u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {
			$('[data-toggle="tooltip"]').tooltip({
			html:true,
			animation:false,
			trigger:"click"
			});
		});
	});
		
})
</script>

</body>
</html>