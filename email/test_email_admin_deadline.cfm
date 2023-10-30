<cfset u_id = 411>
<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>
<cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tps">
    <cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>

<cfparam name="lang" default="fr">

<cfinclude template="./incl_nav_beta.cfm">

<cfsilent>
<cfif not isdefined("lang")>
	<cfset lang = "fr">
</cfif>
<cfset user_firstname = get_user.user_firstname>
<cfset user_lastname = ucase(get_user.user_name)>
<cfset user_email = get_user.user_email>

<cfset arr = ['user_firstname', 'user_lastname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<!--- <cfset email_title = #obj_translater.get_translate_complex('mail_test_done_title', lang, argv)#>
<cfset email_subtitle = #obj_translater.get_translate_complex('mail_test_done_subtitle', lang)#> --->

<cfset email_title = "Bonjour #user_firstname# #user_lastname#">
<cfset email_subtitle = "Subtitle">

<cfset email_header_img = "header_email_na_done.jpg">
<cfset email_icon = "icon_na_done.png">


<cfset btn_href = "https://lms.wefitgroup.com">
<cfset btn_lms = "SIGNER MON ATTESTATION">

<cfinclude template="./incl_nav_beta.cfm">

<cfif not isdefined("lang")>
    <cfset lang = "fr">
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
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
								Nous vous informons que votre formation est arrivée à son terme le : <br><br><strong style='color:#87222F; font-size:22px'><cfoutput>#dateformat(get_tps.order_end,'dd/mm/yyyy')#</cfoutput></strong><br><br> 
								</h4>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal;">
								Il s'agit de la date de clôture administrative de votre dossier. Nous vous rappelons que cette date limite a été fixée par l'organisme financeur de votre formation et que WEFIT n'est pas responsable sur ce point. 
								<br><br>
								Vous n'avez pas réalisé l'ensemble de vos heures prévues initialement, n'hésitez pas à revenir vers nous pour trouver ensemble une solution dans le cas où vous souhaiteriez continuer. 
								<br><br>
								Veuillez trouver ci-après votre attestation de formation partielle à nous retourner signée ce jour.
								</h4>
								<br>
								<table width="100%" cellpadding="0">
									<tr>
										<td width="100%" style="border:1px solid #87222F;">
											<table width="100%" cellspacing="4" cellpadding="10" style="color: #555555; font-size: 14px;">
												<tr>
													<td align="center">
													<h1 style="margin: 10px; font-size: 22px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
													Pour générer votre attestation de formation, veuillez cliquer sur le lien ci-dessous						
													</h1>
													<em>Vous pourrez signer le document à l'aide de votre doigt ou votre souris dans le cadre réservé en bas de la page :</em><br><br>
													
													
													 <!-- Button : BEGIN -->
													<table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
														<tr>
															<td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

																<a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 11px 15px; display: block; border-radius: 4px;">
																<span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput>
																</span>
																</a>

															</td>
														</tr>
													</table>
													<!-- Button : END -->
													
													<br>
													</td>
												</tr>
											</table>
										</td>
										
									</tr>
								</table>
								<br>
								<table width="100%" cellspacing="4" cellpadding="10" style=" color: #555555; font-size: 14px;">
									<tr>
										<td width="100%" style="border:1px solid #87222F;" align="center">
										
											<h1 style="margin: 10px; font-size: 22px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
											Contacter notre service administratif<br>au numéro suivant:		
											</h1>
													
										
											 <!-- Button : BEGIN -->
											<table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
												<tr>
													<td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

														 <a class="button-a button-a-primary" href="#" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 6px 9px; display: block; border-radius: 4px;">
														 <span class="button-link" style="color:#ffffff">
														 09 72 45 24 50
														 </span>
														 </a>

													</td>
												</tr>
											</table>
											<!-- Button : END -->
											ou par mail: 
											<br>
											<!-- Button : BEGIN -->
											<table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
												<tr>
													<td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

														<a class="button-a button-a-primary" href="#" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 6px 9px; display: block; border-radius: 4px;">
														<span class="button-link" style="color:#ffffff">
														finance@wefitgroup.com
														</span>
														</a>

													</td>
												</tr>
											</table>
											<!-- Button : END -->
										<br>
										afin de trouver ensemble une solution quant à la date limite de formation.
										</td>
									</tr>
								</table>
									
								<br>
								<em>
								Sans réponse de votre part dans un <strong>délai d'une semaine</strong> à compter de ce jour, nous considérerons que vous ne souhaitez pas continuer votre formation et nous clôturerons définitivement votre dossier. 
								</em>
								<br><br>
								<h4 style="margin: 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
									Pour tout complément d'information, nous restons à votre disposition <br><strong>du lundi au vendredi de 8h00 à 18h00.</strong>

									<br><br>
									Nous vous souhaitons une excellente journée.
									<br><br>
									Cordialement,
									<br><br>
									<strong>WEFIT TEAM</strong>
								</h4>
							</td>
                        </tr>
						<!--- <cfif isdefined("email_footer")> --->
						<!--- <tr> --->
                            <!--- <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;"> --->
								<!--- <h5 style="margin: 0 0 10px; font-size: 13px; line-height: 125%; color: #333333; font-weight: normal; text-align:left"> --->
								<!--- <cfoutput>#email_footer#</cfoutput> --->
								<!--- </h5> --->
							<!--- </td> --->
						<!--- </tr> --->
						<!--- </cfif> --->
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