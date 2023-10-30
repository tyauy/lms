<cfcomponent>

    <cffunction name="get_order_users" access="remote" returntype="any" returnFormat="JSON">
    

    </cffunction>




    <cffunction name="updt_contact_lead" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="contact_id" type="numeric" required="yes">

        <cfquery name="updt_contact_lead" datasource="#SESSION.BDDSOURCE#">
        UPDATE account_contact
        SET 

        contact_lead = (CASE contact_lead WHEN "0" THEN "1" ELSE "0" END)

        <!---contact_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_firstname#">,
        contact_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_name#">,
        contact_tel1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel1#">,
        contact_tel2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel2#">,
        contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_email#">,
        contact_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_title#">,
        CASE contact_lead WHEN 1 THEN  contact_lead = <cfif contact_lead eq "1">1<cfelse>0</cfif>
        contact_invoice = <cfif contact_invoice eq "1">1<cfelse>0</cfif>,
        contact_active = <cfif contact_active eq "1">1<cfelse>0</cfif>,
        contact_details = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_details#">,
        function_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#function_id#">--->
        WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
        </cfquery>

        <cfreturn "ok">
        
    </cffunction>



</cfcomponent>