<!---<cfdump var="#CGI.query_string#">--->


<!-------------INSERT ------------------>

<cfquery name="get_invoice" datasource="#SESSION.BDDSOURCE#">
SELECT invoice_id FROM invoice WHERE invoice_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#inv_ref#">
</cfquery>

<cfset inv_id = get_invoice.recordCount GT 0 ? get_invoice.invoice_id : -1>

<cfif get_invoice.recordcount neq "0">
INVOICE DEJA EXISTANT : <cfoutput>#inv_id#</cfoutput>
</cfif>
<!--- <cfelse> --->

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_name, account_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">
</cfquery>

<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT o.order_id, f.formation_name_fr FROM orders o
LEFT JOIN lms_formation f ON f.formation_id = o.formation_id
WHERE order_ref = <cfqueryparam cfsqltype="cf_sql_varchar" value="#o_id#">
</cfquery>

<cfquery name="get_status_invoice" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM invoice_status WHERE status_name = '#inv_status#'
</cfquery>

<cfquery name="get_opca_direct" datasource="#SESSION.BDDSOURCE#">
SELECT account_name, account_id FROM account WHERE account_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#opca_id#">
</cfquery>

<cfquery name="get_delay" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_delay WHERE delay_name = '#inv_delay#'
</cfquery>

<cfif get_account.recordcount eq "0">
PROBLEME ACCOUNT ID : <cfoutput>#inv_ref#</cfoutput>
<cfabort>
</cfif>

<cfif get_opca_direct.recordcount eq "0">
<!---- TRAITEMENT DIRECT ---->
<cfset opca_id = get_account.account_id>
<cfelse>
<!---- TRAITEMENT OPCA ---->
<cfset opca_id = get_opca_direct.account_id>

<cfif opca_id eq 987>
	<cfset opca_id = get_account.account_id>
</cfif>

</cfif>



<cfif get_status_invoice.recordcount eq "0">
PROBLEME STATUS INVOICE : <cfoutput>#inv_ref#</cfoutput>
<cfabort>
</cfif>

<cfif get_order.recordcount eq "0">
PROBLEME ORDER ID : <cfoutput>#inv_ref#</cfoutput>
<cfabort>
</cfif>

<cfif get_delay.recordcount eq "0">
PROBLEME DELAY : <cfoutput>#inv_ref#</cfoutput>
<cfabort>
</cfif>

<cfoutput>
<table border="1">
	<tr>
		<td bgcolor="##ECECEC">ORDER REF</td>
		<td>#o_id#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">ORDER ID</td>
		<td>#get_order.order_id#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">ACCOUNT</td>
		<td>#a_id# // #get_account.account_name#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">OPCA DIRECT</td>
		<td>#opca_id# // <cfif get_opca_direct.recordcount neq "0">#get_opca_direct.account_name#</cfif></td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">STATUS</td>
		<td>#get_status_invoice.status_name# // #get_status_invoice.status_id#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">DATE START</td>
		<td>#dateformat(inv_start,'yyyy-mm-dd')#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">DATE END</td>
		<td>#dateformat(inv_end,'yyyy-mm-dd')#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">DATE EDITION</td>
		<td>#dateformat(inv_date,'yyyy-mm-dd')#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">ECHEANCE</td>
		<td>#dateformat(inv_limit,'yyyy-mm-dd')#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">DATE PAIEMENT</td>
		<td><cfif inv_paid neq "">#dateformat(inv_paid,'yyyy-mm-dd')#</cfif></td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">PAIEMENT</td>
		<td>#get_delay.delay_name# // #get_delay.delay_id#</td>
	</tr>
</table>
<br><br>
<table border="1">
	<tr>
		<td bgcolor="##ECECEC">REF WEFIT</td>
		<td>#inv_ref#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">REF PAIEMENT WEFIT</td>
		<td>#inv_ref_paid#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">REF CLIENT</td>
		<td>#inv_ref_paid_client#</td>
	</tr>
</table>
<br><br>
<table border="1">
	<tr>
		<td bgcolor="##ECECEC">H VISIO</td>
		<td>#inv_h_visio#</td>
		<td rowspan="4">
		#inv_h_eur# &euro;
		</td>
		<cfif inv_fees_eur neq "">
		<td rowspan="4">		
		FEES :<br>
		#inv_fees_eur# &euro;		
		</td>
		</cfif>
		<cfif inv_epf_eur neq "">
		<td rowspan="4">
		OTHER :<br>
		#inv_epf_eur# &euro;		
		</td>
		</cfif>
		<td rowspan="4">
		TOTAL :<br>
		#inv_total_eur# &euro;		
		</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">H F2F</td>
		<td>#inv_h_f2f#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">H IMM</td>
		<td>#inv_h_imm#</td>
	</tr>
	<tr>
		<td bgcolor="##ECECEC">H EL</td>
		<td>#inv_h_el#</td>
	</tr>
</table>


<!--- TEMP ? for import opca defi --->
<!--- <cfif isdefined("build")> --->

<!--- <cfquery name="insert_invoice" datasource="#SESSION.BDDSOURCE#" result="insert_inv">
INSERT INTO invoice
(
account_id,
order_id,
status_id,
delay_id,
invoice_ref,
invoice_paid_ref,
invoice_paid_ref_client,
invoice_amount,
invoice_date,
invoice_limit,
invoice_paid
<!---invoice_name,
invoice_instructions,
invoice_complement,
invoice_details--->
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#opca_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_order.order_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_status_invoice.status_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_delay.delay_id#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#inv_ref#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#inv_ref_paid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#inv_ref_paid_client#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(inv_total_eur,',','.','ALL')#">,
<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(inv_date,'yyyy-mm-dd')#">,
<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(inv_limit,'yyyy-mm-dd')#">,
<cfif inv_paid neq ""><cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(inv_paid,'yyyy-mm-dd')#"><cfelse>null</cfif>
)
</cfquery>


<cfquery name="insert_item" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO invoice_item
	(
	invoice_id,
	item_price_total
	item_price_unit,
	item_qty
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_inv.generatedkey#">,
	<cfif inv_epf_eur neq "">
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(inv_epf_eur,',','.','ALL')#">,
	<cfelseif inv_fees_eur neq "">
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(inv_fees_eur,',','.','ALL')#">,
	<cfelse>
		NULL,
	</cfif>

	<cfif inv_h_eur neq "" AND inv_h_visio neq "">
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(inv_h_eur,',','.','ALL')#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#replacenocase(inv_h_visio,',','.','ALL')#">
	<cfelse>
		NULL,
		NULL,
	</cfif>

	)
</cfquery> --->

<!--- o_id=20-5774&a_id=673&opca_id=495&inv_status=PAID&inv_date=44200&inv_limit=44230&inv_paid=44200&inv_ref=FRWE2101002&inv_ref_paid=0486445655S&
inv_ref_paid_client=&inv_bank=SOGE&inv_delay=30%20JOURS%20NET&inv_h_visio=&inv_h_f2f=&inv_h_imm=&inv_h_el=&inv_h_eur=0&inv_fees_eur=32,5&inv_epf_eur=&inv_total_eur=32,5 --->

<cfset total_h = 0 + replacenocase((inv_h_visio neq "" ? inv_h_visio : 0),',','.','ALL') + replacenocase((inv_h_f2f neq "" ? inv_h_f2f : 0),',','.','ALL') + replacenocase((inv_h_imm neq "" ? inv_h_imm : 0),',','.','ALL') + replacenocase((inv_h_el neq "" ? inv_h_el : 0),',','.','ALL')> 

<cfset _bank_id = 1>
<cfswitch expression="#inv_bank#">
	<cfcase value="SOGE"><cfset _bank_id = 1></cfcase>
	<cfcase value="PAYPAL > SOGE"><cfset _bank_id = 1></cfcase>
	<cfcase value="CCOOP"><cfset _bank_id = 2></cfcase>
	<cfcase value="QONTO DE"><cfset _bank_id = 3></cfcase>
	<cfcase value="QONTO FR"><cfset _bank_id = 4></cfcase>
	<cfcase value="QONTO"><cfset _bank_id = 4></cfcase>
	<cfdefaultcase></cfdefaultcase> 
</cfswitch>


<cfinvoke component="api/orders/orders_post" method="insert_invoice" returnvariable="cur_invoice_id">
	
	<cfinvokeargument name="invoice_id" value="#inv_id#">

	<!--- ?? --->
	<cfinvokeargument name="account_id" value="#opca_id#"> 
	
	<cfinvokeargument name="order_id" value="#get_order.order_id#">
	<cfinvokeargument name="invoice_status_id" value="#get_status_invoice.status_id#">
	<cfinvokeargument name="invoice_ref" value="#inv_ref#">
	<cfinvokeargument name="invoice_paid_ref" value="#inv_ref_paid#">
	<cfinvokeargument name="invoice_paid_ref_client" value="#inv_ref_paid_client#">

	<cfinvokeargument name="invoice_date" value="#dateformat(inv_date,'yyyy-mm-dd')#">
	<cfif inv_limit neq ""><cfinvokeargument name="invoice_limit" value="#dateformat(inv_limit,'yyyy-mm-dd')#"></cfif>
	<cfif inv_paid neq ""><cfinvokeargument name="invoice_paid" value="#dateformat(inv_paid,'yyyy-mm-dd')#"></cfif>

	<cfif inv_start neq ""><cfinvokeargument name="invoice_start" value="#dateformat(inv_start,'yyyy-mm-dd')#"></cfif>
	<cfif inv_end neq ""><cfinvokeargument name="invoice_end" value="#dateformat(inv_end,'yyyy-mm-dd')#"></cfif>


	<cfinvokeargument name="delay_id" value="#get_delay.delay_id#">

	<cfinvokeargument name="item_inv_hour" value="#total_h#">
	
	<cfinvokeargument name="item_inv_unit_price" value="#replacenocase((inv_h_eur neq "" ? inv_h_eur : 0),',','.','ALL')#">
	<cfinvokeargument name="item_inv_fee" value="#replacenocase((inv_fees_eur neq "" ? inv_fees_eur : 0),',','.','ALL')#">
	<cfinvokeargument name="item_inv_total" value="#replacenocase((inv_total_eur neq "" ? inv_total_eur : 0),',','.','ALL')#">

	<!--- <cfinvokeargument name="invoice_tva_rate" value="#inv_ref#"> --->

	<cfinvokeargument name="total_hc" value="#replacenocase((inv_total_eur neq "" ? inv_total_eur : 0),',','.','ALL')#">
	<!--- <cfinvokeargument name="total_ttc" value="#inv_ref#"> --->


	<cfinvokeargument name="invoice_bank_id" value="#_bank_id#">



	<cfinvokeargument name="invoice_item_count" value="1">

	<cfinvokeargument name="item_id_1" value="-1">

	<cfinvokeargument name="item_name_1" value="#get_order.formation_name_fr#">
	<cfinvokeargument name="item_inv_hour_1" value="#total_h#">
	<cfinvokeargument name="item_nb_users_1" value="1">
	<cfinvokeargument name="item_inv_unit_price_1" value="#replacenocase((inv_h_eur neq "" ? inv_h_eur : 0),',','.','ALL')#">
	<cfinvokeargument name="item_inv_fee_1" value="#replacenocase((inv_fees_eur neq "" ? inv_fees_eur : 0),',','.','ALL')#">
	<cfinvokeargument name="item_inv_total_1" value="#replacenocase((inv_total_eur neq "" ? inv_total_eur : 0),',','.','ALL')#">

</cfinvoke>


<!--- L'INVOICE #inv_ref# a été ajouté avec l'identifiant  --->
#cur_invoice_id#

<!--- <cfelse>
	<div align="center">
		<a href="#cgi.script_name#?#cgi.query_string#&build=1" style="padding:10px; background-color:##FFA100">
			<cfif get_invoice.recordcount neq "0">
				UPDATE LMS
			<cfelse>
				INSERT LMS
			</cfif>
			
		</a>
	</div>
</cfif> --->

</cfoutput>
