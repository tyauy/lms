<cfdirectory directory="#SESSION.BO_ROOT#/assets/scorm" name="dir_el" action="LIST"></cfdirectory>


<cfloop query="dir_el"> 

<cfquery name="check_el" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_elearning_module WHERE elearning_module_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dir_el.name#">
</cfquery>

<cfif check_el.recordcount neq "0">
    <cfoutput>#dir_el.name#</cfoutput> exists<br>
<cfelse>
    <cfoutput>#dir_el.name#</cfoutput> dont exist<br>

    <cfif findnocase("_",dir_el.name)>
        <cfset sm_id = mid(dir_el.name,1,findnocase("_",dir_el.name)-1)>
    <cfelse>
        <cfset sm_id = dir_el.name>
    </cfif>

    sm_id = <cfoutput>#sm_id#</cfoutput><br><br>

<cfquery name="ins_el" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_elearning_module
(
elearning_module_path,
sessionmaster_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dir_el.name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#sm_id#">
)
</cfquery>

<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT max(elearning_module_id) as id FROM lms_elearning_module
</cfquery>


<cfquery name="ins_elgp" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_elearning_module_cor
    (
    elearning_module_id,
    elearning_module_group_id
    )
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_max.id#">,
    0
    )
    </cfquery>



</cfif>
</cfloop>