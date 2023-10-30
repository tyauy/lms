<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">

<cfif u_id eq "WEFIT FRANCE">
	<cfset u_id = "1">
<cfelseif u_id eq "NINA">
	<cfset u_id = "502">
<cfelseif u_id eq "MYRIAM">
	<cfset u_id = "2847">
<cfelseif u_id eq "VG">
	<cfset u_id = "69">
<cfelseif u_id eq "RC">
	<cfset u_id = "6333">
<cfelseif u_id eq "CB">
	<cfset u_id = "7867">
<cfelseif u_id eq "ARNAUD">
	<cfset u_id = "16908">
<cfelseif u_id eq "ADEL">
	<cfset u_id = "25836">
<cfelseif u_id eq "MIRZA">
	<cfset u_id = "14714">
<cfelseif u_id eq "NORA">
	<cfset u_id = "28698">
</cfif>


<cfif owner_id eq "WEFIT FRANCE">
	<cfset owner_id = "1">
<cfelseif owner_id eq "NINA">
	<cfset owner_id = "502">
<cfelseif owner_id eq "MYRIAM">
	<cfset owner_id = "2847">
<cfelseif owner_id eq "VG">
	<cfset owner_id = "69">
<cfelseif owner_id eq "RC">
	<cfset owner_id = "6333">
<cfelseif owner_id eq "CB">
	<cfset owner_id = "7867">
<cfelseif owner_id eq "ARNAUD">
	<cfset owner_id = "16908">
<cfelseif owner_id eq "ADEL">
	<cfset owner_id = "25836">
<cfelseif owner_id eq "MIRZA">
	<cfset owner_id = "14714">
<cfelseif owner_id eq "NORA">
	<cfset owner_id = "28698">
</cfif>


<cfif a_type eq "HUNTING">
	<cfset type_id = "1">
<cfelseif a_type eq "FARMING">
	<cfset type_id = "2">
<cfelseif a_type eq "MARKETING">
	<cfset type_id = "3">
<cfelseif a_type eq "DO NOT CONTACT">
	<cfset type_id = "5">
<cfelseif a_type eq "ZZZ">
	<cfset type_id = "6">
<cfelseif a_type eq "PARTNERS">
	<cfset type_id = "7">
<cfelseif a_type eq "FARMING KEY">
	<cfset type_id = "8">
<cfelseif a_type eq "SCHOOL">
	<cfset type_id = "9">
</cfif>

<cfif provider_id eq "WEFIT GROUP">
	<cfset provider_id = "1">
<cfelseif provider_id eq "WEFIT GERMANY">
	<cfset provider_id = "2">
<cfelseif provider_id eq "WEFIT FRANCE">
	<cfset provider_id = "3">
</cfif>

	<cfoutput>user_id = #u_id#,</cfoutput>
	<cfoutput>owner_id = #owner_id#,</cfoutput>
	<cfoutput>provider_id = #provider_id#,</cfoutput>
	<cfoutput>type_id = #type_id#,</cfoutput>

<cfif isdefined("a_id")>
	
	<!--- <cfif g_status eq "ZZZ/INACTIVE"> --->
		<!--- <cfset status_id = "4"> --->
	<!--- <cfelse> --->
		<!--- <cfset status_id = "3"> --->
	<!--- </cfif> --->

	<cfquery name="updt_acc" datasource="#SESSION.BDDSOURCE#">
	UPDATE account
	SET
	user_id = #u_id#,
	type_id = #type_id#,
	provider_id= #provider_id#,
	owner_id = #owner_id#,
	<!--- status_id = #status_id#, --->
	group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">,
	account_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_name#">,
	account_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	account_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	account_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	account_country = 75,
	account_f_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad1#">,
	account_f_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad2#">,
	account_f_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad3#">,
	account_f_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad4#">,
	account_f_country = 75,
	account_date = now(),
	vtiger_id = <cfif isdefined("vtiger_id") AND vtiger_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#vtiger_id#"><cfelse>null</cfif>
	WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
	</cfquery>

	<cfoutput>
	Compte #a_name# mis &agrave; jour avec l'id #a_id# !
	</cfoutput>


	<cfif tm_1 neq "" OR tm_2 neq "">

		<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
		SELECT account_id, contact_id, contact_name FROM account_contact 
		WHERE (1 = 2
		<cfif tm_1 neq "">OR contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tm_1#"></cfif>
		<cfif tm_2 neq "">OR contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tm_2#"></cfif>
		)
		</cfquery>

		<cfif get_ctc.recordcount neq "0">
			<cfset newlist = get_ctc.account_id>
			
			<cfloop query="get_ctc">
				<cfif not listfind(newlist,a_id)>
				<cfset newlist = ListAppend(newlist,a_id)>
				</cfif>
				
				<cfoutput><br>TM #get_ctc.contact_id# Rattach&eacute; au compte (#get_ctc.contact_name#) </cfoutput>
				
				<cfquery name="updt_ctc" datasource="#SESSION.BDDSOURCE#">
				UPDATE account_contact SET account_id = '#newlist#' WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_id#">
				</cfquery>

				<cfquery name="del_contact" datasource="#SESSION.BDDSOURCE#">
					DELETE FROM account_contact_cor 
					WHERE ctc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_ctc.contact_id#"> 
				</cfquery>

				<cfif isdefined("newlist")>

					<cfloop list="#newlist#" index="acc">
						<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
							INSERT INTO account_contact_cor
							(
							a_id,
							ctc_id
							)
							VALUES
							(
							<cfqueryparam cfsqltype="cf_sql_integer" value="#acc#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#get_ctc.contact_id#">
							)
						</cfquery>
					</cfloop>

				</cfif>
				
			</cfloop>
			
			
			
		</cfif>
		
		<!---	<cfquery name="get_cor" datasource="#SESSION.BDDSOURCE#">
			SELECT account_id FROM account_contact WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_id#"> AND a_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
			</cfquery>
			
		
		<cfquery name="get_cor" datasource="#SESSION.BDDSOURCE#">
		SELECT ctc_id, a_id FROM account_contact_cor WHERE ctc_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_id#"> AND a_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
		</cfquery>
			
			<cfif get_cor.recordcount eq "0">
				<cfquery name="updt_ctc" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO account_contact_cor
				(
				ctc_id,
				a_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_ctc.contact_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
				)
				</cfquery>
				
				<cfoutput>TM Rattach&eacute; = #get_ctc.contact_name#</cfoutput>
			
			<cfelse>
			
				<cfoutput>TM d&eacute;j&agrave; existant = #get_ctc.contact_name#</cfoutput>
			
			</cfif>
			
			--->



	</cfif>


<cfelse>

	<!--- <cfif g_status eq "DEAD/INACTIVE"> --->
		<!--- <cfset status_id = "4"> --->
	<!--- <cfelse> --->
		<!--- <cfset status_id = "3"> --->
	<!--- </cfif> --->


	<cfquery name="create_acc" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO account
	(
	user_id,
	type_id,
	provider_id,
	owner_id,

	<!--- status_id, --->
	group_id,
	account_name,
	account_address,
	account_address2,
	account_postal,
	account_city,
	account_country,
	account_f_name,
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
	account_phone,
	account_provenance,
	account_terms,
	account_average_price,
	account_email,
	vtiger_id
	)
	VALUES
	(
	#u_id#,
	#type_id#,
	#provider_id#,
	#owner_id#,
	<!--- #status_id#, --->
	<cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad1#">,
	"",
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad2#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_ad3#">,
	75,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad1#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad2#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad3#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad4#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#f_ad5#">,
	75,
	now(),
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	0,
	"",
	<cfif isdefined("vtiger_id") AND vtiger_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#vtiger_id#"><cfelse>null</cfif>
	)
	</cfquery>

	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(account_id) as id FROM account
	</cfquery>


	<cfif tm_1 neq "">

	<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_id, contact_name FROM account_contact WHERE contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tm_1#">
	</cfquery>

	<cfif get_ctc.recordcount neq "0">
		<cftry>

			<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO account_contact_cor
				(
				a_id,
				ctc_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_ctc.contact_id#">
				)
			</cfquery>

			<cfcatch>
				account_contact_cor already filled in
			</cfcatch>
		</cftry>

	<cfoutput>TM Rattach&eacute; = #get_ctc.contact_name#</cfoutput>
	</cfif>


	</cfif>

	<cfif tm_2 neq "">

	<cfquery name="get_ctc2" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_id, contact_name FROM account_contact WHERE contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tm_2#">
	</cfquery>

	<cfif get_ctc2.recordcount neq "0">

		<cftry>

			<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO account_contact_cor
				(
				a_id,
				ctc_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_ctc2.contact_id#">
				)
			</cfquery>
				
			<cfcatch>
				account_contact_cor already filled in
			</cfcatch>
		</cftry>

	<cfoutput>TM Rattach&eacute; = #get_ctc2.contact_name#</cfoutput>
	</cfif>

	</cfif>


	<cfoutput>
	Compte #a_name# ajout&eacute; === #get_max.id#
	</cfoutput>

</cfif>

</cfprocessingdirective>