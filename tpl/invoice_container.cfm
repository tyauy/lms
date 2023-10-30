<cfparam name="i_id">
<cfparam name="save" default="0">



<!--- Invoice --->
<cfquery name="get_invoice" datasource="#SESSION.BDDSOURCE#">
    SELECT i.account_id, i.status_id, i.delay_id, i.invoice_ref, i.invoice_md, i.invoice_amount, i.invoice_amount_ttc, i.invoice_date, i.invoice_limit, 
    i.invoice_paid, i.invoice_name, i.invoice_instructions, i.invoice_complement, i.invoice_details, i.invoice_paid_ref, i.invoice_paid_ref_client, 
    i.invoice_bank_id, i.invoice_provider_id, i.invoice_tva, i.invoice_avoir, i.invoice_start, i.invoice_end, i.invoice_lang,
    o.order_id, o.pack_id, o.order_ref, o.order_start, o.order_end, o.pack_id, o.user_id, a.provider_id,
    a.account_name as client_name
    FROM invoice i
    INNER JOIN orders o ON i.order_id = o.order_id
    LEFT JOIN account a ON o.account_id = a.account_id
    WHERE i.invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#i_id#">
</cfquery>

<cfset order_inv = QueryGetRow(get_invoice, 1)>

<!--- account --->
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
    SELECT a.account_id, a.account_f_name, a.account_f_address, a.account_f_postal, a.account_f_city, a.account_email, 
    a.account_phone, c.country_name_#order_inv.invoice_lang# as account_country_name,
    ac.contact_id, ac.contact_title, ac.contact_firstname, ac.contact_name
    FROM account a
    LEFT JOIN account_contact_cor acc ON acc.a_id = a.account_id 
    LEFT JOIN account_contact ac ON ac.contact_id = acc.ctc_id AND ac.contact_invoice = 1
    LEFT JOIN settings_country c ON c.country_id = a.account_f_country
    WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_inv.account_id#">
    GROUP BY a.account_id ORDER BY ac.contact_id DESC
</cfquery>

<!--- Provider --->
<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
    SELECT provider_id, `provider_name`, `provider_code`, `provider_siret`, `provider_tva`, `provider_siren`, `provider_naf`, `provider_tva_name`, 
    `provider_rcs`, `provider_address`, `provider_postal`, `provider_city`, `provider_country`, 
    `provider_finance_email`, `provider_contact_email`, `provider_finance_phone`, `provider_contact_phone`
    FROM account_provider ap
    <cfif order_inv.invoice_provider_id neq "">
        WHERE ap.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_inv.invoice_provider_id#">
    <cfelse>
        WHERE ap.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_inv.provider_id#">
    </cfif>
</cfquery>


<!--- users --->
<!--- <cfquery name="get_users" datasource="#SESSION.BDDSOURCE#">

</cfquery> --->

<!--- numbers --->
<cfquery name="get_invoice_item" datasource="#SESSION.BDDSOURCE#">
    SELECT item_name, item_nb_users, item_qty, item_price_unit, item_price_fee, item_price_total, item_unit
    FROM invoice_item 
    WHERE invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#i_id#">
</cfquery>


<!--- bank info --->
<cfquery name="get_bank" datasource="#SESSION.BDDSOURCE#">
    SELECT `bank_name`, `bank_iban`, `bank_swift`
    FROM `account_bank` 
    WHERE bank_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_inv.invoice_bank_id#">
</cfquery>

<!--- TODO SELECT lang --->

<cfset dir_go = "/home/www/wnotedev1/admin/inv">

<cfif save eq 1>
    <cfdocument format="pdf" filename="#dir_go#/#order_inv.invoice_ref#.pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" localurl="yes">
        <cfdocumentitem type = "header">
            <cfinclude template="./tpl_header.cfm">
        </cfdocumentitem> 
    
        <cfinclude template="./invoice_content.cfm">
    
        <cfdocumentitem type = "footer">
            <cfinclude template="./tpl_footer.cfm">  
        </cfdocumentitem> 
    
    </cfdocument>

    
    <!--- <div class="row">
        <div class="col-md-12">
            <cfoutput>
            <iframe src="./invoice_view.cfm?invoice_ref=#order_inv.invoice_ref#" width="100%" height="100%"></iframe>
            </cfoutput>
        </div>
    </div> --->
    
    
<cfelse>

    <cfdocument format="pdf" saveasname="#order_inv.invoice_ref#.pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" localurl="yes">
        <cfdocumentitem type = "header">
            <cfinclude template="./tpl_header.cfm">
        </cfdocumentitem> 
    
        <cfinclude template="./invoice_content.cfm">
    
        <cfdocumentitem type = "footer">
            <cfinclude template="./tpl_footer.cfm">  
        </cfdocumentitem> 
    
    </cfdocument>
</cfif>

