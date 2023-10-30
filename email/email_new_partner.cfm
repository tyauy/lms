<cfsilent>
<cfif isdefined("lang")>
<!---COMPLEX
<cfoutput>

	<cfset user_firstname = get_user.user_firstname>
	<cfset user_lastname = ucase(get_user.user_name)>
	<cfset arr = ['user_firstname', 'user_lastname']>
	<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
	
	<cfset email_title = #obj_translater.get_translate_complex('mail_new_test_title', lang)#>
	<cfset email_subtitle = #obj_translater.get_translate_complex('mail_new_tm_subtitle', lang, argv)#>
	<cfset th_login = #obj_translater.get_translate('table_th_login', lang)#>
	<cfset th_url = #obj_translater.get_translate('table_th_url', lang)#>
	<cfset th_email = #obj_translater.get_translate('form_subscription_2', lang)#>
	<cfset th_temp_pwd = #obj_translater.get_translate('table_th_tmp_pwd', lang)#>
	<cfset th_pwd = #obj_translater.get_translate('form_label_password', lang)#>
	<cfset th_pwd_explain = #obj_translater.get_translate_complex('mail_pwd_explain', lang)#>
	<cfset th_prompt = #obj_translater.get_translate_complex('mail_new_formation_subtitle', lang)#>
	<cfset btn_connect = #obj_translater.get_translate('btn_connect', lang)#>
</cfoutput>
START_RM--->

	<cfif lang eq "fr">
		<cfset email_title = "Bienvenue chez WEFIT !">
		<cfset email_subtitle = "#user_firstname# #ucase(user_lastname)#, votre compte Partner Manager est actif.">
		<cfset th_login = "IDENTIFIANTS DE CONNEXION">
		<cfset th_url = "Adresse URL">
		<cfset th_email = "Email">
		<cfset th_temp_pwd = "Mot de passe temporaire*">
		<cfset th_pwd = "Mot de passe">
		<cfset th_pwd_explain = "Vous seul le connaissez">
		<cfset th_prompt = "*Il vous sera demand&eacute; de r&eacute;initialiser votre mot de passe d&egrave;s que vous vous connectez &agrave; la plateforme WEFIT">
		<cfset btn_connect = "Je me connecte !">

		
	<cfelseif lang eq "en">
	
		<cfset email_title = "Welcome to WEFIT!">
		<cfset email_subtitle = "#user_firstname# #ucase(user_lastname)#, your account is active !">
		<cfset th_login = "YOUR LOGINS">
		<cfset th_url = "URL">
		<cfset th_email = "Email">
		<cfset th_pwd = "Password">
		<cfset th_pwd_explain = "You already know it">
		<cfset th_temp_pwd = "Temporary password*">
		<cfset th_prompt = "*You will be prompted to reset your password when you are connected.">
		<cfset btn_connect = "Connect to LMS">

		
	<cfelseif lang eq "de">
	
		<cfset email_title = "Willkommen bei WEFIT!">
		<cfset email_subtitle = "#user_firstname# #ucase(user_lastname)#, ihr WEFIT Profil ist jetzt aktiv">
		<cfset th_login = "IHRE ZUGANGSDATEN">
		<cfset th_url = "URL-Adresse">
		<cfset th_email = "Email">
		<cfset th_pwd = "Passwort">
		<cfset th_pwd_explain = "Es ist Ihnen bereits bekannt">
		<cfset th_temp_pwd = "Tempor&auml;res Passwort*">
		<cfset th_prompt = "*Beim ersten einloggen, werden Sie aufgefordert ihr tempor&auml;res Passwort zur&uuml;ckzusetzen">
		<cfset btn_connect = "Verbinden">

		
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
					<cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/logo_gymglish.jpg" alt="Gymglish" border="0" align="center" style="max-width: 100%; height: auto; background: ##FFF; font-family: sans-serif; font-size: 15px; line-height: 140%; color: ##555555; margin: auto;" class="g-img"></cfoutput>
					<table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
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
										<tr>
											<td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_pwd#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_pwd)#</cfoutput></td>
										</tr>
									</table>
								</p>
							</td>
                        </tr>
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
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
			
		
		<cfinclude template="incl_email_footer.cfm">
		
    </center>
</body>
</html>