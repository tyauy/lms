<cfif show_info eq "welcome">

	<cfif isdefined("u_id") AND listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>	
		
		<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
			<cfinvokeargument name="u_id" value="#u_id#">
		</cfinvoke>
			
		<cfset user_phone = REReplace(get_user.user_phone,"[^0-9 -+]","","all")>
		<cfset user_phone_code = get_user.user_phone_code>
		<cfset user_phone_2 = REReplace(get_user.user_phone_2,"[^0-9 -+]","","all")>
		<cfset user_phone_2_code = get_user.user_phone_2_code>
		<cfset user_email = get_user.user_email>
		<cfset user_email_2 = get_user.user_email_2>
		<cfset business_id = get_user.business_id>
		<cfset user_needs_complement = get_user.user_needs_complement>
		
	<cfelseif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST">
		
		<cfset u_id = SESSION.USER_ID>
		<cfset user_jobtitle = SESSION.USER_JOBTITLE>
		<cfset user_phone = REReplace(SESSION.USER_PHONE,"[^0-9 -+]","","all")>
		<cfset user_phone_code = SESSION.USER_PHONE_CODE>
		<cfset user_phone_2 = REReplace(SESSION.USER_PHONE_2,"[^0-9 -+]","","all")>
		<cfset user_phone_2_code = SESSION.USER_PHONE_2_CODE>
		<cfset user_email = SESSION.USER_EMAIL>
		<cfset user_email_2 = SESSION.USER_EMAIL_2>
		<cfset business_id = SESSION.BUSINESS_ID>
		<cfset user_needs_complement = SESSION.USER_NEEDS_COMPLEMENT>
		
	</cfif>
		
	<cfset phone_code_init = '"#SESSION.LANG_CODE eq "en" ? "gb" : SESSION.LANG_CODE#"'>
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
		<cfscript>
			if (lg neq SESSION.LANG_CODE) {
				if ( lg neq "en") {
					phone_code_init=ListAppend(phone_code_init,'"#lg#"',",");
				} else {
					phone_code_init=ListAppend(phone_code_init,'"gb"',",");
				}
			}
		</cfscript>
	</cfloop>
	
	<cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
		SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name 
		FROM settings_country 
		WHERE country_alpha = "#SESSION.LANG_CODE eq "en" ? "gb" : SESSION.LANG_CODE#" LIMIT 1
	</cfquery>
		
	<cfquery name="get_business_area" datasource="#SESSION.BDDSOURCE#">
	SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 2 ORDER BY keyword_name ASC
	</cfquery>

	<cfif SESSION.LAUNCH_GROUP eq 0>
		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1")>
	<cfelse>
		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",m_id="11")>
	</cfif>
	


	<div>

		<!--- <div class="header_rounded_top border-bottom border-info" style="background-image: url('https://lms.wefitgroup.com/assets/img/header_modal_5.jpg'); height:200px; background-position:top right; background-size: cover;">

		</div> --->
   

		<!--- <div>
			<img src="./assets/img/header_modal_3.jpg" class=" border-bottom border-info border-4" style="width:100%; max-height:220px">
		</div> --->

		<div class="p-3">


			<div class="media">
				<img class="mr-3 img_rounded" src="./assets/img/lst_kinesthetic.jpg" width="200">
				<div class="media-body">
					
					<cfif SESSION.LAUNCH_GROUP eq 0>
					<h5 class="mt-0"><cfoutput>#obj_translater.get_translate_complex('alert_launch_title_before_start')#</cfoutput></h5>
					<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_before_start')#</cfoutput>
					<cfelse>
						<h5 class="mt-0"><cfoutput>#obj_translater.get_translate_complex('alert_launch_title_before_start_group')#</cfoutput></h5>
						<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_before_start_group')#</cfoutput>
					
					</cfif>
				</div>
			</div>

			<p class="mt-3">

			<div class="accordion mt-4" id="accordion_tp">
						
				<div class="card border border-info" style="background-color:#FCFCFC">
				
					<div class="card-header">
					
						<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_item_1" aria-expanded="true" aria-controls="collapse_item_1">
							
							<h5 class="my-1 text-info" align="center">
							
							<cfif SESSION.LAUNCH_GROUP eq 0>
								<cfoutput>#obj_translater.get_translate('accordion_launch_reminder')#</cfoutput>
							<cfelse>
								<cfoutput>#obj_translater.get_translate('accordion_launch_reminder_group')#</cfoutput>
							</cfif>

							<i class="fas fa-check-circle fa-lg pull-right pt-3 text-success collapse" id="check_1"></i>
							
							</h5>
						</button>

						<div id="collapse_item_1" class="collapse show pb-2" data-parent="#accordion_tp">
							
							<table class="table table_subscription border bg-white">
								<tr>
									<td class="bg-light">
									<cfoutput>#obj_translater.get_translate('table_th_program')#</cfoutput>
									</td>
									<td class="bg-light">
									<cfoutput>#obj_translater.get_translate('card_deadline')#</cfoutput>
									</td>
								</tr>
								<cfoutput query="get_tps">
									<cfif method_id eq "3">
										<cfset access_el = "1">
									<cfelseif method_id eq "2">
										<cfset access_f2f = "1">
									<cfelseif method_id eq "1">
										<cfset access_visio = "1">
									</cfif>
									<tr>
										<td width="35%">
										#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
										</td>
										<td width="65%">
										
										<cfif order_start neq "">
											<cfset limit_date_start = obj_dater.get_dateformat(order_start)>
										<cfelse>
											<cfset limit_date_start = obj_dater.get_dateformat(tp_date_start)>
										</cfif>
										
										<cfif order_end neq "">
											<cfset limit_date_end = obj_dater.get_dateformat(order_end)>
										<cfelse>
											<cfset limit_date_end = obj_dater.get_dateformat(tp_date_end)>
										</cfif>
								
										<cfset arr = ['limit_date_start', 'limit_date_end']>
										<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
										#obj_translater.get_translate_complex(id_translate="order_end_reminder", argv="#argv#")#
										
										</td>
									</tr>
								</cfoutput>
							</table>
							
							<div align="center">
							<cfoutput><button type="button" class="btn btn-lg btn-info btn_valid_1"> #obj_translater.get_translate("btn_continue")# <i class="far fa-chevron-double-right"></i></button></cfoutput>
							</div>
							
							
							
								
						</div>
						
					</div>
					
				</div>
				
				
				
				
				
				
				
				
				
				<cfif SESSION.USER_SETUP eq "1">
				<div class="card border border-info" style="background-color:#FCFCFC">
				
					<div class="card-header">
					
						<button type="button" id="btn_head_2" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_2" aria-expanded="false" aria-controls="collapse_item_2">
							<h5 class="my-1 text-info" align="center">
							<cfoutput>#obj_translater.get_translate('accordion_launch_setup')#</cfoutput>
							<i class="fas fa-check-circle fa-lg pull-right pt-3 text-success collapse" id="check_2"></i>
							</h5>
						</button>

						<div id="collapse_item_2" class="collapse pb-2" data-parent="#accordion_tp">
						
							<div class="alert bg-light text-dark border" role="alert">
								<div class="media">
									<i class="fal fa-info-circle fa-3x mr-3"></i>
									<div class="media-body">
										<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_setup')#</cfoutput>
									</div>
								</div>
							</div>
							
							<div align="center">
							<cfoutput><button type="button" class="btn btn-lg btn-info btn_valid_2"><cfoutput>#obj_translater.get_translate('btn_continue')#</cfoutput>  <i class="far fa-chevron-double-right"></i></button></cfoutput>
							</div>
							
						</div>
						
					</div>
					
				</div>
				</cfif>
				
				
				<div class="card border border-info" style="background-color:#FCFCFC">
				
					<div class="card-header">
					
						<button type="button" id="btn_head_3" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_3" aria-expanded="false" aria-controls="collapse_item_3">
							<h5 class="my-1 text-info" align="center">
							<cfoutput>#obj_translater.get_translate('accordion_launch_cgu')#</cfoutput>
							
							<i class="fas fa-check-circle fa-lg pull-right pt-3 text-success collapse" id="check_3"></i>
							</h5>
						</button>

						<div id="collapse_item_3" class="collapse pb-2" data-parent="#accordion_tp">
						<form id="charter_form">
							<div class="card-deck">
								<div class="card border">
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
											<a class="btn btn-sm btn-outline-info" target="_blank" href="common_cgu.cfm?show_info=use">#obj_translater.get_translate('btn_view_use')#</a> 
											<label class="text-dark"><input type="checkbox" name="accept_use" id="accept_use" checked> #obj_translater.get_translate_complex('accept_learner_use')#</label>
											
											</cfoutput>
										</div>
										
									</div>
								</div>
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
											<a class="btn btn-sm btn-outline-info" href="common_cgu.cfm?show_info=policy" target="_blank">#obj_translater.get_translate('btn_view_policy')#</a>
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
							<cfoutput><button type="submit" class="btn btn-lg btn-info btn_valid_3 mt-3"> <cfoutput>#obj_translater.get_translate('btn_continue')#</cfoutput> <i class="far fa-chevron-double-right"></i></button></cfoutput>
							</div>
						</form>
						</div>
						
					</div>
					
				</div>
				
				
				<div class="card border border-info" style="background-color:#FCFCFC">
				
					<div class="card-header">
					
						<button type="button" id="btn_head_4" class="btn btn-link btn-block text-left" disabled data-toggle="collapse" data-target="#collapse_item_4" aria-expanded="false" aria-controls="collapse_item_4">
							<h5 class="my-1 text-info" align="center">
							<cfoutput>#obj_translater.get_translate('accordion_launch_verif')#</cfoutput>
							<i class="fas fa-check-circle fa-lg pull-right pt-3 text-success collapse" id="check_4"></i>
							</h5>
						</button>

						<div id="collapse_item_4" class="collapse pb-2" data-parent="#accordion_tp">
						<form id="form_user">
						<table class="table bg-white border">
							<!--- <tr style="background-color:#ECECEC"> --->
								<!--- <td width="50%"> --->
								<!--- <cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput> --->
								<!--- </td> --->
								<!--- <td width="50%"> --->
								<!--- <cfoutput>#obj_translater.get_translate('table_th_localisation')#</cfoutput> --->
								<!--- </td> --->
							<!--- </tr> --->
							
							<!--- <tr> --->
								<!--- <td> --->
								<!--- <select name="country_id" id="country_id" class="form-control"> --->
								
								<!--- </select> --->
								<!--- </td> --->
								<!--- <td> --->
								<!--- <input type="text" class="form-control" name="user_based" id="user_based" value="<cfoutput>#user_based#</cfoutput>"> --->
								<!--- </td> --->
							<!--- </tr> --->
									
							<tr>
								<td class="bg-light" width="15%"> <cfoutput>#obj_translater.get_translate('table_th_launch_job')#</cfoutput> <!---<span style="color:#FF0000">*</span>---></td>
								<td>
									<input class="form-control" type="text" name="user_jobtitle" value="<cfoutput>#user_jobtitle#</cfoutput>" placeholder="<cfoutput>#obj_translater.get_translate('form_placeholder_jobtitle')#</cfoutput>">
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_launch_area')#</cfoutput> <!---<span style="color:#FF0000">*</span>---></td>
								<td>
									<select name="keyword_id" class="form-control">
									<option value="0" selected>---<cfoutput>#obj_translater.get_translate('text_no_domain')#</cfoutput>---</option>
									<cfoutput query="get_business_area">
									<option value="#keyword_id#" <cfif keyword_id eq business_id>selected</cfif>>#keyword_name#</option>
									</cfoutput>
									</select>
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_launch_phone1')#</cfoutput> <span style="color:#FF0000">*</span> 
								<i class="fas fa-info-circle fa-lg float-right text-info" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_phone')#</cfoutput>"></i>
								</td>
								<td valign="top">
									<!--- <input type="text" class="form-control" name="user_phone" required="yes" value="<cfoutput>#user_phone#</cfoutput>"> --->

									<input id="user_phone" type="tel" name="user_phone" class="form-control" />
									<input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfif user_phone_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_code#</cfoutput></cfif>" />
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_launch_phone2')#</cfoutput></td>
								<td valign="top">
									<!--- <input type="text" class="form-control" name="user_phone_2" value="<cfoutput>#user_phone_2#</cfoutput>"> --->

									<input id="user_phone_2" type="tel" name="user_phone_2" class="form-control" />
									<input id="user_phone_2_code" type="hidden" name="user_phone_2_code"  value="<cfif user_phone_2_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_2_code#</cfoutput></cfif>" />
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_launch_email1')#</cfoutput> <span style="color:#FF0000">*</span> </td>
								<td valign="top">
									<input type="text" class="form-control" name="user_email" disabled value="<cfoutput>#user_email#</cfoutput>">
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_launch_email2')#</cfoutput></td>
								<td valign="top">
									<input type="text" class="form-control" name="user_email_2" validate="email" value="<cfoutput>#user_email_2#</cfoutput>">
								</td>
							</tr>
								
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_launch_complement')#</cfoutput></td>
								<td>
									<textarea class="form-control" name="user_needs_complement" rows="4"><cfoutput>#user_needs_complement#</cfoutput></textarea>
								</td>
							</tr>
							
							<tr>
								<td colspan="2">
								<small><span style="color:#FF0000">* <cfoutput>#obj_translater.get_translate('tooltip_required_field')#</cfoutput></span></small>
								</td>
							</tr>
							
							
						</table>
						
						<div align="center" class="mt-3">
							<button type="submit" id="btn_valid_all" class="btn btn-lg btn-info btn-info" disabled>
							<cfoutput>#obj_translater.get_translate('btn_start_formation')#</cfoutput> <i class="fas fa-arrow-right"></i>
							</button>
						</div>
						
						</form>
							
						</div>
						
					</div>
					
				</div>
				
			
			</div>

		</div>
	</div>


<script>
$(document).ready(function() {

	<cfif isDefined("user_phone_code")>
	<cfif user_phone_code neq "">
		<cfquery name="get_default_code" datasource="#SESSION.BDDSOURCE#">
			SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_code#" LIMIT 1
		</cfquery>
	</cfif></cfif>
		

	const phoneInputField = document.querySelector("#user_phone");
	const phoneInput = window.intlTelInput(phoneInputField, {
		customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
				return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
			},
		preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
		<cfif isDefined("user_phone_code")><cfif user_phone_code neq "" AND get_default_code.recordCount eq 1>initialCountry: "<cfoutput>#get_default_code.country_alpha#</cfoutput>",</cfif></cfif>
		utilsScript:
		"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
	});
	phoneInput.setNumber("<cfoutput>#user_phone#</cfoutput>");

	$('#user_phone').on('countrychange', function(e) {
		var countryData = phoneInput.getSelectedCountryData();
		var codetmp = countryData.dialCode;
			
		if (countryData.areaCodes) {
			if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
		}
		$("#user_phone_code").val(codetmp);
	});


	<cfif isDefined("user_phone_2_code")>
	<cfif user_phone_2_code neq "">
		<cfquery name="get_default_code" datasource="#SESSION.BDDSOURCE#">
			SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_2_code#" LIMIT 1
		</cfquery>
	</cfif></cfif>
		

	const phoneInputField2 = document.querySelector("#user_phone_2");
	const phoneInput2 = window.intlTelInput(phoneInputField2, {
		customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
				return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
			},
		preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
		<cfif isDefined("user_phone_2_code")><cfif user_phone_2_code neq "" AND get_default_code.recordCount eq 1>initialCountry: "<cfoutput>#get_default_code.country_alpha#</cfoutput>",</cfif></cfif>
		utilsScript:
		"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
	});
	phoneInput2.setNumber("<cfoutput>#user_phone_2#</cfoutput>");

	$('#user_phone_2').on('countrychange', function(e) {
		var countryData = phoneInput2.getSelectedCountryData();
		var codetmp = countryData.dialCode;
			
		if (countryData.areaCodes) {
			if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
		}
			
		$("#user_phone_2_code").val(codetmp);
	});

	// $('.btn_contact_wefit').hide();

	// $('.btn_contact_wefit_modal').click(function(event) {	

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

	$('[data-toggle="tooltip"]').tooltip({html: true});
	
	$('#charter_form').submit(function(event) {

		if($('#accept_use').prop('checked') != true || $('#accept_policy').prop('checked') != true)
		{
		alert("<cfoutput>#obj_translater.get_translate('alert_accept_charter')#</cfoutput>");
		return false;
		}
		else
		{
		$('#check_3').collapse('toggle');		
		$('#btn_head_4').prop("disabled", false);
		$('#collapse_item_4').collapse('toggle');
		$('#btn_valid_all').prop("disabled", false);
		return false;
		}
	});
	
	
	
	$(".btn_valid_1").click(function() {
		<!--- $('#collapse_item_1').collapse('hide'); --->
		$('#check_1').collapse('toggle');		
		$('#btn_head_2').prop("disabled", false);
		$('#collapse_item_2').collapse('toggle');
	})
					
					
	$(".btn_valid_2").click(function() {
		<!--- $('#collapse_item_2').collapse('toggle'); --->
		$('#check_2').collapse('toggle');		
		$('#btn_head_3').prop("disabled", false);
		$('#collapse_item_3').collapse('toggle');
	})
	
	
	$("#form_user").submit(function(event) {
		event.preventDefault();
		console.log($('#form_user').serialize());
		$.ajax({				 
			url: 'updater_user.cfc?method=updt_user_launching',
			type: 'POST',		
			dataType: 'json',
			data: $('#form_user').serialize(),
			success : function(resultat, statut){
				$('#window_item_xl_unclosable').modal('hide');
				<!--- console.log(resultat); --->
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








































<cfelseif findnocase("qpt_",show_info) AND isdefined("choice")>
<cfset f_code = listgetat(show_info,2,"_")>

	<!------------ WANT TO SKIP QPT ----->
	<cfif choice eq "0">
	
	<form action="updater_form.cfm" method="post" id="level_form">	
	<div class="row">
		<div class="col-md-12 mt-3">
			<cfoutput>	

			<div class="media">
				<img class="mr-3 img_rounded" src="./assets/img/qpt_#f_code#.jpg" width="200">
				<div class="media-body">
					<h5 class="mt-0"><cfoutput>#obj_translater.get_translate_complex('skip_pt')#</cfoutput></h5>
					#obj_translater.get_translate_complex('ask_learner_level')#
				</div>
			</div>

			<br>
			
			<select class="form-control" name="user_level" id="user_level">
				<option value="0">---#obj_translater.get_translate('btn_choose_level')#---</option>
				<option value="A0" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "A0">selected</cfif>>#obj_translater.get_translate('level_a0')#</option>
				<option value="A1" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "A1">selected</cfif>>#obj_translater.get_translate('level_a1')#</option>
				<option value="A2" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "A2">selected</cfif>>#obj_translater.get_translate('level_a2')#</option>
				<option value="B1" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "B1">selected</cfif>>#obj_translater.get_translate('level_b1')#</option>
				<option value="B2" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "B2">selected</cfif>>#obj_translater.get_translate('level_b2')#</option>
				<option value="C1" <cfif StructKeyExists(SESSION.USER_LEVEL,f_code) AND SESSION.USER_LEVEL[f_code].level_code eq "C1">selected</cfif>>#obj_translater.get_translate('level_c1')#</option>
				<!--- <option value="C2" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "C2">selected</cfif>>#obj_translater.get_translate('level_c2')#</option> --->
			</select>
			
			<div align="center" class="mt-4">
				<input type="hidden" name="form_type" value="level_form">
				<input type="hidden" name="f_code" value="#f_code#">
					
				<button class="btn btn-lg btn-info" type="submit">
				#obj_translater.get_translate('btn_validate_levelstep')# <i class="far fa-chevron-double-right"></i>
				</button>
			</div>
			</cfoutput>
		</div>			
	</div>
	</form>

	<script>
	$(document).ready(function() {

		$('#level_form').submit(function(event) {

			if($('#user_level').val() == 0)
			{
			alert("<cfoutput>#encodeForJavaScript(trim(obj_translater.get_translate_complex('alert_enter_valid_level')))#</cfoutput>");
			return false;
			}
			else
			{
			return true;
			}
			
		});
			
	})
	</script>

	</cfif>















	
<cfelseif show_info eq "lst" AND isdefined("choice")>

	<!------------ WANT TO SKIP LST ----->
	<cfif choice eq "3">
	
		<form action="updater_form.cfm" method="post" id="level_form">	
		<div class="row">
			<div class="col-12 mt-3">	
			
				<div class="media">
					<img class="mr-3 img_rounded" src="./assets/img/lst.jpg" width="200">
					<div class="media-body">
						<cfoutput>#obj_translater.get_translate_complex('skip_lst')#</cfoutput>
					</div>
				</div>	
				
				<div align="center" class="mt-3">			
					<input type="hidden" name="form_type" value="lst_form">
					<button class="btn btn-lg btn-info" type="submit">
					<cfoutput>#obj_translater.get_translate('btn_validate_lststep')#</cfoutput> <i class="far fa-chevron-double-right"></i>
					</button>
				</div>
				
			</div>			
		</div>
		</form>

	<!------------ WANT TO PASS LST ----->
	<cfelseif choice eq "4">

		<div class="row">
			<div class="col-12 mt-3">
				<div class="media">
					<img class="mr-3 img_rounded" src="./assets/img/lst.jpg" width="200">
					<div class="media-body">
						<h5 class="mt-0"><cfoutput>#obj_translater.get_translate('js_modal_title_lst')#</cfoutput></h5>
						<cfoutput>#obj_translater.get_translate_complex('learning_style_test2')#</cfoutput>
						
						<cfoutput>#obj_translater.get_translate_complex('start_lst_subtitle')#</cfoutput>
					</div>
				</div>				
				

				<div align="center">			
													
					<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
					SELECT * FROM lms_quiz_user qu
					INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
					WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_type = "lst"
					</cfquery>

					<cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
						<cfoutput><a href="##" class="btn btn-info btn_view_quiz" id="quser_#get_result_lst.quiz_user_id#">#obj_translater.get_translate('btn_results')# #get_result_lst.quiz_name#</a> </cfoutput>											
					<cfelseif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end eq "">
						<cfoutput><a href="./quiz.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&f=go" class="btn btn-lg btn-danger">#obj_translater.get_translate('btn_continue')# #get_result_lst.quiz_name#</a>	</cfoutput>										
					<cfelse>
						<a href="./quiz.cfm?new_quiz=1&quiz_id=3" class="btn btn-lg btn-info"><i class="fal fa-arrow-right" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>														
					</cfif>
						
				</div>
			</div>
		</div>

	</cfif>
	
	
	

</cfif>