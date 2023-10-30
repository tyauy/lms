<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>
<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
<cfset get_tp = obj_tp_get.oget_tp(t_id="#get_lessonnote.tp_id#")>

<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" <!---filename="../docs/CF_#cv_context_name#_#dateformat(now(),'yyyymmdd')#.pdf"--->>
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

<cfif get_lessonnote.sessionmaster_id eq "695">

	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_fullname, u.*, 
	a.account_name, g.group_name, s.user_status_name_fr as user_status_name
	
	FROM user u
	LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
	LEFT JOIN account a ON a.account_id = u.account_id
	LEFT JOIN account_group g ON g.group_id = a.group_id
	
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
	</cfquery>

	<cfset account_name = get_user.account_name>
	<cfset group_name = get_user.group_name>
	
	<cfset user_steps = get_user.user_steps>
	<cfset user_qpt = get_user.user_qpt>
	<cfset user_qpt_lock = get_user.user_qpt_lock>
	<cfset user_lst = get_user.user_lst>
	
	<cfset user_email = get_user.user_email>
	<cfset user_phone = get_user.user_phone>
	<cfset user_alias = get_user.user_alias>
	
	<cfset avail_id = get_user.avail_id>
	<cfset interest_id = get_user.interest_id>
			
	<cfset user_jobtitle = get_user.user_jobtitle>
	<cfset user_needs_course = get_user.user_needs_course>
	<cfset user_needs_frequency = get_user.user_needs_frequency>
	<cfset user_needs_trainer = get_user.user_needs_trainer>
	<cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
	<cfset user_needs_learn = get_user.user_needs_learn>
	<cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement>
	<cfset user_needs_complement = get_user.user_needs_complement>
	<cfset user_needs_theme = get_user.user_needs_theme>
	<cfset user_needs_duration = get_user.user_needs_duration>
	
	<cfset user_remind_1d = get_user.user_remind_1d>
	<cfset user_remind_3h = get_user.user_remind_3h>
	<cfset user_remind_15m = get_user.user_remind_15m>
	
	<cfset user_status_name = get_user.user_status_name>

	
	<cfquery name="get_result_lst" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#"> AND quiz_id = 3
	</cfquery>
	

	<cfset get_session = obj_tp_get.oget_session(t_id="#get_lessonnote.tp_id#")>
	
	<cfset page = 1>
	<cfinclude template="./ln_na_content.cfm">
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = 2>
	<cfinclude template="./ln_na_content.cfm">
	<cfdocumentitem type="pagebreak" />
	

	
	<cfif get_result_lst.recordcount neq "0">
		<cfset page = 4>
		<cfset quiz_user_id = get_result_lst.quiz_user_id>
		<cfinclude template="./ln_na_content.cfm">
		
	
		<cfif get_tp.session_duration eq get_tp.tp_duration>
		<cfdocumentitem type="pagebreak" />
		<cfset page = 3>
		<cfinclude template="./ln_na_content.cfm">
		</cfif>
	
	<cfelse>
	
		<cfif get_tp.session_duration eq get_tp.tp_duration>
		<cfset page = 3>
		<cfinclude template="./ln_na_content.cfm">
		</cfif>
	
	</cfif>
	
	<cfset page = 5>
	<cfinclude template="./ln_na_content.cfm">
	
<cfelseif get_lessonnote.sessionmaster_id eq "694">
	
	<cfset page = 1>
	<cfinclude template="./ln_pta_content.cfm">
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = 2>
	<cfinclude template="./ln_pta_content.cfm">
		
<cfelse>
		
	<cfif get_lesson.method_id neq "2">
		<cfset page = 1>
		<cfinclude template="./ln_content.cfm">
		<cfdocumentitem type="pagebreak" />

		<cfset page = 2>
		<cfinclude template="./ln_content.cfm">
	<cfelse>
		<cfset page = 1>
		<cfinclude template="./ln_f2f_content.cfm">
	</cfif>
</cfif>

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