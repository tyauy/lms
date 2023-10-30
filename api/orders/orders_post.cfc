<cfcomponent>


    <cffunction name="order_form" access="public" returntype="numeric">

        <cfset user_list = [] />


        <!--- TODO update form --->

        
        <!--- <cfif isDefined("existing_user_count") AND existing_user_count neq "" AND existing_user_count neq 0> --->
        <cfif isDefined("user_id_ex") AND user_id_ex neq "">

            <cfloop list="#user_id_ex#" index="cor">
                <cfif cor neq "" AND cor neq 0>
                    <cfset arrayAppend(user_list, cor) />
                </cfif>
            </cfloop>

            <!--- <cfloop from="1" to="#existing_user_count#" index="idx">
                <cfif arguments["user_id_#idx#"] neq 0 AND arguments["user_id_#idx#"] neq "">
                    <cfset arrayAppend(user_list, arguments["user_id_#idx#"]) />
                </cfif>
            </cfloop> --->

        </cfif>

        <!--- <cfif isDefined("new_user_count") AND new_user_count neq "" AND new_user_count neq 0>

            <cfloop from="1" to="#new_user_count#" index="idx">

                <cftry>

              
                <cfinvoke component="api/users/user_post" method="insert_user" returnVariable="user_new_id">
                    <cfinvokeargument name="user_email" value="#arguments["user_mail_" & idx]#">
                    <cfinvokeargument name="user_phone" value="#arguments["user_phone_" & idx]#">
                    <cfinvokeargument name="user_phone_code" value="#arguments["user_phone_code_" & idx]#">
                    <cfinvokeargument name="user_name" value="#arguments["user_name_" & idx]#">
                    <cfinvokeargument name="user_firstname" value="#arguments["user_firstname_" & idx]#">
                    <cfinvokeargument name="user_gender" value="#arguments["user_gender_" & idx]#">
                    <cfinvokeargument name="account_id" value="#insert_order#">

                </cfinvoke>
                
                <cfif user_new_id neq 0 AND user_new_id neq "">
                    <cfset arrayAppend(user_list, user_new_id) />
                </cfif>

                <cfcatch type="any">
                    Error: <cfoutput>#cfcatch.message#</cfoutput>
                </cfcatch>
                </cftry>

            </cfloop>

        </cfif> --->
	
		<!--- <cfdump var="#user_list#"> --->

        <!--- <cfdump var="#arguments#">
		<br>
		<cfdump var="#order_date#">
		<br>
		<cfdump var="#order_start#">
		<br>
		<cfdump var="#order_end#">
		<br> --->
	
        

		<cfinvoke component="api/orders/orders_post" method="insert_order" returnVariable="order_new_id">
			<cfif isdefined("o_id")><cfinvokeargument name="order_id" value="#o_id#"> </cfif>
			<cfinvokeargument name="account_id" value="#insert_order#">
			<cfinvokeargument name="order_status_id" value="#order_status_id#">
			<cfinvokeargument name="order_date" value="#LSDateFormat(order_date,'yyyy-mm-dd', 'fr')#">
			<cfinvokeargument name="order_start" value="#LSDateFormat(order_start,'yyyy-mm-dd', 'fr')#">
			<cfinvokeargument name="order_end" value="#LSDateFormat(order_end,'yyyy-mm-dd', 'fr')#">
			<!--- <cfif order_close neq ""><cfinvokeargument name="order_close" value="#LSDateFormat(order_close,'yyyy-mm-dd', 'fr')#"></cfif> --->
			<cfinvokeargument name="context_id" value="#context_id#">
			<cfif pack_id neq 0> <cfinvokeargument name="pack_id" value="#pack_id#"> </cfif>
			<cfinvokeargument name="provider_id" value="#provider_id#">
			<cfinvokeargument name="order_tva" value="#order_tva#">
			<cfinvokeargument name="formation_id" value="#formation_id#">
			<cfinvokeargument name="order_ref2" value="#order_ref2#">
			<cfinvokeargument name="order_comment" value="#order_comment#">
			<cfinvokeargument name="order_heritage_id_list" value="#order_heritage_id_list#">
            <cfif ArrayLen(user_list) GT 0>
                <cfinvokeargument name="user_patch" value="#ArrayFirst(user_list)#">
            </cfif>

		</cfinvoke>


        <!--- <br>
        order_id
        <cfdump var="#order_new_id#">
        <br> --->

        <!--- cleaning for update --->
        <cfquery name="insert_order_user" datasource="#SESSION.BDDSOURCE#">
            DELETE FROM `orders_users`
            WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_new_id#">
        </cfquery>

		<cfloop array=#user_list# index="user_id">
	
			<cfquery name="insert_order_user" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO `orders_users`(`order_id`, `user_id`) 
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_integer" value="#order_new_id#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">)
			</cfquery>
		</cfloop>
	

	
	
	
		<cfif isdefined('method_id')>
		<cfset method_array = listToArray(#method_id#, ",")>
	
			<!--- TODO add in order_item (certif destination product)  add a elearning_id if needed--->
			<!--- TODO add tva as account info (settings_tva) --->
			<!--- add une collone tva decimal
			a sortir du loop
			rename order_item_package ?? a boucler sur package une ligne par package
			method_id is package id 12345 a mettre en int - une ligne par package
			degager les amount 
			formation_id a ajouter (fr,en,etc)
			ajouter datebegin/end 
			destination pour immersion --->
	
		<cfloop array="#method_array#" index="cur_method_id">

			<cfdump var="#cur_method_id#">
			<br>
			<cfinvoke component="api/orders/orders_post" method="insert_order_item_package">
				<cfinvokeargument name="order_id" value="#order_new_id#">
				<cfinvokeargument name="method_id" value="#cur_method_id#">
				<cfinvokeargument name="account_id" value="#insert_order#">
				<cfinvokeargument name="formation_id" value="#formation_id#">
				<cfif pack_id neq "0"> <cfinvokeargument name="pack_id" value="#pack_id#"> </cfif>

				<cfswitch expression="#cur_method_id#"> 
					<!--- Visio --->
					<cfcase value="1">

						<cfif isDefined("nbh_visio") AND nbh_visio neq ""><cfinvokeargument name="order_item_qty" value="#nbh_visio#"></cfif>
						<cfif isDefined("start_visio") AND start_visio neq ""><cfinvokeargument name="date_begin" value="#LSDateFormat(start_visio,'yyyy-mm-dd', 'fr')#"></cfif>
						<cfif isDefined("end_visio") AND end_visio neq ""><cfinvokeargument name="date_end" value="#LSDateFormat(end_visio,'yyyy-mm-dd', 'fr')#"></cfif>

					</cfcase>
					<!--- F2F --->
					<cfcase value="2">

						<cfif isDefined("nbh_f2f") AND nbh_f2f neq ""><cfinvokeargument name="order_item_qty" value="#nbh_f2f#"></cfif>
						<cfif isDefined("start_f2f") AND start_f2f neq ""><cfinvokeargument name="date_begin" value="#LSDateFormat(start_f2f,'yyyy-mm-dd', 'fr')#"></cfif>
						<cfif isDefined("end_f2f") ANd end_f2f neq ""><cfinvokeargument name="date_end" value="#LSDateFormat(end_f2f,'yyyy-mm-dd', 'fr')#"></cfif>
						
					</cfcase> 
					<!--- Elearning --->
					<cfcase value="3">

                        <cfinvokeargument name="elearning_id" value="#elearning_id#">
							
						<cfif isDefined("nbh_el") AND nbh_el neq ""><cfinvokeargument name="order_item_qty" value="#nbh_el#"></cfif>
						<cfif isDefined("start_el") AND start_el neq ""><cfinvokeargument name="date_begin" value="#LSDateFormat(start_el,'yyyy-mm-dd', 'fr')#"></cfif>
						<cfif isDefined("end_el") AND end_el neq ""><cfinvokeargument name="date_end" value="#LSDateFormat(end_el,'yyyy-mm-dd', 'fr')#"></cfif>
						
					</cfcase>
					<!--- Immersion --->
					<cfcase value="6">

						<cfinvokeargument name="destination_id" value="#destination_id#">

						<cfif isDefined("nbh_imm") AND nbh_imm neq ""><cfinvokeargument name="order_item_qty" value="#nbh_imm#"></cfif>
						<cfif isDefined("start_imm") AND start_imm neq ""><cfinvokeargument name="date_begin" value="#LSDateFormat(start_imm,'yyyy-mm-dd', 'fr')#"></cfif>
						<cfif isDefined("end_imm") AND end_imm neq ""><cfinvokeargument name="date_end" value="#LSDateFormat(end_imm,'yyyy-mm-dd', 'fr')#"></cfif>
						
						
					</cfcase>
                    <!--- Certif - get to be a row since we need to be able to have it on the factu as a separate entity --->
                    <cfcase value="7">

						<cfif isDefined("certif_id") AND certif_id neq ""><cfinvokeargument name="certif_id" value="#certif_id#"></cfif>
						
					</cfcase>
					<!--- <cfdefaultcase></cfdefaultcase>  --->
				</cfswitch>
			</cfinvoke>
		
		</cfloop>
		</cfif>
	
	

	
	
		<cfif isdefined('order_item_mode_id')>
		<cfset mode_array = listToArray(#order_item_mode_id#, ",")>

		<cfif not isDefined("tva")>
			<cftry>


				<cfquery name="select_tva" datasource="#SESSION.BDDSOURCE#">
					SELECT `provider_tva` FROM `account_provider` 
					WHERE `provider_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#"> LIMIT 1
				</cfquery>

				<output query="select_tva">
					<cfset tva = select_tva.provider_tva>
				</output>

				<cfcatch type="any">
					Error: <cfoutput>#cfcatch.message#</cfoutput>
					<cfoutput>#cfcatch.extendedInfo#</cfoutput>
					<cfoutput>#cfcatch.queryError#</cfoutput>
					<!--- <cfset tva = 20> --->
				</cfcatch>
			</cftry>
			
	
			
		</cfif>

        <!--- delete removed invoice --->
        <cfquery name="select_item_invoice_fordelete" datasource="#SESSION.BDDSOURCE#">
            SELECT `order_item_invoice_id`, `order_item_mode_id` FROM `order_item_invoice` 
            WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_new_id#">
        </cfquery>

        <cfoutput query="select_item_invoice_fordelete">

            <cfif not ArrayContains(mode_array,select_item_invoice_fordelete.order_item_mode_id)>

                <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                    DELETE FROM `order_item_invoice`
                    WHERE `order_item_invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_item_invoice_fordelete.order_item_invoice_id#">
                </cfquery>

            </cfif>

        </cfoutput>

		
		<cfloop array="#mode_array#" index="cur_mode_id">
            
			<!--- <cfset amount_ttc = arguments["order_item_amount_" & cur_mode_id] neq "" ? arguments["order_item_amount_" & cur_mode_id] : 0>
            <cfset amount_ttc = amount_ttc * (1 + (tva / 100))>
            
			<cfset tva_amount = arguments["order_item_amount_" & cur_mode_id] neq "" ? arguments["order_item_amount_" & cur_mode_id] : 0>
			<cfset tva_amount = tva_amount * (tva / 100)>
			
			<cfset nbh_amount = arguments["order_item_qty_" & cur_mode_id] neq "" ? arguments["order_item_qty_" & cur_mode_id] : 0>
			<cfset nbh_amount = nbh_amount * (arguments["order_item_unit_price_" & cur_mode_id] neq "" ? arguments["order_item_unit_price_" & cur_mode_id] : 0)>
        	
			<br>
			<cfdump var="#nbh_amount#">
			
	
			<cfdump var="#cur_mode_id#">

			<cfdump var="#tva#">

            <cfdump var="#arguments["order_item_amount_" & cur_mode_id]#"> --->
			<!--- * TODO add invoice_id --->
			<!--- add une collone tva decimal --->
			<!--- ajouter user_id pour factu si 1 seul user --->
	

			<cfinvoke component="api/orders/orders_post" method="insert_order_item_invoice">
				<cfinvokeargument name="order_id" value="#order_new_id#">
				<cfinvokeargument name="account_id" value="#arguments["account_" & cur_mode_id]#">
                <cfinvokeargument name="item_inv_nb_users" value="#arguments["order_item_nb_user_" & cur_mode_id] neq "" ? arguments["order_item_nb_user_" & cur_mode_id] : ArrayLen(user_list)#">
				<cfinvokeargument name="item_inv_hour" value="#arguments["order_item_qty_" & cur_mode_id] neq "" ? arguments["order_item_qty_" & cur_mode_id] : 0#">
				<cfinvokeargument name="item_inv_unit_price" value="#arguments["order_item_unit_price_" & cur_mode_id] neq "" ? arguments["order_item_unit_price_" & cur_mode_id] : 0#">
				<cfinvokeargument name="item_inv_fee" value="#arguments["order_item_fee_amount_" & cur_mode_id] neq "" ? arguments["order_item_fee_amount_" & cur_mode_id] : 0#">
				<cfinvokeargument name="item_inv_total" value="#arguments["order_item_amount_" & cur_mode_id] neq "" ? arguments["order_item_amount_" & cur_mode_id] : 0#">
				<cfinvokeargument name="item_inv_tva" value="#tva#">
				<cfif ArrayLen(user_list) eq 1>
					<cfinvokeargument name="user_id" value="#ArrayFirst(user_list)#">
				</cfif>
				<cfinvokeargument name="order_item_mode_id" value="#cur_mode_id#">

			</cfinvoke>
	
	
	
	
        
            <!--- ! adding order invoice --->
            <!--- ajouter les tva dans les table invoice order --->
                    
            <!--- add une collone tva decimal --->
            <!--- TODO supprimer invoice_id de order_item_invoice et ajouter order_item_invoice_id dans invoice --->
            <!--- plusieur invoice pour un item / par date --->

            <!--- TODO ajouter + sur page de présentation des order --->
            <!--- <cfinvoke component="api/orders/orders_post" method="insert_invoice">
                <cfinvokeargument name="order_id" value="#order_new_id#">
                <cfinvokeargument name="account_id" value="#insert_order#">
                <cfinvokeargument name="status_id" value="1">
                <cfinvokeargument name="invoice_date" value="#now()#">
                <cfinvokeargument name="invoice_amount" value="#arguments["order_item_amount_" & cur_mode_id]#">
                <cfinvokeargument name="invoice_amount_ttc" value="#amount_ttc#">
            </cfinvoke> --->
	
				
	
		</cfloop>
        </cfif>


        <cfreturn 1>

    </cffunction>













    <cffunction name="insert_order" access="public" returntype="numeric">
        <cfargument name="order_id" type="numeric" required="no">

        <cfargument name="account_id" type="numeric" required="yes">
        <cfargument name="provider_id" type="numeric" required="no">
        <cfargument name="order_tva" type="numeric" required="no">
        <cfargument name="formation_id" type="numeric" required="no">
        <cfargument name="order_status_id" type="numeric" required="no">
        <cfargument name="context_id" type="numeric" required="no">
        <cfargument name="pack_id" type="numeric" required="no">
        <cfargument name="order_date" type="date" required="no">
        <cfargument name="order_start" type="date" required="no">
        <cfargument name="order_end" type="date" required="no">
        <!--- <cfargument name="order_close" type="date" required="no"> --->
        <cfargument name="user_patch" type="numeric" required="no">
        <cfargument name="order_ref2" type="string" required="no">
        <cfargument name="order_comment" type="string" required="no">
        <cfargument name="order_heritage_id_list" type="string" required="no">

        <cftry>

            <!--- <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `order_id` FROM `orders` 
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
                AND `account_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
                AND `method_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#">
            </cfquery>
        
            <cfoutput query="select">
                <cfset return_id = select.order_item_package_id>
            </cfoutput> --->


            <cfif isDefined("order_id")>
            
                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `orders` SET
                    <cfif isDefined("order_status_id")> order_status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_status_id#">,</cfif>
                    <cfif isDefined("order_date")> order_date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_date,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("order_start")> order_start = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("order_end")> order_end = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <!--- <cfif isDefined("order_close")> order_close = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_close,'yyyy-mm-dd', 'fr')#">,</cfif> --->
                    <cfif isDefined("context_id")> context_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#context_id#">,</cfif>
                    <cfif isDefined("pack_id")> pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">,</cfif>
                    <!--- <cfif isDefined("user_patch")> user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_patch#">,</cfif>--->
                    <cfif isDefined("provider_id")> provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,</cfif>
                    <cfif isDefined("order_tva")> order_tva = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_tva#">,</cfif>
                    <cfif isDefined("formation_id")> formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,</cfif>
                    <cfif isDefined("order_ref2")> order_ref2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#order_ref2#">,</cfif>
                    <cfif isDefined("order_comment")> order_comment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#order_comment#">,</cfif>
                    <cfif isDefined("order_heritage_id_list")> order_heritage_id_list = <cfqueryparam cfsqltype="cf_sql_varchar" value="#order_heritage_id_list#">,</cfif>
                    account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
                    WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
                </cfquery>

                <cfset return_id = order_id>
                
            <cfelse>

                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `orders`(
                        `provider_id`, 
                        `account_id`, 
                        <cfif isDefined("order_status_id")>`order_status_id`, </cfif>
                        <cfif isDefined("order_tva")>`order_tva`, </cfif>
                        <cfif isDefined("order_date")>`order_date`, </cfif>
                        <cfif isDefined("order_start")>`order_start`, </cfif>
                        <cfif isDefined("order_end")>`order_end`, </cfif>
                        <!---<cfif isDefined("order_close")>`order_close`, </cfif>--->
                        <cfif isDefined("context_id")>`context_id`, </cfif>
                        <cfif isDefined("pack_id")>`pack_id`, </cfif>
                        <cfif isDefined("user_patch")>`user_id`, </cfif>
                        <cfif isDefined("order_ref2")>`order_ref2`, </cfif>
                        <cfif isDefined("order_comment")>`order_comment`, </cfif>
                        <cfif isDefined("order_heritage_id_list")>`order_heritage_id_list`, </cfif>
                        `formation_id`) 
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
                    <cfif isDefined("order_status_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#order_status_id#">,</cfif>
                    <cfif isDefined("order_tva")><cfqueryparam cfsqltype="cf_sql_integer" value="#order_tva#">,</cfif>
                    <cfif isDefined("order_date")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_date,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("order_start")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("order_end")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <!---<cfif isDefined("order_close")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(order_close,'yyyy-mm-dd', 'fr')#">,</cfif>--->
                    <cfif isDefined("context_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#context_id#">,</cfif>
                    <cfif isDefined("pack_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">,</cfif>
                    <cfif isDefined("user_patch")><cfqueryparam cfsqltype="cf_sql_integer" value="#user_patch#">,</cfif>
                    <cfif isDefined("order_ref2")><cfqueryparam cfsqltype="cf_sql_varchar" value="#order_ref2#">,</cfif>
                    <cfif isDefined("order_comment")><cfqueryparam cfsqltype="cf_sql_varchar" value="#order_comment#">,</cfif>
                    <cfif isDefined("order_heritage_id_list")><cfqueryparam cfsqltype="cf_sql_varchar" value="#order_heritage_id_list#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>

                <cfset cur_order_ref = "#mid(Year(now()), 3,2)#-#return_id#">
                <cfset md = hash("#return_id#", "MD5")>
                
                
                <cfquery name="updt_order_ref" datasource="#SESSION.BDDSOURCE#">
                    UPDATE orders
                    SET order_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cur_order_ref#">,
                    order_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#md#">
                    WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn return_id>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.type#</cfoutput> : <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>








	<cffunction name="insert_order_item_package" access="public" returntype="numeric">
        <cfargument name="order_id" type="numeric" required="yes">
        <cfargument name="method_id" type="numeric" required="yes">
        <cfargument name="account_id" type="numeric" required="yes">
        <cfargument name="formation_id" type="numeric" required="no">
        <cfargument name="order_item_qty" type="numeric" required="no">
        <cfargument name="certif_id" type="numeric" required="no">
        <cfargument name="destination_id" type="numeric" required="no">
        <cfargument name="elearning_id" type="numeric" required="no">
        <cfargument name="date_begin" type="date" required="no">
        <cfargument name="date_end" type="date" required="no">

        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `order_item_package_id` FROM `order_item_package` 
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
                AND `method_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#">
                LIMIT 1
            </cfquery>
            <!---  AND `account_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#"> --->


            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO`order_item_package`(
                        `order_id`, 
                        `method_id`, 
                        <cfif isDefined("formation_id")>`formation_id`, </cfif>
                        <cfif isDefined("order_item_qty")>`hour_qty`, </cfif>
                        <cfif isDefined("certif_id")>`certif_id`, </cfif>
                        <cfif isDefined("destination_id")>`destination_id`, </cfif>
                        <cfif isDefined("elearning_id")>`elearning_id`, </cfif>
                        <cfif isDefined("date_begin")>`date_begin`, </cfif>
                        <cfif isDefined("date_end")>`date_end`, </cfif>
                        `account_id`) 
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#">,
                    <cfif isDefined("formation_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,</cfif>
                    <cfif isDefined("order_item_qty")><cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#order_item_qty#" scale="2">,</cfif>
                    <cfif isDefined("certif_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,</cfif>
                    <cfif isDefined("destination_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#destination_id#">,</cfif>
                    <cfif isDefined("elearning_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#">,</cfif>
                    <cfif isDefined("date_begin")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(date_begin,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("date_end")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(date_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset tmp = QueryGetRow(select, 1)>
                <cfset return_id = tmp.order_item_package_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `order_item_package` SET
                    <cfif isDefined("formation_id")> formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,</cfif>
                    <cfif isDefined("order_item_qty")> hour_qty = <cfqueryparam cfsqltype="cf_sql_decimal" value="#order_item_qty#" scale="2">,</cfif>
                    <cfif isDefined("certif_id")> certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#certif_id#">,</cfif>
                    <cfif isDefined("destination_id")> destination_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#destination_id#">,</cfif>
                    <cfif isDefined("elearning_id")> destination_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#">,</cfif>
                    <cfif isDefined("date_begin")> date_begin = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(date_begin,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("date_end")> date_end = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(date_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
                    WHERE `order_item_package_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn return_id>
        <cfcatch type="any">
            Error insert_order_item_package: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>






    <cffunction name="insert_order_item_invoice" access="public" returntype="numeric">
        <cfargument name="order_id" type="numeric" required="yes">
        <cfargument name="order_item_mode_id" type="numeric" required="yes">
        <cfargument name="account_id" type="numeric" required="yes">
        
        <cfargument name="item_inv_nb_users" type="numeric" required="no">
        <cfargument name="item_inv_hour" type="numeric" required="no">
        <cfargument name="item_inv_unit_price" type="numeric" required="no">
        <cfargument name="item_inv_fee" type="numeric" required="no">
        <cfargument name="item_inv_total" type="numeric" required="no">
        <cfargument name="tva" type="numeric" required="no">
        <cfargument name="user_id" type="numeric" required="no">

        <cfargument name="product_id" type="numeric" required="no">
        <cfargument name="product_name" type="string" required="no">
        <cfargument name="coupon_id" type="numeric" required="no">

        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `order_item_invoice_id` FROM `order_item_invoice` 
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
                AND `order_item_mode_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_item_mode_id#">
                LIMIT 1
            </cfquery>
            <!---  AND `f_account_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#"> --->

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO`order_item_invoice`(
                        `order_id`, 
                        `f_account_id`, 
                        <cfif isDefined("item_inv_nb_users")>`item_inv_nb_users`, </cfif>
                        <cfif isDefined("item_inv_hour")>`item_inv_hour`, </cfif>
                        <cfif isDefined("item_inv_unit_price")>`item_inv_unit_price`, </cfif>
                        <cfif isDefined("item_inv_fee")>`item_inv_fee`, </cfif>
                        <cfif isDefined("item_inv_total")>`item_inv_total`, </cfif>
                        <cfif isDefined("user_id")>`user_id`, </cfif>
                        <cfif isDefined("product_id")>`product_id`, </cfif>
                        <cfif isDefined("product_name")>`product_name`, </cfif>
                        <cfif isDefined("coupon_id")>`coupon_id`, </cfif>
                        `order_item_mode_id`) 
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_id#">,
                    <cfif isDefined("item_inv_nb_users")><cfqueryparam cfsqltype="CF_SQL_integer" value="#item_inv_nb_users#">,</cfif>
                    <cfif isDefined("item_inv_hour")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_hour#">,</cfif>
                    <cfif isDefined("item_inv_unit_price")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_unit_price#">,</cfif>
                    <cfif isDefined("item_inv_fee")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_fee#">,</cfif>
                    <cfif isDefined("item_inv_total")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_total#">,</cfif>
                    <cfif isDefined("user_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,</cfif>
                    <cfif isDefined("product_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#product_id#">,</cfif>
                    <cfif isDefined("product_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#product_name#">,</cfif>
                    <cfif isDefined("coupon_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#coupon_id#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#order_item_mode_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset tmp = QueryGetRow(select, 1)>
                <cfset return_id = tmp.order_item_invoice_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `order_item_invoice` SET
                    <cfif isDefined("item_inv_nb_users")> item_inv_nb_users = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_nb_users#">,</cfif>
                    <cfif isDefined("item_inv_hour")> item_inv_hour = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_hour#">,</cfif>
                    <cfif isDefined("item_inv_unit_price")> item_inv_unit_price = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_unit_price#">,</cfif>
                    <cfif isDefined("item_inv_fee")> item_inv_fee = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_fee#">,</cfif>
                    <cfif isDefined("item_inv_total")> item_inv_total = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_inv_total#">,</cfif>
                    <cfif isDefined("user_id")> user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,</cfif>
                    <cfif isDefined("product_id")> product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#product_id#">,</cfif>
                    <cfif isDefined("product_name")> product_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_name#">,</cfif>
                    <cfif isDefined("coupon_id")> coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#coupon_id#">,</cfif>
                    f_account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
                    WHERE order_item_invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn return_id>
        <cfcatch type="any">
            insert_order_item_invoice: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>

    


     
     



    <!--- TODO update status / ?date --->
    <!--- TODO champs INV20 --->
    <cffunction name="insert_invoice" access="public" output="false" returntype="numeric">
        <cfargument name="invoice_id" type="numeric" required="no" default="-1">

        <cfargument name="account_id" type="numeric" required="yes">
        <cfargument name="order_id" type="numeric" required="yes">
        <cfargument name="provider_id" type="numeric" required="no" default="0">
        <cfargument name="invoice_status_id" type="numeric" required="yes">

        <cfargument name="invoice_ref" type="string" required="no">
        <cfargument name="invoice_name" type="string" required="no">

        <cfargument name="invoice_paid_ref" type="string" required="no">
        <cfargument name="invoice_paid_ref_client" type="string" required="no">

        <cfargument name="invoice_date" type="date" required="no">
        <cfargument name="invoice_start" type="date" required="no">
        <cfargument name="invoice_end" type="date" required="no">
        <cfargument name="invoice_limit" type="date" required="no">
        <cfargument name="invoice_paid" type="any" required="no">

        <cfargument name="delay_id" type="numeric" required="no">
        <cfargument name="invoice_lang" type="string" required="no">

        <cfargument name="invoice_instructions" type="string" required="no">
        <cfargument name="invoice_complement" type="string" required="no">
        <cfargument name="invoice_details" type="string" required="no">

        <cfargument name="item_inv_hour" type="numeric" required="no">
        <cfargument name="item_inv_unit_price" type="numeric" required="no">
        <cfargument name="item_inv_fee" type="numeric" required="no">
        <cfargument name="item_inv_total" type="numeric" required="no">

        <cfargument name="invoice_paid_partial" type="numeric" required="no" default="0">

        <cfargument name="invoice_item_count" type="numeric" required="no">

        <cfargument name="invoice_avoir" type="numeric" required="no" default="-1">
        <cfargument name="invoice_tva_rate" type="numeric" required="no">
        <cfargument name="invoice_tva" type="numeric" required="no">

        <cfargument name="total_hc" type="numeric" required="no">
        <cfargument name="total_ttc" type="numeric" required="no">

        <cfargument name="invoice_bank_id" type="numeric" required="yes">

        <!--- TODO ajouter avoir / factu sur le form pour ref --->

        <!--- <cftry> --->

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `invoice_id` FROM `invoice` WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
            </cfquery>
        

            <cfif provider_id eq 0>
                <cfquery name="select_factu" datasource="#SESSION.BDDSOURCE#">
                    SELECT orders.`order_id`, ap.provider_id , ap.provider_tva, stva.tva_id FROM `orders` 
                    LEFT JOIN account_provider ap ON orders.provider_id = ap.provider_id 
                    LEFT JOIN settings_tva stva ON stva.tva_rate = ap.provider_tva
                    WHERE orders.`order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
                </cfquery>
            <cfelse>
                <cfquery name="select_factu" datasource="#SESSION.BDDSOURCE#">
                    SELECT ap.provider_id , ap.provider_tva, stva.tva_id FROM account_provider ap
                    LEFT JOIN settings_tva stva ON stva.tva_rate = ap.provider_tva
                    WHERE ap.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">
                </cfquery>
            </cfif>
            

            <!--- <cfoutput query="select_factu"> --->
            <cfset tmp2 = QueryGetRow(select_factu, 1)>
            <cfdump var="#tmp2#">
            <cfset provider_id  = tmp2.provider_id  neq "" ? tmp2.provider_id  : 1>
            <cfset provider_tva = tmp2.provider_tva neq "" ? tmp2.provider_tva : 20>
            <cfset provider_tva_id = tmp2.tva_id neq "" ? tmp2.tva_id : 6>
            <!--- </cfoutput> --->
            <!--- <cfdump var="#provider_id #">

            <cfdump var="#provider_tva#">
            <cfdump var="#total_hc#">
            <cfdump var="#total_ttc#"> --->



            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `invoice` (
                        `order_id`, 
                        `account_id`, 
                        `invoice_provider_id`, 
                        <cfif isDefined("delay_id")> delay_id,</cfif>
                        <cfif isDefined("invoice_ref")> invoice_ref,</cfif>
                        <cfif isDefined("total_hc")>`invoice_amount`, </cfif>
                        <cfif isDefined("total_ttc")>`invoice_amount_ttc`, </cfif>
                        <cfif isDefined("invoice_paid_partial")>`invoice_paid_partial`, </cfif>
                        <cfif isDefined("invoice_date")>`invoice_date`, </cfif>
                        <cfif isDefined("invoice_start")>`invoice_start`, </cfif>
                        <cfif isDefined("invoice_end")>`invoice_end`, </cfif>
                        <cfif isDefined("invoice_limit")> invoice_limit,</cfif>
                        <cfif isDefined("invoice_paid")> invoice_paid,</cfif>
                        <cfif isDefined("invoice_instructions")> invoice_instructions,</cfif>
                        <cfif isDefined("invoice_complement")> invoice_complement,</cfif>
                        <cfif isDefined("invoice_details")> invoice_details,</cfif>
                        <cfif isDefined("invoice_paid_ref")> invoice_paid_ref,</cfif>
                        <cfif isDefined("invoice_paid_ref_client")> invoice_paid_ref_client,</cfif>
                        <cfif isDefined("invoice_lang")> invoice_lang,</cfif>
                        invoice_tva,
                        `invoice_avoir`,
                        `invoice_bank_id`,
                        `status_id`) 
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,
                    <cfif isDefined("delay_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#delay_id#">,</cfif>
                    <cfif isDefined("invoice_ref")> <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_ref#">,</cfif>
                    <cfif isDefined("total_hc")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#total_hc#">,</cfif>
                    <cfif isDefined("total_ttc")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#total_ttc#">,</cfif>
                    <cfif isDefined("invoice_paid_partial")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#invoice_paid_partial#">,</cfif>
                    <cfif isDefined("invoice_date")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_date,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("invoice_start")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("invoice_end")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("invoice_limit")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_limit,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("invoice_paid")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_paid,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("invoice_instructions")> <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_instructions#">,</cfif>
                    <cfif isDefined("invoice_complement")><cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_complement#">,</cfif>
                    <cfif isDefined("invoice_details")><cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_details#">,</cfif>
                    <cfif isDefined("invoice_paid_ref")><cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_paid_ref#">,</cfif>
                    <cfif isDefined("invoice_paid_ref_client")><cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_paid_ref_client#">,</cfif>
                    <cfif isDefined("invoice_lang")><cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_lang#">,</cfif>
                    <cfif isdefined("invoice_tva")>
                        <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#invoice_tva#">,
                    <cfelse>
                        <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#provider_tva#">,
                    </cfif>

                    <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_avoir#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_bank_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_status_id#">
                    )
                </cfquery>


                <cfdump var="nb">

                <cfquery name="select_nb" datasource="#SESSION.BDDSOURCE#">
                    SELECT `invoice_id` FROM `invoice` WHERE MONTH(invoice_date) = MONTH(NOW())
                </cfquery>

                <cfset nb = select_nb.recordCount + 1>
                    
                <cfset cur_invoice_id = insert_res.generatedkey>
                <cfset inv_md = hash("#cur_invoice_id#", "MD5")>
                <!--- <cfdump var="#inv_md#"> --->
            </br>

                <cfif not isDefined("invoice_ref")>
                    <cfset cur_invoice_ref = "">
                    <cfif invoice_avoir neq "0"><cfset cur_invoice_ref &= "AV"></cfif>
                    <!--- * ref provider(WFR france / WG group / WDE) + WE + yy + mm + count month + 1 --->
                    <cfswitch expression="#provider_id#">
                        <cfcase value="1"> <cfset cur_invoice_ref &= "WGRP"></cfcase>
                        <cfcase value="2"> <cfset cur_invoice_ref &= "WDE"></cfcase>
                        <cfcase value="3"> <cfset cur_invoice_ref &= "WFR"></cfcase>
                    </cfswitch>
                    <cfset cur_invoice_ref &= "#DateFormat(now(), 'yy')##DateFormat(now(), 'mm')##numberFormat(nb, '00')#">
                    <cfdump var="#cur_invoice_ref#">
                <cfelse>
                    <cfdump var="#invoice_ref#">
                </cfif>
                

                <cfquery name="updt_invoice" datasource="#SESSION.BDDSOURCE#">
                    UPDATE invoice
                    SET 
                    <cfif not isDefined("invoice_ref")>
                        invoice_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cur_invoice_ref#">,
                    </cfif>
                    invoice_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#inv_md#">
                    WHERE invoice_id = #cur_invoice_id#
                </cfquery>
                
            <cfelse>

                <cfset tmp = QueryGetRow(select, 1)>
                <cfset cur_invoice_id = tmp.invoice_id>


                <cfquery datasource="#SESSION.BDDSOURCE#">
                UPDATE `invoice` SET 
                <cfif isDefined("account_id")> account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,</cfif>
                <cfif isDefined("provider_id")> invoice_provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">,</cfif>
                <cfif isDefined("delay_id")> delay_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#delay_id#">,</cfif>
                <cfif isDefined("invoice_ref")> invoice_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_ref#">,</cfif>
                <cfif isDefined("total_hc")> invoice_amount = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#total_hc#">,</cfif>
                <cfif isDefined("total_ttc")> invoice_amount_ttc = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#total_ttc#">,</cfif>
                <cfif isDefined("invoice_paid_partial")> invoice_paid_partial = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#invoice_paid_partial#">,</cfif>
                <cfif isDefined("invoice_date")> invoice_date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_date,'yyyy-mm-dd', 'fr')#">,</cfif>
                <cfif isDefined("invoice_start")> invoice_start = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                <cfif isDefined("invoice_end")> invoice_end = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                <cfif isDefined("invoice_limit")> invoice_limit = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_limit,'yyyy-mm-dd', 'fr')#">,</cfif>
                <cfif isDefined("invoice_paid")> invoice_paid = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(invoice_paid,'yyyy-mm-dd', 'fr')#">,</cfif>
                <cfif isDefined("invoice_instructions")> invoice_instructions = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_instructions#">,</cfif>
                <cfif isDefined("invoice_complement")> invoice_complement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_complement#">,</cfif>
                <cfif isDefined("invoice_details")> invoice_details = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_details#">,</cfif>
                <cfif isDefined("invoice_paid_ref")> invoice_paid_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_paid_ref#">,</cfif>
                <cfif isDefined("invoice_paid_ref_client")> invoice_paid_ref_client = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_paid_ref_client#">,</cfif>
                <cfif isDefined("invoice_lang")> invoice_lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invoice_lang#">,</cfif>
                <cfif isdefined("invoice_tva")>
                    invoice_tva = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#invoice_tva#">,
                <cfelse>
                    invoice_tva = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#provider_tva#">,
                </cfif>
                invoice_avoir = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_avoir#">,
                invoice_bank_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_bank_id#">,
                status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_status_id#">
                WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
                </cfquery>

            </cfif>


            <cfset not_del_list = "">

            hello</br>
            <cfdump var="#invoice_item_count#">
            <cfif isDefined("invoice_item_count") AND invoice_item_count neq "" AND invoice_item_count neq 0>

                <cfloop from="1" to="#invoice_item_count#" index="idx">

                    <cfif isdefined("item_name_#idx#") AND isdefined("item_inv_hour_#idx#")
                    AND isdefined("item_inv_unit_price_#idx#") AND isdefined("item_inv_fee_#idx#") AND isdefined("item_inv_total_#idx#")>

                        <cfif arguments["item_name_#idx#"] eq "" AND LSParseNumber(arguments["item_inv_hour_#idx#"]) eq 0 AND LSParseNumber(arguments["item_inv_unit_price_#idx#"]) eq 0
                        AND LSParseNumber(arguments["item_inv_fee_#idx#"]) eq 0 AND LSParseNumber(arguments["item_inv_total_#idx#"]) eq 0>
                        
                        <cfelse>
                            
                            hello</br>
                        <cfinvoke component="api/orders/orders_post" method="insert_invoice_item" returnVariable="item_new_id">

                            <cfinvokeargument name="invoice_id" value="#cur_invoice_id#">

                            <cfif isdefined("item_id_#idx#")><cfinvokeargument name="item_id" value="#arguments["item_id_#idx#"]#"> </cfif>

                            <cfif isdefined("item_name_#idx#")><cfinvokeargument name="item_inv_name" value="#arguments["item_name_#idx#"]#"></cfif>
                            <cfif isdefined("item_inv_hour_#idx#")><cfinvokeargument name="item_qty" value="#arguments["item_inv_hour_#idx#"]#"></cfif>
                            <cfif isdefined("item_nb_users_#idx#")><cfinvokeargument name="item_nb_users" value="#arguments["item_nb_users_#idx#"]#"></cfif>
                            <cfif isdefined("item_inv_unit_price_#idx#")><cfinvokeargument name="item_price_unit" value="#arguments["item_inv_unit_price_#idx#"]#"></cfif>
                            <cfif isdefined("item_inv_fee_#idx#")><cfinvokeargument name="item_price_fee" value="#arguments["item_inv_fee_#idx#"]#"></cfif>
                            <cfif isdefined("item_inv_total_#idx#")><cfinvokeargument name="item_price_total" value="#arguments["item_inv_total_#idx#"]#"></cfif>

                            <cfif isdefined("invoice_tva")>
                                <cfinvokeargument name="item_tva_rate" value="#invoice_tva#">
                            <cfelse>
                                <cfinvokeargument name="item_tva_rate" value="#provider_tva#">
                            </cfif>
                            <cfif isdefined("provider_tva_id")><cfinvokeargument name="tva_id" value="#provider_tva_id#"></cfif>

                        </cfinvoke>

                        </cfif>
                    </cfif>



                    <cfif isdefined("item_new_id")>

                        <cfif not_del_list neq "">
                            <cfset not_del_list &= ",">
                        </cfif>
                        <cfset not_del_list &= "#item_new_id#">

                    </cfif>

                    

                </cfloop>

            </br>
                <cfdump var="#cur_invoice_id#">
                <cfdump var="#not_del_list#">
                <!--- DELETING DELETED --->
                <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                    DELETE FROM `invoice_item`
                    WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_invoice_id#">
                    <cfif not_del_list neq ""> AND `item_id` NOT IN (#not_del_list#) </cfif>
                </cfquery>

            </cfif>


        <cfreturn cur_invoice_id>

        <!--- <cfcatch type="any">
            insert_invoice: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfoutput>#cfcatch.detail#</cfoutput>
            <!--- <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif> --->
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
    </cffunction>



    
    <cffunction name="insert_invoice_item" access="public" output="false" returntype="numeric">
        <cfargument name="invoice_id" type="numeric" required="yes">
        <cfargument name="item_id" type="numeric" required="no" default="-1">
        
        <cfargument name="item_inv_name" type="string" required="no">

        <cfargument name="item_nb_users" type="numeric" required="no">
        <cfargument name="item_qty" type="numeric" required="no">
        <cfargument name="item_price_unit" type="numeric" required="no">
        <cfargument name="item_price_fee" type="numeric" required="no">
        <cfargument name="item_price_total" type="numeric" required="no">

        <cfargument name="item_tva_rate" type="numeric" required="no">
        <cfargument name="tva_id" type="numeric" required="no">

        <cftry>

            <cfif item_id eq -1>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO`invoice_item`(
                        <cfif isDefined("item_inv_name")>`item_name`, </cfif>
                        <cfif isDefined("item_nb_users")>`item_nb_users`, </cfif>
                        <cfif isDefined("item_qty")>`item_qty`, </cfif>
                        <cfif isDefined("item_price_unit")>`item_price_unit`, </cfif>
                        <cfif isDefined("item_price_fee")>`item_price_fee`, </cfif>
                        <cfif isDefined("item_price_total")>`item_price_total`, </cfif>
                        <cfif isDefined("item_tva_rate")>`item_tva_rate`, </cfif>
                        <cfif isDefined("tva_id")>tva_id, </cfif>
                        `invoice_id`) 
                    VALUES
                    (
                    <cfif isDefined("item_inv_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#item_inv_name#">,</cfif>
                    <cfif isDefined("item_nb_users")><cfqueryparam cfsqltype="cf_sql_integer" value="#item_nb_users#">,</cfif>
                    <cfif isDefined("item_qty")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_qty#">,</cfif>
                    <cfif isDefined("item_price_unit")><cfqueryparam cfsqltype="cf_sql_decimal" scale="4" value="#item_price_unit#">,</cfif>
                    <cfif isDefined("item_price_fee")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_price_fee#">,</cfif>
                    <cfif isDefined("item_price_total")><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_price_total#">,</cfif>
                    <cfif isDefined("item_tva_rate")><cfqueryparam cfsqltype="cf_sql_integer" value="#item_tva_rate#">,</cfif>
                    <cfif isDefined("tva_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#tva_id#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `invoice_item` SET
                    <cfif isDefined("item_inv_name")> item_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#item_inv_name#">,</cfif>
                    <cfif isDefined("item_nb_users")> item_nb_users = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_nb_users#">,</cfif>
                    <cfif isDefined("item_qty")> item_qty = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_qty#">,</cfif>
                    <cfif isDefined("item_price_unit")> item_price_unit = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_price_unit#">,</cfif>
                    <cfif isDefined("item_price_fee")> item_price_fee = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_price_fee#">,</cfif>
                    <cfif isDefined("item_price_total")> item_price_total = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#item_price_total#">,</cfif>
                    <cfif isDefined("item_tva_rate")> item_tva_rate = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_tva_rate#">,</cfif>
                    <cfif isDefined("tva_id")> tva_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tva_id#">,</cfif>
                    invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
                    WHERE `item_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_id#">
                </cfquery>

                <cfset return_id = item_id>
            </cfif>

        <cfreturn return_id>
        <cfcatch type="any">
            insert_invoice_item: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="delete_invoice" httpMethod="POST" access="remote" returntype="numeric">
        <cfargument name="invoice_id" type="numeric" required="yes">        

        <cftry>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `invoice_item`
                WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
            </cfquery>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `invoice`
                WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_id#">
            </cfquery>

            <cfreturn 1>
        <cfcatch type="any">
            delete_invoice: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="delete_order" httpMethod="POST" access="remote" returntype="numeric">
        <cfargument name="order_id" type="numeric" required="yes">        

        <cftry>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `orders_users`
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
            </cfquery>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `order_item_invoice`
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
            </cfquery>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `order_item_package`
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
            </cfquery>

            <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM `orders`
                WHERE `order_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
            </cfquery>


            <cfreturn 1>
        <cfcatch type="any">
            delete_order: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="update_invoice_info_payed" access="remote" method="POST" returntype="numeric">
        <cfargument name="pi_id" type="numeric" required="yes">
        <cfargument name="value" type="numeric" required="yes">

        <cftry>

        <cfquery name="update_i" datasource="#SESSION.BDDSOURCE#">
            UPDATE `user_invoice_info` SET 
            user_invoice_info_payed = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#value#">
            WHERE user_invoice_info_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pi_id#">
        </cfquery>

        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>

</cfcomponent>