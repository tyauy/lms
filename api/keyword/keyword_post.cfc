<cfcomponent>
    
    <cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
    <cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
    <cfset obj_dater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.dater")>
           
    <cffunction name="insert_kw" access="remote" httpMethod="post" returntype="any" returnformat="plain">

        <cfargument name="kw_name" required="yes">
        <cfargument name="sm_id" required="yes">

        <cfquery name="check_kw" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM lms_keyword2 
        WHERE keyword_name_fr LIKE '%#kw_name#%'
        OR keyword_name_en LIKE '%#kw_name#%'
        OR keyword_name_de LIKE '%#kw_name#%'
        OR keyword_name_es LIKE '%#kw_name#%'
        OR keyword_name_it LIKE '%#kw_name#%'
        </cfquery>

        <cfif check_kw.recordcount neq "0">
            <cfset kw_id = check_kw.keyword_id>
        <cfelse>
            <cfquery name="ins_kw" datasource="#SESSION.BDDSOURCE#" result="inserted_kw">
            INSERT INTO lms_keyword2
            (
            keyword_cat_id,
            keyword_name_en,
            is_active,
            parent_id
            )
            VALUES
            (
            3,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#kw_name#">,
            0,
            null
            )
            </cfquery>

            <cfset kw_id = inserted_kw.generatedkey>

        </cfif>

        <cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO lms_sessionmaster_keywordid_cor
        (
        sessionmaster_id,
        keyword_id
        )
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#kw_id#">
        )
        </cfquery>

        <cfreturn "ok">

    </cffunction>
    
</cfcomponent>