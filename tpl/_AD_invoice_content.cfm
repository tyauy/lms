<html>
<body>

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellspacing="15">
<tr><td>
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="5">	
	<tr scope="row" style="vertical-align:top; line-height: 1.5;" width="100%">
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
				<cfoutput query="get_account">
					#account_f_name#<br>
					<cfif isdefined('account_f_address') AND account_f_address neq "">
					#account_f_address#, <br>
					#account_f_postal# #account_f_city#, #account_country_name# <br>
					</cfif>
					<cfif isdefined('account_email') AND account_email neq "">
					#account_email# <br>
					</cfif>
					<cfif isdefined('account_phone') AND account_phone neq "">
					#user_phone#
					</cfif>
				</cfoutput>
				</div>
				</td>
			</tr>
			</table>	
		
		
				
			
		</td>

	</tr>
	<cfoutput query="get_invoice">

	<tr scope="row" width="100%" style="vertical-align:top;">

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
		
		<div width="100%" align="left" style="line-height: 1.5;">
						
						
						
						
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: #999999" width="100%" cellpadding="5" cellspacing="1">
				<tr align="center" bgcolor="#ECECEC">
					<td><strong>Désignation</strong></td>
					<td><strong>Qté</strong></td>
					<td><strong>Unité</strong></td>
					<td><strong>Prix unitaire</strong></td>
					<td><strong>Montant</strong></td>
				</tr>
				
				
				<cfif nbh neq "0">
				<tr bgcolor="##FFFFFF">
					<td <cfif fees neq "0">rowspan="2"</cfif>>#package_name#</td>
					<td>#nbh#</td>
					<td>heures</td>
					<td>#evaluate('numberformat(#unit_price#,"____.__")')# &euro;</td>
					<td>#evaluate('numberformat(#nbh_amount#,"____.__")')# &euro;</td>	
				</tr>
				</cfif>
				<cfif fees neq "0">
				<tr bgcolor="##FFFFFF">
					<cfif nbh eq "0">
					<td>#package_name#</td>
					</cfif>
					<td colspan="3">fees</td>
					<td>#evaluate('numberformat(#fees#,"____.__")')# &euro;</td>	
				</tr>
				</cfif>
				
								
				<tr>
					<td bgcolor="##FAFAFA" colspan="4" align="left"><strong>Total HT</strong></td>
					<td bgcolor="##FFFFFF" align="right">#numberformat(amount_ht,'____.__')# &euro;</td>
				</tr>
				<tr>
				<!--- ACCOUNT'S TVA --->
					<td bgcolor="##FAFAFA" colspan="4" align="left">TVA 20%</td>
					<td bgcolor="##FFFFFF" align="right">#numberformat(tva_amount,'____.__')# &euro;</td>
				</tr>
				<tr>
					<cfset price_ttc = #evaluate('#invoice_amount# + #tva_price#')#>
					<td bgcolor="##FAFAFA" colspan="4" align="left">Total TTC</td>
					<td bgcolor="##FFFFFF" align="right">#numberformat(amount_ttc,'____.__')# &euro;</td>
				</tr>
			</table>
								

		</div>
</td></tr>


<tr></tr>

<tr><td>
<cfoutput>
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: black;" width="100%" cellpadding="5" cellspacing="1">
<tr  style="line-height: 1.5; text-align:center;" bgcolor="##FFFFFF">

<td>

Aucun escompte n'est consenti pour paiement comptant.<br>
Intérêts de retard : 3 fois le taux d'intérêt légal.<br>
Règlement par virement :<br>						
SOCIÉTÉ GÉNÉRALE<br>						
N° IBAN : FR76 3000 3018 8500 0209 5416 211<br>						
CODE SWIFT : SOGEFRPP<br>		
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