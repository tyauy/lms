<cfinclude template="./incl_nav_beta.cfm">

<cfset l_id = 230385>
<cfset planner_id = 12127>
<cfparam name="status" default="reminder">
<cfparam name="recipient" default="learner">

<cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
    <cfinvokeargument name="l_id" value="#l_id#">
</cfinvoke>

<cfinvoke component="components/functions" method="get_dateformat" returnvariable="lesson_date_start">
    <cfinvokeargument name="datego" value="#get_lesson.lesson_start#">
    <cfinvokeargument name="lang" value="#lang#">
</cfinvoke>

<cfoutput>#lang#</cfoutput>

<cfsilent>


<cfset lesson_time_start = timeformat(get_lesson.lesson_start,'HH:mm')>
<cfset trainer_firstname = get_lesson.trainer_firstname>
<cfset learner_firstname = get_lesson.learner_firstname>
    
<cfset arr = ['learner_firstname','trainer_firstname', 'lesson_date_start', 'lesson_time_start']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
             
<cfset email_header_img = "header_email_lesson_booked.jpg">
<cfset email_icon = "icon_lesson_cancelled_late.png">

<!--- <cfset email_title = #obj_translater.get_translate_complex('mail_force_cancel_by_trainer_title', lang, argv)#>
<cfset email_subtitle = #obj_translater.get_translate_complex('mail_force_cancel_by_trainer_subtitle', lang, argv)#>
<cfset email_footer = #obj_translater.get_translate_complex('mail_force_cancel_by_trainer_footer', lang, argv)#> --->

<cfset email_title = "Next virtual lesson avail for booking !">
<cfset email_subtitle = "Salut les amigos, pour ceux qui étaient là, c'était sympa de vous voir. Et pour tous les autres, je vous attends pour la next VC !">
<cfset email_footer = "Vous recez cet email car vous suivez un parcours de formation VC, si vous souhaitez vous désabo, cliquez la !">

<cfset btn_lms = "Confirm my attendance">
<cfset btn_href = "go">
 
<cfset th_detail = #obj_translater.get_translate('global_details', lang)#>
<cfset th_trainer = #obj_translater.get_translate('table_th_trainer', lang)#>
<cfset th_learner = #obj_translater.get_translate('table_th_learner', lang)#>
<cfset th_date = #obj_translater.get_translate('table_th_date', lang)#>
<cfset th_hour = #obj_translater.get_translate('table_th_time', lang)#>
<cfset th_duration = #obj_translater.get_translate('table_th_duration_short', lang)#>
<cfset th_title = #obj_translater.get_translate('table_th_course', lang)#>

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
                                        <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/user/#planner_id#/photo.jpg" width="50" title="#get_lesson.trainer_firstname#" style="border-radius:50%; border:2px solid ##CE1D37 !important; margin-right:15px"></cfoutput>
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
        </tr>
        <cfif isdefined("btn_lms") AND btn_lms neq "" AND isdefined("btn_href") AND btn_href neq "">
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
        </cfif>
        
        <cfif isdefined("email_tips")>
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
        </cfif>
        
        <cfinclude template="incl_email_footer2.cfm">
        
    <!--[if mso | IE]>
    </td>
    </tr>
    </table>
    <![endif]-->
    </center>
</body>
</html>