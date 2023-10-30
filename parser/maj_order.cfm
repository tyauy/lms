<!--- <cfabort> --->
<!--- <cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT order_id, account_id, user_id, formation_id FROM orders
</cfquery> --->
<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
    SELECT order_id, account_id, user_id, formation_id FROM orders
    WHERE `order_ref` LIKE '%_W%'
    AND order_date > "2023-03-06 00:00:00"
</cfquery>


<cfdump var="#get_order#">
<!--- <cfloop query="get_order">

    <cfquery name="get_order_item" datasource="#SESSION.BDDSOURCE#">
    SELECT order_item_id, method_id, order_item_unit_price,
    order_item_amount, order_item_amount_ttc, order_item_mode_id,
    order_item_qty, certif_id, destination_id, product_id, product_name, coupon_id
    FROM order_item WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
    </cfquery>

    <cfloop query="get_order_item">

        <cftry>
    
            <cfinvoke component="api/orders/orders_post" method="insert_order_item_invoice" returnVariable="new_id">
				<cfinvokeargument name="order_id" value="#get_order.order_id#">
				<cfinvokeargument name="account_id" value="#get_order.account_id#">
				<cfinvokeargument name="item_inv_hour" value="#order_item_qty#">
				<cfif order_item_unit_price neq ""><cfinvokeargument name="item_inv_unit_price" value="#order_item_unit_price#"></cfif>
				<!--- <cfinvokeargument name="item_inv_fee" value="#arguments["order_item_fee_amount_" & cur_mode_id]#"> --->
				<cfinvokeargument name="item_inv_total" value="#order_item_amount#">
				<!--- <cfinvokeargument name="item_inv_tva" value="#tva#"> --->
				<cfinvokeargument name="user_id" value="#get_order.user_id#">
				<cfinvokeargument name="order_item_mode_id" value="#order_item_mode_id#">
				<cfif product_id neq ""><cfinvokeargument name="product_id" value="#product_id#"></cfif>
                <cfif product_name neq ""><cfinvokeargument name="product_name" value="#product_name#"></cfif>
                <cfif coupon_id neq ""><cfinvokeargument name="coupon_id" value="#coupon_id#"></cfif>
			</cfinvoke>


            <cfif new_id neq 0>
                <cfquery name="insert_invoice" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO order_item_var SELECT
                        NULL,
                        invoice_item_id, 
                        attribute_id, 
                        variation_id, 
                        #new_id#
                    FROM order_item_var
                    WHERE order_item_id = #order_item_id#
                </cfquery>
            </cfif>
            
            <!--- <cfquery name="insert_invoice" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO order_item_invoice
            (
            order_id, 
            f_account_id, 
            item_inv_hour, 
            item_inv_unit_price, 
            item_inv_fee, 
            item_inv_total, 
            user_id,
            order_item_mode_id
            )
            VALUES (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.order_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.account_id#">,
            <cfqueryparam cfsqltype="cf_sql_decimal" value="#order_item_qty#">,
            <cfqueryparam cfsqltype="cf_sql_decimal" value="#order_item_unit_price#">,
            <cfqueryparam cfsqltype="cf_sql_decimal" value="0">,
            <cfqueryparam cfsqltype="cf_sql_decimal" value="#order_item_amount#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.user_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#order_item_mode_id#">
            )
            </cfquery> --->

            <cfcatch>
                Error get_order_item: <cfoutput>#cfcatch.message#</cfoutput>
                <cfoutput>#cfcatch.extendedInfo#</cfoutput>
                <!--- <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif> --->
            </cfcatch>
        </cftry>

        
        <cfset arr = listToArray (method_id, ",")>

        <cfloop list="#method_id#" delimiters="," index="cur_method">

            <cftry>

                <!--- <cfdump var="#get_order.order_id#">
                <cfdump var="#cur_method#">
                <cfdump var="#get_order.account_id#">
                <cfdump var="#get_order.formation_id#">
                <cfdump var="#get_order_item.order_item_qty#">
                <cfdump var="#get_order_item.certif_id#">
            </br> --->

            <cfinvoke component="api/orders/orders_post" method="insert_order_item_package">
                <cfinvokeargument name="order_id" value="#get_order.order_id#">
                <cfinvokeargument name="account_id" value="#get_order.account_id#">
                <cfinvokeargument name="method_id" value="#cur_method#">
                <cfinvokeargument name="formation_id" value="#get_order.formation_id#">
                <cfif destination_id neq ""><cfinvokeargument name="destination_id" value="#destination_id#"></cfif>
                <cfinvokeargument name="formation_id" value="#get_order.formation_id#">

                <cfif get_order_item.order_item_qty neq ""> <cfinvokeargument name="order_item_qty" value="#get_order_item.order_item_qty#"> </cfif>
                <cfif get_order_item.certif_id neq ""> <cfinvokeargument name="certif_id" value="#get_order_item.certif_id#"> </cfif>

                <!--- <cfif pack_id neq ""> <cfinvokeargument name="pack_id" value="#pack_id#"> </cfif> --->
            </cfinvoke>

            <!--- <cfquery name="insert_package" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO order_item_package
                (
                order_id, 
                method_id, 
                account_id,
                <cfif get_order_item.certif_id neq "">certif_id,</cfif>
                <cfif get_order_item.order_item_qty neq "">hour_qty,</cfif>
                formation_id
                )
                VALUES (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.order_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_method#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.account_id#">,
                
                <cfif get_order_item.certif_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#get_order_item.certif_id#">,</cfif>
                <cfif get_order_item.order_item_qty neq ""><cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#get_order_item.order_item_qty#">,</cfif>
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.formation_id#">
                )
                </cfquery> --->

            <cfcatch>
                Error insert_package: <cfoutput>#cfcatch.message#</cfoutput>
                <cfoutput>#cfcatch.extendedInfo#</cfoutput>
                <!--- <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif> --->
            </cfcatch>
            </cftry>
            
        </cfloop>


        
    </cfloop>

</cfloop> --->
