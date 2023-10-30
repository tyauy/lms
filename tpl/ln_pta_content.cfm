<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>

<cfset lesson_intro = get_lessonnote.lesson_intro>
<cfset lesson_formation = get_lessonnote.formation_name>
<cfset lesson_footer = obj_translater.get_translate("ln_title_ending",formation_id)>

<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
	
<cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
<cfset lesson_feedback = get_lessonnote.lesson_feedback>

<cfset lesson_pta_initial = get_lessonnote.lesson_pta_initial>
<cfset lesson_pta_achievement = get_lessonnote.lesson_pta_achievement>

<cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
SELECT e.eval_id, eq.equ_name_#lang_temp# as equ_name, eq.equ_group_#lang_temp# as equ_group, eq.equ_id, er.equ_result
FROM lms_eval e
INNER JOIN lms_eval_question eq ON eq.eval_id = e.eval_id
LEFT JOIN lms_eval_result er ON er.equ_id = eq.equ_id
WHERE e.eval_id = 1 AND (er.note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#"> OR er.note_id IS NULL)
ORDER BY equ_group
</cfquery>
	
<cfif page eq "1">
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_pta',formation_id)#</cfoutput> (1/2)</h2>		
					</td>
				</tr>				
				<tr>				
					<td style="padding:10px 20px 0px 20px" align="center">
						<em style="font-size:13px"><cfoutput>#lesson_intro#</cfoutput></em>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td valign="top" align="center" style="padding:0px 20px 10px 20px">
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
						<span style="font-size:12px;">#dateformat(get_lessonnote..lesson_start,'dd/mm/yyyy')#</span>
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
					
						<h2 align="center" style="color:#871E2C; font-size:16px"><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h2>	
						
						<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							
							
							<tr>
								<td>
								
								<cfif listlen(lesson_skill_id) neq "0">
								<h3><u>YOU WANTED TO LEARN <cfoutput>#ucase(lesson_formation)#</cfoutput> TO:</u></h3>
								<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
								SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
								</cfquery>
								<ul>
								<cfoutput>
								<cfloop query="get_skill">
								<li>#get_skill.skill_objectives#</li>
								</cfloop>
								</cfoutput>
								</ul>
								</cfif>
								
								
								<cfif lesson_pta_initial neq "">
								<br>
								
								<h3><u><cfoutput>#obj_translater.get_translate('ln_title_initial',formation_id)#</cfoutput></u></h3>
								<cfoutput>#replacenocase(lesson_pta_initial,chr(10),"<br>","ALL")#</cfoutput>
								</cfif>
								
								</td>
							</tr>
						</table>
						
						<br><br>
						
						<h2 align="center" style="color:#871E2C; font-size:16px"><cfoutput>#obj_translater.get_translate('ln_title_achievement',formation_id)#</cfoutput></h2>	
						
						<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							
							
							<tr>
								<td>
								
								
								<cfif lesson_pta_achievement neq "">
								<h3><u><cfoutput>#obj_translater.get_translate('ln_title_now_able',formation_id)#</cfoutput></u></h3>
								<cfoutput>#replacenocase(lesson_pta_achievement,chr(10),"<br>","ALL")#</cfoutput>
								</cfif>
								
								<cfif lesson_feedback neq "">
								<br>
								
								<h3><u><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback_tips',formation_id)#</cfoutput></u></h3>
								<cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#</cfoutput>
								</cfif>
								
								</td>
							</tr>
						</table>
						
					</td>
				</tr>
				
				
			</table>
		</td>
	</tr>
	
	
</table>      
</body>
</html>
<cfelseif page eq "2">
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_pta',formation_id)#</cfoutput> (2/2)</h2>		
					</td>
				</tr>		
			</table>
		</td>
	</tr>
	

	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
						
						<h2 align="center" style="color:#871E2C; font-size:16px"><cfoutput>#obj_translater.get_translate('ln_title_performance',formation_id)#</cfoutput></h2>	
						
						<em>5: Excellent&nbsp;&nbsp;&nbsp;4: Very good&nbsp;&nbsp;&nbsp;3: Good&nbsp;&nbsp;&nbsp;2: Satisfactory&nbsp;&nbsp;&nbsp;1: Poor</em>
							
						<table bgcolor="#CCCCCC" style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:20px" width="100%" cellpadding="10" cellspacing="1">	
	
							<cfoutput query="get_eval" group="equ_group">
											
							<tr bgcolor="##ECECEC">
								<td><strong>#ucase(equ_group)#</strong></td>
								<td width="10"><span class="badge badge-pill badge-secondary">1</span></td>
								<td width="10"><span class="badge badge-pill badge-secondary">2</span></td>
								<td width="10"><span class="badge badge-pill badge-secondary">3</span></td>
								<td width="10"><span class="badge badge-pill badge-secondary">4</span></td>
								<td width="10"><span class="badge badge-pill badge-secondary">5</span></td>
								<td width="10"><span class="badge badge-pill badge-secondary">NA</span></td>
							</tr>
							
							<cfoutput>
							
							<tr bgcolor="##FFFFFF">
								<td>
									#equ_name#
								</td>
								<cfif isdefined("equ_result") AND equ_result eq "1">
								<td width="10" bgcolor="##ff7c7c">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
								<cfif isdefined("equ_result") AND equ_result eq "2">
								<td width="10" bgcolor="##fbb962">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
								<cfif isdefined("equ_result") AND equ_result eq "3">
								<td width="10" bgcolor="##e7ef00">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
								<cfif isdefined("equ_result") AND equ_result eq "4">
								<td width="10" bgcolor="##c6e885">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
								<cfif isdefined("equ_result") AND equ_result eq "5">
								<td width="10" bgcolor="##49b734">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
								<cfif isdefined("equ_result") AND equ_result eq "0">
								<td width="10" bgcolor="##ECECEC">
									X
								</td>
								<cfelse>
								<td width="10" bgcolor="##FFF">
									
								</td>								
								</cfif>
							</tr>
							
							</cfoutput>
							
							</cfoutput>

						</table>
						
					</td>
				</tr>
				
				
			</table>
		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">		
				<tr>				
					<td style="padding:20px" align="center">
						<em style="font-size:13px"><cfoutput>#get_lessonnote.lesson_footer#</cfoutput></em>
					</td>
				</tr>
			</table>
		</td>
	</tr>		
	
</table>      
</body>
</html>
</cfif>