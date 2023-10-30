<cfif page eq "1">


<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>

<cfset lesson_intro = get_lessonnote.lesson_intro>
<cfset lesson_footer = obj_translater.get_translate("ln_title_ending",formation_id)>

<cfset sm_description = get_lessonnote.sessionmaster_description>
<cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
<cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
<cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>

<cfset lesson_open_main = get_lessonnote.lesson_open_main>
<cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
<cfset lesson_add_misc = get_lessonnote.lesson_add_misc>
<cfset lesson_feedback = get_lessonnote.lesson_feedback>
<cfset lesson_grammar = get_lessonnote.lesson_grammar>
<cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>
<cfset lesson_add_vocabulary = get_lessonnote.lesson_add_vocabulary>
<cfset lesson_open_ressources = get_lessonnote.lesson_open_ressources>				
						
<html>
<body style="width:100%; margin:0px; padding:0px">


	
<cfoutput>
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2>#obj_translater.get_translate("ln_title_ln",formation_id)#</h2>
						<h3>#get_lessonnote.sessionmaster_name#</h3>		
					</td>
				</tr>
				
				<!--- <tr>				 --->
					<!--- <td style="padding:20px" align="center"> --->
						<!--- <em style="font-size:13px">#lesson_intro#</em> --->
					<!--- </td> --->
				<!--- </tr> --->
			</table>
		</td>
	</tr>	
	
	<tr>
		<td valign="top" align="center" style="padding:0px 20px 10px 20px">
			
			<table bgcolor="##ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
				<tr>
					<td rowspan="7" width="200" bgcolor="##FFF">
						#obj_lms.get_thumb_session(get_lessonnote.sessionmaster_code,get_lessonnote.sessionmaster_id,200)#
					</td>
				</tr>
				<tr>
					<td width="200">
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_course_title')#</span>
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

		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

						
						<h2 align="center" style="color:##871E2C; font-size:16px">#obj_translater.get_translate('ln_title_description',formation_id)#</h2>	
						
						<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
						<cfif sm_description neq "">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_main_description',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#sm_description#
								</p>
								</td>
							</tr>
						</cfif>
						<cfif sm_objectives neq "">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_objectives',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#sm_objectives#
								</p>
								</td>
							</tr>
						</cfif>
						<cfif sm_grammar neq "">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_grammar',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#sm_grammar#
								</p>
								</td>
							</tr>
						</cfif>
						<cfif sm_vocabulary neq "">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#sm_vocabulary#
								</p>
								</td>
							</tr>
						</cfif>
						</table>
						
					</td>
				</tr>
				<cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "697" OR listlen(lesson_skill_id) neq "0" OR lesson_add_misc neq "">
				<tr>
					<td>
						<h2 align="center" style="color:##871E2C; font-size:16px; margin-top:20px">#obj_translater.get_translate('ln_title_today_teaching_points',formation_id)#</h2>	

						<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
						<cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "1181" OR get_lessonnote.sessionmaster_id eq "1183">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_main_discussion',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
								</p>
								<cfif lesson_open_ressources neq "">
									
									<p style="margin-top:10px">
									<cfoutput>#replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#</cfoutput>
									</p>
								
								</cfif>
								</td>
							</tr>
						
						<cfelseif get_lessonnote.sessionmaster_id eq "697">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_did_work_on',formation_id)#</u></h3>
								<p style="margin-top:10px">
								#replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
								</p>
								
								<cfif lesson_open_ressources neq "">
									
									<p style="margin-top:10px">
									<cfoutput>#replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#</cfoutput>
									</p>
								
								</cfif>
									
								</td>
							</tr>
						</cfif>
						<cfif listlen(lesson_skill_id) neq "0">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_today_work_on',formation_id)#</u></h3>
								<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
								SELECT skill_name_#lang_temp# as skill_name FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
								</cfquery>
								<ul>
								<cfloop query="get_skill">
								<li>#get_skill.skill_name#</li>
								</cfloop>
								</ul>
								</td>
							</tr>
						</cfif>
						<cfif lesson_add_misc neq "">
							<tr>
								<td>
								<p style="margin-top:10px">
								#replacenocase(lesson_add_misc,chr(10),"<br>","ALL")#
								</p>
								</td>
							</tr>
						
						</cfif>
						</table>
					</td>
				</tr>
				</cfif>
			</table>
		</td>
	</tr>
	
	
</table>          
</cfoutput>
</body>
</html>
<cfelseif page eq "2">
<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "en"><cfset formation_id = "2"></cfdefaultcase>
</cfswitch>

<cfset lesson_intro = get_lessonnote.lesson_intro>
<cfset sm_description = get_lessonnote.sessionmaster_description>
<cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
<cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
<cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>
<cfset lesson_open_main = get_lessonnote.lesson_open_main>
<cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
<cfset lesson_add_misc = get_lessonnote.lesson_add_misc>
<cfset lesson_feedback = get_lessonnote.lesson_feedback>
<cfset lesson_footer = obj_translater.get_translate(id_translate="ln_title_ending",lg_translate="#lang_temp#")>
<cfset lesson_grammar = get_lessonnote.lesson_grammar>
<cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>
<cfset lesson_add_vocabulary = get_lessonnote.lesson_add_vocabulary>
<cfset lesson_add_correction = get_lessonnote.lesson_add_correction>
<cfset lesson_homework = get_lessonnote.lesson_homework>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #formation_id# ORDER BY grammar_cat_name
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #formation_id#
</cfquery>

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
				
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
						
						<cfif lesson_grammar neq "" OR lesson_vocabulary neq "" OR lesson_add_vocabulary neq "" OR lesson_add_correction neq "" OR lesson_homework neq "">
						
						<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							<tr>
								<td>
									<cfif listfind(get_lessonnote.ln_skill_id,"5") AND listlen(get_lessonnote.ln_grammar_id) neq "0">
										
										<h3><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_covered',formation_id)#</cfoutput></u></h3>
										
										<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
										SELECT grammar_name, grammar_level, grammar_cat_name, g.grammar_cat_id
										FROM lms_grammar g INNER JOIN lms_grammar_category gc ON gc.grammar_cat_id = g.grammar_cat_id WHERE g.grammar_id IN (#get_lessonnote.ln_grammar_id#)
										</cfquery>										
										
										<cfoutput query="get_grammar" group="grammar_cat_id">
										<strong>#grammar_cat_name# (#grammar_level#)</strong>
										<ul>
										<cfoutput>
										<li>#get_grammar.grammar_name#</li>
										</cfoutput>
										</ul>
										</cfoutput>
										

									</cfif>
							
							
									<cfif lesson_grammar neq "">
										<h3><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_explanation',formation_id)#</cfoutput></u></h3>
										<p style="margin-top:10px">
										<cfoutput>#replacenocase(lesson_grammar,chr(10),"<br>","ALL")#</cfoutput>
										</p>
									</cfif>
							
									<cfif lesson_vocabulary neq "">
									
										<h3><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h3>
										<p style="margin-top:10px">
										<cfoutput>#replacenocase(lesson_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
										</p>
									
									</cfif>
									
									<cfif lesson_add_vocabulary neq "">
									
										<h3><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h3>
										<p style="margin-top:10px">
										<cfoutput>#replacenocase(lesson_add_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
										</p>
									
									</cfif>
									
									<cfif lesson_add_correction neq "">
									
										<p style="margin-top:10px">
										<cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
										</p>
									
									</cfif>
									
									<cfif lesson_homework neq "">
									
										<p style="margin-top:10px">
										<cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
										</p>
									
									</cfif>
								
								</td>
							
							</tr>
							
						</table>
						
						</cfif>

						<cfif lesson_feedback neq "">
							<br>
							<h2 align="center" style="color:#871E2C; font-size:16px"><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback',formation_id)#</cfoutput></h2>
							
							<table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
								<tr>
									<td>
										<cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#	</cfoutput>					
									</td>
								</tr>
							</table>
						</cfif>
					</td>
				</tr>
				<tr>				
					<td style="padding:20px" align="center">
						<cfoutput>
						<em style="font-size:13px">#lesson_footer#</em>
						<br>#get_lessonnote.planner_firstname#
						</cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
</table>           
</body>
</html>

</cfif>
