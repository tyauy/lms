<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">


	
	
	<cffunction name="updt_workinghour" access="remote" returntype="any">
	
		<cfargument name="day_mon_start_am" type="any" required="no">
		<cfargument name="day_mon_start_pm" type="any" required="no">
		<cfargument name="day_mon_end_am" type="any" required="no">
		<cfargument name="day_mon_end_pm" type="any" required="no">
		
		<cfset result = StructNew()>
		<cfset result[0] = get_max.speaking_id>
		<cfset result[1] = lcase(get_max.formation_code)>
		<cfset result[2] = get_max.formation_name>
		<cfset result[3] = level_speaking_id>
		<cfreturn result>

	</cffunction>
	
	
	
	
	
	
	
	
</cfprocessingdirective>
</cfcomponent>