<cfsilent><cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
SELECT u.*, c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha FROM user u
LEFT JOIN settings_country c ON c.country_id = u.country_id
WHERE profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4">

<cfif teaching_criteria_id neq "0" AND teaching_criteria_id neq "" AND teaching_criteria_id neq "null">
AND (1 = 2 
<cfloop list="#teaching_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,teaching_id)
</cfloop>
)
</cfif>

<cfif country_criteria_id neq "0" AND country_criteria_id neq "" AND country_criteria_id neq "null">
AND (1 = 2 
<cfloop list="#country_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,u.country_id)
</cfloop>
)
</cfif>

<cfif speaking_criteria_id neq "0" AND speaking_criteria_id neq "" AND speaking_criteria_id neq "null">
AND (1 = 2 
<cfloop list="#speaking_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,speaking_id)
</cfloop>
)
</cfif>

<cfif avail_criteria_id neq "0" AND avail_criteria_id neq "" AND avail_criteria_id neq "null">
AND (1 = 2 
<cfloop list="#avail_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,avail_id)
</cfloop>
)
</cfif>

<cfif speciality_criteria_id neq "0" AND speciality_criteria_id neq "" AND speciality_criteria_id neq "null">
AND (1 = 2 
<cfloop list="#speciality_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,speciality_id)
</cfloop>
)
</cfif>


<!---
<cfif method_criteria_id neq "0">
AND (1 = 2 
<cfloop list="#method_criteria_id#" index="cor">
OR FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,method_id)
</cfloop>
)
</cfif>--->

ORDER BY user_alias ASC
</cfquery>

</cfsilent><cfoutput>#get_trainer.recordcount#</cfoutput>
	