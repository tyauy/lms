<cfset u_id = 411>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>

<cfparam name="lang" default="fr">
<cfparam name="step" default="new_pwd">

<cfinclude template="./incl_nav_beta.cfm">

<cfsilent>
<cfset user_firstname = get_user.user_firstname>
<cfset user_lastname = ucase(get_user.user_name)>
<cfset arr = ['user_firstname', 'user_lastname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<cfset email_title = "title">
<cfset email_subtitle = "subtitle">
<!--- <cfset email_title = #obj_translater.get_translate_complex('mail_pta_booked_title', lang, argv)#>
<cfset email_subtitle = #obj_translater.get_translate_complex('mail_pta_booked_subtitle', lang)#> --->
<cfset email_header_img = "header_email_pwd_new.jpg">
<cfset email_icon = "icon_lesson_booked.jpg">

<cfset th_login = #obj_translater.get_translate('table_th_login', lang)#>
<cfset th_url = #obj_translater.get_translate('table_th_url', lang)#>
<cfset th_email = #obj_translater.get_translate('form_subscription_2', lang)#>
<cfset th_temp_pwd = #obj_translater.get_translate('table_th_tmp_pwd', lang)#>
<cfset th_prompt = #obj_translater.get_translate_complex('new_mail_prompt', lang)#>
<cfset btn_connect = #obj_translater.get_translate('btn_connect', lang)#>


</cfsilent>