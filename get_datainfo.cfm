<!------------------GET USER INFO --------------------->
<cfif isdefined("user_id")>
<cfsilent>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_name FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">
</cfquery>

<cfset table_user = arraynew(1)>

<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tp tp
LEFT JOIN lms_formation_pack fp ON fp.pack_id = tp.pack_id
WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_id#">
</cfquery>

<cfoutput query="get_user">
	<cfset temp = arrayAppend(table_user, structNew())>
	<cfset table_user[currentrow].user_id = user_id>
	<cfset table_user[currentrow].user_name = user_firstname&" "&user_name>
	
	<!-------------GET ABO LIST ---------------->
	<cfset user_abo = ArrayNew(1)>	
	<cfloop query="get_abo">
		<cfset temp = arrayAppend(user_abo,["#sub_id#", "#sub_total# h"])> 
	</cfloop>	
	<cfset table_user[currentrow].user_abo = user_abo>
	
	
	<!-------------GET TP LIST ---------------->
	<cfset user_tp = ArrayNew(1)>	
	<cfloop query="get_tp">
		<cfset temp = arrayAppend(user_tp,["#tp_id#", "#pack_name_fr# #pack_hour# h"])> 
	</cfloop>	
	<cfset table_user[currentrow].user_tp = user_tp>
	

</cfoutput>

<cfset table_js = SerializeJSON(table_user)>

</cfsilent>
<cfoutput>#table_js#</cfoutput>
</cfif>







<!------------------GET TP INFO --------------------->
<cfif isdefined("tpmaster_id")>
<cfsilent>
<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
SELECT s.sessionmaster_id, tp.tpmaster_name, s.sessionmaster_name, s.parent_id as p_id, (CASE parent_id WHEN '0' THEN s.sessionmaster_id ELSE parent_id END) as grouper
FROM lms_tpsessionmaster s 
INNER JOIN lms_tpcor cor ON s.sessionmaster_id = cor.sessionmaster_id
INNER JOIN lms_tpmaster tp ON tp.tpmaster_id = cor.tpmaster_id
WHERE cor.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
ORDER BY grouper, parent_id
</cfquery>

<cfset table_session = arraynew(1)>

<cfoutput query="get_session">
	<cfset temp = arrayAppend(table_session, structNew())>
	<cfset table_session[currentrow].sessionmaster_id = sessionmaster_id>
	<cfset table_session[currentrow].sessionmaster_name = sessionmaster_name>
	<cfset table_session[currentrow].parent_id = p_id>
	<cfset table_session[currentrow].tpmaster_name = tpmaster_name>
</cfoutput>

<cfset table_js = SerializeJSON(table_session)>

</cfsilent>
<cfoutput>#table_js#</cfoutput>
</cfif>









<!------------------GET ACCOUNT INFO --------------------->
<cfif isdefined("a_id") AND isdefined("get_account")>
<cfif a_id neq "0">
<cfsilent>
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_id, account_name, account_address, account_postal, account_city, account_country, account_f_name, account_f_address, account_f_postal, account_f_city, account_f_country, account_average_price
FROM account a 
WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfquery>
<cfset table_opca = arraynew(1)>
<cfoutput query="get_account">
	<cfset temp = arrayAppend(table_opca, structNew())>
	<cfset table_opca[currentrow].account_id = account_id>
	<cfset table_opca[currentrow].account_address = account_address>
	<cfset table_opca[currentrow].account_postal = account_postal>
	<cfset table_opca[currentrow].account_city = account_city>
	<cfset table_opca[currentrow].account_country= account_country>
	<cfset table_opca[currentrow].account_f_name = account_f_name>
	<cfset table_opca[currentrow].account_f_address = account_f_address>
	<cfset table_opca[currentrow].account_f_postal = account_f_postal>
	<cfset table_opca[currentrow].account_f_city = account_f_city>
	<cfset table_opca[currentrow].account_f_country = account_f_country>
	<cfset table_opca[currentrow].account_average_price = account_average_price>
</cfoutput>
<cfset table_js = SerializeJSON(table_opca)>
</cfsilent>
<cfoutput>#table_js#</cfoutput>
</cfif>
</cfif>






<!------------------GET CONTACT INFO --------------------->
<cfif isdefined("a_id") AND isdefined("get_contact")>
<cfif a_id neq "0">
<cfsilent>
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT contact_firstname, contact_name, contact_id
FROM account_contact 
WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfquery>
<cfset table_contact = arraynew(1)>
<cfoutput query="get_account">
	<cfset temp = arrayAppend(table_contact, structNew())>
	<cfset table_contact[currentrow].contact_id = contact_id>
	<cfset table_contact[currentrow].contact_firstname = contact_firstname>
	<cfset table_contact[currentrow].contact_name = contact_name>
</cfoutput>
<cfset table_js = SerializeJSON(table_contact)>
</cfsilent>
<cfoutput>#table_js#</cfoutput>
</cfif>
</cfif>
