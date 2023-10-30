<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">

<cfif u_id eq "">
Identifiant learner manquant
<cfabort>
</cfif>
<cfif a_id eq "">
Identifiant account manquant
<cfabort>
</cfif>

<!------------------------ MAJ ----------------->
<cfif isdefined("new_id")>
<cfoutput>
 MAJ #new_id#
 
<cfparam name="provider_id" default="WEFIT GROUP">*

<cfif provider_id eq "WEFIT GROUP">
	<cfset provider_id = "1">
<cfelseif provider_id eq "WEFIT GERMANY">
	<cfset provider_id = "2">
 <cfelseif provider_id eq "WEFIT FRANCE">
	<cfset provider_id = "3">
 </cfif>

<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
SELECT user_firstname, user_name FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_id#">
</cfquery>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_name, account_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
</cfquery>

<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_status_finance WHERE status_finance_name = '#order_status#'
</cfquery>

<cfif get_status_finance.recordcount eq "0">
PAS DE STATUS FINANCE !!
<cfabort>
</cfif>

<cfparam name="order_invoice_mode" default="CONSO">

<cfquery name="get_context" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_context WHERE context_alias = '#order_context#'
</cfquery>

<cfif get_context.recordcount eq "0">
PAS D'ORDER CONTEXT (PLAN, CPF etc... )!!
<cfabort>
</cfif>


<cfquery name="get_mode" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_mode WHERE order_mode_name = '#order_invoice_mode#'
</cfquery>

<cfif get_mode.recordcount eq "0">
PAS D'ORDER MODE (comptant, fin de formation etc..) !!
<cfabort>
</cfif>

<cfset order_start = dateformat(order_start,'yyyy-mm-dd')>
<cfset order_end = dateformat(order_end,'yyyy-mm-dd')>

<cfif order_formation eq "FRANCAIS">
	<cfset order_formation = "1">
<cfelseif order_formation eq "ANGLAIS">
	<cfset order_formation = "2">
<cfelseif order_formation eq "ESPAGNOL">
	<cfset order_formation = "4">
<cfelseif order_formation eq "ALLEMAND">
	<cfset order_formation = "3">
<cfelseif order_formation eq "ITALIEN">
	<cfset order_formation = "5">
<cfelseif order_formation eq "ARABE">
	<cfset order_formation = "6">
<cfelseif order_formation eq "HEBREU">
	<cfset order_formation = "7">
<cfelseif order_formation eq "MANDARIN">
	<cfset order_formation = "8">
<cfelseif order_formation eq "NEERLANDAIS">
	<cfset order_formation = "9">
<cfelseif order_formation eq "NORVEGIEN">
	<cfset order_formation = "10">
<cfelseif order_formation eq "POLONAIS">
	<cfset order_formation = "11">
<cfelseif order_formation eq "PORTUGAIS">
	<cfset order_formation = "12">
<cfelseif order_formation eq "RUSSE">
	<cfset order_formation = "13">
<cfelseif order_formation eq "JAPONAIS">
	<cfset order_formation = "14">
<cfelseif order_formation eq "DANOIS">
	<cfset order_formation = "15">
<cfelseif order_formation eq "MANAGEMENT">
	<cfset order_formation = "16">
<cfelseif order_formation eq "BUREAUTIQUE">
	<cfset order_formation = "17">
<cfelseif order_formation eq "TURC">
	<cfset order_formation = "22">
<cfelse>
	<cfset order_formation = "NA">
</cfif>

<cfif order_formation eq "NA">
----> PROBLEME D'IMPORT : formation non trouv&eacute;e pour la cr&eacute;ation de TP<br>
	
	<cfabort>
</cfif>


<cfset order_method_list = "">

<cfif findnocase("VISIO",order_method)>
	<cfset order_method_list = listappend(order_method_list,"1")>
<cfelseif findnocase("F2F",order_method)>
	<cfset order_method_list = listappend(order_method_list,"2")>
<cfelseif findnocase("ELEARNING",order_method)>
	<cfset order_method_list = listappend(order_method_list,"3")>
<cfelseif findnocase("WEMAIL",order_method)>
	<cfset order_method_list = listappend(order_method_list,"5")>
<cfelseif findnocase("IMMERSION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"6")>
<cfelseif findnocase("CERTIFICATION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"7")>
<cfelseif findnocase("AUDIT",order_method)>
	<cfset order_method_list = listappend(order_method_list,"8")>
<cfelseif findnocase("ÉVALUATION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"9")>
<cfelseif findnocase("GROUP CLASS",order_method)>
	<cfset order_method_list = listappend(order_method_list,"11")>
<cfelse>
	<cfset order_method_list = "NA">
</cfif>

<cfif order_method_list eq "NA">
----> PROBLEME D'IMPORT : methode TP non trouv&eacute;e pour la cr&eacute;ation de TP<br>
	
	<cfabort>
</cfif>


<table border="0" cellpadding="10">
	<tr>
		<td valign="top">
			<h2>REFERENCES</h2>

			<table border="1">
				<tr>
					<td>LEARNER</td>
					<td>#get_learner.user_firstname# #get_learner.user_name# // #u_id#</td>
				</tr>
				<tr>
					<td>ACCOUNT</td>
					<td>#get_account.account_name# // #a_id#</td>
				</tr>
				
				
			</table>
		</td>
		
		
		
		
		
		
		<td valign="top">
		
			<h2>ORDER TO MAJ</h2>
			<table border="1">
				<tr>
					<td>ORDER</td>
					<td>#o_id#</td>
				</tr>
				<tr>
					<td>ORDER DATE</td>
					<td><cfif opport_date neq "">#dateformat(opport_date,'yyyy-mm-dd')#<cfelse>#dateformat(now(),'yyyy-mm-dd')#</cfif></td>
				</tr>
				<tr>
					<td>ORDER CLOSE</td>
					<td><cfif opport_date neq "">#dateformat(opport_date,'yyyy-mm-dd')#<cfelse>null</cfif></td>
				</tr>	
				<tr>
					<td>FORMATION ID</td>
					<td>#order_formation#</td>
				</tr>
				<tr>
					<td>STATUS CS</td>
					<td>#user_status#</td>
				</tr>
				<tr>
					<td>STATUS FIN</td>
					<td>#order_status# // #get_status_finance.status_finance_id#</td>
				</tr>
				<tr>
					<td>ORDER REF</td>
					<td>#o_id#</td>
				</tr>
				<tr>
					<td>ORDER REF CLIENT</td>
					<td>#order_ref#</td>
				</tr>
				<tr>
					<td>DEBUT APC</td>
					<td>#order_start#</td>
				</tr>
				<tr>
					<td>FIN APC</td>
					<td>#order_end#</td>
				</tr>
				<tr>
					<td>ORDER MODE</td>
					<td>#order_invoice_mode# // #get_mode.order_mode_id#</td>
				</tr>
				<tr>
					<td>ORDER CONTEXT</td>
					<td>#order_context# // #get_context.context_id#</td>
				</tr>

				<tr>
					<td>ORDER COMMENTS</td>
					<td>#order_comments#</td>
				</tr>

			</table>
		</td>
		
		
	<cfif order_opca_nbh eq ""><cfset order_opca_nbh = 0></cfif>	
	<cfif order_opca_eurh eq ""><cfset order_opca_eurh = 0></cfif>		
	<cfif order_opca_certif eq ""><cfset order_opca_certif = 0></cfif>	
	<cfif order_opca_fees eq ""><cfset order_opca_fees = 0></cfif>
	<cfif order_dir_nbh eq ""><cfset order_dir_nbh = 0></cfif>	
	<cfif order_dir_eurh eq ""><cfset order_dir_eurh = 0></cfif>	
	<cfif order_dir_certif eq ""><cfset order_dir_certif = 0></cfif>
	<cfif order_dir_fees eq ""><cfset order_dir_fees = 0></cfif>
	
	<cfset order_opca_fees = replacenocase(order_opca_certif,",",".","ALL")+replacenocase(order_opca_fees,",",".","ALL")>
	<cfset order_dir_fees = replacenocase(order_dir_certif,",",".","ALL")+replacenocase(order_dir_fees,",",".","ALL")>
	
	<cfif order_opca_nbh neq "0">
		<cfset total_opca = (replacenocase(order_opca_nbh,",",".","ALL")*numberformat(replacenocase(order_opca_eurh,",",".","ALL"),"____.__"))>
	<cfelse>
		<cfset total_opca = 0>
	</cfif>	
	<cfset total_opca = total_opca+order_opca_fees>
			
	<cfif order_dir_nbh neq "0">
		<cfset total_dir = (replacenocase(order_dir_nbh,",",".","ALL")*numberformat(replacenocase(order_dir_eurh,",",".","ALL"),"____.__"))>	
	<cfelse>
		<cfset total_dir = 0>
	</cfif>	
	<cfset total_dir = total_dir+order_dir_fees>
	
	<cfset total_amount = total_opca+total_dir>
	
	
	
	<td valign="top">
		<h2>PACKAGE ITEM</h2>
		<table border="1">
			<tr>
				<td>ORDER</td>
				<td colspan="7">#o_id#</td>
			</tr>
			<tr>
				<td>PACK EDOF</td>
				<td colspan="7"><cfif pack_id neq "">#pack_id#</cfif></td>
			</tr>
		</table>
	
	</td>
	
	<td valign="top">
		<h2>PACKAGE INVOICE</h2>
		<table border="1">
			<tr>
				<td>ORDER</td>
				<td colspan="7">#o_id#</td>
			</tr>
			
			<tr>
				<td>FACTU</td>
				<td>NBH</td>
				<td>PU</td>
				<td>FEES CERT</td>
				<td>FEES</td>
				<td>TOTAL</td>
			</tr>
			
		<cfif total_opca neq "0">
			<tr>
				<td>opca / #order_direct_opca# >> #opca_id#</td>
				<td>#order_opca_nbh#</td>
				<td>#order_opca_eurh#</td>
				<td>#order_opca_certif#</td>
				<td>#order_opca_fees#</td>
				<td>#total_opca#</td>
			</tr>
		<!---<cfelse>
			<tr>
			<td colspan="7">-</td>
			</tr>--->
		</cfif>
		<cfif total_dir neq "0">
			<tr>
				<td>direct / #order_direct_opca# >> #a_id#</td>
				<td>#order_dir_nbh#</td>
				<td>#order_dir_eurh#</td>
				<td>#order_dir_certif#</td>
				<td>#order_dir_fees#</td>
				<td>#total_dir#</td>
			</tr>
		<!---<cfelse>
			<tr>
			<td colspan="7">-</td>
			</tr>--->
		</cfif>
		
	
		</table>
	
	</td>
	
<cfif isdefined("build")>

		
	<cfquery name="updt_order" datasource="#SESSION.BDDSOURCE#">
	UPDATE orders SET 
	order_ref = '#o_id#',
	order_comment = '#order_comments#',
	order_status_id = #get_status_finance.status_finance_id#,
	user_id = #u_id#,
	account_id = #a_id#,
	provider_id = #provider_id#,
	order_ref2 = <cfif order_ref neq "">'#order_ref#',<cfelse>null,</cfif>
	order_date = <cfif opport_date neq "">'#dateformat(opport_date,'yyyy-mm-dd')#',<cfelse>'#dateformat(now(),'yyyy-mm-dd')#',</cfif>
	<!---order_close = <cfif opport_date neq "">'#dateformat(opport_date,'yyyy-mm-dd')#',<cfelse>null,</cfif>--->
	order_start =<cfif order_start neq "">'#order_start#',<cfelse>null,</cfif>
	order_end = <cfif order_end neq "">'#order_end#',<cfelse>null,</cfif>
	context_id = #get_context.context_id#,
	pack_id = <cfif pack_id neq "">#pack_id#,<cfelse>null,</cfif>
	formation_id = #order_formation#
	WHERE order_id = #new_id#
	</cfquery>

	<cfquery datasource="#SESSION.BDDSOURCE#">
		DELETE FROM `orders_users` WHERE
		order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_id#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>

	<cfquery name="insert_order_user" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO `orders_users`(`order_id`, `user_id`) 
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#new_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			)
	</cfquery>
	<!--- <cfdump var="#get_status_finance.status_finance_id#"> --->
	<!--- <cfif #get_status_finance.status_finance_id# eq 10> --->
		<!--- <cfquery name="updt_vip" datasource="#SESSION.BDDSOURCE#"> --->
			<!--- UPDATE lms_tp t --->
			<!--- SET tp_vip = 1 --->
			<!--- WHERE t.method_id < 3 and t.order_id = #new_id# --->
		<!--- </cfquery> --->
	<!--- </cfif> --->
	
	<!--- CLEAN BEFORE TREATMENT ---->
	<cfquery name="del_item_invoice" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM order_item_invoice WHERE order_id = #new_id#
	</cfquery>
		
	<cfif total_opca neq "0">
	<cfquery name="insert_item_invoice" datasource="#SESSION.BDDSOURCE#">
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
	VALUES 
	(
	#new_id#,
	#opca_id#,
	#replacenocase(order_opca_nbh,",",".","ALL")#,
	#numberformat(replacenocase(order_opca_eurh,",",".","ALL"),"____.__")#,
	#numberformat(replacenocase(order_opca_fees,",",".","ALL"),"____.__")#,
	#total_opca#,
	null,
	<cfif opca_id eq "495">3<cfelse>2</cfif>
	)
	</cfquery>
	</cfif>
	
	<cfif total_dir neq "0">
	<cfquery name="insert_item_invoice" datasource="#SESSION.BDDSOURCE#">
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
	VALUES 
	(
	#new_id#,
	#a_id#,
	#replacenocase(order_dir_nbh,",",".","ALL")#,
	#numberformat(replacenocase(order_dir_eurh,",",".","ALL"),"____.__")#,
	#numberformat(replacenocase(order_dir_fees,",",".","ALL"),"____.__")#,
	#total_dir#,
	null,
	1
	)
	</cfquery>
	</cfif>
	
	
	<!---<cfif pack_id neq "0">
	<cfquery name="insert_item_invoice" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO order_item_package
	(
	order_id, 
	method_id, 
	destination_id, 
	certif_id, 
	elearning_id, 
	elearning_duration, 
	package_duration
	)
	VALUES 
	(
	#new_id#,
	#opca_id#,
	#order_opca_nbh#,
	#order_opca_eurh#,
	#order_opca_fees#,
	#total_opca#,
	null,
	<cfif opca_id eq "495">3<cfelse>2</cfif>
	)
	</cfquery>
	</cfif>--->
</cfif>
		
		
		
		
		
		
		
		
		<!---
		
		<cfif isdefined("build")>
		
		</cfif>
		
		<td valign="top">
		
		
			<h2>ORDER ITEMS TO CREATE</h2>
			<table border="1">
				<tr>
					<td></td>
					<td>OPCA</td>
					<td>Method</td>
					<td>h</td>
					<td>&euro;/H</td>
					<td>Fees certif</td>
					<td>Fees fees</td>
					<td>Total</td>
				</tr>
			<cfif order_opca_nbh neq "">
				<tr>
					<td>OPCA</td>
					<td>#order_direct_opca# // #opca_id#</td>
					<td>#order_method# // #tp_method_list#</td>
					<td>#order_opca_nbh#</td>
					<td>#order_opca_eurh#</td>
					<td>#order_opca_certif#</td>
					<td>#order_opca_fees#</td>
					<td>#total_opca#</td>
				</tr>
				
				
				<cfif isdefined("build")>

					<!---- INSERTION LIGNE H*QTY ---->
					<cfif order_opca_nbh neq "" AND order_opca_eurh neq ""> 
					<cfset total_temp = replacenocase(order_opca_nbh,",",".","ALL")*numberformat(replacenocase(order_opca_eurh,",",".","ALL"),"____.__")>
					
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty
					)
					VALUES
					(
					#new_id#,
					'#tp_method_list#',
					'#numberformat(replacenocase(order_opca_eurh,",",".","ALL"),"____.__")#',
					#total_temp#,
					#opca_id#,
					2,
					<!---item_type_id,--->
					'#replacenocase(order_opca_nbh,",",".","ALL")#'
					)			
					</cfquery>
					</cfif>
					
					<!---- INSERTION FEES CERTIF---->
					<cfif order_opca_certif neq "0">
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty,
					certif_id,
					destination_id
					)
					VALUES
					(
					#new_id#,
					7,
					null,
					#numberformat(replacenocase(order_opca_certif,",",".","ALL"),'____.__')#,
					#opca_id#,
					2,
				<!---item_type_id,--->
					1,
					<cfif isdefined("get_certif.certif_id") AND get_certif.certif_id neq "">#get_certif.certif_id#<cfelse>null</cfif>,
					null
					)			
					</cfquery>
					</cfif>
					
					<!---- INSERTION FEES FEES ---->
					<cfif order_opca_fees neq "0">
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty,
					certif_id,
					destination_id
					)
					VALUES
					(
					#new_id#,
					'#tp_method_list#',
					null,
					'#numberformat(replacenocase(order_opca_fees,",",".","ALL"),'____.__')#',
					#opca_id#,
					2,
					<!---item_type_id,--->
					1,
					null,
					null
					)			
					</cfquery>
					</cfif>
				
				
				</cfif>
	
			</cfif>
			<cfif order_dir_nbh neq "">
				<tr>
					<td>DIRECT</td>
					<td>-</td>
					<td>#order_method#</td>
					<td>#order_dir_nbh#</td>
					<td>#order_dir_eurh#</td>
					<td>#order_dir_certif#</td>
					<td>#order_dir_fees#</td>
					<td>#total_dir#</td>
				</tr>
				
				<cfif isdefined("build")>
					<!---- INSERTION LIGNE H*QTY ---->
					<cfif order_dir_nbh neq "" AND order_dir_eurh neq ""> 
					
					<cfset total_temp = replacenocase(order_dir_nbh,",",".","ALL")*numberformat(replacenocase(order_dir_eurh,",",".","ALL"),"____.__")>
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty
					)
					VALUES
					(
					#new_id#,
					'#tp_method_list#',
					'#numberformat(replacenocase(order_dir_eurh,",",".","ALL"),"____.__")#',
					#total_temp#,
					#a_id#,
					1,
					<!---item_type_id,--->
					'#replacenocase(order_dir_nbh,",",".","ALL")#'
					)			
					</cfquery>
					</cfif>
					
					<!---- INSERTION FEES CERTIF---->
					<cfif order_dir_certif neq "0">
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty,
					certif_id,
					destination_id
					)
					VALUES
					(
					#new_id#,
					7,
					null,
					'#numberformat(replacenocase(order_dir_certif,",",".","ALL"),'____.__')#',
					#a_id#,
					1,
					<!---item_type_id,--->
					1,
					<cfif isdefined("get_certif.certif_id") AND get_certif.certif_id neq "">#get_certif.certif_id#<cfelse>null</cfif>,
					null
					)			
					</cfquery>
					</cfif>
					
					<!---- INSERTION FEES FEES ---->
					<cfif order_dir_fees neq "0">
					<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO order_item
					(
					order_id,
					method_id,
					order_item_unit_price,
					order_item_amount,
					account_id,
					order_item_mode_id,
					<!---item_type_id,--->
					order_item_qty,
					certif_id,
					destination_id
					)
					VALUES
					(
					#new_id#,
					'#tp_method_list#',
					null,
					#numberformat(replacenocase(order_dir_fees,",",".","ALL"),'____.__')#,
					#a_id#,
					1,
					<!---item_type_id,--->
					1,
					null,
					null
					)			
					</cfquery>
					</cfif>
				</cfif>
				
			</cfif>
			</table>--->
			
		</td>
		
		
	</tr>
</table>
</cfoutput>



 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 <!------------------------ INSERT ----------------->
 
<cfelse>



<cfparam name="provider_id" default="WEFIT GROUP">


<cfif provider_id eq "WEFIT GROUP">
	<cfset provider_id = "1">
<cfelseif provider_id eq "WEFIT GERMANY">
	<cfset provider_id = "2">
<cfelseif provider_id eq "WEFIT FRANCE">
	<cfset provider_id = "3">
</cfif>



<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT order_id FROM orders WHERE order_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#o_id#">
</cfquery>



<cfif get_order.recordcount neq "0">

ORDER d&eacute;j&agrave; existant dans LMS <cfoutput>#get_order.order_id#</cfoutput>

<cfelse>

<cfoutput>


<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
SELECT user_firstname, user_name FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#u_id#">
</cfquery>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_name, account_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
</cfquery>

<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_status_finance WHERE status_finance_name = '#order_status#'
</cfquery>

<cfif get_status_finance.recordcount eq "0">
PAS DE STATUS FINANCE !!
<cfabort>
</cfif>

<cfparam name="order_invoice_mode" default="CONSO">

<cfquery name="get_context" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_context WHERE context_alias = '#order_context#'
</cfquery>

<cfif get_context.recordcount eq "0">
PAS D'ORDER CONTEXT (PLAN, CPF etc... )!!
<cfabort>
</cfif>

<cfquery name="get_mode" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_mode WHERE order_mode_name = '#order_invoice_mode#'
</cfquery>

<cfif get_mode.recordcount eq "0">
PAS D'ORDER MODE (comptant, fin de formation etc..) !!
<cfabort>
</cfif>


<cfset order_start = dateformat(order_start,'yyyy-mm-dd')>
<cfset order_end = dateformat(order_end,'yyyy-mm-dd')>

<cfif order_formation eq "FRANCAIS">
	<cfset order_formation = "1">
<cfelseif order_formation eq "ANGLAIS">
	<cfset order_formation = "2">
<cfelseif order_formation eq "ESPAGNOL">
	<cfset order_formation = "3">
<cfelseif order_formation eq "ALLEMAND">
	<cfset order_formation = "4">
<cfelseif order_formation eq "ITALIEN">
	<cfset order_formation = "5">
<cfelseif order_formation eq "ARABE">
	<cfset order_formation = "6">
<cfelseif order_formation eq "HEBREU">
	<cfset order_formation = "7">
<cfelseif order_formation eq "MANDARIN">
	<cfset order_formation = "8">
<cfelseif order_formation eq "NEERLANDAIS">
	<cfset order_formation = "9">
<cfelseif order_formation eq "NORVEGIEN">
	<cfset order_formation = "10">
<cfelseif order_formation eq "POLONAIS">
	<cfset order_formation = "11">
<cfelseif order_formation eq "PORTUGAIS">
	<cfset order_formation = "12">
<cfelseif order_formation eq "RUSSE">
	<cfset order_formation = "13">
<cfelseif order_formation eq "JAPONAIS">
	<cfset order_formation = "14">
<cfelseif order_formation eq "DANOIS">
	<cfset order_formation = "15">
<cfelseif order_formation eq "MANAGEMENT">
	<cfset order_formation = "16">
<cfelseif order_formation eq "BUREAUTIQUE">
	<cfset order_formation = "17">
<cfelse>
	<cfset order_formation = "NA">
</cfif>

<cfif order_formation eq "NA">
----> PAS DE FORMATION TROUV&Eacute;E
	
	<cfabort>
</cfif>


<cfset order_method_list = "">

<cfif findnocase("VISIO",order_method)>
	<cfset order_method_list = listappend(order_method_list,"1")>
<cfelseif findnocase("F2F",order_method)>
	<cfset order_method_list = listappend(order_method_list,"2")>
<cfelseif findnocase("ELEARNING",order_method)>
	<cfset order_method_list = listappend(order_method_list,"3")>
<cfelseif findnocase("WEMAIL",order_method)>
	<cfset order_method_list = listappend(order_method_list,"5")>
<cfelseif findnocase("IMMERSION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"6")>
<cfelseif findnocase("CERTIFICATION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"7")>
<cfelseif findnocase("AUDIT",order_method)>
	<cfset order_method_list = listappend(order_method_list,"8")>
<cfelseif findnocase("ÉVALUATION",order_method)>
	<cfset order_method_list = listappend(order_method_list,"9")>
<cfelseif findnocase("GROUP CLASS",order_method)>
	<cfset order_method_list = listappend(order_method_list,"11")>
<cfelse>
	<cfset order_method_list = "NA">
</cfif>

<cfif order_method_list eq "NA">
----> PAS DE M&Eacute;THODE TROUV&Eacute;E
	
	<cfabort>
</cfif>


<table border="0" cellpadding="10">
	<tr>
		<td valign="top">
			<h2>REFERENCES</h2>

			<table border="1">
				<tr>
					<td>LEARNER</td>
					<td>#get_learner.user_firstname# #get_learner.user_name# // #u_id#</td>
				</tr>
				<tr>
					<td>ACCOUNT</td>
					<td>#get_account.account_name# // #a_id#</td>
				</tr>
				
			</table>
		</td>
				
		<td valign="top">
		
			<h2>ORDER TO CREATE</h2>
			<table border="1">
				<tr>
					<td>ORDER</td>
					<td>#o_id#</td>
				</tr>
				<tr>
					<td>ORDER DATE</td>
					<td><cfif opport_date neq "">#dateformat(opport_date,'yyyy-mm-dd')#<cfelse>#dateformat(now(),'yyyy-mm-dd')#</cfif></td>
				</tr>
				<tr>
					<td>ORDER CLOSE</td>
					<td><cfif opport_date neq "">#dateformat(opport_date,'yyyy-mm-dd')#<cfelse>null</cfif></td>
				</tr>
				<tr>
					<td>FORMATION ID</td>
					<td>#order_formation#</td>
				</tr>
				<tr>
					<td>STATUS CS</td>
					<td>#user_status#</td>
				</tr>
				<tr>
					<td>STATUS FIN</td>
					<td>#order_status# // #get_status_finance.status_finance_id#</td>
				</tr>
				<tr>
					<td>ORDER REF</td>
					<td>#o_id#</td>
				</tr>
				<tr>
					<td>ORDER REF CLIENT</td>
					<td>#order_ref#</td>
				</tr>
				<tr>
					<td>DEBUT APC</td>
					<td>#order_start#</td>
				</tr>
				<tr>
					<td>FIN APC</td>
					<td>#order_end#</td>
				</tr>
				<tr>
					<td>ORDER MODE</td>
					<td>#order_invoice_mode# // #get_mode.order_mode_id#</td>
				</tr>
				<tr>
					<td>ORDER CONTEXT</td>
					<td>#order_context# // #get_context.context_id#</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
		
<cfif isdefined("build")>

	<!--- pack_id undefined dans insert --->
	<!--- 	<cfif pack_id neq "">#pack_id#,<cfelse>null,</cfif> --->
	<cfquery name="insert_order" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO orders
	(
	order_status_id,
	user_id,
	account_id,
	provider_id,
	order_ref,
	order_ref2,
	order_date,
	<!---order_close,--->
	order_start,
	order_end,
	context_id,
	formation_id
	)
	VALUES
	(
	#get_status_finance.status_finance_id#,
	#u_id#,
	#a_id#,
	<cfif provider_id neq "">#provider_id#,<cfelse>null,</cfif>
	'#o_id#',
	<cfif order_ref neq "">'#order_ref#',<cfelse>"",</cfif>
	<cfif opport_date neq "">'#dateformat(opport_date,'yyyy-mm-dd')#',<cfelse>'#dateformat(now(),'yyyy-mm-dd')#',</cfif>
	<!---<cfif opport_date neq "">'#dateformat(opport_date,'yyyy-mm-dd')#',<cfelse>null,</cfif>--->
	<cfif order_start neq "">'#order_start#',<cfelse>null,</cfif>
	<cfif order_end neq "">'#order_end#',<cfelse>null,</cfif>
	#get_context.context_id#,
	#order_formation#
	);

	</cfquery>

	<cfquery name="get_max_order" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(order_id) as id FROM orders
	</cfquery>
	
	<cfquery name="updt_order" datasource="#SESSION.BDDSOURCE#">
	UPDATE orders SET order_md = '#hash(get_max_order.id)#' WHERE order_id = #get_max_order.id#
	</cfquery>

	<cfquery name="insert_order_user" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO `orders_users`(`order_id`, `user_id`) 
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_order.id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			)
	</cfquery>
		

</cfif>
		
		
		
		
		
		


<cfif isdefined("build")>
<h2>S'il n'y a pas eu d'erreur, l'import s'est d&eacute;roul&eacute; correctement.... ORDER ID = <cfoutput>#get_max_order.id#</cfoutput></h2>
</cfif>




<br>

<div align="center">
<a href="#cgi.script_name#?#cgi.query_string#&build=1" style="padding:10px; background-color:##FFA100">INSERT LMS</a>
</div>



</cfoutput>

</cfif>

</cfif>

</cfprocessingdirective>
