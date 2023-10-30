<cfsilent>

<cfset th_detail = #obj_translater.get_translate('global_details', lang)#>
<cfset th_trainer = #obj_translater.get_translate('table_th_trainer', lang)#>
<cfset th_learner = #obj_translater.get_translate('table_th_learner', lang)#>
<cfset th_date = #obj_translater.get_translate('table_th_date', lang)#>
<cfset th_hour = #obj_translater.get_translate('table_th_time', lang)#>
<cfset th_duration = #obj_translater.get_translate('table_th_duration_short', lang)#>
<cfset th_title = #obj_translater.get_translate('table_th_course', lang)#>

<!--- <cfset arr = ['learner_firstname','trainer_firstname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->



<!--- <cfset email_title = #obj_translater.get_translate_complex('mail_reminder_title', lang, argv)#>>
<cfset email_subtitle = #obj_translater.get_translate_complex('mail_reminder_subtitle', lang, argv)#>> --->

<cfset email_title = "Suivi de votre formation">
<cfset email_subtitle = "Vous avez effectué le #get_tp.next_lesson# (date dernier cours) votre XX cours (numéro de cours fait exemple 3ème) sur vos XX heures de formation en Anglais.
Nous souhaiterions recueillir vos impressions sur votre formation">

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
                        <td style="color:#252422; font-weight: 600; font-size:15px">
                            <h1><cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/#email_icon#" alt="WEFIT" border="0" align="center" style="max-width: 100%; height: 52px; margin-right:15px"></cfoutput><cfoutput>#email_title#</cfoutput></h1>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
                
        <tr>
            <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                    <tr>
                        <td width="10%">
                                    
                        </td>
                        <td width="80%">
                                
                            <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                                <tr>
                                    <td width="15%" style="vertical-align:middle">
                                        <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#SESSION.USER_ID#/#SESSION.USER_ID#.png")>
                                            <cfoutput>
                                            <img src="#SESSION.BO_ROOT_URL#/assets/user/#SESSION.USER_ID#/#SESSION.USER_ID#.png" width="50" style="margin-right:15px">
                                            <br>
                                            <strong>#SESSION.USER_FIRSTNAME#</strong>
                                            </cfoutput>
                                        </cfif>

                                    </td>
                                    <td width="85%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                        <cfoutput>
                                        <p>#email_subtitle#
                                        <br>
                                        </p>
                                        </cfoutput>
                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td width="10%">
                                    
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                    <tr>
                        <td style="background-color:#F3F3F3; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422; border-top:1px solid #C7152C; padding:10px">
                        
                            <!--- <cfdump var="#get_tp#"> --->
                            Nous espérons que les solutions mises à votre disposition répondent à vos attentes et que vous vous sentez progresser !
                            <br>
                            Vous avez choisi pour formateur(s):
                            <br>


                            <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
                                <cfloop query="get_trainer">
                                <cfoutput>
                                <tr>
                                    <td width="15%" style="vertical-align:middle">
                                        <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/user/#planner_id#/photo.jpg" width="50" style="border-radius:50%; border:2px solid ##CE1D37 !important; margin-right:15px"></cfoutput>
                                    </td>
                                    <td width="85%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: ##252422;">
                                        #planner#
                                    </td>
                                </tr>
                                </cfoutput>
                                </cfloop>
                            </table>

                            
                                

                            <br>
                            N'hésitez pas à revenir vers nous si vous souhaitez adapter le rythme, le niveau ou le contenu de votre parcours.
                            <br>

                            <br>
                            Dites nous en plus en partageant votre expérience avec la communauté WEFIT :
                            <ul>
                                <li>En répondant à cet email </li>
                                <li>En nous appelant au XXXXXXXX (numéro CS français si compte français / numéro CS allemand si compte allemand).</li>
                                <li>En notant votre cours dès que vous avez reçu votre compte-rendu.</li>
                            </ul>
                            
                            
                            <br>
                            Si pas d’autre cours réserver ajouter :
                            Programmez vos prochains cours à l’avance afin de rester motivé(e) et engagé(e) Motivé/Engagé= si Mr Motivée/engagée  si Mme sur le parcours de l’apprentissage.
                            <br>
                            Cordialement,

                        </td>
                    </tr>
                </table>
            </td>
        </tr>

  




        <!--- <tr>
            <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                    <tr>
                        <td width="10%">
                            
                        </td>
                        <td width="80%" style="background-color:#F3F3F3; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422; border-top:1px solid #C7152C; padding:10px">
                            <table width="100%" cellpadding="5">
                                <cfoutput>
                                <tr>
                                    <td align="center" width="150">

                                        <cfif fileexists("/home/www/wnotedev1/www/manager/lms/assets/img_material/#get_lesson.sessionmaster_code#.jpg")>			
                                            <img src="https://lms.wefitgroup.com/assets/img_material/#get_lesson.sessionmaster_code#.jpg" width="130">
                                        <cfelseif fileexists("/home/www/wnotedev1/www/manager/lms/assets/img_material/#get_lesson.sessionmaster_id#.jpg")>			
                                            <img src="https://lms.wefitgroup.com/assets/img_material/#get_lesson.sessionmaster_id#.jpg" width="130">
                                        </cfif>
                                       
                                    </td>
                                    <td align="left">
                                        <strong>#ucase(th_date)#</strong> : #lesson_date_start#
                                        <br>
                                        <strong>#ucase(th_hour)#</strong> : 
                                        #timeformat(get_lesson.lesson_start,'HH:mm')# - #timeformat(get_lesson.lesson_end,'HH:mm')#
                                        <cfif isdefined("lang") AND lang eq "de"> Uhr</cfif>
                                        <br>
                                        <strong>#ucase(th_duration)#</strong> : #get_lesson.lesson_duration# min
                                        <br>
                                        <strong>#ucase(th_title)#</strong> : #get_lesson.sessionmaster_name#
                                    

                                    </td>
                                </tr>
                                </cfoutput>
                            </table>
                        </td>
                        <td width="10%">

                        </td>
                    </tr>
                    <cfif isdefined("email_footer")>
                    <tr>
                        <td width="10%">
                            
                        </td>
                        <td style="font-family: sans-serif; padding-top:20px">
                            <p style="margin: 0 0 10px; font-size: 14px; line-height: 125%; color: #333333; font-weight: normal; text-align:justify">
                            <cfoutput>#email_footer#</cfoutput>
                            </p>
                        </td>
                        <td width="10%">
                            
                        </td>
                    </tr>
                    </cfif>
                </table>
            </td>
        </tr> --->



       <tr>
            <td style="background-color: #ffffff; padding: 0px 30px 20px 30px;">
                <!-- Button : BEGIN -->
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                    <tr>
                        <td class="button-td button-td-primary" style="border-radius: 3px;">
                            <a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: linear-gradient(#C7152C,#8A2128); font-family: sans-serif; font-size: 14px; line-height: 14px; text-decoration: none; padding: 10px 30px; display: block; border-radius: 3px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput></span></a>
                        </td>
                    </tr>
                </table>
                <!-- Button : END -->
            </td>
        </tr>



        
        <!--- <cfif isdefined("email_tips")>
        <tr>
            <td style="background-color: #ffffff; padding: 0px 30px 20px 30px;">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                    <tr>
                        <td width="10%" style="padding-right:15px; border-right:2px solid #C7152C">
                            <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/icon_tips.png" width="30" style="" align="right"></cfoutput>
                        </td>
                        <td width="90%" style="padding-left:15px; font-family: sans-serif; font-size: 12px; line-height: 100%; color: #252422;">
                            <cfoutput>
                                <p>
                                <strong style="color:##C7152C; font-weight:700">Trucs & actuces</strong>
                                <br>
                                <cfoutput>#email_tips#</cfoutput>
                                </p>
                            </cfoutput>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </cfif> --->
        
        <cfinclude template="incl_email_footer2.cfm">
        
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>