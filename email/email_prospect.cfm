<cfsilent>
<cfif isdefined("lang")>
<!---COMPLEX
<cfoutput>

	<cfset user_firstname = get_user.user_firstname>
	<cfset user_lastname = ucase(get_user.user_name)>
	<cfset arr = ['user_firstname', 'user_lastname']>
	<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
	
	<cfset email_title = #obj_translater.get_translate_complex('mail_new_test_title', lang)#>
	<cfset email_subtitle = #obj_translater.get_translate_complex('mail_new_test_subtitle', lang, argv)#>
	<cfset th_login = #obj_translater.get_translate('table_th_login', lang)#>
	<cfset th_url = #obj_translater.get_translate('table_th_url', lang)#>
	<cfset th_email = #obj_translater.get_translate('form_subscription_2', lang)#>
	<cfset th_temp_pwd = #obj_translater.get_translate('table_th_tmp_pwd', lang)#>
	<cfset th_prompt = #obj_translater.get_translate_complex('new_mail_prompt', lang)#>
	<cfset btn_connect = #obj_translater.get_translate('btn_connect', lang)#>
	
	<cfset th_steps = #obj_translater.get_translate_complex('mail_new_test_steps', lang)#>
	<cfset th_step_1 = #obj_translater.get_translate_complex('mail_new_test_step1', lang)#>
	<cfset th_step_2 = #obj_translater.get_translate_complex('mail_new_test_step2', lang)#>
	<cfset th_step_3 = #obj_translater.get_translate_complex('mail_new_test_step3', lang)#>
	<cfset th_step_4 = #obj_translater.get_translate_complex('mail_new_test_step4', lang)#>
</cfoutput>
START_RM--->


	<cfif lang eq "fr">
		<cfset email_title = "Bonjour #user_firstname# #ucase(user_lastname)#">
		<cfset email_subtitle = "Vous avez bénéficié d'un accès à notre plateforme e-Learning WEFIT,<br>nous espérons que vous avez apprécié cette expérience !">
		<cfset email_subtitle_2 = "Peut-être souhaitez-vous en savoir plus sur nous ?">
		<cfset email_subtitle_3 = "Si vous ne faites que passer par là...">
		<cfset email_subtitle_4 = "Nous vous souhaitons une bonne continuation dans vos projets. N'hésitez pas à nous laisser un commentaire sympa avec 5 étoiles ou un Like ;)">
	<cfelseif lang eq "en">
		<cfset email_title = "Bonjour #user_firstname# #ucase(user_lastname)#">
		<cfset email_subtitle = "Vous avez bénéficié d'un accès à notre plateforme e-Learning WEFIT,<br>nous espérons que vous avez apprécié cette expérience !">
		<cfset email_subtitle_2 = "Peut-être souhaitez-vous en savoir plus sur nous ?">
		<cfset email_subtitle_3 = "Si vous ne faites que passer par là...">
		<cfset email_subtitle_4 = "Nous vous souhaitons une bonne continuation dans vos projets. N'hésitez pas à nous laisser un commentaire sympa avec 5 étoiles ou un Like ;)">
	<cfelseif lang eq "de">
		<cfset email_title = "Bonjour #user_firstname# #ucase(user_lastname)#">
		<cfset email_subtitle = "Vous avez bénéficié d'un accès à notre plateforme e-Learning WEFIT,<br>nous espérons que vous avez apprécié cette expérience !">
		<cfset email_subtitle_2 = "Peut-être souhaitez-vous en savoir plus sur nous ?">
		<cfset email_subtitle_3 = "Si vous ne faites que passer par là...">
		<cfset email_subtitle_4 = "Nous vous souhaitons une bonne continuation dans vos projets. N'hésitez pas à nous laisser un commentaire sympa avec 5 étoiles ou un Like ;)">
	<cfelseif lang eq "es">
		<cfset email_title = "Bonjour #user_firstname# #ucase(user_lastname)#">
		<cfset email_subtitle = "Vous avez bénéficié d'un accès à notre plateforme e-Learning WEFIT,<br>nous espérons que vous avez apprécié cette expérience !">
		<cfset email_subtitle_2 = "Peut-être souhaitez-vous en savoir plus sur nous ?">
		<cfset email_subtitle_3 = "Si vous ne faites que passer par là...">
		<cfset email_subtitle_4 = "Nous vous souhaitons une bonne continuation dans vos projets. N'hésitez pas à nous laisser un commentaire sympa avec 5 étoiles ou un Like ;)">
	<cfelseif lang eq "it">
		<cfset email_title = "Bonjour #user_firstname# #ucase(user_lastname)#">
		<cfset email_subtitle = "Vous avez bénéficié d'un accès à notre plateforme e-Learning WEFIT,<br>nous espérons que vous avez apprécié cette expérience !">
		<cfset email_subtitle_2 = "Peut-être souhaitez-vous en savoir plus sur nous ?">
		<cfset email_subtitle_3 = "Si vous ne faites que passer par là...">
		<cfset email_subtitle_4 = "Nous vous souhaitons une bonne continuation dans vos projets. N'hésitez pas à nous laisser un commentaire sympa avec 5 étoiles ou un Like ;)">
	</cfif>	
<!---END_RM--->	
</cfif>
</cfsilent>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
	<cfinclude template="incl_email_meta.cfm">
</head>

<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: #FFF;">
    <center style="width: 100%; background-color: #FFF; text-align: left;">
	
	
	<cfinclude template="incl_email_header.cfm">
			
			<!-- 1 Column Text + Button : BEGIN -->
            <tr>
                <td style="background-color: #ffffff;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                                <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
								<br>
								<h2 style="margin: 0 0 10px; font-size: 18px; line-height: 125%; color: #87222F; font-weight: normal; text-align:center"><cfoutput>#email_subtitle_2#</cfoutput></h2>
								
								
								<!--- <p style="margin: 30px 0 10px;"> --->
									<!--- Pour toute proposition d'amélioration ou demande de renseignement, vous pouvez répondre à cet email ou nous contacter au 01 83 62 32 45 / 47 --->
								<!--- </p> --->
							</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
			
		
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
			
			
			<!-- 1 Column Text + Button : BEGIN -->
            <tr>
                <td style="background-color: #ffffff;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="padding:20px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                              
								<h2 style="margin: 0 0 10px; font-size: 18px; line-height: 125%; color: #87222F; font-weight: normal; text-align:center"><cfoutput>#email_subtitle_3#</cfoutput></h2>
								<div align="center"><img src="./assets/img/header_email_wefit4.jpg" width="100%"></div>
								 <p style="margin: 0 0 10px;" align="center">			
<cfoutput>#email_subtitle_4#</cfoutput>
								</p>
							</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
			
			<!-- 2 Even Columns : BEGIN -->
	        <tr>
	            <td align="center" valign="top" style="padding: 0px 20px 60px 20px; background-color: #ffffff;">
	                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
	                    <tr>
							<td width="48%" class="stack-column-center" valign="top" align="center">
								<img src="./assets/img/logo_email_gg_review.png" width="100%" style="margin-bottom:15px">
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #2BA9CD;">
										     <a class="button-a button-a-primary" target="_blank" href="https://g.page/r/CabjbXZ_BE1fEAg/review" style="background: #2BA9CD; border: 1px solid #2BA9CD; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">AVIS GOOGLE</span></a>
										</td>
                                    </tr>
                                </table>
	                        </td>
							<td width="4%"></td>
	                       <td width="48%" class="stack-column-center" valign="top" align="center">
							   <img src="./assets/img/logo_email_fb.png" width="100%" style="margin-bottom:15px">
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #2BA9CD;">
										     <a class="button-a button-a-primary" target="_blank" href="https://www.facebook.com/WEFITFRANCE" style="background: #2BA9CD; border: 1px solid #2BA9CD; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 8px 10px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff">LIKE FACEBOOK</span></a>
										</td>
                                    </tr>
                                </table>
	                        </td>					
	                    </tr>
	                </table>
					
	            </td>
	        </tr>
	        <!-- 2 Even Columns : END -->
			
			
		<cfinclude template="incl_email_footer.cfm">
		
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>