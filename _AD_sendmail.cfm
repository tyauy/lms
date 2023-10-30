<cfmail from="service@wefitgroup.com" 
to="cbrutus@wefitgroup.com,rremacle@wefitgroup.com" 
subject="Envoie de notification vie LMS Wefit" 
type="html" 
server="#SESSION.CFMAIL_SERVER#"
username="#SESSION.CFMAIL_USERNAME#"
password="#SESSION.CFMAIL_PASSWORD#"
port="#SESSION.CFMAIL_PORT#">


<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
	<cfinclude template="./email/incl_email_meta.cfm">
</head>

<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: ##FFF;">
    <center style="width: 100%; background-color: ##FFF; text-align: left;">
	
	
	<cfinclude template="./email/incl_email_header.cfm">
			
			<!-- 1 Column Text + Button : BEGIN -->
            <tr>
                <td style="background-color: ##ffffff;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: ##ffffff;">
                        <tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: ##555555;">
                                <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: ##333333; font-weight: normal; text-align:center">Ceci et un test</h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: ##333333; font-weight: normal; text-align:center">d'envoi d'email via WEFIT</h4>
								
							</td>
                        </tr>
                        <tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: ##555555;">
                                <!-- Button : BEGIN -->
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: ##87222F;">
										     <a class="button-a button-a-primary" href="https://lms.wefitgroup.com" style="background: ##87222F; border: 1px solid ##87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:##ffffff">Connexion LMS</span></a>
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
			
		
		<cfinclude template="./email/incl_email_footer.cfm">
		
    </center>
</body>
</html>


</cfmail>
sqfb
