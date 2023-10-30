<cfoutput>
user_id - #user_id#<br>

t_alias - #t_alias#<br>
t_firstname - #t_firstname#<br>
t_name - #t_name#<br>
t_email - #t_email#<br>
t_isvisio - #t_isvisio#<br>
t_isf2f - #t_isf2f#<br>
t_c_id - #t_c_id#<br>
t_t_id - #t_t_id#<br>
t_s_id - #t_s_id#<br>
t_based - #t_based#<br>
t_email_2 - #t_email_2#<br>
t_phone - #t_phone#<br>
t_birthday - #dateformat(t_birthday,"yyyy-mm-dd")#<br>
t_visiorate - #t_visiorate#<br>
t_f2frate - #t_f2frate#<br>
t_refrate - #t_refrate#<br>
t_paymentmode - #t_paymentmode#<br>
t_iban - #t_iban#<br>
t_address - #t_address#<br>
t_postal - #t_postal#<br>
t_city - #t_city#<br>
t_country - #t_country#<br>
t_paymentname - #t_paymentname#<br>
t_siret - #t_siret#<br>

t_lst - #t_lst#<br>



<cfset list_method = "">
<cfif t_isvisio neq "NO">
	<cfset list_method = listappend(list_method,"1")>
</cfif>
<cfif t_isf2f neq "NO">
	<cfset list_method = listappend(list_method,"2")>
</cfif>

</cfoutput>

<cfquery name="updt_trainer" datasource="#SESSION.BDDSOURCE#">
UPDATE user
SET
timezone_id = 6,
user_firstname = "#t_firstname#",
user_name = "#t_name#",
user_email = "#t_email#",
user_password = "215B1BB720810818F4462E79B9A55EF7",
user_phone = "#t_phone#",
user_alias = "#t_alias#",
user_lst = "#t_lst#",
interest_id = "#list_int#",
method_id = "#list_method#",
speciality_id = "#list_level#",
perso_id = "#list_perso#",
domain_id = "#list_exp#",
<cfif t_birthday neq "">user_birthday = "#dateformat(t_birthday,"yyyy-mm-dd")#",</cfif>
user_based = "#t_based#"
WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="del_rule" datasource="#SESSION.BDDSOURCE#">
DELETE FROM user_payment WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="ins_rule" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user_payment
(
user_id,
payment_type,
payment_iban,
payment_name,
payment_address,
payment_postal,
payment_city,
payment_siret,
payment_vat,
visio_rate,
f2f_rate,
special_rate
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
'#t_paymentmode#',
'#t_iban#',
'#t_paymentname#',
'#t_address#',
'#t_postal#',
'#t_city#',
'#t_siret#',
'#t_tva#',
<cfif t_visiorate neq "">'#t_visiorate#',<cfelse>null,</cfif>
<cfif t_f2frate neq "">'#t_f2frate#',<cfelse>null,</cfif>
<cfif t_refrate neq "">'#t_refrate#'<cfelse>null</cfif>
)
</cfquery>



