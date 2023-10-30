<cfcomponent>

    <cffunction name="oget_task_list" access="public" returntype="query" output="false" description="Retrieve list of task type">
	
		<cfargument name="task_type" type="any" required="no">
		<cfargument name="category" type="any" required="no">
		<cfargument name="profile_id" type="any" required="no">
		
		<cfquery name="get_task_list" datasource="#SESSION.BDDSOURCE#">
		SELECT task_type_id, task_type_name, task_group, task_group_alias, task_group_sub, task_color, task_automation, task_group_rank, task_category, profile_id, task_online, task_explanation_#SESSION.LANG_CODE# as task_explanation
		FROM task_type WHERE 1=1
		<cfif isdefined("task_type")>AND task_group like '%#task_type#_%'</cfif>
		<cfif isdefined("category")>AND task_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#category#"></cfif>
		<cfif isdefined("profile_id")>AND FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_integer" value="#profile_id#">,profile_id)</cfif>
		AND task_online = 1
		ORDER BY task_group_rank, task_group, task_group_sub, task_type_name
		</cfquery>
		
		<cfreturn get_task_list>
		
	</cffunction>


	<cffunction name="oget_task_channel" access="public" returntype="query" output="false" description="Retrieve list of task channel">
		<cfargument name="task_channel_type" type="any" required="no">

		<cfquery name="get_task_channel" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM task_channel
		<cfif isdefined("task_channel_type")>WHERE FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_channel_type#">,task_channel_type)</cfif>
		</cfquery>
		
		<cfreturn get_task_channel>
		
	</cffunction>

	<cffunction name="oget_to" access="public" returntype="query" output="false" description="Retrieve list of active WEFIT teamates, for task assignation">
			
		<cfargument name="pf_id" type="any" required="no">

		<cfquery name="get_to" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_firstname, u.user_id 
		FROM user u 
		INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
		INNER JOIN user_profile up ON upc.profile_id = up.profile_id
		WHERE <cfif isdefined("pf_id")>upc.profile_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#pf_id#">) <cfelse>upc.profile_id IN (2,5,6,12) </cfif>
		AND u.user_status_id = 4 
		GROUP BY u.user_id
		ORDER BY u.user_firstname
		</cfquery>
		
		<cfreturn get_to>
		
	</cffunction>



	<cffunction name="oget_log" access="public" returntype="query" output="true" description="Retrieve results from logs table">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="p_id" type="numeric" required="no">
		<cfargument name="o_id" type="numeric" required="no">
		<cfargument name="category" type="any" required="no">
		<cfargument name="o_by" type="any" required="no">
		<cfargument name="profile_id" type="any" required="no">
		<cfargument name="log_status" type="any" required="no">
        <cfargument name="log_id" type="numeric" required="no">

		<cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
		SELECT lo.log_id, lo.log_text, lo.log_date, lo.log_remind, lo.log_status, lo.task_channel_id, lo.to_id, lo.from_id,
		f.user_firstname as sender, t.user_firstname as recipient, up.profile_name,
		loi.task_type_id, loi.log_item_status,
		tt.task_type_name, tt.task_color, tt.task_category, tt.task_explanation_#SESSION.LANG_CODE# as task_explanation, task_explanation_long, tt.profile_id,
		u.user_firstname as user_firstname, u.user_name as user_name
		FROM logs lo
		INNER JOIN logs_item loi ON loi.log_id = lo.log_id
		LEFT JOIN task_type tt ON tt.task_type_id = loi.task_type_id 
		LEFT JOIN user f ON lo.from_id = f.user_id
		LEFT JOIN user t ON lo.to_id = t.user_id
		LEFT JOIN user u ON lo.user_id = u.user_id
		LEFT JOIN user_profile up ON f.profile_id = up.profile_id
		WHERE 1 = 1
		
		<cfif isdefined("u_id") AND u_id neq "0">
		AND lo.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("a_id") AND a_id neq "0">
		AND lo.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>

		<cfif isdefined("g_id") AND g_id neq "0">
		AND lo.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		
		<cfif isdefined("o_id")>
		AND lo.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfif>
		
        <cfif isdefined("log_id")>
		AND lo.log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
		</cfif>

		<cfif isdefined("log_status")>
		<cfif log_status eq "1">
		AND lo.log_status = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_status#">
		<cfelse>
		AND lo.log_status IS NULL
		</cfif>
		
		</cfif>
		
		<cfif isdefined("category")>
		AND tt.task_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#category#">
		</cfif>

		<cfif isdefined("profile_id") AND profile_id neq "2" AND profile_id neq "5" AND profile_id neq "6" AND profile_id neq "12">
		AND (1 = 2
		<cfloop list="#profile_id#" index="cor">
		OR FIND_IN_SET(#cor#,tt.profile_id)
		</cfloop>
		)
		</cfif>
		
		<cfif isdefined("o_by")>
		<cfif o_by eq "log_remind">
		ORDER BY lo.log_remind ASC
		<cfelse>
		ORDER BY lo.log_date DESC
		</cfif>		
		</cfif>
		
		</cfquery>
		
		<cfreturn get_log> 
	
	</cffunction>

	<cffunction name="oget_count_log" access="public" returntype="query" output="true" description="Retrieve results from logs table">
		<cfargument name="a_id" type="numeric" required="no">

		<cfquery name="get_count_log" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(lo.log_id) as nb
		FROM logs lo
		INNER JOIN logs_item loi ON loi.log_id = lo.log_id
		LEFT JOIN task_type tt ON tt.task_type_id = loi.task_type_id 
		WHERE 1 = 1
		
		<cfif isdefined("u_id") AND u_id neq "0">
		AND lo.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfif>
		
		<cfif isdefined("a_id") AND a_id neq "0">
		AND lo.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>

		<cfif isdefined("g_id") AND g_id neq "0">
		AND lo.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		
		<cfif isdefined("o_id")>
		AND lo.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfif>

		<cfif isdefined("log_status")>
		<cfif log_status eq "1">
		AND lo.log_status = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_status#">
		<cfelse>
		AND lo.log_status IS NULL
		</cfif>
		</cfif>
		
		<cfif isdefined("category")>
		AND tt.task_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#category#">
		</cfif>
		
		</cfquery>
		
		<cfreturn get_count_log> 
	
	</cffunction>


</cfcomponent>