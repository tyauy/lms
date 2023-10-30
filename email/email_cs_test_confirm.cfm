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
    <cfif template eq "linguaskill_confirm">
        <cfset email_content = "Bonjour #get_user.user_firstname#<br><br>
        
        Je vous confirme votre inscription pour le passage du LINGUASKILL <br><br>
        
        Votre code pour effectuer le test LINGUASKILL est le : '#get_tp.token_code#'<br><br>
        
        Le lancement de votre certification se fera via l'interface LMS au même titre qu'un cours classique. <br>
        Vous recevrez une notification à l'heure de l'examen, suivez alors les instructions.<br><br>
        
        <strong>Si le lancement ne fonctionne pas via votre compte personnel, veuillez suivre la procédure ci-dessous:</strong><br>
        
        <ul>
            <li>
                - Se rendre sur le site  LINGUASKILL: <a href='https://www.metritests.com/metrica'>https://www.metritests.com/metrica</a><br>
            </li>
            <li>
                - Ajouter votre code dans l'espace à gauche '#get_tp.token_code#'<br>
            </li>
            <li>
                - Cliquer sur la flèche au milieu de votre écran pour lancer le test <br>
            </li>
        </ul>
        
        Bonne réussite!<br><br>
        
        Cordialement, <br>
        
        ">
    </cfif>
<cfelseif lang eq "en">
    <cfif template eq "linguaskill_confirm">

        <cfset email_content = "Hi #get_user.user_firstname#<br><br>
        This email is to confirm you are now registered to take the LINGUASKILL exam <br><br>

        Your personal code is: '#get_tp.token_code#'; Keep this code safe, you will need it to take the exam.<br><br>
        
        You will access the exam through the WEFIT LMS interface, the same way as you start your visio lessons. Another email will be sent to you nearer the your exam time with instructions that you need to  follow<br><br>
        
        
        <strong>If you can not access the exam through the LMS please follow the procedure below:</strong><br>
        
        <ul>
            <li>
                - Go to: <a href='https://www.metritests.com/metrica'>https://www.metritests.com/metrica</a><br>
            </li>
            <li>
                - Type in your code marked in the space marked '#get_tp.token_code#'<br>
            </li>
            <li>
                - Click on the arrow in the middle of the screen to start the exam<br>
            </li>
        </ul>

        
         Good luck!<br>
        
        ">

    </cfif>
<cfelseif lang eq "de">
    <cfif template eq "linguaskill_confirm">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Lieber Herr #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Liebe Frau #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Guten tag #get_user.user_firstname#<br><br>">
        </cfif>

        <cfset email_content = email_content & "
        Hiermit bestätige ich Ihnen Ihre Einschreibung für die LINGUASKILL-Prüfung.<br><br>

        Ihr persönlicher Zugangscode : '#get_tp.token_code#'<br><br>
        
        Ebenso wie einen gewöhnlichen Kurs können Sie die Zertifizierung über die LMS-Plattform erreichen.<br>
        Sie erhalten kurz vor der Prüfungszeit eine Mitteilung mit weiteren Anweisungen.<br><br>
        
        <strong>Falls Sie die Zertifizierung nicht über die LMS-Plattform erreichen können, verfahren Sie bitte folgendermaßen:</strong><br>
        <ul>
            <li>
                -Gehen Sie zur Internetseite LINGUASKILL: <a href='https://www.metritests.com/metrica'>https://www.metritests.com/metrica</a><br>
            </li>
            <li>
                - Geben Sie Ihren Zugangscode im dafür vorgesehenen Bereich ein '#get_tp.token_code#'<br>
            </li>
            <li>
                - Klicken Sie auf den Pfeil in der Mitte Ihres Bildschirms, um die Prüfung zu starten<br>
            </li>
        </ul>        
         
        Wir wünschen Ihnen viel Erfolg.<br><br>
        
        Mit freundlichem Gruß,<br>
        ">

<cfelseif lang eq "es">
    <cfif template eq "linguaskill_confirm">

        <cfif listFindNoCase("Hr.,M,M.,Mr.", get_user.user_gender,",")>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        <cfelseif listFindNoCase("Fr.Mme,Mrs.,Ms.", get_user.user_gender)>
            <cfset email_content ="Estimada #get_user.user_firstname#<br><br>">
        <cfelse>
            <cfset email_content ="Estimado #get_user.user_firstname#<br><br>">
        </cfif>
        <cfset email_content = email_content & "
        Le confirmamos su inscripción para realizar la prueba LINGUASKILL. <br><br>

        Su código para realizar la prueba LINGUASKILL es el siguiente:  '#get_tp.token_code#'<br><br>
        
        El inicio de dicha certificación será desde la página web LMS, al igual que una clase normal.  <br>
        Recibirá una notificación a la hora del examen, por favor, siga las instrucciones. <br><br>
        
        <strong>Si el inicio de la prueba no funciona desde su espacio personal, siga los pasos que se explican abajo:</strong><br>
        <ul>
            <li>
                -Vaya a la web de LINGUASKILL:  <a href='https://www.metritests.com/metrica'>https://www.metritests.com/metrica</a><br>
            </li>
            <li>
                - Escriba su código en el espacio de la izquierda '#get_tp.token_code#'<br>
            </li>
            <li>
                - Clique con la flecha en medio de su pantalla para comenzar la prueba<br>
            </li>
        </ul>    
        
        ¡Suerte!<br><br>
        
        Cordialmente, <br>
        

        ">

    </cfif>
<cfelseif lang eq "it">
    <cfif template eq "linguaskill_confirm">
        <cfset email_content = "Buongiorno #get_user.user_firstname#<br><br>

        Confermiamo la tua registrazione per l'esame LINGUASKILL. Il tuo codice personale è: '#get_tp.token_code#'. Ti consigliamo di conservare questo codice, in quanto ti sarà richiesto per accedere all'esame.<br><br>
        L'accesso all'esame avverrà tramite l'interfaccia LMS di WEFIT, proprio come fai per avviare le lezioni video. Riceverai un'altra e-mail poco prima dell'esame con le istruzioni dettagliate da seguire.<br><br>
        In caso di difficoltà nell'accesso all'esame tramite LMS, ti preghiamo di seguire la procedura indicata di seguito:<br>
        <ul>
            <li>
                Vai su: <a href='https://www.metritests.com/metrica'>https://www.metritests.com/metrica</a><br>
            </li>
            <li>
                Digita il tuo codice nell'apposito spazio '#get_tp.token_code#'.<br>
            </li>
            <li>
                Clicca sulla freccia al centro dello schermo per avviare l'esame.<br>
            </li>
        </ul>    
        Ti auguriamo buona fortuna per l'esame!<br><br>
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