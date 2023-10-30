<cfset p_id = u_id>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT u.*, c.country_name_#SESSION.LANG_CODE# as country_name
FROM user u
LEFT JOIN settings_country c ON c.country_id = u.country_id
WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
</cfquery>

<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>

<cfset p_id = get_planner.user_id>
<cfset u_id = get_planner.user_id>
<cfset user_gender = get_planner.user_gender>
<cfset user_name = get_planner.user_name>
<cfset user_email = get_planner.user_email>
<cfset user_email_2 = get_planner.user_email_2>
<cfset user_alias = get_planner.user_alias>
<cfset user_firstname = get_planner.user_firstname>
<cfset user_phone = get_planner.user_phone>	
<cfset avail_id = get_planner.avail_id>
<cfset user_based = get_planner.user_based>	
<cfset user_resume = get_planner.user_resume>
<cfset user_abstract = get_planner.user_abstract>
<cfset user_video = get_planner.user_video>
<cfset user_create = get_planner.user_create>
<cfset user_video_link = get_planner.user_video_link>

<cfset country_id_solo = get_planner.country_id>
<cfset interest_id_solo = get_planner.interest_id>
<cfset function_id_solo = get_planner.function_id>
<!--- <cfset certif_id_solo = get_planner.certif_id> --->
<!--- <cfset perso_id_solo = get_planner.perso_id> --->

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
<cfset user_timezone_id = get_planner.timezone_id>
<cfset user_lang = get_planner.user_lang>

<cfset user_status_name = get_planner.user_status_name>
<cfset user_status_id = get_planner.user_status_id>
<cfset user_status_css = get_planner.user_status_css>

<cfset user_type_id = get_planner.user_type_id>
<cfset user_type_name = get_planner.user_type_name>

<cfloop list="#SESSION.LIST_PT#" index="cor">
<cfset "user_qpt_#cor#" = evaluate("get_planner.user_qpt_#cor#")>
<cfset "user_qpt_lock_#cor#" = evaluate("get_planner.user_qpt_lock_#cor#")>
</cfloop>

<cfset user_lst = get_planner.user_lst>
<cfset user_lst_lock = get_planner.user_lst_lock>

<cfset user_add_learner = get_planner.user_add_learner>
<cfset user_add_course = get_planner.user_add_course>

<!------------------ OBJ QUERIES ----------------->
<cfset get_teaching_solo = obj_query.oget_teaching(p_id="#p_id#")>
<cfset get_speaking_solo = obj_query.oget_speaking(p_id="#p_id#")>
<cfset get_personnality_solo = obj_query.oget_personnality(p_id="#p_id#")>
<cfset get_method_solo = obj_query.oget_method(p_id="#p_id#")>
<cfset get_country_solo = obj_query.oget_country(p_id="#p_id#")>
<cfset get_experience_solo = obj_query.oget_experience(p_id="#p_id#")>
<cfset get_cursus_solo = obj_query.oget_cursus(p_id="#p_id#")>
<cfset get_interest_solo = obj_query.oget_interest(p_id="#p_id#")>
<cfset get_function_solo = obj_query.oget_function(p_id="#p_id#")>
<cfset get_expertise_business_solo = obj_query.oget_expertise_business(p_id="#p_id#")>
<cfset get_certif_solo = obj_query.oget_certif(p_id="#p_id#")>
<cfset get_techno_solo = obj_query.oget_techno(p_id="#p_id#")>
<cfset get_about_solo = obj_query.oget_about(p_id="#p_id#")>
<cfset get_paragraph_solo = obj_query.oget_paragraph(p_id="#p_id#")>

<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#p_id#")>
<cfset get_result_lst = obj_query.oget_result_lst(p_id="#p_id#")>
<cfset get_workinghour = obj_query.oget_workinghour(p_id="#p_id#")>

<cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#p_id#")>
<cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#p_id#")>

<cfinvoke component="api/users/user_trainer_get" method="get_trainer_teach_ready" returnvariable="user_ready">
	<cfinvokeargument name="user_id" value="#p_id#">
</cfinvoke>

<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="2.8" marginright="0.5" marginleft="0.5" margintop="2" localurl="yes" <!---filename="../docs/CF_#cv_context_name#_#dateformat(now(),'yyyymmdd')#.pdf"--->>
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<tr>
		<td width="180" valign="top">
		<img src="../assets/img/logo_wefit_260.jpg" width="220"><br>
		</td>
		<td width="15"></td>
		<td valign="top" align="left">
		</td>
	</tr>	
</table>
</cfdocumentitem> 

<cfloop query="get_user">
<cfset page = "1">
<cfinclude template="./trainer_content.cfm">

<cfdocumentitem type="pagebreak" />

<cfset page = "2">
<cfinclude template="./trainer_content.cfm">

</cfloop>

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:20px" width="900" cellpadding="0">
	<tr>
		<td width="180" valign="top" align="center">
			<img src="../assets/img/logo_wefit_260.jpg" width="120">
			<br><br>
			WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
			D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
		</td>
	</tr>	
</table>
</cfdocumentitem> 
</cfdocument>