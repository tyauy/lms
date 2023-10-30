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

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset accord_es = "o">
        <cfelseif listFindNoCase("Fr.,Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset accord_es = "a">
        <cfelse>
            <cfset accord_es = "o">
        </cfif>

    <cfelseif lang eq "it">
                
        <cfset email_title = "Buongiorno #get_user.user_firstname#">

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
            
            <cfset email_subtitle = "Nous constatons que vous n'avez pas encore réservé votre premier cours.">

            <cfset email_content = "<br><br>
            Installez-vous confortablement et lancez-vous ! Vous verrez notre interface est simple d'utilisation !<br><br>
            <br>
            <br>
            Si vous le souhaitez, nous pouvons tout à fait vous accompagner dans cette étape, cela prendra une vingtaine de minutes.
            <br>
            Veuillez nous le faire savoir : 
            <ul>
                <li>Par retour d'email</li>
                <li>En nous contactant au #phone_number#</li>
                <li>Lors de la première étape de votre lancement, en cliquant sur le bouton d'aide</li>
            </ul><br><br>
            <br>
            Votre apprentissage linguistique commence maintenant : préparez votre agenda, choisissez vos formateurs et réservez vos cours !
            <br>
            <br>
            A très bientôt sur WEFIT !
            ">

        <cfelseif lang eq "en">

            <cfset email_subtitle = "">

            <cfset email_content = "">

        <cfelseif lang eq "de">

            <cfset email_subtitle = "">

            <cfset email_content = "">

        <cfelseif lang eq "es">

            <cfset email_subtitle = "">

            <cfset email_content = "">

        <cfelseif lang eq "it">

            <cfset email_subtitle = "">

            <cfset email_content = "">

        </cfif>

    </cfif>
























    <!--- <cfif lang eq "fr">
        <cfif template eq 1>

            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>
            
            ">

        <cfelseif template eq 2>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>
            Nous vous avons envoyé le #lsdateformat(get_tp.tp_date_start, "dd-mm-yyyy", 'fr')# vos accès pour votre formation d'#get_tp.formation_name_lg#.<br><br>

            Nos formateurs ont hâte de vous rencontrer!<br><br>

            Vous souhaitez être conseillés sur nos formateurs ou votre choix de programme? Notre équipe se fera un plaisir de vous accompagner dans votre lancement de formation!<br><br>

            Vous préférez réaliser votre lancement en totale autonomie? Connectez-vous et personnalisez la formation qui vous ressemble en quelques clics!<br>
            Préparez votre agenda et réservez vos cours avec les formateurs de votre choix!<br>
            ">
            
        <cfelseif template eq 3>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>

            Nous avons vu que vous n'avez pas encore commencé votre formation d'#get_tp.formation_name_lg#.<br><br>

            Définissez dès maintenant votre rythme de formation en réservant à l'avance vos cours avec le formateur de votre choix et créez votre propre mécanisme d'apprentissage!<br><br>

            Nos astuces :<br>

            <ul>
                <li>
                    Vous souhaitez maintenir votre niveau? Réserver un cours par semaine de 45 minutes ou 1 heure.<br>
                </li>
                <li>
                    Vous voulez progresser? Réserver deux à trois cours par semaine de la durée de votre choix.<br>
                </li>
                <li>
                    Vous avez besoin de progresser rapidement? Privilégiez 4 à 5 cours par semaine d'une durée de 30 ou 45 minutes par cours.<br><br>
                </li>
            </ul>

            Vous souhaitez être conseillés sur le rythme idéal? Contactez nous par téléphone, chat ou via email.<br>
            Préparez votre agenda pour réserver vos cours avec les formateurs de votre choix!<br>
            ">

        </cfif>
    <cfelseif lang eq "en">
        <cfif template eq 1>

            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Hello #get_user.user_firstname#<br><br>
            I see you have not booked any lessons with us yet. <br><br>

            Sit back with a coffee, click the link below and launch your language training today! <br><br>

            You will find our system easy to use, but if you would prefer to have one of our team talk you through the steps then please feel free to book a 30 minute appointment.<br><br>

            Don't forget to have your diary to hand so you can book your lessons with the trainer of your choice<br><br>

            Start your language journey with WEFIT today<br>
            ">

        <cfelseif template eq 2>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Hello #get_user.user_firstname#<br><br>

            On #lsdateformat(get_tp.tp_date_start, "dd-mm-yyyy", 'fr')# we sent you your login details to start your #get_tp.formation_name_lg# training.<br><br>

            Our trainers are looking forward to meeting you!<br><br>

            Would you like some help or advice on choosing a trainer or program? Our team would be happy to assist you with  your training launch! <br><br>

            Would you prefer to launch your training program on your own? Log on and customize the training program that's right for you in just a few clicks!<br><br>
            
            Don't forget to have your diary to hand so you can book your lessons with the trainer of your choice<br>
            ">
            
        <cfelseif template eq 3>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Hello #get_user.user_firstname#<br><br>

            We see that you haven't started your X training yet. <br><br>

            Define your training rhythm now by booking your lessons in advance with the trainer of your choice!<br><br>

            WEFIT tips to get the most out of our training:<br>
            <ul>
                <li>
                    Want to maintain your level? Book one 45-minute or 1-hour class a week.<br>
                </li>
                <li>
                    Want to progress? Book two to three lessons a week of the duration of your choice.<br>
                </li>
                <li>
                    Need to progress quickly? Book 4 to 5 lessons a week, each lasting 30 or 45 minutes.<br>
                </li>
            </ul>
            Would you like advice on the ideal pace? Contact us by phone, chat or email.<br><br>

            Don't forget to have your diary to hand so you can book your lessons<br>

            ">

        </cfif>
    <cfelseif lang eq "de">
        <cfif template eq 1>

            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "

            Wir haben festgestellt, dass Sie Ihr Sprachtraining noch nicht gestartet haben.<br><br>

            Machen Sie es sich bequem, um gleich heute noch durchzustarten! <br><br>

            Sie werden sehen, dass unsere Plattform sehr intuitiv ist. Sollten Sie dennoch lieber von einem unser Teammitglieder Unterstützung wünschen, können Sie im nächsten Schritt einen 30-minütigen Termin reservieren.  <br><br>


            Halten Sie Ihren Terminkalender bereit und buchen Sie sogleich Ihre erste Stunde mit einem Trainer Ihrer Wahl.<br><br>

            Das Sprachenlernen mit WEFIT beginnt nun! <br>

            ">

        <cfelseif template eq 2>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "
            Wir haben Ihnen am #lsdateformat(get_tp.tp_date_start, "dd-mm-yyyy", 'fr')# Ihre Zugangsdaten für Ihr #get_tp.formation_name_lg# zugesandt.<br><br>

            Unsere Trainer freuen sich schon auf Sie.<br><br>

            Brauchen Sie Hilfe oder Tipps für die richtige Wahl des Trainers oder Ihres Trainingsprogramms? Unser Team begleitet Sie gerne bei den ersten Schritten.<br><br>

            Möchten Sie lieber selbstständig den Beginn Ihres Programms planen? Dann melden Sie sich einfach an und passen Sie Ihr Trainingsprogramm individuell in nur wenigen Klicks an. <br>
            Halten Sie Ihren Terminkalender bereit und buchen Sie sogleich Ihre erste Stunde mit einem Trainer Ihrer Wahl.<br>
            ">
            
        <cfelseif template eq 3>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "

            Wir haben festgestellt, dass Sie Ihr #get_tp.formation_name_lg# noch nicht begonnen haben. <br><br>

            Definieren Sie Ihren eigenen Trainingsrhythmus, indem Sie vorab Ihre Kurs mit einem Trainer Ihrer Wahl reservieren.<br><br>
            
            Unsere Tipps für Ihr erfolgreiches Sprachtraining:<br>
            
            <ul>
                <li>
                    Sie möchten Ihr Sprachniveau beibehalten? Reservieren Sie einen 45-minütigen oder 60-minütigen Kurs pro Woche. <br>
                </li>
                <li>
                    Sie wollen sich verbessern? Reservieren Sie zwei bis drei Kurse pro Woche, mit der Dauer Ihrer Wahl. <br>
                </li>
                <li>
                    Sie müssen sich schnell verbessern? Wählen Sie am besten 4 bis 5 Kurse pro Woche, mit einer Dauer zwischen 30 und 45 Minuten. <br>
                </li>
            </ul>
            
            Haben Sie noch Fragen bezüglich des idealen Trainingsrhythmus? Dann zögern Sie nicht uns per Telefon, Chat oder Email zu kontaktieren.<br><br>
            
            Halten Sie Ihren Terminkalender bereit und buchen Sie sogleich Ihre erste Stunde mit einem Trainer Ihrer Wahl.        <br>
            ">

        </cfif>
    <cfelseif lang eq "es">
        <cfif template eq 1>

            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "
            Nos hemos percatado de que aún no ha reservado su primera clase. <br><br>

            ¡Tome asiento, póngase cómodo y tome su tiempo para comenzar su formación!<br><br>

            Verá que nuestro sistema es fácil de utilizar, sin embargo, si prefiere que un miembro de nuestro equipo le acompañe, no dude en reservar una reunión de máximo 30 minutos en la etapa siguiente. <br><br>

            Prepare su agenda y reserve un primer encuentro con el formador de su elección. <br>
            Su aprendizaje lingüístico comienza ahora. .<br>
            ">

        <cfelseif template eq 2>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "
            Le hemos enviado el #lsdateformat(get_tp.tp_date_start, "dd-mm-yyyy", 'fr')# con el acceso a su formación de #get_tp.formation_name_lg#. <br> <br>

            ¡Nuestros formadores están deseando conocerle! <br><br>

            ¿Quiere que le aconsejamos sobre nuestros formadores o sobre el programa que ha elegido? ¡Nuestro equipo estará encantado de acompañarle en el inicio de su formación!<br><br>

            ¿O quizás prefiere comenzar su formación en total autonomía? En ese caso, conéctese a su cuenta y personalice la formación que más le interese en un par de clics. <br><br>

            Prepare su agenda y reserve un primer encuentro con el formador de su elección.<br>
            ">
            
        <cfelseif template eq 3>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
                <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
            <cfelse>
                <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
            </cfif>
            <cfset email_content = email_content & "
            Nos hemos percatado de que aún no ha comenzado su formación de #get_tp.formation_name_lg#.<br><br>

            Establezca desde hoy mismo su ritmo de formación reservando con antelación sus clases con el formador de su elección y cree su propio mecanismo de aprendizaje. <br><br>
            
            Aquí tiene algunos trucos :<br>
            
            <ul>
                <li>
                    ¿Desea mantener su nivel? Reserve una clase de 45 minutos o de 1 hora por semana. <br>
                </li>
                <li>
                    ¿Desea progresar? Reserve dos o tres clases (de la duración que quiera) por semana. <br>
                </li>
                <li>
                    ¿Necesita progresar de forma rápida? En ese caso, nuestra recomendación es que reserve 4 o 5 clases de 30 o 45 minutos por semana. <br>
                </li>
            </ul>
            
            ¿Quiere que le aconsejamos sobre su ritmo ideal?  Entonces, contáctenos por teléfono, chat o e-mail.<br><br>
            
            Prepare su agenda y reserve un primer encuentro con el formador de su elección.  <br>
            ">

        </cfif>
    <cfelseif lang eq "it">
        <cfif template eq 1>

            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
            Siamo entusiasti di invitarti a iniziare il tuo viaggio linguistico con WEFIT! Abbiamo notato che finora non hai ancora prenotato nessuna lezione sulla nostra piattaforma, ma non preoccuparti, è il momento perfetto per iniziare!<br><br>
            Prenditi un momento di relax, magari con un buon caffè, e clicca sul link sottostante per accedere al nostro sistema di prenotazione. Sarai piacevolmente sorpreso/a dalla facilità d'uso e dalla vasta scelta di insegnanti qualificati a tua disposizione.<br><br>
            Se preferisci ricevere una breve sessione di assistenza personalizzata, il nostro team sarà lieto di guidarti attraverso i passaggi necessari. Basta prenotare un appuntamento di 30 minuti e saremo pronti ad aiutarti.<br><br>
            Ricordati di avere a portata di mano la tua agenda per poter selezionare e prenotare direttamente le lezioni con l'insegnante che preferisci. Siamo qui per rendere il tuo percorso di apprendimento linguistico il più efficace e piacevole possibile.<br><br>
            Inizia il tuo viaggio linguistico con WEFIT oggi stesso e scopri quanto rapidamente potrai raggiungere i tuoi obiettivi!<br><br>
            Ti aspettiamo con entusiasmo!<br>
            ">

        <cfelseif template eq 2>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>
            In data #lsdateformat(get_tp.tp_date_start, "dd-mm-yyyy", 'fr')# ti abbiamo inviato i dati di accesso per iniziare il tuo corso #get_tp.formation_name_lg#. Siamo entusiasti di darti il benvenuto!<br><br>
            I nostri istruttori altamente qualificati sono ansiosi di conoscerti e guidarti lungo il percorso di apprendimento e noi siamo qui per offrirti un'assistenza personalizzata e garantire che il corso sia perfettamente adattato alle tue esigenze.<br><br>
            Se desideri aiuto o consigli nella scelta dell'insegnante o del programma più adatto a te, il nostro team è pronto ad assisterti nel lancio del tuo percorso di formazione. Saremo felici di consigliarti e di assicurarci che tu ottenga il massimo valore dalla tua esperienza con noi.<br><br>
            D'altra parte, se preferisci configurare il tuo programma autonomamente, puoi accedere al nostro sistema e personalizzare il tuo corso con pochi semplici clic. Ti offriamo la flessibilità di adattare il percorso di apprendimento secondo i tuoi ritmi e le tue preferenze.<br><br>
            Siamo determinati a fornirti un'esperienza di apprendimento straordinaria e a supportarti lungo tutto il tuo percorso. Non vediamo l'ora di vedere i tuoi progressi e di aiutarti a raggiungere i tuoi obiettivi!<br><br>
            Ricordati di avere a portata di mano la tua agenda per poter selezionare e prenotare direttamente le lezioni con l'insegnante che preferisci. <br><br>
            Cordiali saluti,<br>
            ">
            
        <cfelseif template eq 3>
            <cfset email_title = "Welcome to WEFIT !">
            <cfset email_subtitle = "">

            <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>

            Siamo spiacenti di vedere che non hai ancora potuto iniziare la tua formazione. Ma non preoccuparti! Puoi definire il tuo ritmo di apprendimento prenotando le lezioni in anticipo con l'insegnante che preferisci.<br><br>
            Ecco alcuni consigli da parte di WEFIT per ottenere il massimo dai nostri allenamenti:<br><br>
            <ul>
                <li>
                    Mantenere il tuo livello attuale: Prenota una lezione di 45 minuti o 1 ora alla settimana per consolidare le tue competenze linguistiche.<br>
                </li>
                <li>
                    Progressione graduale: Se desideri fare progressi, prenota due o tre lezioni a settimana della durata che preferisci (30, 45 o 60 minuti). Potrai approfondire gli argomenti e migliorare le tue abilità linguistiche in modo più rapido ed efficace.<br>
                </li>
                <li>
                    Progressione veloce: Se hai bisogno di progredire rapidamente, ti consigliamo di prenotare 4 o 5 lezioni a settimana, ciascuna della durata di 30 o 45 minuti. Questo ti permetterà di ottenere risultati tangibili nel minor tempo possibile.<br>
                </li>
            </ul>
            
            Consulenza personalizzata: Se hai bisogno di un consiglio ad hoc per la tua situazione personale e lavorativa, siamo qui per aiutarti. Puoi contattarci tramite telefono, chat o e-mail per discutere delle tue esigenze specifiche e trovare la soluzione più adatta a te.<br><br>
            Sappiamo quanto sia importante conciliare gli impegni personali e lavorativi con il tuo percorso di formazione. Per questo, siamo pronti a offrirti un supporto su misura.<br><br>
            Non perdere altro tempo, contattaci oggi stesso e prenota le tue lezioni per iniziare a raggiungere i tuoi obiettivi linguistici!<br><br>
            Ricordati di avere a portata di mano la tua agenda per poter selezionare e prenotare direttamente le lezioni con l'insegnante che preferisci. <br><br>
            Cordiali saluti,<br>
            ">

        </cfif>

    </cfif> --->


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