<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">
<cfif isdefined("ins") AND isdefined("qu_id") AND isdefined("qu_type") AND isdefined("quiz_user_id")>

<!----- IF THERE IS AN ANSWER / NO TIMES UP ---->
<cfif isdefined("ans_id") AND listlen("ans_id") neq "0">

	<cfset sub_id = "0">
	<!--- CHECK IF ANSWER ARE CORRECT --->
	<cfloop list="#ans_id#" index="id">

		<cfset sub_id ++>
		
		<!--- INS ANSWER --->
		<cfquery name="ins_answer" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_quiz_result
		(
		qu_id,
		ans_id,
		quiz_user_id,
		iscorrect,
		ans_text,
		sub_id
		)
		VALUES
		(
		'#qu_id#',
		<cfif qu_type neq "text">'#id#',<cfelse>0,</cfif>
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
		'0',
		<cfif qu_type eq "text">'#trim(id)#'<cfelse>null</cfif>,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
		)
		</cfquery>

		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT max(result_id) as maxid FROM lms_quiz_result LIMIT 1
		</cfquery>

		<cfquery name="check_answer" datasource="#SESSION.BDDSOURCE#">
		SELECT sub_id, ans_gain FROM lms_quiz_answer 
		WHERE ans_iscorrect = "1"
		AND qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
		<cfif qu_type neq "text">
		AND ans_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
		<cfelse>
		AND ans_text = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(id)#">
		</cfif>
		</cfquery>		
		
		<!---- CORRECT ANSWER ---->	
		<cfif check_answer.recordcount neq "0">
			<cfquery name="updt_answer" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_quiz_result SET iscorrect = "1", ans_gain = <cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#check_answer.ans_gain#"> WHERE result_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.maxid#">
			</cfquery>
		</cfif>
		
	</cfloop>

<cfelse>
<!----- IF THERE IS NO ANSWER DUE TO TIMES UP ---->

	<cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
		SELECT DISTINCT(sub_id) as sub_id FROM lms_quiz_answer WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cfoutput query="get_sub">
		<cfquery name="ins_answer" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_quiz_result
		(
		qu_id,
		ans_id,
		quiz_user_id,
		iscorrect,
		ans_text,
		sub_id
		)
		VALUES
		(
		'#qu_id#',
		0,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
		'0',
		null,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
		)
		</cfquery>
	</cfoutput>
</cfif>


<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
SELECT lmu.quiz_id, qc.qu_ranking, quiz_user_group_id
FROM lms_quiz_user lmu 
INNER JOIN lms_quiz_cor qc ON qc.qu_id = lmu.current_qu_id AND qc.quiz_id = lmu.quiz_id
WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> 
AND lmu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>

<cfquery name="get_next" datasource="#SESSION.BDDSOURCE#">
SELECT qq.qu_id FROM lms_quiz_question qq 
INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id AND qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.quiz_id#">
WHERE qc.qu_ranking > <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.qu_ranking#">
AND qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.quiz_id#">
ORDER BY qu_ranking ASC LIMIT 1
</cfquery>
<!--- <cfdump var="#get_id#">
<cfdump var="#get_next#">

<cfabort> --->

<cfif get_next.recordcount neq "0">
	<!------- GO NEXT QUESTION ----->
	<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_quiz_user SET 
	current_qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next.qu_id#">,
	current_visited = 0
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	</cfquery>

	<cfif isdefined("act") AND act eq "stop">
		<cflocation addtoken="no" url="learner_eval.cfm?stop=1">
	<cfelse>
		<cflocation addtoken="no" url="quiz.cfm?quiz_user_id=#quiz_user_id#">
	</cfif>
<cfelse>
	<!------- QUIZ FINALIZATION & REDIRECT ----->
	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_alias, qu.*
	FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	</cfquery>
	
	<cfif get_quiz.quiz_type eq "qpt_en" 
	OR get_quiz.quiz_type eq "qpt_de" 
	OR get_quiz.quiz_type eq "qpt_fr" 
	OR get_quiz.quiz_type eq "qpt_es" 
	OR get_quiz.quiz_type eq "qpt_it"
	OR get_quiz.quiz_type eq "qpt_pt"
	OR get_quiz.quiz_type eq "qpt_zh"
	OR get_quiz.quiz_type eq "qpt_ru"
	OR get_quiz.quiz_type eq "qpt_nl"
	>
		
		<cfif get_quiz.quiz_type eq "qpt_en">
			<cfset cor = "en">
		<cfelseif get_quiz.quiz_type eq "qpt_de">
			<cfset cor = "de">
		<cfelseif get_quiz.quiz_type eq "qpt_fr">
			<cfset cor = "fr">
		<cfelseif get_quiz.quiz_type eq "qpt_es">
			<cfset cor = "es">
		<cfelseif get_quiz.quiz_type eq "qpt_it">
			<cfset cor = "it">
		<cfelseif get_quiz.quiz_type eq "qpt_pt">
			<cfset cor = "pt">
		<cfelseif get_quiz.quiz_type eq "qpt_zh">
			<cfset cor = "zh">
		<cfelseif get_quiz.quiz_type eq "qpt_ru">
			<cfset cor = "ru">
		<cfelseif get_quiz.quiz_type eq "qpt_nl">
			<cfset cor = "nl">
		</cfif>
		
		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
	
		<!------- UPDATE SUCCESS FLAG IF SPECIAL RATES----->
		<cfif get_quiz.quiz_alias eq "C1">
			<cfif get_result_score.score lte "6">				
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'B2',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "B2">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "0">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			<cfelseif get_result_score.score gt "6" AND get_result_score.score lt "17">				
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'C1',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "C1">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "1">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			<cfelse>
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'C2',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "C2">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "2">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			</cfif>
		<cfelseif get_quiz.quiz_alias eq "B2">
			<cfif get_result_score.score gte "13">
				<cfset quiz_success = "1">
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'B2',
				user_qpt_lock_#cor# = 0
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "B2">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 0>
				
			<cfelse>
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'B1',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "B1">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "0">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			</cfif>
		<cfelseif get_quiz.quiz_alias eq "B1">
			<cfif get_result_score.score gte "12">
				<cfset quiz_success = "1">
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'B1',
				user_qpt_lock_#cor# = 0
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "B1">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 0>
				
			<cfelse>
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'A2',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "A2">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "0">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			</cfif>
		<cfelseif get_quiz.quiz_alias eq "A2">
			<cfif get_result_score.score gte "11">
				<cfset quiz_success = "1">
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'A2',
				user_qpt_lock_#cor# = 0
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "A2">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 0>
				
			<cfelse>
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'A1',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "A1">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "0">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			</cfif>
		<cfelseif get_quiz.quiz_alias eq "A1">
			<cfif get_result_score.score gte "10">
				<cfset quiz_success = "1">
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'A1',
				user_qpt_lock_#cor# = 0
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "A1">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 0>
				
			<cfelse>
				<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET 
				user_qpt_#cor# = 'A0',
				user_qpt_lock_#cor# = 1
				WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				</cfquery>
				
				<cfset "SESSION.USER_QPT_#ucase(cor)#" = "A0">
				<cfset "SESSION.USER_QPT_LOCK_#ucase(cor)#" = 1>
				
				<cfset quiz_success = "0">
				
				<!---- REMOVE PT STEP ALERT --->
				<cfif findnocase("qpt_",get_quiz.quiz_type)>
					<cfif SESSION.USER_PROFILE neq "trainer">
						<cfset temp = obj_lms.updt_step("2")>
					</cfif>
				</cfif>
				
			</cfif>
		</cfif>

		<cftry>

			<!--- NEW INSERT LEVEL --->
			<cfquery name="get_f" datasource="#SESSION.BDDSOURCE#">
				SELECT formation_id FROM lms_formation WHERE formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">
			</cfquery>

			<cfquery name="get_l" datasource="#SESSION.BDDSOURCE#">
				SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("SESSION.USER_QPT_#ucase(cor)#")#">
			</cfquery>

			<cfinvoke component="api/users/user_post" method="up_user_level">
                <cfinvokeargument name="user_id" value="#SESSION.USER_ID#">
                <cfinvokeargument name="skill_id" value="0">
                <cfinvokeargument name="formation_id" value="#get_f.formation_id#">
                <cfinvokeargument name="formation_code" value="#cor#">
                <cfinvokeargument name="level_id" value="#get_l.level_id#">
                <cfinvokeargument name="level_code" value="#evaluate("SESSION.USER_QPT_#ucase(cor)#")#">
                <cfinvokeargument name="level_verified" value="1">
            </cfinvoke>
			
		<cfcatch type="any">
			updt_user_level: <cfoutput>#cfcatch.message#</cfoutput>
		</cfcatch>
		</cftry>


		<!--- reset last pt --->
		<cfif isdefined("quiz_user_group_id")>
			<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_quiz_user SET quiz_head = 0 WHERE quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> AND quiz_head = 1
			</cfquery>
		</cfif>
	
		<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_user 
		SET quiz_user_end = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
		quiz_success = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_success#">,
		quiz_head = 1
		<!--- <cfif isdefined("SESSION.TP_ID")> --->
		<!--- , tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.TP_ID#"> --->
		<!--- , pt_type = "start" --->
		<!--- </cfif> --->
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>

		<!--- updating global score --->
		<cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
			<cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
			<cfinvokeargument name="quiz_user_group_id" value="#get_id.quiz_user_group_id#">
		</cfinvoke>
				
		<!--- IF LAUNCING LEARNER COME BACK TO LAUNCH PROCESS --->
		<cfif SESSION.USER_STATUS_ID eq "3">
			<cflocation addtoken="no" url="learner_launch_1.cfm?show_result_qpt=1&quser_id=#quiz_user_id#">
		<!--- IF SESSION.TP_ID DEFINED, BACK TO TP DETAILS --->
		<cfelseif isdefined("SESSION.TP_ID") AND SESSION.TP_ID neq "" AND SESSION.TP_ID neq "0">
			<cflocation addtoken="no" url="common_tp_details.cfm?tp_id=#SESSION.TP_ID#&show_result_qpt=1&quser_id=#quiz_user_id#">
		<cfelse>
			<cflocation addtoken="no" url="quiz_eval.cfm?quiz_user_id=#quiz_user_id#&u_id=#SESSION.USER_ID#">
		</cfif>
		
	<cfelseif get_quiz.quiz_type eq "lst_sociability" OR get_quiz.quiz_type eq "lst_brain" OR get_quiz.quiz_type eq "lst_memory">

		<cflocation addtoken="no" url="learner_evals.cfm?show_result=#quiz_user_id#">
		
	<cfelseif get_quiz.quiz_type eq "lst">
		
		<!---- REMOVE STEP ALERT --->
		<cfif SESSION.USER_PROFILE neq "trainer">
			<cfset temp = obj_lms.updt_step("3")>
		</cfif>
			
		<cfquery name="get_total_lst" datasource="#SESSION.BDDSOURCE#">
		SELECT lqa.ans_flag, COUNT(lqr.ans_id) as nb
		FROM lms_quiz_answer lqa
		INNER JOIN lms_quiz_result lqr ON lqa.ans_id = lqr.ans_id
		WHERE lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		GROUP BY lqa.ans_flag
		</cfquery>
		
		<cfset TEMP_LB = 0>
		<cfset TEMP_RB = 0>
		<cfset TEMP_INT = 0>
		<cfset TEMP_EXT = 0>
		<cfset TEMP_VNV = 0>
		<cfset TEMP_K = 0>
		<cfset TEMP_VV = 0>
		<cfset TEMP_AV = 0>
				
		<cfoutput query="get_total_lst">
			<cfif ans_flag eq "LB"> 
				<cfset TEMP_LB = nb>
			<cfelseif ans_flag eq "RB">
				<cfset TEMP_RB = nb>
			<cfelseif ans_flag eq "INT">
				<cfset TEMP_INT = nb>
			<cfelseif ans_flag eq "EXT">
				<cfset TEMP_EXT = nb>
			<cfelseif ans_flag eq "VNV">
				<cfset TEMP_VNV = nb>
			<cfelseif ans_flag eq "K">
				<cfset TEMP_K = nb>
			<cfelseif ans_flag eq "VV">
				<cfset TEMP_VV = nb>
			<cfelseif ans_flag eq "AV">
				<cfset TEMP_AV = nb>
			</cfif>
		</cfoutput>
		
		<cfset total_brain = TEMP_LB+TEMP_RB>
		<cfset total_social = TEMP_INT+TEMP_EXT>
		<cfset total_sensory = TEMP_VNV+TEMP_K+TEMP_VV+TEMP_AV>
		
		<!--- <cfoutput> --->
		<!--- total_brain = #total_brain#<br> --->
		<!--- total_social = #total_social#<br> --->
		<!--- total_sensory = #total_sensory#<br> --->
		<!--- TEMP_LB = #TEMP_LB#<br> --->
		<!--- TEMP_RB = #TEMP_RB#<br> --->
		<!--- TEMP_INT = #TEMP_INT#<br> --->
		<!--- TEMP_EXT = #TEMP_EXT#<br> --->
		<!--- TEMP_VNV = #TEMP_VNV#<br> --->
		<!--- TEMP_K = #TEMP_K#<br> --->
		<!--- TEMP_VV = #TEMP_VV#<br> --->
		<!--- TEMP_AV = #TEMP_AV# --->
		<!--- </cfoutput> --->
		
		<!--- <cfabort> --->
		
		<cfset user_lst = "#round((TEMP_LB/total_brain)*100)#,#round((TEMP_RB/total_brain)*100)#,#round((TEMP_INT/total_social)*100)#,#round((TEMP_EXT/total_social)*100)#,#round((TEMP_VNV/total_sensory)*100)#,#round((TEMP_K/total_sensory)*100)#,#round((TEMP_VV/total_sensory)*100)#,#round((TEMP_AV/total_sensory)*100)#">

		<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_user 
		SET quiz_user_end = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET 
		user_lst = '#user_lst#',
		user_lst_lock = 1
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfset SESSION.USER_LST = "#user_lst#">
		<cfset SESSION.USER_LST_LOCK = 1>

		<cfif SESSION.USER_STATUS_ID eq "3">
			<cflocation addtoken="no" url="learner_launch_1.cfm?show_result_lst=1">				
		<cfelse>
			<cflocation addtoken="no" url="quiz_eval.cfm?quiz_user_id=#quiz_user_id#&u_id=#SESSION.USER_ID#">			
		</cfif>
		
	<cfelse>
	
		<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_user 
		SET quiz_user_end = <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cflocation addtoken="no" url="quiz_eval.cfm?quiz_user_id=#quiz_user_id#&u_id=#SESSION.USER_ID#">
		
	</cfif>
	

	
	
	
</cfif>

</cfif>
</cfprocessingdirective>
