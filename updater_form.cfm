<cfif isdefined("form_type") AND form_type eq "needs_form" AND isdefined("view")>
		
	<cfparam name="user_jobtitle" default="">
	<!--- <cfparam name="user_needs_course" default=""> --->
	<cfparam name="user_needs_frequency" default="">
	<cfparam name="user_needs_learn" default="">
	<cfparam name="user_needs_complement" default="">
	<cfparam name="user_needs_duration" default="">
	<cfparam name="interest_id" default="">
	<cfparam name="techno_id" default="3">
	<cfparam name="avail_id" default="">
	<!---<cfparam name="expertise_id" default="">--->
	<cfparam name="speaking_id" default="0">

	<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TM">
		
		<!--- ALL NA, PUT FORM VARIABLE IN SESSION --->
		<cfif isdefined("interest_id")>
			<cfset SESSION.INTEREST_ID = interest_id>
		<cfelse>
			<cfset SESSION.INTEREST_ID = "">
		</cfif>
				
		<!---<cfif isdefined("expertise_id")>
			<cfset SESSION.USER_NEEDS_EXPERTISE_ID = expertise_id>
		<cfelse>
			<cfset SESSION.USER_NEEDS_EXPERTISE_ID = "">
		</cfif>--->
		
		<!--- JUST FULL NA, PUT FORM VARIABLE IN SESSION --->
		<cfif view eq "full">
			<cfif isdefined("avail_id")>
				<cfset SESSION.AVAIL_ID = avail_id>
			<cfelse>
				<cfset SESSION.AVAIL_ID = "">
			</cfif>
			
			<cfif isdefined("speaking_id")>
				<cfset SESSION.USER_NEEDS_SPEAKING_ID = speaking_id>
			<cfelse>
				<cfset SESSION.USER_NEEDS_SPEAKING_ID = "0">
			</cfif>
			
			<cfif isdefined("user_needs_learn")>
				<cfset SESSION.USER_NEEDS_LEARN = user_needs_learn>
			<cfelse>
				<cfset SESSION.USER_NEEDS_LEARN = "">
			</cfif>
			
			<cfif isdefined("techno_id")>
				<cfset SESSION.TECHNO_ID = techno_id>
			<cfelse>
				<cfset SESSION.TECHNO_ID = "">
			</cfif>
			<cfset SESSION.USER_JOBTITLE = user_jobtitle>
			<cfset SESSION.USER_PHONE = user_phone>
			<cfset SESSION.USER_PHONE_CODE = user_phone_code>
			<!--- <cfset SESSION.USER_NEEDS_COURSE = user_needs_course> --->
			<cfset SESSION.USER_NEEDS_FREQUENCY = user_needs_frequency>
			<cfset SESSION.USER_NEEDS_COMPLEMENT = user_needs_complement>
			<cfset SESSION.USER_NEEDS_DURATION = user_needs_duration>
			<cfset SESSION.USER_NEEDS_NBTRAINER = user_needs_nbtrainer>
		</cfif>
		
	</cfif>
	
	<cfif view eq "light">
	
		LIIGHT !
		
		
		
		<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
		SELECT sm.*
		FROM lms_tpmaster2 tp
		INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
		<!--- WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> --->
		<!--- AND  --->
		WHERE tp.tpmaster_prebuilt = 0
		AND sm.sessionmaster_online_visio = 1
		AND tp.formation_id = 2
		AND (1 = 2
		<cfloop list="#interest_id#" index="cor">
			OR FIND_IN_SET (<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">, sm.keyword_id)
		</cfloop>
			
		)

		<cfif isdefined("level_id")>
		AND (1 = 2
		<cfloop list="#level_id#" index="cor">
			OR tp.tpmaster_level like '%#cor#%'	
		</cfloop>
		)
		</cfif>

		<!--- AND FIND_IN_SET (<cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">, sm.grammar_id) --->
			

		GROUP BY sm.sessionmaster_id
		ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
		</cfquery>


		<cfset new_list = "">
		<cfloop query="get_session_access">
		<cfset new_list = listappend(new_list,sessionmaster_id)>
		</cfloop>

		<cfset SESSION.USER_EL_LIST = new_list>


	</cfif>
	
	<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user 
	SET 
	<cfif view eq "full">
	user_jobtitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_jobtitle#">,
	<!--- user_needs_course = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_course#">, --->
	user_needs_frequency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_frequency#">,
	user_needs_learn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_learn#">,
	user_needs_complement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_complement#">,
	user_needs_duration = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_duration#">,
	user_needs_speaking_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#speaking_id#">,
	avail_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#avail_id#">,
	techno_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#techno_id#">,
	user_needs_nbtrainer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_needs_nbtrainer#">,
	<cfif user_phone neq "">
		user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
		user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
	</cfif>
	</cfif>
	<cfif isdefined("new_list")>
	user_el_list = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_list#">,
	</cfif>
	interest_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#interest_id#">,
	user_needs = 1
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	
	<cfif findnocase("common_learner_account",CGI.HTTP_REFERER)>
		<cflocation addtoken="no" url="#CGI.HTTP_REFERER#&k=1">
	<cfelseif findnocase("common_practice",CGI.HTTP_REFERER)>
		<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
	<cfelse>
		<!----------- REMOVE STEP NEEDS -------------->
		<cfset temp = obj_lms.updt_step("1")>
		<cflocation addtoken="no" url="learner_index.cfm">
	</cfif>
	
	
<cfelseif isdefined("form_type") AND form_type eq "charter_form">
	

	<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user 
	SET user_charter = 1
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>

	<cfset SESSION.USER_CHARTER = "1">
	
	<cflocation addtoken="no" url="learner_launch_1.cfm">

	
	
	
	
<cfelseif isdefined("form_type") AND form_type eq "lst_form">
	
	<!----------- REMOVE STEP LST -------------->
	<cfset temp = obj_lms.updt_step("3")>
		
	<cflocation addtoken="no" url="learner_launch_1.cfm">

	
	
	
	
<cfelseif isdefined("form_type") AND form_type eq "level_form" AND isdefined("f_code")>

	<!--- <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
	UPDATE user 
	SET user_qpt_#lcase(f_code)# =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">, user_qpt_lock_#lcase(f_code)# = 0
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery> --->
	

	<!--- <cftry> --->
		<!--- NEW INSERT LEVEL --->
		<cfquery name="get_f" datasource="#SESSION.BDDSOURCE#">
			SELECT formation_id FROM lms_formation WHERE formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_code#">
		</cfquery>

		<cfquery name="get_l" datasource="#SESSION.BDDSOURCE#">
			SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">
		</cfquery>

		<cfinvoke component="api/users/user_post" method="up_user_level">
			<cfinvokeargument name="user_id" value="#SESSION.USER_ID#">
			<cfinvokeargument name="skill_id" value="0">
			<cfinvokeargument name="formation_id" value="#get_f.formation_id#">
			<cfinvokeargument name="formation_code" value="#ucase(f_code)#">
			<cfinvokeargument name="level_id" value="#get_l.level_id#">
			<cfinvokeargument name="level_code" value="#user_level#">
			<cfinvokeargument name="level_verified" value="0">
		</cfinvoke>

	<!--- <cfcatch type="any">
		updt_user_level: <cfoutput>#cfcatch.message#</cfoutput>
	</cfcatch>
	</cftry> --->

	
	<!----------- REMOVE STEP LEVEL -------------->
	<cfset temp = obj_lms.updt_step("2")>
	
	<!----------- SET CORRECT QPT LEVEL -------------->
	<cfset "SESSION.USER_QPT_#ucase(f_code)#" = user_level>
	<cfset "SESSION.USER_QPT_#ucase(f_code)#_LOCK" = 0>
	<cfset "SESSION.USER_LEVEL_UNVERIFIED" = user_level>
	
	<cflocation addtoken="no" url="learner_launch_1.cfm">


<cfelseif isdefined("form_type") AND (form_type eq "open_tp" OR form_type eq "workshop_tp") AND (isdefined("t_id") OR isdefined("SESSION.TP_ID"))>
	
	<cfif isdefined("SESSION.TP_ID")>
		<cfset t_id = SESSION.TP_ID>
	</cfif>
	<cfset u_id = SESSION.USER_ID>
	
	<!---- CLEAN TP ANYWAY ---->
	<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tpsession 
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">  
	</cfquery>
	
	<!---- INS FL ---->
	<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id,
	session_duration,
	session_rank,
	method_id,
	cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
	695,
	30,
	1,
	1,
	1
	)
	</cfquery>
	
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
	<cfset tp_master_hour = get_tp.tp_duration/60>

	<cfloop from="2" to="#tp_master_hour#" index="cor">
	
		<!---- FILL TP ---->
		<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpsession
		(
		tp_id,
		sessionmaster_id,
		session_duration,
		session_rank,
		method_id,
		cat_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
		<cfif form_type eq "open_tp">1183<cfelse>697</cfif>,
		60,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
		1,
		1
		)
		</cfquery>
	
	</cfloop>

	<!---- INS PTA ---->
	<cfquery name="ins_pta" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id,
	session_duration,
	session_rank,
	method_id,
	cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
	694,
	30,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_master_hour+1#">,
	1,
	1
	)
	</cfquery>
	

	<cflocation addtoken="no" url="learner_launch_3.cfm">
	
	
<cfelseif isdefined("form_type") AND form_type eq "trainer_tp" AND isdefined("t_id")>
	
	<!---- CLEAN TP ANYWAY ---->
	<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tpsession 
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
	</cfquery>
	
	<!---- INS FL + PTA ---->
	<cfquery name="ins_na" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id,
	session_duration,
	session_rank,
	method_id,
	cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
	695,
	30,
	1,
	1,
	1
	)
	</cfquery>
	
	<cfquery name="ins_pta" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id,
	session_duration,
	session_rank,
	method_id,
	cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
	694,
	30,
	2,
	1,
	1
	)
	</cfquery>

	<cflocation addtoken="no" url="learner_launch_3.cfm">

	
<cfelseif isdefined("form_type") AND form_type eq "affect_trainer" AND isdefined("t_id") AND isdefined("u_id")>

	<cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
	UPDATE user SET 
	user_status_id = 4
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	<cfset SESSION.USER_STATUS_ID = 4>
	<cfset SESSION.ACCESS_VISIO = 1>

	<cfif isdefined("p_list")>
		<cfloop list="#p_list#" index="cor">
			<cfset obj_tp_post.updt_tptrainer_add(t_id=t_id,u_id=u_id,p_id=cor,interne='yes')>
		</cfloop>
	</cfif>

	<cfquery name="get_lessons" datasource="#SESSION.BDDSOURCE#">
		SELECT lesson_id, lesson_start, lesson_end, planner_id  FROM lms_lesson2
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		AND lesson_pending = 1
	</cfquery>

	<cfset lesson_list = "">

	<cfoutput query="get_lessons" group="planner_id">

		<cfoutput>
			<cfset lesson_list = lesson_list & "<tr><td>#lsDateTimeFormat(lesson_start, 'dd-mm-yyyy HH:nn:ss', 'fr')# - #lsDateTimeFormat(lesson_end, 'HH:nn:ss', 'fr')#</td></tr>">
		</cfoutput>

	</cfoutput>

	<!--- <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
		<cfinclude template="./email/email_new_launch.cfm">
	</cfmail> --->
	
	<cfquery name="up_pending" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET
		lesson_pending = 0
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT user_gender, user_name, user_firstname, user_email, user_lang
	FROM user u
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
		<cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
			<cfinvokeargument name="task_type_id" value="72">
			<cfinvokeargument name="u_id" value="#u_id#">
			<cfinvokeargument name="task_channel_id" value="6">
		</cfinvoke>
		
		<cfset subject = "WEFIT | Lancement apprenant OK">
			
		<cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com" bcc="rremacle@wefitgroup.com,trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
			<cfinclude template="./email/email_new_launch.cfm">
		</cfmail>
	
		<cfif SESSION.LAUNCH_GROUP eq 0>
	
			<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&tp_firstlesson=1">
			
		<cfelse>

			<cflocation addtoken="no" url="index.cfm">

		</cfif>
	
	
<cfelseif isdefined("form_type") AND form_type eq "tp_form">

	<cflocation addtoken="no" url="learner_launch_3.cfm">
	
</cfif>