<cfscript>

/** @param aofS      Array of structures. (Required)
* @param key      Key to sort by. (Required)
* @param sortOrder      Order to sort by, asc or desc. (Optional)
* @param sortType      Text, textnocase, or numeric. (Optional)
* @param delim      Delimiter used for temporary data storage. Must not exist in data. Defaults to a period. (Optional)
**/

function arrayOfStructsSort(aOfS,key){
        var sortOrder = "asc";        
        var sortType = "textnocase";
        var delim = ".";
        //make an array to hold the sort stuff
        var sortArray = arraynew(1);
        //make an array to return
        var returnArray = arraynew(1);
        //grab the number of elements in the array (used in the loops)
        var count = arrayLen(aOfS);
        //make a variable to use in the loop
        var ii = 1;
        //if there is a 3rd argument, set the sortOrder
        if(arraylen(arguments) GT 2)
            sortOrder = arguments[3];
        //if there is a 4th argument, set the sortType
        if(arraylen(arguments) GT 3)
            sortType = arguments[4];
        //if there is a 5th argument, set the delim
        if(arraylen(arguments) GT 4)
            delim = arguments[5];
        //loop over the array of structs, building the sortArray
        for(ii = 1; ii lte count; ii = ii + 1)
            sortArray[ii] = aOfS[ii][key] & delim & ii;
        //now sort the array
        arraySort(sortArray,sortType,sortOrder);
        //now build the return array
        for(ii = 1; ii lte count; ii = ii + 1)
            returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
        //return the array
        return returnArray;
}

public string function getClientIp() {
    local.response = "";

    try {
        try {
            local.headers = getHttpRequestData().headers;
            if (structKeyExists(local.headers, "X-Forwarded-For") && len(local.headers["X-Forwarded-For"]) > 0) {
                local.response = trim(listFirst(local.headers["X-Forwarded-For"]));
            }
        } catch (any e) {}

        if (len(local.response) == 0) {
            if (structKeyExists(cgi, "remote_addr") && len(cgi.remote_addr) > 0) {
                local.response = cgi.remote_addr;
            } else if (structKeyExists(cgi, "remote_host") && len(cgi.remote_host) > 0) {
                local.response = cgi.remote_host;
            }
        }
    } catch (any e) {}

    return local.response;
}

</cfscript>

<cffunction name="get_duration_format" access="remote">
    <cfargument name="pack_duration" type="any" required="yes">
    
    <cfif pack_duration eq "1">
        <cfset togo = "1 jour">
    <cfelseif pack_duration eq "7">
        <cfset togo = "1 semaine">
    <cfelseif pack_duration eq "30">
        <cfset togo = "1 mois">
    <cfelse>
        <cfset togo = "#pack_duration/30# mois">
    </cfif>
    
    <cfreturn togo>

</cffunction>

<cffunction name="get_dateformat" access="public" returntype="string">
	
    <cfargument name="datego" type="date">
    <cfargument name="user_lang" required="no">

    <cfif isdefined("user_lang")>

    <cfif user_lang eq "fr">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelseif user_lang eq "en">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelseif user_lang eq "de">
        <cfset datego = dateformat(datego,'dd.mm.yyyy')>
    <cfelseif user_lang eq "es">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelse>
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    </cfif>

    <cfelse>

    <cfif SESSION.LANG_CODE eq "fr">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelseif SESSION.LANG_CODE eq "en">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelseif SESSION.LANG_CODE eq "de">
        <cfset datego = dateformat(datego,'dd.mm.yyyy')>
    <cfelseif SESSION.LANG_CODE eq "es">
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    <cfelse>
        <cfset datego = dateformat(datego,'dd/mm/yyyy')>
    </cfif>
    
    </cfif>
    
    <cfreturn datego>

</cffunction>

<cffunction name="get_thumb_border" access="public" returntype="any">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="size" type="numeric" required="yes">
    <cfargument name="responsive" type="any" required="no">
    <cfargument name="display_title" type="any" required="no">
    <cfargument name="style" type="any" required="no">
    <cfargument name="css" type="any" required="no">
    <cfargument name="align" type="any" required="no">
    <cfargument name="class" type="any" required="no">

    <cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
    SELECT user_gender, user_firstname FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
    </cfquery>
            
    <cfoutput>
        <cfif fileexists("https://lms.wefitgroup.com/assets/user/#user_id#/photo.jpg")>
            <img src="https://lms.wefitgroup.com/assets/user/#user_id#/photo.jpg" width="#size#" title="<cfif isdefined("display_title")>#display_title#</cfif>"
            <cfif isdefined("style")>style="#style#"</cfif> 
            <cfif isdefined("align")>align="#align#"</cfif>
            <cfif isdefined("class")>class="#class#"</cfif>>
        </cfif>
    </cfoutput>
    
</cffunction>


<cffunction name="get_level_thumb" access="public" returntype="any" output="true">
    <cfargument name="level_id" type="any" required="yes">
    <cfargument name="size" type="numeric" required="no">

    <cfoutput>
    <cfloop list="0,1,2,3,4,5,6,100" index="cor">
        <cfif listfind(level_id,cor)>
        <img src='https://lms.wefitgroup.com/assets/img_level/#cor#_plain.svg' <cfif isdefined("size")>width="#size#"</cfif>>
        </cfif>
    </cfloop>
    </cfoutput>
    
</cffunction>

