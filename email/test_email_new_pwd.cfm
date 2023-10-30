<cfinclude template="./incl_nav_beta.cfm">

<cfparam name="lang" default="fr">
<cfparam name="step" default="new_pwd">
<cfset u_id = 411>

<cfif not isdefined("lang")>
    <cfset lang = "fr">
</cfif>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>


<cfsilent>
   

<cfset user_firstname = get_user.user_firstname>
<cfset user_lastname = ucase(get_user.user_name)>
<cfset user_email = get_user.user_email>

<cfset arr = ['user_firstname', 'user_lastname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<cfif step eq "new_pwd">

	<cfset email_title = obj_translater.get_translate_complex('mail_new_pwd_title', lang)>
	<cfset email_subtitle = obj_translater.get_translate_complex('mail_new_pwd_subtitle', lang, argv)>


    <cfset email_header_img = "header_email_pwd_new.jpg">
    <cfset email_icon = "icon_lesson_booked.png">

    <cfset btn_href = "https://lms.wefitgroup.com/">
    <cfset btn_lms = "#obj_translater.get_translate('btn_lms_connect', lang)#">

<cfelseif step eq "reset_pwd">

    <cfset reinit = "1">
    <cfset temp = "123456">

    <cfquery name="get_email" datasource="#SESSION.BDDSOURCE#">
    SELECT user_id, user_lang FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
    </cfquery>

    <cfset email_title = obj_translater.get_translate_complex('mail_reset_mdp_title', lang)>
    <cfset email_subtitle =  obj_translater.get_translate_complex('mail_reset_mdp_subtitle', lang)>
    <cfset btn_lms = obj_translater.get_translate_complex('mail_reset_mdp_btn', lang)>
    <cfset footer_txt = obj_translater.get_translate_complex('mail_reset_mdp_footer', lang)>


    <cfset btn_href = "https://lms.wefitgroup.com/_reinit.cfm?phsh=#temp#&u_id=#get_email.user_id#">


    <!--- <cfset email_title = #obj_translater.get_translate_complex('mail_pta_booked_title', lang, argv)#>
    <cfset email_subtitle = #obj_translater.get_translate_complex('mail_pta_booked_subtitle', lang)#> --->
    <cfset email_header_img = "header_email_pwd_reset.jpg">
    <cfset email_icon = "icon_lesson_booked.png">
</cfif>

<cfset th_login = #obj_translater.get_translate('table_th_login', lang)#>
<cfset th_url = #obj_translater.get_translate('table_th_url', lang)#>
<cfset th_email = #obj_translater.get_translate('form_subscription_2', lang)#>
<cfset th_temp_pwd = #obj_translater.get_translate('table_th_tmp_pwd', lang)#>
<cfset th_prompt = #obj_translater.get_translate_complex('new_mail_prompt', lang)#>
<cfset btn_connect = #obj_translater.get_translate('btn_connect', lang)#>
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
                <td style="background-color: #ffffff; padding: 0px 30px 20px 30px;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td width="26%" style="">
                                <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/unknown_female.png" width="50" title="Cindy" style="border-radius:50%; border: 2px solid ##8A2128 !important; margin-right:15px" align="right"></cfoutput>
                            </td>
                            <td width="74%" style="font-family: sans-serif; font-size: 15px; line-height: 140%; color: #252422;">
                                <cfoutput>
                                <p>#email_subtitle#
                                <br>
                                <span style="color:##C7152C; font-weight:600">Happy Customer Service</span>
                                </p>
                                </cfoutput>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td style="background-color: #ffffff; padding: 20px 30px 20px 30px;">
                    <!-- Button : BEGIN -->
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                        <tr>
                            <td class="button-td button-td-primary" style="border-radius: 17px;">
                                <a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: linear-gradient(#C7152C,#8A2128); font-family: sans-serif; font-size: 14px; line-height: 14px; text-decoration: none; padding: 10px 30px; display: block; border-radius: 17px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput></span></a>
                            </td>
                        </tr>
                    </table>
                    <!-- Button : END -->
                </td>
            </tr>
            
            <!---<tr>
                <td style="background-color: #ffffff; padding: 0px 30px 20px 30px;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td width="30" style="padding-right:15px; border-right:2px solid #C7152C">
                                <cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/img/icon_tips.png" width="30" style=""></cfoutput>
                            </td>
                            <td width="510" style="padding-left:15px; font-family: sans-serif; font-size: 12px; line-height: 100%; color: #252422;">
                                <cfoutput>
                                    <p>
                                    <strong style="color:##C7152C; font-weight:700">Trucs & actuces</strong>
                                    <br>
                                    Indicabant ad Tyrii confessisque conpulsus litterae etiam inductus Christiani vitae tortis textrini tuniculam prolatae diaconus manicis discrimen textam est tortis.

                                    </p>
                                </cfoutput>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>--->
                
            
            <cfinclude template="incl_email_footer2.cfm">
            
        <!--[if mso | IE]>
        </td>
        </tr>
        </table>
        <![endif]-->
        </center>
    </body>
    </html>