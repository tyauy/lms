<cfsilent>
<cfoutput>
	<cfset user_firstname = get_user.user_firstname>
	<cfset user_lastname = ucase(get_user.user_name)>
	<cfset btn_connect = "Accès fiche learner">
	<cfif !isDefined("email_title")>
		<cfset email_title = "a réalisé un lancement autonome">
	</cfif>
</cfoutput>	
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
								<h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#user_firstname# #user_lastname#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h4>
								<!--- <p style="margin: 30px 0 10px;"> --->
									<!--- <table width="100%" cellpadding="5" style="border:1px solid #ECECEC"> --->
										<!--- <tr> --->
											<!--- <th bgcolor="#F3F3F3"><cfoutput>#th_login#</cfoutput></th> --->
										<!--- </tr> --->
									<!--- </table> --->
									<!--- <table width="100%" cellpadding="5" style="border-top:0px; border-left:1px solid #ECECEC; border-right:1px solid #ECECEC; border-bottom:1px solid #ECECEC;"> --->
										<!--- <tr> --->
											<!--- <td width="35%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_url#</cfoutput></td> --->
											<!--- <td width="65%" style="background-color: #FFF; font-size: 13px;"> --->
											<!--- <a href="https://lms.wefitgroup.com">lms.wefitgroup.com</a> --->
											<!--- </td> --->
										<!--- </tr> --->
										<!--- <tr> --->
											<!--- <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_email#</cfoutput></td> --->
											<!--- <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_email)#</cfoutput></td> --->
										<!--- </tr> --->
										<!--- <cfif isdefined("send_reset")> --->
										<!--- <tr> --->
											<!--- <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_temp_pwd#</cfoutput></td> --->
											<!--- <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#trim(user_pwd)#</cfoutput></td> --->
										<!--- </tr> --->
										<!--- <cfelse> --->
										<!--- <tr> --->
											<!--- <td style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_pwd#</cfoutput></td> --->
											<!--- <td style="background-color: #FFF; font-size: 13px;"><cfoutput>#th_pwd_explain#</cfoutput></td> --->
										<!--- </tr> --->
										<!--- </cfif> --->
									<!--- </table> --->
									<!--- <cfif isdefined("send_reset")> --->
									<!--- <p style="font-size:12px"><em><cfoutput>#th_prompt#</cfoutput></em></small></p> --->
									<!--- </cfif> --->
								<!--- </p> --->
								
							</td>
						</tr>
						<tr>
							<td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
								<!-- Button : BEGIN -->
								<table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
									<cfif isDefined("lesson_list")>
										<cfoutput>#lesson_list#</cfoutput>
									</cfif>
									<tr>
										<td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">
												<a class="button-a button-a-primary" href="<cfoutput>https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#u_id#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_connect#</cfoutput></span></a>
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