<cfif isdefined("status") AND isdefined("recipient")>

<cfsilent>

<cfif isdefined("lang") AND lang eq "en">

	<cfif status eq "reminder">
		<cfset email_title = "Reminder">
		<cfset email_subtitle = "You have a lesson on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "missed">
		<cfset email_title = "Missed lesson">
		<cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "confirm">
		<cfset email_title = "Lesson booked">
		<cfset email_subtitle = "#dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "na">
		<cfset email_title = "1st lesson booked">
		<cfset email_subtitle = "#dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "na_done">
		<cfset email_title = "You had your first lesson with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "We hope you enjoyed it. Your training program is available and from now on, you can book your lessons on your own.">
	<cfelseif status eq "pta_done">
		<cfset email_title = "You had your Post Training Assessment with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Thank you for choosing WEFIT and for all your hard work. We hope that you enjoyed your training with us!">
		<cfset email_footer = "Click on the link below to get access to your lesson note.">
	<cfelseif status eq "test_done">
		<cfset email_title = "You had a Test Lesson with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Thank you for choosing WEFIT! We hope that you enjoyed your lesson!">
		<cfset email_footer = "Click on the link below to get access to your lesson note.">
	<cfelseif status eq "pta_booked">
		<cfset email_title = "Post Training Assessment booked with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "This is the last lesson with us. We hope that you enjoyed your training!">
	<cfelseif status eq "test_booked">
		<cfset email_title = "Test lesson booked with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "">
	<cfelseif status eq "cancel">
		<cfset email_title = "Lesson cancelled">
		<cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# is cancelled">
	<cfelseif status eq "complete">
		<cfset email_title = "Your lesson note is available">
		<cfset email_subtitle = "#get_lesson.trainer_firstname# filled your lesson note - Lesson done on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')#.">
		<cfset email_footer = "Click on the link below to get access to your lesson note.">
	<cfelseif status eq "force_cancel_by_learner">
		<cfset email_title = "Lesson cancellation">
		<cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# is now cancelled.">
		<cfset email_footer = "Unfortunately, this lesson will now be considered as missed because you have cancelled it too late.
<br><br>
In the future so as not to lose any training hours, visio lessons must be cancelled more than 6 hours before the lesson is due to start and more than 48 hours before for face to face lessons.
<br><br>
Please click on the button below to rebook your visio lesson.">
	<cfelseif status eq "force_cancel_by_trainer">
		<cfset email_title = "Late cancellation">
		<cfset email_subtitle = "Lesson initially scheduled on #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# is cancelled. Our apologies.">
	</cfif>

	<cfset th_detail = "DETAILS">
	<cfset th_trainer = "Trainer">
	<cfset th_learner = "Learner">
	<cfset th_date = "Date">
	<cfset th_hour = "Hour">
	<cfset th_duration = "Duration">
	<cfset th_cat = "Lesson type">
	<cfset th_title = "Lesson title">
	
	<cfset date_lesson = dateformat(get_lesson.lesson_start,'yyyy/mm/dd')>
	
	<cfif recipient eq "learner">
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "GO TO WEFIT LMS">
	<cfelseif recipient eq "trainer">
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "GO TO WEFIT LMS">
	<cfelse>
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "WEFIT LMS">
	</cfif>
	
<cfelseif isdefined("lang") AND lang eq "de">

	<cfif status eq "reminder">
		<cfset email_title = "Erinnerung">
		<cfset email_subtitle = "Sie haben einen neuen Kurs gebucht am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr">
	<cfelseif status eq "missed">
		<cfset email_title = "Kurs verpasst">
		<cfset email_subtitle = "Der gebuchte Kurs am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr wurde verpasst">
	<cfelseif status eq "confirm">
		<cfset email_title = "Kurs gebucht">
		<cfset email_subtitle = "am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr">
	<cfelseif status eq "na">
		<cfset email_title = "1. Kurs gebucht">
		<cfset email_subtitle = "#dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr">
	<cfelseif status eq "pta_done">
		<cfset email_title = "Sie haben Ihr Post Training Assessment mit #get_lesson.trainer_firstname# absolviert.">
		<cfset email_subtitle = "Vielen Dank, dass Sie sich für WEFIT entschieden haben. Wir hoffen, dass Ihnen Ihr Taining mit uns gefallen hat.">
		<cfset email_footer = "Bitte loggen Sie sich ein, um Ihre Lesson Notes einzusehen.">
	<cfelseif status eq "test_done">
		<cfset email_title = "You had a Test Lesson with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Thank you for choosing WEFIT! We hope that you enjoyed your lesson!">
		<cfset email_footer = "Click on the link below to get access to your lesson note.">
	<cfelseif status eq "pta_booked">
		<cfset email_title = "Post Training Assessment mit #get_lesson.trainer_firstname# gebucht">
		<cfset email_subtitle = "Dies ist Ihr letzter Kurs mit uns. Wir hoffen, dass Ihnen Ihr Training mit WEFIT gefallen hat.">
	<cfelseif status eq "test_booked">
		<cfset email_title = "Test lesson booked with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "">
	<cfelseif status eq "na_done">
		<cfset email_title = "Sie hatten Ihren ersten Kurs mit #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Wir hoffen, Ihre Erwartungen wurden erf&uuml;llt. Ihr Trainingsprogramm ist jetzt verf&uuml;gbar, Sie k&ouml;nnen Ihre n&auml;chsten Kurse buchen.">
	<cfelseif status eq "cancel">
		<cfset email_title = "Kurs storniert">
		<cfset email_subtitle = "Der gebuchte Kurs am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr ist storniert.">
	<cfelseif status eq "complete">
		<cfset email_title = "WEFIT | Ihre Lesson Notes sind jetzt verfügbar">
		<cfset email_subtitle = "#get_lesson.trainer_firstname# hat Ihre Lesson Notes hochgeladen - Kurs absolviert am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr.">
		<cfset email_footer = "<p style='font-size:12px' align='center'>Neu! Um unseren Service kontinuierlich zu verbessern, laden wir Sie ein, die Qualität Ihres Kurses zu bewerten.<br> Es dauert nur eine Minute.</p>
		<br>
		<p align='center'>Bitte loggen Sie sich ein, um Ihre Lesson Notes einzusehen.</p>
		">
	<cfelseif status eq "force_cancel_by_learner">
		<cfset email_title = "Kurs storniert">
		<cfset email_subtitle = "Der gebuchte Kurs am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr ist nun storniert.">
		<cfset email_footer = "Wir sind leider gezwungen, diesen Kurs als fehlgeschlagen zu betrachten. Dieser wird von Ihren Gutschriften abgezogen, da die Absagefrist nicht eingehalten wurde (6 Uhr bei Videokonferenzen, 48 Uhr bei persönlichen Gegenkursen)
		
<br><br>
Wir erinnern Sie daran, dass Sie einen gebuchten Kurs auf zwei Arten umprogrammieren oder stornieren k&ouml;nnen:
<br>
- &Uuml;ber Ihr pers&ouml;nliches Profil auf der WEFIT Plattform: Stornieren Sie Ihren Kurs bis zu 6 Stunden vor Beginn (Videoconference), 48 Stunden vor Beginn (Face to Face), direkt in Ihrem Kalender.<br>
<br><br>
Bitte z&ouml;gern Sie nicht, diesen Kurs erneut zu buchen!">
	<cfelseif status eq "force_cancel_by_trainer">
		<cfset email_title = "Stornierung eines Kurses">
		<cfset email_subtitle = "Der gebuchte Kurs am #dateformat(get_lesson.lesson_start,'dd.mm.yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# Uhr wurde abgesagt. Wir entschuldigen uns f&uuml;r diese Unannehmlichkeit.">
	</cfif>

	<cfset th_detail = "DETAILS">
	<cfset th_trainer = "Trainer">
	<cfset th_learner = "Lerner">
	<cfset th_date = "Datum">
	<cfset th_hour = "Uhrzeit">
	<cfset th_duration = "Dauer">
	<cfset th_cat = "Art des Kurses">
	<cfset th_title = "Kurstitel">
	
	<cfset date_lesson = "#dateformat(get_lesson.lesson_start,'dd.mm.yyyy')#">
	
	<cfif recipient eq "learner">
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "Zum WEFIT LMS">
	<cfelseif recipient eq "trainer">
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "Zum WEFIT LMS">
	</cfif>
	
<cfelse>

	<cfif status eq "reminder">
		<cfset email_title = "Rappel automatique">
		<cfset email_subtitle = "Vous avez cours le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "missed">
		<cfset email_title = "Cours manqu&eacute;">
		<cfset email_subtitle = "Cours pr&eacute;vu le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "confirm">
		<cfset email_title = "Confirmation de r&eacute;servation">
		<cfset email_subtitle = "Le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "na">
		<cfset email_title = "R&eacute;servation 1er cours">
		<cfset email_subtitle = "Le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')#">
	<cfelseif status eq "na_done">
		<cfset email_title = "Votre premier cours a eu lieu avec #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Nous esp&eacute;rons que celui-ci a r&eacute;pondu &agrave; vos attentes. Nous vous souhaitons bonne route !">
	<cfelseif status eq "pta_done">
		<cfset email_title = "Vous avez eu votre dernier cours avec #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Merci d'avoir choisi WEFIT ! Nous esp&eacute;rons que vous avez atteint vos objectifs et pass&eacute; un bon moment avec notre &eacute;quipe !">
		<cfset email_footer = "Cliquez sur le lien ci-dessous pour acc&eacute;der &agrave; votre rapport de formation.">
	<cfelseif status eq "test_done">
		<cfset email_title = "Vous avez eu un cours Test avec #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Merci de faire confiance à WEFIT! Nous esp&eacute;rons que tout s'est bien pass&eacute; !">
		<cfset email_footer = "Cliquez sur le lien ci-dessous pour acc&eacute;der &agrave; votre rapport de formation.">
	<cfelseif status eq "pta_booked">
		<cfset email_title = "Votre dernier cours avec #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "Il s'agit du derniers cours de votre parcours de formation (Post Training Assessement) ! Nous esp&eacute;rons que vous &ecirc;tes satisfait du travail accompli !">
	<cfelseif status eq "test_booked">
		<cfset email_title = "Test lesson booked with #get_lesson.trainer_firstname#">
		<cfset email_subtitle = "">
	<cfelseif status eq "cancel">
		<cfset email_title = "Annulation cours">
		<cfset email_subtitle = "Le cours pr&eacute;vu le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')# a &eacute;t&eacute; annul&eacute;">
	<cfelseif status eq "complete">
		<cfset email_title = "Compte rendu de cours disponible">
		<cfset email_subtitle = "#get_lesson.trainer_firstname# a finalis&eacute; le compte rendu de votre cours du #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')#.">
		<cfset email_footer = "
		<p style='font-size:12px' align='center'>Afin d'améliorer nos services, nous vous invitons à évaluer la qualité de votre cours, cela ne prendra qu'une minute !</p>
		<br>
		<p align='center'>Cliquez sur le lien ci-dessous pour acc&eacute;der &agrave; votre rapport de cours.</p>
		">
	<cfelseif status eq "force_cancel_by_learner">
		<cfset email_title = "Annulation de cours hors d&eacute;lai">
		<cfset email_subtitle = "Nous confirmons que le cours pr&eacute;vu le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')# a &eacute;t&eacute; annul&eacute;.">
		<cfset email_footer = "Nous sommes malheureusement contraints de consid&eacute;rer ce cours comme manqu&eacute;. Celui-ci sera d&eacute;duit de vos cr&eacute;dits car le d&eacute;lai d'annulation n'a pas &eacute;t&eacute; respect&eacute; (6 heures pour les cours en visioconf&eacute;rence, 48 heures pour les cours en face &agrave; face).
<br><br>
Nous vous rappelons que vous pouvez annuler un cours via votre espace personnel WEFIT : rendez-vous sur votre calendrier, et annulez &agrave; l'aide du bouton correspondant, dans le d&eacute;lai mentionn&eacute; ci-dessus.
<br><br>
N'h&eacute;sitez pas &agrave; reprogrammer ce cours !  
">
	<cfelseif status eq "force_cancel_by_trainer">
		<cfset email_title = "Annulation de cours hors d&eacute;lai">
		<cfset email_subtitle = "Le cours pr&eacute;vu le #dateformat(get_lesson.lesson_start,'dd/mm/yyyy')# &agrave; #timeformat(get_lesson.lesson_start,'HH:mm')# a &eacute;t&eacute; annul&eacute;. Nous sommes sinc&egrave;rement d&eacute;sol&eacute;s pour ce d&eacute;sagr&eacute;ment.">
	</cfif>

	<cfset th_detail = "D&Eacute;TAILS">
	<cfset th_trainer = "Formateur">
	<cfset th_learner = "Apprenant">
	<cfset th_date = "Date">
	<cfset th_hour = "Heure">
	<cfset th_duration = "Dur&eacute;e">
	<cfset th_cat = "Type de cours">
	<cfset th_title = "Intitul&eacute;">
	
	<cfset date_lesson = dateformat(get_lesson.lesson_start,'dd/mm/yyyy')>
	
	<cfif recipient eq "learner" and (status eq "complete" or status eq "na_done" or status eq"pta_done" or status eq "test_done")>
		<cfset btn_href = "https://lms.wefitgroup.com/common_tp_details.cfm?go_l_id=#get_lesson.lesson_id#&t_id=#get_lesson.tp_id#&go_rating=1">
		<cfset btn_lms = "Acc&egrave;s WEFIT LMS">
	<cfelseif recipient eq "trainer">
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "Acc&egrave;s WEFIT LMS">
	<cfelseif recipient eq "learner">
		<cfset btn_href = "https://lms.wefitgroup.com/common_tp_details.cfm">
		<cfset btn_lms = "Acc&egrave;s WEFIT LMS">
	<cfelse>
		<cfset btn_href = "https://lms.wefitgroup.com">
		<cfset btn_lms = "WEFIT LMS">
	</cfif>

	
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
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
								<p style="margin: 0 0 10px;">
									<table width="100%" cellpadding="5">
										<tr>
											<th bgcolor="#F3F3F3"><cfoutput>#th_detail#</cfoutput></th>
										</tr>
									</table>
									<table width="100%" cellpadding="5">
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_trainer#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.trainer_firstname#</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_learner#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.learner_firstname# #get_lesson.learner_lastname#</cfoutput>
											</td>
										</tr>
										<!---<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;">Compte</td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.account_name#</cfoutput>
											</td>
										</tr>--->
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_date#</cfoutput></td>
											<td width="75%" style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#date_lesson#</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_hour#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>
											<cfif isdefined("lang") AND lang eq "de"> Uhrzeit</cfif>
											#timeformat(get_lesson.lesson_start,'HH:mm')# - #timeformat(get_lesson.lesson_end,'HH:mm')#
											<cfif isdefined("lang") AND lang eq "de"> Uhr</cfif>
											</cfoutput>
											
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_duration#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.lesson_duration# min</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_cat#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.cat_name#</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_title#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.sessionmaster_name#</cfoutput>
											</td>
										</tr>
									</table>
								</p>
							</td>
                        </tr>
						<cfif isdefined("email_footer")>
						<tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
								<h5 style="margin: 0 0 10px; font-size: 13px; line-height: 125%; color: #333333; font-weight: normal; text-align:left">
								<cfoutput>#email_footer#</cfoutput>
								</h5>
							</td>
						</tr>
						</cfif>
                        <tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                                <!-- Button : BEGIN -->
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

										     <a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput></span></a>

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
		
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>


</cfif>