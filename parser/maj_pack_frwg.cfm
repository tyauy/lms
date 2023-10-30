<cfabort>

<cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM `LMS-1`.lms_formation_pack where provider_id = 3 AND pack_active = 1 AND pack_id < 2039 ORDER BY pack_id ASC
</cfquery>

<cfoutput query="get_pack">


<cfquery name="updt_pack" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_formation_pack
    (
    formation_id,
    certif_id,
    pack_name,
    pack_hour,
    pack_duration,
    pack_objectives,
    pack_results,
    pack_content,
    pack_amount_ht,
    pack_amount_ttc,
    method_id,
    destination_id,
    pack_modalites,
    pack_keys,
    pack_certif_info,
    elearning_id,
    provider_id,
    pack_active
    )
    VALUES
    (
    #formation_id#,
    #certif_id#,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">,
    #pack_hour#,
    <cfif pack_duration neq "">#pack_duration#<cfelse>null</cfif>,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_objectives#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_results#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_content#">,
    #pack_amount_ht#,
    #pack_amount_ttc#,
    '#method_id#',
    <cfif destination_id neq "">#destination_id#<cfelse>null</cfif>,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_modalites#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_keys#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_certif_info#">,
    <cfif elearning_id neq "">#elearning_id#<cfelse>null</cfif>,
    1,
    1
    )
    </cfquery>
    </cfoutput>