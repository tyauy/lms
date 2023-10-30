<cfcomponent>
<cfsetting enablecfoutputonly="No" showdebugoutput="No">
	<cffunction name="get_account" access="public" returnFormat="json">
		<!---<cfargument name="position" type="string" required="yes">--->
		<cfargument name="type_id" type="string" required="yes">
		<cfsilent>
		
		<cfquery name="get_client" datasource="#SESSION.BDDSOURCE#">
		SELECT a.*, a2.account_name as group_name, at.type_name, at.type_id, u.user_alias FROM account a
		LEFT JOIN account a2 ON a.group_id = a2.account_id 
		LEFT JOIN account_type at ON at.type_id = a.type_id
		LEFT JOIN user u ON u.user_id = a.user_id
		WHERE a.type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#type_id#">
		ORDER BY account_name ASC
		</cfquery>
		
		<cfset table_account = arraynew(1)>
		
		<cfset table = "">
				
		<cfoutput query="get_client">

		<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
		SELECT contact_firstname, contact_name, contact_id FROM account_contact
		WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#"> AND contact_lead = 1
		</cfquery>
		
			<cfset test = "">
			<cfset test = listappend(test, "#account_id#")>
			<cfset test = listappend(test, "#account_name#")>
			<cfset test = listappend(test, "#group_name#")>
			<cfset test = listappend(test, "contact")>
			<cfset test = listappend(test, "#account_city#")>
			<cfset test = listappend(test, "#account_country#")>
			<cfset test = listappend(test, "#account_phone#")>
			<cfset test = listappend(test, "#user_alias#")>
			<cfset test = listappend(test, "bla")>
			
			<cfset todo = "[#test#]">
			
			<cfset table = listappend(table,todo)>
			
			<!---
						
			<cfset temp = arrayAppend(table_account, structNew())>
			
			<cfset table_account[currentrow].account_id = account_id>
			<cfset table_account[currentrow].account_name = account_name>
			<cfset table_account[currentrow].group_name = group_name>
			<!---<cfset temp = "">
			<cfloop query="get_ctc">
			<cfset temp = temp&'<a href="crm_account_edit.cfm?a_id=#get_client.account_id#&c_id=#get_ctc.contact_id#">#get_ctc.contact_firstname# #get_ctc.contact_name#</a><br>'>
			</cfloop>--->
			<cfset table_account[currentrow].account_contact = "contact">
			<cfset table_account[currentrow].account_city = account_city>
			<cfset table_account[currentrow].account_country = account_country>
			<cfset table_account[currentrow].account_phone = account_phone>
			<cfset table_account[currentrow].user_alias = user_alias>
			<!----<cfset temp = '<a class="btn btn-info btn-xs" href="crm_account_edit.cfm?a_id=#account_id#">Voir</a>'>--->
			<cfset table_account[currentrow].colright = "hello">
				
			<!---<cfset table_account[currentrow].start = dateformat(task_close, "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>
			<cfset table_account[currentrow].end = dateformat(dateadd('d',task_close,1), "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>--->
			
			--->
		</cfoutput>

		<!---<cfset table_js = SerializeJSON(table_account)>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_ID","account_id","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_NAME","account_name","ALL")>
		<cfset table_js = replacenocase(table_js,"GROUP_NAME","group_name","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_CONTACT","account_contact","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_CITY","account_city","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_COUNTRY","account_country","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_PHONE","account_phone","ALL")>
		<cfset table_js = replacenocase(table_js,"USER_ALIAS","user_alias","ALL")>
		<cfset table_js = replacenocase(table_js,"COLRIGHT","colright","ALL")>
--->
		</cfsilent>
		<cfreturn table_js>
	
	</cffunction>
	
</cfcomponent>