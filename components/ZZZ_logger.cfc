<cfcomponent>

	<cffunction name="ins_log" access="public" returntype="any">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="a_id" type="numeric" required="no">
		<cfargument name="g_id" type="numeric" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="log_text" type="any" required="yes">
		<cfargument name="log_date" type="any" required="no">
		<cfargument name="log_remind_ok" type="any" required="no">

		<!--------------------- DATE TREATMENT ----------------->
		<cfif isdefined("log_remind_ok")>
			<cfif day(log_remind) lte "12">		
				<cfset log_remind_date = "#dateformat(log_remind,'yyyy-dd-mm')# #timeformat(log_remind,'HH:mm:00')#">
				<cfset log_remind_from = "#timeformat(dateadd("n",-120,log_remind),'HHmm')#">
				<cfset log_remind_to = "#timeformat(dateadd("n",-90,log_remind),'HHmm')#">
				<cfset log_remind_gg = "#dateformat(log_remind,'yyyyddmm')#T#log_remind_from#00Z/#dateformat(log_remind,'yyyyddmm')#T#log_remind_to#00Z">
			<cfelse>
				<cfset log_remind_date = "#dateformat(log_remind,'yyyy-mm-dd')# #timeformat(log_remind,'HH:mm:00')#">
				<cfset log_remind_from = "#timeformat(dateadd("n",-120,log_remind),'HHmm')#">
				<cfset log_remind_to = "#timeformat(dateadd("n",-90,log_remind),'HHmm')#">
				<cfset log_remind_gg = "#dateformat(log_remind,'yyyymmdd')#T#log_remind_from#00Z/#dateformat(log_remind,'yyyymmdd')#T#log_remind_to#00Z">
			</cfif>
		</cfif>

		<cfquery name="insert_log" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO logs (
		user_id, 
		account_id,
		group_id,
		log_text, 
		log_date, 
		<cfif isdefined("log_remind_ok")>log_remind,</cfif>
		from_id,
		to_id,
		task_type_id,
		profile_id,
		log_status
		)
		VALUES 
		(
		<cfif isdefined("u_id") AND u_id neq "0" AND u_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"><cfelse>null</cfif>,
		<cfif isdefined("a_id") AND a_id neq "0" AND a_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"><cfelse>null</cfif>,
		<cfif isdefined("g_id") AND g_id neq "0" AND g_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#"><cfelse>null</cfif>,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#log_text#">,
		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
		<cfif isdefined("log_remind_ok")><cfqueryparam cfsqltype="cf_sql_timestamp" value="#log_remind_date#">,</cfif>
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		<cfif isdefined("to_id") AND to_id neq "0"><cfqueryparam cfsqltype="cf_sql_integer" value="#to_id#">,<cfelse>null,</cfif>
		<cfif task_type_id neq "0"><cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#"><cfelse>null</cfif>,
		<cfif isdefined("profile_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#profile_id#"></cfif>,
		<cfif task_category eq "TO DO">null<cfelse>1</cfif>
		)	
		</cfquery>

        <cfreturn "ok">
        
     </cffunction>
	     
</cfcomponent>