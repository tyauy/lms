<cfcomponent>
	<cffunction name="get_case" access="public" returntype="string">
		<cfargument name="table_js" type="string" required="yes">

<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
<cfset table_js = replacenocase(table_js,"TITLE","title","ALL")>
<cfset table_js = replacenocase(table_js,"START","start","ALL")>
<cfset table_js = replacenocase(table_js,"END","end","ALL")>
<cfset table_js = replacenocase(table_js,"EVENTCOLOR","eventcolor","ALL")>
<cfset table_js = replacenocase(table_js,"COLOR","color","ALL")>
<cfset table_js = replacenocase(table_js,"RENDERING","rendering","ALL")>
<cfset table_js = replacenocase(table_js,"CONSTRAINT","constraint","ALL")>
<cfset table_js = replacenocase(table_js,"RESOURCEID","resourceId","ALL")>
<cfset table_js = replacenocase(table_js,".0","","ALL")>

        <cfreturn table_js>
        
     </cffunction>
	 
</cfcomponent>