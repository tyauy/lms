<cfsilent>
    <cfset email_title = "Bienvenue chez WEFIT,<br>#user_firstname# #ucase(user_lastname)#">
    <cfset email_subtitle = "Votre Université ou École travaille avec WEFIT dans le cadre de la certification LINGUASKILL de vos étudiants.<br><br>Un espace de consultation est mis à disposition sur notre plateforme.">
    <cfset th_login = "IDENTIFIANTS DE CONNEXION">
    <cfset th_url = "Adresse URL">
    <cfset th_email = "Email">
    <cfset th_temp_pwd = "Mot de passe temporaire*">
    <cfset th_pwd = "Mot de passe">
    <cfset th_pwd_explain = "Vous seul le connaissez">
    <cfset th_prompt = "*Il vous sera demand&eacute; de r&eacute;initialiser votre mot de passe d&egrave;s que vous vous connectez &agrave; la plateforme WEFIT">
    <cfset btn_connect = "Je me connecte !">
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
                            <cfoutput query="get_session_access">
                                #token_session_name#<br>
                            </cfoutput>

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
                                        <td style="background-color: #F3F3F3; font-size: 13px;"><cfif user_pwd_chg eq "0"><cfoutput>#th_temp_pwd#</cfoutput><cfelse><cfoutput>#th_pwd#</cfoutput></cfif></td>
                                        <td style="background-color: #FFF; font-size: 13px;"><cfif user_pwd_chg eq "1">Vous seul le connaissez<cfelse><cfoutput>#trim(user_pwd)#</cfoutput></cfif></td>
                                    </tr>
                                </table>
                                <cfif user_pwd_chg eq "0"><span style="font-size: 13px;"><cfoutput>#trim(th_prompt)#</cfoutput></span></cfif>
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