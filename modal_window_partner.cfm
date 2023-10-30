<cfif isdefined("create_user") OR isdefined("updt_user")>
    
    <cfsilent>

    <cfset get_account = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

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

    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name 
    FROM lms_level WHERE level_id <> 0
    </cfquery>

    <cfif isdefined("u_id")>

        <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
            <cfinvokeargument name="u_id" value="#u_id#">
        </cfinvoke>
        
        <cfoutput query="get_user">
            <cfset user_lastname = user_lastname>
            <cfset user_email = user_email>
            <cfset user_firstname = user_firstname>
            <cfset user_gender = user_gender>
            <cfset user_phone = user_phone>
            <cfset user_phone_code = user_phone_code>
            <cfset user_lang = user_lang>
        </cfoutput>

    <cfelse>

        <cfset user_lastname = "">
        <cfset user_email = "">
        <cfset user_firstname = "">
        <cfset user_gender = "M.">
        <cfset user_phone = "">
        <cfset user_phone_code = "">
        <cfset user_lang = "">
        

    </cfif>

</cfsilent>
	
    <form id="form_launch">
        
        <table class="table table-sm">
            
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
                    <select name="account_id" id="account_id" class="form-control">
                    <cfoutput query="get_account">
                    <option value="#account_id#">#account_name#</option>
                    </cfoutput>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="bg-light" width="30%">
                <label>T&eacute;l&eacute;phone 1</label>
                </td>
                <td colspan="2">
                <!--- <input type="text" class="form-control" name="user_phone" placeholder="T&eacute;l&eacute;phone"> --->
                <input id="user_phone" type="tel" name="user_phone" />
                <input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
                </td>
            </tr>
            <tr>
                <td colspan="3" bgcolor="#ECECEC"><strong>Identifiants de connexion</strong></td>
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
                <td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_lms_language')#</cfoutput>*</label></td>
                <td colspan="2">
                    <select name="user_lang" class="form-control">
                    <cfoutput>
                    <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
                        <option value="#cor#" <cfif cor eq "fr">selected</cfif>>#ucase(cor)#</option>
                    </cfloop>
                    </cfoutput>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan="3" bgcolor="#ECECEC"><strong>Déploiement Formation</strong></td>
            </tr>

            <tr>
                <td class="bg-light" width="20%"><label><cfoutput>Formule</cfoutput>*</label></td>
                <td colspan="2">
                    <label>
                        <input type="radio" name="user_formula" value="en" checked> <img src="./assets/img_formation/2.png" width="30"> ANGLAIS - VISIO 10h - SESSION 30min  
                    </label>
                    <br>
                    <label>
                        <input type="radio" name="user_formula" value="es"> <img src="./assets/img_formation/4.png" width="30"> ESPAGNOL - VISIO 10h - SESSION 30min
                    </label>
                </td>
            </tr>

            <tr>
                <td class="bg-light" width="20%"><label><cfoutput>Niveau</cfoutput>*</label></td>
                <td colspan="2">
                    <select name="level_alias" class="form-control">
                    <cfoutput  query="get_level">
                        <option value="#level_alias#" <cfif level_id eq 2>selected</cfif>>#level_alias#</option>
                    </cfoutput>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="bg-light" width="25%"><label>Date de lancement </label>*</td>
                <td>
                    <small class="text-muted"><em><span style="color:###FF0000">(L'apprenant reçoit son email et peut accéder à l'interface)</span></small>
                    
                    <div class="controls">
                        <div class="input-group">
                            <cfoutput>
                            <input id="tp_date_send" name="tp_date_send" type="text" class="datepicker form-control" value="#dateformat(now(),'dd/mm/yyyy')#" />
                            <label for="tp_date_send" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                            </cfoutput>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="bg-light" width="20%"><label><cfoutput>Entre le</cfoutput>*</label></td>
                <td colspan="2">
                    <small class="text-muted"><em><span style="color:###FF0000">(L'apprenant ne peut pas réserver avant cette date)</span></small>
                    <div class="controls">
                        <div class="input-group">
                            <cfoutput>
                            <input id="tp_date_start" name="tp_date_start" type="text" class="datepicker form-control" value="#dateformat(now(),'dd/mm/yyyy')#" />
                            <label for="tp_date_start" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                            </cfoutput>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="bg-light" width="25%"><label>Et le</label>*</td>
                <td>
                    <small class="text-muted"><em><span style="color:###FF0000">(L'apprenant ne peut pas réserver après cette date)</span></small>
                    
                    <div class="controls">
                        <div class="input-group">
                            <cfoutput>
                            <input id="tp_date_end" name="tp_date_end" type="text" class="datepicker form-control" value="#dateformat(dateadd("m",6,now()),'dd/mm/yyyy')#" />
                            <label for="tp_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                            </cfoutput>
                        </div>
                    </div>
                </td>
            </tr>

            <!--- <tr>
                <td class="bg-light" width="20%"><label><cfoutput>Coach Brief</cfoutput>*</label></td>
                <td colspan="2">
                    <textarea class="form-control">


                    </textarea>
                </td>
            </tr> --->

        </table>
       
         <div align="center">
            <!--- <small class="text-muted"><em><span style="color:#FF0000">(Le mail de lancement est généré en validant ce formulaire)</span></small> --->
                <input type="hidden" name="ins_learner" value="1">
                <br> <input type="submit" class="btn btn-outline-red" value="Déployer apprenant">
        </div>
    </form>
	
			
<script>
$(document).ready(function() {

    $('#user_create').submit(function(event) {
        if($('#account_id').val() == "0")
        {
            alert("Selectionnez un compte SVP.");
            return false;
        };
    });		


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
            // for (let index = 0; index < countryData.areaCodes.length; index++) {
            // 	const element = countryData.areaCodes[index];
            // 	codetmp += "-" + element;
            // }
            if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
            
        }

        $("#user_phone_code").val(codetmp);
    });

    $("#tp_date_start").datepicker({
        changeMonth: true,
        dateFormat:"dd/mm/yy",
        numberOfMonths: 1,
        onClose: function( selectedDate ) {
            /*$( "#tp_date_end" ).datepicker( "option", "minDate", selectedDate );	*/

            var datego = moment(selectedDate, "DD-MM-YYYY").add(1,'years');
            datego = datego.format("DD/MM/YYYY");

            $( "#tp_date_end" ).datepicker("setDate", datego );

            
        }
    });

    $("#tp_date_end").datepicker({
        changeMonth: true,
        dateFormat:"dd/mm/yy",
        numberOfMonths: 1,
        /*onClose: function( selectedDate ) {
            $( "#tp_date_start" ).datepicker( "option", "maxDate", selectedDate );
        }*/
    });
    
    $("#tp_date_send").datepicker({
        changeMonth: true,
        dateFormat:"dd/mm/yy",
        numberOfMonths: 1,
        /*onClose: function( selectedDate ) {
            $( "#tp_date_start" ).datepicker( "option", "maxDate", selectedDate );
        }*/
    });


    $("#form_launch").submit(function( event ) {

        event.preventDefault();

        $.ajax({				 
            url: 'api/launching/launching_post.cfc?method=insert_user',
            type: "POST",
            data: $(this).serialize(),
            datatype : "html",
            success : function(result, statut){
                window.location.href=("partner_index.cfm?k=1")
            },
            error : function(result, statut, error){
            }
        });

    })


})
</script>
	



<cfelseif isdefined("view") AND view eq "choose_trainer_partner">



    <div class="alert bg-light text-dark border" role="alert">
            
        <div class="d-flex justify-content-center mb-4">
            <img class="mr-3" src="./assets/img/method_test.jpg" width="200">
            <img class="mr-3" src="./assets/img/logo_gymglish.jpg" width="200">
        </div>

        <!------- SCAN ALREADY ATTACHED Ts ------>
        <cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#SESSION.TP_ID#")>
        <cfset get_tp = obj_tp_get.oget_tp(t_id="#SESSION.TP_ID#")>
<!--- <cfdump var="#get_trainer#"> --->

        <cfset planner_firstname = get_trainer.planner>
        <cfset tp_date_begin = obj_dater.get_dateformat(get_tp.tp_date_start)>
        <cfset tp_date_end = obj_dater.get_dateformat(get_tp.tp_date_end)>
        <cfset arr = ['planner_firstname', 'tp_date_begin', 'tp_date_end']>
            <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
            <cfoutput>#obj_translater.get_translate_complex(id_translate="alert_launch_text_partner", argv="#argv#")#</cfoutput>

			<!--- <p>
				<cfoutput></cfoutput>
			</p>
            <h5 class="mt-0" align="center"><cfoutput>On continue ?</cfoutput></h5>
            
            <br>
            Vous avez choisi <strong>$$planner_firstname$$</strong>. Pour rappel, votre parcours VISIO débute le <strong>$$tp_date_begin$$</strong> et termine le <strong>$$tp_date_end$$</strong>. Vous ne pourrez donc réserver des cours que sur cette période.
            <br><br>
            Vous pouvez annuler votre cours jusqu'à 6h avant le début et le replanifier. Passé ce délai, ce cours sera considéré comme manqué.
            <br><br>
            Il est maintenant temps de réserver vos <strong>cours de 30 minutes</strong>. Parcourez les disponibilités de votre formateur/trice et cliquez simplement sur le créneau que vous souhaitez réserver. N'hésitez pas à utiliser le filtre des jours pour aller plus vite ! Enfin, vous devez réserver un minimum de 5 cours pour pouvoir poursuivre. --->
        </div>
    </div>

    <div align="center">
        <button class="btn btn-red" data-dismiss="modal">JE RéSERVE</button>
    </div>


    
<cfelseif isdefined("view") AND view eq "welcome_partner">

    <cfset get_tp = obj_tp_get.oget_tp(t_id="#SESSION.TP_ID#")>
    <cfset f_code = lcase(get_tp.formation_code)>

    <form id="form_launch">

    <div class="alert bg-light text-dark border" role="alert">
        <div class="d-flex justify-content-center mb-4">
            <img class="mr-3" src="./assets/img/lst_extrovert.jpg" width="200">
            <img class="mr-3" src="./assets/img/logo_gymglish.jpg" width="200">
        </div>

            <h5 class="mt-0" align="center"><cfoutput>#obj_translater.get_translate_complex('alert_launch_title_before_start')#</cfoutput></h5>
            Bonjour <cfoutput>#SESSION.USER_FIRSTNAME# #SESSION.USER_LASTNAME#</cfoutput>,
            <br><br>
            Vous allez suivre un <strong>parcours de 10 heures</strong> en VISIO avec WEFIT, partenaire privilégié de GYMGLISH. Les étapes de lancement sont simples, vous choisissez votre formateur et accédez au calendrier de réservation, sur lequel vous pourrez planifier vos <strong>cours de 30 minutes</strong>.
            <br><br>
            Veuillez nous indiquer votre niveau afin que nous puissions vous proposer les contenus et les formateurs les plus adapatés :
            <br><br>

            <cfoutput>
            <select class="form-control" name="user_level" id="user_level">
                <option value="0">---#obj_translater.get_translate('btn_choose_level')#---</option>
                <option value="A0" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "A0">selected</cfif>>#obj_translater.get_translate('level_a0')#</option>
                <option value="A1" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "A1">selected</cfif>>#obj_translater.get_translate('level_a1')#</option>
                <option value="A2" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "A2">selected</cfif>>#obj_translater.get_translate('level_a2')#</option>
                <option value="B1" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "B1">selected</cfif>>#obj_translater.get_translate('level_b1')#</option>
                <option value="B2" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "B2">selected</cfif>>#obj_translater.get_translate('level_b2')#</option>
                <option value="C1" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "C1">selected</cfif>>#obj_translater.get_translate('level_c1')#</option>
                <!--- <option value="C2" <cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#") AND evaluate("SESSION.USER_QPT_#ucase(f_code)#") eq "C2">selected</cfif>>#obj_translater.get_translate('level_c2')#</option> --->
            </select>
            </cfoutput>
        </div>
    </div>

    <div align="center">
        <input type="hidden" name="f_code" value="<cfoutput>#f_code#</cfoutput>">
        <button class="btn btn-red" type="submit">C'EST PARTI !</button>
    </div>

    </form>

    <script>
        $(document).ready(function() {
               
        
            $("#form_launch").submit(function( event ) {
        
                event.preventDefault();
        
                $.ajax({				 
                    url: 'api/launching/launching_post.cfc?method=update_level',
                    type: "POST",
                    data: $(this).serialize(),
                    datatype : "html",
                    success : function(result, statut){
                        window.location.href=("learner_launch_partner.cfm?notrigger=1")
                    },
                    error : function(result, statut, error){
                    }
                });
        
            })
        
        
        })
        </script>

</cfif>