<html>
    <body style="width:100%; margin:0px; padding:0px">
    
    <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellspacing="15">
    <tr><td>
        <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="5" cellspacing="5">	
        <tr scope="row" style="vertical-align:top; line-height: 1.5;" width="100%">
            <td width="40%">
                <br>
                <cfoutput query="get_provider">
                <h3 style="margin:0; padding:0"> #provider_name#</h3>#provider_address#<br>
                <cfif get_provider.provider_id eq 2>
                    D-#provider_postal# #provider_city#<br>
                <cfelse>
                    #provider_postal# #provider_city#, #provider_country#<br>
                </cfif>
                #provider_finance_email#<br>
                <cfif get_provider.provider_id neq 2>
                    Tel : #provider_finance_phone#
                </cfif>
                </cfoutput>
            </td>
    
            <td width="40%">
            
                <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="8" cellspacing="0">
                <tr>
                    <th style="background-color:#cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="invoice_recipient",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                </tr>
                <tr style="line-height: 1.5; background-color:#FAFAFA;">
                    <td>
                    <div style="margin-top:5px;">
                    <cfoutput query="get_account">
                        <cfif account_id neq 346>
                            <strong>#account_f_name#</strong><br>
                            <cfif contact_id neq "">
                                #contact_title# #contact_firstname# #uCase(contact_name)# <br>
                            </cfif>
                            <cfif isdefined('account_f_address') AND account_f_address neq "">
                            #account_f_address#, <br>
                            <cfif get_provider.provider_id eq 2>
                                D-#account_f_postal# #account_f_city#<br>
                            <cfelse>
                                #account_f_postal# #account_f_city#, #account_country_name#<br>
                            </cfif>
                            </cfif>
                        <cfelse>

                            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
                                SELECT u.user_gender, u.user_firstname, u.user_name, u.user_adress_inv, u.user_postal_inv, u.user_city_inv,
                                c.country_name_#order_inv.invoice_lang# as account_country_name
                                FROM user u
                                LEFT JOIN settings_country c ON c.country_id = u.country_id_inv
                                WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_inv.user_id#">
                            </cfquery>
                            
                            <strong>#get_user.user_gender# #get_user.user_firstname# #uCase(get_user.user_name)# </strong><br>
                            #get_user.user_adress_inv#, <br>
                            <cfif get_provider.provider_id eq 2>
                                D-#get_user.user_postal_inv# #get_user.user_city_inv#<br>
                            <cfelse>
                                #get_user.user_postal_inv# #get_user.user_city_inv#, #get_user.account_country_name#<br>
                            </cfif>
                        </cfif>
                        
                        <!--- <cfif isdefined('account_email') AND account_email neq "">
                        #account_email# <br>
                        </cfif>
                        <cfif isdefined('account_phone') AND account_phone neq "">
                        #account_phone#
                        </cfif> --->
                    </cfoutput>
                    </div>
                    </td>
                </tr>

                <!--- <cfif order_inv.client_name neq get_account.account_f_name> --->
                <tr>
                    <th style="background-color:#cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="table_th_account",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                </tr>
                <tr>
                    <td>
                    <cfoutput>#order_inv.client_name#</cfoutput>
                    </td>
                </tr>
                <!--- </cfif> --->
                </table>	
            
            
                    
                
            </td>
    
        </tr>
        <cfoutput query="get_invoice">
        <tr scope="row" width="100%" style="vertical-align:top;">
            <td colspan="2">
                <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:30px;" width="100%" cellpadding="8" cellspacing="0">
                <tr>
                    <th style="background-color:##cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="invoice_date_edit",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                    <th style="background-color:##cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="invoice_ref_folder",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                    <th style="background-color:##cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="invoice_period",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                    <th style="background-color:##cb2339; color:white;"><cfoutput>#obj_translater.get_translate(id_translate="invoice_ref_wefit",lg_translate="#order_inv.invoice_lang#")#</cfoutput></th>
                </tr>
                <tr style="line-height: 1.5; background-color:##FAFAFA;">
                    <td align="center">
                        #obj_dater.get_dateformat(datego="#invoice_date#",user_lang="#order_inv.invoice_lang#")#
                    </td>
                    <td align="center">#invoice_paid_ref_client#</td>
                    <td align="center"><cfif get_invoice.invoice_start neq "" AND get_invoice.invoice_end neq "">#obj_translater.get_translate(id_translate="short_date_from",lg_translate="#order_inv.invoice_lang#")# #obj_dater.get_dateformat(datego="#get_invoice.invoice_start#",user_lang="#order_inv.invoice_lang#")# #obj_translater.get_translate(id_translate="short_date_to",lg_translate="#order_inv.invoice_lang#")# #obj_dater.get_dateformat(datego="#get_invoice.invoice_end#",user_lang="#order_inv.invoice_lang#")#<cfelse>-</cfif></td>
                    <td align="center">#order_ref#</td>
                </tr>
                </table>
            </td>
        </tr>
        </cfoutput>
        </table>		
    </td></tr>

    <tr><td><div align="center" style="font-size:16px;"><strong><cfoutput><cfif get_invoice.invoice_avoir eq "1">#obj_translater.get_translate(id_translate="invoice_avoir",lg_translate="#order_inv.invoice_lang#")#<cfelse>#obj_translater.get_translate(id_translate="invoice_invoice",lg_translate="#order_inv.invoice_lang#")#</cfif> #get_invoice.invoice_ref#</cfoutput></strong></div></td></tr>
    <tr><td>
            
            <div width="100%" align="left" style="line-height: 1.5;">
                            
                            
                <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: #999999" width="100%" cellpadding="6" cellspacing="1">
                    <tr align="center" bgcolor="#ECECEC">
                        <cfoutput>
                        <td colspan="2"><strong>#obj_translater.get_translate(id_translate="invoice_designation",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        <td><strong>#obj_translater.get_translate(id_translate="invoice_learner",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        <td><strong>#obj_translater.get_translate(id_translate="invoice_qty",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        <!--- <td><strong>#obj_translater.get_translate(id_translate="invoice_unit",lg_translate="#order_inv.invoice_lang#")#</strong></td> --->
                        <td><strong>#obj_translater.get_translate(id_translate="invoice_price_unit",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        <td><strong>#obj_translater.get_translate(id_translate="invoice_price_fee",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        <td><strong>#obj_translater.get_translate(id_translate="invoice_amount",lg_translate="#order_inv.invoice_lang#")#</strong></td>
                        </cfoutput>
                    </tr>
                    
                    
                    <cfloop query="get_invoice_item">
                        <cfoutput>
                        <tr bgcolor="##FFF">
                            <td colspan="2">
                                #item_name#
                            </td>
                            <td>#item_nb_users#</td>
                            <td>#item_qty#</td>
                            <!--- <td>
                                #item_unit#
                                <!--- todo hour #obj_translater.get_translate(id_translate="hour",lg_translate="#order_inv.invoice_lang#")#--->
                            </td> --->
                            <td>#evaluate('numberformat(#item_price_unit#,"____.__")')# &euro;</td>
                            <td>#evaluate('numberformat(#item_price_fee#,"____.__")')# &euro;</td>
                            <td align="right">#evaluate('numberformat(#item_price_total#,"____.__")')# &euro;</td>	
                        </tr>
                        </cfoutput>  
                    </cfloop>  

                    <tr>
                        <td bgcolor="#ECECEC" colspan="6" align="right"><strong><cfoutput>#obj_translater.get_translate(id_translate="invoice_total_ht",lg_translate="#order_inv.invoice_lang#")#</cfoutput></strong></td>
                        <td bgcolor="#ECECEC" align="right"><cfoutput>#numberformat(order_inv.invoice_amount,'____.__')#</cfoutput>  &euro;</td>
                    </tr>
                    <tr>
                    <!--- ACCOUNT'S TVA --->
                    <cfif order_inv.invoice_tva GT 0>
                        <td bgcolor="#FAFAFA" colspan="6" align="right"><cfoutput>#obj_translater.get_translate(id_translate="invoice_vat",lg_translate="#order_inv.invoice_lang#")#</cfoutput> <cfoutput>#order_inv.invoice_tva#</cfoutput>%</td>
                        <td bgcolor="#FFFFFF" align="right"><cfoutput>#numberformat(order_inv.invoice_amount * (order_inv.invoice_tva / 100),'____.__')#</cfoutput> &euro;</td>
                    <cfelse>
                        <td bgcolor="#FAFAFA" colspan="6" align="right"><cfoutput>#obj_translater.get_translate(id_translate="invoice_vat",lg_translate="#order_inv.invoice_lang#")#</cfoutput> 0.00%</td>
                        <td bgcolor="#FFFFFF" align="right">N/A</td>
                    </cfif>
                    </tr>
                    <tr>
                        <!--- <cfset price_ttc = #evaluate('#invoice_amount# + #tva_price#')#> --->
                        <td bgcolor="#FAFAFA" colspan="6" align="right"><cfoutput>#obj_translater.get_translate(id_translate="invoice_total_ttc",lg_translate="#order_inv.invoice_lang#")#</cfoutput></td>
                        <td bgcolor="#FFFFFF" align="right"><cfoutput>#numberformat(order_inv.invoice_amount_ttc,'____.__')#</cfoutput> &euro;</td>
                    </tr>
                </table>
                                    
    
            </div>
    </td></tr>
    
    <cfif get_provider.provider_id neq 2>
        <tr>
            <td align="center">
                <cfoutput>#obj_translater.get_translate(id_translate="invoice_due",lg_translate="#order_inv.invoice_lang#")# : #obj_dater.get_dateformat(datego="#get_invoice.invoice_limit#",user_lang="#order_inv.invoice_lang#")#</cfoutput>
                <br>
            </td>
        </tr>
    </cfif>

    

    <cfif order_inv.invoice_instructions neq "">
        <tr scope="row" width="100%" style="vertical-align:top;">
            <td>
                <strong><cfoutput>#obj_translater.get_translate(id_translate="invoice_special",lg_translate="#order_inv.invoice_lang#")#</cfoutput></strong>:<br>
                <cfoutput>#order_inv.invoice_instructions#</cfoutput>
            </td>
        </tr>
    </cfif>

    <tr><td>
        <cfoutput>
            <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: black; margin-top:110px" width="100%" cellpadding="5" cellspacing="1">
            <tr  style="line-height: 1.5; text-align:center;" bgcolor="##FFFFFF">
            
            <td>
            <cfif order_inv.invoice_lang eq "fr">
                Aucun escompte n'est consenti pour paiement comptant.<br>
                Intérêts de retard : 3 fois le taux d'intérêt légal.<br>
                Règlement par virement :</strong><br>			
                #get_bank.bank_name#<br>			
                N° IBAN : #get_bank.bank_iban#<br>						
                CODE SWIFT : #get_bank.bank_swift#<br>		
                N° TVA INTRA : #get_provider.provider_tva_name#<br>						
                N° SIRET : #get_provider.provider_siret#<br>
                N° SIREN : #get_provider.provider_siren#<br>
                CODE NAF : #get_provider.provider_naf#<br>
                RCS : #get_provider.provider_rcs#<br>
            <cfelseif order_inv.invoice_lang eq "en">
                No discount is allowed for cash payment.<br>						
                Interest on late payment: 3 times the legal interest rate.	<br>					
                (contact finance@wefitgroup.com)<br>
                Payment by transfer:</strong><br>			
                #get_bank.bank_name#<br>			
                N° IBAN : #get_bank.bank_iban#<br>				
                CODE SWIFT : #get_bank.bank_swift#<br>
                VAT NUMBER : #get_provider.provider_tva_name#						
                COMPANY IDENTIFICATION : #get_provider.provider_siret#			
                CODE NAF : #get_provider.provider_naf# / SIREN : #get_provider.provider_siren#
            <cfelseif order_inv.invoice_lang eq "de">
                Zahlbar innerhalb von 14 Tagen ab Rechnungsstellung<br>
                Es werden keine Skonti gewährt.<br>	
                Verzugszinsen: 1,5 % des gesetzlichen Zinssatzes<br>			
                (Kontakt: finance@wefitgroup.com)<br>
                <br>
                <br>
                <strong>Überweisung an:</strong><br>
                <br>
                Kreditinstitut: <strong>#get_bank.bank_name#</strong><br>	
                IBAN: #get_bank.bank_iban#<br>
                BIC/SWIFT:  #get_bank.bank_swift#<br>
                <cfif get_provider.provider_tva_name neq "">
                    Steuer-ID : #get_provider.provider_tva_name#<br>
                </cfif>
                <!--- Steuernummer : #get_provider.provider_siret#/#get_provider.provider_naf#<br> --->
                Betriebsnummer: #get_provider.provider_siren#		
            </cfif>
            </td>
            </tr>				
            </table>
        </cfoutput>
    </td>
    </tr>
    </table>           
    </body>
    </html>