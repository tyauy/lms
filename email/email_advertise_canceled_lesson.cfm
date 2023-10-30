<cfparam name="lang" default="fr">
<cfparam name="l_id">
<cfparam name="u_dest">
<cfparam name="cs" default="0">

<cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>

<cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
    <cfinvokeargument name="l_id" value="#l_id#">
</cfinvoke>

<cfinvoke component="components/functions" method="get_dateformat" returnvariable="lesson_date_start">
    <cfinvokeargument name="datego" value="#get_lesson.lesson_start#">
    <cfinvokeargument name="lang" value="#lang#">
</cfinvoke>

<cfset lesson_time_start = timeformat(get_lesson.lesson_start,'HH:mm')>
<cfset lesson_duration = get_lesson.lesson_duration>
<cfset trainer_firstname = get_lesson.trainer_firstname>
<cfset learner_firstname = u_dest>
    
<cfset arr = ['learner_firstname', 'lesson_date_start', 'lesson_time_start', 'lesson_duration']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<cfsilent>

<cfset email_header_img = "header_email_advertise_cancelled.jpg">
<cfset email_icon = "icon_reminder.png">

<cfinvoke component="components/translater" method="get_translate_complex" returnVariable="email_title">
    <cfinvokeargument name="id_translate" value="mail_adv_cancel_title"><cfinvokeargument name="lg_translate" value="#lang#"><cfinvokeargument name="argv" value="#argv#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate_complex" returnVariable="email_subtitle">
    <cfinvokeargument name="id_translate" value="mail_adv_cancel_subtitle"><cfinvokeargument name="lg_translate" value="#lang#"><cfinvokeargument name="argv" value="#argv#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate_complex" returnVariable="email_footer">
    <cfinvokeargument name="id_translate" value="mail_adv_cancel_footer"><cfinvokeargument name="lg_translate" value="#lang#"><cfinvokeargument name="argv" value="#argv#">
</cfinvoke>


<!--- <cfset email_title = #obj_translater.get_translate_complex('mail_adv_cancel_title', lang, argv)#>>
<cfset email_subtitle = #obj_translater.get_translate_complex('mail_adv_cancel_subtitle', lang, argv)#>>
<cfset email_footer = #obj_translater.get_translate_complex('mail_adv_cancel_footer', lang, argv)#>> --->


<cfset btn_href1 = "https://lms.wefitgroup.com/common_tp_details.cfm?late_lesson=#l_id#">
<cfset btn_lms1 = obj_translater.get_translate('btn_book_now_short', lang)>

<cfset btn_href2 = "https://lms.wefitgroup.com/common_learner_account.cfm">
<cfset btn_lms2 = obj_translater.get_translate('btn_my_account', lang)>

<cfinvoke component="components/translater" method="get_translate" returnVariable="th_detail">
    <cfinvokeargument name="id_translate" value="global_details"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_trainer">
    <cfinvokeargument name="id_translate" value="table_th_trainer"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_learner">
    <cfinvokeargument name="id_translate" value="table_th_learner"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_date">
    <cfinvokeargument name="id_translate" value="table_th_date"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_hour">
    <cfinvokeargument name="id_translate" value="table_th_time"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_duration">
    <cfinvokeargument name="id_translate" value="table_th_duration_short"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>
<cfinvoke component="components/translater" method="get_translate" returnVariable="th_title">
    <cfinvokeargument name="id_translate" value="table_th_course"><cfinvokeargument name="lg_translate" value="#lang#">
</cfinvoke>

<!--- <cfset th_detail = #obj_translater.get_translate('global_details', lang)#>
<cfset th_trainer = #obj_translater.get_translate('table_th_trainer', lang)#>
<cfset th_learner = #obj_translater.get_translate('table_th_learner', lang)#>
<cfset th_date = #obj_translater.get_translate('table_th_date', lang)#>
<cfset th_hour = #obj_translater.get_translate('table_th_time', lang)#>
<cfset th_duration = #obj_translater.get_translate('table_th_duration_short', lang)#>
<cfset th_title = #obj_translater.get_translate('table_th_course', lang)#> --->

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
                                    <td width="15%" style="">
                                        <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/user/#get_lesson.planner_id#/photo.jpg" width="50" title="#get_lesson.trainer_firstname#" style="border-radius:50%; border:2px solid ##CE1D37 !important; margin-right:15px"></cfoutput>
                                    </td>
                                    <td width="85%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                        <cfoutput>
                                        <p>#email_subtitle#
                                        <br>
                                        <span style="color:##C7152C; font-weight:600">#ucase(get_lesson.trainer_firstname)#</span>
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
                        <td width="10%">
                            
                        </td>
                        <td width="80%" style="background-color:#F3F3F3; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422; border-top:1px solid #C7152C; padding:10px">
                            <table width="100%" cellpadding="5">
                                <cfoutput>
                                <tr>
                                    <td align="center">
                                        <!-- Button : BEGIN -->
                                        <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                            <tr>
                                                <td class="button-td button-td-primary" style="border-radius: 3px;">
                                                    <a class="button-a button-a-primary" href="#btn_href1#" style="background: linear-gradient(##C7152C,##8A2128); font-family: sans-serif; font-size: 14px; line-height: 14px; text-decoration: none; padding: 10px 30px; display: block; border-radius: 3px;"><span class="button-link" style="color:##ffffff">#btn_lms1#</span></a>
                                                </td>
                                            </tr>
                                        </table>
                                        <!-- Button : END -->
                                    </td>
                                    <td align="left">
                                        <strong>#ucase(th_date)#</strong> : #lesson_date_start#
                                        <br>
                                        <strong>#ucase(th_hour)#</strong> : 
                                        <cfif isdefined("lang") AND lang eq "de"> Uhrzeit</cfif>
                                        #timeformat(get_lesson.lesson_start,'HH:mm')# - #timeformat(get_lesson.lesson_end,'HH:mm')#
                                        <cfif isdefined("lang") AND lang eq "de"> Uhr</cfif>
                                        <br>
                                        <strong>#ucase(th_duration)#</strong> : #get_lesson.lesson_duration# min
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
        </tr>
        <tr>
            <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                <!-- Button : BEGIN -->
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                    <tr>
                        <td class="button-td button-td-primary" style="border-radius: 3px;">
                            <a class="button-a button-a-primary" href="<cfoutput>#btn_href2#</cfoutput>" style="background: linear-gradient(#C7152C,#8A2128); font-family: sans-serif; font-size: 14px; line-height: 14px; text-decoration: none; padding: 10px 30px; display: block; border-radius: 3px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms2#</cfoutput></span></a>
                        </td>
                    </tr>
                </table>
                <!-- Button : END -->
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