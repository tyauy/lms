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
    <cfset btn_contact = obj_translater.get_translate(id_translate="btn_contact_wefit",lg_translate="#lang#")>

    <cfset trainer_display = "">
    
    <cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
    SELECT lesson_id, lesson_start, l.planner_id, u.user_firstname 
    FROM lms_lesson2 l 
    INNER JOIN user u ON u.user_id = l.planner_id 
    WHERE l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND (status_id = 2 OR status_id = 5) AND lesson_start < NOW() ORDER BY lesson_start DESC LIMIT 1
    </cfquery>

    <cfquery name="get_trainer_list" datasource="#SESSION.BDDSOURCE#">
    SELECT u.user_firstname 
    FROM lms_tpplanner tpp 
    INNER JOIN user u ON u.user_id = tpp.planner_id 
    INNER JOIN lms_lesson2 l ON l.planner_id = u.user_id AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    WHERE tpp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND tpp.active = 1
    GROUP BY tpp.planner_id
    </cfquery>

    <cfquery name="get_next_lesson" datasource="#SESSION.BDDSOURCE#">
    SELECT lesson_id, lesson_start, l.planner_id, u.user_firstname 
    FROM lms_lesson2 l 
    INNER JOIN user u ON u.user_id = l.user_id 
    WHERE l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
    AND (l.status_id = 1) AND lesson_start > NOW() 
    </cfquery>

    <cfif get_tp.tp_completed eq ""><cfset tp_completed = 0><cfelse><cfset tp_completed = get_tp.tp_completed></cfif>
    <cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled = 0><cfelse><cfset tp_scheduled = get_tp.tp_scheduled></cfif>
    <cfif get_tp.tp_missed eq ""><cfset tp_missed = 0><cfelse><cfset tp_missed = get_tp.tp_missed></cfif>
    <cfset tp_left = (get_tp.tp_duration - tp_completed - tp_missed - tp_scheduled)>
    <cfset tp_left_txt = obj_lms.get_format_hms(toformat="#tp_left#",unit="min")>


    <!--------------------------------- H1 HELLO MESSAGE ------------------------>
    <cfif lang eq "fr">    

        <cfset email_title = "Bonjour #get_user.user_firstname#">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset accord_fr = "">
        <cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset accord_fr = "e">
        <cfelse>
            <cfset accord_fr = "">
        </cfif>

        <cfif get_trainer_list.recordcount eq "1">
            <cfset trainer_display = get_trainer_list.user_firstname>
        <cfelseif get_trainer_list.recordcount eq "2">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong> et <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong>">
        <cfelseif get_trainer_list.recordcount eq "3">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong>, <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong> et <strong>#QueryGetRow(get_trainer_list,3).user_firstname#</strong>">
        </cfif>
        
    <cfelseif lang eq "en">
        
        <cfset email_title = "Hi #get_user.user_firstname#">

        <cfif get_trainer_list.recordcount eq "1">
            <cfset trainer_display = get_trainer_list.user_firstname>
        <cfelseif get_trainer_list.recordcount eq "2">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong> and <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong>">
        <cfelseif get_trainer_list.recordcount eq "3">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong>, <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong> and <strong>#QueryGetRow(get_trainer_list,3).user_firstname#</strong>">
        </cfif>

    <cfelseif lang eq "de">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_title = "Lieber Herr #get_user.user_firstname#">
        <cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_title = "Liebe Frau #get_user.user_firstname#">
        <cfelse>
            <cfset email_title = "Guten tag #get_user.user_firstname#">
        </cfif>

        <cfif get_trainer_list.recordcount eq "1">
            <cfset trainer_display = get_trainer_list.user_firstname>
        <cfelseif get_trainer_list.recordcount eq "2">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong> und <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong>">
        <cfelseif get_trainer_list.recordcount eq "3">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong>, <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong> und <strong>#QueryGetRow(get_trainer_list,3).user_firstname#</strong>">
        </cfif>

    <cfelseif lang eq "es">
        
        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_title = "Estimado #get_user.user_firstname#">
        <cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_title = "Estimada #get_user.user_firstname#">
        <cfelse>
            <cfset email_title = "Estimado #get_user.user_firstname#">
        </cfif>

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset accord_es = "o">
        <cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset accord_es = "a">
        <cfelse>
            <cfset accord_es = "o">
        </cfif>

        <cfif get_trainer_list.recordcount eq "1">
            <cfset trainer_display = get_trainer_list.user_firstname>
        <cfelseif get_trainer_list.recordcount eq "2">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong> y <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong>">
        <cfelseif get_trainer_list.recordcount eq "3">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong>, <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong> y <strong>#QueryGetRow(get_trainer_list,3).user_firstname#</strong>">
        </cfif>

    <cfelseif lang eq "it">
                
        <cfset email_title = "Buongiorno #get_user.user_firstname#">

        <cfif get_trainer_list.recordcount eq "1">
            <cfset trainer_display = get_trainer_list.user_firstname>
        <cfelseif get_trainer_list.recordcount eq "2">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong> E <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong>">
        <cfelseif get_trainer_list.recordcount eq "3">
            <cfset trainer_display = "<strong>#QueryGetRow(get_trainer_list,1).user_firstname#</strong>, <strong>#QueryGetRow(get_trainer_list,2).user_firstname#</strong> E <strong>#QueryGetRow(get_trainer_list,3).user_firstname#</strong>">
        </cfif>

    </cfif>


    <!--------------------------------- PARAM CS NUMBER DEPENDING ON PROVIDER ------------------------>
    <cfif get_user.provider_id eq "2">
        <cfset phone_number = "+49 7151 2 59 40 54">
    <cfelse>
        <cfset phone_number = "+33 (0)1 89 16 82 67">
    </cfif>


    <!--------------------------------- TEMPLATE 1 ------------------------>
    <cfif template eq 1>
    
        <cfif lang eq "fr">  
            
            <cfset email_subtitle = "Vous avez récemment débuté votre formation et avez eu cours avec <strong>#get_last_lesson.user_firstname#</strong> le #obj_function.get_dateformat(get_last_lesson.lesson_start, 'fr')#.">

            <cfset email_content = "<br>Nous serions ravis de recueillir vos impressions sur votre formation en #get_tp.formation_name# et savoir si vous êtes satisfait#accord_fr# de #trainer_display#.
            <br><br>
            Nous espérons que la plateforme est facile d'utilisation, et que vous vous sentez progresser !
            <br><br>
            Partagez avec nous votre expérience :
            <ul>
                <li>En répondant à cet email</li>
                <li>En nous appelant au #phone_number#</li>
                <li>En notant régulièrement vos cours et vos formateurs</li>
            </ul>
            ">

            <cfif get_next_lesson.recordCount eq "0">
                <cfset email_content = email_content&"<br>Nous constatons à ce jour que vous n'avez pas de cours programmé. 
                <br>
                Nous vous conseillons de programmer vos cours à l'avance afin de rester motivé#accord_fr# et obtenir les créneaux qui vous conviennent le mieux.">
            </cfif>

            <cfset email_content = email_content&"<br><br>
            A très bientôt !<br><br>">

        <cfelseif lang eq "en">

            <cfset email_subtitle = "You have recently started your training and had a course with <strong>#get_last_lesson.user_firstname#</strong> on #obj_function.get_dateformat(get_last_lesson.lesson_start, 'en')#.">

            <cfset email_content = "<br>We would be delighted to get your impressions of your #get_tp.formation_name# training and to know if you are satisfied with #trainer_display#.
            <br><br>
            We hope the platform is easy to use, and that you feel you are making progress!
            <br><br>
            Share your experience with us:<br>
            <ul>
                <li>By replying to this email</li>
                <li>By calling us on #phone_number#</li>
                <li>By regularly rating your lessons and trainers</li>
            </ul>
            ">

            <cfif get_next_lesson.recordCount eq "0">
                <cfset email_content = email_content&"<br>We notice that you don't have any lessons scheduled.
                <br>
                We advise you to schedule your lessons in advance to stay motivated and get the slots that suit you best.">
            </cfif>

            <cfset email_content = email_content&"<br><br>
            See you soon!<br><br>">

        <cfelseif lang eq "de">

            <cfset email_subtitle = "Ihre letzte Stunde mit #get_last_lesson.user_firstname# war am #obj_function.get_dateformat(get_last_lesson.lesson_start, 'de')#. <br> Sie haben noch #tp_left_txt# in Ihrem Trainingsprogramm zu absolvieren.">

            <cfset email_content = "<br>We would be delighted to get your impressions of your #get_tp.formation_name# training and to know if you are satisfied with #trainer_display#.<br><br>
            <br><br>
            We hope the platform is easy to use, and that you feel you are making progress!
            <br><br>
            Share your experience with us:<br>
            <ul>
                <li>By replying to this email</li>
                <li>By calling us on #phone_number#</li>
                <li>By regularly rating your lessons and trainers</li>
            </ul>
            ">

            <cfif get_next_lesson.recordCount eq "0">
                <cfset email_content = email_content&"<br>We notice that you don't have any lessons scheduled.
                <br>
                We advise you to schedule your lessons in advance to stay motivated and get the slots that suit you best.">
            </cfif>

            <cfset email_content = email_content&"<br><br>
            See you soon!<br><br>">

        <cfelseif lang eq "es">

            <cfset email_subtitle = "Ya ha empezado su formación y ha tenido su clase con #get_last_lesson.user_firstname# el #obj_function.get_dateformat(get_last_lesson.lesson_start, 'es')#.">

            <cfset email_content = "<br>Estaremos encantados de tomar nota de sus impresiones en cuanto a su formación en #get_tp.formation_name# y confirmar que está satisfech#accord_es# de #trainer_display#.
            <br><br>
            ¡Esperamos que la plataforma es fácil de uso que se sienta progresando!
            <br><br>
            Comparte con nosotros su experiencia:<br>
            <ul>
                <li>Respondiendo a este correo electrónico</li>
                <li>Llamándonos al #phone_number#</li>
                <li>By regularly rating your lessons and trainers</li>
            </ul>
            ">

            <cfif get_next_lesson.recordCount eq "0">
                <cfset email_content = email_content&"<br>Hoy en dia, veemos que no tiene ni una clase programada.
                <br>
                Le aconsejamos programar sus próximas clases con antelación para mantenerse motivad#accord_es# y obtener los horarios que más le convengan.">
            </cfif>

            <cfset email_content = email_content&"<br><br>
            ¡Hasta pronto!<br><br>">


        <cfelseif lang eq "it">

            <cfset email_subtitle = "Speriamo che tu stia trascorrendo una giornata produttiva. Desideriamo informarti che la tua ultima lezione si è tenuta il #tp_left_txt# con #obj_function.get_dateformat(get_last_lesson.lesson_start, 'it')#. È un piacere avere la possibilità di supportarti nel tuo percorso di apprendimento.">

            <cfset email_content = "<br>We would be delighted to get your impressions of your #get_tp.formation_name# training and to know if you are satisfied with #trainer_display#.
            <br><br>
            We hope the platform is easy to use, and that you feel you are making progress!
            <br><br>
            Share your experience with us:<br>
            <ul>
                <li>By replying to this email</li>
                <li>By calling us on #phone_number#</li>
                <li>By regularly rating your lessons and trainers</li>
            </ul>
            ">

            <cfif get_next_lesson.recordCount eq "0">
                <cfset email_content = email_content&"<br>We notice that you don't have any lessons scheduled.
                <br>
                We advise you to schedule your lessons in advance to stay motivated and get the slots that suit you best.">
            </cfif>

            <cfset email_content = email_content&"<br><br>
            See you soon!<br><br>">

        </cfif>



    <!--------------------------------- TEMPLATE 2 ------------------------>
    <cfelseif template eq 2>
    
        <cfif lang eq "fr">    

            <cfset email_subtitle = "Votre dernier cours avec <strong>#get_last_lesson.user_firstname#</strong> a eu lieu le #obj_function.get_dateformat(get_last_lesson.lesson_start, 'fr')#. <br>Il vous reste #tp_left_txt# à programmer.">

            <cfset email_content = "<br>Nous savons que trouver des disponibilités avec vos formateurs correspondant à votre agenda n'est pas toujours facile.<br><br>

            Nous vous partageons nos astuces :<br>

            <ol>
                <li>
                    Réservez vos cours en avance
                </li>
                <li>
                    Ajoutez un formateur supplémentaire depuis votre espace 
                </li>
                <li>
                    Ajustez la durée de vos cours selon vos disponibilités (contactez-nous par email, chat ou téléphone)
                </li>
            </ol>

            Bien cordialement<br><br>
            ">

        <cfelseif lang eq "en">

            <cfset email_subtitle = "Your last lesson was on #obj_function.get_dateformat(get_last_lesson.lesson_start, 'en')# with <strong>#get_last_lesson.user_firstname#</strong>.<br>You still have #tp_left_txt# until the end of your training">

            <cfset email_content = "<br>We know that finding availability with your trainers to suit your schedule isn't always easy.<br><br>

            Here are some of our tips:<br>
            
            <ol>
                <li>
                    Book your lessons in advance
                </li>
                <li>
                    Add a trainer directly from your space
                </li>
                <li>
                    Change the duration of your lessons with a simple email or call to our Customer Service team
                </li>
            </ol>
            
            We wish you a great rest of the day!<br><br>
            ">

        <cfelseif lang eq "de">

            <cfset email_subtitle = "Ihre letzte Stunde mit #get_last_lesson.user_firstname# war am #obj_function.get_dateformat(get_last_lesson.lesson_start, 'de')#. <br> Sie haben noch #tp_left_txt# in Ihrem Trainingsprogramm zu absolvieren.">

            <cfset email_content = "<br>Wir wissen, dass es nicht immer einfach ist, Ihre Verfügbarkeiten sowie die Ihrer Trainer zu vereinbaren.<br><br>

            Hier ein paar Tipps:<br>
            
            <ol>
                <li>
                    Reservieren Sie Ihre Kurse frühzeitig
                </li>
                <li>
                    Fügen Sie einen weiteren Trainer hinzu
                </li>
                <li>
                    Kontaktieren Sie uns per Email, Chat oder Telefonanruf, um die Dauer der Kurse anzupassen, sodass Sie Ihr Fristende einhalten können
                </li>
            </ol>
            
        Wir freuen uns, von Ihnen zu hören.Mit freundlichem Gruß. <br><br>
            ">

        <cfelseif lang eq "es">

            <cfset email_subtitle = "Su última clase con #get_last_lesson.user_firstname# fue el #obj_function.get_dateformat(get_last_lesson.lesson_start, 'es')#. <br> Aún le queda #tp_left_txt# para programar.">

            <cfset email_content = "<br>Sabemos que encontrar disponibilidad con sus profesores que coincidan con su agenda no es nada fácil. <br> <br>
            Así mismo le compartimos algunos consejos :<br>

            <ol>
                <li>
                    Reserve sus clases con antelación<br>
                </li>
                <li>
                    Añada un formador desde su espacio personal <br>
                </li>
                <li>
                    Cambie la duración de sus clases con un simple email, a través del chat o con una llamada para conseguir llegar a su fecha límite. <br>
                </li>
            </ol>
            Atentamente, <br><br>
            ">


        <cfelseif lang eq "it">

            <cfset email_subtitle = "Speriamo che tu stia trascorrendo una giornata produttiva. Desideriamo informarti che la tua ultima lezione si è tenuta il #tp_left_txt# con #obj_function.get_dateformat(get_last_lesson.lesson_start, 'it')#. È un piacere avere la possibilità di supportarti nel tuo percorso di apprendimento.">

            <cfset email_content = "<br>Riconosciamo che coordinare e conciliare le tue esigenze con gli insegnanti può essere una sfida.<br> <br>
    Per questo motivo, abbiamo preparato per te una lista di utili suggerimenti:<br>
            <ol>
                <li>
                    Prenota le lezioni in anticipo.<br>
                </li>
                <li>
                    Aggiungi insegnanti al tuo profilo.<br>
                </li>
                <li>
                    Modifica la durata delle lezioni: è sufficiente inviare un'e-mail o contattare il nostro Servizio Clienti telefonicamente.<br>
                </li>
            </ol>
        
            Cordiali saluti,<br><br>
            ">

        </cfif>








    <!--------------------------------- TEMPLATE 3 ------------------------>      
    <cfelseif template eq 3>

        <cfif lang eq "fr">    

            <cfset email_subtitle = "Réservez dès maintenant votre prochain cours avec <strong>#get_last_lesson.user_firstname#</strong> !">
            
            <cfset email_content = "<br>Pour rappel il vous reste #tp_left_txt# à réaliser avant le #obj_function.get_dateformat(get_tp.tp_date_end,'fr')#.

            #get_last_lesson.user_firstname# a hâte de vous retrouver sur le chemin de l'apprentissage.<br><br>

            Si votre agenda ne vous permet pas de prendre des cours tout de suite, n'hésitez pas à nous le faire savoir; nous vous recontacterons à un moment plus approprié.<br><br>

            Toute notre équipe reste à votre disposition et vous souhaite une belle journée<br><br>
            ">

        <cfelseif lang eq "en">    

            <cfset email_subtitle = "Book your next lesson with <strong>#get_last_lesson.user_firstname#</strong> today!">

            <cfset email_content = "<br>As a reminder, you still have #tp_left_txt# to complete and #get_last_lesson.user_firstname# is looking forward to helping you reach your targets<br><br>
            
            If you are not able to take your lessons at the moment, just let us know, and we can contact you when you are in a better place to restart your training<br><br>
            
        If you need any help or guidance, our team is here to help you. Have a lovely day<br><br>
            ">

        <cfelseif lang eq "de">    

            <cfset email_subtitle = "Reservieren Sie doch noch heute Ihren nächsten Kurs mit #get_last_lesson.user_firstname#.">

            <cfset email_content = "<br>Sie haben noch #tp_left_txt# bis zum Trainingsende am #obj_function.get_dateformat(get_tp.tp_date_end,'de')#.<br><br>
            
            #get_last_lesson.user_firstname# freut/en sich darauf, Sie auf Ihrem Sprachabenteuer weiterhin zu begleiten und Ihnen zu helfen, Ihre Ziele zu erfüllen.<br><br>
            
            Falls Ihr Terminkalender es Ihnen aktuell nicht ermöglicht, Ihr Sprachtraining fortzusetzen, zögern Sie bitte nicht uns darüber zu informieren. <br>
            Wir kontaktieren Sie in diesem Fall zu einem günstigeren Zeitpunkt wieder.<br><br>
            
            Wir wünschen Ihnen weiterhin viel Erfolg.<br>
            Mit freundlichem Gruß,<br><br>">
        
        <cfelseif lang eq "es">    

            <cfset email_subtitle = "¡ Reserve su próxima clase con <strong>#get_last_lesson.user_firstname#</strong> !">

            <cfset email_content = "<br>Le queriamos recordar que le quedan todavía #tp_left_txt# de clase para realizar antes del #obj_function.get_dateformat(get_tp.tp_date_end,'es')#.<br><br>
            
            #get_last_lesson.user_firstname# tiene muchas ganas de volver a verle en su camino del aprendizaje.<br><br>
            
            Si su agenda no le permite reservar nuevas clases en estos momentos, háganoslo saber y nosotros le contactaremos a un momento más adecuado <br><br>
            
            Todo el equipo queda a su entera disposición et le desea un buen día.<br><br>">

        <cfelseif lang eq "it">    

            <cfset email_subtitle = "Prenota oggi Le tue ore con <strong>#get_last_lesson.user_firstname#</strong> !">

            <cfset email_content = "<br>Hai encora #tp_left_txt# da completare entro il #obj_function.get_dateformat(get_tp.tp_date_end,'fr')#.

            #get_last_lesson.user_firstname# è entusiasta di aiutarti a raggiungere i tuoi obiettivi.<br><br>

            Capisco che potresti avere impegni o situazioni impreviste che potrebbero impedirti di seguire le lezioni al momento. Non preoccuparti! Basta farci sapere e il nostro team sarà pronto a contattarti quando sarai disponibile per riprendere la tua formazione. La tua crescita e il tuo successo sono la nostra priorità assoluta. <br><br>

            Restiamo a vostra disposizione e via auguriamo una buona giornata<br><br>">

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
                        <td style="font-size: 15px; color: #333333; font-weight: normal;">
                            <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
                            <h4 style="margin: 0 0 10px; font-size: 17px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
                            
                            <cfoutput>#email_content#</cfoutput>
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
                                    <td class="button-td button-td-primary" style="border-radius: 4px; background-color: #87222F;">
                                        <a class="button-a button-a-primary" href="https://lms.wefitgroup.com" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;">
                                            <span class="button-link" style="color:#ffffff">
                                                <cfoutput>#btn_connect#</cfoutput>
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
        </tr>

        <cfinclude template="incl_email_footer2.cfm">

    </center>
</body>
</html>