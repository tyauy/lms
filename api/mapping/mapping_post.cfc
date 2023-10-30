<cfcomponent>

    <cffunction name="updt_mapping" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="mapping_id" type="any" required="yes">
        <cfargument name="qu_id" type="any" required="yes">
        <cfargument name="main_mapping_id" type="numeric" required="no" default="0">
        <cfargument name="qu_advise" type="string" required="no" default="">


        <cfloop list="#mapping_id#" index="cor">
            <cfquery name="ins_mapping" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_quiz_question_mapping_cor
            (
                mapping_id,
                qu_id,
                is_main
            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
                <cfif cor eq main_mapping_id>1<cfelse>0</cfif>
            )
            </cfquery>
        </cfloop>

        <cfquery name="updt_qu" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_quiz_question
            SET 
            qu_updated_by = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
            qu_updated_date = now(),
            is_treated = 2,
            qu_advise_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_advise#">
            WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
        </cfquery>

        <cfreturn "ok">
    
    </cffunction>

    <cffunction name="rename_mapping" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="mapping_id" type="numeric" required="yes">
        <cfargument name="name" type="any" required="yes">

       

        <cfquery name="updt_name" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_mapping
            SET 
            MAPPING_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#name#">
        
            WHERE MAPPING_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
        </cfquery>

        <cfreturn "ok">
    
    </cffunction>
    <cffunction name="edit_trad" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="mapping_id" type="any" required="yes">
        <cfargument name="name" type="any" required="yes">
        <cfargument name="lang" type="any" required="yes">
        <cfquery name="rename_trad" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_mapping
            SET mapping_name_#lang# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#name#">
            Where mapping_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
        </cfquery>
    </cffunction>

    <cffunction name="change_desc" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="mapping_id" type="any" required="yes">
        <cfargument name="desc" type="any" required="yes">
        <cfargument name="lang" type="any" required="yes">
        <cfquery name="rename_task_desc" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_mapping
            SET description_#lang# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#desc#">
            Where mapping_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
        </cfquery>
    </cffunction>

    <cffunction name="updt_mapping_type" access="remote" httpMethod="post" returntype="any" returnformat="plain" output="true">
	
        <cfargument name="mp_id" type="numeric" required="yes">
        <cfargument name="mapping_explanation_long" type="any" required="yes">
        <cfargument name="lang" type="any" required="yes">
        

        <cfoutput>#mapping_explanation_long#</cfoutput>

        <cfquery name="updt_mapping" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_mapping 
        SET mapping_explanation_long_#lang# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_explanation_long#">
        WHERE mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mp_id#">
        </cfquery>

        <cfreturn mapping_explanation_long>
    </cffunction>

    
    <cffunction name="new_mapping" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="mapping_name" type="any" required="yes">
        <cfargument name="formation_id" type="any" required="yes">
        <cfargument name="level" type="any" required="yes">
        <cfargument name="mapping_category" type="any" required="yes">
        
        <cfquery name="new_mapping" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_mapping (mapping_name, formation_id, level, mapping_category)
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_name#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#level#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_category#">
            );
        </cfquery>
        <cfreturn mapping_name>
    </cffunction>
    

</cfcomponent>