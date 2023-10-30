<!--- <cfif isdefined("status") AND isdefined("recipient")> --->

<cfsilent>

	<cfset btn_href = "https://lms.wefitgroup.com">
	<cfset btn_lms = "CONNEXION WEFIT LMS">
	<cfset email_title = "Bonjour #get_tps.user_contact#">
	<cfset email_subtitle = "Nous vous informons que votre dossier de formation arrive à son terme le : <br><br><strong style='color:##87222F; font-size:22px'>#dateformat(get_tps.order_end,'dd/mm/yyyy')#</strong><br><br>Nous vous rappelons que cette date limite a été fixée par l'organisme financeur de votre formation et que WEFIT n'est en aucun cas responsable sur ce point. ">
	<cfset email_explain = "À ce jour, il vous reste XX heures à programmer. Passé cette date, vous ne pourrez plus réserver de cours.">
	
	<cfset email_footer = "Click on the link below to get access to your lesson note.">
	<cfset th_tp = "Parcours">
	<cfset th_status = "Status">
	<cfset th_progress = "Cr&eacute;dits restants">
	
	
	
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
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
								<p style="margin: 30px 0 10px; color: #555555;">
								<table width="100%" cellpadding="4" style="border:1px solid #ECECEC; color: #555555; font-size: 13px;">
									<tr>
										<th width="50%" bgcolor="#F3F3F3"><cfoutput>#th_tp#</cfoutput></th>
										<th bgcolor="#F3F3F3"><cfoutput>#th_status#</cfoutput></th>
										<th bgcolor="#F3F3F3"><cfoutput>#th_progress#</cfoutput></th>
									</tr>
									<cfoutput query="get_tps">
																			
										

										<!--- <cfif method_id eq "3"> --->
											<!--- <cfset access_el = "1"> --->
										<!--- <cfelseif method_id eq "2"> --->
											<!--- <cfset access_f2f = "1"> --->
										<!--- <cfelseif method_id eq "1"> --->
											<!--- <cfset access_visio = "1"> --->
										<!--- </cfif> --->
										<tr>
											<td style="font-size: 13px;">
											#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
											</td>
											<td style="font-size: 13px;">
											<cfif method_id neq "7"> 
											#status_name#
											</cfif>
											</td>
											<td style="font-size: 13px;">
											<cfif method_id eq "1" OR method_id eq "2"> 
												<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
												<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
												<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
												<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
												<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
												<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
												<cfset tp_remain_go = (tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go)/60>
												#tp_remain_go#
											</cfif>
											
											</td>
										</tr>
									</cfoutput>
								</table>
								</p>
								
								<h1 style="margin: 10px; font-size: 22px; line-height: 125%; color: #333333; font-weight: normal; text-align:center">
								2 options s'offrent à vous :								
								</h1>
								<table width="100%" cellpadding="0">
									<tr>
										<td width="47%" style="border:1px solid #87222F;">
											<table width="100%" cellspacing="4" cellpadding="10" style="color: #555555; font-size: 14px;">
												<tr>
													<td align="center">
													
													<strong style="color:#87222F; font-size:15px">Réserver vos cours</strong><br><br> via votre système de réservation disponible sur votre plateforme WEFIT GROUP :<br><br>
													
													
													 <!-- Button : BEGIN -->
													<table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
														<tr>
															<td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

																 <a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 6px 9px; display: block; border-radius: 4px;">
																 <span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput>
																 </span>
																 </a>

															</td>
														</tr>
													</table>
													<!-- Button : END -->
													</td>
												</tr>
											</table>
										</td>
										<td width="6%">
										
										</td>
										<td width="47%" style="border:1px solid #87222F;">
											<table width="100%" cellspacing="4" cellpadding="10" style=" color: #555555; font-size: 14px;">
												<tr>
													<td align="center">
													
													<strong style="color:#87222F; font-size:15px">Contacter notre service administratif</strong><br> au numéro suivant:<br>
													
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
										</td>
									</tr>
								</table>
								<br>
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