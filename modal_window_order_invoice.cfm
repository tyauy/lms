<cfif isdefined("o_id") AND isdefined("a_id")>
<cfsilent>

    <!--- <cfset SESSION.INVOICE_GO_BACK_URL = cgi.HTTP_REFERER> --->

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
        SELECT `account_id`, `account_name` FROM `account`
        WHERE `account_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
    </cfquery>

    <cfoutput query="get_account">

        <cfset _account_id = account_id>
        <cfset _account_name = account_name>
	</cfoutput>
    
    <cfquery name="get_invoice_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT `status_id`, `status_name`, `status_title`, `status_color`, `status_css` FROM invoice_status
    </cfquery>

    <cfquery name="get_invoice_delay" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT `delay_id`, `delay_name`, `delay_dday` FROM `settings_delay`
    </cfquery>

    <cfquery name="get_settings_tva" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT `tva_id`, `tva_rate` FROM settings_tva
    </cfquery>

    <cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT ap.provider_id, ap.provider_name, ap.provider_code, ap.provider_tva 
        FROM account_provider ap 
        INNER JOIN orders o ON ap.provider_id = o.provider_id 
        WHERE o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
    </cfquery>

    <cfif get_provider.recordCount eq 0>

        <cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
            SELECT ap.provider_id, ap.provider_name, ap.provider_code, ap.provider_tva 
            FROM account_provider ap 
            INNER JOIN account a ON a.provider_id = ap.provider_id
            INNER JOIN orders o ON a.account_id = o.account_id 
            WHERE o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
        </cfquery>

    </cfif>
    
    <cfset invoice_bank_id = 1>

    <cfif get_provider.recordCount GT 0>
    <cfset cur_provider = QueryGetRow(get_provider, 1)>
    <cfset invoice_tva = cur_provider.provider_tva>
    

    <cfquery name="get_bank" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT a.bank_id, a.provider_id, a.bank_name, a.bank_iban, a.bank_swift, ap.provider_name FROM account_bank a
        INNER JOIN account_provider ap ON ap.provider_id = a.provider_id
        ORDER BY bank_id ASC
    </cfquery>
    <!--- WHERE provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_provider.provider_id#"> --->

    <cfquery name="get_bank_default" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT a.bank_id FROM account_bank a
        WHERE a.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_provider.provider_id#">
        ORDER BY bank_id ASC
        LIMIT 1
    </cfquery>

    <cfset invoice_bank_id = get_bank_default.bank_id>

    </cfif>



    <cfset nb_users = 1>
    <cfset item_inv_hour = 0>
    <cfset item_inv_unit_price = 0>
    <cfset item_inv_fee = 0>
    <cfset item_inv_total = 0>

    <cfif isDefined("i_id")>
        
        <cfquery name="get_invoice" datasource="#SESSION.BDDSOURCE#">
            SELECT `status_id`, `delay_id`, `invoice_ref`, `invoice_md`, `invoice_amount`, `invoice_amount_ttc`, `invoice_paid_partial`, `invoice_date`, `invoice_start`, `invoice_end`, `invoice_limit`, `invoice_paid`, `invoice_name`, 
            `invoice_instructions`, `invoice_complement`, `invoice_details`, `invoice_paid_ref`, `invoice_paid_ref_client`, `invoice_bank_id`, `invoice_provider_id`, `invoice_tva`, `invoice_avoir`, `invoice_lang`
            FROM `invoice` 
            WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#i_id#">
         </cfquery>	
     
         <cfoutput query="get_invoice">

            <cfset invoice_status_id = status_id>
            <cfset invoice_bank_id = invoice_bank_id>
            <cfif get_invoice.invoice_tva neq "">
                <cfset invoice_tva = get_invoice.invoice_tva>
            </cfif>
            <cfset invoice_avoir = get_invoice.invoice_avoir>
             
            <cfset invoice_instructions = invoice_instructions>
            <cfset invoice_complement =invoice_complement>
            <cfset invoice_details = invoice_details>
             
            <cfset invoice_paid_ref = invoice_paid_ref>
            <cfset invoice_paid_ref_client = invoice_paid_ref_client>

            <cfset invoice_paid_partial = invoice_paid_partial>
             
            <cfset invoice_ref = invoice_ref>
            <cfset invoice_name = invoice_name>

            <cfif not isDefined("user_lang")>
                <cfset user_lang = invoice_lang>
            </cfif>
            <cfif invoice_provider_id neq "">

                <cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
                    SELECT ap.provider_id, ap.provider_name, ap.provider_code, ap.provider_tva 
                    FROM account_provider ap 
                    WHERE ap.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#invoice_provider_id#">
                </cfquery>
                <cfset cur_provider = QueryGetRow(get_provider, 1)>
                <cfif get_invoice.invoice_tva eq "">
                    <cfset invoice_tva = cur_provider.provider_tva>
                </cfif>
            </cfif>
             
            <cfset invoice_date = LSDateFormat(invoice_date,'dd/mm/yyyy', 'fr')>
            <cfset invoice_delay_id = delay_id>
            <cfset invoice_limit = LSDateFormat(invoice_limit,'dd/mm/yyyy', 'fr')>
            <cfset invoice_paid = LSDateFormat(invoice_paid,'dd/mm/yyyy', 'fr')>
            <cfset invoice_start = LSDateFormat(invoice_start,'dd/mm/yyyy', 'fr')>
            <cfset invoice_end = LSDateFormat(invoice_end,'dd/mm/yyyy', 'fr')>
     
        </cfoutput>


        <cfquery name="get_invoice_item" datasource="#SESSION.BDDSOURCE#">
            SELECT `item_id`, `product_id`, `item_nb_users`, `item_qty`, `item_price_unit`, `item_price_fee`, `item_price_total`, `invoice_id`, `item_name`, `tva_id`, `item_unit`, `item_tva_rate`, `item_cpn` 
            FROM `invoice_item` 
            WHERE `invoice_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#i_id#">
        </cfquery>
      
        <cfoutput>
            <cfset invoice_item_count = get_invoice_item.recordCount>


        </cfoutput>

        <cfif get_invoice_item.recordCount neq 0>

            <cfset first_invoice_default = QueryGetRow(get_invoice_item, 1)>

            <cfset item_name = first_invoice_default.item_name>
            <cfset nb_users = first_invoice_default.item_nb_users>
            <cfset item_inv_hour = first_invoice_default.item_qty>
            <cfset item_inv_unit_price = first_invoice_default.item_price_unit>
            <cfset item_inv_fee = first_invoice_default.item_price_fee>
        </cfif>
        

        

    <cfelse>

            <cfset invoice_status_id = 8>

            <cfset invoice_instructions = "">
            <cfset invoice_complement = "">
            <cfset invoice_details = "">
             
            <cfset invoice_paid_ref = "">
            <cfset invoice_paid_ref_client = "">
     
             
            <cfset invoice_ref = "">
            <cfset invoice_name = "">
            <cfset invoice_avoir = 0>
            <cfset invoice_delay_id = 1>
            <cfset invoice_paid_partial = 0>

     
             
            <cfset invoice_date = LSDateFormat(now(),'dd/mm/yyyy', 'fr')>

            <cfif not isDefined("user_lang")>
                <cfset user_lang = cur_provider.provider_code>
            </cfif>

            <cfset invoice_item_count = 1>

            <cfif isdefined("o_id") AND isdefined("mode")>
                <cfquery name="get_order_item_invoice" datasource="#SESSION.BDDSOURCE#">
                    SELECT oi.item_inv_hour, oi.item_inv_unit_price, oi.item_inv_fee, oi.item_inv_total, a.account_name, item_inv_nb_users,
                    o.order_start, o.order_end, o.formation_id, lf.formation_name_#user_lang# as formation_name, o.order_ref2, o.order_tva
                    FROM order_item_invoice oi
                    INNER JOIN orders o ON oi.order_id = o.order_id
                    LEFT JOIN account a ON oi.f_account_id = a.account_id
                    LEFT JOIN lms_formation lf ON o.formation_id = lf.formation_id
                    WHERE oi.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#"> AND oi.order_item_mode_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mode#">
                </cfquery>
                <cfoutput query="get_order_item_invoice">

                    <cfset nb_users = item_inv_nb_users>
                    <cfset item_inv_hour = item_inv_hour>
                    <cfset item_inv_unit_price = item_inv_unit_price>
                    <cfset item_inv_fee = item_inv_fee neq "" ? item_inv_fee : 0>
                    <cfset item_inv_total = item_inv_total>

                    <cfset invoice_limit = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')>
                    <!--- <cfset invoice_paid = LSDateFormat(order_end, 'dd/mm/yyyy', 'fr')> --->
                    <cfset invoice_start = LSDateFormat(order_start, 'dd/mm/yyyy', 'fr')>
                    <cfset invoice_end = LSDateFormat(order_end, 'dd/mm/yyyy', 'fr')>

                    <cfset cur_formation_name = formation_name>
                    
                    <cfset invoice_paid_ref_client = order_ref2>

                    <cfif order_tva neq "">
                        <cfset invoice_tva = order_tva>
                    </cfif>

                </cfoutput>
                

            <cfelse>

                <cfset invoice_limit = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')>
                <!--- <cfset invoice_paid = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')> --->
                <cfset invoice_start = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')>
                <cfset invoice_end = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')>
            </cfif>

            <cfif isDefined("cur_provider")>            
                <cfswitch expression="#cur_provider.provider_id#">
                    <cfcase value="1"> <cfset invoice_ref &= "WGRP"></cfcase>
                    <cfcase value="2"> <cfset invoice_ref &= "WDE"></cfcase>
                    <cfcase value="3"> <cfset invoice_ref &= "WFR"></cfcase>
                </cfswitch>
            </cfif>

        <cfquery name="select_nb" datasource="#SESSION.BDDSOURCE#">
            SELECT `invoice_id` FROM `invoice` WHERE MONTH(invoice_date) = MONTH(NOW())
        </cfquery>

        <cfset nb = select_nb.recordCount + 2>     

        <cfset invoice_ref &= "#DateFormat(now(), 'yy')##DateFormat(now(), 'mm')##numberFormat(nb, '00')#">
        <!--- <cfdump var="#cur_invoice_ref#"> --->

            
            
    </cfif>

    <cfif nb_users eq "">
        <cfset nb_users = 1>
    </cfif>

    <cfif user_lang eq "">
        <cfset user_lang = SESSION.LANG_CODE>
    </cfif>

    <cfquery name="get_order_info" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT a.account_name, a.account_id, lf.formation_name_#user_lang# as formation_name
        FROM orders o 
        INNER JOIN account a ON a.account_id = o.account_id
        LEFT JOIN lms_formation lf ON o.formation_id = lf.formation_id 
        WHERE o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
    </cfquery>

<cfquery name="get_all_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT account_name, account_id FROM account a ORDER BY account_name ASC
</cfquery>
<cfquery name="get_provider_list" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT provider_id, provider_name FROM account_provider
</cfquery>
    
    <cfset order_info = QueryGetRow(get_order_info, 1)>
    
    <cfset item_default_name = "">

    <cfquery name="get_order_package" datasource="#SESSION.BDDSOURCE#">
        SELECT oip.method_id, llm.method_name_#user_lang# as method_name, 
        oip.hour_qty, llc.certif_name, lld.destination_name, lle.elearning_name
        FROM order_item_package oip
        LEFT JOIN lms_list_certification llc ON oip.certif_id = llc.certif_id
        LEFT JOIN lms_list_destination lld ON oip.destination_id = lld.destination_id
        LEFT JOIN lms_list_elearning lle ON oip.elearning_id = lle.elearning_id
        LEFT JOIN lms_lesson_method llm ON oip.method_id = llm.method_id

        WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">

    </cfquery>

    <cfset item_default_name = "">

    <cfif isDefined("order_info.formation_name")><cfset item_default_name &= "#order_info.formation_name#"></cfif>


    <!--- <cfloop query="get_order_package">
        <cfif hour_qty neq "">
            <cfset item_default_name&= "#hour_qty# h ">
        </cfif> --->


        <cfloop query="get_order_package"> 
            <cfset temp =  "#ucase(method_name)# ">
            
            <cfif hour_qty eq ""><cfset hour_qty = 0></cfif>

            <cfif method_id eq "1">
                <cfset temp &= "#hour_qty# #obj_translater.get_translate('short_hours',user_lang)#">
            <cfelseif method_id eq "3">
                <cfset temp &= "#ucase(elearning_name)# #hour_qty/30#">
                <cfif (hour_qty/30) GT 1>
                    <cfset temp &= " #obj_translater.get_translate('short_months',user_lang)#">
                <cfelse>
                    <cfset temp &= " #obj_translater.get_translate('short_month',user_lang)#">
                </cfif>
                
            <cfelseif method_id eq "7">
                <cfset temp &= "#ucase(certif_name)#">
            </cfif>

                <cfset item_default_name &= " - #temp#">
        </cfloop>

    
    

    <!--- GET USERS --->
    <cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
        SELECT u.user_id, u.user_name, u.user_firstname
        FROM orders_users ou
        LEFT JOIN user u ON u.user_id = ou.user_id
        WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
    </cfquery>

    <!--- <cfset nb_users = get_orders_users.recordCount> --->
    <cfset item_default_list_user = "">
    <cfoutput query="get_orders_users">
        <cfif currentRow GT 1> <cfset item_default_list_user &= ","> </cfif>
        <cfset item_default_list_user &= "#uCase(user_name)# #user_firstname#">
    </cfoutput>

    
    <cfset order_start = LSDateFormat(now(),'dd/mm/yyyy', 'fr')>
    <cfif invoice_limit eq "">
        <cfset invoice_limit = LSDateFormat(now(), 'dd/mm/yyyy', 'fr')>

    </cfif>

</cfsilent>



<!--- <cfdump var="#cgi#"> --->

<form action="updater_order.cfm" name="form_invoice" method="post">
    <cfoutput>#o_id#</cfoutput>
    <div class="row">

        <div class="col-md-2">
            <cfoutput><span class="btn btn-sm btn-info text-white btn_read_order" id="o_#o_id#" style="cursor:pointer"><i class="fal fa-backward"></i> BACK</span></cfoutput>
        </div>
        <div class="col-md-4">
            <select name="invoice_lang" class="form-control form-control-sm user_lang_form" id="user_lang_form">
                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
                    <cfoutput>
                        <option value="#cor#" <cfif cor eq "#user_lang#">selected</cfif>>#ucase(cor)#</option>
                    </cfoutput>
                </cfloop>
            </select>
        </div>
        <div class="col-md-4">
            <button type="button" class="update_form_users btn btn-sm btn-info text-white" id="update_form_users">by users</button>
            <button type="button" class="list_users btn btn-sm btn-info text-white" id="list_users">List users</button>
        </div>
    
        <div class="col-md-2">
            <label>Avoir</label>
            <input type="checkbox" class="m-1 form-check-input" id="invoice_avoir_check" value="0">
        </div>
    </div>

    <div class="row">
                                    
        <div class="col-md-6">
            <div class="bg-light p-2 m-1 border">
                <h6 align="center" class="text-info">Info</h6>
                <br>
            
                <table class="table table-sm table-bordered bg-white">
                    <tr>
                        <td width="30%"><label>N° Facture Wefit</label></td>
                        <td>
                        <!--- <cfoutput>#invoice_ref#</cfoutput> --->
                        <input type="text" class="form-control" name="invoice_ref" id="invoice_ref" value="<cfoutput>#invoice_ref#</cfoutput>">
                        </td>
                    </tr>
                    <tr>
                        <td><label>Destinataire</label></td>
                        <td>
                        <!--- <cfoutput>#account_name#</cfoutput> --->
                        <select name="account_id" id="account_id" class="form-control form-control-sm">
                            <cfoutput>
                            <cfloop query="get_all_account">
                                <option value="#get_all_account.account_id#" class="account-#get_all_account.account_id# font-weight-bold" <cfif get_all_account.account_id eq _account_id>selected</cfif>>#get_all_account.account_name#</option>
                            </cfloop>
                            </cfoutput>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Provider</label></td>
                        <td>
                            <cfif isDefined("cur_provider")>
                                <!--- <cfoutput>#cur_provider.provider_name#</cfoutput> --->

                                <select name="provider_id" id="provider_id" class="form-control form-control-sm">
                                    <cfoutput>
                                    <cfloop query="get_provider_list">
                                        <option value="#get_provider_list.provider_id#" class="account-#get_provider_list.provider_id# font-weight-bold" <cfif get_provider_list.provider_id eq cur_provider.provider_id>selected</cfif>>#get_provider_list.provider_name#</option>
                                    </cfloop>
                                    </cfoutput>
                                </select>

                                <!--- <cfselect class="form-control form-control-sm" id="provider_id_select" name="provider_id" query="get_provider_list" display="provider_name" value="provider_id" selected="#cur_provider.provider_id#"></cfselect> --->
                            </cfif>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Account</label></td>
                        <td>
                        <cfoutput>#order_info.account_name#</cfoutput>
                        </td>
                    </tr>
                </table>

                <table class="table table-sm table-bordered bg-white">
                    <tr>
                        <td width="30%"><label>Statut</label></td>
                        <td>
                        <select name="invoice_status_id" class="form-control form-control-sm">
                        <cfoutput>
                        <cfloop query="get_invoice_status">
                        <option value="#status_id#" class="text-#status_css# font-weight-bold" <cfif invoice_status_id eq status_id>selected</cfif>>#status_name#</option>
                        </cfloop>
                        </cfoutput>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Bank</label></td>
                        <td>
                        <select name="invoice_bank_id" class="form-control form-control-sm">
                        <cfoutput>
                        <cfif isDefined("cur_provider")>
                            <cfloop query="get_bank">
                            <option value="#bank_id#" class="font-weight-bold" <cfif invoice_bank_id eq bank_id>selected</cfif>>#provider_name# - #bank_name#</option>
                            </cfloop>
                        </cfif>
                        </cfoutput>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td>TVA</td>
                        <td>
                            <select name="invoice_tva" id="invoice_tva" class="form-control form-control-sm invoice_tva">
                                <cfloop query="get_settings_tva">
                                    <cfoutput>
                                        <option value="#tva_rate#" <cfif tva_rate eq "#invoice_tva#">selected</cfif>>
                                            <cfif tva_rate neq "0">
                                                #tva_rate#
                                            <cfelse>
                                                N/A
                                            </cfif>
                                        </option>
                                    </cfoutput>
                                </cfloop>
                            </select>
                            <!--- <input type="number" name="invoice_tva" id="invoice_tva" class="form-control form-control-sm" value="<cfoutput>#invoice_tva#</cfoutput>"> --->
                        </td>
                    </tr>
                    <!--- <tr>
                        <td><label>invoice_name</label></td>
                        <td><input type="text" name="invoice_name" class="form-control form-control-sm" value="<cfoutput>#invoice_name#</cfoutput>"></td>
                    </tr> --->
                    <tr>
                    </tr>		
                    
                    <tr>
                        <td><label>Réf/N° Client</label></td>
                        <td><!---<cfdump var="#get_order#">--->
                            <input type="text" name="invoice_paid_ref_client" class="form-control form-control-sm" value="<cfoutput>#invoice_paid_ref_client#</cfoutput>"></td>
                    </tr>
                    
                </table>

            </div>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-12">
                    <div class="bg-light p-2 m-1 border">
                        <h6 align="center" class="text-info">Dates</h6>
                        <br>

                        <table class="table table-sm table-bordered bg-white">

                            <tr>
                                <td width="35%"><label>Date Emission</label></td>
                                <td>
                                    <div class="controls">
                                        <div class="input-group">
                                            <input id="invoice_date" name="invoice_date" type="text" class="datepicker form-control" value="<cfoutput>#invoice_date#</cfoutput>" />
                                            <label for="invoice_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                        </div>
                                    </div>					
                                
                                </td>
                            </tr>	

                        </table>
                            

                        <table class="table table-sm table-bordered bg-white">
                            <tr>
                                <td width="35%"><label>Début Période</label></td>
                                <td>
                                    <div class="controls">
                                        <div class="input-group">
                                            <input id="invoice_start" name="invoice_start" type="text" class="datepicker form-control" value="<cfoutput>#invoice_start#</cfoutput>" />
                                            <label for="invoice_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                        </div>
                                    </div>							
                                </td>
                            </tr>
                            <tr>
                                <td><label>Fin Période</label></td>
                                <td>
                                    <div class="controls">
                                        <div class="input-group">
                                            <input id="invoice_end" name="invoice_end" type="text" class="datepicker form-control" value="<cfoutput>#invoice_end#</cfoutput>" />
                                            <label for="invoice_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                        </div>
                                    </div>							
                                </td>
                            </tr>
                        </table>

                        <table class="table table-sm table-bordered bg-white">
                            <tr>
                                <td width="35%"><label>Délai Paiement</label></td>
                                <td>
                                <select name="delay_id" id="delay_id" class="form-control form-control-sm">
                                <cfoutput>
                                <cfloop query="get_invoice_delay">
                                <option value="#delay_id#" name="#delay_dday#" class="font-weight-bold" <cfif delay_id eq invoice_delay_id>selected</cfif>>#delay_name#</option>
                                </cfloop>
                                </cfoutput>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Date limite Paiement</label></td>
                                <td>
                                    <div class="controls">
                                        <div class="input-group">
                                            <input id="invoice_limit" name="invoice_limit" type="text" class="datepicker form-control" value="<cfoutput>#invoice_limit#</cfoutput>" />
                                            <label for="invoice_limit" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                        </div>
                                    </div>							
                                </td>
                            </tr>
                        </table>

                        <table class="table table-sm table-bordered bg-white">
                            <tr>
                                <td width="35%"><label>Paid Date</label></td>
                                <td>
                                    <div class="controls">
                                        <div class="input-group">
                                            <input id="invoice_paid" name="invoice_paid" type="text" class="datepicker form-control" value="<cfif isDefined("invoice_paid")><cfoutput>#invoice_paid#</cfoutput></cfif>" />
                                            <label for="invoice_paid" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
                                        </div>
                                    </div>							
                                </td>
                            </tr>     
                            
                            <tr>
                                <td><label>Paid Comment</label></td>
                                <td><input type="text" name="invoice_paid_ref" class="form-control form-control-sm" value="<cfoutput>#invoice_paid_ref#</cfoutput>"></td>
                            </tr>

                            <tr>
                                <td><label>Paid Amount</label></td>
                                <td><input type="number" step="any" name="invoice_paid_partial" id="invoice_paid_partial" class="form-control form-control-sm" value="<cfif isDefined("invoice_paid_partial")><cfoutput>#invoice_paid_partial#</cfoutput></cfif>"></td>
                            </tr>


                        </table>
                    </div>
                </div>

            <!--- <div class="col-md-12">
                <div class="bg-light p-2 m-1 border">
                    <h6 align="center" class="text-info"></h6>
                    <br>

                </div>
            </div> --->
        </div>
    </div>
</div>
<div class="row">
                                    
        <div class="col-md-12">
            <div class="bg-light p-2 m-1 border">
                <h6 align="center" class="text-info">Détails facture <a type="button" class="btn btn-sm btn-info add_invoice_item" id="add_invoice_item"><i class="fal fa-plus"></i></a>
                </h6>
                
                <br>       

                <table  id="container_invoice_item" class="table table-sm table-bordered bg-white">
                    <tr bgcolor="#ECECEC">
                        <th>#</th>
                        <th class="col-sm-12 col-md-6" style="text-align:center !important;"><label>Désignation</label></th>
                        <th class="col-sm-12 col-md-1" style="text-align:center !important;"><label>Learners</label></th>
                        <th class="col-sm-12 col-md-1" style="text-align:center !important;"><label>H</label></th>
                        <th class="col-sm-12 col-md-1" style="text-align:center !important;"><label>P.U.</label></th>
                        <th class="col-sm-12 col-md-1" style="text-align:center !important;"><label>Fee</label></th>
                        <!--- <th><label>item_tva_rate</label></th> --->
                        <th class="col-sm-12 col-md-2" style="text-align:center !important;"><label>Total</label></th>
                        <th class="col-sm-12 col-md-1" style="text-align:center !important;"><label>-</label></th>

                        <th></th>
                    </tr>
                    
                        <cfif isDefined("i_id")>
                            <cfloop query="get_invoice_item">
                                <cfoutput>
                                <tr class="nbr_invoice_item_tr">
                                    <td>#get_invoice_item.currentRow#</td>
                                    <td><input type="text" name="item_name_#get_invoice_item.currentRow#" id="item_name_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_name#</cfoutput>"></td>
                                    <td><input type="number" step="any" name="item_nb_users_#get_invoice_item.currentRow#" id="item_nb_users_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_nb_users#</cfoutput>"></td>
                                    <td><input type="number" step="any" name="item_inv_hour_#get_invoice_item.currentRow#" id="item_inv_hour_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_qty#</cfoutput>"></td>
                                    <td><input type="number" step="any" name="item_inv_unit_price_#get_invoice_item.currentRow#" id="item_inv_unit_price_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_price_unit#</cfoutput>"></td>
                                    <td><input type="number" step="any" name="item_inv_fee_#get_invoice_item.currentRow#" id="item_inv_fee_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_price_fee#</cfoutput>"></td>
                                    <!--- <td><input type="number" step="any" name="item_tva_rate_#get_invoice_item.currentRow#" id="item_tva_rate_#get_invoice_item.currentRow#" class="item_tva_rate_#get_invoice_item.currentRow# form-control form-control-sm" value="<cfoutput>item_tva_rate</cfoutput>"></td> --->
                                    <td><input type="number" step="any" name="item_inv_total_#get_invoice_item.currentRow#" id="item_inv_total_#get_invoice_item.currentRow#" class="form-control form-control-sm" value="<cfoutput>#item_price_total#</cfoutput>"></td>
                                    <td><button class="btn btn-info btn-sm remove_item_line" id="reset_#get_invoice_item.currentRow#"><i class="fal fa-trash-alt"></i></button></td>
                                    <input type="hidden" name="item_id_#get_invoice_item.currentRow#" value="#item_id#">
                                </tr>
                                </cfoutput>
                            </cfloop>
                        <cfelse>
                            <tr class="nbr_invoice_item_tr">
                                <td>1</td>
                                <td><input type="text" name="item_name_1" id="item_name_1" class="form-control form-control-sm" value="<cfoutput>#item_default_name#</cfoutput>"></td>
                                <td><input type="number" step="any" name="item_nb_users_1" id="item_nb_users_1" class="form-control form-control-sm" value="<cfoutput>#nb_users#</cfoutput>"></td>
                                <td><input type="number" step="any" name="item_inv_hour_1" id="item_inv_hour_1" class="form-control form-control-sm" value="<cfoutput>#item_inv_hour#</cfoutput>"></td>
                                <td><input type="number" step="any" name="item_inv_unit_price_1" id="item_inv_unit_price_1" class="form-control form-control-sm" value="<cfoutput>#item_inv_unit_price#</cfoutput>"></td>
                                <td><input type="number" step="any" name="item_inv_fee_1" id="item_inv_fee_1" class="form-control form-control-sm" value="<cfoutput>#item_inv_fee#</cfoutput>"></td>
                                <!--- <td><input type="number" step="any" name="item_tva_rate_1" id="item_tva_rate_1" class="form-control form-control-sm" value="<cfoutput>item_tva_rate</cfoutput>"></td> --->
                                <td><input type="number" step="any" name="item_inv_total_1" id="item_inv_total_1" class="form-control form-control-sm" value="<cfoutput>#item_inv_total#</cfoutput>"></td>
                                <td><button class="btn btn-info btn-sm remove_item_line" id="reset_1"><i class="fal fa-trash-alt"></i></button></td>
                                <input type="hidden" name="item_id_1" value="-1">
                            </tr>
                        </cfif>


                        <tr bgcolor="#ECECEC">
                            <td></td>
                            <td colspan="5" align="right"><label><strong>TOTAL HT</strong></label></td>
                            <td align="right"><strong><label id="total_hc_label"></label> &euro;</strong>
                                 
                                 <input type="hidden" name="total_hc" id="total_hc" value="0">
                                <!--- <label id="total_hc"></label> --->
                            </td>
                            <td></td>
                        </tr>
                        <tr bgcolor="#ECECEC">
                            <td></td>
                            <td colspan="5" align="right"><label>TVA &nbsp;</label><label id="tva_reminder">
                                <cfoutput>
                                <cfif invoice_tva neq "0">
                                    #invoice_tva#
                                <cfelse>
                                    N/A
                                </cfif>
                                </cfoutput>
                                </label> %</td>
                            <td align="right"><label id="total_tva_label"></label>
                                <input type="hidden" name="total_tva" id="total_tva" value="0"> &euro;
                                <!--- <label id="total_tva"></label> --->
                            </td>
                            <td></td>
                        </tr>
                        <tr bgcolor="#ECECEC">
                            <td></td>
                            <td colspan="5" align="right"><label>TOTAL TTC</label></td>
                            <td align="right"><label id="total_ttc_label"></label>
                                <input type="hidden" name="total_ttc" id="total_ttc" value="0"> &euro;
                            </td>
                            <td></td>
                        </tr>
                </table>

                <div align="right">
                    <a type="button" class="total_invoice_item btn btn-sm btn-info text-white" id="total_invoice_item">Total</i></a>
                    <a type="button" class="reset_invoice_item btn btn-sm btn-info text-white" id="reset_invoice_item">Reset</i></a>
                </div>
                
            </div>
        </div>
    </div>
    <div class="row">
                                    
        <div class="col-md-12">
            <div class="bg-light p-2 m-1 border">
                <h6 align="center" class="text-info">Commentaires / Instructions spéciales</h6>
                <br>
            
                <table class="table table-sm table-bordered bg-white">
                    <tr>
                        <td><textarea type="text" name="invoice_instructions" class="form-control form-control-sm"><cfoutput>#invoice_instructions#</cfoutput></textarea></td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-12" align="center">
          
            <cfoutput>
            <input type="hidden" name="order_id" value="#o_id#">
            <input type="hidden" name="invoice_item_count" id="invoice_item_count" value="#invoice_item_count#">
            <input type="hidden" name="a_id" value="#order_info.account_id#">
            <!--- <input type="hidden" name="account_id" value="#_account_id#"> --->
            <input type="hidden" name="_invoice_form" value="1">
            <input type="hidden" name="invoice_avoir" id="invoice_avoir" value="0">
            <!--- <input type="hidden" name="provider_id" value="#get_provider.provider_id#"> --->
            

            <input type="submit" class="btn btn-success" value="Enregistrer">
            <cfif isdefined("i_id")>
                <input type="hidden" name="invoice_id" value="#i_id#">
                <input type="hidden" name="_maj_order" value="1">
                <td><a type="button" target="_blank" href="./tpl/invoice_container.cfm?a_id=#a_id#&i_id=#i_id#&user_lang=fr"><i class="far fa-download"></i></a></td>
            </cfif>
            </cfoutput>


            

        </div>
    </div>
</form>
<script>
    $(document).ready(function() {

        <cfif invoice_avoir eq "1">
            $('#invoice_avoir_check').prop('checked', true);
            $("#invoice_avoir").val(1);
        </cfif>

        var delay = 0;

        $( "#delay_id" ).change(function(event) {
            var val = $(event.target).find('option:selected').attr("name");

            var date = $('#invoice_date').datepicker('getDate');
            // var nextDayDate = new Date();
            // nextDayDate.setDate(date.getDate() + parseInt(val));
            date.setDate(date.getDate() + parseInt(val));
            $('#invoice_limit').datepicker('setDate', moment(date, 'dd/mm/yy').toDate());

            delay = parseInt(val);
        });

        
        $( "#invoice_avoir_check" ).change(function(event) {
            // var val = $(event.target).val();

            var inv_item_index = $('#container_invoice_item tr').length - 3;
            
            for (let index = 0; index < inv_item_index; index++) {
                $("#item_inv_unit_price_"+ index).val((parseFloat($("#item_inv_unit_price_"+ index).val()) * -1).toFixed(2));

                $("#item_inv_fee_"+ index).val((parseFloat($("#item_inv_fee_"+ index).val()) * -1).toFixed(2));

            }

            $("#invoice_avoir").val($("#invoice_avoir").val() == 0 ? 1 : 0);

            $("#total_invoice_item").trigger("click");
           
        });

    
    
        $("#total_invoice_item").click(function () {
            var inv_item_index = $('#container_invoice_item tr').length - 3;

            var total = 0;
            
            for (let index = 0; index < inv_item_index; index++) {

                if ($("#item_inv_hour_"+ index).val() || $("#item_inv_unit_price_"+ index).val()) {

                    var nb_user = parseFloat($("#item_nb_users_"+ index).val() ? $("#item_nb_users_"+ index).val() : 1);
                    var nb_hour = parseFloat($("#item_inv_hour_"+ index).val() ? $("#item_inv_hour_"+ index).val() : 1)
                    var unitp = parseFloat($("#item_inv_unit_price_"+ index).val() ? $("#item_inv_unit_price_"+ index).val() : 1);
                    
                    var fee = parseFloat($("#item_inv_fee_"+ index).val());

                    $("#item_inv_total_"+ index).val((nb_user * ((nb_hour*unitp) + fee)).toFixed(2));
                    total += (nb_user * ((nb_hour*unitp) + fee));
                }
             
            }
            

            $("#total_hc").val(total.toFixed(2));
            $("#total_hc_label").text(total.toFixed(2));
            $("#total_tva").val((total * (parseFloat($("#invoice_tva").val() / 100) )).toFixed(2));
            $("#total_tva_label").text((total * (parseFloat($("#invoice_tva").val() / 100) )).toFixed(2));
            $("#tva_reminder").text($("#invoice_tva").val() == 0 ? "N/A" : $("#invoice_tva").val());
            // $("#tva_reminder").text($("#invoice_tva").val());
            $("#total_ttc").val((parseFloat(total) + (total * (parseFloat($("#invoice_tva").val() / 100) ))).toFixed(2));
            $("#total_ttc_label").text((parseFloat(total) + (total * (parseFloat($("#invoice_tva").val() / 100) ))).toFixed(2));
        })

        $("#total_invoice_item").trigger("click");
        

        $('.btn_read_order').click(function(event) {
            event.preventDefault();		
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var o_id = idtemp[1];
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("Edition order "+o_id);
            $('#modal_body_xl').load("modal_window_order_read.cfm?o_id="+o_id, function(){});
        });
        
        $("#add_invoice_item").click(function (event) {
            var inv_item_index = $('#container_invoice_item tr').length - 3;
            
            var to_create = "<tr class='nbr_invoice_item_tr'><td>"+inv_item_index+"</td>";
            to_create += '<td><input type="text" name="item_name_' + inv_item_index + '" id="item_name_' + inv_item_index + '" class="form-control form-control-sm" value=""></td>';
			to_create += '<td><input type="number" step="any" name="item_nb_users_' + inv_item_index + '" id="item_nb_users_' + inv_item_index +  '" class="form-control form-control-sm" value="1"></td>';
			to_create += '<td><input type="number" step="any" name="item_inv_hour_' + inv_item_index + '" id="item_inv_hour_' + inv_item_index +  '" class="form-control form-control-sm" value="0"></td>';
			to_create += '<td><input type="number" step="any" name="item_inv_unit_price_' + inv_item_index + '" id="item_inv_unit_price_' + inv_item_index +  '" class="form-control form-control-sm" value="0"></td>';
			to_create += '<td><input type="number" step="any" name="item_inv_fee_' + inv_item_index + '" id="item_inv_fee_' + inv_item_index +  '" class="form-control form-control-sm" value="0"></td>';
			to_create += '<td><input type="number" step="any" name="item_inv_total_' + inv_item_index + '" id="item_inv_total_' + inv_item_index +  '" class="form-control form-control-sm" value="0"></td>';
            to_create += '<td><button class="btn btn-info btn-sm remove_item_line" id="reset_' + inv_item_index + '"><i class="fal fa-trash-alt"></i></button></td>';
            to_create += '<input type="hidden" name="item_id_' + inv_item_index +  '" value="-1"></tr>';

			$("#container_invoice_item tr:nth-child(" + inv_item_index + ")").after(to_create);

            $("#invoice_item_count").val(inv_item_index);

            $(".remove_item_line").bind("click",handler_remove);

        })

        $("#invoice_date").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {},
        onSelect: function( selectedDate ) {
            // console.log(selectedDate)
            var date = $('#invoice_date').datepicker('getDate');
            // var nextDayDate = new Date();
            // nextDayDate.setDate(date.getDate() + delay);
            date.setDate(date.getDate() + delay);
            $('#invoice_limit').datepicker('setDate', moment(date, 'dd/mm/yy').toDate());
        }	
        });

        $("#invoice_start").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}
        });
        
        $("#invoice_end").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}	
        });

        $("#invoice_limit").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}	
        });
        
        $("#invoice_paid").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}	
        });

        $( "#user_lang_form" ).change(function(event) {
            event.preventDefault();

            var val = $(event.target).val();

            $('#modal_title_xl').text("Invoice");
            $('#modal_body_xl').empty();
            
            $('#modal_body_xl').load("modal_window_order_invoice.cfm?a_id="+<cfoutput>#a_id#+"&o_id="+#o_id#<cfif isDefined("mode")>+"&mode="+#mode#</cfif><cfif isDefined("i_id")>+"&i_id="+#i_id#</cfif></cfoutput>+"&user_lang="+val, function() {});
            
        });

        
        var by_user = -1;
        var by_list = -1;

                
        $("#reset_invoice_item").click(function () {
            event.preventDefault();

            by_user = 1;

            $("#update_form_users").trigger("click");
        })

        var handler_remove = function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            idtemp = idtemp.split("_");
		    var pos = idtemp[1];
            // console.log("hello",pos);
            // var inv_item_index = $('#container_invoice_item tr').length;
            // console.log(inv_item_index);
            // $("#container_invoice_item tr:nth-child(" + (parseInt(pos) + 1) + ")").remove();

            $("#item_name_"+ pos).val("");
            $("#item_nb_users_"+ pos).val(0);
            $("#item_inv_hour_"+ pos).val(0);
            $("#item_inv_unit_price_"+ pos).val(0);
            $("#item_inv_fee_"+ pos).val(0);
            $("#item_inv_total_"+ pos).val(0);


            
            $("#total_invoice_item").trigger("click");

        };
        $(".remove_item_line").bind("click",handler_remove);

        $("#list_users").click(function () {
            
            $(".nbr_invoice_item_tr").remove();

            var inv_item_index = $('#container_invoice_item tr').length - 3;
            
            var to_create = "<tr class='nbr_invoice_item_tr'><td>"+inv_item_index+"</td>";
            to_create += '<td><input type="text" name="item_name_' + inv_item_index + '" id="item_name_' + inv_item_index + '" class="form-control form-control-sm" value="'
                + "<cfoutput>#item_default_list_user#</cfoutput>" + "<cfoutput>#item_default_name#</cfoutput>" + '"></td>';
            to_create += '<td><input type="number" step="any" name="item_nb_users_' + inv_item_index + '" id="item_nb_users_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                + <cfoutput>#nb_users#</cfoutput> + '"></td>';
            to_create += '<td><input type="number" step="any" name="item_inv_hour_' + inv_item_index + '" id="item_inv_hour_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                + <cfoutput>#item_inv_hour#</cfoutput> + '"></td>';
            to_create += '<td><input type="number" step="any" name="item_inv_unit_price_' + inv_item_index + '" id="item_inv_unit_price_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                + <cfoutput>#item_inv_unit_price#</cfoutput> + '"></td>';
            to_create += '<td><input type="number" step="any" name="item_inv_fee_' + inv_item_index + '" id="item_inv_fee_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                + <cfoutput>#item_inv_fee#</cfoutput> + '"></td>';
            to_create += '<td><input type="number" step="any" name="item_inv_total_' + inv_item_index + '" id="item_inv_total_' + inv_item_index +  '" class="form-control form-control-sm" value=""></td>';
            to_create += '<td><button class="btn btn-info btn-sm remove_item_line" id="reset_' + inv_item_index + '"><i class="fal fa-trash-alt"></i></button></td>';
            to_create += '<input type="hidden" name="item_id_' + inv_item_index +  '" value="-1"></tr>';

            $("#container_invoice_item tr:nth-child(" + inv_item_index + ")").after(to_create);

            $("#invoice_item_count").val(inv_item_index);

            $(".remove_item_line").bind("click",handler_remove);

            $("#total_invoice_item").trigger("click");
        })

        $("#update_form_users").click(function () {

            if ($("#invoice_avoir").val() == 1) {

                $("#invoice_avoir").val(-1);
                $('#invoice_avoir_check').prop('checked', false);

            }


            // $('#modal_title_xl').text("Invoice");
            // $('#modal_body_xl').empty();
            
            // $('#modal_body_xl').load("modal_window_order_invoice.cfm?a_id="+<cfoutput>#a_id#+"&o_id="+#o_id#
            // <cfif isDefined("mode")>+"&mode="+#mode#</cfif>
            // <cfif isDefined("i_id")>+"&i_id="+#i_id#</cfif>
            // <cfif not isDefined("by_user")>+"&by_user=1"</cfif>+"&user_lang="+"#user_lang#"</cfoutput>, function() {});

            // console.log(by_user);

            if (by_user == -1) {
                $.ajax({
                url : './api/orders/orders_get.cfc?method=get_order_users',
                type : 'POST',
                data : {order_id:<cfoutput>#o_id#</cfoutput>},				
                success : function(result, status) {
                    // console.log(result);
                    var obj_result = jQuery.parseJSON(result);

                    $(".nbr_invoice_item_tr").remove();

                    for (let index = 0; index < obj_result.length; index++) {
                        const element = obj_result[index];
                        var inv_item_index = $('#container_invoice_item tr').length - 3;
                
                        var to_create = "<tr class='nbr_invoice_item_tr'><td>"+inv_item_index+"</td>";
                        to_create += '<td><input type="text" name="item_name_' + inv_item_index + '" id="item_name_' + inv_item_index + '" class="form-control form-control-sm" value="'
                            + element.USER_NAME + " " + element.USER_FIRSTNAME  + " - " + "<cfoutput>#item_default_name#</cfoutput>" + '"></td>';
                        to_create += '<td><input type="number" step="any" name="item_nb_users_' + inv_item_index + '" id="item_nb_users_' + inv_item_index +  '" class="form-control form-control-sm" value="1"></td>';
                        to_create += '<td><input type="number" step="any" name="item_inv_hour_' + inv_item_index + '" id="item_inv_hour_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                            + <cfoutput>#item_inv_hour#</cfoutput> + '"></td>';
                        to_create += '<td><input type="number" step="any" name="item_inv_unit_price_' + inv_item_index + '" id="item_inv_unit_price_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                            + <cfoutput>#item_inv_unit_price#</cfoutput> + '"></td>';
                        to_create += '<td><input type="number" step="any" name="item_inv_fee_' + inv_item_index + '" id="item_inv_fee_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                            + <cfoutput>#item_inv_fee#</cfoutput> + '"></td>';
                        to_create += '<td><input type="number" step="any" name="item_inv_total_' + inv_item_index + '" id="item_inv_total_' + inv_item_index +  '" class="form-control form-control-sm" value=""></td>';
                        to_create += '<td><button class="btn btn-info btn-sm remove_item_line" id="reset_' + inv_item_index + '"><i class="fal fa-trash-alt"></i></button></td>';
                        to_create += '<input type="hidden" name="item_id_' + inv_item_index +  '" value="-1"></tr>';

                        $("#container_invoice_item tr:nth-child(" + inv_item_index + ")").after(to_create);

                        $("#invoice_item_count").val(inv_item_index);
                        
                    }
                    
                    $(".remove_item_line").bind("click",handler_remove);

                    $("#total_invoice_item").trigger("click");
                }
            });
            } else {
                $(".nbr_invoice_item_tr").remove();

                var inv_item_index = $('#container_invoice_item tr').length - 3;
                
                var to_create = "<tr class='nbr_invoice_item_tr'><td>"+inv_item_index+"</td>";
                to_create += '<td><input type="text" name="item_name_' + inv_item_index + '" id="item_name_' + inv_item_index + '" class="form-control form-control-sm" value="'
                    + "<cfoutput>#item_default_name#</cfoutput>" + '"></td>';
                to_create += '<td><input type="number" step="any" name="item_nb_users_' + inv_item_index + '" id="item_nb_users_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                    + <cfoutput>#nb_users#</cfoutput> + '"></td>';
                to_create += '<td><input type="number" step="any" name="item_inv_hour_' + inv_item_index + '" id="item_inv_hour_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                    + <cfoutput>#item_inv_hour#</cfoutput> + '"></td>';
                to_create += '<td><input type="number" step="any" name="item_inv_unit_price_' + inv_item_index + '" id="item_inv_unit_price_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                    + <cfoutput>#item_inv_unit_price#</cfoutput> + '"></td>';
                to_create += '<td><input type="number" step="any" name="item_inv_fee_' + inv_item_index + '" id="item_inv_fee_' + inv_item_index +  '" class="form-control form-control-sm" value="'
                    + <cfoutput>#item_inv_fee#</cfoutput> + '"></td>';
                to_create += '<td><input type="number" step="any" name="item_inv_total_' + inv_item_index + '" id="item_inv_total_' + inv_item_index +  '" class="form-control form-control-sm" value=""></td>';
                to_create += '<td><button class="btn btn-info btn-sm remove_item_line" id="reset_' + inv_item_index + '"><i class="fal fa-trash-alt"></i></button></td>';
                to_create += '<input type="hidden" name="item_id_' + inv_item_index +  '" value="-1"></tr>';

                $("#container_invoice_item tr:nth-child(" + inv_item_index + ")").after(to_create);

                $("#invoice_item_count").val(inv_item_index);

                $(".remove_item_line").bind("click",handler_remove);

                $("#total_invoice_item").trigger("click");
                
            }
            
            by_user *= -1;


        })

        <cfif NOT isDefined("i_id") AND nb_users eq 1>
            $("#update_form_users").trigger("click");
        </cfif>


    });
</script>
</cfif>