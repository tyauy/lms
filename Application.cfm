<cfapplication name="bo_lms_live" clientmanagement="yes" sessionmanagement="yes" loginstorage="session" sessiontimeout="#CreateTimeSpan( 0, 2, 0, 0 )#">

<cfset SESSION.BDDSOURCE = "lms-1">

<cfset SESSION.BO_ROOT = "/home/www/wnotedev1/www/manager/lms">
<cfset SESSION.BO_ROOT_COMPONENT = "components">
<cfset SESSION.BO_ROOT_API = "api">
<cfset SESSION.BO_ROOT_URL = "https://lms.wefitgroup.com">
<cfset SESSION.BO_CONNECT_URL = "https://lms.wefitgroup.com">
<cfif server.coldfusion.productlevel eq "Developer">
	<cfset SESSION.BO_ROOT_URL = "http://localhost:8500/dev/lms">
	<cfset SESSION.BO_CONNECT_URL = "http://localhost:8500">
</cfif>

<cfset SESSION.CFMAIL_USERNAME = "rremacle@wefitgroup.com">
<cfset SESSION.CFMAIL_PASSWORD = "xcarUCRF796tWsTv">
<cfset SESSION.CFMAIL_SERVER = "smtp-relay.brevo.com">
<cfset SESSION.CFMAIL_PORT = "587">

<cfset SESSION.LISTMONTHS = "Janvier,F&eacute;vrier,Mars,Avril,Mai,Juin,Juillet,Ao&ucirc;t,Septembre,Octobre,Novembre,D&eacute;cembre">
<cfset SESSION.LISTMONTHS_SHORT = "Jan,F&eacute;v,Mars,Avril,Mai,Juin,Juil,Ao&ucirc;t,Sept,Oct,Nov,D&eacute;c">
<cfset SESSION.LISTMONTHS_JS = "Jan,Fev,Mars,Avril,Mai,Juin,Juil,Aout,Sept,Oct,Nov,Dec">
<cfset SESSION.LISTMONTHS_SHORT_FR = "Jan,F&eacute;v,Mars,Avril,Mai,Juin,Juil,Ao&ucirc;t,Sept,Oct,Nov,D&eacute;c">

<cfset SESSION.LISTMONTHS_SHORT_EN = "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sept,Oct,Nov,Dec">
<cfset SESSION.LISTMONTHS_SHORT_DE = "Jan,Feb,Marz,April,Mai,Juni,Juli,Aug,Sept,Okt,Nov,Dez">
<cfset SESSION.LISTMONTHS_SHORT_ES = "Ene,Feb,Mar,Abr,May,Jun,Jul,Ago,Sept,Oct,Nov,Dic">
<cfset SESSION.LISTMONTHS_SHORT_IT = "Genn,Febbr,Mar,Apr,Magg,Giugno,Luglio,Ag,Sett,Ott,Nov,Dic">
<cfset SESSION.LISTMONTHS_CODE = "01,02,03,04,05,06,07,08,09,10,11,12">

<cfset SESSION.LISTMONTHS_EN = "January,February,March,April,May,June,July,August,September,October,November,December">
<cfset SESSION.LISTMONTHS_DE = "Januar,Februar,M&auml;rz,April,Mai,Juni,Juli,August,September,Oktober,November,Dezember">
<cfset SESSION.LISTMONTHS_ES = "Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre">
<cfset SESSION.LISTMONTHS_IT = "Gennaio,Febbraio,Marzo,Aprile,Maggio,Giugno,Luglio,Agosto,Settembre,Ottobre,Novembre,Dicembre">

<cfset SESSION.DAYWEEK_FR = "LUN,MAR,MER,JEU,VEN,SAM,DIM">
<cfset SESSION.DAYWEEK_FR_SHORT = "D,L,M,M,J,V,S">
<cfset SESSION.DAYWEEK_EN = "MON,TUE,WED,THU,FRI,SAT,SUN">
<cfset SESSION.DAYWEEK_EN_SHORT = "S,M,T,W,T,F,S">
<cfset SESSION.DAYWEEK_DE = "MO,DI,MI,DO,FR,SA,SO">
<cfset SESSION.DAYWEEK_DE_SHORT = "S,M,D,M,D,F,S">
<cfset SESSION.DAYWEEK_ES = "LUN,MAR,MIE,JUE,VIE,SAB,DOM">
<cfset SESSION.DAYWEEK_IT = "LUN,MAR,MER,GIO,VEN,SAB,DO">

<cfset SESSION.DAYWEEK_FR_MIN = "lun,mar,mer,jeu,ven,sam,dim">
<cfset SESSION.DAYWEEK_EN_MIN = "mon,tue,wed,thu,fri,sat,sun">
<cfset SESSION.DAYWEEK_DE_MIN = "mo,di,mi,do,fr,sa,so">
<cfset SESSION.DAYWEEK_ES_MIN = "lun,mar,mie,jue,vie,sab,som">
<cfset SESSION.DAYWEEK_IT_MIN = "lun,mar,mer,gio,ven,sab,do">

<cfset SESSION.DAYWEEK_ORDERED_FR = "Dim,Lun,Mar,Mer,Jeu,Ven,Sam">
<cfset SESSION.DAYWEEK_ORDERED_EN = "Sun,Mon,Tue,Wed,Thu,Fri,Sat">
<cfset SESSION.DAYWEEK_ORDERED_DE = "so,mo,di,mi,do,fr,sa">
<cfset SESSION.DAYWEEK_ORDERED_ES = "som,lun,mar,mie,jue,vie,sab">
<cfset SESSION.DAYWEEK_ORDERED_IT = "do,lun,mar,mer,gio,ven,sab">

<cfset SESSION.LIST_LANGUAGES = "Fran&ccedil;ais,English,Espa&ntilde;ol,Deutsch,Italiano">
<cfset SESSION.LIST_LANGUAGES_SHORT = "fr,en,de,es,it">
<cfset SESSION.LIST_HOURS = "00:00,00:15,00:30,00:45,01:00,01:15,01:30,01:45,02:00,02:15,02:30,02:45,03:00,03:15,03:30,03:45,04:00,04:15,04:30,04:45,05:00,05:15,05:30,05:45,06:00,06:15,06:30,06:45,07:00,07:15,07:30,07:45,08:00,08:15,08:30,08:45,09:00,09:15,09:30,09:45,10:00,10:15,10:30,10:45,11:00,11:15,11:30,11:45,12:00,12:15,12:30,12:45,13:00,13:15,13:30,13:45,14:00,14:15,14:30,14:45,15:00,15:15,15:30,15:45,16:00,16:15,16:30,16:45,17:00,17:15,17:30,17:45,18:00,18:15,18:30,18:45,19:00,19:15,19:30,19:45,20:00,20:15,20:30,20:45,21:00,21:15,21:30,21:45,22:00,22:15,22:30,22:45,23:00,23:15,23:30,23:45">
<cfset SESSION.LIST_PT = "fr,en,de,es,it,ru,nl,pt,zh">
<cfset SESSION.LIST_SUBLEVEL = "A1_1,A1_2,A1_3,A2_1,A2_2,A2_3,B1_1,B1_2,B1_3,B2_1,B2_2,B2_3,C1_1,C1_2,C1_3">

<cfset SESSION.REPORT_OPTION = {
	finance_order_list_get: {
		path: "api/orders/orders_get",
		method: "oget_orders",
		role: "2,5"
	}
}>

<cfset obj_query = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.queries")>
<cfset obj_charter = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.charter")>
<cfset obj_dater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.dater")>
<cfset obj_provider = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.provider")>
<cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
<cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
<cfset obj_number = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.number")>
<cfset obj_function = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.functions")>
<cfset obj_core = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.core")>

<cfset obj_task_get = createobject("component", "#SESSION.BO_ROOT_API#.task.task_get")>
<cfset obj_task_post = createobject("component", "#SESSION.BO_ROOT_API#.task.task_post")>

<cfset obj_user_get = createobject("component", "#SESSION.BO_ROOT_API#.users.user_get")>
<cfset obj_user_post = createobject("component", "#SESSION.BO_ROOT_API#.users.user_post")>

<cfset obj_user_trainer_get = createobject("component", "#SESSION.BO_ROOT_API#.users.user_trainer_get")>
<cfset obj_user_trainer_post = createobject("component", "#SESSION.BO_ROOT_API#.users.user_trainer_post")>

<cfset obj_tp_get = createobject("component", "#SESSION.BO_ROOT_API#.tp.tp_get")>
<cfset obj_tp_post = createobject("component", "#SESSION.BO_ROOT_API#.tp.tp_post")>

<cfset obj_order_get = createobject("component", "#SESSION.BO_ROOT_API#.orders.orders_get")>
<cfset obj_order_post = createobject("component", "#SESSION.BO_ROOT_API#.orders.orders_post")>

<cfset obj_account_get = createobject("component", "#SESSION.BO_ROOT_API#.account.account_get")>
<cfset obj_account_post = createobject("component", "#SESSION.BO_ROOT_API#.account.account_post")>

<cfset obj_quiz_get = createobject("component", "#SESSION.BO_ROOT_API#.quiz.quiz_get")>
<cfset obj_quiz_post = createobject("component", "#SESSION.BO_ROOT_API#.quiz.quiz_post")>

<cfif not findnocase("cron_", PATH_TRANSLATED) 
AND not findnocase("_modal_window_mdp_reset", PATH_TRANSLATED) 
AND not findnocase("_updater_mdp", PATH_TRANSLATED) 
AND not findnocase("_reinit", PATH_TRANSLATED) 
AND not findnocase("_form", PATH_TRANSLATED)
AND not findnocase("_viewer", PATH_TRANSLATED)
AND not findnocase("_sign", PATH_TRANSLATED)
AND not findnocase("_note", PATH_TRANSLATED)
AND not findnocase("convention_container", PATH_TRANSLATED)
AND not findnocase("aff_container", PATH_TRANSLATED)
AND not findnocase("estimate_container", PATH_TRANSLATED)
AND not findnocase("_fne_subscribe", PATH_TRANSLATED)
AND not findnocase("_fne_subscribe_sign", PATH_TRANSLATED)
AND not findnocase("_subscribe", PATH_TRANSLATED)
AND not findnocase("_updater_subscribe", PATH_TRANSLATED)
AND not findnocase("_updater_note", PATH_TRANSLATED)
AND not findnocase("connect2", PATH_TRANSLATED)
AND not findnocase("modal_window_cgu", PATH_TRANSLATED)
AND not findnocase("modal_window_contact", PATH_TRANSLATED)
AND not findnocase("modal_window_info", PATH_TRANSLATED)
AND not findnocase("cornerstone_connect", PATH_TRANSLATED)
AND not findnocase("connect_google", PATH_TRANSLATED)
AND not findnocase("connect_microsoft", PATH_TRANSLATED)
AND not findnocase("connect_validate", PATH_TRANSLATED)
AND not findnocase("_updater_validate", PATH_TRANSLATED)
>


<!--- <cfif isDefined("gggo") OR isdefined("state")>
	<cfoauth
	type = "Google"
	clientid = "server.clientid"
	secretkey = "server.clientid"
	result = "res"
	state = "gg_auth"
	redirecturi = "#SESSION.BO_ROOT_URL#/index.cfm" >
</cfif> --->


<!--- <cfset SESSION.PROFILE_LIST_NAME = ""> --->



<!--- OR isdefined("state") --->
<cfif (isdefined("user_password") AND isdefined("user_name")) OR isdefined("upass")>

	<cfset incl="1">
	<cfinclude template="connect_out.cfm">
	
	<cfif not isdefined("upass") AND not isDefined("state")>
		<cfset temp = hash(user_password)>
	</cfif>	
	
	<cfquery name="get_user" dataSource="#SESSION.BDDSOURCE#"> 
	SELECT 
	u.user_id, u.account_id, u.user_ismanager, u.user_status_id, u.user_type_id, u.timezone_id, u.contact_id, u.user_gender, u.user_firstname, u.user_name, u.user_alias, u.user_temp_alias, u.user_email, u.user_email_2, u.user_phone, u.user_phone_2, u.user_phone_code, u.user_phone_2_code, u.user_password, u.user_pwd_chg, u.user_create, u.user_color, u.user_css, u.user_lang, u.user_charter, u.situation_id, u.interest_id, u.function_id, u.business_id, u.method_id, u.speciality_id, u.country_id, u.avail_id, u.perso_id, u.expertise_id, u.techno_id, u.certif_id, u.user_jobtitle, u.user_birthday, u.user_based, u.user_adress, u.user_postal, u.user_city, u.user_company, u.user_school, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, u.country_id_inv, u.user_news, u.user_needs, u.user_needs_course, u.user_needs_trainer, u.user_needs_frequency, u.user_needs_nbtrainer, u.user_needs_learn, u.user_needs_complement, u.user_needs_trainer_complement, u.user_needs_theme, u.user_needs_duration, u.user_needs_speaking_id, u.user_needs_expertise_id, u.user_remind_1d, u.user_remind_3h, u.user_remind_1h, u.user_remind_15m, u.user_remind_missed, u.user_remind_cancelled, u.user_remind_scheduled, u.user_notification_late_canceled, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h, u.user_remind_sms_15m, u.user_remind_sms_missed, u.user_remind_sms_scheduled, u.user_hide_report_all, u.user_hide_report_free_remain, u.user_steps, u.user_level, u.user_access_tp, u.user_el_list, u.user_shortlist, u.user_elapsed, u.user_lastconnect, u.user_md5, u.user_blocker, u.user_visio_rate, u.user_f2f_rate, u.user_add_course, u.user_add_learner, u.user_paid_global, u.user_paid_missed, u.user_paid_tva, u.user_resume, u.user_video, u.user_video_link, u.user_signature, u.user_abstract, u.user_account_right_id, u.user_session_right_id, u.user_widget, u.user_pref_task_group, u.user_appointlet, u.user_ref, u.user_ref2, u.user_ctc_cpf, u.user_ctc_formation, u.user_optin, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr, u.user_setup, u.user_gymglish_link, u.user_pt_mandatory,
	up.*, 
	tz.*, a.account_id, a.account_name, a.group_id, a.provider_id,
	s.user_status_name_fr as user_status_name,
	t.user_type_name_fr as user_type_name,
	ac.contact_id
	FROM user u
	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
	LEFT JOIN user_type t ON t.user_type_id = u.user_type_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id != 11
	INNER JOIN user_profile up ON upc.profile_id = up.profile_id
	LEFT JOIN account a ON a.account_id = u.account_id
	LEFT JOIN settings_timezone tz ON tz.timezone_id = u.timezone_id
	LEFT JOIN account_contact ac ON ac.user_id = u.user_id
	<cfif isdefined("upass")>
	WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">
	AND user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#upass#">
	AND u.user_status_id <> 5
	<cfelse>
	WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">
	AND user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#temp#">
	AND u.user_status_id <> 5
	</cfif>
	<cfif isdefined("upid")>
		AND up.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#upid#">
	</cfif>
	LIMIT 1
	</cfquery> 

	
		
	<!--- AT LEAST 1 USER EXISTS WITH THIS EMAIL / PASSWORD --->
	<cfif get_user.recordcount NEQ "0">
	
		<cfset SESSION.USER_PROFILE_ID = get_user.profile_id>
		<cfset SESSION.USER_PROFILE = get_user.profile_name>
		<cfset SESSION.USER_PROFILE_CSS = get_user.profile_css>

		<!--- For Multi select --->
		<cfset SESSION.booking_array = {}>

		
		<cfinclude template="Application_vars.cfm">
			
	<cfelse>

		<cfset incl="1">
		<cfset error="1">
		<cfinclude template="connect_out.cfm">

	</cfif>

	
	
	
</cfif>

<cfif not isdefined("SESSION.USER_SHORTLIST")>
	<cfset SESSION.USER_SHORTLIST = "">
</cfif>

<cfif isdefined("url.lg") AND listfind(SESSION.LIST_LANGUAGES_SHORT,url.lg)> 
	<cfswitch expression="#url.lg#">
		<cfcase value="fr"><cfset SESSION.LANG = "1"><cfset SESSION.LANG_CODE = url.lg></cfcase>
		<cfcase value="en"><cfset SESSION.LANG = "2"><cfset SESSION.LANG_CODE = url.lg></cfcase>
		<cfcase value="de"><cfset SESSION.LANG = "3"><cfset SESSION.LANG_CODE = url.lg></cfcase>
		<cfcase value="es"><cfset SESSION.LANG = "4"><cfset SESSION.LANG_CODE = url.lg></cfcase>
		<cfcase value="it"><cfset SESSION.LANG = "5"><cfset SESSION.LANG_CODE = url.lg></cfcase>
	</cfswitch>
</cfif>



<!------------ IF SEVERAL ACCOUNTS + SWITCH PROFILE, SCAN QUERY AND CONNECT AGAIN WITH NEW PROFILE ---------->
<cfif isdefined("url.switch_profile") AND isdefined("SESSION.PROFILE_LIST") AND isdefined("SESSION.USER_ID")>
	
	<cfloop query="#SESSION.PROFILE_LIST#">
		<cfif SESSION.PROFILE_LIST.profile_id eq url.switch_profile>
			<cfset SESSION.USER_PROFILE = SESSION.PROFILE_LIST.profile_name>
			<cfset SESSION.USER_PROFILE_CSS = SESSION.PROFILE_LIST.profile_css>
			<cfset SESSION.USER_PROFILE_ID = SESSION.PROFILE_LIST.profile_id>

			<cfquery name="get_user" dataSource="#SESSION.BDDSOURCE#"> 
			SELECT 
			u.user_id, u.account_id, u.user_ismanager, u.user_status_id, u.user_type_id, u.timezone_id, u.contact_id, u.user_gender, u.user_firstname, u.user_name, u.user_alias, u.user_temp_alias, u.user_email, u.user_email_2, u.user_phone, u.user_phone_2, u.user_phone_code, u.user_phone_2_code, u.user_password, u.user_pwd_chg, u.user_create, u.user_color, u.user_css, u.user_lang, u.user_charter, u.situation_id, u.interest_id, u.function_id, u.business_id, u.method_id, u.speciality_id, u.country_id, u.avail_id, u.perso_id, u.expertise_id, u.techno_id, u.certif_id, u.user_jobtitle, u.user_birthday, u.user_based, u.user_adress, u.user_postal, u.user_city, u.user_company, u.user_school, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, u.country_id_inv, u.user_news, u.user_needs, u.user_needs_course, u.user_needs_trainer, u.user_needs_frequency, u.user_needs_nbtrainer, u.user_needs_learn, u.user_needs_complement, u.user_needs_trainer_complement, u.user_needs_theme, u.user_needs_duration, u.user_needs_speaking_id, u.user_needs_expertise_id, u.user_remind_1d, u.user_remind_3h, u.user_remind_1h, u.user_remind_15m, u.user_remind_missed, u.user_remind_cancelled, u.user_remind_scheduled, u.user_notification_late_canceled, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h, u.user_remind_sms_15m, u.user_remind_sms_missed, u.user_remind_sms_scheduled, u.user_hide_report_all, u.user_hide_report_free_remain, u.user_steps, u.user_level, u.user_access_tp, u.user_el_list, u.user_shortlist, u.user_elapsed, u.user_lastconnect, u.user_md5, u.user_blocker, u.user_visio_rate, u.user_f2f_rate, u.user_add_course, u.user_add_learner, u.user_paid_global, u.user_paid_missed, u.user_paid_tva, u.user_resume, u.user_video, u.user_video_link, u.user_signature, u.user_abstract, u.user_account_right_id, u.user_session_right_id, u.user_widget, u.user_pref_task_group, u.user_appointlet, u.user_ref, u.user_ref2, u.user_ctc_cpf, u.user_ctc_formation, u.user_optin, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr, u.user_setup, u.user_gymglish_link, u.user_pt_mandatory,
			up.*, 
			tz.*, a.account_id, a.account_name, a.group_id, a.provider_id,
			s.user_status_name_fr as user_status_name,
			t.user_type_name_fr as user_type_name,
			ac.contact_id
			FROM user u
			LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
			LEFT JOIN user_type t ON t.user_type_id = u.user_type_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
			INNER JOIN user_profile up ON upc.profile_id = up.profile_id
			LEFT JOIN account a ON a.account_id = u.account_id
			LEFT JOIN settings_timezone tz ON tz.timezone_id = u.timezone_id
			LEFT JOIN account_contact ac ON ac.user_id = u.user_id
			WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ID#">
			LIMIT 1
			</cfquery>
			
			<cfinclude template="Application_vars.cfm">

		</cfif>
	</cfloop>
	
</cfif>


<!------------------------- BOOT USER IF NOT CONNECTED -------------------->
<cfif not isdefined("SESSION.USER_ID")>
	
	<cfinclude template="connect.cfm"> 
	<cfabort>

</cfif>


</cfif>