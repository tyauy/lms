<!DOCTYPE html>

<cfinclude template="./incl/incl_lang.cfm">

<cfquery name="get_situation" datasource="#SESSION.BDDSOURCE#">
SELECT situation_id, situation_name_#lang_doc# as situation_name FROM user_situation
</cfquery>

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

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfif not isdefined("SESSION.USER_ID")>
		<cfinclude template="./incl/incl_head_light.cfm">
		<style type="text/css">
		.card {
			border-radius: 2px !important;
			box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
		}
		</style>
	<cfelse>
		<cfinclude template="./incl/incl_head.cfm">
	</cfif>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_subscription')#">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<div class="row justify-content-center">

				<div class="col-md-8 col-sm-12">
				 
					<div class="card border-top border-info">
						<div class="card-header my-2">
							<h5 class="card-title">
							<img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_wefit_100.jpg" width="30" align="left" style="margin-right:15px">
							<cfoutput>#obj_translater.get_translate('card_subscribe')#</cfoutput>
							</h5>
							<p class="mt-3"><cfoutput>#obj_translater.get_translate('text_subscription')#</cfoutput> 
							<ul>
							<li><cfoutput>#obj_translater.get_translate('text_subscription_1')#</cfoutput></li>
							<li><cfoutput>#obj_translater.get_translate('text_subscription_2')#</cfoutput></li>
							<li><cfoutput>#obj_translater.get_translate('text_subscription_3')#</cfoutput></li>
							</ul>
							</p>
					
						</div>
						<div class="card-body">

							<form class="mt-3" action="_updater_subscribe.cfm" method="post">
				
								<cfif isdefined("e")>
								<div class="row">
									<div class="col-md-12">
									<cfif e eq "1">
										<div class="alert alert-danger" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_user_already_exist')#</cfoutput>
										</div>
									</cfif>	
									</div>
								</div>
								</cfif>	
								<cfoutput>
								<div class="form-group row">
									<label for="user_name" class="col-sm-3 col-form-label">#obj_translater.get_translate('form_subscription_1')# :*</label>
									<div class="col-sm-4">
									<input type="text" class="form-control form-control-sm" id="user_firstname" name="user_firstname" required="yes" placeholder="#obj_translater.get_translate('form_label_firstname')#">
									</div>
									<div class="col-sm-5">
									<input type="text" class="form-control form-control-sm" id="user_name" name="user_name" required="yes" placeholder="#obj_translater.get_translate('form_label_name')#">
									</div>
								</div>
								<div class="form-group row mt-2">
									<label for="user_email" class="col-sm-3 col-form-label">#obj_translater.get_translate('form_label_email')#*</small></label>
									<div class="col-sm-9">
									<input type="email" class="form-control form-control-sm" id="user_email" name="user_email" required="yes" placeholder="email@example.com">
									</div>
								</div>
								<div class="form-group row mt-2">
									<label for="user_password" class="col-sm-3 col-form-label">#obj_translater.get_translate('form_label_password')#*</small></label>
									<div class="col-sm-9">
									<input type="password" class="form-control form-control-sm" id="user_password" name="user_password" required="yes" placeholder="*******">
									</div>
								</div>
								<div class="form-group row mt-2">
									<label for="user_phone" class="col-sm-3 col-form-label">#obj_translater.get_translate('form_subscription_4')#*</small></label>
									<div class="col-sm-9">
									<!--- <input type="text" class="form-control form-control-sm" id="user_phone" name="user_phone" required="yes" placeholder="#obj_translater.get_translate('form_placeholder_phone')#"> --->
									<input id="user_phone" type="tel" name="user_phone" />
									<input id="user_phone_code" type="hidden" name="user_phone_code"  value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
								</div>
								</div>
								<div class="form-group row mt-2">
									<label for="user_situation" class="col-sm-3 col-form-label">#obj_translater.get_translate('form_subscription_5')#*</small></label>
									<div class="col-sm-9">
									<select class="form-control" name="situation_id" id="situation_id">
									<option value="0">---</option>
									<cfloop query="get_situation">
									<option value="#situation_id#">#situation_name#</option>
									</cfloop>
									</select>									
									</div>
								</div>
								<cfif isdefined("lang_doc") AND lang_doc eq "fr">
								<div class="form-group row mt-2">
									<label for="user_cpf" class="col-sm-3 col-form-label">Disposez-vous de droits CPF*<br>(Mon Compte Formation) ?<br></label>
									<div class="col-sm-9">
										<div class="form-check form-check-inline mr-3">
											<input type="radio" class="form-check-input" name="user_cpf" id="user_cpf_1" value="Oui"> <label class="form-check-label pl-1" for="user_cpf_1">Oui</label>
										</div>
										<div class="form-check form-check-inline mr-3">
											<input type="radio" class="form-check-input" name="user_cpf" id="user_cpf_2" value="Non"> <label class="form-check-label pl-1" for="user_cpf_2">Non</label>
										</div>
										<div class="form-check form-check-inline">
											<input type="radio" class="form-check-input" name="user_cpf" id="user_cpf_3" value="Ne sais pas"> <label class="form-check-label pl-1" for="user_cpf_3">Je ne sais pas</label>
										</div>
									</div>
								</div>
								<div class="form-group row mt-2">
									<label for="user_search" class="col-sm-3 col-form-label">&Ecirc;tes vous &agrave; la recherche d'une formation ?</small></label>
									<div class="col-sm-9">
										<div class="form-check form-check-inline mr-3">
											<input type="radio" class="form-check-input" name="user_search" id="user_search_1" value="Oui"> <label class="form-check-label pl-1" for="user_search_1">Oui</label>
										</div>
										<div class="form-check form-check-inline mr-3">
											<input type="radio" class="form-check-input" name="user_search" id="user_search_2" value="Non"> <label class="form-check-label pl-1" for="user_search_2">Non</label>
										</div>
									</div>
								</div>
								</cfif>
								
								</cfoutput>
								
								
								
								<div class="form-group row mt-2">
									<label class="col-sm-3 col-form-label"></label>
									<div class="col-sm-9">
									<input type="checkbox" name="user_optin" required="yes"> <small>
									<cfif SESSION.LANG eq "1">
										J'accepte les conditions d'utilisation du site <a href="https://www.wefitgroup.com/wefit/mentions-legales-cgv-protection-donnees/">www.wefitgroup.com</a></small>
									<cfelseif SESSION.LANG eq "2">
										I agree with the terms of use of <a href="https://www.wefitgroup.com/wefit/mentions-legales-cgv-protection-donnees/">www.wefitgroup.com</a></small>
									<cfelseif SESSION.LANG eq "3">
										Ich akzeptiere die Nutzungsbedingungen von <a href="https://www.wefitgroup.com/wefit/mentions-legales-cgv-protection-donnees/">www.wefitgroup.com</a></small>
									</cfif>
									</div>
								</div>
								<br>
								<div align="center">
								<cfoutput>
								<input type="hidden" name="user_lang" value="#lang_doc#">
								<button class="btn btn-default btn-info" type="submit">#obj_translater.get_translate('form_subscription_btn')#</button></cfoutput>
								</div>

								<div class="form-group row mt-2">
									<div class="col-12">
										<small class="text-muted"><em>* <cfoutput>#obj_translater.get_translate('tooltip_required_field')#</cfoutput></em></small>
									</div>
								</div>
								
							</form>
			
									
						</div>
					</div>
					

				</div>
				
			</div>
	
		</div>
		
		<footer class="footer footer-black footer-white ">
			<div class="container-fluid">
				<div class="row">
					<nav class="footer-nav">
						<ul>
							<li>
							<a href="https://www.wefitgroup.com" target="_blank">SUPPORT WEFIT</a>
							</li>
						</ul>
					</nav>
					<div class="credits ml-auto">
						<span class="copyright">
						<!---<img src="./sources/<cfoutput>#SESSION.MASTER_ID#</cfoutput>/img/logo_wefit_1line.png" height="25" style="margin-top:2px">--->
						&copy;
						<script>
						<cfoutput>#year(now())#</cfoutput>
						</script> / WEFIT / LMS Version 2.2 
						</span>
					</div>
				</div>
			</div>
		</footer>


	</div>
	
</div>

<!-------- MODAL SKELETON ------------>
<div id="window_item_sm" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_sm" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_sm" class="modal-body">
			
			</div>
        </div>
    </div>
</div>


</body>

<cfif not isdefined("SESSION.USER_ID")>
	<cfinclude template="./incl/incl_scripts_light.cfm">
<cfelse>
	<cfinclude template="./incl/incl_scripts.cfm">
</cfif>

<script>

$(document).ready(function() {
	
	const phoneInputField = document.querySelector("#user_phone");
	const phoneInput = window.intlTelInput(phoneInputField, {
		customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
				return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
			},
		preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
		utilsScript:
		"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
	});

	$('#user_phone').on('countrychange', function(e) {
		var countryData = phoneInput.getSelectedCountryData();
		var codetmp = countryData.dialCode;
			
		if (countryData.areaCodes) {
			if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
		}
		$("#user_phone_code").val(codetmp);
	});

	$('.btn_reinit_mdp').click(function(event) {	
		event.preventDefault();
		$('#window_item_sm').modal({keyboard: true});
		$('#modal_title_sm').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_forgotten')#</cfoutput>");
		$('#modal_body_sm').load("_modal_window_mdp_reset.cfm?reinit=1", function() {});

	});


	
});
</script>

</html>