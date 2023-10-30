<cfif isdefined("form") AND isdefined("updt_tp") AND isdefined("t_id")>

	<!---<cfdump var="#form#">--->

	
	<!--- SELECT EXISTING ---->
	<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
	SELECT session_id FROM lms_tpsession s WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
	
	<!--- CREATE LIST ---->
	<cfset list_session_exists = "">
	<cfset list_session_record = "">

	<cfoutput query="get_session">
	<cfset list_session_exists = listappend(list_session_exists,session_id)>
	</cfoutput>

	
	<cfloop collection="#form#" item="cor">
		<!--- LOOP OVER EXISTING SESSIONS IN FORM AND REORDER CORRECTLY---->
		<cfif mid(cor,1,2) eq "S_">

			<cfset session_id = listgetat(cor,2,"_")>
			<cfset session_temp = listgetat(form[cor],1,"_")>
			<cfset session_master_id = listgetat(form[cor],2,"_")>
			<cfset session_duration = listgetat(form[cor],3,"_")>
			<cfset session_cat = listgetat(form[cor],4,"_")>
			<cfset session_rank = listgetat(form[cor],5,"_")>

			<cfset list_session_record = listappend(list_session_record,session_id)>
			
			<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tpsession SET 
			session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_rank#">
			WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
			AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>
			
			<cfoutput>
			session_id = #session_id#<br>
			session_rank = #session_rank#<br>
			session_duration = #session_duration#<br>
			session_master_id = #session_master_id#<br><br>
			</cfoutput>

		<!--- LOOP OVER EXISTING SESSIONS TO CREATE (STC) AND REORDER CORRECTLY---->
		<cfelseif mid(cor,1,4) eq "STC_">

			to create<br>
			<cfoutput>
			#cor#<br><br>

			<cfset session_temp = listgetat(form[cor],1,"_")>
			<cfset session_master_id = listgetat(form[cor],2,"_")>
			<cfset session_duration = listgetat(form[cor],3,"_")>
			<cfset session_cat = listgetat(form[cor],4,"_")>
			<cfset session_rank = listgetat(form[cor],5,"_")>
			
			stc = #cor#<br>
			session_rank = #session_rank#<br>
			session_duration = #session_duration#<br>
			session_master_id = #session_master_id#<br><br>


			<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
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
			<cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#session_master_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#session_duration#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#session_rank#">,
			0,
			1,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#session_cat#">
			)
			</cfquery>
			
			</cfoutput>

		</cfif>
	</cfloop>

	<!--- LOOP OVER ALREADY EXISTING SESSION IN DATABASE AND DELETE IT IF NOT IN THE FORM---->
	<cfloop list="#list_session_exists#" index="cor">

		<cfif not listfind(list_session_record,cor)>
		<cfquery name="del_session" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfquery>
		</cfif>

	</cfloop>
	
	<!--- COMPARE SESSIONS AND TP DURATION AND CHECK IF TP FINALIZED ---->
	<cfquery name="get_session_duration" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(session_duration) as nb FROM lms_tpsession s WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
	
	<cfquery name="get_tp_duration" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_duration FROM lms_tp t WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
	
	<!--- UPDATE TP STATUS ---->
	<cfif get_session_duration.nb eq get_tp_duration.tp_duration>
		<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_close = 1, tp_status_id = 2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
	<cfelse>
		<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tp SET tp_close = 1, tp_status_id = 2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
	</cfif>
	

	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#&k=1">

<cfelseif isdefined("del_tp") AND isdefined("t_id")>

	<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	<cfquery name="updt_session" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>

	<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#">
	
<cfelseif isdefined("updt_switch") AND isdefined("t_id") AND isdefined("u_id") AND isdefined("s_id") AND isdefined("sm_id")>

	<cfquery name="get_newcat" datasource="#SESSION.BDDSOURCE#">
		SELECT `sessionmaster_cat_id` FROM `lms_tpsessionmaster2` WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>

	<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession SET sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
	cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_newcat.sessionmaster_cat_id#">
	<cfif isdefined("session_duration")>
	,session_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_duration#">
	</cfif>
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	AND session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="common_tp_builder.cfm?t_id=#t_id#&u_id=#u_id#&k=1">

</cfif>







