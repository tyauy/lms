<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,4,5,6,8,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="view" default="active">

<cfif isdefined("p_id") AND (listFindNoCase("LEARNER,TM,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>

	<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>
	
	<cfset p_id = get_planner.user_id>
	<cfset user_name = get_planner.user_name>
	<cfset user_email = get_planner.user_email>
	<cfset user_alias = get_planner.user_alias>
	<cfset user_firstname = get_planner.user_firstname>
	<cfset user_phone = get_planner.user_phone>
	
	<cfset country_id = get_planner.country_id>
	<cfset avail_id = get_planner.avail_id>
	<cfset method_id = get_planner.method_id>
	<cfset user_based = get_planner.user_based>
	<cfset interest_id = get_planner.interest_id>
	<cfset speciality_id = get_planner.speciality_id>
	<!--- <cfset perso_id = get_planner.perso_id> --->
	<cfset expertise_id = get_planner.expertise_id>	
	
	<cfset user_resume = get_planner.user_resume>
	<cfset user_abstract = get_planner.user_abstract>
	<cfset user_video = get_planner.user_video>
	<cfset user_create = get_planner.user_create>
	
	<cfset user_remind_1d = get_planner.user_remind_1d>
	<cfset user_remind_3h = get_planner.user_remind_3h>
	<cfset user_remind_15m = get_planner.user_remind_15m>	
	<cfset user_remind_missed = get_planner.user_remind_missed>
	<cfset user_remind_cancelled = get_planner.user_remind_cancelled>
	<cfset user_remind_scheduled = get_planner.user_remind_scheduled>
	
	<cfset user_remind_sms_15m = get_planner.user_remind_sms_15m>
	<cfset user_remind_sms_missed = get_planner.user_remind_sms_missed>
	<cfset user_remind_sms_scheduled = get_planner.user_remind_sms_scheduled>	
	
	<cfset user_blocker = get_planner.user_blocker>
	
	<cfset user_timezone = get_planner.user_timezone>
	<cfset user_lang = get_planner.user_lang>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<cfset get_planner = obj_query.oget_planner(p_id="#SESSION.USER_ID#")>
	
	<cfset p_id = SESSION.USER_ID>
	<cfset user_id = SESSION.USER_ID>
	<cfset user_name = SESSION.USER_NAME>
	<cfset user_email = SESSION.USER_EMAIL>
	<cfset user_alias = SESSION.USER_ALIAS>
	<cfset user_firstname = SESSION.USER_FIRSTNAME>
	<cfset user_phone = SESSION.USER_PHONE>
	
	<cfset country_id = SESSION.COUNTRY_ID>
	<cfset avail_id = SESSION.AVAIL_ID>
	<cfset method_id = SESSION.METHOD_ID>
	<cfset user_based = SESSION.USER_BASED>
	<cfset interest_id = SESSION.INTEREST_ID>
	<cfset expertise_id = SESSION.EXPERTISE_ID>
	
	<cfset user_resume = get_planner.user_resume>
	<cfset user_abstract = get_planner.user_abstract>
	
	<cfset user_remind_1d = SESSION.USER_REMIND_1D>
	<cfset user_remind_3h = SESSION.USER_REMIND_3H>
	<cfset user_remind_15m = SESSION.USER_REMIND_15M>
	<cfset user_remind_missed = SESSION.USER_REMIND_MISSED>
	<cfset user_remind_cancelled = SESSION.USER_REMIND_CANCELLED>
	<cfset user_remind_scheduled = SESSION.USER_REMIND_SCHEDULED>
	
	<cfset user_remind_sms_15m = SESSION.USER_REMIND_SMS_15M>
	<cfset user_remind_sms_missed = SESSION.USER_REMIND_SMS_MISSED>
	<cfset user_remind_sms_scheduled = SESSION.USER_REMIND_SMS_SCHEDULED>
	
	<cfset user_blocker = SESSION.USER_BLOCKER>
	
	<cfset user_timezone = SESSION.USER_TIMEZONE>
	<cfset user_lang = SESSION.USER_LANG>
	
<cfelse>

	<cflocation addtoken="no" url="index.cfm">

</cfif>

<cfparam name="tab" default="learners">

<cfquery name="get_workinghour" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user_workinghour WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	.nav-link {
		color: #999 !important;
		display:inline !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}
	</style>
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfif SESSION.USER_PROFILE eq "learner">
			<cfset title_page = "#obj_translater.get_translate('title_page_common_trainer_learnerview')#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_common_trainer_trainerview')#">
		</cfif>
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<cfinclude template="./incl/incl_nav_trainer.cfm">
			
			<cfif view eq "active">
				<cfset st_id = "1,2">
				<cfset ust_id = "1,2,3,4">
				<cfset m_id = "100">
				<cfset pf_id = "100">
			<cfelseif view eq "all">
				<cfset st_id = "100">
				<cfset ust_id = "100">
				<cfset m_id = "100">
				<cfset pf_id = "100">
			<cfelseif view eq "tolaunch">
				<cfset st_id = "1">
				<cfset ust_id = "1,2,3,4">
				<cfset m_id = "100">
				<cfset pf_id = "100">	
			<cfelseif view eq "nnl">
				<cfset st_id = "100">
				<cfset ust_id = "4">
				<cfset m_id = "100">
				<cfset pf_id = "100">	
			<cfelseif view eq "badl">
				<cfset st_id = "100">
				<cfset ust_id = "4">
				<cfset m_id = "100">
				<cfset pf_id = "100">
			<cfelseif view eq "inactive">
				<cfset st_id = "100">
				<cfset ust_id = "5">
				<cfset m_id = "100">
				<cfset pf_id = "100">
			</cfif>

			<cfset get_learner = obj_query.oget_learner(ust_id="#ust_id#",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#")>
			
			<!--- <cfdump var="#get_learner#"> --->
			
			
			<cfinclude template="./widget/wid_learner_list_cs.cfm">
			
			
		</div>
			
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>


$(document).ready(function() {

	$('.btn_trainer_edit_avail').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_avail_edit')#</cfoutput>");		
		$('#modal_body_lg').load("modal_window_trainer.cfm?display=avail&p_id=<cfoutput>#p_id#</cfoutput>");
	});
	
	$('.btn_trainer_edit_speciality').click(function(event) {
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_special_edit')#</cfoutput>");		
		$('#modal_body_lg').load("modal_window_trainer.cfm?display=speciality&p_id=<cfoutput>#p_id#</cfoutput>");
	});

});
</script>
</body>
</html>