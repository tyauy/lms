<cfsilent>
<cfif isdefined("lang")>

<!---COMPLEX
<cfoutput>

	<cfset certif_name = #get_token.certif_name#>
	<cfset arr = ['certif_name']>
	<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

	<cfset email_title = #obj_translater.get_translate_complex('mail_token_title1', lang)#>
	<cfset email_subtitle = #obj_translater.get_translate_complex('mail_token_subtitle1', lang, argv)#>
	
	<cfset email_title2 = #obj_translater.get_translate_complex('mail_token_title2', lang)#>
	<cfset email_subtitle2 = #obj_translater.get_translate_complex('mail_token_subtitle2', lang)#>
	
	<cfset email_title3 = #obj_translater.get_translate_complex('mail_token_title3', lang)#>
	<cfset email_subtitle3 = #obj_translater.get_translate_complex('mail_token_subtitle3', lang)#>
	
	
	<cfset th_certif = #obj_translater.get_translate('table_th_certif_login', lang)#>
	<cfset th_token = "ENTRY CODE">
	<cfset th_institution_id = "INSTITUTION_ID">
	<cfset th_candidate_id = "CANDIDATE_ID">
	
	<cfset th_login = #obj_translater.get_translate('table_th_el_login', lang)#>
	<cfset th_url = #obj_translater.get_translate('table_th_url', lang)#>
	<cfset th_email = #obj_translater.get_translate('form_subscription_2', lang)#>
	<cfset th_temp_pwd = #obj_translater.get_translate('table_th_tmp_pwd', lang)#>
	<cfset th_pwd_known = #obj_translater.get_translate_complex('mail_pwd_explain', lang)#>
	
	
	<cfset th_prompt = #obj_translater.get_translate_complex('new_mail_prompt', lang)#>
	<cfset btn_connect = #obj_translater.get_translate('btn_connect', lang)#>
	<cfset th_formation = #obj_translater.get_translate('sidemenu_learner_formation', lang)#>
	<cfset th_tp = #obj_translater.get_translate('table_th_program_short', lang)#>
</cfoutput>
START_RM--->

	<cfif lang eq "fr">
		<cfif isdefined("display_warning")>
			<cfset email_title = "Passage de votre certification">
			<cfset email_subtitle = display_warning>
		<cfelse>
			<cfset email_title = "Passage de votre certification">
			<cfset email_subtitle = "Vous allez passer la certification <br> <strong>#get_token.certif_name#</strong> <br>Les codes suivants seront nécessaires au passage de votre certification :">
		</cfif>
		<cfset email_title2 = "Déroulement de la certification">
		<cfset email_subtitle2 = "Veuillez suivre attentivement les étapes ci-dessous :">
		
		<cfset email_title3 = "Votre compte eLearning">
		<cfset email_subtitle3 = "Si vous souhaitez accéder à la plateforme e-Learning et vous entraîner, veuillez utiliser les identifiants suivants :">
		
		<cfset email_title4 = "Vous avez des questions ?">
		<cfset email_subtitle4 = "Notre équipe prend en charge vos demandes :<br>Du lundi au vendredi de 8h à 18h au 01 89 16 82 67<br>ou par email : certif@wefitgroup.com">
		
		<cfset th_certif = "IDENTIFIANTS CERTIFICATION">
		<cfset th_token = "ENTRY CODE">
		<cfset th_institution_id = "INSTITUTION_ID">
		<cfset th_candidate_id = "CANDIDATE_ID">
		<cfset th_url_metritest = "ADRESSE URL">
		
		<cfset th_login = "IDENTIFIANTS ELEARNING">
		<cfset th_url = "Adresse URL">
		<cfset th_email = "Email">
		<cfset th_temp_pwd = "Mot de passe temporaire*">
		<cfset th_pwd_known = "Vous seul le connaissez">
		
		
		<cfset th_prompt = "*Il vous sera demand&eacute; de r&eacute;initialiser votre mot de passe d&egrave;s que vous vous connectez &agrave; la plateforme WEFIT">
		<cfset btn_connect = "Je me connecte !">
		<cfset th_formation = "MA FORMATION">
		<cfset th_tp = "PARCOURS">
		

		
	<cfelseif lang eq "en">
	
		<cfset email_title = "Passage de votre certification">
		<cfset email_subtitle = "Vous avez opté pour la certification <br> <strong>#get_token.certif_name#</strong> <br>Les codes suivants seront nécessaires au passage de votre certification :">
		
		<cfset email_title2 = "Déroulement de la certification">
		<cfset email_subtitle2 = "Veuillez suivre attentivement les étapes ci-dessous :">
		
		<cfset email_title3 = "Votre compte eLearning">
		<cfset email_subtitle3 = "Si vous souhaitez accéder à la plateforme e-Learning et vous entraîner, veuillez utiliser les identifiants suivants :">
		
		<cfset email_title4 = "Vous avez des questions ?">
		<cfset email_subtitle4 = "Notre équipe prend en charge vos demandes :<br>Du lundi au vendredi de 8h à 18h au 01 89 16 82 67<br>ou par email : certif@wefitgroup.com">
		
		<cfset th_certif = "IDENTIFIANTS CERTIFICATION">
		<cfset th_token = "ENTRY CODE">
		<cfset th_institution_id = "INSTITUTION_ID">
		<cfset th_candidate_id = "CANDIDATE_ID">
		<cfset th_url_metritest = "Adresse URL">

		<cfset th_login = "IDENTIFIANTS ELEARNING">
		<cfset th_url = "Adresse URL">
		<cfset th_email = "Email">
		<cfset th_temp_pwd = "Mot de passe temporaire*">
		<cfset th_prompt = "*Il vous sera demand&eacute; de r&eacute;initialiser votre mot de passe d&egrave;s que vous vous connectez &agrave; la plateforme WEFIT">
		<cfset btn_connect = "Je me connecte !">
		<cfset th_formation = "MA FORMATION">
		<cfset th_tp = "PARCOURS">
		
	<cfelseif lang eq "de">
	
		<cfset email_title = "Passage de votre certification">
		<cfset email_subtitle = "Vous avez opté pour la certification <br> <strong>#get_token.certif_name#</strong> <br>Les codes suivants seront nécessaires au passage de votre certification :">
		
		<cfset email_title2 = "Déroulement de la certification">
		<cfset email_subtitle2 = "Veuillez suivre attentivement les étapes ci-dessous :">
		
		<cfset email_title3 = "Votre compte eLearning">
		<cfset email_subtitle3 = "Si vous souhaitez accéder à la plateforme e-Learning et vous entraîner, veuillez utiliser les identifiants suivants :">
		
		<cfset email_title4 = "Vous avez des questions ?">
		<cfset email_subtitle4 = "Notre équipe prend en charge vos demandes :<br>Du lundi au vendredi de 8h à 18h au 01 89 16 82 67<br>ou par email : certif@wefitgroup.com">
		
		<cfset th_certif = "IDENTIFIANTS CERTIFICATION">
		<cfset th_token = "ENTRY CODE">
		<cfset th_institution_id = "INSTITUTION_ID">
		<cfset th_candidate_id = "CANDIDATE_ID">
		<cfset th_url_metritest = "Adresse URL">
		
		<cfset th_login = "IDENTIFIANTS ELEARNING">
		<cfset th_url = "Adresse URL">
		<cfset th_email = "Email">
		<cfset th_temp_pwd = "Mot de passe temporaire*">
		<cfset th_prompt = "*Il vous sera demand&eacute; de r&eacute;initialiser votre mot de passe d&egrave;s que vous vous connectez &agrave; la plateforme WEFIT">
		<cfset btn_connect = "Je me connecte !">
		<cfset th_formation = "MA FORMATION">
		<cfset th_tp = "PARCOURS">
		
	<cfelseif lang eq "es">
		<cfset email_title = "">
		<cfset email_subtitle = "">
		<cfset th_login = "">
		<cfset th_url = "">
		<cfset th_email = "">
		<cfset th_temp_pwd = "">
		<cfset th_prompt = "">
		<cfset btn_connect = "">
	<cfelseif lang eq "it">
		<cfset email_title = "">
		<cfset email_subtitle = "">
		<cfset th_login = "">
		<cfset th_url = "">
		<cfset th_email = "">
		<cfset th_temp_pwd = "">
		<cfset th_prompt = "">
		<cfset btn_connect = "">
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
								
								<p style="margin: 30px 0 10px;">
									<table width="100%" cellpadding="5" style="border:1px solid #ECECEC">
										<tr>
											<th bgcolor="#F3F3F3"><cfoutput>#th_certif#</cfoutput></th>
										</tr>
									</table>
									<table width="100%" cellpadding="5" style="border-top:0px; border-left:1px solid #ECECEC; border-right:1px solid #ECECEC; border-bottom:1px solid #ECECEC;">
										<tr>
											<td width="35%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_token#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(get_token.token_code)#</cfoutput></td>
										</tr>
										<tr>
											<td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_institution_id#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">FR171_RP</td>
										</tr>
										<tr>
											<td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_candidate_id#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_email)#</cfoutput></td>
										</tr>
										<cfif isDefined("no_install")>
										<tr>
											<td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_url_metritest#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;"><a href="https://www.metritests.com/metrica/">https://www.metritests.com/metrica/</a></td>
										</tr>
										</cfif>
									</table>
								</p>
								
								<!--- <h1 style="margin: 20px 0 10px 0; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>Attention !</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>Une maintenance du système de passage de la certification Linguaskill est prévue le <strong>25 mai 2022</strong>. Veuillez choisir une autre date pour votre test ;)</cfoutput></h4> --->
									

								
								<cfif not isDefined("no_install")>
									<h1 style="margin: 20px 0 10px 0; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title2#</cfoutput></h1>
									<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle2#</cfoutput></h4>
									
									<p style="margin: 30px 0 10px;">
									<table width="100%" cellpadding="5">
										<tr>
											<td width="20%" align="center"><img src="https://lms.wefitgroup.com/assets/img/file-download.png" width="35"></td>
											<td align="left" style="font-size: 13px;">Je consulte impérativement le manuel du candidat<br><a href="https://formation.wefitgroup.com/assets/docs/2022_Process_LINGUASKILL_RL_FR.pdf"><strong style="color:##FF0000">[CONSULTER]</strong></a></td>
										</tr>
										<tr>
											<td width="20%" align="center"><img src="https://lms.wefitgroup.com/assets/img/download.png" width="40"></td>
											<td align="left" style="font-size: 13px;">J'installe le logiciel de surveillance et je vérifie la compatibilité<br><a href="https://app-electron-eu.sumadi.net/download/app/en/eu/global/v2"><strong style="color:##FF0000">[TÉLÉCHARGER]</strong></a></td>
										</tr>
										<tr>
											<td width="20%" align="center"><img src="https://lms.wefitgroup.com/assets/img/file-download.png" width="35"></td>
											<td align="left" style="font-size: 13px;">Si je rencontre un souci technique, je consulte le document de résolution des problèmes<br><a href="https://formation.wefitgroup.com/assets/docs/2022_Resolution_Problemes_Techniques.pdf"><strong style="color:##FF0000">[CONSULTER]</strong></a></td>
										</tr>
										<tr>
											<td width="20%" align="center"><img src="https://lms.wefitgroup.com/assets/img/file-certificate.png" width="40"></td>
											<td align="left" style="font-size: 13px;">Je passe mon test et je reçois les résultats (PDF) par email, suite à la validation de mon identité et l'analyse de ma vidéo par l'équipe WEFIT</td>
										</tr>
									</table>
									</p>
									<p style="margin: 0; font-size: 13px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
										<em>
											La validation de vos résultats s'effectue dans les 24h ouvrées suivant le passage de votre test. 
											Sans contre-indication, vous recevrez votre certificat par email. 
											Afin de valider définitivement votre résultat et de garantir son authenticité, 
											WEFIT se réserve le droit de vous appeler et/ ou programmer un échange visio de 5 minutes durant lequel votre caméra et micro devront être activés et pour lequel vous devrez être munis d’une pièce d’identité valide.
											En cas de non-respect des règles de passage ou sans réponse de votre part, 
											le certificat pourrait être invalidé sans remboursement possible. <br><br>
											Le passage de la certification ne concerne que les candidats étudiant ou résidant sur le territoire français (+DOM/TOM) et allemand.
											<br><br> Durée de validité du code : 1 an (après un an votre achat ne sera plus valable)
										</em>
									</p>
								</cfif>

								
								<cfif isdefined("user_create_el") AND user_create_el eq "1">
								<h1 style="margin: 30px 0 10px 0; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title3#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle3#</cfoutput></h4>
								
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
										<tr>
											<td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_temp_pwd#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput><cfif not isdefined("user_id") OR (isdefined("user_pwd_chg") AND user_pwd_chg eq "0")>#trim(user_pwd)#<cfelse>#th_pwd_known#</cfif></cfoutput>
											</td>
										</tr>
										
									</table>
									<cfif not isdefined("user_id")>
									<p style="font-size:12px"><em><cfoutput>#th_prompt#</cfoutput></em></small></p>
									</cfif>
								</p>
								</cfif>
								
								
							</td>
                        </tr>
						<cfif isdefined("user_create_el") AND user_create_el eq "1">
                        <tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
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
						</cfif>
						<tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
								<h1 style="margin: 20px 0 10px 0; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title4#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle4#</cfoutput></h4>
							 </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
			
		
		<cfinclude template="incl_email_footer.cfm">
		
    </center>
</body>
</html>