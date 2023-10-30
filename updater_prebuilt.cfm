<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
<cfset session_duration = get_tp.session_duration/60>

<cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpmaster2
(
tpmaster_name,
tpmaster_hour,
tpmaster_prebuilt,
formation_id,
tpmaster_level,
tpmaster_biglevel,
tpmaster_name_fr,
tpmaster_name_en,
tpmaster_name_de,
tpmaster_name_es
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name_fr#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session_duration#">,
1,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_level#">,
<cfif findnocase("A",tpmaster_level)>"A"<cfelseif findnocase("B",tpmaster_level)>"B"<cfelseif findnocase("C",tpmaster_level)>"C"</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name_fr#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name_en#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name_de#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name_es#">
)
</cfquery>

<cfquery name="get_max_tp" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(tpmaster_id) as id FROM lms_tpmaster2
</cfquery>

<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#")>


<cfset counter = 0>


<cfoutput query="get_session">

<cfset counter++>

<!--- <cfquery name="ins_sessionmaster" datasource="#SESSION.BDDSOURCE#"> --->
<!--- INSERT INTO lms_tpsessionmaster2 --->
<!--- ( --->
<!--- sessionmaster_name, --->
<!--- sessionmaster_cat_id, --->
<!--- session_close, --->
<!--- method_id, --->
<!--- cat_id --->
<!--- ) --->
<!--- VALUES --->
<!--- ( --->
<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">, --->
<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#session_master_id#">, --->
<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#session_duration#">, --->
<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#session_rank#">, --->
<!--- 0, --->
<!--- 1, --->
<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#session_cat#"> --->
<!--- ) --->
<!--- </cfquery> --->


<!--- <cfquery name="get_max_session" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT MAX(sessionmaster_id) as id FROM lms_tpsessionmaster2 --->
<!--- </cfquery> --->

<cfquery name="ins_tpmastercor" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpmastercor2
(
sessionmaster_id,
sessionmaster_rank,
sessionmaster_schedule_duration,
tpmaster_id,
mapping_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#counter#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session_duration#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_tp.id#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_id#">
)
</cfquery>



<cflocation addtoken="no" url="common_tp_details2.cfm?t_id=#t_id#&u_id=7767">











</cfoutput>