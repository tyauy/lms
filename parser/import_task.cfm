<cfdump var="#URL#">

<cfset list_profile = "">
<cfif task_visible_cs neq "">
    <cfset list_profile = listappend(list_profile,"5")>
</cfif>
<cfif task_visible_tm neq "">
    <cfset list_profile = listappend(list_profile,"8")>
</cfif>
<cfif task_visible_t neq "">
    <cfset list_profile = listappend(list_profile,"4")>
</cfif>
<cfif task_visible_sales neq "">
    <cfset list_profile = listappend(list_profile,"2")>
</cfif>
<cfif task_visible_finance neq "">
    <cfset list_profile = listappend(list_profile,"6")>
</cfif>

<cfif task_type_id eq "">
<!---------------INSERT ------------------>

<cfquery name="get_info" datasource="#SESSION.BDDSOURCE#">
SELECT task_group_rank, task_color FROM task_type WHERE task_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#">
</cfquery>

<cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
INSERT INTO task_type
(
task_type_name,
task_group,
task_group_alias,
task_group_sub,
task_group_rank,
task_color,
task_automation,
task_category,
profile_id,
task_online,
task_explanation_fr,
task_explanation_en,
task_explanation_de,
task_explanation_es
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_type_name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_alias#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_sub#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_info.task_group_rank#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_info.task_color#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_automation#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_category#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#list_profile#">,
1,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_fr#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_en#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_de#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_es#">
)
</cfquery>

<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(task_type_id) as id FROM task_type
</cfquery>



La task a été créé avec l'ID <cfoutput>#get_max.id#</cfoutput>


<cfelse>



<!---------------UPDATE ------------------>
<cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
UPDATE task_type
SET
task_type_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_type_name#">,
task_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#">,
task_group_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_alias#">,
task_group_sub = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_sub#">,
task_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_category#">,
profile_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#list_profile#">,
task_explanation_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_fr#">,
task_explanation_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_en#">,
task_explanation_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_de#">,
task_explanation_es = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_es#">,
task_automation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_automation#">
WHERE task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#">
</cfquery>
  

</cfif>
