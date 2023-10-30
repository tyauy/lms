<!--- <cfif u_id eq "WEFIT FRANCE">
	<cfset u_id = "1">
<cfelseif u_id eq "NINA">
	<cfset u_id = "502">
<cfelseif u_id eq "MYRIAM">
	<cfset u_id = "2847">
<cfelseif u_id eq "VG">
	<cfset u_id = "69">
<cfelseif u_id eq "YANN">
	<cfset u_id = "4809">
<cfelseif u_id eq "RC">
	<cfset u_id = "6333">
<cfelseif u_id eq "CB">
	<cfset u_id = "7867">
<cfelseif u_id eq "UF">
	<cfset u_id = "7871">
</cfif> --->

<!--- <cfif country_id eq "WEFIT GROUP">
	<cfset country_id = "75">
	<cfset provider_id = "1">
<cfelseif country_id eq "WEFIT GERMANY">
	<cfset country_id = "84">
	<cfset provider_id = "2">
<cfelseif country_id eq "WEFIT FRANCE">
	<cfset country_id = "75">
	<cfset provider_id = "3">
</cfif> --->

<!--- <cfif group_type eq "HUNTING">
	<cfset group_type_id = "1">
<cfelseif group_type eq "FARMING">
	<cfset group_type_id = "2">
<cfelseif group_type eq "MARKETING">
	<cfset group_type_id = "3">
<cfelseif group_type eq "DO NOT CONTACT">
	<cfset group_type_id = "5">
<cfelseif group_type eq "ZZZ">
	<cfset group_type_id = "6">
<cfelseif group_type eq "PARTNERS">
	<cfset group_type_id = "7">
<cfelseif group_type eq "FARMING KEY">
	<cfset group_type_id = "8">
</cfif> --->

<cfif isdefined("group_id")>
		
	<cfquery name="create_gp" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_group
	SET 
	group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#group_name#">,
	group_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#group_type#">
	<!--- group_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_type_id#">,--->
	<!--- country_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#country_id#">,--->
	<!--- manager_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,--->
	<!--- provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">--->
	WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
	</cfquery>

	<cfoutput>
	Groupe #group_name# mis &agrave; jour, avec le group_id #group_id#
	</cfoutput>
	
<cfelse>

	<cfquery name="check_gp" datasource="#SESSION.BDDSOURCE#">
	SELECT group_id FROM account_group WHERE group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#group_name#">
	</cfquery>
	
	<cfif check_gp.recordcount eq "0">
	
		<cfquery name="create_gp" datasource="#SESSION.BDDSOURCE#" result="new_gp">
		INSERT INTO account_group
		(
		group_name,
		group_type
		<!--- group_type_id, --->
		<!--- country_id,--->
		<!--- manager_id--->
		<!--- provider_id--->
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#group_name#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#group_type#">
		<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#group_type_id#">,--->
		<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#country_id#">,--->
		<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">--->
		<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">--->
		)
		</cfquery>

		<cfquery name="create_hash" datasource="#SESSION.BDDSOURCE#">
			UPDATE account_group
			SET 
			group_hash = LOWER(HEX(group_id * floor(RAND() * 1000 + 100)))
			WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_gp.generatedkey#">
		</cfquery>
		
		<!--- UPDATE account_group SET group_hash = LOWER(HEX(group_id * floor(RAND() * 1000 + 100))) WHERE group_hash IS NULL --->
		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(group_id) as id FROM account_group
		</cfquery> --->

		<cfoutput>
		Groupe #group_name# ajout&eacute;. Nouvel ID === #new_gp.generatedkey#
		</cfoutput>
		
	<cfelse>
		<cfoutput>
		Un group existe d&eacute;j&agrave; avec le nom #group_name# et l'ID #check_gp.group_id#
		</cfoutput>
	
	</cfif>
	

</cfif>

