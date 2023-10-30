<cfinclude template="./incl_nav_beta.cfm">

<cfset u_id = 411>
<cfparam name="lang" default="fr">
<cfparam name="step" default="new_formation">

<cfif not isdefined("lang")>
    <cfset lang = "fr">
</cfif>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>

<cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tps">
    <cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>

<cfsilent>

<cfset user_firstname = get_user.user_firstname>
<cfset user_lastname = ucase(get_user.user_name)>
<cfset user_email = get_user.user_email>

<cfset arr = ['user_firstname', 'user_lastname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<cfif step eq "new_test">
    <cfset email_title = obj_translater.get_translate_complex(id_translate="mail_new_test_title",lg_translate="#lang#")>
    <cfset email_subtitle = obj_translater.get_translate_complex(id_translate="mail_new_test_subtitle",argv="#argv#",lg_translate="#lang#")>
    <cfset email_header_img = "header_email_launching_test.jpg">
    <cfset email_icon = "icon_launching.png">
<cfelseif step eq "new_guest">
    <cfset email_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_title",lg_translate="#lang#")>
    <cfset email_subtitle = obj_translater.get_translate_complex(id_translate="mail_new_formation_subtitle",argv="#argv#",lg_translate="#lang#")>
    <cfset email_header_img = "header_email_launching_guest.jpg">
    <cfset email_icon = "icon_launching.png">
<cfelseif step eq "new_formation">
    <cfset email_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_title",lg_translate="#lang#")>
    <cfset email_subtitle = obj_translater.get_translate_complex(id_translate="mail_new_formation_subtitle",argv="#argv#",lg_translate="#lang#")>
    <cfset email_header_img = "header_email_launching_regular.jpg">
    <cfset email_icon = "icon_launching.png">
<cfelseif step eq "new_group">
    <cfset email_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_title",lg_translate="#lang#")>
    <cfset email_subtitle = obj_translater.get_translate_complex(id_translate="mail_new_formation_subtitle",argv="#argv#",lg_translate="#lang#")>
    <cfset email_header_img = "header_email_launching_group.jpg">
    <cfset email_icon = "icon_launching.png">
</cfif>

<cfset th_login = obj_translater.get_translate(id_translate="table_th_login",lg_translate="#lang#")>
<cfset th_url = obj_translater.get_translate(id_translate="table_th_url",lg_translate="#lang#")>
<cfset th_email = obj_translater.get_translate(id_translate="form_subscription_2",lg_translate="#lang#")>
<cfset th_temp_pwd = obj_translater.get_translate(id_translate="table_th_tmp_pwd",lg_translate="#lang#")>
<cfset th_pwd = obj_translater.get_translate(id_translate="form_label_password",lg_translate="#lang#")>
<cfset th_pwd_explain = obj_translater.get_translate_complex(id_translate="mail_pwd_explain",lg_translate="#lang#")>
<cfset th_prompt = obj_translater.get_translate_complex(id_translate="new_mail_prompt",lg_translate="#lang#")>
<cfset btn_connect = obj_translater.get_translate(id_translate="btn_connect",lg_translate="#lang#")>
<cfset th_formation = obj_translater.get_translate(id_translate="sidemenu_learner_formation",lg_translate="#lang#")>
<cfset th_tp = obj_translater.get_translate(id_translate="table_th_program_short",lg_translate="#lang#")>

<cfset th_video = obj_translater.get_translate_complex(id_translate="mail_new_formation_video",lg_translate="#lang#")>
<!--- <cfset th_video_explain = obj_translater.get_translate_complex(id_translate="mail_new_formation_video_explain",lg_translate="#lang#")> --->
<cfset th_video_1_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_video1_title",lg_translate="#lang#")>
<cfset th_video_1_link = "https://www.wefitgroup.com/wefit/video-lancement-formation/">
<cfset th_video_2_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_video2_title",lg_translate="#lang#")>
<cfset th_video_2_link = "https://www.wefitgroup.com/wefit/video-presentation-fonctionnalites/">
<cfset th_video_3_title = obj_translater.get_translate_complex(id_translate="mail_new_formation_video3_title",lg_translate="#lang#")>
<cfset th_video_3_link = "https://www.wefitgroup.com/wefit/video-reservation-annulation-lancement-cours/">

<cfset th_steps = obj_translater.get_translate_complex(id_translate="mail_new_formation_steps",lg_translate="#lang#")>
<cfset th_step_1 = obj_translater.get_translate_complex(id_translate="mail_new_formation_step1",lg_translate="#lang#")>
<cfset th_step_lst = obj_translater.get_translate_complex(id_translate="mail_new_formation_step_lst",lg_translate="#lang#")>
<cfset th_step_pt = obj_translater.get_translate_complex(id_translate="mail_new_formation_step_pt",lg_translate="#lang#")>
<cfset th_step_pt_needs = obj_translater.get_translate_complex(id_translate="mail_new_formation_step_pt_needs",lg_translate="#lang#")>
<cfset th_step_needs = obj_translater.get_translate_complex(id_translate="mail_new_formation_step_needs",lg_translate="#lang#")>
<cfset th_step_explain = obj_translater.get_translate_complex(id_translate="mail_new_formation_step_explain",lg_translate="#lang#")>
</cfsilent>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
    <cfinclude template="incl_email_meta2.cfm">
</head>

<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: #FFF;">
    <center style="width: 100%; background-color: #FFF; text-align: left;">
    
    
    <cfinclude template="incl_email_header2.cfm">
            
            <tr>
                <td style="background-color: #ffffff; padding: 20px 30px 0px 30px;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="color:#252422; font-weight: 600; font-size:15px">
                                <h1><cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/#email_icon#" alt="WEFIT" border="0" align="center" style="max-width: 100%; height: 52px; margin-right:15px"></cfoutput><cfoutput>#email_title#</cfoutput></h1>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td width="26%" style="">
                                <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/unknown_female.png" width="50" title="Cindy" style="border-radius:50%; border: 2px solid ##8A2128 !important; margin-right:15px" align="right"></cfoutput>
                            </td>
                            <td width="74%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                <cfoutput>
                                <p>#email_subtitle#
                                <br>
                                <span style="color:##C7152C; font-weight:600">Cindy</span>
                                </p>
                                </cfoutput>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <!-- 1 Column Text + Button : BEGIN -->
            <tr>
                <td style="background-color: #ffffff;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
                                <h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
                                <p style="margin: 30px 0 10px;">
                                    <table width="100%" cellpadding="5" style="border:1px solid #ECECEC">
                                        <tr>
                                            <th bgcolor="#F3F3F3"><cfoutput>#th_login#</cfoutput></th>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="5" style="border-top:0px; border-left:1px solid #ECECEC; border-right:1px solid #ECECEC; border-bottom:1px solid #ECECEC;">
                                        <tr>
                                            <td width="35%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_url#</cfoutput></td>
                                            <td width="65%" style="background-color: #FFF; font-size: 13px;">
                                            <a href="https://lms.wefitgroup.com">lms.wefitgroup.com</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_email#</cfoutput></td>
                                            <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_email)#</cfoutput></td>
                                        </tr>
                                        <cfif isdefined("send_reset")>
                                        <tr>
                                            <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_temp_pwd#</cfoutput></td>
                                            <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_pwd)#</cfoutput></td>
                                        </tr>
                                        <cfelse>
                                        <tr>
                                            <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_pwd#</cfoutput></td>
                                            <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#th_pwd_explain#</cfoutput></td>
                                        </tr>
                                        </cfif>
                                    </table>
                                    <cfif isdefined("send_reset")>
                                    <p style="font-size:12px"><em><cfoutput>#th_prompt#</cfoutput></em></small></p>
                                    </cfif>
                                </p>
                                
                                <p style="margin: 30px 0 10px; color: #252422;">
                                <table width="100%" cellpadding="5" style="border:1px solid #ECECEC; color: #252422;">
                                    <tr>
                                        <th bgcolor="#F3F3F3"><cfoutput>#th_tp#</cfoutput></th>
                                    </tr>
                                </table>
                                <table width="100%" cellpadding="5" style="border-top:0px; border-left:1px solid #ECECEC; border-right:1px solid #ECECEC; border-bottom:1px solid #ECECEC; color: #252422;">
                                    <cfoutput query="get_tps">
                                        <cfif method_id eq "3">
                                            <cfset access_el = "1">
                                        <cfelseif method_id eq "2">
                                            <cfset access_f2f = "1">
                                        <cfelseif method_id eq "1">
                                            <cfset access_visio = "1">
                                        </cfif>
                                        <tr>
                                            <td width="35%" style="font-size: 13px;">
                                            #obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#",lg_translate="#lang#")#
                                            </td>
                                            <td width="65%" style="font-size: 13px;">
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
                                            #obj_translater.get_translate_complex(id_translate="order_end_reminder", argv="#argv#",lg_translate="#lang#")#
                                            </td>
                                        </tr>
                                    </cfoutput>
                                </table>
                                </p>
                                <cfif step eq "new_formation">
                                <cfif lang eq "fr" AND isdefined("access_visio")>
                                
                                <h4 style="margin: 30px 0px 20px 0px; font-size: 20px; line-height: 125%; color: #851F2D; font-weight: normal; text-align:center"><cfoutput>#th_video#</cfoutput></h4>
                                <!--- <p style="font-size:12px; margin:5px 0px 0px 0px; color: #252422" align="center"><em><cfoutput>#th_video_explain#</cfoutput></em></p> --->
                                
    
                                <table width="100%" cellpadding="5" style="text-align:left; color: #252422">
                                    <tr>
                                        <td align="center" width="33%" valign="top"><a style="font-size: 11px; line-height: 125%; color: #333333; font-weight: normal; text-align:center" href="<cfoutput>#th_video_1_link#</cfoutput>"><img src="./assets/img/visu_1.jpg" width="150" align="center"></a><br><cfoutput>#th_video_1_title#</cfoutput></td>
                                        <td align="center" width="33%" valign="top"><a style="font-size: 11px; line-height: 125%; color: #333333; font-weight: normal; text-align:center" href="<cfoutput>#th_video_2_link#</cfoutput>"><img src="./assets/img/visu_2.jpg" width="150" align="center"></a><br><cfoutput>#th_video_2_title#</cfoutput></td>
                                        <td align="center" width="33%" valign="top"><a style="font-size: 11px; line-height: 125%; color: #333333; font-weight: normal; text-align:center" href="<cfoutput>#th_video_3_link#</cfoutput>"><img src="./assets/img/visu_3.jpg" width="150" align="center"></a><br><cfoutput>#th_video_3_title#</cfoutput></td>
                                    </tr>
                                </table>
                                
                                </cfif>
                                </cfif>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                <!-- Button : BEGIN -->
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">
                                                <a class="button-a button-a-primary" href="https://lms.wefitgroup.com" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_connect#</cfoutput></span></a>
                                        </td>
                                    </tr>
                                </table>
                                <!-- Button : END -->
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->

            <cfif step eq "new_guest">
                <!-- 2 Even Columns : BEGIN -->
                <tr>
                    <td align="center" valign="top" style="padding: 0px 20px 20px 20px; background-color: #ffffff;">
                        <table role="presentation" cellspacing="10" cellpadding="0" border="0" width="100%">
                            <tr>
                            
                                
                                <td width="48%" class="stack-column-center" valign="top" style="border:2px solid #CE1D37; padding:10px" align="center">
                                    <h6 style="color:#CE1D37 !important; margin: 0 0 10px; font-size: 14px; line-height: 125%;">POUR TOUS</h6>
                                    <img src="./assets/img/logo_email_wefit_adapt.png" width="100%">	
                                    <p style="margin: 20px 0px;">
    WEFIT propose des formations linguistiques personnalisées & certifiantes en VISIO et/ou ELEARNING
                                    </p>
                                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                        <tr>
                                            <td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">
                                                <a class="button-a button-a-primary" target="_blank" href="https://www.wefitgroup.com/formation-linguistique/visioconference-anglais/" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">EN SAVOIR PLUS</span></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4%"></td>							
                                <td width="48%" class="stack-column-center" valign="top" style="border:2px solid #FAB526; padding:10px" align="center">
                                    <h6 style="color:#FAB526 !important; margin: 0 0 10px; font-size: 14px; line-height: 125%;">POUR TOUS</h6>
                                    <img src="./assets/img/logo_email_certifications.png" width="100%">
                                    <p style="margin: 20px 0px;">							
    Si vous êtes intéressé(e) par le passage d'une certification en ligne (LINGUASKILL, TOEIC, BRIGHT...)
                                    </p>
                                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                        <tr>
                                            <td class="button-td button-td-primary" style="border-radius: 4px; background: #FAB526;">
                                                <a class="button-a button-a-primary" target="_blank" href="https://formation.wefitgroup.com/certifications-langue" style="background: #FAB526; border: 1px solid #FAB526; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">WEFIT SHOP</span></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!-- 2 Even Columns : END -->
                
                <!-- 2 Even Columns : BEGIN -->
                <tr>
                    <td align="center" valign="top" style="padding: 0px 20px 40px 20px; background-color: #ffffff;">
                        <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td width="48%" class="stack-column-center" valign="top" style="border:2px solid #2A379A; padding:10px" align="center">
                                    <h6 style="color:#2A379A !important; margin: 0 0 10px; font-size: 14px; line-height: 125%;">VOUS AVEZ DES DROITS CPF</h6>
                                    <img src="./assets/img/logo_email_cpf.png" width="100%">
                                    <p style="margin: 20px 0px;">
    Toutes nos formations sont éligibles et disponibles dans l'application Mon Compte Formation.<br>Consultez notre catalogue pour en savoir plus.
                                    </p>
                                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                        <tr>
                                            <td class="button-td button-td-primary" style="border-radius: 4px; background: #2A379A;">
                                                <a class="button-a button-a-primary" target="_blank" href="https://cpf.wefitgroup.com/catalogue-formation-langue" style="background: #2A379A; border: 1px solid #2A379A; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">CATALOGUE CPF</span></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4%"></td>
                                <td width="48%" class="stack-column-center" valign="top" style="border:2px solid #6BD098; padding:10px" align="center">
                                <h6 style="color:#6BD098 !important; margin: 0 0 10px; font-size: 14px; line-height: 125%;">DEMANDEURS D'EMPLOI</h6>
                                <img src="./assets/img/logo_email_pe.png" width="100%">
                                <p style="margin: 20px 0px;">
    Vous avez la possibilité de solliciter une Aide Individuelle à la Formation (AIF) pour la prise en charge intégrale de votre formation, ou un abondement sur vos droits CPF.
                                    </p>
                                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                        <tr>
                                            <td class="button-td button-td-primary" style="border-radius: 4px; background: #6BD098;">
                                                <a class="button-a button-a-primary" target="_blank" href="https://cpf.wefitgroup.com/compte-formation-pole-emploi" style="background: #6BD098; border: 1px solid #6BD098; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">CONTACTEZ-NOUS</span></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>					
                            </tr>
                        </table>
                        
                    </td>
                </tr>
                <!-- 2 Even Columns : END -->

            </cfif>
            
        
        <cfinclude template="incl_email_footer2.cfm">
        
    </center>
</body>
</html>