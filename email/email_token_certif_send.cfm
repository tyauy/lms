<cfsilent>

    <cfset email_title1 = "Vous avez récemment passé la certification LINGUASKILL">
    <cfset email_subtitle1 = "... et nous vous remercions d'avoir choisi WEFIT !<br><br>Vous trouverez en pièce jointe le résultat de votre certification">
         
    <cfset email_title4 = "Nous restons à votre disposition">
    <cfset email_subtitle4 = "Notre équipe prend en charge vos demandes au 01 89 16 82 67<br>ou par email : service@wefitgroup.com">

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