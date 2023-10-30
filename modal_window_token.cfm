<cfif isdefined("t_id") AND isdefined("action")>

<cfsilent>

<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_list_token t
INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
</cfquery>

<cfif action eq "create">
	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
	SELECT account_id, account_name FROM account ORDER BY account_name
	</cfquery>

	<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
	SELECT user_status_id, UCASE(user_status_name_fr) AS user_status_name FROM user_status WHERE user_status_id = 4
	</cfquery>

	<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
	SELECT profile_id, UCASE(profile_name) as profile_name FROM user_profile WHERE profile_id = 7
	</cfquery>

	<cfquery name="get_user_type" datasource="#SESSION.BDDSOURCE#">
	SELECT user_type_id, user_type_name_#SESSION.LANG_CODE# as user_type_name FROM user_type WHERE user_type_id = 3
	</cfquery>
<cfelseif action eq "affect">
	<cfquery name="get_all_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT account_name, account_id FROM account a ORDER BY account_name ASC
	</cfquery>
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

</cfsilent>


	<!--- <table class="table table-sm table-bordered"> --->
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong><cfoutput>Token #get_token.token_code#</cfoutput></strong></td> --->
		<!--- </tr> --->
		
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"><label>Email Candidat</label></td> --->
			<!--- <td colspan="2"> --->
			<!--- <input class="form-control" type="email" name="email_send" required="yes" validate="email" value=""> --->
			<!--- </td> --->
		<!--- </tr> --->
		
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"><label>Email en CC (RH, Resp Ecole)</label></td> --->
			<!--- <td colspan="2"> --->
			<!--- <input class="form-control" type="email" name="email_send" validate="email" value=""> --->
			<!--- </td> --->
		<!--- </tr> --->
		
	<!--- </table> --->
	
	
	
	
	<cfform action="updater_token.cfm" id="user_create">
		
		
		<div class="alert alert-info">
		Envoyer le jeton suivant :
		<br>
		<h5><cfoutput>#get_token.token_code#</cfoutput></h5>
		<br>
		Pour la certification :
		<br>
		<h5><cfoutput>#get_token.certif_name#</cfoutput></h5>
		</div>
	
		
		<cfif action eq "create">
		<table class="table table-sm">
			<tr>
				<td colspan="3" bgcolor="#ECECEC"><strong>Profil learner</strong></td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Type*</label>
				</td>
				<td colspan="2">
					<cfselect name="profile_id" class="form-control form-control-sm" query="get_profile" display="profile_name" value="profile_id">

					</cfselect>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="20%"><label>Status*</label></td>
				<td colspan="2">
					<select name="user_status_id" class="form-control form-control-sm">
						<cfoutput query="get_user_status">
						<option value="#user_status_id#">#user_status_name#</option>
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="20%"><label>Rang*</label></td>
				<td colspan="2">
					<cfselect name="user_type_id" class="form-control form-control-sm" query="get_user_type" display="user_type_name" value="user_type_id" selected="3"></cfselect>
				</td>
			</tr>
			
			<tr>
				<td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_lms_language')#</cfoutput>*</label></td>
				<td colspan="2">
					<select name="user_lang" class="form-control form-control-sm">
					<cfoutput>
					<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
						<option value="#cor#" <cfif cor eq "fr">selected</cfif>>#ucase(cor)#</option>
					</cfloop>
					</cfoutput>
					</select>
				</td>
			</tr>
				
			<tr>
				<td colspan="3" bgcolor="#ECECEC"><strong>Coordonn&eacute;es</strong></td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Civilit&eacute;*</label>
				</td>
				<td colspan="2">
					<label><input name="user_gender" type="radio" value="M." checked> M.</label>&nbsp;&nbsp;&nbsp;
					<label><input name="user_gender" type="radio" value="Mme"> Mme</label>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Pr&eacute;nom*</label>
				</td>
				<td colspan="2">
				<input type="text" class="form-control" name="user_firstname" required="yes" placeholder="Pr&eacute;nom">
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Nom*</label>
				</td>
				<td colspan="2">
				<input type="text" class="form-control" name="user_lastname" required="yes" placeholder="Nom">
				</td>
			</tr>
			
			<tr>
				<td class="bg-light" width="30%">
				<label>Compte*</label>
				</td>
				<td colspan="2">
					<cfselect name="account_id" id="account_id" class="form-control form-control-sm" query="get_account" display="account_name" value="account_id" selected="47">
					<!--- <option value="0" selected>---- ATTACHER COMPTE ---- </option> --->
					</cfselect>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>T&eacute;l&eacute;phone 1</label>
				</td>
				<td colspan="2">
				<!--- <input type="text" class="form-control" name="user_phone" placeholder="T&eacute;l&eacute;phone"> --->
				<input id="user_phone" type="tel" name="user_phone" class="form-control" />
				<input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
				</td>
			</tr>
			<tr>
				<td colspan="3" bgcolor="#ECECEC"><strong>Identifiants de connexion</strong></td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Créer elearning 1 mois</label>
				</td>
				<td colspan="2">
				<label><input type="radio" name="user_create_el" value="1"> OUI</label>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label><input type="radio" name="user_create_el" value="0" checked> NON</label>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Email (connexion)*</label>
				</td>
				<td colspan="2">
				<input type="text" class="form-control" name="user_email" required="yes" placeholder="Email principal">
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Mot de passe <em>(temporaire)</em></label>
				</td>
				<td colspan="2">
				<cfset temp = RandRange(100000, 999999)>
				<input type="text" class="form-control" name="user_pwd" required="yes" value="<cfoutput>#temp#</cfoutput>">
				</td>
			</tr>
	
			<tr>
				<td colspan="2">
				<cfoutput>
				<input type="hidden" name="action" value="create">
				<input type="hidden" name="t_id" value="#t_id#">
				</cfoutput>	
				<div align="center"><input type="submit" class="btn btn-success" value="Envoyer token"></div>		
				
				</td>
			</tr>
		</table>
		<cfelseif action eq "affect">
		<table class="table table-sm">
			<tr>
				<td class="bg-light" width="30%">
				<label>Account</label>
				</td>
				<td colspan="2">
					<!--- <cfselect name="user_id" id="user_id" class="form-control form-control-sm" query="get_user" display="user_name" value="user_id">
					<option value="0" selected>---Choisir Apprenant ----</option>
					</cfselect> --->
					<select name="account_select" id="account_select" class="form-control form-control-sm" <cfif isdefined("o_id")>disabled</cfif>>
						<option value="0" selected>---Apprenants sans compte----</option>
						<cfoutput>
						<cfloop query="get_all_account">
							<option value="#account_id#">#account_name#</option>
						</cfloop>
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Learner</label>
				</td>
				<td colspan="2">
					<!--- <cfselect name="user_id" id="user_id" class="form-control form-control-sm" query="get_user" display="user_name" value="user_id">
					<option value="0" selected>---Choisir Apprenant ----</option>
					</cfselect> --->
					<div id="container_existing_user">
					</div>
					<!--- <select id="learner_select" name="user_id" class="learner_select_all form-control form-control-sm">
					</select> --->
				</td>
			</tr>
			<tr>
				<td class="bg-light" width="30%">
				<label>Créer elearning 1 mois</label>
				</td>
				<td colspan="2">
				<label><input type="radio" name="user_create_el" value="1"> OUI</label>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label><input type="radio" name="user_create_el" value="0" checked> NON</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<cfoutput>
				<input type="hidden" name="action" value="affect">
				<input type="hidden" name="t_id" value="#t_id#">
				</cfoutput>	
				<div align="center"><input type="submit" class="btn btn-success" value="Envoyer mail"></div>		
				
				</td>
			</tr>
		<cfelseif action eq "send">
		<table class="table table-sm">
			<tr>
				<td colspan="2">
				<cfoutput>
				<input type="hidden" name="action" value="send">
				<input type="hidden" name="t_id" value="#t_id#">
				<!--- <input type="hidden" name="user_create_el" value="1"> --->
				</cfoutput>	
				<div align="center"><input type="submit" class="btn btn-success" value="Envoyer mail"></div>		
				
				</td>
			</tr>
			
		</cfif>
		</cfform>


	<script>
	$(document).ready(function() {
			
	<cfif action eq "create">
				
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

	<cfelseif action eq "affect">

	function updateuserlist(val_acc_selected){
	// learner_select_all
	// console.log(val_acc_selected);
	$.ajax({
		url: './api/users/user_get.cfc?method=oget_account_user',
		type: 'POST',
		data: { a_id: val_acc_selected, learner_only: 1 },
		success: function (result, status) {
			// console.log(result);
			var obj_result = jQuery.parseJSON(result);
			var target = $("#container_existing_user");
			target.empty(); // remove old options

			var el = $("<select></select>")
			el.attr("class", "learner_select_all form-control form-control-sm")
			el.attr("id", "learner_select")
			el.attr("name", "user_id")
			el.append($("<option></option>").attr("value", "0").text("---Choisir Apprenant ----"));

			obj_result.forEach(element => {
				el.append($("<option></option>").attr("value", element.USER_ID).text(element.USER_NAME + " " + element.USER_FIRSTNAME + ' - ' + element.PROFILE_NAME));
			});
			target.append(el);

		}
		});
	}

	updateuserlist(0);

	$("#account_select").change(function(event) {
		// $("#pack_id option[value='0']").prop("selected", true);

		var val_acc_selected = $(event.target).val();
		updateuserlist(val_acc_selected);
	})
	</cfif>

	});
	</script>
	
</cfif>
