<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_name_#lang_temp# as skill_name, skill_id FROM lms_skill
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_keyword_category;
</cfquery>

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">


	<tr>
		<td valign="top" align="center" style="padding:0px 20px 0px 20px">
			
			<h2><cfoutput>#obj_translater.get_translate('ln_title_ln',formation_id)#</cfoutput></h2>	
			
			<cfoutput>
			<table bgcolor="##ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
				<tr>
					<td rowspan="7" width="200" bgcolor="##FFF">
						#obj_lms.get_thumb_session(get_lessonnote.sessionmaster_code,get_lessonnote.sessionmaster_id,200)#
					</td>
				</tr>
				<tr>
					<td width="200">
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_course_title',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;"><strong>#get_lessonnote.sessionmaster_name#</strong></span>
					</td>
				</tr>	
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_trainer',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.planner_firstname#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_learner',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.user_firstname# #get_lessonnote.user_name#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_date',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#dateformat(get_lessonnote.lesson_start,'dd/mm/yyyy')#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_time',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</span>
					</td>
				</tr>							
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_duration_short',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.lesson_duration# min</span>
					</td>
				</tr>		
			</table>
			</cfoutput>
		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
						<h3><cfoutput>#obj_translater.get_translate('ln_title_objectives',formation_id)#</cfoutput></h3>
						<cfoutput>#get_lessonnote.sessionmaster_description#</cfoutput>
			
						
						<br>
						
						<h3><cfoutput>#obj_translater.get_translate('ln_title_main_discussion',formation_id)#</cfoutput></h3>
						<br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>

						<br>
						
						<h3 style="padding:0px; margin:0px"><cfoutput>#obj_translater.get_translate('ln_title_today_teaching_points',formation_id)#</cfoutput></h3>
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top">
									<cfoutput query="get_skill" startrow="1" maxrows="4">
									<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#"> #skill_name#</label><br>							
									</cfoutput>
								</td>
								<td valign="top">
									<cfoutput query="get_skill" startrow="5" maxrows="4">
									<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#"> #skill_name#</label><br>				
									</cfoutput>
								</td>
								<td valign="top">
									<cfoutput query="get_skill" startrow="9" maxrows="50">
									<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#"> #skill_name#</label><br>				
									</cfoutput>
								</td>
							</tr>
							
						</table>
						
						<br>
						<h3><cfoutput>#obj_translater.get_translate('ln_title_grammar_covered',formation_id)#</cfoutput></h3>
						<br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						
						<br>
						<h3><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></h3>
						<br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						
						<br>
						<h3><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback',formation_id)#</cfoutput></h3>
						<br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						<br><br>
						<div style="border-top:1px solid #CCC; width:100%"></div>
						
					</td>
				</tr>
			</table>
			
			
		</td>
	</tr>
	
	
</table>         
</body>
</html>

