<cfprocessingdirective pageencoding="utf-8" suppressWhiteSpace="true">

<head>
<style>
body{
font-family:Arial;
}
</style>
</head>

<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/pack_edof.csv" variable="vartemp" charset="utf-8">
	
<cfset counter = 0>
	
<cfset vartemp = replacenocase(vartemp,";;"," ; ; ","ALL")>
<cfset vartemp = replacenocase(vartemp,";;"," ; ; ","ALL")>
<cfset vartemp = replacenocase(vartemp,";;"," ; ; ","ALL")>
	
<cfoutput>		
<cfloop list="#vartemp#" index="encours" delimiters="#chr(10)#">
<cfset counter++>

<!--- <cfif counter lte 10> --->
<cfset PACK_ACTIVE = listgetat(encours,1,';')>
<cfset STATUS = listgetat(encours,2,';')>
<cfset PACK_ID = listgetat(encours,3,';')>
<cfset FORMATION_ID = listgetat(encours,4,';')>
<cfset CERTIF_ID = listgetat(encours,5,';')>
<cfset PACK_NAME = listgetat(encours,6,';')>
<cfset PACK_HOUR = listgetat(encours,7,';')>
<cfset PACK_DURATION = listgetat(encours,8,';')>
<cfset PACK_OBJECTIVES = listgetat(encours,9,';')>
<cfset PACK_RESULTS = listgetat(encours,10,';')>
<cfset PACK_CONTENT = listgetat(encours,11,';')>
<cfset PACK_CERTIF = listgetat(encours,12,';')>
<cfset PACK_AMOUNT_HT = listgetat(encours,13,';')>
<cfset PACK_AMOUNT_TTC = listgetat(encours,14,';')>
<cfset METHOD_ID = listgetat(encours,15,';')>
<cfset DESTINATION_ID = listgetat(encours,16,';')>
<cfset PACK_MODALITES = listgetat(encours,17,';')>
<cfset PACK_KEYS = listgetat(encours,18,';')>
<cfset PACK_CERTIF_INFO = listgetat(encours,19,';')>
<cfset ELEARNING_ID = listgetat(encours,20,';')>
<cfset FROM_ID = listgetat(encours,21,';')>
<cfset PROVIDER_ID = listgetat(encours,22,';')>


-----------------------------------------------------
<br>


formation_id = #formation_id#<br>
certif_id = #certif_id#<br>
pack_name = #pack_name#<br>
pack_hour = #pack_hour#<br>
pack_duration = #pack_duration#<br>
pack_objectives = #pack_objectives#<br>
pack_results = #pack_results#<br>
pack_content = #pack_content#<br>
pack_certif = #pack_certif#<br>
pack_amount_ht = #pack_amount_ht#<br>
pack_amount_ttc = #pack_amount_ttc#<br>
method_id = #method_id#<br>
destination_id = #destination_id#<br>
pack_modalites = #pack_modalites#<br>
pack_keys = #pack_keys#<br>
pack_certif_info = #pack_certif_info#<br>
elearning_id = #elearning_id#<br>
provider_id = #provider_id#<br><br><br>



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
pack_certif,
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
<cfif pack_duration neq " ">#pack_duration#<cfelse>null</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_objectives#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_results#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_content#">,
#pack_certif#,
#pack_amount_ht#,
#pack_amount_ttc#,
'#method_id#',
<cfif destination_id neq " ">#destination_id#<cfelse>null</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_modalites#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_keys#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_certif_info#">,
<cfif elearning_id neq " ">#elearning_id#<cfelse>null</cfif>,
#provider_id#,
1
)
</cfquery>




</cfloop>

</cfoutput>


</cfprocessingdirective>

