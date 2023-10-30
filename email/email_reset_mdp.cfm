<cfif isdefined("reinit") AND isdefined("temp")>
	<cfsilent>
<!---COMPLEX
<cfoutput>
	<cfset email_title = #obj_translater.get_translate_complex('mail_reset_mdp_title', lang)#>
	<cfset email_subtitle =  #obj_translater.get_translate_complex('mail_reset_mdp_subtitle', lang)#>
	<cfset btn_lms = #obj_translater.get_translate_complex('mail_reset_mdp_btn', lang)#>
	<cfset footer_txt = #obj_translater.get_translate_complex('mail_reset_mdp_footer', lang)#>
</cfoutput>
START_RM--->
		<cfif lang eq "fr">		
			<cfset email_title = "Vous avez perdu votre mot de passe ?">
			<cfset email_subtitle = "Veuillez cliquer sur le lien suivant. Vous serez r&eacute;dirig&eacute;(e) sur une interface vous permettant d'entrer un nouvau mot de passe.">
			<cfset btn_lms = "R&eacute;initialiser mon mot de passe">
			<cfset footer_txt = "Si vous n'&ecirc;tes pas &agrave; l'origine de cet email, veuillez l'ignorer. Si vous recevez &agrave; nouveau ce type de message, veuillez contacter notre service client.">
		<cfelseif lang eq "en">
			<cfset email_title = "You have lost your password...">
			<cfset email_subtitle = "Please click on the link below, you will be redirected to a page where you can reset it.">
			<cfset btn_lms = "Reset password">
			<cfset footer_txt = "Please ignore this email if you are not concerned. Please contact our customer service if you receive this email again.">
		<cfelseif lang eq "de">
			<cfset email_title = "Sie haben Ihr Passwort vergessen?">
			<cfset email_subtitle = "Bitte folgen Sie nachstehendem Link, um ein neues Passwort zu vergeben.">
			<cfset btn_lms = "Passwort zur&uuml;cksetzen">
			<cfset footer_txt = "">
		<cfelseif lang eq "es">
		
		<cfelseif lang eq "it">
		
		</cfif>
<!---END_RM--->
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
								<p style="margin: 0 0 10px;">
									
								</p>
							</td>
                        </tr>
						
                        <tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                                <!-- Button : BEGIN -->
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

										     <a class="button-a button-a-primary" href="<cfoutput>https://lms.wefitgroup.com/_reinit.cfm?phsh=#temp#&u_id=#get_email.user_id#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput></span></a>

										</td>
                                    </tr>
                                </table>
                                <!-- Button : END -->
                            </td>
                        </tr>
						
						<tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
								<h5 style="margin: 0 0 10px; font-size: 15px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
								<cfoutput>#footer_txt#</cfoutput>
								</h5>
							</td>
						</tr>
						
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
			
		
		<cfinclude template="incl_email_footer.cfm">
		
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>


</cfif>