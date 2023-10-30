<cfcomponent>
    
    <!------------------ RETRIEVE PACK INFO TO PREFILL TRAINING DEPLOYED ON GENERATING ORDER ------------->
    <cffunction name="oget_formation_pack" access="remote" returntype="any" returnformat="json">
        
        <cfargument name="pack_id" type="numeric" required="yes">

        <cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM lms_formation_pack WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
        </cfquery>

        <cfset table_data = structNew()>
        
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <cfset table_data["pack_id"] = get_pack.pack_id>
        <cfset table_data["pack_name"] = get_pack.pack_name>
        <cfset table_data["pack_hour"] = round(get_pack.pack_hour)>
        <cfset table_data["method_id"] = listtoarray(get_pack.method_id)>
        <cfset table_data["formation_id"] = get_pack.formation_id>
        <cfset table_data["elearning_id"] = get_pack.elearning_id>
        <cfset table_data["pack_duration"] = get_pack.pack_duration>
        <cfset table_data["destination_id"] = get_pack.destination_id>
        <cfset table_data["certif_id"] = get_pack.certif_id>
        <cfset table_data["pack_amount_ht"] = get_pack.pack_amount_ht>
        <cfset table_data["pack_amount_ttc"] = get_pack.pack_amount_ttc>
        
        <cfset table_js = SerializeJSON(table_data)>
        
        <cfreturn table_js> 

    </cffunction>



    <!------------------ GET PACK TO DISPLAY ------------->
    <cffunction name="oget_formation_catalog" access="remote" returntype="query">

        <cfargument name="f_id" type="numeric" required="no">
        <cfargument name="provider_id" type="numeric" required="no">
        <cfargument name="p_id" type="numeric" required="no">
        <cfargument name="m_id" type="numeric" required="no">
        <cfargument name="c_id" type="numeric" required="no">
        <cfargument name="el_id" type="numeric" required="no">
        <cfargument name="e_id" type="numeric" required="no">

        <cfquery name="get_formation_catalog" datasource="#SESSION.BDDSOURCE#">
        SELECT fc.*, f.formation_url, f.formation_code, el.elearning_src, de.destination_name, ap.provider_siret
        FROM lms_formation_pack fc
        INNER JOIN lms_formation f ON f.formation_id = fc.formation_id
        LEFT JOIN lms_list_certification c ON c.certif_id = fc.certif_id
        LEFT JOIN lms_list_elearning el ON el.elearning_id = fc.elearning_id
        LEFT JOIN lms_list_destination de ON de.destination_id = fc.destination_id
        LEFT JOIN account_provider ap ON ap.provider_id = fc.provider_id
        WHERE fc.pack_active = 1

        <cfif isdefined("provider_id")>
        AND fc.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">
        </cfif>
        
        
        <cfif isdefined("f_id")>
        
            AND fc.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
        
            <cfif isdefined("p_id") AND p_id neq "100" AND isdefined("m_id") AND m_id neq "1,3">
            AND pack_hour IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#p_id#">)
            </cfif>
                                
            <cfif isdefined("m_id") AND m_id neq "100">
                <cfif listfind(m_id,"6")>
                    AND (1 = 2
                    <cfloop list="#m_id#" index="cor">
                    OR FIND_IN_SET(#cor#,method_id)
                    </cfloop>
                    )
                    <cfelse>
                        AND method_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#m_id#">
                </cfif>	
            </cfif>
        
            <cfif isdefined("c_id") AND c_id neq "100">
            AND certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
            </cfif>
        
            <cfif isdefined("el_id") AND el_id neq "100" AND isdefined("m_id") AND (listfind(m_id,3) OR m_id eq 100)>
            AND fc.elearning_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#el_id#">
            </cfif>
            
            <cfif isdefined("e_id") AND e_id neq "0">
        
                <cfif e_id eq "500-">
                AND pack_amount_ttc < "500.00"
                <cfelseif e_id eq "500-1000">
                AND pack_amount_ttc >= 500 AND pack_amount_ttc < 1000
                <cfelseif e_id eq "1000-1500">
                AND pack_amount_ttc >= 1000 AND pack_amount_ttc < 1500
                <cfelseif e_id eq "1500+">
                AND pack_amount_ttc >= 1500
                </cfif>
        
            </cfif>
        
            ORDER BY pack_amount_ttc
        
        <cfelse>
        
            ORDER BY rand() LIMIT 5
        
        </cfif>    
        </cfquery>

        <cfreturn get_formation_catalog> 

    </cffunction>

</cfcomponent>