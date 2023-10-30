<!--- https://www.bennadel.com/blog/726-coldfusion-SESSION-cfc-tutorial-and-SESSION-cfc-reference.htm --->

<cfcomponent displayname="bo_lms_live" output="true" hint="Handle the SESSION.">


<!--- Set up the SESSION. --->
<cfset THIS.Name = "bo_lms_live" />
<!--- <cfset THIS.SESSIONTimeout = CreateTimeSpan( 0, 0, 1, 0 ) /> --->
<cfset THIS.ClientManagement = true />
<cfset THIS.SessionManagement = true />
<cfset THIS.SessionTimeout = "#CreateTimeSpan( 0, 2, 0, 0 )#" />
<cfset THIS.LoginStorage = "session" />
<!--- <cfset THIS.SetClientCookies = false /> --->

<cfset THIS.restSettings.restEnabled=true>
<cfset THIS.serialization.preserveCaseForStructKey=true>
<cfset THIS.serialization.preserveCaseForQueryColumn=true>


<!--- Define the page request properties. --->
<!--- <cfsetting requesttimeout="20" showdebugoutput="false" enablecfoutputonly="false" /> --->


	<cffunction
		name="OnSESSIONStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the SESSION is first created.">

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
		<cfset SESSION.CFMAIL_SERVER = "smtp-relay.sendinblue.com">
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
		<cfset SESSION.LISTMONTHS_SHORT_DE = "Januar,Februar,M&auml;rz,April,Mai,Juni,Juli,August,September,Oktober,November,Dezember">
		<cfset SESSION.LISTMONTHS_SHORT_ES = "Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre">
		<cfset SESSION.LISTMONTHS_SHORT_IT = "Gennaio,Febbraio,Marzo,Aprile,Maggio,Giugno,Luglio,Agosto,Settembre,Ottobre,Novembre,Dicembre">

		<cfset SESSION.DAYWEEK_FR = "LUN,MAR,MER,JEU,VEN,SAM,DIM">
		<cfset SESSION.DAYWEEK_EN = "MON,TUE,WED,THU,FRI,SAT,SUN">
		<cfset SESSION.DAYWEEK_DE = "MO,DI,MI,DO,FR,SA,SO">
		<cfset SESSION.DAYWEEK_ES = "LUN,MAR,MIE,JUE,VIE,SAB,DOM">
		<cfset SESSION.DAYWEEK_IT = "LUN,MAR,MER,GIO,VEN,SAB,DO">

		<cfset SESSION.DAYWEEK_FR_MIN = "lun,mar,mer,jeu,ven,sam,dim">
		<cfset SESSION.DAYWEEK_EN_MIN = "mon,tue,wed,thu,fri,sat,sun">
		<cfset SESSION.DAYWEEK_DE_MIN = "mo,di,mi,do,fr,sa,so">
		<cfset SESSION.DAYWEEK_ES_MIN = "lun,mar,mie,jue,vie,sab,som">
		<cfset SESSION.DAYWEEK_IT_MIN = "lun,mar,mer,gio,ven,sab,do">

		<cfset SESSION.DAYWEEK_ORDERED_FR = "Dimanche,Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi">

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


		<cfreturn true />
	</cffunction>


	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">

		<!--- login --->
        <!--- <cfset SESSION.BDDSOURCE = "lms-1">
        <cfset SESSION.LANG_CODE = "fr"> --->
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>

		<!--- Return out. --->
		<cfreturn true />
	</cffunction>


	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>

		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete.">

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnSessionEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="SessionScope"
			type="struct"
			required="true"
			/>

		<cfargument
			name="SESSIONScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>

        <cfscript>
            structdelete(SESSION, "LANG_CODE")
        </cfscript>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnSESSIONEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the SESSION is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="SESSIONScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnError"
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch.">

		<!--- Define arguments. --->
		<cfargument
			name="Exception"
			type="any"
			required="true"
			/>

		<cfargument
			name="EventName"
			type="string"
			required="false"
			default=""
			/>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>

</cfcomponent>