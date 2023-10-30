<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">
<cfif isdefined("c_id")>

	<cfquery name="check_tm" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_id FROM account_contact WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_id#">
	</cfquery>
	
	<cfif check_tm.recordcount neq "0">
	
		<cfquery name="create_tm" datasource="#SESSION.BDDSOURCE#">
		UPDATE account_contact
		SET
		contact_function = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_fct#">,
		contact_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_fname#">,
		contact_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(c_name)#">,
		contact_tel1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_tel1#">,
		contact_tel2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_tel2#">,
		contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(c_email)#">,
		contact_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_civ#">
		WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
		</cfquery>

		<cfoutput>
		TM #c_fname# #c_name# avec l'ID #c_id# mis a jour !
		</cfoutput>

	<cfelse>
	
		<cfoutput>
		Le TM #c_fname# #c_name# n'existe pas dans la BDD !
		</cfoutput>
		
	</cfif>
	
<cfelse>

	<cfquery name="check_tm" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_id FROM account_contact WHERE contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#c_email#">
	</cfquery>
	
	<cfif check_tm.recordcount eq "0">
	
		<cfquery name="create_tm" datasource="#SESSION.BDDSOURCE#" result="insert_ctc">
		INSERT INTO account_contact
		(
		account_id,
		contact_function,
		contact_firstname,
		contact_name,
		contact_tel1,
		contact_tel2,
		contact_email,
		contact_title,
		contact_lead,
		contact_invoice,
		contact_details
		)
		VALUES
		(
		0,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#c_fct#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#c_fname#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(c_name)#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#c_tel1#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#c_tel2#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(c_email)#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#c_civ#">,
		1,
		0,
		""
		)
		</cfquery>
		
		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(contact_id) AS id FROM account_contact
		</cfquery> --->

		<cfoutput>
		TM #c_fname# #c_name# ajout&eacute; avec l'ID #insert_ctc.generatedkey# !
		</cfoutput>

	<cfelse>
	
		<cfoutput>
		Le TM #c_fname# #c_name# existe d&eacute;j&agrave; avec l'ID #check_tm.contact_id# !
		</cfoutput>
		
	</cfif>
	
</cfif>



</cfprocessingdirective>
