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

<cfset email_title = "">
<cfset email_subtitle = "">

<cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
    SELECT lesson_id, lesson_start, l.planner_id, u.user_firstname FROM lms_lesson2 l INNER JOIN user u ON u.user_id = l.planner_id WHERE l.tp_id = #t_id# AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW() ORDER BY lesson_start DESC LIMIT 1
</cfquery>

<cfif get_tp.tp_completed neq "">
<cfset tp_left = (get_tp.tp_duration - get_tp.tp_completed) / 60>
<cfelse>
    <cfset tp_left = get_tp.tp_duration / 60>
</cfif>

<cfif lang eq "fr">
    <cfif template eq "linguaskill_b2b">
        <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>

        Félicitations, il est l'heure de passer votre certification Linguaskill pour valider le niveau de votre formation!<br><br>

        Il vous reste une dernière étape, nous communiquer dès à présent vos disponibilités!<br><br>

        Bon à savoir :<br>

        <ul>
            <li>
                Ce test s'effectue en ligne<br>
            </li>
            <li>
                Durée 1h30 <br>
            </li>
            <li>
                Évaluation de votre niveau de compréhension écrite et orale sur le Cadre Européen Commun de Référence pour les Langues!<br>
            </li>
        </ul>

        Votre inscription sera effective sous 24 heures, vous recevrez un email de confirmation. Si vous n'avez rien reçu dans ce délai nous vous invitons à consulter vos courriers indésirables ou nous appeler<br><br>

        En vous remerciant par avance pour votre retour, nous vous souhaitons une agréable journée.<br><br>

        Bien cordialement,<br>
        ">
    <cfelseif template eq "linguaskill_cpf">
        <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>

        Félicitations, il est l'heure de passer votre certification Linguaskill Business pour valider le niveau de votre formation!<br><br>
        
        Communiquez-nous dès maintenant vos disponibilités pour préparer votre inscription aux 3 modules :<br>
        
        <ul>
            <li>
                - Listening et Reading<br>
            </li>
            <li>
                - Speaking<br>
            </li>
            <li>
                - Writing<br>
            </li>
        </ul>
        
        Votre inscription sera effective sous 24 heures, vous recevrez un email de confirmation. Si vous n'avez rien reçu dans ce délai nous vous invitons à consulter vos courriers indésirables ou nous appeler<br><br>
        
        Cordialement,<br>
        ">
    <cfelseif template eq "bright_cpf">
        <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>
        Félicitations, il est l'heure de passer votre certification Bright qui évaluera votre niveau sur le Cadre Européen Commun de Référence pour les Langues!<br><br>
        
        <ul>
            <li>
                Test en ligne supervisé à distance via BRIGHT SECURE.<br>
            </li>
            <li>
                Durée : environ 1h<br>
            </li>
            <li>
                de 0 à 5 Validité : 2 ans<br>
            </li>
            <li>
                Votre certification au format PDF sera disponible dans les 7 jours suivant l'examen<br>
            </li>
        </ul>
        Afin de vous inscrire, communiquez-nous les informations suivantes :<br>
        
        <ul>
            <li>
                - Date souhaitée  <br>
            </li>
            <li>
                - Votre Genre <br>
            </li>
            <li>
                - Nom de naissance <br>
            </li>
            <li>
                - Date de naissance <br>
            </li>
            <li>
                - Lieu de naissance (ville + code postal)<br>
            </li>
        </ul>
        
        Votre inscription sera effective sous 24 heures, vous recevrez un email de confirmation. Si vous n'avez rien reçu dans ce délai nous vous invitons à consulter vos courriers indésirables ou nous appeler<br><br>
        
        Cordialement,<br>
        ">
    <cfelseif template eq "toeic">
        <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>

        Félicitations, il est l'heure de passer votre certification TOEIC qui évaluera votre niveau sur le Cadre Européen Commun de Référence pour les Langues!  <br><br>
        
        Délai de 15 jours ouvrés pour vous inscrire.<br><br>
        
        2 Tests TOEIC sont disponibles :<br>
        <ul>
            <li>
                Le test TOEIC en centre<br>
            </li>
            <li>
                Durée : 2h. <br>
            </li>
            <li>
                Certification délivrée à la fin du test dans les 15 jours ouvrés.<br>
            </li>
        </ul>
        
        <ul>
            <li>
                Le TOEIC à passer en ligne. <br>
            </li>
            <li>
                Durée : 1h30. <br>
            </li>
            <li>
                Attestation de passage délivrée dans les 15  jours ouvrés.<br>
            </li>
        </ul>
        Afin de vous inscrire, communiquez-nous les informations suivantes :<br>
        
        <ul>
            <li>
                - Date souhaitée  <br>
            </li>
            <li>
                - Date de naissance <br>
            </li>
            <li>
                - Académie / Ville souhaités pour le passage en centre : <br>
            </li>
        </ul>
        
        Cordialement,        <br>
        ">

    </cfif>
<cfelseif lang eq "en">
    <cfif template eq "linguaskill_b2b">
        <cfset email_content = "Hello #get_user.user_firstname#<br><br>

        Congratulations, it is now time to take your Linguaskill exam to validate your language level!
        
        There is just one final step, let us know your availability!
        
        Good to know:
        <ul>
            <li>
                - Date souhaitée  <br>
            </li>
            <li>
                - Date de naissance <br>
            </li>
            <li>
                - Académie / Ville souhaités pour le passage en centre : <br>
            </li>
        </ul>
        The test is 100% online
        Duration: 1h30 
        This exam will evaluate your reading and listening skills based on the Common European Framework of Reference
        
        Your registration will take effect within 24 hours, and you will receive a confirmation email.  If you haven’t received anything and the email is not in your junk folder please contact us.
        
        If you have any questions please free to contact us
        
        Thanks
        

        ">
    <cfelseif template eq "linguaskill_cpf">
        <cfset email_content = "Hello #get_user.user_firstname#<br><br>

        Congratulations, it is now time to take your Linguaskill Business exam to validate your language level!<br><br>
        
        Let us know your availability now to prepare your registration for the 3 modules:<br>
        <ul>
            <li>
                - Listening and Reading<br>
            </li>
            <li>
                - Speaking<br>
            </li>
            <li>
                - Writing<br>
            </li>
        </ul>
        
        Your registration will take effect within 24 hours, and you will receive a confirmation email.  If you haven't received anything and the email is not in your junk folder please contact us<br><br>
        
        
        If you have any questions please free to contact us<br><br>
        
        Thanks<br>
        

        ">
    <cfelseif template eq "bright_cpf">
        <cfset email_content = "Hello #get_user.user_firstname#<br><br>

        Congratulations, it is now time to take your Linguaskill Business exam to validate your language level on the Common European Framework of Reference for languages!<br><br>
        
        
        Supervised online test via BRIGHT SECURE.<br>
        <ul>
            <li>
                Duration: approx. 1 hour<br>
            </li>
            <li>
                from 0 to 5 Validity: 2 years<br>
            </li>
            <li>
                To register, please provide us with the following information:<br>
            </li>
        </ul>
        To register, please provide us with the following information:<br>
        <ul>
            <li>
                - Preferred date  <br>
            </li>
            <li>
                - Your gender <br>
            </li>
            <li>
                - Birth name <br>
            </li>
            <li>
                - Date of birth <br>
            </li>
            <li>
                - Place of birth (city + postcode)<br>
            </li>
        </ul>
        
        Your registration will take effect within 24 hours, and you will receive a confirmation email.  If you haven't received anything and the email is not in your junk folder please contact us<br><br>
        
        Thanks<br>
        

        ">
    <cfelseif template eq "toeic">
        <cfset email_content = "Hello #get_user.user_firstname#<br><br>

        Congratulations, it is now time to take your TOEIC exam to validate your language level on the Common European Framework of Reference for languages!<br><br>
        
        You have 15 days to register<br><br>
        
        There are 2 ways to take the TOEIC exam:<br>
        <ul>
            <li>
                At a TOEIC test center<br>
            </li>
            <li>
                Duration: 2 hours<br>
            </li>
            <li>
                Certificate issued within 15 working days<br>
            </li>
        </ul>
        <ul>
            <li>
                TOEIC exam online <br>
            </li>
            <li>
                Duration: 1 hour <br>
            </li>
            <li>
                Certificate issued within 15 working days<br>
            </li>
        </ul>
        To register, please provide us with the following information:<br>
        <ul>
            <li>
                - Date you want to take the test<br>
            </li>
            <li>
                - Your birthdate <br>
            </li>
            <li>
                - Academy  / Town of the exam centre<br>
            </li>
        </ul>
        
        
        Thanks <br>
        
        ">

    </cfif>
<cfelseif lang eq "de">
    <cfif template eq "linguaskill_b2b">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "
        Herzlichen Glückwunsch, es ist Zeit Ihre LINGUASKILL-Zertifizierung durchzuführen, um Ihr Sprachniveau festzustellen.<br><br>

        Bitte teilen Sie uns dazu einfach Ihre Verfügbarkeiten mit!<br><br>
        
        Gut zu wissen:<br>
        <ul>
            <li>
                Dieser Test findet online statt.<br>
            </li>
            <li>
                Dauer: 1,5 Stunden<br>
            </li>
            <li>
                Prüfung des Leseverstehens und Hörverstehens nach dem Gemeinsamen Europäischen Referenzrahmen<br>
            </li>
        </ul>
        
        Ihre Einschreibung wird innerhalb von 24 Stunden wirksam und Sie werden eine Bestätigungsmail erhalten. Sollten Sie nach dieser Zeit keine Email erhalten haben, überprüfen Sie bitte Ihren Spamordner oder rufen Sie uns an.<br><br>
        
        
        Wir wünschen Ihnen gutes Gelingen.<br>
        Mit freundlichem Gruß,<br>
        

        ">
    <cfelseif template eq "linguaskill_cpf">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "

        Herzlichen Glückwunsch, es ist Zeit Ihre Zertifizierung “Linguaskill Business” durchzuführen, um Ihr Sprachniveau festzustellen.<br><br>

        Teilen Sie uns dazu einfach Ihre Verfügbarkeiten mit, sodass wir Ihre Einschreibung für die 3 Module vorbereiten können:  <br>
        <ul>
            <li>
                - Hörverstehen und Leseverstehen<br>
            </li>
            <li>
                - Sprechen<br>
            </li>
            <li>
                - Schreiben<br>
            </li>
        </ul>
        
        Gut zu wissen:<br>
        <ul>
            <li>
                Dieser Test findet online statt.<br>
            </li>
            <li>
                Dauer: 1,5 Stunden<br>
            </li>
            <li>
                Prüfung des Leseverstehens und Hörverstehens nach dem Gemeinsamen Europäischen Referenzrahmen<br>
            </li>
        </ul>
        
        Ihre Einschreibung wird innerhalb von 24 Stunden wirksam und Sie werden eine Bestätigungsmail erhalten. Sollten Sie nach dieser Zeit keine Email erhalten haben, überprüfen Sie bitte Ihren Spamordner oder rufen Sie uns an.<br><br>
        
        Wir wünschen Ihnen gutes Gelingen für Ihre Sprachzertifizierung.<br><br>
        
        Mit freundlichem Gruß,<br>
        
        ">
    <cfelseif template eq "bright_cpf">


        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "
        Herzlichen Glückwunsch, es ist Zeit Ihre Bright-Zertifizierung durchzuführen, die Ihre Kenntnisse nach den Sprachniveaus des Gemeinsamen Europäischen Referenzrahmen beurteilt.<br><br>

        Gut zu wissen:<br>
        <ul>
            <li>
                Ein überwachter Onlinetest durch  BRIGHT SECURE.<br>
            </li>
            <li>
                Dauer: circa 1 Stunde<br>
            </li>
            <li>
                Gültigkeit : 2 Jahre<br>
            </li>
            <li>
                Ihre Zertifizierung ist innerhalb von 7 Tagen nach der Prüfung im PDF-Format verfügbar <br>
            </li>
        </ul>
        Um Sie zu dieser Prüfung einzuschreiben, senden Sie uns bitte folgende Informationen:<br>
        <ul>
            <li>
                - Bevorzugtes Datum<br>
            </li>
            <li>
                - Ihr Geschlecht<br>
            </li>
            <li>
                - Ihr Geburtsname<br>
            </li>
            <li>
                - Ihr Geburtsdatum <br>
            </li>
            <li>
                - Ihr Geburtsort (Stadt + Postleitzahl)<br>
            </li>
        </ul>
        
        Ihre Einschreibung wird innerhalb von 24 Stunden wirksam und Sie werden eine Bestätigungsmail erhalten. Sollten Sie nach dieser Zeit keine Email erhalten haben, überprüfen Sie bitte Ihren Spamordner oder rufen Sie uns an.<br><br>
        
        Wir wünschen Ihnen gutes Gelingen.<br>
        

        ">
    <cfelseif template eq "toeic">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "
        Herzlichen Glückwunsch, es ist Zeit Ihre TOEIC-Zertifizierung durchzuführen, die Ihre Kenntnisse nach den Sprachniveaus des Gemeinsamen Europäischen Referenzrahmen beurteilt.<br>
        Schreiben Sie sich dazu bitte innerhalb der nächsten zwei Wochen ein!<br><br>
        
        Es gibt 2 Möglichkeiten, Ihre TOEIC-Zertifizierung zu absolvieren:<br>
        <ul>
            <li>
                In einem TOEIC Testzentrum <br>
            </li>
            <li>
                Dauer: 2 Stunden <br>
            </li>
            <li>
                Sie erhalten Ihr Sprachdiplom innerhalb von 15 Werktagen nach dem Test. <br>
            </li>
        </ul>
        oder
        <ul>
            <li>
                Online<br>
            </li>
            <li>
                Dauer: 1,5 Stunden<br>
            </li>
            <li>
                Sie erhalten Ihr Sprachdiplom innerhalb von 15 Werktagen nach dem Test. <br>
            </li>
        </ul>
        Um Sie zu dieser Prüfung einzuschreiben, senden Sie uns bitte folgende Informationen:<br>
        <ul>
            <li>
                - Bevorzugtes Datum<br>
            </li>
            <li>
                - Ihr Geburtsdatum <br>
            </li>
            <li>
                - Die Region oder die Stadt für die Durchführung in einem Testzentrum.<br>
            </li>
        </ul>
        
        Wir wünschen Ihnen gutes Gelingen für Ihre Sprachzertifizierung.<br><br>
        
        Mit freundlichem Gruß,<br>
        ">

    </cfif>
<cfelseif lang eq "es">
    <cfif template eq "linguaskill_b2b">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "

        ¡Enhorabuena! Ha llegado el momento de que pase su certificación Linguaskill para validar el nivel de su formación. <br>
        Solamente le queda una última etapa: ¡comunicarnos su disponibilidad actual!<br><br>
        
        Debe saber que :<br>
        <ul>
            <li>
                Esta prueba se realiza en línea <br>
            </li>
            <li>
                Tiene una duración de 1h30 <br>
            </li>
            <li>
                La evaluación de su nivel de comprensión escrita y oral se establece según el Marco Común Europeo de Referencia para las Lenguas.  <br>
            </li>
        </ul>
        
        Su inscripción será efectiva en 24 horas y recibirá un correo de confirmación. En el caso de no recibir ningún correo pasado ese tiempo, le invitamos a que consulte sus correos no deseados o que se ponga en contacto con nosotros. <br>
        Le agradecemos de antemano su respuesta y le deseamos un buen día. <br><br>
        
        Cordialmente, <br>
        
        ">
    <cfelseif template eq "linguaskill_cpf">
        
        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "

        ¡Enhorabuena! Ha llegado el momento de que pase su certificación Linguaskill Business para validar el nivel de su formación. <br><br>

        Comuníquenos lo antes posible su disponibilidad para preparar su inscripción a los 3 módulos:<br>
        <ul>
            <li>
                - Listening y Reading<br>
            </li>
            <li>
                - Speaking<br>
            </li>
            <li>
                - Writing<br>
            </li>
        </ul>
        
        Su inscripción será efectiva en 24 horas y recibirá un correo de confirmación. En el caso de no recibir ningún correo pasado ese tiempo, le invitamos a que consulte sus correos no deseados o que se ponga en contacto con nosotros. <br>
        Le agradecemos de antemano su respuesta y le deseamos un buen día. <br><br>
        
        Cordialmente, <br>
        

        ">
    <cfelseif template eq "bright_cpf">
        
        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "
        ¡Enhorabuena! Ha llegado el momento de que pase su certificación Bright, la cual evaluará su nivel según el  Marco Común Europeo de Referencia para las Lenguas. <br><br>

        <ul>
            <li>
                Prueba en línea supervisada a distancia por BRIGHT SECURE.<br>
            </li>
            <li>
                Duración: aproximadamente 1 hora. <br>
            </li>
            <li>
                Válidez de 0 a 5  : 2 años<br>
            </li>
            <li>
                Su certificación estará disponible en formato PDF durante los 7 días siguientes al día del examen.<br>
            </li>
        </ul>
        Para inscribirse, comuníquenos los siguientes datos: <br>
        <ul>
            <li>
                - La fecha deseada <br>
            </li>
            <li>
                - Su género<br>
            </li>
            <li>
                - Apellidos <br>
            </li>
            <li>
                - Fecha de nacimiento <br>
            </li>
            <li>
                - Lugar de nacimiento (ciudad y código postal)<br>
            </li>
        </ul>
        
        Su inscripción será efectiva en 24 horas y recibirá un correo de confirmación. En el caso de no recibir ningún correo pasado ese tiempo, le invitamos a que consulte sus correos no deseados o que se ponga en contacto con nosotros. <br>
        Le agradecemos de antemano su respuesta y le deseamos un buen día. <br><br>
        
        Cordialmente, <br>
        

        ">
    <cfelseif template eq "toeic">
        
        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "

        ¡Enhorabuena! Ha llegado el momento de pasar su certificación TOEIC, el cual evaluará su nivel según el Marco Común Europeo de Referencia para las Lenguas.  <br><br>

        Periodo de 15 días hábiles para inscribirse.<br><br>
        
        Hay dos pruebas TOEIC disponibles::<br>
        <ul>
            <li>
                La prueba TOEIC en presencial<br>
            </li>
            <li>
                Duración : 2h. <br>
            </li>
            <li>
                Certificación expedida a los 15 días hábiles tras la realización de la prueba. <br>
            </li>
        </ul>
        <ul>
            <li>
                El TOEIC en línea. <br>
            </li>
            <li>
                Duración : 1h30. <br>
            </li>
            <li>
                Certificado de realización del examen expedido en los 15 días hábiles tras la realización de la prueba. <br>
            </li>
        </ul>
        Para inscribirse, comuníquenos los siguientes datos: <br>
        <ul>
            <li>
                - Fecha en la que desea realizar la prueba <br>
            </li>
            <li>
                - Fecha de nacimiento<br>
            </li>
            <li>
                - Academia / Ciudad en la que desea realizar la prueba de manera presencial. <br>
            </li>
        </ul>
        
        
        Cordialmente,<br>
        
        ">

    </cfif>
<cfelseif lang eq "it">
    <cfif template eq "linguaskill_b2b">
        <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
        Congratulazioni, è finalmente arrivato il momento di sostenere l'esame Linguaskill per convalidare il tuo livello linguistico! Manca solo un ultimo passo: comunicaci la tua disponibilità!<br>
        Ecco alcune informazioni utili:<br>
        <ul>
            <li>
                L'esame si svolge interamente online per la massima comodità.<br>
            </li>
            <li>
                La durata dell'esame è di 85 minuti.<br>
            </li>
            <li>
                L'esame valuterà le tue capacità di lettura e di ascolto in conformità con il Quadro Comune Europeo di Riferimento.<br>
            </li>
        </ul>
        Per confermare la tua iscrizione, ti basterà comunicarci la tua disponibilità e noi provvederemo ad effettuare la registrazione entro 24 ore. Riceverai successivamente una e-mail di conferma. Nel caso in cui non ricevessi l'email entro 24 ore (per favore verifica anche la tua cartella di posta indesiderata), ti preghiamo di contattarci.<br>
        Se hai domande o dubbi, non esitare a contattarci. Siamo qui per aiutarti.<br>
        Grazie e in bocca al lupo per l'esame!<br>
        Cordiali saluti,<br>
        
        ">
    <cfelseif template eq "linguaskill_cpf">
        <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
        Congratulazioni, è finalmente arrivato il momento di sostenere l'esame Linguaskill Business per convalidare il tuo livello linguistico! Non perdere tempo e comunica subito la tua disponibilità per preparare l'iscrizione ai 3 moduli:<br>
        <ul>
            <li>
                Modulo di Ascolto e Lettura<br>
            </li>
            <li>
                Modulo di Parlato<br>
            </li>
            <li>
                Modulo di Scritto<br>
            </li>
        </ul>
        Una volta che ci avrai fornito le tue disponibilità, provvederemo ad effettuare la tua iscrizione entro 24 ore e riceverai una conferma via e-mail. Nel caso in cui non ricevessi alcuna comunicazione entro 24 ore (per favore verifica anche la tua cartella di posta indesiderata), ti preghiamo di contattarci immediatamente.<br>
        Se hai domande o necessiti di ulteriori informazioni, non esitare a contattarci. Siamo qui per assisterti.<br>
        Grazie e in bocca al lupo per l'esame!<br>
        Cordiali saluti,<br>
        

        ">
    <cfelseif template eq "bright_cpf">
        <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
        Congratulazioni, è finalmente arrivato il momento di sostenere l'esame Linguaskill Business per convalidare il tuo livello linguistico secondo il Quadro Comune Europeo di Riferimento per le lingue! L'esame verrà svolto online e sarà supervisionato tramite BRIGHT SECURE.<br>
        Ecco alcuni dettagli importanti sull'esame:<br>
        <ul>
            <li>
                Durata approssimativa: circa 1 ora<br>
            </li>
            <li>
                Valutazione su una scala da 0 a 5<br>
            </li>
            <li>
                Validità del certificato: 2 anni<br>
            </li>
            <li>
                La certificazione in formato PDF sarà disponibile entro 7 giorni dall'esame.<br>
            </li>
        </ul>
        Per effettuare l'iscrizione, ti preghiamo di fornirci le seguenti informazioni:<br>
        <ul>
            <li>
                Data preferita per sostenere l'esame<br>
            </li>
            <li>
                Sesso<br>
            </li>
            <li>
                Nome di nascita<br>
            </li>
            <li>
                Data di nascita<br>
            </li>
            <li>
                Luogo di nascita (città + codice postale)<br>
            </li>
        </ul>
        Una volta che ci avrai fornito queste informazioni, provvederemo ad effettuare la tua registrazione entro 24 ore e riceverai una conferma via e-mail. Nel caso in cui non ricevessi alcuna comunicazione entro 24 (per favore verifica anche la tua cartella di posta indesiderata), ti preghiamo di contattarci.<br>
        Grazie e in bocca al lupo per l'esame!<br>
        Cordiali saluti,<br>
        
        ">
    <cfelseif template eq "toeic">
        <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
        Congratulazioni, è finalmente arrivato il momento di sostenere l'esame TOEIC per convalidare il tuo livello linguistico secondo il Quadro Comune Europeo di Riferimento per le lingue!<br>
        Hai a disposizione 15 giorni per iscriverti all'esame. Ci sono due modalità per sostenere il TOEIC:<br>
        <ul>
            <li>
                Presso un centro d'esame TOEIC:<br>
            </li>
            <li>
                Durata: 2 ore<br>
            </li>
            <li>
                Certificato rilasciato entro 15 giorni lavorativi<br>
            </li>
        </ul>
        <ul>
            <li>
                Esame TOEIC online:<br>
            </li>
            <li>
                Durata: 1 ora<br>
            </li>
            <li>
                Certificato rilasciato entro 15 giorni lavorativi<br>
            </li>
        </ul>
        Per effettuare l'iscrizione, ti preghiamo di fornirci le seguenti informazioni:<br>
        <ul>
            <li>
                Data in cui desideri sostenere l'esame<br>
            </li>
            <li>
                Data di nascita<br>
            </li>
            <li>
                Accademia/Città del centro d'esame (nel caso tu scelga di svolgere l'esame presso un centro d'esame)<br>
            </li>
        </ul>
        Grazie e in bocca al lupo per l'esame!<br>
        Cordiali saluti,<br>
        
        ">

    </cfif>

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
                        <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
                        <h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
                        <p>
                            <cfoutput>#email_content#</cfoutput>
                        </p>
                    </tr>

                    <cfif get_tps.recordCount GT 0>
                        <p style="margin: 30px 0 10px; color: #555555;">
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
                                    <cfif order_start neq "">
                                        <cfset limit_date_start = obj_dater.get_dateformat(order_start)>
                                    <cfelse>
                                        <cfset limit_date_start = obj_dater.get_dateformat(tp_date_start)>
                                    </cfif>
                                    
                                    <cfif order_end neq "">
                                        <cfset limit_date_end = obj_dater.get_dateformat(order_end)>
                                    <cfelse>
                                        <cfset limit_date_end = obj_dater.get_dateformat(tp_date_end)>
                                    </cfif>
                            
                                    <cfset arr = ['limit_date_start', 'limit_date_end']>
                                    <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
                                    #obj_translater.get_translate_complex(id_translate="order_end_reminder", argv="#argv#",lg_translate="#lang#")#
                                    </td>
                                </tr>
                            </cfoutput>
                        </table>
                        </p>
                    </cfif>
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
                

        <cfinclude template="incl_email_footer2.cfm">
        
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>