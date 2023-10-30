<cfif isdefined("form") AND isdefined("updt_tppack") AND isdefined("pack_id")>

	<cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_formation_pack
	SET
	pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">,
	pack_hour = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_hour#">,
	pack_objectives = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_objectives#">,
	pack_results = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_results#">,
	pack_content = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_content#">
	WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>
	



	<cflocation addtoken="no" url="db_tppack_builder.cfm?pack_id=1&k=1">
</cfif>