<cfcomponent>

    <!--- Function to handle OPTIONS HTTP method for CORS preflight requests --->
    <cffunction name="options" access="remote" returnType="void" httpMethod="OPTIONS">
        <cfheader name="Access-Control-Allow-Origin" value="http://localhost:8100">
        <cfheader name="Access-Control-Allow-Methods" value="GET,POST">
        <cfheader name="Access-Control-Allow-Headers" value="Content-Type">
    </cffunction>

    <cffunction name="login" access="remote" returnType="any" output="false">
        <cfheader name="Access-Control-Allow-Origin" value="http://localhost:8100">
        <cfheader name="Access-Control-Allow-Methods" value="GET,POST">
        <cfheader name="Access-Control-Allow-Headers" value="Content-Type">
        <cfargument name="user_name" type="string" required="false" default="">
        <cfargument name="user_password" type="string" required="false" default="">
        
        <!--- Query to check if a user with the given credentials exists in the database --->
        <cfquery name="getUser" datasource="#SESSION.BDDSOURCE#">
            SELECT *
            FROM user
            WHERE user_email = <cfqueryparam value="#ARGUMENTS.user_name#" cfsqltype="CF_SQL_VARCHAR">
              AND user_password = <cfqueryparam value="#ARGUMENTS.user_password#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        
        <!--- Check if the query returned any results --->
        <cfif getUser.recordCount gt 0>
            <!--- User exists, create a success response with user data --->
            <cfset response = {
                "status": "success",
                "user": {
                    "id": getUser.UserID,
                    "name": getUser.UserName,
                    "email": getUser.UserEmail
                }
            }>
        <cfelse>
            <!--- User does not exist, create an error response --->
            <cfset response = {
                "status": "error",
                "message": "Invalid credentials"
            }>
        </cfif>
        
        <!--- Output the response as JSON --->
        <cfcontent type="application/json">
        <cfoutput>#serializeJSON(response)#</cfoutput>
    </cffunction>

</cfcomponent>
