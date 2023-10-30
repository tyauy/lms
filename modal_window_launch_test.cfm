<cfsilent>

	<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
	SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 OR keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
	</cfquery>

	<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
	SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_objectives_#SESSION.LANG_CODE# as skill_objectives, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
	</cfquery>
		
	<cfquery name="get_tptype" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_type_id, tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tp_type_explain_#SESSION.LANG_CODE# as tp_type_explain, tp_type_css, tp_type_img FROM lms_tptype ORDER BY FIELD(tp_type_id,4,1,2,3)
	</cfquery>

	<cfquery name="get_tpformula" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_formula_id, tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tp_formula_desc_#SESSION.LANG_CODE# as tp_formula_desc, tp_formula_css, tp_formula_img, tp_formula_nbcourse FROM lms_tpformula
	</cfquery>
	
	<cfquery name="get_tpsupport" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_support_id, tp_support_name_#SESSION.LANG_CODE# as tp_support_name, tp_support_desc_#SESSION.LANG_CODE# as tp_support_desc, tp_support_css, tp_support_img FROM lms_tpsupport
	</cfquery>
	
	<cfquery name="get_lesson_origin" datasource="#SESSION.BDDSOURCE#">
	SELECT origin_id, origin_name_#SESSION.LANG_CODE# as origin_name, origin_src FROM lms_lesson_origin
	</cfquery>
		
	<cfquery name="get_tporientation" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_orientation_id, tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc, tp_orientation_src, tp_orientation_css FROM lms_tporientation WHERE tp_orientation_id < 3
	</cfquery>
	
	<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
	SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 OR keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
	</cfquery>

	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>

	<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
	<cfset get_session = obj_tp_get.oget_session(u_id="#u_id#",t_id="#t_id#")>

	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>	
	<cfset tp_master_hour = get_tp.tp_duration/60>		
	<cfset tp_orientation_select = get_tp.tp_orientation_id>
	<cfset tp_interest_select = get_tp.tp_interest_id>
	<cfset tp_function_select = get_tp.tp_function_id>


	<cfset SESSION.SESSION_ID = get_session.session_id>

</cfsilent>

<!--- <cfdump var="#SESSION.SESSION_ID#"> --->
<cfset accordion_list = "">


<div class="accordion mt-4" id="accordion_test">
	
	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button type="button" id="btn_head_choice" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapse_item_choice" aria-expanded="true" aria-controls="collapse_item_choice">
				
				<h5 class="my-1 text-info" align="center">
					<cfoutput>#obj_translater.get_translate('accordion_choice')#</cfoutput>
				
					<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"1")>show</cfif>" id="check_choice"></i>
				
				</h5>
			</button>

			<div id="collapse_item_choice" class="collapse <cfif not listfind(accordion_list,"1")>show</cfif>" data-parent="#accordion_test">
							
				<form id="form_choice">
				<div class="card-deck btn-group-toggle" data-toggle="buttons">
					
					<label class="btn btn-lg card p-2 m-2 btn-outline-info cursored label_choice">
						<img class="card-img-top" src="./assets/img/method_speed.jpg">
						<input type="radio" name="test_choice_1" class="test_choice" value="1" autocomplete="off" checked="checked">
						<div class="card-body">
							<div align="center">
							<h5 align="center" class="mb-1" style="white-space:normal !important"><cfoutput>#obj_translater.get_translate('btn_test_choice_fast')#</cfoutput></h5>
							</div>
							<p class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
								<cfoutput>#obj_translater.get_translate('test_choice_fast_subtitle')#</cfoutput>
							</p>
						</div>
					</label>
					
					<label class="btn btn-lg card p-2 m-2 btn-outline-success cursored label_choice">
						<img class="card-img-top" src="./assets/img/method_discover.jpg">
						<input type="radio" name="test_choice_1" class="test_choice" value="2" autocomplete="off">
						<div class="card-body">
							<div align="center">
							<h5 align="center" class="mb-1" style="white-space:normal !important"><cfoutput>#obj_translater.get_translate('btn_test_choice_slow')#</cfoutput></h5>
							</div>
							<p class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
								<cfoutput>#obj_translater.get_translate('test_choice_slow_subtitle')#</cfoutput>
							</p>
						</div>
					</label>
					
					<!--- <label class="btn btn-lg card p-2 m-2 btn-outline-info cursored label_choice">
						<img class="card-img-top" src="./assets/img/method_rdv.jpg">
						<input type="radio" name="test_choice_1" class="test_choice" value="3" autocomplete="off">
						<div class="card-body">
							<div align="center">
							<h5 align="center" class="mb-1" style="white-space:normal !important">Prendre RDV </h5>
							</div>
							<p class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
							Je souhaite être assisté(e) et/ou obtenir une présentation de nos services
							</p>
							
						</div>
					</label> --->
				</div>
				
				<div align="center">
				<br>
				<cfoutput>
				<input type="hidden" name="t_id" value="#t_id#">
				</cfoutput>
				</div>
				</form>
								
					
			</div>
				
			
		</div>
		
	</div>
	
	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
		
			<button type="button" id="btn_head_use" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_use" aria-expanded="false" aria-controls="collapse_item_use">
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_launch_cgu')#</cfoutput>
				
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse" id="check_use"></i>
				</h5>
			</button>

			<div id="collapse_item_use" class="collapse pb-2" data-parent="#accordion_test">
			<form id="charter_form">
				<div class="card-deck">
					<!--- <div class="card border">
						<div class="card-body p-3 d-flex flex-column">
						
							<div align="center">
								<h5 class="d-inline text-dark"><i class="fal fa-list fa-lg"></i> <cfoutput>#obj_translater.get_translate('card_use')#</cfoutput></h5><br>
							</div>
										
							<p class="mt-3">
							<cfoutput>#obj_translater.get_translate_complex('use_intro')#</cfoutput>
							<br>
							</p>
										
							<div class="m-2 p-2 mt-auto" align="center">
								<cfoutput>
								<a class="btn btn-sm btn-info" target="_blank" href="common_cgu.cfm?show_info=use">#obj_translater.get_translate('btn_view_use')#</a> 
								<label class="text-dark"><input type="checkbox" name="accept_use" id="accept_use" checked> #obj_translater.get_translate_complex('accept_learner_use')#</label>
								
								</cfoutput>
							</div>
							
						</div>
					</div> --->
					<div class="card border">
						<div class="card-body p-3 d-flex flex-column">
							<div align="center">
								<h5 class="d-inline text-dark"><i class="fal fa-shield-check fa-lg"></i> <cfoutput>#obj_translater.get_translate('card_policy')#</cfoutput></h5><br>
							</div>
										
							<p class="mt-3">
							<cfoutput>#obj_translater.get_translate_complex('policy_intro')#</cfoutput>
							</p>
										
							<div class="m-2 p-2 mt-auto" align="center">
								<cfoutput>
								<a class="btn btn-sm btn-info" href="common_cgu.cfm?show_info=policy" target="_blank">#obj_translater.get_translate('btn_view_policy')#</a>
								<br>
								<label class="text-dark"><input type="checkbox" name="accept_policy" id="accept_policy" checked> #obj_translater.get_translate_complex('accept_learner_policy')#</label>
								</cfoutput>
							</div>
							
						</div>
					</div>
					<div class="card border">
						<div class="card-body p-3 d-flex flex-column">
							<div align="center">
								<h5 class="d-inline text-dark"><i class="fal fa-paper-plane fa-lg"></i> <cfoutput>#obj_translater.get_translate('card_communication')#</cfoutput></h5><br>
							</div>
										
							<p class="mt-3">
							<cfoutput>#obj_translater.get_translate_complex('communication_intro')#</cfoutput>
							</p>
										
							<div class="m-2 p-2 mt-auto" align="center">
								<cfoutput>
								<label class="text-dark"><input type="checkbox" name="accept_communication" id="accept_communication"> #obj_translater.get_translate('accept_learner_communication')#</label>
								</cfoutput>
							</div>
							
						</div>
					</div>
				</div>	
				
				<div align="center">
				<cfoutput><button type="submit" class="btn btn-lg btn-success mt-3"> <cfoutput>#obj_translater.get_translate('btn_continue')#</cfoutput> <i class="far fa-chevron-double-right"></i></button></cfoutput>
				</div>
			</form>
			</div>
			
		</div>
		
	</div>

	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
		
			<button type="button" id="btn_head_level" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_level" aria-expanded="false" aria-controls="collapse_item_level">
				<h5 class="my-1 text-info" align="center">
					<cfoutput>#obj_translater.get_translate('accordion_level')#</cfoutput>
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse" id="check_level"></i>
				</h5>
			</button>

			<div id="collapse_item_level" class="collapse pb-2" data-parent="#accordion_test">
			
				<div id="container_level_choice_1" class="collapse">
					<form action="updater_form.cfm" method="post" id="level_form">	
					<div class="alert bg-light text-dark border" role="alert">
						<div class="media">
							<cfoutput><img  src="./assets/img/qpt_#lcase(f_code)#.jpg" width="150" class="mr-3"></cfoutput>
							<div class="media-body">
								<cfoutput>#obj_translater.get_translate_complex('text_accordion_speed')#</cfoutput>
								
									<div class="row">
										<div class="col-md-12 mt-3">
											<cfoutput>	
											
											<select class="form-control" name="user_level" id="user_level">
												<option value="0">---#obj_translater.get_translate('btn_choose_level')#---</option>
												<option value="A0">#obj_translater.get_translate('level_a0')#</option>
												<option value="A1">#obj_translater.get_translate('level_a1')#</option>
												<option value="A2">#obj_translater.get_translate('level_a2')#</option>
												<option value="B1">#obj_translater.get_translate('level_b1')#</option>
												<option value="B2">#obj_translater.get_translate('level_b2')#</option>
												<option value="C1">#obj_translater.get_translate('level_c1')#</option>
												<!--- <option value="C2" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "C2">selected</cfif>>#obj_translater.get_translate('level_c2')#</option> --->
											</select>
											
											
											</cfoutput>
										</div>			
									</div>
									
								
							</div>
						</div>
					</div>
					<div align="center" class="mt-4">
						<input type="hidden" name="form_type" value="level_form">
						<cfoutput><input type="hidden" name="f_code" value="#f_code#"></cfoutput>
						<button class="btn btn-lg btn-success" type="submit">
							<cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput><i class="far fa-chevron-double-right"></i>
						</button>
					</div>
					</form>
								
					
				</div>


				<!--- <div id="container_level_choice_2" class="collapse">

					<div class="alert bg-light text-dark border" role="alert">
						<div class="media">
							<cfoutput><img  src="./assets/img/qpt_#lcase(f_code)#.jpg" width="150" class="mr-3"></cfoutput>
							<div class="media-body">
								<cfoutput>#obj_translater.get_translate_complex('text_accordion_speed')#</cfoutput>
							</div>
						</div>
					</div>

					<div align="center">
						<cfoutput>
							<button type="button" class="btn btn-lg btn-success btn_valid_level">#obj_translater.get_translate("btn_understood")# <i class="far fa-chevron-double-right"></i></button>
						</cfoutput>
					</div>

				</div> --->


			</div>
			
		</div>
		
	</div>
		
	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button type="button" id="btn_head_support" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_support" aria-expanded="true" aria-controls="collapse_item_support">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>
					<cfoutput>#obj_translater.get_translate('accordion_tp_support')#</cfoutput>
				</cfoutput>
				
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"3")>show</cfif>" id="check_support"></i>
				
				</h5>
			</button>

			<div id="collapse_item_support" class="collapse <cfif not listfind(accordion_list,"3") AND listfind(accordion_list,"2")>show</cfif>" data-parent="#accordion_test">
			
				<div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_support')#</cfoutput>
						</div>
					</div>
				</div>
				
				<form id="form_support">
					<div class="card-deck">
						<!--- <label class="btn btn-lg card p-2 m-2 btn-outline-info cursored tp_support_all <cfif get_tp.tp_support_id eq "0" OR get_tp.tp_support_id eq "">active</cfif>" id="tp_support_all"> --->
						<!--- <input type="checkbox" name="tp_support_id" value="0" autocomplete="off" <cfif get_tp.tp_support_id eq "0" OR get_tp.tp_support_id eq "">checked="checked"</cfif>> --->
							<!--- <img class="card-img-top" src="./assets/img/support_all.jpg"> --->
							<!--- <div class="card-body"> --->
								<!--- <h5 align="center" class="mb-1" style="white-space:normal !important">Tout me convient !</h5> --->
							<!--- </div> --->
						<!--- </label> --->
						<cfloop query="get_tpsupport">
						<cfoutput>
						<div class="card p-2 m-2 border tp_support">
							<img class="card-img-top" src="./assets/img/#tp_support_img#" width="120">
							<!--- <input type="checkbox" name="tp_support_id" class="tp_support_id" value="#tp_support_id#" autocomplete="off" <cfif listfind(get_tp.tp_support_id,get_tpsupport.tp_support_id)>checked="checked"</cfif>> --->
							<div class="card-body" align="center">
								<h5 class="mb-1 text-muted" style="white-space:normal !important">#get_tpsupport.tp_support_name#</h5>
								<div class="card-text font-weight-normal text-muted" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
								#tp_support_desc#
								</div>
							</div>
						</div>
						</cfoutput>
						</cfloop>
						
					</div>

					<div align="center">
						<cfoutput>
							<button type="button" class="btn btn-lg btn-success btn_valid_support">#obj_translater.get_translate("btn_understood")# <i class="far fa-chevron-double-right"></i></button>
						</cfoutput>
					</div>

				</form>

					
			</div>
				
			
		</div>
		
	</div>
	
	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
			
			<button type="button" id="btn_head_orientation" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_orientation" aria-expanded="true" aria-controls="collapse_item_orientation">
				
				<h5 class="my-1 text-info" align="center">
					<cfoutput>#obj_translater.get_translate('accordion_tp_orientation')#</cfoutput>
				
				<!--- <i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"5")>show</cfif>" id="check_5"></i> --->
				
				</h5>
			</button>

			<div id="collapse_item_orientation" class="collapse<!---<cfif not listfind(accordion_list,"5")>show</cfif>--->" data-parent="#accordion_test">
				
				<!--- <div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_orientation')#</cfoutput>
						</div>
					</div>
				</div> --->
				

				<form id="form_orientation">
					<div class="card-deck btn-group-toggle" data-toggle="buttons">
						
						<cfoutput query="get_tporientation">
							<label class="btn btn-lg card p-2 m-2 btn-outline-info cursored label_choice">
								<img class="card-img-top" src="./assets/img/#tp_orientation_src#">
								<input type="radio" name="tp_orientation_id" class="tp_orientation_id" value="#tp_orientation_id#" autocomplete="off" <cfif tp_orientation_id eq tp_orientation_select>checked="checked"</cfif>>
								<div class="card-body">
									<div align="center">
									<h5 align="center" class="mb-1" style="white-space:normal !important">#tp_orientation_name#</h5>
									</div>
									<p class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
										#tp_orientation_desc#
									</p>
								</div>
							</label>
						</cfoutput>
						<cfoutput><input type="hidden" name="t_id" value="#SESSION.TP_ID#"></cfoutput>
					</div>
				</form>


					
			</div>
			
		</div>
		
	</div>

	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
			
			<button id="btn_head_theme" class="btn btn-link btn-block text-left collapsed" disabled type="button" data-toggle="collapse" data-target="#collapse_item_theme" aria-expanded="false" aria-controls="collapse_item_theme">
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_theme')#</cfoutput>
				</h5>
			</button>
			
			<div id="collapse_item_theme" class="collapse" data-parent="#accordion_test">

				<form id="form_kw">			
				<div id="accordion_kw">
				<cfloop query="get_keyword_cat">
					<cfoutput>
					<div id="collapse_#keyword_cat_id#" class="collapse p-2 collapse_kw" data-parent="##accordion_kw">
					</cfoutput>
						
					<cfif get_tp.tp_type_id eq "2">
					<div class="alert bg-light text-dark border" role="alert">
						<div class="media">
							<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
							<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_theme')#</cfoutput>
							</div>
						</div>
					</div>
					</cfif>
					
					<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
					SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj
					FROM lms_keyword k 
					WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> 
					GROUP BY keyword_id
					ORDER BY keyword_name
					</cfquery>
					
					<div class="row btn-group-toggle" data-toggle="buttons">
						
						<cfoutput query="get_keyword">
						
						<!--- <cfset test = randrange(100,118)> --->
							<div class="col-md-3">
							<label class="btn btn-lg card p-2 m-1 btn-outline-info cursored tp_keyword <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>active</cfif>">
								
								<div class="media">
								<cfif get_keyword_cat.keyword_cat_id eq "3">
								<input type="checkbox" name="tp_interest_id" class="tp_interest_id" value="#keyword_id#" autocomplete="off" <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>checked="checked"</cfif>>
								<cfelse>
								<input type="checkbox" name="tp_function_id" class="tp_function_id" value="#keyword_id#" autocomplete="off" <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>checked="checked"</cfif>>
								</cfif>
									<div class="media-body">
									<h6 align="center" class="mb-1" style="white-space:normal !important"><cfif get_keyword_cat.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif></h6>
									</div>
								</div>
								
							</label>
							</div>
						</cfoutput>
					
					</div>		
				
				</div>				
				</cfloop>
				</div>
			
				<cfoutput>
				<div align="center"><button type="button" class="btn btn-lg btn-success tp_keyword_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button></div>
				</cfoutput>
				
				</form>	
					
			</div>
			
		</div>
		
	</div>
	
	
</div>










<script>
$(document).ready(function() {

	<!--------------------------- FIRST CHOICE ------------------>	
	$(".test_choice").change(function(event) {
		event.preventDefault();
		test_choice = $(".test_choice:checked").val();

		$('#collapse_item_use').collapse('toggle');
		$('#btn_head_use').prop("disabled", false);
		$('#check_choice').collapse('show');

	})
	




	<!--------------------------- CHARTER ------------------>	
	$('#charter_form').submit(function(event) {

		if($('#accept_policy').prop('checked') != true)
		{
			alert("<cfoutput>#obj_translater.get_translate('alert_accept_charter')#</cfoutput>");
			return false;
		}
		else
		{
			$('#check_use').collapse('show');		
			
		
			if(test_choice == "1")
			{
				$('#container_level_choice_1').collapse('show');	
				$('#btn_head_level').prop("disabled", false);
				$('#collapse_item_level').collapse('toggle');
				
			}
			else if(test_choice == "2")
			{
				$('#check_level').collapse('show');		
				$('#btn_head_support').prop("disabled", false);
				$('#collapse_item_support').collapse('toggle');
			}

			return false;

		}
	});


	$('#level_form').submit(function(event) {

		event.preventDefault();

		if($('#user_level').val() == 0)
		{
			alert("<cfoutput>#encodeForJavaScript(trim(obj_translater.get_translate_complex('alert_enter_valid_level')))#</cfoutput>");
			return false;
		}
		else
		{
			// alert("2");
			
			$.ajax({				 
				url: 'updater_tp.cfc?method=updt_level',
				type: 'GET',		
				dataType: 'json',
				data: $('#level_form').serialize(),
				success : function(resultat, statut){
					console.log(resultat);
					$('#check_level').collapse('show');		
					$('#btn_head_support').prop("disabled", false);
					$('#collapse_item_support').collapse('toggle');
				},
				error : function(resultat, statut, erreur){
					<!--- console.log(resultat); --->
					<!--- console.log(erreur); --->
				},
				complete : function(resultat, statut){
					<!--- console.log(resultat); --->
				}	
			});
			
		}
		
		
	});

	$(".btn_valid_level").click(function() {
		$('#check_level').collapse('show');		
		$('#btn_head_support').prop("disabled", false);
		$('#collapse_item_support').collapse('toggle');
	})




	

	<!--------------------------- SUPPORT ------------------>	
	$(".btn_valid_support").click(function() {
		$('#check_support').collapse('show');		
		$('#btn_head_orientation').prop("disabled", false);
		$('#collapse_item_orientation').collapse('toggle');
	})



	
	<!--------------------------- ORIENTATION ------------------>	
	$(".tp_orientation_id").change(function(event) {
		event.preventDefault();
		
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_orientation',
			type: 'POST',		
			dataType: 'json',
			data: $('#form_orientation').serialize(),
			success : function(resultat, statut){
				var tp_orientation_id = resultat;
				console.log(tp_orientation_id);
				if(tp_orientation_id == "1")
				{	$("#collapse_3").collapse('toggle');
					$("#collapse_4").collapse('toggle');
				}
				else if(tp_orientation_id == "2")
				{	
					$("#collapse_4").collapse('toggle');
					$("#collapse_3").collapse('toggle');
				}				
				$('#collapse_item_theme').collapse('toggle');
				<!--- $('#check_5').collapse('show'); --->
				$('#btn_head_theme').prop("disabled", false);
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
				<!--- console.log(erreur); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	
	tp_interest_id = [];
	tp_function_id = [];
	$.each($("input[class='tp_interest_id']:checked"), function(){			
		tp_interest_id.push($(this).val());			
	});
	$.each($("input[class='tp_function_id']:checked"), function(){			
		tp_function_id.push($(this).val());			
	});
	<!--------------------------- 5th ITEM ------------------>	
	$(".tp_interest_id").change(function() {
		tp_interest_id = [];	
		$.each($("input[class='tp_interest_id']:checked"), function(){			
			tp_interest_id.push($(this).val());			
		});
	})
	$(".tp_function_id").change(function() {
		tp_function_id = [];	
		$.each($("input[class='tp_function_id']:checked"), function(){			
			tp_function_id.push($(this).val());			
		});
	})
	$(".tp_keyword_btn").click(function() {

		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_keyword',
			type: 'GET',		
			dataType: 'json',
			data: "t_id=<cfoutput>#t_id#</cfoutput>&tp_interest_id="+tp_interest_id+"&tp_function_id="+tp_function_id,
			success : function(resultat, statut){
				<!--- console.log(resultat); --->
				<!--- $('#window_item_xl_unclosable').modal('hide'); --->
				<!--- var tp_type_id = $("input[class='tp_type_id']:checked").val(); --->
				<!--- alert(tp_type_id); --->
				if(test_choice == "1")
				{
					window.location.href="learner_launch_2_test.cfm?display_info=1";
				}
				else if(test_choice == "2")
				{
					$('#window_item_xl_unclosable').modal("hide");
				}
					
		
				
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	
	
	
})
</script>

