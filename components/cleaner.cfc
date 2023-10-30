<cfcomponent>
    <cfprocessingdirective pageEncoding="utf-8">
        <cffunction name="renamego" access="public" returntype="string" output="false">
            <cfargument name="torename" type="string" required="yes">
    
            <cfset final_string = replace(trim(torename), " : ", "-", "ALL")>
            <cfset final_string = lcase(final_string)>
            <cfset final_string = replace(final_string, '"', '', "ALL")>
            <cfset final_string = replace(final_string, " - ", "-", "ALL")>
            <cfset final_string = replace(final_string, " + ", "-", "ALL")>
            <cfset final_string = replace(final_string, ":", "", "ALL")>
            <cfset final_string = replace(final_string, " ?", "", "ALL")>
            <cfset final_string = replace(final_string, "?", "", "ALL")> 
            <cfset final_string = replace(final_string, "!", "", "ALL")> 
            <cfset final_string = replace(final_string, "'", " ", "ALL")> 
            <cfset final_string = replace(final_string, "'", " ", "ALL")> 
            <cfset final_string = replace(final_string, "(", "", "ALL")>
            <cfset final_string = replace(final_string, ")", "", "ALL")>
            <cfset final_string = replace(final_string, ".", "", "ALL")>
            <cfset final_string = replace(final_string, ",", "-", "ALL")> 
            <cfset final_string = replace(final_string, "/", " ", "ALL")>
            <cfset final_string = replace(final_string, "&", " ", "ALL")>
            <cfset final_string = replace(final_string, "@", " ", "ALL")>
            <cfset final_string = replace(final_string, " ", "-", "ALL")>
            <cfset final_string = replace(final_string, "%", "", "ALL")>
            <cfset final_string = replace(final_string, "--", "-", "ALL")>
            <cfset final_string = replace(final_string, "--", "-", "ALL")>
            <cfset final_string = replace(final_string, "’", "-", "ALL")>
           
            <cfset final_string = replace(final_string, "é", "e", "ALL")>
            <cfset final_string = replace(final_string, "è", "e", "ALL")>
            <cfset final_string = replace(final_string, "à", "a", "ALL")>
            <cfset final_string = replace(final_string, "ê", "e", "ALL")>
            <cfset final_string = replace(final_string, "î", "i", "ALL")>
            <cfset final_string = replace(final_string, "ë", "e", "ALL")>
           
            
            <cfreturn trim(final_string)>
        </cffunction>
        
    </cfcomponent>