<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
	<cfif isdefined("o_id") AND isdefined("act") AND isdefined("n_doc") AND isdefined("dir_go") AND isdefined("dir_rel")>
		
		<!--- <cfset get_order = obj_query.oget_orders(o_id="#o_id#")> --->
		<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
			SELECT order_ref 
			FROM orders 
			WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#"> 
			AND account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfquery>
		
		<cfif isdefined("doc_attach") AND doc_attach neq "">

			<cfif not directoryExists(dir_go)>
			
				<cfdirectory directory="#dir_go#" action="create" mode="777">
			
			</cfif>
					
			<cffile action = "upload" 
			filefield = "doc_attach" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777">					
							
			<cfif cffile.FileWasSaved>	

				<cfif cffile.clientFileExt neq "pdf" AND cffile.clientFileExt neq "jpg" AND cffile.clientFileExt neq "jpeg" AND cffile.clientFileExt neq "png" AND cffile.clientFileExt neq "docx" AND cffile.clientFileExt neq "doc">
				
					<cffile action="DELETE" file="#dir_go#/#cffile.ClientFile#">
				
					Unsupported File Format...  Please <a href="common_orders.cfm">go back</a> and try again !
					
					<cfabort>		
				</cfif>
				<cfif (CFFILE.FileSize GT (5000 * 1024))>
				
					<cffile action="DELETE" file="#dir_go#/#cffile.ClientFile#">
				
					File too big... Please <a href="common_orders.cfm">go back</a> and try again !
					
					<cfabort>	
				</cfif>
					
					<cffile action="rename" 
					source = "#dir_go#/#cffile.ClientFile#" 
					destination = "#dir_go#/#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#" 
					attributes = "normal"
					mode="777"> 
					
					<cfquery name="updt_orders" datasource="#SESSION.BDDSOURCE#">
					UPDATE orders SET					
					<cfif act eq "upl_apc">
					order_apc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_bdc">
					order_bdc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_conv">
					order_conv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_avn">
					order_avn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_avn2">
					order_avn2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_aff">
					order_aff = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_cert">
					order_cert = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_cda">
					order_cda = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					<cfelseif act eq "upl_bf">
					order_bf = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n_doc#_#get_order.order_ref#.#lcase(cffile.clientFileExt)#">
					</cfif>
					WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
					</cfquery>
				
			</cfif>
			
		</cfif>
		
		<cfif from eq "order">
			<cflocation addtoken="no" url="common_orders.cfm?o_id=#o_id#">
		<cfelseif from eq "account">
			<cfquery name="get_ref" datasource="#SESSION.BDDSOURCE#">
			SELECT order_ref FROM orders WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
			</cfquery>
			<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#&o_ref=#get_ref.order_ref#&view_tab=order">
		<cfelseif isDefined("ucb")>
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#ucb#">
		<cfelseif from eq "learner">
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#">
		</cfif>
		
	<cfelseif isdefined("o_id") AND isdefined("n_doc") AND isdefined("doc_delete")>

		<cfset dir_go = "#SESSION.BO_ROOT#/admin/#lcase(n_doc)#">
		<cfif isdefined("u_id")> <cfset dir_go &= "/#u_id#"> </cfif>
		<cfset dir_go &= "/#doc_delete#">

		<cffile action = "delete" file = "#dir_go#">
		
		<cfquery name="updt_orders" datasource="#SESSION.BDDSOURCE#">
		UPDATE orders SET					
		<cfif lcase(n_doc) eq "apc">
		order_apc = null
		<cfelseif lcase(n_doc) eq "bdc">
		order_bdc = null
		<cfelseif lcase(n_doc) eq "conv">
		order_conv = null
		<cfelseif lcase(n_doc) eq "avn">
		order_avn = null
		<cfelseif lcase(n_doc) eq "avn2">
		order_avn2 = null
		<cfelseif lcase(n_doc) eq "aff">
		order_aff = null
		<cfelseif lcase(n_doc) eq "cert">
		order_cert = null
		<cfelseif lcase(n_doc) eq "cda">
		order_cda = null
		<cfelseif lcase(n_doc) eq "bf">
		order_bf = null
		</cfif>
		WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
		</cfquery>
		
		<cfif from eq "order">
			<cflocation addtoken="no" url="common_orders.cfm?o_id=#o_id#">
		<cfelseif from eq "account">
			<cfquery name="get_ref" datasource="#SESSION.BDDSOURCE#">
			SELECT order_ref FROM orders WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
			</cfquery>
			<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#&o_ref=#get_ref.order_ref#&view_tab=order">
		<cfelseif isDefined("ucb")>
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#ucb#">
		<cfelseif from eq "learner">
			<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#">
		</cfif>
	
	
	</cfif>
	
</cfif>