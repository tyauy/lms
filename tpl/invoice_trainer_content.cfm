
<!--------------------------------------------------------------------->
<html>

<body>

	<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellspacing="15">
		<tr>
			<td>
				<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5"
					cellspacing="5">
					<tr scope="row" style="vertical-align:top; line-height: 1.5;" width="100%">
						<!--- <td width="5%"></td> --->
						<td width="40%">
							<!--- <br>
							<strong> WEFIT GROUP</strong><br>
							168 rue de la Convention,<br>
							75015 PARIS, FRANCE<br>
							finance@wefitgroup.com<br>
							Tel : 01 83 62 32 47 --->
						</td>

						<td width="40%">

							<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; border: 1px solid black;" width="100%"
								cellpadding="5" cellspacing="0">
								<!--- <tr>
									<th style="background-color:#cb2339; color:white;">Facturé à:</th>
								</tr> --->
								<tr style="line-height: 1.5;">
									<td>
										<div style="margin-top:5px;">
											<cfoutput query="get_user">
												<strong>
												#user_firstname# #user_name#<br>
												<br>
												#payment_address# <br>
												#payment_postal# #payment_city# <br>
												#payment_country#
												</strong>
											</cfoutput>
										</div>
									</td>
								</tr>
							</table>




						</td>
						<!--- <td width="5%"></td> --->
					</tr>
					<tr scope="row" width="100%" style="vertical-align:top;">
						<td width="40%">


							<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%"
								cellpadding="5" cellspacing="0">
								<!--- <tr>
									<th style="background-color:#cb2339; color:white;">Ref dossier :</th>
									<th style="background-color:#cb2339; color:white;">Date : </th>
								</tr> --->
								<tr>
									<td align="right" bgcolor="#ECECEC">Date</td>
									<td align="left">PARIS, LE <cfoutput>#LSDateFormat(now(),'dd/mm/yyyy', 'fr')#</cfoutput></td>
								</tr>
								<tr>
									<td align="right" bgcolor="#ECECEC">Réf trainer :</td>
									<td align="left"><cfoutput>#get_user.user_alias#</cfoutput></td>
								</tr>
								<tr>
									<td align="right" bgcolor="#ECECEC">Période :</td>
									<td align="left"><cfoutput>#periode_name#</cfoutput></td>
								</tr>
								<tr>
									<td align="right" bgcolor="#ECECEC">Total formation (h) :</td>
									<td align="left"><cfoutput>#numberformat(total_hours / 60,"____.__")#</cfoutput></td>
								</tr>
							</table>




						</td>
						<td width="40%" bgcolor="#ECECEC">
							<!--- <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%"
								cellpadding="5" cellspacing="0" bgcolor="#ECECEC"> --->
								<!--- <tr>
									<th style="background-color:#cb2339; color:white;">Ref dossier :</th>
									<th style="background-color:#cb2339; color:white;">Date : </th>
								</tr> --->
								<cfoutput>
									#replaceNoCase(get_user.payment_iban, chr(10),"<br>", "all")#
									<cfif get_user.payment_siret neq "">
										<br>#get_user.payment_siret#
									</cfif>
								</cfoutput>
								<!--- <tr>
									<td align="right">Bank name:</td>
									<td align="left">Transferwise</td>
								</tr>
								<tr>
									<td align="right">Account owner :</td>
									<td align="left">Claytina Reddy</td>
								</tr>
								<tr>
									<td align="right">Account Number:</td>
									<td align="left">BE93 9671 6563 7667</td>
								</tr>
								<tr>
									<td align="right">Swift code:</td>
									<td align="left">TRWIBEB1XXX</td>
								</tr> --->
							<!--- </table> --->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div align="center" style="font-size:17px; padding: 15px;" bgcolor="#ECECEC"><strong> TRAINER INVOICE : <cfoutput>#get_user.user_alias# - #msel##ysel#</cfoutput> </strong></div>
			</td>
		</tr>
		<tr>
			<td>
				<!------ ORDER CONTENT AND PRICES ------>
				<div width="100%" align="left" style="line-height: 1.5;">
					<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;"
						width="100%" cellpadding="5" cellspacing="1">
						<tr align="center" bgcolor="#ECECEC">
							<td colspan="2"><strong>SUMMARY</strong></td>
							<td><strong>AMOUNT</strong></td>
							<td><strong>PRICE/H</strong></td>
							<td><strong>TOTAL</strong></td>
						</tr>

					<cfoutput query="get_total">
							
						<tr bgcolor="##FFFFFF">
							<td colspan="2">#cat_name# #formation_code# #method_name#</td>

							<td align="center">#numberformat(total_dur / 60,"____.__")#</td>

							<td align="center">#pricing_amount# &euro;</td>

							<td align="center">#numberformat(amount_total,"____.__")# &euro;</td>
						</tr>
					</cfoutput>

					<cfoutput>
						<tr>
							<td colspan="3"></td>
							<td bgcolor="##FAFAFA" align="left"><strong>Total HT</strong></td>
							<td bgcolor="##FFFFFF" align="right">
								<cfoutput>#numberformat(total_amount,'____.__')# &euro;</cfoutput>
							</td>
						</tr>
						<tr>
							<cfif get_user.tva_rate neq "">
								<cfset tva_price=total_amount*(get_user.tva_rate/100)>
							<cfelse>
								<cfset tva_price=total_amount*0>
							</cfif>
							<td colspan="3"></td>
							<td bgcolor="##FAFAFA" align="left">TVA #get_user.tva_rate#%</td>
							<td bgcolor="##FFFFFF" align="right">
								<cfoutput>#numberformat(tva_price,'____.__')# &euro;</cfoutput>
							</td>
						</tr>
						<tr>
							<cfset price_ttc=evaluate('#total_amount# + #tva_price#')>
							<td colspan="3"></td>
							<td bgcolor="##FAFAFA" align="left">Total TTC</td>
							<td bgcolor="##FFFFFF" align="right">
								<cfoutput>#numberformat(price_ttc,'____.__')# &euro;</cfoutput>
							</td>
						</tr>
					</cfoutput>

				</table>

			</div>
		</td>
	</tr>

	<tr></tr>

	<tr>
		<td>
			<cfoutput>
				<div style="width: 100%;">
					<div style="float: left; border: 1px solid black; height: 150px; width: 250px;">
						<p>WEFIT</p>
						<p>Représenté par M. Vincent GEST</p>

						<div align="center">
							<img src="http://winegroup.synten.com/gateway/img/signature_wefit.jpg" width="150px" align="center"><br><br>
						</div>

					</div>
					<div style="margin-left: 370px; border: 1px solid black; height: 150px; width: 260px;">
						<p>Signature Formateur WEFIT</p>
					</div>
				</div>
			</cfoutput>
		</td>
	</tr>

	<!--- <tr>
		<td>
			<cfoutput>
				<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: black;"
					width="100%" cellpadding="5" cellspacing="1">
					<tr style="line-height: 1.5; text-align:center;" bgcolor="##FFFFFF">

						<td>
							<!--- POUR FACTURE B2C
Aucun escompte n'est consenti pour paiement comptant.<br>
Intérêts de retard : 3 fois le taux d'intérêt légal.<br>
Règlement par virement :<br>						
SOCIÉTÉ GÉNÉRALE<br>						
N° IBAN : FR76 3000 3018 8500 0209 5416 211<br>						
CODE SWIFT : SOGEFRPP<br> --->
							Règlement par Carte Bancaire <br>
							<br>
							N° TVA INTRA : FR34510689649<br>
							N° SIRET : 510 689 649 00034<br>
							CODE NAF : 7022Z / SIREN : 516 689 649<br>
						</td>
					</tr>
				</table>
			</cfoutput>
		</td>
	</tr> --->
	</table>
</body>

</html>