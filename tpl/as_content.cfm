<cfsilent>
<cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
<cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
<cfset get_lesson = obj_query.oget_lessons(u_id="#u_id#",st_id="5,6",t_id="#t_id#",ghosted="1",orderby="ASC")>
<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
</cfsilent>


<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="20">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('pdf_title_as')#</cfoutput></h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = get_tp.tp_scheduled></cfif>
	<cfif get_tp.tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = get_tp.tp_inprogress></cfif>
	<cfif get_tp.tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = get_tp.tp_cancelled></cfif>
	<cfif get_tp.tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = get_tp.tp_missed></cfif>
	<cfif get_tp.tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = get_tp.tp_completed></cfif>
	
	<cfset tp_done_go = (tp_completed_go+tp_inprogress_go)/60>
	<tr>
		<td valign="top">
			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;" width="100%" cellpadding="6" cellspacing="1">
				<cfoutput>
				<tr>
					<td width="20%"><strong><cfoutput>#obj_translater.get_translate('form_label_company')#</cfoutput></strong></td>
					<td width="30%" bgcolor="##FFFFFF">#get_user.account_name#</td>
					<td width="20%"><strong><cfoutput>#obj_translater.get_translate('table_th_training')#</cfoutput></strong></td>
					<td width="30%" bgcolor="##FFFFFF">#get_tp.formation_name#</td>
				</tr>
				<tr>
					<td width="20%"><strong><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></strong></td>
					<td width="30%" bgcolor="##FFFFFF">#get_user.user_firstname# #ucase(get_user.user_name)#</td>
					<td width="20%"><strong><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong></td>
					<td width="30%" bgcolor="##FFFFFF"><cfoutput>#obj_translater.get_translate('short_between2')#</cfoutput> #dateformat(get_tp.first_lesson,'dd/mm/yyyy')# <cfoutput>#obj_translater.get_translate('short_and2')#</cfoutput> #dateformat(get_tp.last_lesson,'dd/mm/yyyy')#</td>
				</tr>	
				<cfif SESSION.LANG_CODE eq "fr">
				<tr>
					<td width="20%"><strong>Cadre de la formation</strong></td>
					<td width="30%" bgcolor="##FFFFFF"></td>
					<td width="20%"><strong>Heures &eacute;marg&eacute;es</strong></td>
					<td width="30%" bgcolor="##FFFFFF"><cfoutput>#tp_done_go#</cfoutput>h</td>
				</tr>
				</cfif>
				</cfoutput>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="1">
				<tr>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_date'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_start'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_end'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_method'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_type'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_course_title'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_learner'))#</cfoutput>
					</th>
					<th>
					<cfoutput>#ucase(obj_translater.get_translate('table_th_duration'))#</cfoutput>
					</th>
				</tr>
				
				<cfoutput query="get_lesson">			
				<tr bgcolor="##FFFFFF">
					<td align="center">
						#obj_dater.get_dateformat(lesson_start)#
					</td>
					<td align="center">
						#timeformat(lesson_start,'HH:mm')#
					</td>
					<td align="center">
						#timeformat(lesson_end,'HH:mm')#
					</td>
					<td align="center">
						#method_name#
					</td>
					<td align="center">
						#cat_name#
					</td>
					<td align="center">
						#sessionmaster_name#
					</td>
					<td align="center">
						#obj_lms.get_trainer_signature(p_id="#planner_id#", size="80")#
					</td>
					<td align="center">
						#obj_lms.get_learner_signature(l_id="#lesson_id#", u_id="#u_id#", size="80")#
					</td>					
					<td align="center">
						#obj_lms.get_formath(lesson_duration)# h
					</td>
				</tr>
				</cfoutput>				
			</table>
		</td>
	</tr>
	<!----
	<tr>
		<td valign="top">
			
		</td>
	</tr>
	<tr>
		<td style="padding-top:100px">
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td> &Agrave; Paris, le <cfoutput>#dateformat(now(),'dd/mm/yyyy')#</cfoutput>
				</tr>			
			</table>
		</td>	
	</tr>
	<tr>
		<td align="left" valign="top" style="padding-top:20px">	
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
				<tr>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left">
									<span style="font-size:13px;"><strong>WEFIT</strong></span><br>
									<span style="font-size:10px"><em>Vincent GEST, Pr&eacute;sident de WEFIT Group</em></span><br>
								
								</td>
							</tr>
							<tr>
								<td align="center">
									<cfoutput><img src="../sources/#SESSION.MASTER_ID#/img/signature_wefit.jpg" align="center"><br><br></cfoutput>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		

		</td>
	</tr>
	---->
</table>           

</body>
</html>
