
<cfparam name="o_id">
<cfparam name="dwl" default="0">

<cfquery name="get_invoice" datasource="lms-1">
    SELECT i.invoice_id, i.invoice_amount, i.invoice_amount_ttc, i.invoice_ref, i.invoice_date, i.invoice_md,
    o.order_ref, o.order_start, o.order_end, o.user_id
    FROM invoice i
    LEFT JOIN orders o ON o.order_id = i.order_id
    LEFT JOIN invoice_item it ON it.invoice_id = i.invoice_id
    LEFT JOIN order_item_var iv ON iv.invoice_item_id = it.item_id
    WHERE i.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
    LIMIT 1
</cfquery> 

<cfquery name="get_item" datasource="lms-1">
    SELECT it.item_id, it.item_qty, it.item_price_unit, it.item_price_total, i.invoice_md,
    pv.variation_name_#SESSION.LANG_CODE# as variation_name,
    p.product_name_#SESSION.LANG_CODE# as product_name, p.method_id
    FROM invoice_item it
    LEFT JOIN invoice i ON i.invoice_id = it.invoice_id
    LEFT JOIN order_item_var v ON v.invoice_item_id = it.item_id
    LEFT JOIN product_variation pv ON pv.variation_id = v.variation_id
    LEFT JOIN product p ON p.product_id = it.product_id
    WHERE it.invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_invoice.invoice_id#">
    ORDER BY method_id
</cfquery> 


<cfquery name="get_user" datasource="lms-1">
	SELECT u.user_name, u.user_firstname, u.user_phone, u.user_email, u.user_adress, u.user_postal, u.user_city, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, 
	c.country_name_fr as country_name,
	c_inv.country_name_fr as country_name_inv
	FROM user u
	LEFT JOIN settings_country c ON c.country_id = u.country_id
	LEFT JOIN settings_country c_inv ON c_inv.country_id = u.country_id_inv
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_invoice.user_id#">
</cfquery>

<cfset invoice_name = #listgetat(get_invoice.invoice_ref, 1, '_')#>
<cfset invoice_name = "#invoice_name#_#get_invoice.invoice_md#">

<cfset dir_go = "/home/www/wnotedev1/www/manager/formation/admin/inv">

<!--- <cftry>

    <!--- <cfif dwl eq 1>
        <cfheader name="Content-Disposition" value='attachment; filename="#invoice_name#.pdf"'>
        <cfcontent type="application/pdf"  deletefile="no" file="#dir_go#/#invoice_name#.pdf">
    <cfelse> --->
        <cfcontent type="application/pdf" file="#dir_go#/#invoice_name#.pdf">
    <!--- </cfif> --->
    

<cfcatch type="any">
    No PDF for invoice : <cfoutput>#invoice_name#</cfoutput>
</cfcatch>
</cftry>
         --->
<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" localurl="yes">
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<tr>
		<td width="180" valign="top">
		</td>
		<td width="15"></td>
		<td valign="top" align="left">
		</td>
	</tr>	
</table>
</cfdocumentitem> 

<html>
<body>

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellspacing="15">
<tr><td>
    <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="5">	
    <tr scope="row" style="vertical-align:top; line-height: 1.5;" width="100%">
        <!--- <td width="5%"></td> --->
        <td width="40%">
            <br>
            <strong> WEFIT GROUP</strong><br>
            168 rue de la Convention,<br>
            75015 PARIS, FRANCE<br>
            finance@wefitgroup.com<br>
            Tel : 01 83 62 32 47
        </td>

        <td width="40%">
        
            <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="0">
            <tr>
                <th style="background-color:#cb2339; color:white;">Destinataire</th>
            </tr>
            <tr style="line-height: 1.5;">
                <td>
                <div style="margin-top:5px;">
                <cfoutput query="get_user">
                    #user_firstname# #user_name#<br>
                    <cfif isdefined('user_adress_inv') AND user_adress_inv neq "">
                    #user_adress_inv#, <br>
                    #user_postal_inv# #user_city_inv#, #country_name_inv# <br>
                    <cfelse>
                    #user_adress#, <br>
                    #user_postal# #user_city#, #country_name# <br>
                    </cfif>
                    #user_email# <br>#user_phone#
                </cfoutput>
                </div>
                </td>
            </tr>
            </table>	
        
        
                
            
        </td>
        <!--- <td width="5%"></td> --->
    </tr>
    <cfoutput query="get_invoice">
    <!--- <tr scope="row" width="100%"> --->
    <tr scope="row" width="100%" style="vertical-align:top;">
        <!--- <td width="5%"></td> --->
        <td>
            

            <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="0">
            <tr>
                <th style="background-color:##cb2339; color:white;">Ref dossier :</th>
                <th style="background-color:##cb2339; color:white;">Date : </th>
            </tr>
            <tr>
                <td align="center"> N°#order_ref#</td>
                <td align="center">#dateformat(invoice_date, 'dd/mm/yyyy')#</td>
            </tr>
            </table>



            
        </td>
        <td width="40%">
            <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="0">
            <tr>
                <th style="background-color:##cb2339; color:white;">Période :</th>
            </tr>
            <tr>
                <td align="center">Du #dateformat(order_start, 'dd/mm/yyyy')# au #dateformat(order_end, 'dd/mm/yyyy')#<br></td>
            </tr>
            </table>
        </td>
    </tr>
    </cfoutput>
    </table>		
</td></tr>

<tr><td><div align="center" style="font-size:17px;"><strong><cfoutput> Facture N°#get_invoice.invoice_ref# </cfoutput></strong></div></td></tr>
<tr><td>
<!------ ORDER CONTENT AND PRICES ------>
<div width="100%" align="left" style="line-height: 1.5;">
    
    <cfset view = "inv_">
    <cfset order_id = #o_id#>
    
<table <cfif view eq "ord_"> width="100%" class="table <cfif isdefined('cart_return')>table-striped"<cfelse>table-borderless border bg-white" </cfif>
<cfelseif view eq "inv_">style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: #999999" width="100%" cellpadding="5" cellspacing="1"</cfif>>
<thead>
	<cfif view eq "ord_">
	<tr>
		<th align="left" width="25%" scope="col"></th>
		<th style="color:grey; font-size:11px;" align="left" width="40%" scope="col">PRODUIT</th>
		<th style="color:grey; font-size:11px;" align="left" width="15%" scope="col">QUANTITE</th>
		<th style="color:grey; font-size:11px;" class="text-center" width="20%" scope="col">PRIX</th>
	</tr>
	<cfelseif view eq "inv_">
	<tr align="center" bgcolor="#ECECEC">
		<td><strong>Désignation</strong></td>
		<td><strong>Qté</strong></td>
		<td><strong>Unité</strong></td><!------->
		<td><strong>Prix unitaire</strong></td><!------->
		<td><strong>Montant</strong></td>
	</tr>
	</cfif>
</thead>
<tbody class="cart_container">
								
									<!----------->
	<cfquery name="get_item" datasource="lms-1"> 
        SELECT it.order_item_id, it.method_id, it.order_item_unit_price, it.order_item_amount, it.order_item_amount_ttc, it.order_item_qty, it.certif_id, it.product_id, it.coupon_id, it.product_name,
        p.product_name_#SESSION.LANG_CODE# as product_name_lg,
        cpn.coupon_discount, cpn.coupon_type
        FROM order_item it 
        LEFT JOIN product p ON p.product_id = it.product_id 
        LEFT JOIN product_coupon cpn ON cpn.coupon_id = it.coupon_id
        WHERE it.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#"> 
        ORDER BY order_item_qty DESC, order_item_id
    </cfquery> 
	<cfquery name="get_invoice" datasource="lms-1">
        SELECT i.invoice_id, i.invoice_amount, i.invoice_amount_ttc, i.invoice_ref, i.invoice_date, i.invoice_md,
        o.order_ref, o.order_start, o.order_end, o.user_id
        FROM invoice i
        LEFT JOIN orders o ON o.order_id = i.order_id
        LEFT JOIN invoice_item it ON it.invoice_id = i.invoice_id
        LEFT JOIN order_item_var iv ON iv.invoice_item_id = it.item_id
        WHERE i.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
        LIMIT 1
    </cfquery>						
	
	
	<cfset tva = fix(get_invoice.invoice_amount*0.2*100)/100>
	<cfset tva = numberformat(tva,'____.__')>
	
	<cfoutput query="get_item"> 
	<!--- GEN. COUPON --->
	<cfif product_id eq 0>
	<tr <cfif view eq "ord_">style="border-top: 1px solid grey; color:blue;"<cfelse>bgcolor="##FFFFFF"</cfif>>
		<cfif view eq "ord_"><td></td><cfelse><td colspan="3"></td></cfif>
		<td align="right" colspan="2">Code promo <strong>#product_name#</strong> :</td>
		<cfif method_id eq "euro"><cfset type="&euro;"><cfelse><cfset type="%"></cfif>
		<td align="right">- #order_item_amount_ttc# #type#</td>
		<!---<cfset ttc_amount -= #order_item_amount#>--->
	</tr>
	<!--------->
	<cfelse>
    <cfquery name="get_var" datasource="lms-1"> 
        SELECT v.variation_name_#SESSION.LANG_CODE# as variation_name 
        FROM order_item_var itv 
        LEFT JOIN product_variation v ON v.variation_id = itv.variation_id 
        WHERE order_item_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_item.order_item_id#">
        ORDER BY itv.attribute_id 
    </cfquery> 
	<!--- <cfset get_var = obj_processor.oget_var(get_item.order_item_id)> --->
									
	<tr style="border-top: 1px solid grey;"<cfif view eq "inv_">bgcolor="##FFFFFF"</cfif>>
		<cfif view eq "ord_">
		<td><!---<img width="80" src="../assets/img_product/#method_id#.jpg">---></td> 
		<!---<cfelseif view eq "inv_">
		<td width="20" align="center"><img src="../assets/img/picto_methode_#method_id#.png" width="30"></td>--->
		</cfif>
		<td align="left">#get_item.product_name#<br>
		<div class="mt-1">
			<cfloop query="get_var"> 
										 
				<span class="badge bg-secondary mr-1 p-2"<cfif view eq "inv_">style="color:grey;"</cfif>>#variation_name#</span>
										 
			</cfloop> 
		</div>
		</td>
		<td align="left">#get_item.order_item_qty#</td> 
		<cfif view eq "inv_">
			<td align="center"><cfif method_id eq 1>heure (s)<cfelseif method_id eq 3>mois<cfelseif method_id eq 7> unité (s)</cfif></td>
			<td align="center"><cfif isdefined('order_item_unit_price') and order_item_unit_price neq "0">#order_item_unit_price# &euro;<cfelse>-</cfif></td>

		</cfif>
		<td align="right">
			<cfif view eq "ord_">
				<cfset view_tva = 1.2>
			<cfelseif view eq "inv_">
				<cfset view_tva = 1>
			</cfif>

			<cfif isdefined('get_item.coupon_id') and get_item.coupon_id neq 0 and get_item.coupon_id neq "">
				<cfif get_item.coupon_type eq "euro">
					<cfset type = "&euro;">
					<cfif view eq "ord_">
					<cfset reduc = round(get_item.coupon_discount*view_tva*get_item.order_item_qty)>
					<cfelse>
					<cfset reduc = fix(get_item.coupon_discount*get_item.order_item_qty*100)/100>
					</cfif>
					<cfset reduc_price = #reduc#>
				<cfelse>
					<!--- % --->
					<cfset type= "%">
					<cfset reduc_price = (get_item.order_item_unit_price*get_item.order_item_qty*get_item.coupon_discount/100*1.2)>
					<cfset reduc = #get_item.coupon_discount#>
				</cfif>
				
				<cfif view eq "ord_">
					<cfset before_cpn = fix(get_item.order_item_unit_price*1.2*100)/100 *get_item.order_item_qty>
				<cfelse>
					<cfset before_cpn = fix(get_item.order_item_unit_price*get_item.order_item_qty*100)/100>
				</cfif>
				
				<small>#numberformat(before_cpn,'____.__')# &euro;
				<br><span style="color:blue;">- #numberformat(reduc,'____.__')# #type#</span></small>
				<!--- <br><span style="color:blue;">#numberformat(get_item.order_item_amount_ttc,'____.__')# &euro;</span> --->
				
			<cfelse>
				<cfif view eq "ord_">
					#numberformat(get_item.order_item_amount_ttc,'____.__')#
				<cfelseif view eq "inv_">
					#numberformat(get_item.order_item_amount,'____.__')#
				</cfif> &euro;
			</cfif>
		</td> 
	</tr>
	</cfif>
	</cfoutput>
	
	<cfif view eq "ord_">
	
	<tr style="border-top: 1px solid grey;">
	<cfoutput>
		<td></td>
		<td colspan=2 align="right" <cfif not isdefined('cart_return')>style="padding-bottom: 0px;"</cfif>><strong>Total TTC :</strong></td>
		<td align="right" <cfif not isdefined('cart_return')>style="padding-bottom: 0px;"</cfif>><strong>#numberformat(get_invoice.invoice_amount_ttc,'____.__')# &euro;</strong></td>

	</cfoutput>
	</tr>
	
	<tr>
	<cfoutput>
		<td></td>
		<td colspan=2 align="right">Dont TVA 20% :</td>
		<td align="right">#tva# &euro;</td>
	</cfoutput>
	</tr>
	
	<cfelseif view eq "inv_">
	<cfoutput query="get_invoice">
		<tr>
			<td bgcolor="##FAFAFA" colspan="4" align="left"><strong>Total HT</strong></td>
			<td bgcolor="##FFFFFF" align="right">#numberformat(invoice_amount,'____.__')# &euro;</td>
		</tr>
		<tr>
			<cfset tva_price = invoice_amount_ttc - invoice_amount>
			<td bgcolor="##FAFAFA" colspan="4" align="left">TVA 20%</td>
			<td bgcolor="##FFFFFF" align="right">#numberformat(tva_price,'____.__')# &euro;</td>
		</tr>
		<tr>
			<td bgcolor="##FAFAFA" colspan="4" align="left">Total TTC</td>
			<td bgcolor="##FFFFFF" align="right">#numberformat(invoice_amount_ttc,'____.__')# &euro;</td>
		</tr>
	</cfoutput>
	</cfif>
	
</tbody>
</table>

</div>
</td></tr>


<tr></tr>

<tr><td>
<cfoutput>
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: black;" width="100%" cellpadding="5" cellspacing="1">
<tr  style="line-height: 1.5; text-align:center;" bgcolor="##FFFFFF">

<td>
<!--- POUR FACTURE B2C
Aucun escompte n'est consenti pour paiement comptant.<br>
Intérêts de retard : 3 fois le taux d'intérêt légal.<br>
Règlement par virement :<br>						
SOCIÉTÉ GÉNÉRALE<br>						
N° IBAN : FR76 3000 3018 8500 0209 5416 211<br>						
CODE SWIFT : SOGEFRPP<br> --->		
Règlement par Carte Bancaire	<br>			
<br>
N° TVA INTRA : FR34510689649<br>						
N° SIRET : 510 689 649 00034<br>				
CODE NAF : 7022Z / SIREN : 516 689 649<br>
</td>
</tr>				
</table>
</cfoutput>
</td>
</tr>
</table>           
</body>
</html>

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:0px; margin-top:0px" width="900">
	<tr>
		<td valign="top" align="center">
			<img src="https://formation.wefitgroup.com/assets/img/logo_wefit_260.jpg" width="120">
			<br><br>
			WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
			D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
		</td>
	</tr>	
</table>    
</cfdocumentitem> 

</cfdocument>