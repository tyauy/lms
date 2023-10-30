<cfif isdefined("form") AND isdefined("t_id") AND isdefined("s_id") AND isdefined("u_id")>

	<cfquery name="updt_session" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsession
	SET	session_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session_name#">,
	skill_id = <cfif isdefined("skill_id") AND skill_id neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#skill_id#"><cfelse>null</cfif>,
	<cfif isdefined("level_id") AND level_id neq "">
	level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_id#">,
	<cfelse>
	level_id = null,
	</cfif>
	<cfif isdefined("mapping_id") AND mapping_id neq "">
	mapping_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_id#">,
	<cfelse>
	mapping_id = null,	
	</cfif>
	<cfif isdefined("origin_id") AND origin_id neq "">
	origin_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#origin_id#">,
	</cfif>
	keyword_id = <cfif isdefined("keyword_id") AND keyword_id neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#keyword_id#"><cfelse>null</cfif>
	WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
	AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
		
	<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#">


<cfelseif isdefined("form") AND isdefined("tpmastercor_id")>

	<cfquery name="updt_session" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpmastercor2
	SET	tpmastercor_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmastercor_name#">,
	tpmastercor_mapping_id = <cfif isdefined("tpmastercor_mapping_id") AND tpmastercor_mapping_id neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmastercor_mapping_id#"><cfelse>null</cfif>
	WHERE tpmastercor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmastercor_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_tpprefilled_list.cfm?f_id=#f_id#">

</cfif>



