<cfif isdefined("form.user_email_b2c") 
AND isdefined("form.user_name_b2c") 
AND isdefined("form.user_firstname_b2c") 
AND isdefined("form.user_phone_b2c")  
AND isdefined("form.situation_id_b2c") 
AND isdefined("form.user_search_b2c")
AND isdefined("form.user_cpf_b2c")
AND isdefined("form.user_message_b2c")
AND isdefined("form.contact_b2c")
AND isdefined("form.recaptcha_response_b2c")
>

<script async src="https://www.googletagmanager.com/gtag/js?id=AW-874808066"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'AW-874808066');
</script>

<!-- Event snippet for CANDIDATURE TRAINER conversion page -->
<script>
gtag('event', 'conversion', {'send_to': 'AW-874808066/cM12CJ7BwNICEIKGkqED'});
</script>

<cfhttp url="https://www.google.com/recaptcha/api/siteverify" result="response_b2c">
<cfhttpparam type="Formfield" name="secret" value="6Lfw5XEaAAAAAAEizqsoV2L0NUNUUtahm8LIvWPV"> 
<cfhttpparam type="Formfield" name="response" value="#recaptcha_response_b2c#">
</cfhttp>


<cfif isJSON(response_b2c.filecontent)>
	<cfset response_b2c = DeserializeJSON(response_b2c.filecontent)>

	<cfif structKeyExists(response_b2c,"success")>
	
	
		<cfif response_b2c.success eq "YES" AND response_b2c.score gte 0.5>
		
			<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
			SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_b2c#">
			</cfquery>

			<cfif check_user.recordcount eq "0">

			<cfset temp = RandRange(100000, 999999)>
			
			<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user
			(
			profile_id,
			account_id,
			user_status_id,
			user_type_id,
			user_firstname,
			user_name,
			user_email,
			user_password,
			user_pwd_chg,
			user_phone,
			user_create,
			user_lang,
			situation_id,
			user_ctc_cpf,
			user_ctc_formation
			)
			VALUES
			(
			10,
			<cfif situation_id_b2c eq "3">239<cfelse>47</cfif>,
			4,
			3,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname_b2c#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name_b2c)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email_b2c)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
			1,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_b2c#">,
			now(),
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_b2c#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_cpf_b2c#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_search_b2c#">
			)
			</cfquery>

			<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(user_id) as id FROM user
			</cfquery>

			<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
			UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
			</cfquery>

			<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_profile_cor
			(
			user_id,
			profile_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
			10
			)
			</cfquery>


			</cfif>
			
			<cfquery name="get_situation" datasource="#SESSION.BDDSOURCE#">
			SELECT situation_name_fr FROM user_situation WHERE situation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_b2c#">
			</cfquery>
	

			<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Contact Site B2C" type="html" server="localhost">
			<table>
				<tr>
					<td>Contact</td>
					<td>#user_firstname_b2c# #user_name_b2c#</td>
				</tr>
				<tr>
					<td>Situation</td>
					<td>#get_situation.situation_name_fr#</td>
				</tr>
				<tr>
					<td>Email</td>
					<td>#user_email_b2c#</td>
				</tr>
				<tr>
					<td>T&eacute;l&eacute;phone</td>
					<td>#user_phone_b2c#</td>
				</tr>
				<tr>
					<td>Objet</td>
					<td><cfif isdefined("user_wish_b2c")>#user_wish_b2c#<cfelse>NC</cfif></td>
				</tr>
				<tr>
					<td>Message</td>
					<td>#user_message_b2c#</td>
				</tr>
				<tr>
					<td>Dispose de droits</td>
					<td><cfif isdefined("user_cpf_b2c")>#user_cpf_b2c#<cfelse>NC</cfif></td>
				</tr>
				<tr>
					<td>Recherche d'une formation</td>
					<td><cfif isdefined("user_search_b2c")>#user_search_b2c#<cfelse>NC</cfif></td>
				</tr>
			</table>
			</cfmail>
			
			<cflocation addtoken="no" url="https://formation.wefitgroup.com/page_contact.cfm?k=1">
			
		<cfelse>
		
			<cflocation addtoken="no" url="https://formation.wefitgroup.com/page_contact.cfm?e=2">
		
		</cfif>
	
	</cfif>
</cfif>

</cfif>























<cfif isdefined("form.user_email_b2b") 
AND isdefined("form.user_name_b2b") 
AND isdefined("form.user_firstname_b2b") 
AND isdefined("form.user_phone_b2b")  
AND isdefined("form.user_company_b2b") 
<!--- AND isdefined("form.user_wish_b2b") --->
AND isdefined("form.user_message_b2b")
AND isdefined("form.contact_b2b")
AND isdefined("form.recaptcha_response_b2b")
>


<cfhttp url="https://www.google.com/recaptcha/api/siteverify" result="response_b2b">
<cfhttpparam type="Formfield" name="secret" value="6Lfw5XEaAAAAAAEizqsoV2L0NUNUUtahm8LIvWPV"> 
<cfhttpparam type="Formfield" name="response" value="#recaptcha_response_b2b#">
</cfhttp>


<cfif isJSON(response_b2b.filecontent)>
	<cfset response_b2b = DeserializeJSON(response_b2b.filecontent)>
	
	<cfif structKeyExists(response_b2b,"success")>
	
		<cfif response_b2b.success eq "YES" AND response_b2b.score gte 0.5>
		

			<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Contact Site PRO" type="html" server="localhost">
			<table>
				<tr>
					<td>Contact</td>
					<td>#user_firstname_b2b# #user_name_b2b#</td>
				</tr>
				<tr>
					<td>Société</td>
					<td>#user_company_b2b#</td>
				</tr>
				<tr>
					<td>Email</td>
					<td>#user_email_b2b#</td>
				</tr>
				<tr>
					<td>T&eacute;l&eacute;phone</td>
					<td>#user_phone_b2b#</td>
				</tr>
				<tr>
					<td>Objet</td>
					<td><cfif isdefined("user_wish_b2b")>#user_wish_b2b#<cfelse>NC</cfif></td>
				</tr>
				<tr>
					<td>Message</td>
					<td>#user_message_b2b#</td>
				</tr>
				<!--- <tr> --->
					<!--- <td>Dispose de droits</td> --->
					<!--- <td><cfif isdefined("user_cpf_b2b")>#user_cpf_b2b#<cfelse>NC</cfif></td> --->
				<!--- </tr> --->
				<!--- <tr> --->
					<!--- <td>Recherche d'une formation</td> --->
					<!--- <td><cfif isdefined("user_search_b2b")>#user_search_b2b#<cfelse>NC</cfif></td> --->
				<!--- </tr> --->
			</table>
			</cfmail>
			
			<cflocation addtoken="no" url="https://formation.wefitgroup.com/page_contact.cfm?k=1">
			
		<cfelse>
		
			<cflocation addtoken="no" url="https://formation.wefitgroup.com/page_contact.cfm?e=2">
		
		</cfif>
	
	</cfif>
</cfif>

</cfif>



















<cfif isdefined("form.user_email_demo") 
AND isdefined("form.user_password_demo") 
AND isdefined("form.user_name_demo") 
AND isdefined("form.user_firstname_demo") 
AND isdefined("form.user_phone_demo")
AND isdefined("form.situation_id_demo")
AND isdefined("form.user_cpf_demo")
AND isdefined("form.user_company_demo")
AND isdefined("form.user_search_demo")
AND isdefined("form.contact_demo")
AND isdefined("form.recaptcha_response_demo")
>



<cfhttp url="https://www.google.com/recaptcha/api/siteverify" result="response_demo">
<cfhttpparam type="Formfield" name="secret" value="6Lfw5XEaAAAAAAEizqsoV2L0NUNUUtahm8LIvWPV"> 
<cfhttpparam type="Formfield" name="response" value="#recaptcha_response_demo#">
</cfhttp>


<cfif isJSON(response_demo.filecontent)>
	<cfset response_demo = DeserializeJSON(response_demo.filecontent)>
	
	<cfif structKeyExists(response_demo,"success")>
	
		<cfif response_demo.success eq "YES" AND response_demo.score gte 0.5>
		
			<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
			SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email_demo#">
			</cfquery>

			<cfif check_user.recordcount eq "0">

				<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user
				(
				profile_id,
				account_id,
				user_status_id,
				user_type_id,
				user_firstname,
				user_name,
				user_email,
				user_password,
				user_pwd_chg,
				user_phone,
				user_create,
				user_lang,
				situation_id,
				user_ctc_cpf,
				user_ctc_formation
				)
				VALUES
				(
				7,
				<cfif situation_id_demo eq "3">239<cfelse>47</cfif>,
				4,
				3,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_name_demo)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email_demo)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_password_demo)#">,
				1,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_demo#">,
				now(),
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_cpf_demo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_search_demo#">
				)
				</cfquery>

				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				SELECT MAX(user_id) as id FROM user
				</cfquery>

				<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_profile_cor
				(
				user_id,
				profile_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				7
				)
				</cfquery>

				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
				UPDATE user SET user_md5 = '#hash(get_max.id)#' WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
				</cfquery>

				<cfquery name="get_situation" datasource="#SESSION.BDDSOURCE#">
				SELECT situation_name_fr FROM user_situation WHERE situation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#situation_id_demo#">
				</cfquery>
						
				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_tp
				(
				user_id,
				tp_status_id,
				formation_id,
				method_id,
				tp_date_start,
				tp_date_end,
				tp_rank,
				elearning_id,
				elearning_duration,
				tp_duration,
				order_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
				2,
				2,
				3,
				now(),
				#DateAdd("h",6,now())#,
				1,
				1,
				1,
				0,
				1
				)
				</cfquery>
				
				<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | Creation de compte GUEST B2C" type="html" server="localhost">
				<table>
					<tr>
						<td>Contact</td>
						<td>#user_firstname_demo# #user_name_demo#</td>
					</tr>
					<tr>
						<td>Situation</td>
						<td>#get_situation.situation_name_fr#</td>
					</tr>
					<tr>
						<td>Email</td>
						<td>#user_email_demo#</td>
					</tr>
					<tr>
						<td>T&eacute;l&eacute;phone</td>
						<td>#user_phone_demo#</td>
					</tr>
					<tr>
						<td>Société</td>
						<td>#user_company_demo#</td>
					</tr>
					<tr>
						<td>Dispose de droits</td>
						<td><cfif isdefined("user_cpf_demo")>#user_cpf_demo#<cfelse>NC</cfif></td>
					</tr>
					
					<tr>
						<td>Recherche d'une formation</td>
						<td><cfif isdefined("user_search_demo")>#user_search_demo#<cfelse>NC</cfif></td>
					</tr>
					
					
				</table>
				</cfmail>

				<cflocation addtoken="no" url="https://lms.wefitgroup.com?user_name=#user_email_demo#&upass=#hash(user_password_demo)#">
				
			<cfelse>
					
				<cfif findnocase("page_contact",CGI.HTTP_REFERER)>
				
					<cflocation addtoken="no" url="page_contact.cfm?e=1">
					
				<cfelseif findnocase("page_el",CGI.HTTP_REFERER)>
				
					<cflocation addtoken="no" url="page_el.cfm?e=1">
					
				</cfif>
			
			</cfif>

		<cfelse>
		
			<cfif findnocase("page_contact",CGI.HTTP_REFERER)>
				
				<cflocation addtoken="no" url="page_contact.cfm?e=2">
				
			<cfelseif findnocase("page_el",CGI.HTTP_REFERER)>
			
				<cflocation addtoken="no" url="page_el.cfm?e=2">
				
			</cfif>
		
		</cfif>
		
	</cfif>
</cfif>

</cfif>
























<cfif isdefined("form.user_firstname_cpf") 
AND isdefined("form.user_name_cpf") 
AND isdefined("form.user_email_cpf")  
AND isdefined("form.user_phone_cpf")
AND isdefined("form.contact_cpf")
AND isdefined("SESSION.GROUP_ID")
AND isdefined("SESSION.GROUP_NAME")
AND isdefined("SESSION.GROUP_PRICE_REDUCTION")
>

	<cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
	SELECT fc.pack_name, fc.pack_amount_ttc, ap.provider_siret
	FROM lms_formation_pack fc
	LEFT JOIN account_provider ap ON ap.provider_id = fc.provider_id
	WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>
	
	<cfset current_price = ((100-SESSION.GROUP_PRICE_REDUCTION)/100)*get_pack.pack_amount_ttc>
	
	<cfmail from="W-LMS <service@wefitgroup.com>" to="start@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT | CPF #SESSION.GROUP_NAME#" type="html" server="localhost">
	
	Lead from B2B catalog
	
	<table>
		<tr>
			<td>Contact</td>
			<td>#user_firstname_cpf# #user_name_cpf#</td>
		</tr>
		<tr>
			<td>Email</td>
			<td>#user_email_cpf#</td>
		</tr>
		<tr>
			<td>Phone</td>
			<td>#user_phone_cpf#</td>
		</tr>
		<tr>
			<td>Group</td>
			<td>#SESSION.GROUP_NAME#</td>
		</tr>
		<tr>
			<td>Pack</td>
			<td>#get_pack.pack_name#</td>
		</tr>
		<tr>
			<td>Amount TTC</td>
			<td>#get_pack.pack_amount_ttc# &euro;</td>
		</tr>
		<tr>
			<td>Discount group</td>
			<td>#SESSION.GROUP_PRICE_REDUCTION# %</td>
		</tr>
		<tr>
			<td>Final price to apply</td>
			<td>#current_price# &euro;</td>
		</tr>
		<tr>
			<td>Link</td>
			<td><a href="https://www.moncompteformation.gouv.fr/espace-prive/html/##/formation/recherche/#get_pack.provider_siret#_#pack_id#_FWF/#get_pack.provider_siret#_#pack_id#_AFWF">[link EDOF]</a></a></td>
		</tr>
	</table>
	</cfmail>

	<cflocation addtoken="no" url="https://www.moncompteformation.gouv.fr/espace-prive/html/##/formation/recherche/#get_pack.provider_siret#_#pack_id#_FWF/#get_pack.provider_siret#_#pack_id#_AFWF">
				


</cfif>










<!--- <cfoutput>

	#form.user_firstname_partner#
	#form.user_name_partner#
	#form.user_email_partner#
	#form.user_num_partner#
	#form.user_phone_partner#
	#form.user_service_partner#
	#form.contact_partner#
	#SESSION.GROUP_ID#
	#SESSION.GROUP_NAME#

</cfoutput> --->


<cfif isdefined("form.user_firstname_partner") 
AND isdefined("form.user_name_partner") 
AND isdefined("form.user_email_partner")  
AND isdefined("form.user_num_partner")
AND isdefined("form.user_phone_partner")
AND isdefined("form.user_service_partner")
AND isdefined("form.contact_partner")
AND isdefined("SESSION.GROUP_ID")
AND isdefined("SESSION.GROUP_NAME")
AND isdefined("form.url_back")
>



	<cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
	SELECT fc.pack_name, fc.pack_amount_ttc, ap.provider_siret, fc.pack_amount_ht
	FROM lms_formation_pack fc
	LEFT JOIN account_provider ap ON ap.provider_id = fc.provider_id
	WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>

	<cfquery name="get_tm" datasource="#SESSION.BDDSOURCE#">
	SELECT ac.contact_email
	FROM account_contact ac
	WHERE contact_active = 1
	AND account_id IN (SELECT account_id FROM account WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#">)
	</cfquery>
	
	<cfset list_cc = "">
	<cfoutput query="get_tm">
		<cfset list_cc = listappend(list_cc,contact_email)>
	</cfoutput>

	<cfoutput>#list_cc#</cfoutput>
	
	<!--- <cfset current_price = ((100-SESSION.GROUP_PRICE_REDUCTION)/100)*get_pack.pack_amount_ttc> --->
	
	<cfmail from="W-LMS <service@wefitgroup.com>" to="rremacle@wefitgroup.com,nmichel@wefitgroup.com" subject="Buchungsbestätigung WEFIT Sprachentraining | #SESSION.GROUP_NAME#" type="html" server="localhost">
		
		<cfinclude template="./email/email_partner_lead.cfm">
	
	</cfmail>

	<cflocation addtoken="no" url="#form.url_back#">
				


</cfif>