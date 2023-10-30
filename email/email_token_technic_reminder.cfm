<cfsilent>

    <cfif isdefined("display_warning")>
        <cfset email_title1 = "Passage de votre certification">
        <cfset email_subtitle1 = display_warning>
    <cfelse>
        <cfset email_title1 = "Passage de votre certification">
        <cfset email_subtitle1 = "Vous allez passer la certification <br> <strong>#get_token.certif_name#</strong>">
    </cfif>

    <cfset email_title2 = "Petit rappel des conditions de passage">
    <cfset email_subtitle2 = "Veillez à vérifier que votre matériel remplit les conditions suivantes :">

    <cfset email_title4 = "Vous avez des questions ?">
	<cfset email_subtitle4 = "Notre équipe prend en charge vos demandes :<br>Du lundi au vendredi de 8h à 18h au 01 89 16 82 67<br>ou par email : certif@wefitgroup.com">
		

</cfsilent>

    <!DOCTYPE html>
    <html lang="fr" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
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
                                    
                                    <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title1#</cfoutput></h1>
                                    <h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle1#</cfoutput></h4>
                                    
                                        <p style="margin: 30px 0 10px;">
                                        <table width="100%" cellpadding="5">
                                            <tr>
                                                <td width="20%" align="center"><img src="./assets/img/file-download.png" width="40"></td>
                                                <td align="left" style="font-size: 13px;">Je consulte impérativement le manuel du candidat<br><a href="https://formation.wefitgroup.com/assets/docs/2022_Process_LINGUASKILL_RL_FR.pdf"><strong style="color:##FF0000">[CONSULTER]</strong></a></td>
                                            </tr>
                                            <tr>
                                                <td width="20%" align="center"><img src="./assets/img/download.png" width="40"></td>
                                                <td align="left" style="font-size: 13px;">J'installe le logiciel de surveillance et je vérifie la compatibilité<br><a href="https://app-electron-eu.sumadi.net/download/app/en/eu/global/v2"><strong style="color:##FF0000">[TÉLÉCHARGER]</strong></a></td>
                                            </tr>
                                            <tr>
                                                <td width="20%" align="center"><img src="./assets/img/file-download.png" width="35"></td>
                                                <td align="left" style="font-size: 13px;">Si je rencontre un souci technique, je consulte le document de résolution des problèmes<br><a href="https://formation.wefitgroup.com/assets/docs/2022_Resolution_Problemes_Techniques.pdf"><strong style="color:##FF0000">[CONSULTER]</strong></a></td>
                                            </tr>
                                        </table>
                                        </p>
                                        

                                    <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title2#</cfoutput></h1>
                                    <h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle2#</cfoutput></h4>
                                        
                                    <p style="margin: 0; font-size: 13px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
                                        <ul>
                                            <li>Application SUMADI V2 installée</li>
                                            <li>Windows 8 et plus</li>
                                            <li>Mac OS X et plus</li>
                                            <li>Webcam fonctionnelle</li>
                                            <li>L’utilisation d’un second écran n’est pas autorisée</li>
                                            <li>Débit internet : 512 kbps minimum</li>
                                            <li>Taille de l’écran : 13’’ minimum avec une résolution de 1280 px x 720 px minimum</li>
                                            <li>Navigateur : Chrome</li>
                                            <li>Casque audio (vérifiez que le périphérique est bien reconnu par votre ordinateur)</li>
                                        </ul>
                                    </p>
                                </td>
                            </tr>

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