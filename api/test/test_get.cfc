<cfcomponent restpath="test" rest="true" httpMethod="GET" >

	<cffunction name="oget_path" access="remote" returntype="any" returnFormat="JSON">

		<!--- <cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
		SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name FROM settings_country WHERE phone_code IS NOT NULL
		</cfquery>


		<cfprocessingdirective suppresswhitespace="yes">
		<cfset result = SerializeJSON(get_country_phone, "struct")>
		</cfprocessingdirective> --->

    	<cfreturn PATH_TRANSLATED>
		
	</cffunction>


    <cffunction name="test1" restpath="test1" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="p_id" type="numeric" required="yes">
        <cftry>



            <cfset SESSION.TESTAPISESS = p_id>
            <cfreturn "OK">
  
            

            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
                <cfreturn "{ error: 500, content #cfcatch.message#}">
            </cfcatch>
        </cftry>
	</cffunction>


    <cffunction name="test2" access="remote" returntype="any" returnFormat="JSON">

		<cfreturn SESSION.TESTAPISESS>
		
	</cffunction>


</cfcomponent>