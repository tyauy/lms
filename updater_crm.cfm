<!---------------------------- MANAGE ACCOUNT ------------------------>

<!---------------------------- INSERT ACCOUNT ------------------------>
<cfif isdefined("form") AND isdefined("ins_account") or isdefined("copy_account")>
<cfquery name="ins_account" datasource="#SESSION.BDDSOURCE#"  result="insert_ac">
INSERT INTO account
(
type_id,
provider_id,
group_id,
delay_id,
order_mode_id,
tva_id,
sector_id,
size_id,
user_id,
owner_id,
account_date,
account_name,
account_address,
account_postal,
account_city,
account_country,
account_f_name,
account_f_address,
account_f_postal,
account_f_city,
account_f_country,
account_details_1,
account_tva_num,
account_site,
account_phone
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#type_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#delay_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#order_mode_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#tva_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#sector_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#size_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#owner_id#">,
<cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_address#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_postal#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_city#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_country#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_address#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_postal#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_city#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_country#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_details_1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_tva_num#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_site#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#account_phone#">
)
</cfquery>
<cfquery name="get_account_id" datasource="#SESSION.BDDSOURCE#">
	SELECT LAST_INSERT_ID() AS account_id;
	</cfquery>
	
<cfset new_account_id = get_account_id.account_id>

<!---<cfdump var="#new_account_id#">
<cfdump var="#account_id#"> --->
<cfif isDefined("copy_account")> 
<cfquery name="get_a_contact" datasource="#SESSION.BDDSOURCE#" result="get_ctc">
	SELECT * FROM account_contact_cor where a_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
</cfquery>
<!---------------------------- INSERT ACCOUNT CONTACTS ------------------------>
<cfloop query="get_a_contact"> 
<cfquery name="ins_contact" datasource="#SESSION.BDDSOURCE#" result="insert_ctc">
	INSERT INTO account_contact_cor
	(
	a_id,
	ctc_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#new_account_id#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_a_contact.ctc_id#">
	)
	</cfquery></cfloop>
<cfdump var="#insert_ac.generatedkey#">
<cfquery name="get_tm" datasource="#SESSION.BDDSOURCE#" result="get_tm">
	SELECT * FROM user where find_in_set(#account_id#,user_account_right_id)
</cfquery>

<cfloop query="get_tm">
	<cfset new_account_right_id = get_tm.user_account_right_id & ",#new_account_id#">

	<cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_account_right_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_account_right_id#"> WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tm.user_id#">
	</cfquery>
</cfloop>
<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#insert_ac.generatedkey#&k=1">
</cfif>
<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT max(account_id) as id FROM account
</cfquery> --->
<!--- <cfset temp = obj_logger.ins_log(account_id=get_max.id,log_text="Compte cr&eacute;&eacute;")> --->
<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#insert_ac.generatedkey#&k=1">
</cfif>
<!---------------------------- UPDATE ACCOUNT ------------------------>

<cfif isdefined("form") AND isdefined("account_id") AND isdefined("updt_account") AND findnocase("crm_account_edit",CGI.HTTP_REFERER)>
<cfquery name="updt_account" datasource="#SESSION.BDDSOURCE#">
UPDATE account
SET
type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#type_id#">,
provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,
group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">,
delay_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#delay_id#">,
order_mode_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_mode_id#">,
tva_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tva_id#">,
sector_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sector_id#">,
size_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#size_id#">,
user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
owner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#owner_id#">,
account_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_name#">,
account_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_address#">,
account_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_postal#">,
account_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_city#">,
account_country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_country#">,
account_f_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_name#">,
account_f_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_address#">,
account_f_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_postal#">,
account_f_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_city#">,
account_f_country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_f_country#">,
account_details_1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_details_1#">,
account_tva_num = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_tva_num#">,
account_site = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_site#">,
<cfif isdefined("account_pt_mandatory")>account_pt_mandatory = 1,<cfelse>account_pt_mandatory = 0,</cfif>
account_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_phone#">
WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
</cfquery>
<!--- <cfset temp = obj_logger.ins_log(account_id=account_id,log_text="Compte modifi&eacute;")> --->
<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#account_id#">
</cfif>

<!---------------------------- DELETE ACCOUNT ------------------------>
<cfif isdefined("account_id") AND isdefined("del_account")>
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_name, group_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
</cfquery>
<cfset group_id = get_account.group_id>	
<!--- <cfset temp = obj_logger.ins_log(account_id=account_id,log_text="Compte #get_account.account_name# supprim&eacute;")> --->
<cfquery name="del_account" datasource="#SESSION.BDDSOURCE#">
DELETE FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
</cfquery>
<!--- Return a JSON response instead of using cflocation --->
<cfoutput>
	{
		"status": "success",
		"redirectURL": "crm_account_edit.cfm?g_id=#group_id#"
	}
</cfoutput>
</cfif>







<!-------------------------- GROUP UPDATE --------------------------->
<cfif isdefined("form") AND isdefined("updt_group") AND isdefined("group_id")>

	<cfquery name="updt_group" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_group SET
	group_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#group_name#">
	<!--- group_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_type_id#">,
	manager_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#manager_id#">--->
	WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
	</cfquery>

	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#">
</cfif>




<!-------------------------- GROUP UPDATE --------------------------->
<cfif isdefined("form") AND isdefined("ins_group")>

<cfquery name="ins_group" datasource="#SESSION.BDDSOURCE#" result="new_group">
INSERT INTO account_group 
(
	group_name
)
VALUES
(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#group_name#">
)
</cfquery>

<cfquery name="create_hash" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_group
	SET 
	group_hash = LOWER(HEX(group_id * floor(RAND() * 1000 + 100)))
	WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_group.generatedkey#">
</cfquery>

<cflocation addtoken="no" url="index.cfm?k=1">
</cfif>







<!-------------------------- GROUP PRICE --------------------------->
<cfif isdefined("form") AND isdefined("updt_group_price")>

<!--- <cfoutput> --->

<!--- #price_reduction#<br><br> --->
<!--- <cfloop index="cur_lg" from="1" to="#nb_languages#"> --->
<!--- #evaluate('price_#cur_lg#')#<br> --->
<!--- </cfloop> --->
<!--- </cfoutput> --->
<cfquery name="updt_group_price" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_group_price
	SET price_reduction = <cfqueryparam cfsqltype="cf_sql_decimal" value="#price_reduction#">
	<cfloop index="cur_lg" from="1" to="#nb_languages#">
	, price_#cur_lg# = <cfqueryparam cfsqltype="cf_sql_decimal" value="#evaluate('price_#cur_lg#')#">
	</cfloop>
	WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
</cfquery>

<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#updt_group_price#">
</cfif>



<!---------------------------- MANAGE CONTACT ------------------------>
<cfif isdefined("form") AND isdefined("a_id") AND isdefined("ins_contact")<!--- AND findnocase("crm_account_edit",CGI.HTTP_REFERER)--->>
<cfquery name="ins_contact" datasource="#SESSION.BDDSOURCE#" result="insert_ctc">
INSERT INTO account_contact
(
account_id,
contact_firstname,
contact_name,
contact_tel1,
contact_tel2,
contact_email,
contact_title,
contact_lead,
contact_invoice,
contact_details,
function_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_firstname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_email#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_title#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_lead#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_invoice#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_details#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#function_id#">
)
</cfquery>
<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT max(contact_id) as id FROM account_contact
</cfquery> --->
<!--- <cfset temp = obj_logger.ins_log(contact_id=get_max.id,log_text="Contact cr&eacute;&eacute;")> --->

<cfif a_id neq "">

	<cfloop list="#a_id#" index="acc">
		<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO account_contact_cor
			(
			a_id,
			ctc_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#acc#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_ctc.generatedkey#">
			)
		</cfquery>
	</cfloop>

</cfif>

<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#&c_id=#insert_ctc.generatedkey#">
</cfif>


<cfif isdefined("form") AND isdefined("a_id") AND isdefined("contact_id") AND isdefined("updt_contact")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET 
	contact_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_firstname#">,
	contact_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_name#">,
	contact_tel1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel1#">,
	contact_tel2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_tel2#">,
	contact_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_email#">,
	contact_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_title#">,
	contact_lead = <cfif contact_lead eq "1">1<cfelse>0</cfif>,
	contact_invoice = <cfif contact_invoice eq "1">1<cfelse>0</cfif>,
	contact_active = <cfif contact_active eq "1">1<cfelse>0</cfif>,
	contact_details = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_details#">,
	function_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#function_id#">
	<cfif isdefined("acor_id")>
	,account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#acor_id#">
	</cfif>
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<!--- <cfset temp = obj_logger.ins_log(contact_id=contact_id,log_text="Contact mis &agrave; jour")> --->

	<cfquery name="del_contact" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM account_contact_cor 
		WHERE ctc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#"> 
	</cfquery>

	<cfif isdefined("acor_id")>

		<cfloop list="#acor_id#" index="acc">
			<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO account_contact_cor
				(
				a_id,
				ctc_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#acc#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
				)
			</cfquery>
		</cfloop>
	
	</cfif>


	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#&c_id=#contact_id#">

</cfif>



<cfif isdefined("form") AND isdefined("a_id") AND isdefined("user_id") AND isdefined("contact_id") AND isdefined("updt_contact_tm")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE user
	SET 
	user_account_right_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_account_right_id#">,
	user_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfquery>

	<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">

</cfif>

<cfif isdefined("a_id") AND isdefined("user_id") AND isdefined("contact_id") AND isdefined("del_contact_tm")>

	<cfquery name="del_user" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#">
	
</cfif>


<cfif isdefined("a_id") AND isdefined("user_id") AND isdefined("contact_id") AND isdefined("send_contact_tm")>
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT user_gender, user_name, user_firstname, user_email, upc.profile_id, user_lang
	FROM user u
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON upc.profile_id = up.profile_id
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	GROUP BY u.user_id
	</cfquery>
	
	<cfset user_gender = get_user.user_gender>
	<cfset user_firstname = get_user.user_firstname>
	<cfset user_lastname = get_user.user_name>
	<cfset user_email = get_user.user_email>
	<cfset user_pwd = RandRange(100000, 999999)>
	<cfset profile_id = get_user.profile_id>
	<cfset user_lang = get_user.user_lang>

	<cfquery name="updt_pwd" datasource="#SESSION.BDDSOURCE#">
		UPDATE user
		SET user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfquery>
		
	<cfif user_lang eq "fr">
		<cfset subject = "WEFIT | Votre compte Training Manager">
	<cfelseif user_lang eq "en">
		<cfset subject = "WEFIT | Your Training Manager account">
	<cfelseif user_lang eq "de">
		<cfset subject = "WEFIT | Your Training Manager account">
	<cfelseif user_lang eq "es">
		<cfset subject = "WEFIT | Votre compte Training Manager">
	<cfelseif user_lang eq "it">
		<cfset subject = "WEFIT | Votre compte Training Manager">
	</cfif>	
	
	<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com,mkouhail@wefitgroup.com,nmichel@wefitgroup.com" subject="#subject#" type="html" server="localhost">
		<cfset lang = user_lang>
		<cfinclude template="./email/email_new_tm.cfm">
	</cfmail>
	
	<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
			
</cfif>
			

<cfif isdefined("form") AND isdefined("a_id") AND isdefined("contact_id") AND isdefined("ins_contact_tm")>

	<cfset temp = RandRange(100000, 999999)>
	
	<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM account_contact WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>
	
	<cfquery name="ins_tm" datasource="#SESSION.BDDSOURCE#"  result="insert_tm">
	INSERT INTO user
	(
	user_firstname,
	user_name,
	user_email,
	profile_id,
	user_create,
	user_status_id,
	user_password,
	user_pwd_chg,
	user_account_right_id,
	user_lang,
	contact_id
	)	
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_firstname#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_name#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_ctc.contact_email#">,
	8,
	now(),
	4,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
	0,
	<cfif isdefined("user_account_right_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_account_right_id#"><cfelse>null</cfif>,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	)	
	</cfquery>
				
	<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(user_id) as id FROM user
	</cfquery> --->

	<cfquery name="updt_ctc" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="=#insert_tm.generatedkey#">
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO user_profile_cor
	(
	user_id,
	profile_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tm.generatedkey#">,
	8
	)
	</cfquery>
			
			
	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#&c_id=#contact_id#">

</cfif>



<cfif isdefined("form") AND isdefined("a_id") AND isdefined("contact_id") AND isdefined("link_contact")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<cfquery name="del_contact" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM account_contact_cor 
		WHERE ctc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#"> 
	</cfquery>

	<cfif isdefined("a_id")>

		<cfloop list="#a_id#" index="acc">
			<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO account_contact_cor
				(
				a_id,
				ctc_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#acc#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
				)
			</cfquery>
		</cfloop>

	</cfif>

	<cflocation addtoken="no" url="cs_tms.cfm">

</cfif>



<cfif isdefined("contact_id") AND isdefined("account_id") AND isdefined("del_contact") AND findnocase("account_edit",CGI.HTTP_REFERER)>
	<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
	SELECT contact_firstname, contact_name FROM account_contact WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<cfset temp = obj_logger.ins_log(account_id=account_id,log_text="Contact #get_contact.contact_firstname# #get_contact.contact_name# supprim&eacute;")>

	<cfquery name="del_contact" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM account_contact WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<cfquery name="del_contact" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM account_contact_cor WHERE ctc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
	</cfquery>

	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#account_id#">
</cfif>


<cfif isdefined("ctc_id") AND isdefined("a_id") AND isdefined("inactive_contact")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET contact_active = 0
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ctc_id#">
	</cfquery>

	<cflocation addtoken="no" url="cs_tms.cfm">

</cfif>


<cfif isdefined("ctc_id") AND isdefined("a_id") AND isdefined("active_contact")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET contact_active = 1
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ctc_id#">
	</cfquery>

	<cflocation addtoken="no" url="cs_tms.cfm">

</cfif>



<cfif isdefined("ctc_id") AND isdefined("updt_optin")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET contact_optin = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_optin#">
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ctc_id#">
	</cfquery>

	<cflocation addtoken="no" url="cs_tms.cfm">

</cfif>


<cfif isdefined("ctc_id") AND isdefined("updt_issue")>

	<cfquery name="updt_contact" datasource="#SESSION.BDDSOURCE#">
	UPDATE account_contact
	SET contact_issue = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_issue#">
	WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ctc_id#">
	</cfquery>

	<cflocation addtoken="no" url="cs_tms.cfm">

</cfif>
















<!---------------------------- MANAGE OPPORT / TASK ------------------------>
<cfif isdefined("form") AND isdefined("account_id") AND (isdefined("ins_opport") OR isdefined("ins_task"))>


<cfif isdefined("ins_opport")>
	<cfif day(task_date_deadline) lte "12">
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-dd-mm')#">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-dd-mm')#">
	<cfelse>
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-mm-dd')#">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-mm-dd')#">
	</cfif>
<cfelse>
	<cfif day(task_date_deadline) lte "12">
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-dd-mm')# #task_date_start#:00">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-dd-mm')# #task_date_end#:00">
	<cfelse>
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-mm-dd')# #task_date_start#:00">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-mm-dd')# #task_date_end#:00">
	</cfif>
</cfif>

<cfif isdefined("task_alert")>
	<cfif day(task_date_remind) lte "12">
		<cfset task_date_remind = "#dateformat(task_date_remind,'yyyy-dd-mm')# 00:00:00">
	<cfelse>
		<cfset task_date_remind = "#dateformat(task_date_remind,'yyyy-mm-dd')# 00:00:00">
	</cfif>
</cfif>


<cfquery name="ins_opport" datasource="#SESSION.BDDSOURCE#"  result="insert_task">
INSERT INTO task
(
contact_id,
parent_id,
account_id,
user_id,
invoice_id,
task_type_id,
task_name,
task_date_creation,
task_alert,
task_date_remind,
task_date_close,
task_date_start,
task_date_end,
task_date_deadline,
<!---task_description,--->
task_amount,
task_probability
)
VALUES
(
<cfif isdefined("contact_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#"><cfelse>0</cfif>,
<cfif isdefined("parent_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#parent_id#"><cfelse>0</cfif>,
<cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
<cfif isdefined("invoice_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#"><cfelse>0</cfif>,
<cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#">,
<cfif isdefined("task_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_name#"><cfelse>null</cfif>,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
<cfif isdefined("task_alert")>
	1,
	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_remind#">,
<cfelse>
	0,
	null,
</cfif>
null,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_start#">,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_end#">,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_deadline#">,
<!---<cfqueryparam cfsqltype="cf_sql_varchar" value="#task_description#">,--->
<cfif isdefined("task_amount") AND task_amount neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_amount#"><cfelse>null</cfif>,
<cfif isdefined("task_probability")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_probability#"><cfelse>null</cfif>
)
</cfquery>

<!------ INSERTION COMMENTAIRES ------>
<cfif isdefined("log_text") AND log_text neq "">
<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(task_id) as id FROM task LIMIT 1
</cfquery> --->
<cfoutput>#obj_logger.ins_log(task_id="#insert_task.generatedkey#", log_text="#log_text#")#</cfoutput>
</cfif>

<!------ REDIRECTION SUR PAGE CORRESPONDANTE ------>
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">

</cfif>








<!---------------------------- UPDATE OPPORT / TASK ------------------------>
<cfif isdefined("form") AND isdefined("account_id") AND isdefined("task_id") AND (isdefined("updt_opport") OR isdefined("updt_task"))>

<cfif isdefined("updt_opport")>
	<cfif day(task_date_deadline) lte "12">
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-dd-mm')#">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-dd-mm')#">
	<cfelse>
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-mm-dd')#">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-mm-dd')#">
	</cfif>
<cfelse>
	<cfif day(task_date_deadline) lte "12">
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-dd-mm')# #task_date_start#:00">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-dd-mm')# #task_date_end#:00">
	<cfelse>
		<cfset task_date_start = "#dateformat(task_date_deadline,'yyyy-mm-dd')# #task_date_start#:00">
		<cfset task_date_end = "#dateformat(task_date_deadline,'yyyy-mm-dd')# #task_date_end#:00">
	</cfif>
</cfif>

<cfif isdefined("task_alert")>
	<cfif day(task_date_remind) lte "12">
		<cfset task_date_remind = "#dateformat(task_date_remind,'yyyy-dd-mm')# 00:00:00">
	<cfelse>
		<cfset task_date_remind = "#dateformat(task_date_remind,'yyyy-mm-dd')# 00:00:00">
	</cfif>
</cfif>

<cfquery name="updt_opport" datasource="#SESSION.BDDSOURCE#">
UPDATE task
SET 
<cfif isdefined("contact_id")>contact_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">,</cfif>
<cfif isdefined("parent_id")>parent_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#parent_id#">,</cfif>
<cfif isdefined("account_id")>account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,</cfif>
<cfif isdefined("invoice_id")>invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">,</cfif>

task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#">,
task_name = <cfif isdefined("task_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_name#"><cfelse>null</cfif>,

<cfif isdefined("task_alert")>
task_alert = 1,
task_date_remind = <cfqueryparam cfsqltype="cf_sql_date" value="#task_date_remind#">,
<cfelse>
task_alert = 0,
task_date_remind = null,
</cfif>

task_date_close = <cfif isdefined("task_date_close")><cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"><cfelse>null</cfif>,

task_date_start = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_start#">,
task_date_end = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_end#">,
task_date_deadline = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_deadline#">,

<!---task_description = <cfif isdefined("task_description")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_description#"><cfelse>null</cfif>,--->
task_amount = <cfif isdefined("task_amount") AND task_amount neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_amount#"><cfelse>null</cfif>,
task_probability = <cfif isdefined("task_probability")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_probability#"><cfelse>null</cfif>

WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
</cfquery>

<!------ INSERTION COMMENTAIRES ------>
<cfif isdefined("log_text") AND log_text neq "">
<cfoutput>
#obj_logger.ins_log(task_id="#task_id#", log_text="#log_text#")#
</cfoutput>
</cfif>

<!------ REDIRECTION SUR PAGE CORRESPONDANTE ------>
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">

</cfif>





<!---------------------------- QUICK UPDATE OPPORT / TASK FROM CALENDAR (DATES ONLY) ------------------------>
<cfif isdefined("task_id") AND isdefined("updt_quick")>

	<cfset task_date_start_1 = listgetat(task_date_start,1,'_')>
	<cfset task_date_start_2 = replace(listgetat(task_date_start,2,'_'),'-',':','ALL')>
	<cfset task_date_start = "#task_date_start_1# #task_date_start_2#">
	
	<cfif isdefined("task_date_end")>
		<cfset task_date_end_1 = listgetat(task_date_end,1,'_')>
		<cfset task_date_end_2 = replace(listgetat(task_date_end,2,'_'),'-',':','ALL')>
		<cfset task_date_end = "#task_date_end_1# #task_date_end_2#">
	<cfelse>
		<cfset task_date_end = task_date_start>
	</cfif>
	

	<cfquery name="updt_opport" datasource="#SESSION.BDDSOURCE#">
	UPDATE task
	SET 
	task_alert = 0,
	task_date_remind = null,
	task_date_start = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_start#">,
	task_date_end = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_end#">,
	task_date_deadline = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#task_date_end#">
	WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
	</cfquery>

</cfif>




<!---------------------------- QUICK UPDATE CLOSING OPPORT / TASK ------------------------>
<cfif isdefined("task_id") AND isdefined("updt_close")>

	<cfquery name="updt_opport" datasource="#SESSION.BDDSOURCE#">
	UPDATE task
	SET task_date_close = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
	<cfif isdefined("updt_close_won")>,task_type_id=7</cfif>
	<cfif isdefined("updt_close_lost")>,task_type_id=6</cfif>
	WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
	
</cfif>






<!---------------------------- DELETE OPPORT / TASK ------------------------>
<cfif isdefined("task_id") AND (isdefined("del_opport") OR isdefined("del_task"))>
<cfquery name="del_opprt" datasource="#SESSION.BDDSOURCE#">
DELETE FROM task WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
</cfquery>
<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
</cfif>








