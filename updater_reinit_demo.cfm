<cfif isdefined("u_id") AND isdefined("reinit") AND (
u_id eq "411" 
OR u_id eq "7767" 
OR u_id eq "2030" 
OR u_id eq "4841"
OR u_id eq "11743"
OR u_id eq "11744"
OR u_id eq "25911"
OR u_id eq "25913"
OR u_id eq "11745"
OR u_id eq "11746"
OR u_id eq "11747"
OR u_id eq "4348"
OR u_id eq "11683"
OR u_id eq "11682"
OR u_id eq "28538"
OR u_id eq "27578"
OR u_id eq "30384"
)> 
									
														
	<cfset get_tps_access = obj_tp_get.oget_tps(u_id="#u_id#",m_id="1")>
	
	<cfoutput query="get_tps_access">				
		<cfif method_id eq "1" AND (formation_id eq "1" OR formation_id eq "2" OR formation_id eq "3")>
			<cfset stepper = "1,2,3">
		</cfif>
		<cfquery name="reset_tp_trainer" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tpplanner SET 
			active = 0, 
			modification_date = NOW()
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
		</cfquery>
	</cfoutput>
	
	
	<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tp SET 
	tp_status_id = 1, 
	tp_formula_id = null,
	tp_type_id = null,
	tp_support_id = null,
	tp_skill_id = null,
	tp_interest_id = null,
	tp_function_id = null,
	tp_orientation_id = null,
	tp_session_duration = null
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND method_id NOT IN (3,11,10)
	</cfquery>

	<cfquery name="del_lesson" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_lesson2 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cfquery name="del_tp_method" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tpuser 
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
	AND tp_id 
	IN (SELECT tp_id FROM lms_tp WHERE method_id = 10)
	</cfquery>

	<cfquery name="del_lesson_attendance" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_lesson2_attendance WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT quiz_user_id FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cfoutput query="get_quiz">

		<cfquery name="del_quiz_question" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_result WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="del_quiz" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_user WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
	</cfoutput>

	<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user SET
	user_status_id = 3,

	user_lst = null,
	user_lst_lock = null,
	user_qpt = null,
	user_qpt_lock = null,
	user_charter = null,
	situation_id = null,
	interest_id = null,
	avail_id  = null,
	expertise_id = null,
	user_steps = <cfif isdefined("stepper")>'#stepper#',<cfelse>'1,2,3',</cfif>
	
	user_el_list = null,
	
	user_level = null,
	user_needs = null,
	user_needs_course = null,
	user_needs_trainer = null,
	user_needs_frequency = null,
	user_needs_nbtrainer = null,
	user_needs_learn = null,
	user_needs_complement = null,
	user_needs_trainer_complement = null,
	user_needs_theme = null,
	user_needs_duration = null,

	user_qpt_fr = null,
	user_qpt_lock_fr = null,
	user_qpt_en = null,
	user_qpt_lock_en = null,
	user_qpt_es = null,
	user_qpt_lock_es = null,
	user_qpt_de = null,
	user_qpt_lock_de = null,
	user_qpt_it = null,
	user_qpt_lock_it = null,
	user_qpt_ar = null,
	user_qpt_lock_ar = null,
	user_qpt_iw = null,
	user_qpt_lock_iw = null,
	user_qpt_zh = null,
	user_qpt_lock_zh = null,
	user_qpt_nl = null,
	user_qpt_lock_nl = null,
	user_qpt_pl = null,
	user_qpt_lock_pl = null,
	user_qpt_pt = null,
	user_qpt_lock_pt = null,
	user_qpt_ru = null,
	user_qpt_lock_ru = null,
	user_qpt_ja = null,
	user_qpt_lock_ja = null,
	user_qpt_da = null,
	user_qpt_lock_da = null,
	user_qpt_gr = null,
	user_qpt_lock_gr = null,
	user_setup = 1,
	user_needs_speaking_id = null,
	user_needs_expertise_id = null

	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">

	</cfquery>

	<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#">


</cfif>