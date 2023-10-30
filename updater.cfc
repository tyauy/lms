<cfcomponent>	
	
	<cffunction name="shortlist" access="remote" output="false" returntype="any" returnformat="plain">
	
	
		<cfargument name="sm_id" type="numeric" required="yes">

		<cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sm_id#)>
			
			<cfset new_shortlist = listdeleteat(SESSION.USER_SHORTLIST, ListFind(SESSION.USER_SHORTLIST,sm_id)) />
			<cfset result = "off">
			
		<cfelse>
		
			<cfset new_shortlist = listappend(SESSION.USER_SHORTLIST,sm_id)>
			<cfset result = "on">
			
		</cfif>
		
		<cfset SESSION.USER_SHORTLIST = new_shortlist>
		
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_shortlist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_shortlist#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
			
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="el_list" access="remote" output="false" returntype="any" returnformat="plain">
	
	
		<cfargument name="sm_id" type="numeric" required="yes">

		<cfif isdefined("SESSION.USER_EL_LIST") AND listfind(SESSION.USER_EL_LIST,#sm_id#)>
			
			<cfset new_shortlist = listdeleteat(SESSION.USER_EL_LIST, ListFind(SESSION.USER_EL_LIST,sm_id)) />
			<cfset result = "off">
			
		<cfelse>
		
			<cfset new_shortlist = listappend(SESSION.USER_EL_LIST,sm_id)>
			<cfset result = "on">
			
		</cfif>
		
		<cfset SESSION.USER_EL_LIST = new_shortlist>
		
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_el_list = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_shortlist#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
			
		<cfreturn result>
		
	</cffunction>
	
	
	<cffunction name="updt_progress" access="remote" output="false" returntype="any">
			
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_elapsed = user_elapsed+5
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfquery name="get_time" datasource="#SESSION.BDDSOURCE#">
		SELECT user_elapsed FROM user
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		
		<cfset SESSION.USER_ELAPSED = get_time.user_elapsed>
			
		<cfreturn "ok">
		
	</cffunction>
	
	
</cfcomponent>