
<cfsilent>

<!--- <cfset ins_learner = 1> --->
<cfparam name="up_learner" default="0">
<cfparam name="ins_learner" default="#up_learner#">

<cfset ins_tp = 0>

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

<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
    SELECT tc.tpmastercor_id, tc.sessionmaster_id, tc.sessionmaster_rank, tc.sessionmaster_schedule_duration, tc.tpmaster_id,
	tc.tpmastercor_name_#SESSION.LANG_CODE# as tpmastercor_name, tc.tpmastercor_desc_#SESSION.LANG_CODE# as tpmastercor_desc,
    tp.tpmaster_id, tp.tpmaster_level, tp.tpmaster_hour, tp.tpmaster_img, tp.tpmaster_lesson_duration,
    sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.module_id, sm.keyword_id, sm.sessionmaster_cat_id,

    (CASE WHEN tp.tpmaster_name_#SESSION.LANG_CODE# <> "" THEN tp.tpmaster_name_#SESSION.LANG_CODE# ELSE tp.tpmaster_name END) AS tpmaster_name, 
    
    (CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sm.sessionmaster_name END) AS sessionmaster_name, 
    (CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# <> "" THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sm.sessionmaster_description END) AS sessionmaster_description 

    FROM lms_tpmaster2 tp
    INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
    
    WHERE formation_id = 2
    AND tp.tpmaster_type = 6
    AND sm.sessionmaster_online_visio = 1
    

    GROUP BY tc.tpmaster_id, tc.sessionmaster_rank, tc.sessionmaster_id
    ORDER BY tc.tpmaster_id, tc.sessionmaster_rank, sm.sessionmaster_name
</cfquery>	

<cfif isdefined("u_id")>
    
    <!--- <cfset ins_learner = 0> --->
    <cfset ins_tp = 1>

    <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
        <cfinvokeargument name="u_id" value="#u_id#">
    </cfinvoke>
    
    <cfoutput query="get_user">
        <cfset user_lastname = user_name>
        <cfset user_email = user_email>
        <cfset user_firstname = user_firstname>
        <cfset user_gender = user_gender>
        <cfset user_phone = user_phone>
        <cfset user_phone_code = user_phone_code>
        <cfset user_lang = user_lang>
        <cfset user_pt_mandatory = account_pt_mandatory>
    </cfoutput>

<cfelse>

    <cfset user_lastname = "">
    <cfset user_email = "">
    <cfset user_firstname = "">
    <cfset user_gender = "M.">
    <cfset user_phone = "">
    <cfset user_phone_code = "">
    <cfset user_lang = "">
    <cfset user_pt_mandatory = "0">

</cfif>

</cfsilent>

<form id="form_launch">
    
    <table class="table table-sm">
        <cfoutput>
        <tr id="user_form">
            <td colspan="3" bgcolor="##ECECEC"><strong>#obj_translater.get_translate('table_th_details')#</strong></td>
        </tr>
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('table_th_genre')#*</label>
            </td>
            <td colspan="2">
                <label><input name="user_gender" type="radio" value="M." <cfif user_gender eq "M.">checked</cfif>>#obj_translater.get_translate('shop_mr')#</label>&nbsp;&nbsp;&nbsp;
                <label><input name="user_gender" type="radio" value="Mme" <cfif user_gender eq "Mme">checked</cfif>>#obj_translater.get_translate('shop_ms')#</label>
            </td>
        </tr>
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('form_label_firstname')#*</label>
            </td>
            <td colspan="2">
            <input type="text" class="form-control" name="user_firstname" required="yes" placeholder="#obj_translater.get_translate('form_label_firstname')#" value="#user_firstname#" >
            </td>
        </tr>
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('form_label_name')#*</label>
            </td>
            <td colspan="2">
            <input type="text" class="form-control" name="user_lastname" required="yes" placeholder="#obj_translater.get_translate('form_label_name')#" value="#user_lastname#">
            </td>
        </tr>
        
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('table_th_account')#*</label>
            </td>
            <td colspan="2">
                <select name="account_id" id="account_id" class="form-control">
                <cfloop query="get_account">
                <option value="#get_account.account_id#">#get_account.account_name#</option>
                </cfloop>
                </select>
            </td>
        </tr>
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('form_subscription_4')# 1</label>
            </td>
            <td colspan="2">
            <!--- <input type="text" class="form-control" name="user_phone" placeholder="T&eacute;l&eacute;phone"> --->
            <input id="user_phone" type="tel" name="user_phone" />
            <input id="user_phone_code" type="hidden" name="user_phone_code" value="#get_country_phone.phone_code#" />
            </td>
        </tr>
        <tr class="user_row">
            <td colspan="3" bgcolor="##ECECEC"><strong>#obj_translater.get_translate('table_th_login')#</strong></td>
        </tr>
        <tr class="user_row">
            <td class="bg-light" width="30%">
            <label>#obj_translater.get_translate('form_label_email')#*</label>
            </td>
            <td colspan="2">
            <input type="text" class="form-control" name="user_email" <cfif isdefined("u_id")>disabled<cfelse>required="yes"</cfif> placeholder="#obj_translater.get_translate('form_label_email')#" value="<cfoutput>#user_email#</cfoutput>">
            </td>
        </tr>

        <tr class="user_row">
            <td class="bg-light" width="20%"><label>#obj_translater.get_translate('table_th_lms_language')#*</label></td>
            <td colspan="2">
                <select name="user_lang" class="form-control">
                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
                    <option value="#cor#" <cfif cor eq "fr">selected</cfif>>#ucase(cor)#</option>
                </cfloop>
                </select>
            </td>
        </tr>
        </cfoutput>

        <cfif up_learner eq 0>

        <cfoutput>
        <tr>
            <td>#obj_translater.get_translate_complex('launch_formation_agreement_tm')#</td>
        </tr>
            
        <tr id="tp_form" bgcolor="##ECECEC">
            <td colspan="2">
                <input type="checkbox" name="show_ins_tp" id="show_ins_tp" value="1" <cfif ins_tp eq "1">checked</cfif>>
                <strong>#obj_translater.get_translate('deployment_tm')#</strong>
            </td>
        </tr>

        <tr class="tp_row">
            <td class="bg-light" width="20%"><label>#obj_translater.get_translate('table_th_language')#*</label></td>
            <td colspan="2">
                <select name="formation_id" class="form-control">
                <!--- <cfoutput>
                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
                    <option value="#cor#" <cfif cor eq "fr">selected</cfif>>#ucase(cor)#</option>
                </cfloop>
                </cfoutput> --->
                <option value="2" selected>EN</option>
                <option value="1">FR</option>
                </select>
            </td>
        </tr>
        </cfoutput>

        <tr class="tp_row">
            <td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('formation_tm')#</cfoutput>*</label></td>
            <td colspan="2">
                <cfoutput query="get_module" group="tpmaster_id">
                    <label>
                        <input type="radio" name="tpmaster_id" value="#tpmaster_id#" <cfif currentrow eq 1>checked</cfif>> #tpmaster_name# - SESSION #tpmaster_lesson_duration#min  
                    </label>
                    <br>
                </cfoutput>

                <label>
                    <input type="radio" name="tpmaster_id" value="0"> Quizz Only 
                </label>
                
                <!--- <label>
                    <input type="radio" name="user_formula" value="es"> <img src="./assets/img_formation/4.png" width="30"> ESPAGNOL - VISIO 10h - SESSION 30min
                </label> --->
            </td>
        </tr>


        <tr class="tp_row">
            <td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('mandatory_pt_tm')#</cfoutput>*</label></td>

            <td colspan="2">
                <input type="checkbox" name="user_pt_mandatory" value="1" <cfif user_pt_mandatory eq "1">checked</cfif>>
            </td>
        </tr>

        <tr class="tp_row">
            <td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('level')#</cfoutput>*</label></td>
            <td colspan="2">
                <select name="level_alias" class="form-control">
                <cfoutput  query="get_level">
                    <option value="#level_alias#" <cfif level_id eq 2>selected</cfif>>#level_alias#</option>
                </cfoutput>
                </select>
            </td>
        </tr>

        <!--- ALWAY HIDDEN BUT STAY IN THE PAGE FOR FORM --->
        <!--- <tr class="tp_row"> --->
        <tr hidden>
            <td class="bg-light" width="25%"><label>Date de lancement </label>*</td>
            <td>
                <small class="text-muted"><em><span style="color:#FF0000">(L'apprenant reçoit son email et peut accéder à l'interface)</span></small>
                
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

        <!--- <tr class="tp_row"> --->
        <tr hidden>
            <td class="bg-light" width="20%"><label><cfoutput>Entre le</cfoutput>*</label></td>
            <td colspan="2">
                <small class="text-muted"><em><span style="color:#FF0000">(L'apprenant ne peut pas réserver avant cette date)</span></small>
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

        <!--- <tr class="tp_row"> --->
        <tr hidden>
            <td class="bg-light" width="25%"><label>Et le</label>*</td>
            <td>
                <small class="text-muted"><em><span style="color:#FF0000">(L'apprenant ne peut pas réserver après cette date)</span></small>
                
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
        </cfif>

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
            <input type="hidden" name="ins_learner" value="<cfoutput>#ins_learner#</cfoutput>">
            <input type="hidden" id="ins_tp" name="ins_tp" value="<cfoutput>#ins_tp#</cfoutput>">
            <br> <input type="submit" class="btn btn-outline-red" value="Déployer apprenant">
    </div>
</form>
        
<script>
$(document).ready(function() {

    var show_user = <cfoutput>#ins_learner#</cfoutput>;
    var show_tp = <cfoutput>#ins_tp#</cfoutput>;

    <cfif ins_learner neq 1>
        $('tr.user_row').hide();
    </cfif>
    <cfif ins_tp neq 1>
        $('tr.tp_row').hide();
    </cfif>

    
    $('#tp_form').click(function() {


        if (show_tp) {
            $('tr.tp_row').hide();
            show_tp = 0;
            $('#show_ins_tp').prop( "checked", false );
        } else {
            $('tr.tp_row').show();
            show_tp = 1;
            $('#show_ins_tp').prop( "checked", true );
        }

        $('#ins_tp').val(show_tp);
    });

    $('#user_form').click(function() {

        if (show_user) {
            $('tr.user_row').hide();
            show_user = 0;
        } else {
            $('tr.user_row').show();
            show_user = 1;
        }

        // $('#ins_learner').val(show_user);
    });

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

    if(confirm("<cfoutput>#obj_translater.get_translate('register_confirm_tm')#</cfoutput>")){
        $.ajax({				 
            url: 'api/users/user_post.cfc?method=insert_user_tm',
            type: "POST",
            data: $(this).serialize(),
            datatype : "html",
            success : function(result, statut){
                console.log(result);
                window.location.reload(true);
                // window.location.href=("partner_index.cfm?k=1")
            },
            error : function(result, statut, error){
            }
        });

    }
   
})


})
</script>
