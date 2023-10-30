<cfif isdefined("act") AND act eq "updt" AND isdefined("pack_id")>


<cfquery name="updt_formation" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_formation_pack
SET
formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,
pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">,
pack_hour = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_hour#">,
<cfif pack_duration neq "">pack_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_duration#">,</cfif>
pack_objectives = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_objectives#">,
pack_results = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_results#">,
pack_content = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_content#">,
pack_amount_ht = '#pack_amount_ht#',
pack_amount_ttc = '#pack_amount_ttc#',
<!--- tpmaster_id = <{tpmaster_id: }>, --->
<!--- pack_na = <{pack_na: }>, --->
<!--- pack_pta = <{pack_pta: }>, --->
<!--- pack_ol = <{pack_ol: }>, --->
<!--- pack_gp = <{pack_gp: }>, --->
<!--- pack_el = <{pack_el: }>, --->
<!--- pack_level = <{pack_level: }>, --->
method_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#method_id#">,
<!--- destination_id = <{destination_id: }>, --->
<!--- pack_f_ref = <{pack_f_ref: }>, --->
<!--- pack_af_ref = <{pack_af_ref: }>, --->
pack_active = <cfif pack_active eq "1">1<cfelse>0</cfif>,
pack_modalites = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_modalites#">,
pack_keys = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_keys#">,
pack_certif_info = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_certif_info#">
WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
</cfquery>

<cflocation addtoken="no" url="db_tppack_list.cfm?k=1">

<cfelseif isdefined("act") AND act eq "ins">

INSERT INTO LMS-1.lms_formation_pack
(pack_id,
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
tpmaster_id,
pack_na,
pack_pta,
pack_ol,
pack_gp,
pack_el,
pack_level,
method_id,
destination_id,
pack_f_ref,
pack_af_ref,
pack_new,
pack_modalites,
pack_examples,
pack_keys,
pack_certif_info)
VALUES
(<{pack_id: }>,
<{formation_id: }>,
<{certif_id: }>,
<{pack_name: }>,
<{pack_hour: }>,
<{pack_duration: }>,
<{pack_objectives: }>,
<{pack_results: }>,
<{pack_content: }>,
<{pack_amount_ht: }>,
<{pack_amount_ttc: }>,
<{tpmaster_id: }>,
<{pack_na: }>,
<{pack_pta: }>,
<{pack_ol: }>,
<{pack_gp: }>,
<{pack_el: }>,
<{pack_level: }>,
<{method_id: }>,
<{destination_id: }>,
<{pack_f_ref: }>,
<{pack_af_ref: }>,
<{pack_new: }>,
<{pack_modalites: }>,
<{pack_examples: }>,
<{pack_keys: }>,
<{pack_certif_info: }>);
</cfif>















<cfabort>






<cfquery name="get_formation" datasource="LMS-1-08012020">
SELECT * FROM lms_formation_pack
</cfquery>

<cfoutput query="get_formation">


<cfquery name="updt_formation" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_formation_pack
SET
formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,
pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">,
pack_hour = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_hour#">,
<cfif pack_duration neq "">pack_duration = '#pack_duration#',</cfif>
pack_objectives = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_objectives#">,
pack_results = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_results#">,
pack_content = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_content#">,
pack_amount_ht = '#pack_amount_ht#',
pack_amount_ttc = '#pack_amount_ttc#',
<!--- tpmaster_id = <{tpmaster_id: }>, --->
<!--- pack_na = <{pack_na: }>, --->
<!--- pack_pta = <{pack_pta: }>, --->
<!--- pack_ol = <{pack_ol: }>, --->
<!--- pack_gp = <{pack_gp: }>, --->
<!--- pack_el = <{pack_el: }>, --->
<!--- pack_level = <{pack_level: }>, --->
method_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#method_id#">,
<!--- destination_id = <{destination_id: }>, --->
<!--- pack_f_ref = <{pack_f_ref: }>, --->
<!--- pack_af_ref = <{pack_af_ref: }>, --->
pack_new = <cfif pack_new eq "1">#pack_new#<cfelse>null</cfif>,
pack_modalites = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_modalites#">,
pack_keys = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_keys#">,
pack_certif_info = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_certif_info#">
WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
</cfquery>


<br>
</cfoutput>


