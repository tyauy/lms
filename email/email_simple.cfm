<cfsilent>

    <cfif not isDefined("email_title")>
        <cfset email_title="">
    </cfif>
    <cfif not isDefined("email_title")>
        <cfset email_subtitle="">
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
								<cfif isDefined("email_subtitle")><h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4></cfif>
								<p style="margin: 0 0 10px;">
									
								</p>
							</td>
                        </tr>
						
                    </table>
                </td>
            </tr>
			
		
		<cfinclude template="incl_email_footer.cfm">
		
    </center>
</body>
</html>
