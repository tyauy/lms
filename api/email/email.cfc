<cfcomponent>

    <!--- output="false" --->
    <cffunction name="send_simple_email" access="public" returntype="numeric" >
        <cfargument name="to" type="string" required="yes">
        <cfargument name="lang" type="string" required="no" default="fr">
        <cfargument name="subject" type="string" required="yes">
        <cfargument name="template" type="string" required="no">
        <cfargument name="email_title" type="string" required="yes">
        <cfargument name="email_subtitle" type="string" required="no">
        
		<cftry>


        <!--- rremacle@wefitgroup.com,service@wefitgroup.com,finance@wefitgroup.com,trainer@wefitgroup.com --->
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#to#" subject="#subject#" type="html" server="localhost">
            <cfif isDefined("template")>
                <cfinclude template="#template#">
            <cfelse>
                <cfinclude template="/email/email_simple.cfm">
            </cfif>
		</cfmail>
		
		<cfreturn 1>

		<cfcatch type="any">
			Error: <cfoutput>#cfcatch.message#</cfoutput>
			<cfreturn 0>
		</cfcatch>
		</cftry>

	</cffunction>


</cfcomponent>