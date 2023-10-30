<!--- <cfif isdefined("status") AND isdefined("recipient")> --->

<cfsilent>

	<cfparam name="btn_href" default="https://lms.wefitgroup.com">
	<cfset btn_lms = "SIGNER MON ATTESTATION">
	<cfset email_title = "Bonjour #get_tps.user_contact#">

	
	
	
<!--- <cfif isdefined("lang") AND lang eq "en"> --->

		
	<!--- <cfif status eq "no_next_lesson"> --->
		<!--- <cfset email_title = "Vous n'avez aucun cours programmé"> --->
		<!--- <cfset email_subtitle = "#get_lesson.trainer_firstname# filled your lesson note - Lesson done on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#."> --->
		<!--- <cfset email_footer = "Click on the link below to get access to your lesson note."> --->
	<!--- <cfelseif status eq "bad_learner"> --->
		<!--- <cfset email_title = "Vous êtes toujours avec nous ? ;)"> --->
		<!--- <cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# is now cancelled."> --->
		<!--- <cfset email_footer = ""> --->
	<!--- </cfif> --->
	
	<!--- <cfif recipient eq "learner"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- <cfelseif recipient eq "trainer"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- </cfif> --->
	
<!--- <cfelseif isdefined("lang") AND lang eq "de"> --->

	<!--- <cfif status eq "no_next_lesson"> --->
		<!--- <cfset email_title = "Sie haben keinen Kurs gebucht."> --->
		<!--- <cfset email_subtitle = "#get_lesson.trainer_firstname# hat Ihre Lesson Note ausgefüllt. Lesson Note erstellt am #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#."> --->
		<!--- <cfset email_footer = "Bitte folgen Sie nachstehendem Link um zu Ihren Lesson Notes zu gelangen."> --->
	<!--- <cfelseif status eq "bad_learner"> --->
		<!--- <cfset email_title = "Vous êtes toujours avec nous ? ;)"> --->
		<!--- <cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# is now cancelled."> --->
		<!--- <cfset email_footer = ""> --->
	<!--- </cfif> --->
	
	<!--- <cfif recipient eq "learner"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- <cfelseif recipient eq "trainer"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- </cfif> --->
	
<!--- <cfelse> --->

	<!--- <cfif status eq "no_next_lesson"> --->
		<!--- <cfset email_title = "Vous n'avez aucun cours programm&eacute;"> --->
		<!--- <cfset email_subtitle = "Nous vous rappelons qu'aucun cours n'a été planifié depuis votre dernière en date du "> --->
		<!--- <cfset email_footer = "Connectez-vous à la plateforme pour planifier"> --->
	<!--- <cfelseif status eq "bad_learner"> --->
		<!--- <cfset email_title = "Vous &ecirc;tes toujours avec nous ? ;)"> --->
		<!--- <cfset email_subtitle = ""> --->
		<!--- <cfset email_footer = ""> --->
	<!--- </cfif> --->
	
	<!--- <cfif recipient eq "learner"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- <cfelseif recipient eq "trainer"> --->
		<!--- <cfset btn_href = "https://lms.wefitgroup.com"> --->
		<!--- <cfset btn_lms = "GO TO WEFIT LMS"> --->
	<!--- </cfif> --->
	
<!--- </cfif> --->



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


<!--- </cfif> --->