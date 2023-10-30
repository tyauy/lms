<!DOCTYPE html>

<cfparam name="back" default="2">

<cfinclude template="./incl/incl_lang.cfm">

<cfquery name="get_country_list" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
    SELECT country_id, country_name_#SESSION.LANG_CODE# as country_name FROM settings_country WHERE country_id IN (75, 84) ORDER BY country_name_#SESSION.LANG_CODE# ASC
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

<cfif isdefined("SESSION.USER_ID")>

	<!--- <cfset get_user = obj_processor.oget_user('#SESSION.USER_ID#')>
	<cfset get_tps = obj_processor.oget_tps(#SESSION.USER_ID#)>
	<cfset get_orders = obj_processor.oget_orders(#SESSION.USER_ID#, 11)> --->
			
    <cfparam name="user_id" default="#SESSION.USER_ID#">
    <cfparam name="user_firstname" default="">
	<cfparam name="user_name" default="">
	<cfparam name="user_email" default="">
	<cfparam name="user_phone" default="">
	<cfparam name="user_gender" default="">
	<cfparam name="user_company" default="">
	<cfparam name="user_school" default="">

<cfelse>

	<cfparam name="user_id" default="">
	<cfparam name="user_firstname" default="">
	<cfparam name="user_name" default="">
	<cfparam name="user_email" default="">
	<cfparam name="user_phone" default="">
	<cfparam name="user_gender" default="">
	<cfparam name="user_company" default="">
	<cfparam name="user_school" default="">

</cfif>

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head_light.cfm">
    <link  rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
</head>

<script src="https://www.google.com/recaptcha/api.js?render=6Lfw5XEaAAAAAOp0NknElZFU_tF7X0aLNP_erAPZ"></script>
<script>
grecaptcha.ready(function () {
	grecaptcha.execute('6Lfw5XEaAAAAAOp0NknElZFU_tF7X0aLNP_erAPZ', { action: 'contact' }).then(function (token) {
		var recaptcha_response_account = document.getElementById('recaptcha_response_account');
		recaptcha_response_account.value = token;
	});
});
</script>

<style type="text/css">
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
.bck_img{
	background-image: url('./assets/img/back_connect_<cfoutput>#back#</cfoutput>.jpg');
	background-position:center center;
	background-size:cover;
	background-repeat:no-repeat;
}
h1,h2,h3,h4,h5,h6,p,td,button,a{
	font-family: 'Titillium Web', sans-serif;
}
.btn-danger {
    background-color: #CE1D37 !important;
    color: #FFFFFF;
}
.btn-danger:hover,
.btn-danger:focus,
.btn-danger:active,
.btn-danger.active,
.btn-danger:active:focus,
.btn-danger:active:hover,
.btn-danger.active:focus,
.btn-danger.active:hover {
    background-color: #c50202 !important;
}
.text-danger {
    color: #CE1D37 !important;
}
a.text-danger:hover {
    color: #c50202 !important;
}
.iti{
    width: 100%;
}
</style>

<body>
	
<div class="main">

	<div class="container-fluid bck_img">
		
		<div class="container">


            <div class="row d-flex justify-content-center align-items-center min-vh-100 py-6">
                <div class="col-12">
                    
                    <div class="card" style="border-top: 3px solid #CB2039;">
                        <div class="card-body p-3 p-sm-4">
                                
                            <div align="center">
                                <h4 class="font-weight-light m-0">Nous n'avons pas trouvé votre compte</h4>
                                <h5>Vérifiez votre compte wefit <cfoutput>#user_email#</cfoutput></h5>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-sm-12 col-md-8">
                                    <!--- <cfif not findnocase("connect.cfm",SCRIPT_NAME) AND not findnocase("connect_out.cfm",SCRIPT_NAME)>
                                        <form id="form_connect" method="post" action="<cfoutput>#SESSION.BO_CONNECT_URL##SCRIPT_NAME##CGI.QUERY_STRING neq "" ? "?"&CGI.QUERY_STRING : ""#</cfoutput>"> 
                                    <cfelse>
                                        <form id="form_connect" method="post" action="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>"> 
                                    </cfif> --->
                                    <form action="_updater_validate.cfm" method="post" id="link_user">
                                    <div class="mb-3 ">
                                        <input type="text" id="user_email" name="user_email" placeholder="<cfoutput>#obj_translater.get_translate('table_th_email')#</cfoutput>" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <input type="password" id="user_password_tmp" name="user_password_tmp" placeholder="<cfoutput>#obj_translater.get_translate('table_th_password')#</cfoutput>" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <input type="hidden" name="_type" value="login">
                                        <input type="hidden" name="recaptcha_response_account" id="recaptcha_response_account">	
                                        <button id="form_submit" class="btn btn-danger d-block w-100 mt-3" type="submit"><cfoutput>#obj_translater.get_translate('btn_connect')#</cfoutput></button>
                                    </div>
                                    </form>
                                </div>
                            </div>

                            <div class="dropdown-divider"></div>

                            <div align="center">
                                <!--- <h4 class="font-weight-light m-0"><cfoutput>#obj_translater.get_translate('title_page_connect')#</cfoutput></h4> --->
                                <h5>Ou si vous n'avez pas encore de compte WEFIT</h5>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-sm-12 col-md-8">
                                    <cfoutput>
                                    <form action="_updater_validate.cfm" method="post" id="new_user">
                
                                        <div class="form-check-inline">
                                            <label><small><strong>#obj_translater.get_translate('form_label_title')#<span class="text-danger">*</span></strong></small></label><br>
                                            <label for="user_male"><small><span class="ml-5"> M.</span></small></label>
                                            <input type="radio" class="m-1 form-check-input" name="user_gender" id="user_gender" value="M." <cfif user_gender eq "M.">checked</cfif> required>
                                            <label for="user_female"><small><span class="ml-5"> Mme</span></small></label>
                                            <input type="radio" class="m-1 form-check-input" name="user_gender" id="user_gender" value="Mme" <cfif user_gender eq "Mme">checked</cfif>>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mt-2">
                                                <label for="user_firstname"><small><strong>#obj_translater.get_translate('form_label_firstname')#<span class="text-danger">*</span></strong></small></label>
                                                <input type="text" class="form-control" name="user_firstname" required="yes" id="user_firstname" value="#user_firstname#" placeholder="#obj_translater.get_translate('form_label_firstname')#">
                                            </div>
                                            <div class="col-md-6 mt-2">
                                                <label for="user_name"><small><strong>#obj_translater.get_translate('form_label_name')#<span class="text-danger">*</span></strong></small></label>
                                                <input type="text" class="form-control" name="user_name" required="yes" id="user_name" value="#user_name#" placeholder="#obj_translater.get_translate('form_label_name')#">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mt-2">
                                                <label for="user_phone"><small><strong>#obj_translater.get_translate('table_th_phone')#<span class="text-danger">*</span></strong></small></label>
                                                <!--- <input type="text" class="form-control" name="user_phone" required="yes" id="user_phone" value="#user_phone#" placeholder="#obj_translater.get_translate('table_th_phone')#"> --->
                                                <input id="user_phone" type="tel"  class="form-control" name="user_phone" />
                                                <input id="user_phone_code" type="hidden" name="user_phone_code"  value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
                                            </div>
                                            <div class="col-md-6 mt-2">
                                                <label for="user_email"><small><strong>#obj_translater.get_translate('form_label_email')#<span class="text-danger">*</span></strong></small></label>
                                                <input type="email" class="form-control" name="user_email" required="yes" id="user_email" value="#user_email#" placeholder="#obj_translater.get_translate('form_label_email')#">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mt-2">
                                                <label for="user_company"><small><strong>#obj_translater.get_translate('form_label_company')#</strong></small></label>
                                                <input type="text" class="form-control" name="user_company" id="user_company" value="#user_company#" placeholder="#obj_translater.get_translate('form_label_apply')#">
                                            </div>
                                            <div class="col-md-6 mt-2">
                                                <label for="user_school"><small><strong>#obj_translater.get_translate('form_label_school')#</strong></small></label>
                                                <input type="text" class="form-control" name="user_school" id="user_school" value="#user_school#" placeholder="#obj_translater.get_translate('form_label_apply')#">
                                            </div>
                                        </div>
                                        <div class="form-group mt-2">
                                            <label for="user_password_tmp"><small><strong>#obj_translater.get_translate('form_label_password')#<span class="text-danger">*</span></strong></small></label>
                                            <input type="password" class="form-control" name="user_password_tmp" id="user_password_tmp" required="yes">
                                        </div>
                                        <div class="form-group mt-2">
                                            <label for="user_adress"><small><strong>#obj_translater.get_translate('table_th_address')#<span class="text-danger">*</span></strong></small></label>
                                            <input type="text" class="form-control" name="user_adress" required="yes" id="user_adress" placeholder="">
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2 mt-2">
                                                <label for="user_city"><small><strong>#obj_translater.get_translate('shop_postal_code')#<span class="text-danger">*</span></strong></small></label>
                                                <input type="text" class="form-control" name="user_postal" required="yes" id="inputZip">
                                            </div>
                                            <div class="col-md-6 mt-2">
                                                <label for="user_city"><small><strong>#obj_translater.get_translate('shop_city')#<span class="text-danger">*</span></strong></small></label>
                                                <input type="text" class="form-control" name="user_city" required="yes" id="inputCity">
                                            </div>
                                            <div class="col-md-4 mt-2">
                                                <label for="user_country"><small><strong>#obj_translater.get_translate('shop_country')#</strong></small></label>
                                                <select id="user_country" name="user_country" class="form-control">
                                                <!--- <option value="75" selected>France</option> --->
                                                <cfloop query="get_country_list">
                                                    <option value="#get_country_list.country_id#" <cfif get_country_list.country_id eq 75>selected</cfif>>#get_country_list.country_name#</option>
                                                </cfloop>
                                                </select>
                                            </div>		
                                        </div>
                                        <div class="row mt-3">
                                            <div class="form-check-inline">
                                                <label><strong>#obj_translater.get_translate('form_label_inv_address')#</strong></label>
                                                <br>
                                                <label for="user_male"><small><span class="ml-5"> #obj_translater.get_translate('yes')#</span></small></label>
                                                <input type="radio" class="m-1 form-check-input" name="same_adress" id="same_adress" value="oui" checked>
                                                <label for="user_female"><small><span class="ml-5"> #obj_translater.get_translate('no')#</span></small></label>
                                                <input type="radio" class="m-1 form-check-input inv_adress_diff" name="same_adress" id="same_adress" value="non">
                                            </div>
                                        </div>
                                        <div class="inv_adress">
                                        
                                        </div>
                                        <div align="center" class="mt-4">
                                            <!--- <a class="btn btn-link text-dark btn_account" href="##">Pourquoi créer un compte ?</a> --->
                                            <input type="hidden" name="_type" value="register">
                                            <input type="hidden" name="recaptcha_response_account" id="recaptcha_response_account">	
                                            <button type="submit" class="btn btn-dark">#obj_translater.get_translate('shop_create_account')#</button>
                                        </div>
                                    </form>
                                    </cfoutput>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
                    

        </div>
	</div>

</div>

<footer style="position: fixed; bottom: 0; width: 100%; text-align: center; background-color: rgba(255, 255, 255, 0.5);">
	<div class="container p-2 text-dark">
		<a role="button" class="text-dark btn_show_charter" class="text-muted"><cfoutput>#obj_translater.get_translate('card_use')#</cfoutput></a>
		|
		<a role="button" class="text-dark btn_show_cgu" class="text-muted"><cfoutput>#obj_translater.get_translate('card_policy')#</cfoutput></a>
		|
		<a role="button" class="text-dark btn_contact_wefit" class="text-muted"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
	</div>
</footer>


<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<cfinclude template="./incl/incl_scripts_modal.cfm">



<script src="./assets/js/core/jquery.min.js"></script>	
<script src="./assets/js/core/bootstrap.min.js"></script>
<script>

$(document).ready(function() {

	const phoneInputField = document.querySelector("#user_phone");
    if(phoneInputField){
        const phoneInput = window.intlTelInput(phoneInputField, {
            customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
                return "<cfoutput>#obj_translater.get_translate('table_th_phone')#</cfoutput>";
            },
            <!--- preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>], --->
            onlyCountries: ["fr", "de"],
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
    }


	$('.btn_show_cgu').click(function(event) {	
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_cgu'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_cgu.cfm?view=display_cgu", function() {});
	});

	$('.btn_show_charter').click(function(event) {	
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_charter'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_cgu.cfm?view=display_charter", function() {});
	});

	$('.btn_contact_wefit').click(function(event) {	
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_contact_wefit'))#</cfoutput>");
		$('#modal_body_lg').load("modal_window_contact.cfm?view=l", function() {});
	});



	/********************** FOR MODAL CLOSING *********************/
	$("#window_item_sm").on('hidden.bs.modal', function () {
		$('#modal_body_sm').empty();
		$('#modal_title_sm').empty();
	});
	
	$("#window_item_lg").on('hidden.bs.modal', function () {
		$('#modal_body_lg').empty();
		$('#modal_title_lg').empty();
	});

	$("#window_item_xl").on('hidden.bs.modal', function () {
		$('#modal_body_xl').empty();
		$('#modal_title_xl').empty();
	});
	



});
</script>

</body>

</html>