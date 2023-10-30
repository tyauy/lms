<cfparam name="ins_tp_group" default="0">
<cfparam name="ins_tp_vc" default="0">


<cfif isdefined("ins_tp") AND isdefined("form") AND isdefined("u_id")>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
	<!------ CF TRICK FOR DATEPICKER -------------->
	<cfif day(tp_date_start) lte "12">
		<cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-dd-mm')#">
	<cfelse>
		<cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-mm-dd')#">
	</cfif>	

	<cfif day(tp_date_end) lte "12">
		<cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-dd-mm')#">
	<cfelse>
		<cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-mm-dd')#">
	</cfif>	

	<cfif get_user.profile_id eq "9">
		<cfset nbh = 45>
	<cfelse>
		<cfset nbh = replacenocase(tp_duration,",",".","ALL")*60>
	</cfif>
	
	
	<cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp">
	INSERT INTO lms_tp
	(
	user_id,
	order_id,
	tp_status_id,
	tp_date_start,
	tp_date_end,
	tp_name,
	tp_duration,
	formation_id,
	method_id,
	<cfif get_user.profile_id eq "9">
	tp_type_id,
	</cfif>
	
	techno_id,
	elearning_id,
	elearning_duration,
	elearning_url,
	elearning_login,
	elearning_password,
	
	tp_rank,
	tp_vip,
	
	certif_id,
	certif_url,
	certif_login,
	token_id,
	
	destination_id,
	
	creator_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
	<cfif order_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#"><cfelse>null</cfif>,
	<cfif ins_tp_group eq 1>2<cfelse><cfqueryparam cfsqltype="cf_sql_integer" value="#tp_status_id#"></cfif>,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#tp_date_start#">,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#tp_date_end#">,
	<cfif isdefined("tp_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_name#">,<cfelse>null,</cfif>
	<cfqueryparam cfsqltype="cf_sql_integer" value="#nbh#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#">,
	<cfif get_user.profile_id eq "9">
	6,
	</cfif>
	
	<cfif isdefined("techno_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#techno_id#">,<cfelse>null,</cfif>
	<cfif isdefined("elearning_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#">,<cfelse>null,</cfif>
	<cfif isdefined("elearning_duration")><cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_duration#">,<cfelse>null,</cfif>
	<cfif isdefined("elearning_url") AND elearning_url neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_url#">,<cfelse>null,</cfif>
	<cfif isdefined("elearning_login") AND elearning_login neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_login#">,<cfelse>null,</cfif>
	<cfif isdefined("elearning_password") AND elearning_password neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_password#">,<cfelse>null,</cfif>
	
	1,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_vip#">,
	
	<cfif isdefined("certif_id") AND certif_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,<cfelse>null,</cfif>
	<cfif isdefined("certif_url") AND certif_url neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_url#">,<cfelse>null,</cfif>
	<cfif isdefined("certif_login") AND certif_login neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_login#">,<cfelse>null,</cfif>
	<cfif isdefined("token_id") AND token_id neq "0"><cfqueryparam cfsqltype="cf_sql_varchar" value="#token_id#">,<cfelse>0,</cfif>
	
	
	<cfif isdefined("destination_id") AND destination_id neq "0"><cfqueryparam cfsqltype="cf_sql_integer" value="#destination_id#"><cfelse>null</cfif>,
	
	<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	)
	</cfquery>

	<!--- <cfquery name="get_max_tp" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(tp_id) as id FROM lms_tp
	</cfquery> --->

	<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpuser
	(
		user_id,
		tp_id
	)
	VALUES
	(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
	)
	</cfquery>

	<cfif order_id eq "1" OR order_id eq "2">
	<cftry>
    <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO `orders_users`
		(`order_id`, `user_id`) 
		VALUES 
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		)
    </cfquery>
    <cfcatch type="any"></cfcatch>
	</cftry>
	</cfif>

	<!----- CERTIFICATION SCHEDULABLE TP --->
	<cfif method_id eq "7">
	
	<cfquery name="ins_trainer" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpplanner (
			tp_id,
			planner_id,
			active
		)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
			4784,
			1
		)
	</cfquery>
		
	<cfquery name="ins_certif" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id, 
	session_duration,
	method_id,
	cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
	1112, 
	60,
	7,
	1
	)</cfquery>
	</cfif>


	<!----- F2F / VISIO SCHEDULABLE TP --->
	<cfif method_id eq "1" OR method_id eq "2">
	
		<!--- <cfquery name="get_max_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(tp_id) as id FROM lms_tp
		</cfquery> --->

		<cfif tp_create eq "0">
		<!--- [TP VIDE] --->

		<cfelseif tp_create eq "1">
		<!--- [TP NA+PTA] --->

			<!--- CREATE NA --->
			<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpsession
			(
			tp_id,
			sessionmaster_id,
			session_duration,
			session_rank,
			session_close,
			method_id,
			cat_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
			695,
			30,
			1,
			0,
			1,
			1
			);
			</cfquery>

			<!--- CREATE PTA --->
			<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpsession
			(
			tp_id,
			sessionmaster_id,
			session_duration,
			session_rank,
			session_close,
			method_id,
			cat_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
			694,
			30,
			2,
			0,
			1,
			1
			);
			</cfquery>

		<cfelseif tp_create eq "2">
		<!--- [TP TEST] --->

			<!--- CREATE TEST LESSON --->
			<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpsession
			(
			tp_id,
			sessionmaster_id,
			session_duration,
			session_rank,
			session_close,
			method_id,
			cat_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
			769,
			45,
			2,
			0,
			1,
			1
			);
			</cfquery>
			
		</cfif>
	
	</cfif>

	<cfif ins_tp_group eq 1 OR ins_tp_vc eq 1>
		<cflocation addtoken="no" url="cs_list_tp.cfm?k=1">
	<cfelse>
		<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1&tab=3">
	</cfif>
	
<cfelseif isdefined("updt_tp") AND isdefined("form") AND isdefined("u_id") AND isdefined("t_id")>


	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<!------ CF TRICK FOR DATEPICKER -------------->
		<cfif day(tp_date_start) lte "12">
			<cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-dd-mm')#">
		<cfelse>
			<cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-mm-dd')#">
		</cfif>
		<cfif day(tp_date_end) lte "12">
			<cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-dd-mm')#">
		<cfelse>
			<cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-mm-dd')#">
		</cfif>
		<cfset nbh = replacenocase(tp_duration,",",".","ALL")*60>
		
		<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET
		order_id = <cfif order_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#"><cfelse>null</cfif>,
		tp_status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_status_id#">,
		tp_date_start = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#tp_date_start#">,
		<cfif isDefined("tp_name")>tp_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_name#">,</cfif>
		tp_date_end = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#tp_date_end#">,
		tp_vip = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_vip#">
		<cfif isdefined("formation_id")>,formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#"></cfif>
		
		
		<!---method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#">,--->
		
		<cfif isdefined("techno_id")>,techno_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#techno_id#"></cfif>
		<cfif isdefined("tp_formula_id")>,tp_formula_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_formula_id#"></cfif>
		<cfif isdefined("tp_type_id")>,tp_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_type_id#"></cfif>
		<cfif isdefined("tp_session_duration")>,tp_session_duration = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_session_duration#"></cfif>
		<cfif isdefined("tp_skill_id")>,tp_skill_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_skill_id#"></cfif>
		
		
		<cfif isdefined("elearning_id")>,elearning_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#"></cfif>
		<cfif isdefined("elearning_duration")>,elearning_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_duration#"></cfif>
		<cfif isdefined("elearning_url")>,elearning_url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_url#"></cfif>
		<cfif isdefined("elearning_login")>,elearning_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_login#"></cfif>
		<cfif isdefined("elearning_password")>,elearning_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_password#"></cfif>
		
		<cfif isdefined("certif_id") AND certif_id neq "0">,certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#"></cfif>
		<!---<cfif isdefined("certif_token") AND certif_token neq "0">,certif_token = <cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_token#"></cfif>--->
		<cfif isdefined("certif_url") AND certif_url neq "0">,certif_url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_url#"></cfif>
		<cfif isdefined("certif_login") AND certif_login neq "0">,certif_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#certif_login#"></cfif>
		<cfif isdefined("token_id")>,token_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_id#"></cfif>
		
		<cfif isdefined("destination_id") AND destination_id neq "0">,destination_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#destination_id#"></cfif>
		
		,tp_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#nbh#">
		
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
		
		<cfif ins_tp_group eq 1 OR ins_tp_vc eq 1>
			<cflocation addtoken="no" url="cs_list_tp.cfm?k=1">
		<cfelse>
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1&tab=3">
		</cfif>
	<cfelse>
		<cftry>
			<cfif isdefined("techno_id")>
				<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
					UPDATE lms_tp SET
					techno_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#techno_id#">
					WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
				</cfquery>
			</cfif>
			
			<cfinvoke component="api/task/task_post" method="insert_task" returnvariable="insertResult">
				<cfinvokeargument name="task_type_id" value="200">
				<cfinvokeargument name="u_id" value="#u_id#">
				<cfinvokeargument name="task_channel_id" value="6">
				<cfinvokeargument name="task_category" value="FEEDBACK">
			</cfinvoke>
			
			<cfoutput>
				<script>console.log('Task insertion result: ' + '#serializeJSON(insertResult)#');</script>
			</cfoutput>
		
			<cfif ins_tp_group eq 1 OR ins_tp_vc eq 1>
				<cflocation addtoken="no" url="cs_list_tp.cfm?k=1">
			<cfelse>
				<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1&tab=3">
			</cfif>
		
		<cfcatch type="any">
			<cfoutput>
				<script>console.error('Error: ' + '#cfcatch.message#');</script>
			</cfoutput>
		</cfcatch>
		</cftry>
		
		
		
		
	</cfif>
</cfif>

