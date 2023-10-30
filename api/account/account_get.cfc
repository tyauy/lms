<cfcomponent>

    <cffunction name="get_account" access="remote" returntype="query">
        <cfargument name="a_id" type="numeric" required="no">
        <cfargument name="manager_id" type="any" required="no">
        <cfargument name="t_id" type="any" required="no">
        <cfargument name="pv_id" type="any" required="no">
        <cfargument name="st_id" type="any" required="no">


        <cfparam name="o_by" default="account_name">
       

        <cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
        SELECT a.*, 
        s.sector_name, sz.size_name, t.type_name, t.type_css, 
        ap.*,
        ag.group_name, ag.group_hash, ag.provider_id,
        u.user_firstname as account_manager, u.user_color as account_manager_color, 
        u2.user_firstname as account_owner, u2.user_color as account_owner_color, 
        co1.country_name_fr as account_country_name, co2.country_name_fr as account_f_country_name,
        co3.country_alpha as country_alpha,
        om.order_mode_name
        FROM account a
        LEFT JOIN account_group ag ON ag.group_id = a.group_id 	
        LEFT JOIN account_type t ON t.type_id = a.type_id
        LEFT JOIN account_provider ap ON ap.provider_id = a.provider_id 	
        LEFT JOIN user u ON u.user_id = a.user_id
        LEFT JOIN user u2 ON u2.user_id = a.owner_id
        LEFT JOIN settings_sector s ON s.sector_id = a.sector_id
        LEFT JOIN settings_size sz ON sz.size_id = a.size_id
        LEFT JOIN settings_tva tva ON tva.tva_id = a.tva_id
        LEFT JOIN settings_delay delay ON delay.delay_id = a.delay_id
        LEFT JOIN order_mode om ON om.order_mode_id = a.order_mode_id

        LEFT JOIN settings_country co1 ON co1.country_id = a.account_country
        LEFT JOIN settings_country co2 ON co2.country_id = a.account_f_country
        LEFT JOIN settings_country co3 ON co3.country_id = ag.country_id

        WHERE a.type_id <> 4
            
            <cfif isdefined("a_id") AND a_id neq "ALL">
            AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
            </cfif>

            <cfif isdefined("manager_id") AND manager_id neq "ALL">
            AND a.user_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#manager_id#">)
            </cfif>
            
            <cfif isdefined("t_id") AND t_id neq "ALL">
            AND a.type_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#t_id#">)
            </cfif>
            
            <cfif isdefined("pv_id") AND pv_id neq "ALL">
            AND a.provider_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#pv_id#">)
            </cfif>

            <cfif isdefined("st_id") AND st_id neq "ALL">
            AND a.status_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#st_id#">)
            </cfif>

            <cfif o_by eq "manager">
            ORDER BY u.user_firstname, ag.group_name, a.account_name
            <cfelseif o_by eq "account_name">
            ORDER BY a.account_name
            </cfif>


        </cfquery>

      <cfreturn get_account>


    </cffunction>





    <cffunction name="get_tva" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="p_id" type="any" required="yes">

        <cfquery name="get_tva" datasource="#SESSION.BDDSOURCE#">
        SELECT `provider_tva` FROM `account_provider` WHERE `provider_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        </cfquery>

        <cfprocessingdirective suppresswhitespace="yes">
        <cfset result = SerializeJSON(get_tva, "struct")>
        </cfprocessingdirective>

        <cfreturn result>

    </cffunction>




    <cffunction name="get_contact" access="remote" returntype="query">
        <cfargument name="a_id" type="any" required="yes">
        <cfargument name="contact_lead" type="any" required="no">

        <cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
        SELECT ac.*, sf.function_name 
        FROM account_contact ac 
        INNER JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id
        LEFT JOIN settings_function sf ON sf.function_id = ac.function_id
        WHERE acc.a_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
        <cfif isdefined("contact_lead")>
        AND contact_lead = 1
        </cfif>
        ORDER BY ac.contact_lead DESC, ac.contact_name ASC
        </cfquery>

        <cfreturn get_contact>



    </cffunction>


    <cffunction name="get_user_account" access="remote" returntype="query">
        <cfargument name="a_id" type="any" required="yes">
        <cfargument name="pf_id" type="any" required="yes">

        <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
        SELECT u.user_id, u.user_firstname, u.user_name, u.user_email, u.user_password, u.user_status_id, up.profile_name, up.profile_id, us.user_status_css, us.user_status_name_fr
        FROM user u 
        INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id 
        INNER JOIN user_profile up ON up.profile_id = upc.profile_id 
        INNER JOIN user_status us ON us.user_status_id = u.user_status_id 
        WHERE FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,u.user_account_right_id) 
        AND upc.profile_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#pf_id#">)
        </cfquery>

        <cfreturn get_user>

    </cffunction>


</cfcomponent>