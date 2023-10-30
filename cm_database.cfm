
<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,8,11,12">
	<cfinclude template="./incl/incl_secure.cfm">

    <cfparam name="a_id" default="">

    <cfif a_id eq "" AND isDefined("SESSION.USER_ACCOUNT_RIGHT_ID")>
        <cfset a_id = SESSION.USER_ACCOUNT_RIGHT_ID>
    </cfif>
    
    <!--- <cfset get_contact = obj_account_get.get_contact(a_id="#a_id#")> --->

    <cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
        SELECT user_id, user_firstname, user_name, user_email, user_status_id, user_session_right_id
        FROM user
        WHERE profile_id = 11 
        AND account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#" list="yes">)
    </cfquery>


    <cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
        SELECT a.account_name, a.account_id, a.group_id
        FROM account a 
        WHERE a.type_id = 9
        <cfif a_id neq "">
            AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#" list="yes">)
        </cfif>
        GROUP BY a.account_id
        ORDER BY a.account_name
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


    <cfquery name="get_certif_all" datasource="#SESSION.BDDSOURCE#">
        SELECT lts.token_session_id, token_session_name, token_session_start, token_session_end, 
        token_session_last_update, token_session_method, token_session_certif_type, token_session_status,
        a.account_name, a.account_id,
        COUNT(lt.user_id) AS nb
        FROM lms_list_token_session lts
        INNER JOIN account a ON a.account_id = lts.account_id
        LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
        WHERE 1=1

            AND lts.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#" list="yes">)
            
        GROUP BY lts.token_session_id
        ORDER BY lts.token_session_name ASC
    </cfquery>

<!--- <cfif isDefined("SESSION.USER_ACCOUNT_RIGHT_ID") AND SESSION.USER_ACCOUNT_RIGHT_ID neq "">
    AND a.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)
</cfif>
<cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
    AND lts.token_session_id IN (#SESSION.USER_SESSION_RIGHT_ID#)
</cfif> --->
</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>
<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
.iti{
    width: 100%;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Gestion Collaborateurs">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
      

            <div class="row mt-4">
                <div class="col-md-12">

                    
<!--- a_id =  <cfoutput>#a_id#</cfoutput> --->
                    <form id="form_new_collab">
                        <table class="table bg-white" id="session_container">
                                
                            <tr>
                                <td colspan="3" bgcolor="#ECECEC"><strong>CREER UN COMPTE GESTIONNAIRE</strong></td>
                            </tr>
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>Email (connexion)*</label>
                                </td>
                                <td colspan="2">
                                <input type="text" class="form-control" name="user_email" required="yes" placeholder="Email principal">
                                </td>
                            </tr>
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>Civilit&eacute;*</label>
                                </td>
                                <td colspan="2">
                                    <label><input name="user_gender" type="radio" value="M." checked> M.</label>&nbsp;&nbsp;&nbsp;
                                    <label><input name="user_gender" type="radio" value="Mme"> Mme</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>Pr&eacute;nom*</label>
                                </td>
                                <td colspan="2">
                                <input type="text" class="form-control" name="user_firstname" required="yes" placeholder="Pr&eacute;nom">
                                </td>
                            </tr>
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>Nom*</label>
                                </td>
                                <td colspan="2">
                                <input type="text" class="form-control" name="user_name" required="yes" placeholder="Nom">
                                </td>
                            </tr>
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>T&eacute;l&eacute;phone 1</label>
                                </td>
                                <td colspan="2">
                                <!--- <input type="text" class="form-control" name="user_phone" placeholder="T&eacute;l&eacute;phone"> --->
                                <input id="user_phone" class="form-control" type="tel" name="user_phone" />
                                <input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="bg-light" width="20%">
                                <label>ACCES COMPOSANTES</label>
                                <br><small>Plusieurs choix en appuyant sur CTRL</small>
                                </td>
                                <td colspan="2">
                                    <!--- <cfdump var="#get_account#"> --->
                                    <select <!--- onchange="document.location.href='cm_collaborator.cfm?a_id='+$(this).val()" ---> multiple="yes" class="form-control">
                                        <cfoutput query="get_account">
                                            <!--- <optgroup label="#group_name#">
                                            <cfoutput> --->
                                                <option <cfif a_id eq account_id>selected</cfif> value="#account_id#">
                                                #account_name#<!--- (#nb#)--->
                                                </option>
                                            <!--- </cfoutput>
                                             </optgroup> --->
                                        </cfoutput>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td class="bg-light" width="20%">
                                <label>ACCES SESSIONS</label>
                                <br><small>Plusieurs choix en appuyant sur CTRL</small>
                                </td>
                                <td colspan="2">
                                    <select name="token_session_id_select" id="token_session_id_select" multiple="yes" class="form-control">
                                        <!--- <option value="0">---Sélectionner---</option> --->
                                        <cfoutput query="get_certif_all">
                                        <option name="#token_session_name#" value="#token_session_id#">#account_name# || #token_session_name#</option>
                                        </cfoutput>
                                    </select>
                                </td>
                            </tr>              

                        </table>
                    
                        <div align="center">
                            <cfoutput>
                                <!--- <input type="hidden" id="token_list" name="token_list" value="#token_list#"> --->
                                <input type="hidden" name="account_id" id="account_id" value="#a_id#">
                                <input type="hidden" name="selected_session" id="selected_session" value="1">
                                <input type="submit" id="submit_new_collab" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
                            </cfoutput>
                        </div>
                    
                    </form>
                </div>

            </div>
        </br>
        </br>
        <div class="row">
            <div class="col-md-12">

                <div class="card">
                    <div class="card-body">
                        <cfif get_contact.recordcount neq "0">
                
                            <table class="table table-sm">
                                <tr class="bg-light">
                                    <th>STATUS</th>
                                    <th>NAME</th>
                                    <th>SESSION</th>
                                    <th>ACTION</th>
                                </tr>
                            
                                <cfoutput query="get_contact">
                                <tr>
                                    <td>
                                    <cfif user_status_id eq "4">
                                        <span class="badge badge-pill text-white bg-success">Actif</span>			
                                    <cfelse>
                                        <span class="badge badge-pill text-white  bg-dark">Inactif</span>			
                                    </cfif>
                                    </td>
                                    <td>
                                        #user_firstname# #uCase(user_name)#
                                    </td>
                                    <td>
                                    <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                                        <cfinvokeargument name="user_session_right_id" value="#user_session_right_id#">
                                    </cfinvoke>
                                    
                                    <cfloop query="get_session_access">
                                    <p>#token_session_name#</p>
                                    </cfloop>
                                    <!---</cfif>--->
                                    </td>
                                    <td>
                                        <a class="btn btn-sm btn-default btn_mail" href="##" id="edit_#user_id#"><i class="fas fa-envelope"></i></a>
                                    <!--- <a class="btn btn-sm btn-default btn_edit_ctc" href="##" id="edit_#user_id#"><i class="fas fa-edit"></i></a> --->
                                    <!---<a class="btn btn-sm btn-default btn_del_ctc" href="##" onclick="if(confirm('Souhaitez-vous effacer ce contact ?')){document.location.href='updater_crm.cfm?account_id=#account_id#&contact_id=#contact_id#&del_contact=1'}"><i class="far fa-trash-alt"></i></a>--->
                                    </td>
                                </tr>
                                </cfoutput>
                            </table>
                        
                        </cfif>
                    </div>

                </div>
                

            </div>
        </div>

	</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>


$( document ).ready(function() {
    var nb = 1;
    $('#submit_new_collab').click(function(){
		event.preventDefault();

		console.log($('#form_new_collab').serialize()); 
		$.ajax({
			url: './api/school/school_post.cfc?method=add_manager',
			type: 'POST',
			data : $('#form_new_collab').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				// window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

	})

    $('.btn_mail').click(function(){
		event.preventDefault();

        var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var _id = idtemp[1];

		console.log(_id); 
		$.ajax({
			url: './api/school/school_post.cfc?method=send_manager_login',
			type: 'POST',
			data : {u_id:_id},
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				// window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

	})

    $('#token_session_id_select').change(function(event){ 

        // event.preventDefault();

        // var value = $(this).val();
        // console.log($(this))
        // console.log($(this)[0].selectedOptions[0].text);
        // console.log($(this).val())

        // if ($(this).val() != 0)
        // {

        // var to_create = '<tr id="session_element_'+nb+'"><td class="bg-light" width="20%"><input type="hidden" name="new_session_'+nb+'" value="'+$(this).val()+'"></td>';

        // to_create += '<td width="70%">'+$(this)[0].selectedOptions[0].text+'</td><td width="10%" align="center">';
        // to_create += '<button type="button" class="btn btn-sm btn-outline-info btn_remove_session" id="del_session_'+nb+'"><i class="fal fa-trash-alt"></i></button>';
        // to_create += "</td></tr>";
        // $("#session_container").append(to_create);

        // $("#selected_session").val(nb);

        // $(".btn_remove_session").bind("click",handler_remove);

        // nb++;
        // }
    });


    // var handler_remove = function(event) {
    //         event.preventDefault();
    //         var idtemp = $(this).attr("id").split("_");
    //         $("#session_element_"+idtemp[2]).remove();

    //     };
    // $(".btn_remove_session").bind("click",handler_remove);



    <cfif isDefined("user_phone_code")>
        <cfif user_phone_code neq "">
            <cfquery name="get_default_code" datasource="#SESSION.BDDSOURCE#">
                SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_code#" LIMIT 1
            </cfquery>
        </cfif>
    </cfif>
    
    
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
    <cfif isDefined("user_phone")>phoneInput.setNumber("<cfoutput>#user_phone#</cfoutput>");</cfif>

    $('#user_phone').on('countrychange', function(e) {
        var countryData = phoneInput.getSelectedCountryData();
        // console.log(countryData);
        var codetmp = countryData.dialCode;
        
        if (countryData.areaCodes) {
            if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
        }

        $("#user_phone_code").val(codetmp);
    });
});
</script>

</body>
</html>