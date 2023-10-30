<cfcomponent>

    <cffunction name="get_word_list" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="vcl_id" type="numeric" required="yes">
		<cfargument name="lang" type="string" required="no" default="en">
		
		<!----- ADD TAUGHT LANGUAGE ----------->
		<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
            SELECT voc_word_#lang# as word FROM lms_vocabulary 
            WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#"> 
            ORDER BY voc_id ASC
        </cfquery>
		
        <!--- <cfset res = "">
        <cfloop query="get_vocabulary">
            <cfif get_vocabulary.currentRow GT 1>
                <cfset res &= " \n ">
            </cfif>
            <cfset res &= "#get_vocabulary.word#">
        </cfloop> --->
        
		<cfprocessingdirective suppresswhitespace="yes">
          <cfset result = SerializeJSON(get_vocabulary, "struct")>
        </cfprocessingdirective>
    
		<cfreturn result>
		
		
	</cffunction>

</cfcomponent>