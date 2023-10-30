<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">




	<cffunction name="rm_user_about" access="remote" returntype="any">
		<cfargument name="uaid" type="numeric" required="yes">
		
		<cfquery name="rm_about" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_about WHERE user_about_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#uaid#">
		</cfquery>

	</cffunction>



	<cffunction name="add_user_about" access="remote" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="about_type" type="varchar" required="yes">
		<cfargument name="about_desc" type="varchar" required="yes">
		
		
		<cfquery name="add_user_about" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_about (user_id, user_about_type, user_about_desc) 
			VALUES (#p_id#, '#about_type#', '#about_desc#')
		</cfquery>
	</cffunction>

	
</cfprocessingdirective>

</cfcomponent>