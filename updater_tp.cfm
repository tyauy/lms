<cfif isdefined("form") AND isdefined("updt_tp") AND isdefined("t_id")>

	<!---<cfdump var="#form#">--->

	<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
	SELECT session_id FROM lms_tpsession s WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
	<cfset list_session_exists = "">
	<cfset list_session_record = "">

	<cfoutput query="get_session">
	<cfset list_session_exists = listappend(list_session_exists,session_id)>
	</cfoutput>

			
	<cfloop collection="#form#" item="cor">
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

		<cfelseif mid(cor,1,4) eq "STC_">

			to create<br>
			<cfoutput>
			#cor#<br><br>

			<cfset session_temp = listgetat(form[cor],1,"_")>
			<cfset session_master_id = listgetat(form[cor],2,"_")>
			<cfset session_duration = listgetat(form[cor],3,"_")>
			<cfset session_cat = listgetat(form[cor],4,"_")>
			<cfset session_rank = listgetat(form[cor],5,"_")>
			
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
			
			stc = #cor#<br>
			session_rank = #session_rank#<br>
			session_duration = #session_duration#<br>
			session_master_id = #session_master_id#<br><br>
			</cfoutput>

		</cfif>
	</cfloop>


	<cfloop list="#list_session_exists#" index="cor">

		<cfif not listfind(list_session_record,cor)>
		<cfquery name="del_session" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfquery>
		</cfif>

	</cfloop>

	<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tp SET tp_close = 1, tp_status_id = 2 WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>

	<cflocation addtoken="no" url="common_tp_builder.cfm?t_id=#t_id#&u_id=#u_id#&k=1">

<cfelseif isdefined("del_tp") AND isdefined("t_id")>

	<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#">

</cfif>












<cfabort>

<cfif isdefined("tp_id") AND isdefined("add_prebuilt") AND isdefined("prebuilt_id")>

<cfquery name="get_mastersession" datasource="#SESSION.BDDSOURCE#">
SELECT c.sessionmaster_id, c.sessionmaster_rank, c.sessionmaster_duration 
FROM lms_tpmastercor c
INNER JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = c.sessionmaster_id	
WHERE c.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#prebuilt_id#"> ORDER BY c.sessionmaster_id
</cfquery>

<cfquery name="get_max_rank" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(session_rank) as session_rank
FROM lms_tpsession s
WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
</cfquery>

<cfif get_max_rank.session_rank neq "">
	<cfset session_rank = get_max_rank.session_rank>
<cfelse>
	<cfset session_rank = 0>
</cfif>


<cfoutput query="get_mastersession">

	<cfset session_rank++>
	
	<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession
	(
	tp_id,
	sessionmaster_id,
	session_rank,
	session_duration
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#session_rank#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_duration#">

	)
	</cfquery>

	</cfoutput>
<cfoutput>#obj_lms.get_tp(tp_id)#</cfoutput>
</cfif>












<cfif isdefined("tp_id") AND isdefined("m_id") AND isdefined("del_module")>

<!----- GET SESSION ----->
<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
SELECT session_id FROM lms_tpsession s
INNER JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = s.sessionmaster_id
WHERE sm.module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#m_id#"> AND s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
</cfquery>

<!----- DELETE SESSION ----->
<cfoutput query="get_session">
<cfquery name="del_session" datasource="#SESSION.BDDSOURCE#">
DELETE FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#session_id#">
</cfquery>
</cfoutput>

<cfoutput>#obj_lms.get_tp(tp_id)#</cfoutput>
</cfif>






<!----- DELETE SESSION SOLO ----->
<cfif isdefined("tp_id") AND isdefined("s_id") AND isdefined("del_session")>
<cfquery name="del_session" datasource="#SESSION.BDDSOURCE#">
DELETE FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
</cfquery>
<cfoutput>#obj_lms.get_tp(tp_id)#</cfoutput>
</cfif>






<cfif isdefined("tp_id") AND isdefined("s_id") AND isdefined("move_session")>
<!----- DELETE SESSION ----->

<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
SELECT session_rank AS r_actual FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
</cfquery>

<cfif move_session eq "up">

	<cfquery name="get_prev" datasource="#SESSION.BDDSOURCE#">
	SELECT session_id AS s_prev, session_rank AS r_prev FROM lms_tpsession 
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	AND session_rank < <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.r_actual#">
	ORDER BY session_rank DESC
	LIMIT 1
	</cfquery>
	
	<cfif get_prev.recordcount neq "0" AND get_prev.r_prev neq "">
	<cfquery name="updt_prev" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession 
	SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.r_actual#">
	WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_prev.s_prev#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	</cfquery>
	<cfquery name="updt_actual" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession 
	SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_prev.r_prev#">
	WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	</cfquery>
	</cfif>

<cfelseif move_session eq "down">

	<cfquery name="get_next" datasource="#SESSION.BDDSOURCE#">
	SELECT session_id AS s_next, session_rank AS r_next FROM lms_tpsession 
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	AND session_rank > <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.r_actual#">
	ORDER BY session_rank ASC
	LIMIT 1
	</cfquery>

	<cfif get_next.recordcount neq "0" AND get_next.r_next neq "">
	<cfquery name="updt_next" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession 
	SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.r_actual#">
	WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next.s_next#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	</cfquery>
	<cfquery name="updt_actual" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession 
	SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_next.r_next#">
	WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
	</cfquery>
	</cfif>
	
</cfif>


<cfoutput>#obj_lms.get_tp(tp_id)#</cfoutput>
</cfif>













<!------------------CREATE SESSION --------------------->
<cfif isdefined("tp_id") AND isdefined("sm_id") AND isdefined("duration")>

	<cfquery name="get_max_rank" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(session_rank) as maxrank FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">	
	</cfquery>
	
	<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_tpsession 
	(
	tp_id,
	sessionmaster_id,
	session_duration,
	session_rank
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#duration#">,
	<cfif get_max_rank.maxrank neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_rank.maxrank+1#"><cfelse>1</cfif>
	)
	</cfquery>	

<cfoutput>#obj_lms.get_tp(tp_id)#</cfoutput>
</cfif>


