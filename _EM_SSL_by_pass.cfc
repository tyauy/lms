<cfcomponent displayname="_EM_SSL_by_pass">

    <cffunction name="checkClientTrusted" returntype="void">
        <cfargument name="chain" type="any">
        <cfargument name="authType" type="string">
        <!--- Do nothing --->
    </cffunction>

    <cffunction name="checkServerTrusted" returntype="void">
        <cfargument name="chain" type="any">
        <cfargument name="authType" type="string">
        <!--- Do nothing --->
    </cffunction>

 <cffunction name="getAcceptedIssuers" returntype="any">
    <!--- Create an empty array --->
   <cfset emptyArray = arraynew(1)>
    <!--- Return the empty array --->
    <cfreturn emptyArray>
</cffunction>


</cfcomponent>
