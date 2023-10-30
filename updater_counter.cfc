<cfcomponent>

	<cffunction name="oget_material" access="remote" output="false" returntype="any" returnFormat="JSON">
		<cfargument name="interest_id" type="any" required="yes">
		<cfargument name="level_id" type="any" required="no">
	
		<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
		SELECT sm.*
		FROM lms_tpmaster2 tp
		INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
		<!--- WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> --->
		<!--- AND  --->
		WHERE tp.tpmaster_prebuilt = 0
		AND sm.sessionmaster_online_visio = 1
		AND tp.formation_id = 2
		AND (1 = 2
		<cfloop list="#interest_id#" index="cor">
			OR FIND_IN_SET (<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">, sm.keyword_id)
		</cfloop>
			
		)

		<cfif isdefined("level_id")>
		AND (1 = 2
		<cfloop list="#level_id#" index="cor">
			OR tp.tpmaster_level like '%#cor#%'	
		</cfloop>
		)
		</cfif>

		<!--- AND FIND_IN_SET (<cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">, sm.grammar_id) --->
			

		GROUP BY sm.sessionmaster_id
		</cfquery>


		<!--- <cfset new_list = ""> --->
		<!--- <cfloop query="get_session_access"> --->
		<!--- <cfset new_list = listappend(new_list,sessionmaster_id)> --->
		<!--- </cfloop> --->
			
		
		<cfreturn get_material.recordcount>
		
	</cffunction>
	
	
	
</cfcomponent>