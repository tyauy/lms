<cfsilent>
	<cfparam name="lang" default="en">

	<cfset th_detail = #obj_translater.get_translate('global_details', lang)#>
	<cfset th_trainer = #obj_translater.get_translate('table_th_trainer', lang)#>
	<cfset th_learner = #obj_translater.get_translate('table_th_learner', lang)#>
	<cfset th_date = #obj_translater.get_translate('table_th_date', lang)#>
	<cfset th_hour = #obj_translater.get_translate('table_th_time', lang)#>
	<cfset th_duration = #obj_translater.get_translate('table_th_duration_short', lang)#>
	<cfset th_title = #obj_translater.get_translate('table_th_course', lang)#>
	<cfset th_login = obj_translater.get_translate(id_translate="table_th_login",lg_translate="#lang#")>
	<cfset th_url = obj_translater.get_translate(id_translate="table_th_url",lg_translate="#lang#")>
	<cfset th_email = obj_translater.get_translate(id_translate="form_subscription_2",lg_translate="#lang#")>
	<cfset th_temp_pwd = obj_translater.get_translate(id_translate="table_th_tmp_pwd",lg_translate="#lang#")>
	<cfset th_pwd = obj_translater.get_translate(id_translate="form_label_password",lg_translate="#lang#")>
	<cfset th_pwd_explain = obj_translater.get_translate_complex(id_translate="mail_pwd_explain",lg_translate="#lang#")>
	<cfset th_prompt = obj_translater.get_translate_complex(id_translate="new_mail_prompt",lg_translate="#lang#")>
	<cfset btn_connect = obj_translater.get_translate(id_translate="btn_connect",lg_translate="#lang#")>
	<cfset th_formation = obj_translater.get_translate(id_translate="sidemenu_learner_formation",lg_translate="#lang#")>
	<cfset th_tp = obj_translater.get_translate(id_translate="table_th_program_short",lg_translate="#lang#")>
	<cfset __min = #obj_translater.get_translate('short_minute', lang)#>

	<cfset email_title = "">
	<cfset email_subtitle = "">

	<cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT lesson_id, lesson_start, l.planner_id, u.user_firstname 
		FROM lms_lesson2 l 
		INNER JOIN user u ON u.user_id = l.planner_id 
		WHERE l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW() ORDER BY lesson_start DESC LIMIT 1
	</cfquery>

	<cfif get_tp.tp_completed eq ""><cfset tp_completed = 0><cfelse><cfset tp_completed = get_tp.tp_completed></cfif>
	<cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled = 0><cfelse><cfset tp_scheduled = get_tp.tp_scheduled></cfif>
	<cfif get_tp.tp_missed eq ""><cfset tp_missed = 0><cfelse><cfset tp_missed = get_tp.tp_missed></cfif>
	<cfset tp_left = (get_tp.tp_duration - tp_completed - tp_missed - tp_scheduled)>
	<cfset tp_left_txt = obj_lms.get_format_hms(toformat="#tp_left#",unit="min")>
				
	<!--- LIST OF LESSON + TRAINER --->
	<cfquery name="get_lessons" datasource="#SESSION.BDDSOURCE#">
	SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.planner_id, l.lesson_duration,
	u.user_firstname
	FROM lms_lesson2 l
	INNER JOIN user u ON u.user_id = l.planner_id
	WHERE l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	ORDER BY l.planner_id, l.lesson_start
	</cfquery>

	<!--------------------------------- H1 HELLO MESSAGE ------------------------>
	<cfif lang eq "fr">    

		<cfset email_title = "Bonjour #get_user.user_firstname#">
		
	<cfelseif lang eq "en">
		
		<cfset email_title = "Hi #get_user.user_firstname#">

	<cfelseif lang eq "de">

		<cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
			<cfset email_title = "Lieber Herr #get_user.user_firstname#">
		<cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
			<cfset email_title = "Liebe Frau #get_user.user_firstname#">
		<cfelse>
			<cfset email_title = "Guten tag #get_user.user_firstname#">
		</cfif>

	<cfelseif lang eq "es">
		
		<cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
			<cfset email_title = "Estimado #get_user.user_firstname#">
		<cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
			<cfset email_title = "Estimada #get_user.user_firstname#">
		<cfelse>
			<cfset email_title = "Estimado #get_user.user_firstname#">
		</cfif>

	<cfelseif lang eq "it">
				
		<cfset email_title = "Buongiorno #get_user.user_firstname#">

	</cfif>


	<!--------------------------------- TEMPLATE 1 ------------------------>
	<cfif lang eq "fr">

		<cfset email_subtitle = "Vous avez effectué le lancement de votre formation.<br><strong>Bienvenue à bord !</strong>">

		<cfset email_content = "<br><br>Apprendre une langue étrangère est une aventure à part entière, dans laquelle nous sommes présents pour vous accompagner et vous guider à chaque pas.<br>
		Chez WEFIT nos fabuleux formateurs vous aideront à atteindre et surpasser vos objectifs d'apprentissage linguistique.<br>
		Notre équipe du Service Client se fera un plaisir de répondre à toutes vos questions. <br><br>

		Voici un rappel des cours que vous avez réservés :<br><br>
		">
		
	<cfelseif lang eq "en">

		<cfset email_content = "Hi #get_user.user_firstname#<br><br>
		Learning a language is an exciting adventure and we are here to support you every step of the way.<br>
		At WEFIT our experienced trainers are dedicated to helping you achieve your learning goals 
		and our Customer Service team are on hand to answer any questions you may have.<br><br>

		You schedule of lessons booked so far :<br><br>
		">
			
	<cfelseif lang eq "de">
		

		<cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
			<cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
		<cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
			<cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
		<cfelse>
			<cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
		</cfif>
		<cfset email_content = email_content & "
		Ihre letzte Stunde mit #get_last_lesson.user_firstname# war am #lsdateformat(get_last_lesson.lesson_start, "dd-mm-yyyy", 'fr')#. <br>
		Sie haben noch #tp_left# Stunden in Ihrem Trainingsprogramm zu absolvieren.<br><br>

		Wir wissen, dass es nicht immer einfach ist, Ihre Verfügbarkeiten sowie die Ihrer Trainer zu vereinbaren.<br>
		Hier ein paar Tipps:<br>

		<ul>
			<li>
				1 - Reservieren Sie Ihre Kurse frühzeitig<br>
			</li>
			<li>
				2 - Fügen Sie einen weiteren Trainer hinzu<br>
			</li>
			<li>
				3 - Kontaktieren Sie uns per Email, Chat oder Telefonanruf, um die Dauer der Kurse anzupassen, sodass Sie Ihr Fristende einhalten können<br>
			</li>
		</ul>

		Wir freuen uns, von Ihnen zu hören.<br><br>

		Mit freundlichem Gruß<br>

		">
		
	<cfelseif lang eq "es">

		<cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
			<cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
		<cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
			<cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
		<cfelse>
			<cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
		</cfif>
		<cfset email_content = email_content & "
		Su última lección con #get_last_lesson.user_firstname# fue el #lsdateformat(get_last_lesson.lesson_start, "dd-mm-yyyy", 'fr')#. <br>
		Aún le queda #tp_left# horas para programar. <br><br>

		Sabemos que encontrar disponibilidad con sus formadores que coincidan con su agenda no es tarea fácil. <br>
		Es por esto que aquí le damos algunos consejos :<br>

		<ul>
			<li>
				1 - Reserve sus clases con antelación<br>
			</li>
			<li>
				2 - Añada un formador desde su espacio personal <br>
			</li>
			<li>
				3 - Cambie la duración de sus clases con un simple email, a través del chat o con una llamada para conseguir llegar a su fecha límite. <br>
			</li>
		</ul>
		Cordialmente, <br><br>

		¡Le deseamos que tenga un buen día!<br>
		">

	<cfelseif lang eq "it">

		<cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
		Speriamo che tu stia trascorrendo una giornata produttiva. Desideriamo informarti che la tua ultima lezione si è tenuta il #tp_left# con #lsdateformat(get_last_lesson.lesson_start, "dd-mm-yyyy", 'fr')#. È un piacere avere la possibilità di supportarti nel tuo percorso di apprendimento.<br>
		Riconosciamo che coordinare e conciliare le tue esigenze con gli insegnanti può essere una sfida. Per questo motivo, abbiamo preparato per te una lista di utili suggerimenti:<br>
		<ul>
			<li>
				Prenota le lezioni in anticipo:in questo modo, avrai la sicurezza di avere un posto riservato. Ricorda che, se necessario, potrai disdire una lezione fino a 6 ore prima dell'appuntamento senza perderla.<br>
			</li>
			<li>
				Aggiungi insegnanti al tuo profilo: se desideri ottenere una prospettiva più ampia e diversificata, hai la possibilità di aggiungere uno o più insegnanti al tuo profilo. Puoi avere fino a un massimo di 3 insegnanti contemporaneamente, questo ti consentirà di beneficiare di differenti approcci didattici, se desiderato diversi accenti e più flessibilità a livello di orari.<br>
			</li>
			<li>
				Modifica la durata delle lezioni: comprendiamo che le tue esigenze potrebbero cambiare nel tempo. Per adattare il corso alle tue necessità, è sufficiente inviare un'e-mail o contattare il nostro Servizio Clienti telefonicamente. Saremo lieti di assisterti nella modifica della durata delle lezioni secondo le tue preferenze.<br>
			</li>
		</ul>
		Ci auguriamo che questi consigli ti siano utili per gestire al meglio il tuo percorso di apprendimento. Se hai bisogno di ulteriori informazioni o assistenza, non esitare a contattarci. Siamo qui per supportarti.<br>
		Ti auguriamo un'ottima giornata e un proficuo proseguimento delle tue lezioni!<br><br>

		Cordiali saluti,<br>
		">
	</cfif>
	
</cfsilent>
	
		
		
	<!DOCTYPE html>
	<html lang="<cfoutput>#lang#</cfoutput>" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
	<head>
		<cfinclude template="incl_email_meta2.cfm">
	</head>
	<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: #FAFAFA;">
		<center style="width: 100%; background-color: #FAFAFA; text-align: left;">
			
		<cfinclude template="incl_email_header2.cfm">
				
			<tr>
				<td style="background-color: #ffffff; padding: 20px 30px 0px 30px;">
					<table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
						<tr>
							<td style="font-size: 15px; color: #333333; font-weight: normal;">
								<h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 17px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
								
								<cfoutput>#email_content#</cfoutput>
							</td>
						</tr>
					
						<tr>
							<td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
								<cfoutput query="get_lessons" group="planner_id">

									<table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: ##ffffff;">
										<tr>
											<td width="20%" align="center">
												<img src="#SESSION.BO_ROOT_URL#/assets/user/#planner_id#/photo.jpg" width="50" title="#user_firstname#" style="border-radius:50%; border:2px solid ##CE1D37 !important;">
												<br>
												#user_firstname#
											</td>
											<td width="80%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: ##252422;">
												<cfoutput>
													#obj_function.get_dateformat(lesson_start)# - #lesson_duration# #__min# <br>
												</cfoutput>
											</td>
										</tr>
									</table>

								</cfoutput>
							</td>
						</tr>
	
						<cfif get_tps.recordCount GT 0>
						<tr>
							<td style="margin: 30px 0 10px; color: #555555;">
								<table width="100%" cellpadding="5" style="border:1px solid #ECECEC; color: #555555;">
									<tr>
										<th bgcolor="#F3F3F3"><cfoutput>#th_tp#</cfoutput></th>
									</tr>
								</table>
								<table width="100%" cellpadding="5" style="border-top:0px; border-left:1px solid #ECECEC; border-right:1px solid #ECECEC; border-bottom:1px solid #ECECEC; color: #555555;">
									<cfoutput query="get_tps">
										<cfif method_id eq "3">
											<cfset access_el = "1">
										<cfelseif method_id eq "2">
											<cfset access_f2f = "1">
										<cfelseif method_id eq "1">
											<cfset access_visio = "1">
										</cfif>
										<tr>
											<td width="35%" style="font-size: 13px;">
											#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#",lg_translate="#lang#")#
											</td>
											<td width="65%" style="font-size: 13px;">
											<cfif tp_date_start neq "">
												<cfset limit_date_start = obj_dater.get_dateformat(tp_date_start)>
											<cfelse>
												<cfset limit_date_start = obj_dater.get_dateformat(order_start)>
											</cfif>
											
											<cfif tp_date_end neq "">
												<cfset limit_date_end = obj_dater.get_dateformat(tp_date_end)>
											<cfelse>
												<cfset limit_date_end = obj_dater.get_dateformat(order_end)>
											</cfif>
									
											<cfset arr = ['limit_date_start', 'limit_date_end']>
											<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
											#obj_translater.get_translate_complex(id_translate="order_end_reminder", argv="#argv#",lg_translate="#lang#")#
											</td>
										</tr>
									</cfoutput>
								</table>
							</td>
						</tr>
						</cfif>
						<tr>
							<td style="padding: 20px 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
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
					
	
			<cfinclude template="incl_email_footer2.cfm">
			
		<!--[if mso | IE]>
		</td>
		</tr>
		</table>
		<![endif]-->
		</center>
	</body>
	</html>