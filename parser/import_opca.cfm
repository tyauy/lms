<cfif isdefined("a_id")>

	<cfquery name="create_acc" datasource="#SESSION.BDDSOURCE#">
	UPDATE account SET
	account_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_name#">,
	account_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	account_address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	account_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	account_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad4#">,

	account_f_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_name#">,
	account_f_referrer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad5#">,
	account_f_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	account_f_address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	account_f_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	account_f_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad4#">,

	account_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_tel#">,
	account_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mid(a_email,1,70)#">
	WHERE account_id = #a_id#
	</cfquery>
	
	
	<cfoutput>
	OPCA #a_name# mis a jour avec l'identifant #a_id#
	</cfoutput>

<cfelse>

	<cfquery name="create_acc" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO account
	(
	user_id,
	type_id,
	group_id,

	account_name,
	account_address,
	account_address2,
	account_postal,
	account_city,
	account_country,

	account_f_name,
	account_f_referrer,
	account_f_address,
	account_f_address2,
	account_f_postal,
	account_f_city,
	account_f_country,

	account_date,
	account_details_1,
	account_details_2,
	account_tva_num,
	account_site,
	account_provenance,
	account_terms,
	account_phone,
	account_email
	)
	VALUES
	(
	176,
	4,
	0,

	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad4#">,
	75,

	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad5#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad4#">,
	75,

	now(),
	"",
	"",
	"",
	"",
	"",
	"",
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_tel#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#mid(a_email,1,70)#">
	)
	</cfquery>

	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(account_id) as id FROM account 
	</cfquery>
	
	<cfoutput>
	OPCA #a_name# ins&eacute;r&eacute; avec l'identifant #get_max.id#
	</cfoutput>

</cfif>