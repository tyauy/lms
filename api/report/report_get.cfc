<cfcomponent>

    <cffunction name="oget_method_list" access="remote" returntype="any" returnformat="json" description="Retrieve list of method type">
	
        <cftry>

        <cfquery name="get_lesson_method" datasource="#SESSION.BDDSOURCE#">
            SELECT method_id, method_alias_fr FROM `lms_lesson_method`
        </cfquery>
		
		<cfprocessingdirective suppresswhitespace="yes">
          <cfset table_js = SerializeJSON(get_lesson_method, "struct")>
        </cfprocessingdirective>
    
        <cfreturn table_js>

        <cfcatch type="any">
            insert_invoice: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfoutput>#cfcatch.detail#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>


    <cffunction name="oget_report_json" access="remote" returntype="any" method="POST" returnformat="json" description="Retrieve list of method type">
        <cfargument name="report" type="string" required="yes">
        <cfargument name="option" type="string" required="no" default="">

        <cfset _option = {}>

        <!--- <cftry> --->

            <cfif option neq "">
                <cfset _option = deserializeJSON(option)>
            </cfif>

            <cfinvoke component="#SESSION.REPORT_OPTION[report].path#" method="#SESSION.REPORT_OPTION[report].method#" returnVariable="result">

                <cfloop collection=#_option# item="_item">
                    <cfinvokeargument name="#_item#" value="#_option[_item]#">
                </cfloop>

            </cfinvoke>

            <!--- <cfdump var="#result#"> --->

		
            <cfprocessingdirective suppresswhitespace="yes">
                <cfset table_js = SerializeJSON(result, "struct")>
            </cfprocessingdirective>
        
            <cfreturn table_js>
<!--- 
        <cfcatch type="any">
            oget_report_json: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
		
	</cffunction>


</cfcomponent>