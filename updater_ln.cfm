<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">


<!------------------------- INSERT STRUCT / WORK / OPEN LESSON TREATMENT ------------------>
<cfif isdefined("form") AND isdefined("ins_ln") AND isdefined("l_id")>

	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>

	<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_lesson_note
	(
		lesson_id,
		lesson_intro,
		
		<cfif isdefined("lesson_open_main")>lesson_open_main,</cfif>
		
		<cfif isdefined("skill_id")>skill_id,</cfif>
		<cfif isdefined("grammar_id")>grammar_id,</cfif>

		<cfif isdefined("lesson_grammar") AND isdefined("skill_id") AND listfind(skill_id,"5")>lesson_grammar,</cfif>
		<cfif isdefined("lesson_vocabulary") AND isdefined("skill_id") AND listfind(skill_id,"6")>lesson_vocabulary,</cfif>
		<cfif isdefined("lesson_add_misc")>lesson_add_misc,</cfif>		
		<cfif isdefined("lesson_feedback")>lesson_feedback,</cfif>
		
		<cfif isdefined("lesson_na_needs")>lesson_na_needs,</cfif>
		<cfif isdefined("lesson_na_workon")>lesson_na_workon,</cfif>
		<cfif isdefined("lesson_na_improve")>lesson_na_improve,</cfif>
		
		<cfif isdefined("lesson_pta_initial")>lesson_pta_initial,</cfif>
		<cfif isdefined("lesson_pta_achievement")>lesson_pta_achievement,</cfif>
		
		lesson_footer,
		lesson_date,
		lesson_lock
	)
	VALUES
	(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_intro#">,
		
		<cfif isdefined("lesson_open_main")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_open_main#">,</cfif>
		
		<cfif isdefined("skill_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#skill_id#">,</cfif>
		<cfif isdefined("grammar_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#grammar_id#">,</cfif>
		
		<cfif isdefined("lesson_grammar") AND isdefined("skill_id") AND listfind(skill_id,"5")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_grammar#">,</cfif>
		<cfif isdefined("lesson_vocabulary") AND isdefined("skill_id") AND listfind(skill_id,"6")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_vocabulary#">,</cfif>
		<cfif isdefined("lesson_add_misc")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_add_misc#">,</cfif>
		<cfif isdefined("lesson_feedback")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_feedback#">,</cfif>		
				
		<cfif isdefined("lesson_na_needs")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_needs#">,</cfif>
		<cfif isdefined("lesson_na_workon")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_workon#">,</cfif>
		<cfif isdefined("lesson_na_improve")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_improve#">,</cfif>
		
		<cfif isdefined("lesson_pta_initial")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_pta_initial#">,</cfif>
		<cfif isdefined("lesson_pta_achievement")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_pta_achievement#">,</cfif>
		
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_footer#">,
		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
		<cfif isdefined("finalise_lesson")>1<cfelse>0</cfif>
	)
	</cfquery>
	
	<!------------------- IF PTA, FILL EVAL ------------------>
	<cfif get_lesson.sessionmaster_id eq "694">
	
		<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>
		
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_eval_result WHERE note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#">
		</cfquery>	
		
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,2) eq "q_">
			
				
				<cfset equ_id = listgetat(cor,2,"_")>
				<cfset equ_result = evaluate(cor)>
				
				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_eval_result
				(
				equ_id,
				equ_result,
				note_id				
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#equ_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#equ_result#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#">
				)
				</cfquery>
				
				
			</cfif>
		</cfloop>
		
	</cfif>
	
	<cfif isdefined("finalise_lesson")>
	
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET status_id = "5", completed_date = now() WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>	
				
		<!------------------- IF NA ------------------>
		<cfif get_lesson.sessionmaster_id eq "695">

			<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET 
				tp_status_id = 2
				WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
			</cfquery>
		
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre programme de formation est disponible">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Your training program is up-to-date">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Ihr Trainingsprogramm ist up-to-date">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Your training program is up-to-date">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Your training program is up-to-date">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "na_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>
			
		<!------------------- IF TEST LESSON ------------------>
		<cfelseif get_lesson.sessionmaster_id eq "769">
			
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Cours test effectué">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Test lesson done">
			</cfif>
			
			<cfif isdefined("t_id")>
			
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 3, tp_date_end = now() WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
				</cfquery>
				
			</cfif>
			
			
			<cfmail from="W-LMS <service@wefitgroup.com>" to="sales@wefitgroup.com,service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "test_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>


		<!------------------- IF PTA ------------------>
		<cfelseif get_lesson.sessionmaster_id eq "694">
		
			<cfif isdefined("t_id")>
			
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 3, tp_date_end = now() WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
				</cfquery>
				
			</cfif>

			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre rapport de formation">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Post Training Assessment report">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" bcc="service@wefitgroup.com,finance@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "pta_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>
		
		
		<!------------------- IF REGULAR LESSON ------------------>
		<cfelse>
		
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre compte rendu de cours">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Your lesson note is available">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Ihre Lesson Note ist jetzt verfügbar">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Your lesson note is available">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Your lesson note is available">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "complete">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>
		
		</cfif>
	
	</cfif>
		

	<cflocation addtoken="no" url="index.cfm?k=2">
	
	
	
<!------------------------- UPDATE STRUCT / WORK / OPEN LESSON TREATMENT ------------------>
<cfelseif isdefined("form") AND isdefined("updt_ln") AND isdefined("l_id") AND isdefined("note_id")>
	
	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
	
	<cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_lesson_note SET
	
	skill_id = <cfif isdefined("skill_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#skill_id#">,<cfelse>null,</cfif>
	grammar_id = <cfif isdefined("grammar_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#grammar_id#">,<cfelse>null,</cfif>	
	
	lesson_intro = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_intro#">,
	
	lesson_open_main = <cfif isdefined("lesson_open_main")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_open_main#">,</cfif>
	

	lesson_grammar = <cfif isdefined("lesson_grammar") AND isdefined("skill_id") AND listfind(skill_id,"5")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_grammar#">,<cfelse>null,</cfif>
	lesson_vocabulary = <cfif isdefined("lesson_vocabulary") AND isdefined("skill_id") AND listfind(skill_id,"6")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_vocabulary#">,<cfelse>null,</cfif>
	lesson_add_misc = <cfif isdefined("lesson_add_misc")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_add_misc#">,<cfelse>null,</cfif>	
	lesson_feedback = <cfif isdefined("lesson_feedback")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_feedback#">,<cfelse>null,</cfif>
		
	lesson_footer = <cfif isdefined("lesson_footer")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_footer#">,<cfelse>null,</cfif>
	lesson_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
	
	lesson_na_needs = <cfif isdefined("lesson_na_needs")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_needs#">,<cfelse>null,</cfif>
	lesson_na_workon = <cfif isdefined("lesson_na_workon")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_workon#">,<cfelse>null,</cfif>
	lesson_na_improve = <cfif isdefined("lesson_na_improve")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_na_improve#">,<cfelse>null,</cfif>
	
	lesson_pta_initial = <cfif isdefined("lesson_pta_initial")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_pta_initial#">,<cfelse>null,</cfif>
	lesson_pta_achievement = <cfif isdefined("lesson_pta_achievement")><cfqueryparam cfsqltype="cf_sql_varchar" value="#lesson_pta_achievement#">,<cfelse>null,</cfif>
	
	
	lesson_lock = <cfif isdefined("finalise_lesson")>1<cfelse>0</cfif>
	
	WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> AND note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#note_id#">
	</cfquery>
	
	<!------------------- IF PTA, FILL EVAL ------------------>
	<cfif get_lesson.sessionmaster_id eq "694">
	
		<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>
		
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_eval_result WHERE note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#">
		</cfquery>	
		
		<cfloop collection="#form#" item="cor">
			<cfif mid(cor,1,2) eq "q_">
			
				
				<cfset equ_id = listgetat(cor,2,"_")>
				<cfset equ_result = evaluate(cor)>
				
				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_eval_result
				(
				equ_id,
				equ_result,
				note_id				
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#equ_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#equ_result#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#">
				)
				</cfquery>
				
				
			</cfif>
		</cfloop>
		
	</cfif>
		
		
	<cfif isdefined("finalise_lesson")>
	
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET status_id = "5", completed_date = now() WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>	
	
		<!------------------- IF NA ------------------>
		<cfif get_lesson.sessionmaster_id eq "695">
		
			<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET 
				tp_status_id = 2
				WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
			</cfquery>
			
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre premier cours">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Your first lesson">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Deine erste Lektion">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Your first lesson">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Your first lesson">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "na_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>
			
		<!------------------- IF PTA ------------------>
		<cfelseif get_lesson.sessionmaster_id eq "694">
		
			<cfif isdefined("t_id")>
			
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 3, tp_date_end = now() WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
				</cfquery>
				
			</cfif>
		
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre rapport de formation">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Post Training Assessment report">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Post Training Assessment report">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" bcc="service@wefitgroup.com,finance@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "pta_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>
			
		<!------------------- IF TEST LESSON ------------------>
		<cfelseif get_lesson.sessionmaster_id eq "769">
				
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Cours test effectué">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Test lesson done">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Test lesson done">
			</cfif>
			
			<!--- <cfif isdefined("t_id")> --->
			
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 3, tp_date_end = now() WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
				</cfquery>
				
			<!--- </cfif> --->
			
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="sales@wefitgroup.com,service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "test_done">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>

		<!------------------- IF REGULAR LESSON ------------------>
		<cfelse>
		
			<!---------------------------- LEARNER NOTIFICATION ----------------------->
			<cfif get_lesson.learner_lang eq "fr">
				<cfset subject = "WEFIT | Votre compte rendu de cours">
			<cfelseif get_lesson.learner_lang eq "en">
				<cfset subject = "WEFIT | Your lesson note is available">
			<cfelseif get_lesson.learner_lang eq "de">
				<cfset subject = "WEFIT | Ihre Lesson Note ist jetzt verfügbar">
			<cfelseif get_lesson.learner_lang eq "es">
				<cfset subject = "WEFIT | Your lesson note is available">
			<cfelseif get_lesson.learner_lang eq "it">
				<cfset subject = "WEFIT | Your lesson note is available">
			</cfif>
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
				<cfset lang = get_lesson.learner_lang>
				<cfset status = "complete">
				<cfset recipient = "learner">			
				<cfinclude template="./email/email_lesson_status.cfm">		
			</cfmail>	
			
		</cfif>

			
		<cfquery name="select_total" datasource="#SESSION.BDDSOURCE#">
			SELECT SUM(lesson_duration) as ltotal, t.tp_id, t.tp_duration 
			FROM lms_tp t
			LEFT JOIN lms_lesson2 l ON t.tp_id = l.tp_id 
			WHERE l.status_id IN (4,5) 
			AND l.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
		</cfquery>

		<cfif select_total.ltotal GTE select_total.tp_duration>
			<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_tp SET tp_status_id = 3, tp_date_end = now() WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>
		</cfif>

	
	</cfif>	
	
	<cflocation addtoken="no" url="index.cfm?k=2">
	
</cfif>

</cfprocessingdirective>