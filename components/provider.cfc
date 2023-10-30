<cfcomponent>

	<!-------------------------- GET ACCOUNT LIST ------------------------>
	<cffunction name="get_account" access="public" returntype="any">
		<cfargument name="type_id" type="string" required="yes">
		<cfsilent>
		
		<cfquery name="get_client" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_id, a.account_name, a.account_city, a.account_phone, ag.group_name, at.type_name, at.type_id, ast.status_name, u.user_alias, c.country_name_fr FROM account a
		LEFT JOIN account_group ag ON ag.group_id = a.group_id 
		LEFT JOIN account_type at ON at.type_id = a.type_id
		LEFT JOIN account_status ast ON ast.status_id = a.status_id
		LEFT JOIN settings_country c ON c.country_id = a.account_country
		LEFT JOIN user u ON u.user_id = a.user_id
		WHERE a.type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#type_id#">
		ORDER BY account_name ASC
		</cfquery>
		
		<cfset table_account = arraynew(1)>
		
		<cfoutput query="get_client">

		<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
		SELECT ac.contact_firstname, ac.contact_name, ac.contact_id 
		FROM account_contact ac
		INNER JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id
		WHERE acc.a_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#"> AND contact_lead = 1
		</cfquery>

			<cfset temp = arrayAppend(table_account, structNew())>
			
			<cfset table_account[currentrow].account_id = account_id>
			<cfset table_account[currentrow].status_name = status_name>
			<cfset table_account[currentrow].account_name = account_name>
			<cfset table_account[currentrow].group_name = group_name>
			<cfset temp = "">
			<cfloop query="get_ctc">
			<cfset temp = temp&'<a href="crm_account_edit.cfm?a_id=#get_client.account_id#&c_id=#get_ctc.contact_id#">#get_ctc.contact_firstname# #get_ctc.contact_name#</a><br>'>
			</cfloop>
			<cfset table_account[currentrow].account_contact = temp>
			<cfset table_account[currentrow].account_city = account_city>
			<cfset table_account[currentrow].account_country = country_name_fr>
			<cfset table_account[currentrow].account_phone = account_phone>
			<cfset table_account[currentrow].user_alias = user_alias>
			<cfset temp = '<a class="btn btn-sm btn-outline-info" href="crm_account_edit.cfm?a_id=#account_id#"><i class="far fa-eye"></i></a>'>
			<!---<cfif SESSION.TOOL neq "plan">
			<cfset temp = temp&' <a class="btn btn-info btn-sm" href="invoice_edit.cfm?a_id=#account_id#"><i class="fas fa-euro-sign"></i></a>'>
			</cfif>--->
			<cfset table_account[currentrow].colright = temp>
				
			<!---<cfset table_account[currentrow].start = dateformat(task_close, "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>
			<cfset table_account[currentrow].end = dateformat(dateadd('d',task_close,1), "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>--->
		</cfoutput>

		<cfset table_js = SerializeJSON(table_account)>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_ID","account_id","ALL")>
		<cfset table_js = replacenocase(table_js,"STATUS_NAME","status_name","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_NAME","account_name","ALL")>
		<cfset table_js = replacenocase(table_js,"GROUP_NAME","group_name","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_CONTACT","account_contact","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_CITY","account_city","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_COUNTRY","account_country","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_PHONE","account_phone","ALL")>
		<cfset table_js = replacenocase(table_js,"USER_ALIAS","user_alias","ALL")>
		<cfset table_js = replacenocase(table_js,"COLRIGHT","colright","ALL")>

		</cfsilent>
		
		<cfset table_js ='{"data":#table_js#}'>
		
		<cfreturn table_js>
	
	</cffunction>
	
	
	
	
	
	
	
	<!-------------------------- GET CONTACT------------------------>
	<cffunction name="get_contact" access="remote" returntype="any" returnformat="json">
	<cfsilent>
	<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
	SELECT *
	FROM account_contact ac
	LEFT JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id
	LEFT JOIN account a ON a.account_id = acc.a_id 
	LEFT JOIN account_group ag ON ag.group_id = a.group_id 
	LEFT JOIN account_type at ON at.type_id = a.type_id
	LEFT JOIN user u ON u.user_id = a.user_id
	ORDER BY contact_name ASC
	</cfquery>

		<cfset table_contact = arraynew(1)>

		<cfoutput query="get_contact">

			<cfset temp = arrayAppend(table_contact, structNew())>	
			
			<cfset table_contact[currentrow].contact_name = contact_name>
			<cfset table_contact[currentrow].contact_firstname = contact_firstname>
			<cfset table_contact[currentrow].account_name = account_name>
			<cfset table_contact[currentrow].group_name = group_name>
			<cfset table_contact[currentrow].type_name = type_name>
			<cfset table_contact[currentrow].account_city = account_city>
			<cfset table_contact[currentrow].contact_tel1 = contact_tel1>
			<cfset table_contact[currentrow].user_alias = user_alias>
			<cfset temp = '<a class="btn btn-default btn-sm" href="crm_account_edit.cfm?a_id=#account_id#&c_id=#contact_id#"><i class="far fa-eye"></i></a>'>
			<cfset table_contact[currentrow].colright = temp>
				
			<!---<cfset table_account[currentrow].start = dateformat(task_close, "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>
			<cfset table_account[currentrow].end = dateformat(dateadd('d',task_close,1), "yyyy-mm-dd")&"T"&TimeFormat(task_close, "HH:mm:ss")>--->
		</cfoutput>

		<cfset table_js = SerializeJSON(table_contact)>
		<cfset table_js = replacenocase(table_js,"CONTACT_NAME","contact_name","ALL")>
		<cfset table_js = replacenocase(table_js,"CONTACT_FIRSTNAME","contact_firstname","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_NAME","account_name","ALL")>
		<cfset table_js = replacenocase(table_js,"GROUP_NAME","group_name","ALL")>
		<cfset table_js = replacenocase(table_js,"TYPE_NAME","type_name","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_CITY","account_city","ALL")>
		<cfset table_js = replacenocase(table_js,"CONTACT_TEL1","contact_tel1","ALL")>
		<cfset table_js = replacenocase(table_js,"USER_ALIAS","user_alias","ALL")>
		<cfset table_js = replacenocase(table_js,"COLRIGHT","colright","ALL")>

		</cfsilent>
		
		<cfset table_js ='{"data":#table_js#}'>
		
		<cfreturn table_js>
	</cffunction>
	
	
	
	
	
	
	
	
	
	<!-------------------------- GET OPPORT / GET TASK BY TASK_TYPE_ID------------------------>
	<cffunction name="get_opport" access="public" returntype="any">
		<cfargument name="task_type_id" type="string" required="yes">
		<cfsilent>
		<cfquery name="get_opport" datasource="#SESSION.BDDSOURCE#">
		SELECT t.*, tt.task_type_name, u.user_alias, a.account_name, a.account_id, ac.contact_firstname, ac.contact_name
		FROM task t
		LEFT JOIN task_type tt ON tt.task_type_id = t.task_type_id
		LEFT JOIN account a ON a.account_id = t.account_id 
		LEFT JOIN account_contact ac ON ac.contact_id = t.contact_id
		INNER JOIN user u ON u.user_id = t.user_id
		WHERE t.task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_type_id#">
		</cfquery>

		<cfset table_opport = arraynew(1)>

		<cfoutput query="get_opport">

			<cfset temp = arrayAppend(table_opport, structNew())>
			
			<cfset table_opport[currentrow].task_name = task_name>
			<cfset table_opport[currentrow].task_type_name = task_type_name>
			<cfset table_opport[currentrow].user_alias = user_alias>
			<cfset table_opport[currentrow].account_name = account_name>
			<cfif contact_name neq "">
				<cfset table_opport[currentrow].contact_name = contact_firstname&" "&contact_name>
			<cfelse>
				<cfset table_opport[currentrow].contact_name = "-">
			</cfif>
			<cfset table_opport[currentrow].task_date_deadline = dateformat(task_date_deadline,'dd/mm/yyyy')>
			
			<cfif task_amount neq "">
				<cfset table_opport[currentrow].task_amount = task_amount&" &euro;">
			<cfelse>
				<cfset table_opport[currentrow].task_amount = "-">
			</cfif>
			
			<cfif task_probability neq "-">
				<cfset table_opport[currentrow].task_probability = task_probability&" %">
			<cfelse>
				<cfset table_opport[currentrow].task_probability = "-">
			</cfif>
			
			<cfset table_opport[currentrow].task_date_close = dateformat(task_date_close,'dd/mm/yyyy')>
			<cfset temp = "">
			<cfset temp = '<a class="btn btn-default btn-sm" href="crm_account_edit.cfm?a_id=#account_id#"><i class="far fa-eye"></i></a>'>
			<cfset table_opport[currentrow].action = temp>

		</cfoutput>

		<cfset table_js = SerializeJSON(table_opport)>
		<cfset table_js = replacenocase(table_js,"TASK_NAME","task_name","ALL")>
		<cfset table_js = replacenocase(table_js,"TASK_TYPE_NAME","task_type_name","ALL")>
		<cfset table_js = replacenocase(table_js,"USER_ALIAS","user_alias","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_NAME","account_name","ALL")>
		<cfset table_js = replacenocase(table_js,"CONTACT_NAME","contact_name","ALL")>
		<cfset table_js = replacenocase(table_js,"TASK_DATE_DEADLINE","task_date_deadline","ALL")>
		<cfset table_js = replacenocase(table_js,"TASK_AMOUNT","task_amount","ALL")>
		<cfset table_js = replacenocase(table_js,"TASK_PROBABILITY","task_probability","ALL")>
		<cfset table_js = replacenocase(table_js,"TASK_DATE_CLOSE","task_date_close","ALL")>
		<cfset table_js = replacenocase(table_js,"ACTION","action","ALL")>

		</cfsilent>
		
		<cfset table_js ='{"data":#table_js#}'>
		
		<cfreturn table_js>
		
	</cffunction>
	
	
	
	
	
	<!-------------------------- GET ORDER------------------------>
	<cffunction name="get_order" access="public" returntype="any">
		<cfargument name="status_id" type="numeric" required="yes">
		<cfsilent><cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
		SELECT o.*, a.account_name, os.status_name FROM orders o
		INNER JOIN account a ON o.account_id = a.account_id
		INNER JOIN orders_status os ON os.status_id = o.status_id
		<cfif status_id neq "0">AND o.status_id = #status_id#</cfif>
		</cfquery>

		<cfset table_order = arraynew(1)>

		<cfoutput query="get_order">

			<cfset temp = arrayAppend(table_order, structNew())>
			
			<cfset table_order[currentrow].order_id = order_id>
			<cfset table_order[currentrow].order_date = dateformat(order_date,'dd/mm/yyyy')>
			<cfset table_order[currentrow].order_limit = dateformat(order_limit,'dd/mm/yyyy')>
			<cfset table_order[currentrow].account_name = '<a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#</a>'>
			<!---<cfset table_order[currentrow].contact_name = "">--->
			<cfset table_order[currentrow].order_amount = numberformat(order_amount, '____.__')&" &euro;">
			<cfset table_order[currentrow].status_name = status_name>
			<cfset temp = '<a id="view_#order_id#" class="btn btn-default btn-sm btn_view_invoice"><i class="far fa-eye"></i></a> <a class="btn btn-info btn-sm" href="invoice_edit.cfm?o_id=#order_id#"><i class="fas fa-edit"></i></a> <a class="btn btn-info btn-sm btn_del_invoice" href="invoice_edit.cfm?o_id=#order_id#"><i class="far fa-trash-alt"></i></a>'>
			<cfset table_order[currentrow].action = temp>
		</cfoutput>

		<cfset table_js = SerializeJSON(table_order)>
		<cfset table_js = replacenocase(table_js,"ORDER_ID","order_id","ALL")>
		<cfset table_js = replacenocase(table_js,"ORDER_DATE","order_date","ALL")>
		<cfset table_js = replacenocase(table_js,"ORDER_LIMIT","order_limit","ALL")>
		<cfset table_js = replacenocase(table_js,"ACCOUNT_NAME","account_name","ALL")>
		<!---<cfset table_js = replacenocase(table_js,"CONTACT_NAME","contact_name","ALL")>--->
		<cfset table_js = replacenocase(table_js,"ORDER_AMOUNT","order_amount","ALL")>
		<cfset table_js = replacenocase(table_js,"STATUS_NAME","status_name","ALL")>
		<cfset table_js = replacenocase(table_js,"ACTION","action","ALL")>

		</cfsilent>

		<cfset table_js ='{"data":#table_js#}'>
			
		<cfreturn table_js>
	
	</cffunction>
	
	
	
	
	
	
	<!-------------------------- GET LOGS------------------------>
	<cffunction name="get_log" access="public" returntype="any">
	<cfsilent><cfquery name="get_log" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_alias, l.*, a.account_id, a.account_name, tt.task_group, tt.task_type_name FROM logs l
		LEFT JOIN task t ON l.task_id = t.task_id
		LEFT JOIN task_type tt ON t.task_type_id = tt.task_type_id
		LEFT JOIN user u ON l.user_id = u.user_id
		LEFT JOIN account a ON l.account_id = a.account_id
		LEFT JOIN orders o ON l.order_id = o.order_id
		LEFT JOIN supply s ON l.supply_id = s.supply_id
		LEFT JOIN account_contact c ON l.contact_id = c.contact_id
		WHERE 1 = 1
		<cfif isdefined("view") AND view eq "sales">OR (l.account_id != 0 OR l.contact_id != 0 OR l.task_id != 0)</cfif>
		<cfif isdefined("view") AND view eq "logistic">OR (l.supply_id != 0)</cfif>
		<cfif isdefined("view") AND view eq "invoicing">OR (l.order_id != 0)</cfif>
		ORDER BY log_date DESC
		</cfquery>

		<cfset table_log = arraynew(1)>

		<cfoutput query="get_log">

			<cfset temp = arrayAppend(table_log, structNew())>
			
			<cfset table_log[currentrow].log_date = dateformat(log_date,'dd/mm/yyyy')&" "&TimeFormat(log_date, "hh:mm:ss")>
			
			<cfif task_id neq "0">
				<cfset log_type = task_type_name>
				<cfset log_reference = "">
			</cfif>
			<cfif account_id neq "0">
				<cfset log_type = "Compte">
				<cfset log_reference = '<a href="account_edit.cfm?a_id=#account_id#">#account_name#</a>'>
			</cfif>
			<cfif order_id neq "0">
				<cfset log_type = "Facturation">
				<cfset log_reference = "">
			</cfif>
			<cfif supply_id neq "0">
				<cfset log_type = "Logistique">
				<cfset log_reference = "">
			</cfif>
			<cfif contact_id neq "0">
				<cfset log_type = "Contact">
				<cfset log_reference = "">
			</cfif>						
			<cfset table_log[currentrow].log_type = log_type>
			<cfset table_log[currentrow].log_reference = log_reference>
			<cfset table_log[currentrow].user_alias = user_alias>
			<cfset table_log[currentrow].log_text = log_text>

		</cfoutput>

		<cfset table_js = SerializeJSON(table_log)>
									
		<cfset table_js = replacenocase(table_js,"LOG_DATE","log_date","ALL")>							
		<cfset table_js = replacenocase(table_js,"LOG_TYPE","log_type","ALL")>
		<cfset table_js = replacenocase(table_js,"LOG_REFERENCE","log_reference","ALL")>
		<cfset table_js = replacenocase(table_js,"USER_ALIAS","user_alias","ALL")>
		<cfset table_js = replacenocase(table_js,"LOG_TEXT","log_text","ALL")>


		</cfsilent>
		
		<cfset table_js ='{"data":#table_js#}'>
			
		<cfreturn table_js>
	
	</cffunction>
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
</cfcomponent>