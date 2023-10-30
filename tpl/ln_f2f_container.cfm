<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>
<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="4" marginright="0.5" marginleft="0.5" margintop="2" <!---filename="../docs/CF_#cv_context_name#_#dateformat(now(),'yyyymmdd')#.pdf"--->>
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


<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_fullname, u.*, 
a.account_name, g.group_name, s.user_status_name_fr as user_status_name

FROM user u
LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
LEFT JOIN account a ON a.account_id = u.account_id
LEFT JOIN account_group g ON g.group_id = a.group_id

WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
</cfquery>

<cfset page = 1>
<cfinclude template="./ln_f2f_content.cfm">
		


<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top" align="center" style="padding:0px 20px 0px 20px">
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
				<tr>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<!--- L'APPRENANT --->
						<span style="font-size:13px"><strong><cfoutput>#obj_translater.get_translate('ln_title_learner_sign',formation_id)#</cfoutput></strong></span><br>
						<span style="font-size:10px"><em><cfoutput>#get_lessonnote.user_firstname# #get_lessonnote.user_name#</cfoutput></em></span>
						
					</td>
					<td width="4%"></td>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<!--- LE FORMATEUR --->
						<span style="font-size:13px;"><strong><cfoutput>#obj_translater.get_translate('ln_title_trainer_sign',formation_id)#</cfoutput></strong></span><br>
						<span style="font-size:10px"><em><cfoutput>#get_lessonnote.planner_firstname#</cfoutput></em></span>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</cfdocumentitem> 
</cfdocument>