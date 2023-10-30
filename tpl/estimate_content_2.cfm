<cfif page eq "0">
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>CONVENTION DE FORMATION PROFESSIONNELLE</cfoutput></h2>					

					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<h3>ENTRE LES SOUSSIGN&Eacute;S</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="20" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="center">
<strong>WEFIT GROUP</strong><br>
168 rue de la Convention - 75015 PARIS<br>
Soci&eacute;t&eacute; immatricul&eacute;e sous le num&eacute;ro de Siret 510 689 649 00034 au RCS de Paris.<br><br>
Repr&eacute;sent&eacute;e par Monsieur Vincent GEST en qualit&eacute; de Pr&eacute;sident.<br>
D&eacute;claration d'activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d'Ile de France.<br>
<br><br>
ci-apr&egrave;s : <strong>L'ORGANISME DE FORMATION</strong>

					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:0px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<h3>ET</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="20" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="center">
<cfoutput>
<strong>#a_company#</strong>
<br>
#a_address#
<br>
#a_zipcode# #a_city# - #a_country#
<br>
									
Repr&eacute;sent&eacute;e par #a_ctc#
<br>
</cfoutput>
<br><br>
ci-apr&egrave;s : <strong>LE CLIENT</strong>

					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
	Est conclue la convention suivante, en application des dispositions du Livre IX du Code du Travail portant sur l'organisation de la formation professionnelle continue dans le cadre de l'&Eacute;ducation permanente.
	

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>           

</body>
</html>

<cfelseif page eq "1">

<cfset ht_total = "0">

<cfif f_learner lt 1>
<cfset f_learner = 1>
</cfif>


<cfif training_pack eq "card">

	<cfquery name="get_price_unit" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM account_group_price WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#">
	</cfquery>

	<cfset visio_pu = amount_training_pu>
	<cfset visio_q = f_h>
	<cfset visio_forfait = "0">

	<cfif visio_forfait neq "0">
	<cfset visio_total = visio_forfait*f_learner>
	<cfelse>
	<cfif visio_pu neq "" AND visio_q neq "">
	<cfset visio_total = (visio_pu*visio_q)*f_learner>
	<cfelse>
	<cfset visio_total = 0>
	</cfif>
	</cfif>


	<cfset certif_pu = "70">
	<cfif f_certif eq "1">
	<cfset certif_q = f_learner>
	<cfelse>
	<cfset certif_q = 0>
	</cfif>
	<cfset certif_forfait = "0">

	<cfif certif_forfait neq "0">
	<cfset certif_total = certif_forfait*f_certif>
	<cfelse>
	<cfif certif_pu neq "" AND certif_q neq "">
	<cfset certif_total = (certif_pu*certif_q)*f_certif>
	<cfelse>
	<cfset certif_total = 0>
	</cfif>
	</cfif>

	 
	<cfset f2f_pu = "">
	<cfset f2f_q = "">
	<cfset f2f_forfait = "0">

	<cfif f2f_forfait neq "0">
	<cfset f2f_total = f2f_forfait>
	<cfelse>
	<cfif f2f_pu neq "" AND f2f_q neq "">
	<cfset f2f_total = (f2f_pu*f2f_q)*f_learner>
	<cfelse>
	<cfset f2f_total = 0>
	</cfif>
	</cfif>

	<cfset el_pu = "">
	<cfset el_q = "">
	<cfset el_forfait = "0">

	<cfif el_forfait neq "0">
	<cfset el_total = el_forfait>
	<cfelse>
	<cfif el_pu neq "" AND el_q neq "">
	<cfset el_total = (el_pu*el_q)*f_learner>
	<cfelse>
	<cfset el_total = 0>
	</cfif>
	</cfif>
	 
	<cfset imm_pu = "">
	<cfset imm_q = "">
	<cfset imm_forfait = "0">

	<cfif imm_forfait neq "0">
	<cfset imm_total = imm_forfait>
	<cfelse>
	<cfif imm_pu neq "" AND imm_q neq "">
	<cfset imm_total = (imm_pu*imm_q)*f_learner>
	<cfelse>
	<cfset imm_total = 0>
	</cfif>
	</cfif>
	
	<cfset ht_total = visio_total+f2f_total+el_total+imm_total+certif_total>
	<cfset tva_total = ht_total*0.2>
	<cfset ttc_total = ht_total+tva_total>
 
<cfelseif training_pack eq "pack">

	<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
	SELECT fp.*, f.formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation_pack fp
	INNER JOIN lms_formation f ON f.formation_id = fp.formation_id
	WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>
	
	<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
	SELECT sm.*, tc.sessionmaster_schedule_duration, tp.tpmaster_name
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
	WHERE tp.tpmaster_prebuilt = 1 AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation_pack.formation_id#">
	AND tp.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tppack_id#">
	ORDER BY tc.sessionmaster_rank ASC 
	</cfquery>	

	<cfif SESSION.GROUP_PRICE_REDUCTION neq "0">
		<cfset ht_unit = round((((100-SESSION.GROUP_PRICE_REDUCTION)/100)*get_formation_pack.pack_amount_ht))>
		<cfset ht_total = ht_unit*f_learner>
	<cfelse>
		<cfset ht_unit = round(get_formation_pack.pack_amount_ht)>
		<cfset ht_total = ht_unit*f_learner>
	</cfif>
	
	
		
	<cfset tva_total = ht_total*0.2>
	<cfset ttc_total = ht_total+tva_total>

</cfif>

 
 
 

<!---------------------CONTENT ESTIMATE----------------------->

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td width="60%" align="center">
					</td>
					<td width="40%" align="center">
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; background-color:#FAFAFA" width="100%" cellpadding="10">
							<tr>
								<td>
								<!--- <cfif isdefined("a_id")> --->
									<!--- <cfoutput> --->
									<!--- <strong>#get_account.account_name#</strong> --->
									<!--- <br> --->
									<!--- #get_account.account_address#<cfif get_account.account_address2 neq ""><br> - #get_account.account_address2#</cfif> --->
									<!--- <br> --->
									<!--- #get_account.account_postal# #get_account.account_city# --->
									<!--- <br> --->
									<!--- #get_account.account_country# --->
									<!--- </cfoutput> --->
								<!--- <cfelse> --->
									<cfoutput>
									<strong>#a_company#</strong>
									<br>
									#a_address#
									<br>
									#a_zipcode# #a_city# - #a_country#
									<br>
									#a_ctc#
									</cfoutput>
								<!--- </cfif> --->
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top" align="center">
						<h2>DEVIS DE FORMATION</h2>
						<h3><cfoutput>#dateformat(now(),'dd/mm/yyyy')#</cfoutput></h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top" align="center">
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: #999999" width="100%" cellpadding="5" cellspacing="1">
							<tr align="center" bgcolor="#ECECEC">
								<td colspan="2"><strong>D&eacute;signation</strong></td>
								<td><strong>Apprenant(s)</strong></td>
								<td><strong>Qt&eacute;</strong></td>
								<td><strong>Unit&eacute;</strong></td>
								<td><strong>Prix unitaire</strong></td>
								<td><strong>Total</strong></td>
							</tr>
							<tr bgcolor="#FAFAFA">
								<td colspan="7"><strong>FORMATION</strong></td>
							</tr>
							<cfif training_pack eq "card">
							<cfoutput>
							<tr bgcolor="##FFFFFF">
								<td width="20" align="center"><img src="./assets/img/picto_methode_1.png" width="30"></td>
								<td>Visio-conf&eacute;rence</td>
								<td align="center" width="30">#f_learner#</td>
								<td align="center">#visio_q#</td>
								<td align="center">heure(s)</td>
								<td align="center"><cfif visio_total neq "0">#visio_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif visio_total neq "0">#numberformat(visio_total,'____.__')# &euro;<cfelse>-</cfif></td>
							</tr>
							<!---<tr bgcolor="##FFFFFF">
								<td align="center"><img src="./assets/img/picto_methode_3.png" width="30"></td>
								<td>e-Learning</td>
								<td align="center"><cfif f_package eq "en" OR f_package eq "de">#f_learner#</cfif></td>
								<td align="center"><cfif f_package eq "en" OR f_package eq "de">12<cfelse>#el_q#</cfif></td>
								<td align="center">mois</td>
								<td align="center"><cfif el_total neq "0">#el_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif f_package eq "en" OR f_package eq "de">inclus<cfelse><cfif el_total neq "0">#numberformat(el_total,'____.__')# &euro;<cfelse>-</cfif></cfif></td>
							</tr>	
							<tr bgcolor="##FFFFFF">
								<td align="center"><img src="./assets/img/picto_methode_2.png" width="30"></td>
								<td>Pr&eacute;sentiel</td>
								<td align="center"></td>
								<td align="center">#f2f_q#</td>
								<td align="center">heure(s)</td>
								<td align="center"><cfif f2f_total neq "0">#f2f_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif f2f_total neq "0">#numberformat(f2f_total,'____.__')# &euro;<cfelse>-</cfif></td>
							</tr>	
							<tr bgcolor="##FFFFFF">
								<td align="center"><img src="./assets/img/picto_methode_6.png" width="30"></td>
								<td>Immersion</td>
								<td align="center"></td>
								<td align="center">#imm_q#</td>
								<td align="center">heure(s)</td>
								<td align="center"><cfif imm_total neq "0">#imm_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif imm_total neq "0">#numberformat(imm_total,'____.__')# &euro;<cfelse>-</cfif></td>
							</tr>--->
							<tr bgcolor="##FFFFFF">
								<td align="center"><img src="./assets/img/picto_methode_7.png" width="30"></td>
								<td>Certification</td>
								<td align="center"></td>
								<td align="center"><cfif certif_q neq "0">#certif_q#</cfif></td>
								<td align="center">unit&eacute;(s)</td>
								<td align="center"><cfif certif_total neq "0">#certif_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif certif_total neq "0">#numberformat(certif_total,'____.__')# &euro;<cfelse>-</cfif></td>
							</tr>
							<tr bgcolor="##FAFAFA">
								<td colspan="7"><strong>OPTIONS</strong></td>
							</tr>
							</cfoutput>
							<cfif f_id eq "2">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ANGLAIS<br>Acc&egrave;s illimit&eacute; e-Learning ESSENTIAL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_id eq "1">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : FRAN&Ccedil;AIS<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_id eq "3">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ALLEMAND<br>Acc&egrave;s illimit&eacute; e-Learning ESSENTIAL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_id eq "4">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ESPAGNOL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_id eq "5">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ITALIEN<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							</cfif>
							
							<cfelse>
							
							<tr bgcolor="#FFFFFF">
								<td width="20" align="center"><img src="./assets/img/picto_methode_1.png" width="30"></td>
								<td width="300"><cfoutput>#get_formation_pack.pack_name#</cfoutput></td>
								<td align="center" width="30"><cfoutput>#f_learner#</cfoutput></td>
								<td align="center"></td>
								<td align="center">pack(s)</td>
								<td align="center"><cfoutput>#NumberFormat(ht_unit,'____.__')#</cfoutput> &euro;</td>
								<td align="right"><cfoutput>#NumberFormat(ht_total,'____.__')#</cfoutput> &euro;</td>
							</tr>
							
							</cfif>

							<tr>
								<td bgcolor="#FAFAFA" colspan="6" align="right"><strong>Total HT</strong></td>
								<td bgcolor="#FFFFFF" align="right"><cfoutput>#numberformat(ht_total,'____.__')# &euro;</cfoutput></td>
							</tr>
							<tr>
								<td bgcolor="#FAFAFA" colspan="6" align="right">TVA 20%</td>
								<td bgcolor="#FFFFFF" align="right"><cfoutput>#numberformat(tva_total,'____.__')# &euro;</cfoutput></td>
							</tr>
							<tr>
								<td bgcolor="#FAFAFA" colspan="6" align="right">Total TTC</td>
								<td bgcolor="#FFFFFF" align="right"><cfoutput>#numberformat(ttc_total,'____.__')# &euro;</cfoutput></td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>

		</td>
	</tr>
	
	<tr>
		<td width="100%">
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top">
						<!---<h3>COMMENTAIRES / INSTRUCTIONS SP&Eacute;CIALES</h3>
						Dur&eacute;e de formation : de 1 &agrave; 3 mois.
						<cfif f_package eq "en">
						<br>
						L'acc&egrave;s illimit&eacute; e-Learning Essential Anglais est offert sur l'ann&eacute;e 2020 dans le cadre de l'offre WE BOOST.
						</cfif>--->
						
						<h3>EFFECTIF(S) FORM&Eacute;(S)</h3><table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<cfoutput>
								<cfloop from="1" to="5" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							<cfif f_learner gt "5">
							<tr>
								<cfoutput>
								<cfloop from="6" to="10" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							</cfif>
							<cfif f_learner gt "10">
							<tr>
								<cfoutput>
								<cfloop from="11" to="15" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							</cfif>
							<cfif f_learner gt "15">
							<tr>
								<cfoutput>
								<cfloop from="16" to="20" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							</cfif>
							<cfif f_learner gt "20">
							<tr>
								<cfoutput>
								<cfloop from="21" to="25" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							</cfif>

						</table>
						<br>
						<h3>SYNTH&Egrave;SE FORMATION</h3>
						<cfinclude template="estimate_summary2.cfm">
						<br><br>
						<h3>CONDITIONS FINANCI&Egrave;RES</h3>
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="2">
							<!---<tr>
								<td bgcolor="#FAFAFA" width="20%">Conditions de r&egrave;glement</td>
								<td>50% d&eacute;but de formation / 50% &agrave; &eacute;ch&eacute;ance
								
								</td>
							</tr>--->
							<tr>
								<td bgcolor="#FAFAFA">Dur&eacute;e de validit&eacute; devis</td>
								<td>1 mois</td>
							</tr>
						</table>

					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
</table>    
  

</body>
</html>


<cfelseif page eq "2">
<!---------------------TRAINING PROGRAM----------------------->

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top" align="center">
						<h2>PROGRAMME DE FORMATION</h2>
						<h3><cfoutput>#visio_q#</cfoutput> Heures de formation VISIO</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center">			
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">		
							<cfif training_pack eq "card">
							
								<cfif visio_q lt 20>
							
								<cfset module_list_1 = "Auxiliaires Avoir et &Ecirc;tre,Pr&eacute;sent de l'indicatif,Pass&eacute;-compos&eacute; / Pass&eacute; simple,Imparfait,Imp&eacute;ratif,Futur simple,Conditionnel,Pr&eacute;positions de temps et de lieux,Verbes &agrave; pr&eacute;position,Verbes pronominaux,Nombre cardinaux et ordinaux">
								<cfset module_list_2 = "Masculin/ f&eacute;minin,Accord des adjectifs,Expressions idiomatiques,La comparaison,Liens logiques,Prononciation (le e-muet, les liaisons),Syntaxe g&eacute;n&eacute;rale,Accord des adjectifs,Interrogation,Subjonctif,Le discours rapport&eacute;">
								<cfset module_list_3 = "Usages au t&eacute;l&eacute;phone,Animer une pr&eacute;sentation,Mises en situations professionnelles,Jeux de r&ocirc;les,Entretiens">
								<cfset module_list_4 = "Participer et intervenir en r&eacute;union,Comprendre et r&eacute;diger des documents professionnels,Accueillir des visiteurs,Savoir n&eacute;gocier,D&eacute;crire des produits/ses services/son poste">
								
								<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
									<tr>
										<td colspan="4">
											<span style="font-size:14px;"><strong><cfoutput><cfif f_id eq "2">ANGLAIS<cfelseif f_id eq "1">FRAN&Ccedil;AIS<cfelseif f_id eq "3">ALLEMAND<cfelseif f_id eq "4">ESPAGNOL<cfelseif f_id eq "5">ITALIEN</cfif> - GENERAL</cfoutput></strong></span>
										</td>
									</tr>
									<cfset counter = 0>
									<cfloop list="#module_list_1#" index="cor">
									<cfoutput>
									<cfset counter++>
									<tr>
										<td bgcolor="##FFFFFF" width="45%">
											<span style="font-size:12px;">#cor#</span>
										</td>
										<td width="5%">
											<span style="font-size:12px;">X</span>
										</td>
										<td bgcolor="##FFFFFF" width="45%">
											<span style="font-size:12px;">#listgetat(module_list_2,counter)#</span>
										</td>
										<td width="5%">
											<span style="font-size:12px;">X</span>
										</td>
									</tr>
									</cfoutput>
									</cfloop>	
									<tr>
										<td colspan="4">
											<span style="font-size:14px;"><strong><cfoutput><cfif f_id eq "2">ANGLAIS<cfelseif f_id eq "1">FRAN&Ccedil;AIS<cfelseif f_id eq "3">ALLEMAND<cfelseif f_id eq "4">ESPAGNOL<cfelseif f_id eq "5">ITALIEN</cfif> - PROFESSIONNEL</cfoutput></strong></span>
										</td>
									</tr>
									<cfset counter = 0>
									<cfloop list="#module_list_3#" index="cor">
									<cfoutput>
									<cfset counter++>
									<tr>
										<td bgcolor="##FFFFFF" width="45%">
											<span style="font-size:12px;">#cor#</span>
										</td>
										<td width="5%">
											<span style="font-size:12px;">X</span>
										</td>
										<td bgcolor="##FFFFFF" width="45%">
											<span style="font-size:12px;">#listgetat(module_list_4,counter)#</span>
										</td>
										<td width="5%">
											<span style="font-size:12px;">X</span>
										</td>
									</tr>
									</cfoutput>
									</cfloop>
								</table>
								
								<cfelse>
								
								<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
						
								<tr>
									<td colspan="4" align="center">
									<h3>Programme de formation</h3>
									</td>
								</tr>
								<cfset listgo = "695,739,740,768,741,744,742,743,750,751,752,753,748,749,731,732,733,882,883,694">	
								<cfoutput>
								<cfset counter = "0">
								<cfloop list="#listgo#" index="cor">
								<cfset counter++>
								
								<cfquery name="get_session_description" datasource="#SESSION.BDDSOURCE#">
								SELECT sm.*	FROM lms_tpsessionmaster2 sm WHERE sessionmaster_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
								</cfquery>
			
								<tr>
									<td width="50" bgcolor="##FFFFFF">
										
									<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#get_session_description.sessionmaster_code#.jpg")>			
										<img src="./assets/img_material/thumbs/#get_session_description.sessionmaster_code#.jpg" width="50" align="left">
									<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#get_session_description.sessionmaster_id#.jpg")>			
										<img src="./assets/img_material/thumbs/#get_session_description.sessionmaster_id#.jpg" width="50" align="left">
									<cfelse>
										<img src="./assets/img/wefit_lesson.jpg" width="50" align="left">
									</cfif>
										
										
									</td>
									<td width="100" bgcolor="##FFFFFF">
										<span style="font-size:12px;">Cours&nbsp;#counter#</span>
									</td>
									<td width="100" bgcolor="##FFFFFF">
										<span style="font-size:12px;"><!---<cfif cor eq "695" OR cor eq "694">30<cfelse>--->60<!---</cfif>---> min</span>
									</td>
									<td bgcolor="##FFFFFF">
										<span style="font-size:12px;"><strong>#get_session_description.sessionmaster_name_fr#</strong></span>
										<br>
										#get_session_description.sessionmaster_description_fr#
									</td>
									<!---<td bgcolor="##FFFFFF">
										<span style="font-size:12px;"><strong>#sessionmaster_description#</strong></span>
									</td>--->
								</tr>
								</cfloop>
								</table>
								</cfoutput>
								
								</cfif>
							<cfelse>
								<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
							
								<tr>
									<td colspan="4" align="center">
									<h3><cfoutput>#get_sm.tpmaster_name#</cfoutput></h3>
									</td>
								</tr>
								
								<cfset counter = 0>
								<cfoutput query="get_sm">
								<cfset counter++>
								<tr>
									<td width="50" bgcolor="##FFFFFF">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
											<img src="./assets/img_material/thumbs/#sessionmaster_code#.jpg" width="50" align="left">
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>	
											<img src="./assets/img_material/thumbs/#sessionmaster_id#.jpg" width="50" align="left">
										<cfelse>
											<img src="./assets/img/wefit_lesson.jpg" width="50" align="left">
										</cfif>
									</td>
									<td width="100" bgcolor="##FFFFFF">
										<span style="font-size:12px;">Lesson&nbsp;#counter#</span>
									</td>
									<td width="100" bgcolor="##FFFFFF">
										<span style="font-size:12px;"><cfif sessionmaster_id eq "694" OR sessionmaster_id eq "695">30 min<cfelse>60 min</cfif></span>
									</td>
									<td bgcolor="##FFFFFF">
										<span style="font-size:12px;"><strong><cfif sessionmaster_name_fr neq "">#sessionmaster_name_fr#<cfelse>#sessionmaster_name#</cfif></strong></span>
										<br>
										<cfif sessionmaster_description_fr neq "">#sessionmaster_description_fr#<cfelse>#sessionmaster_description#</cfif>
									</td>
									<!---<td bgcolor="##FFFFFF">
										<span style="font-size:12px;"><strong>#sessionmaster_description#</strong></span>
									</td>--->
								</tr>
								
								</cfoutput>
								</table>	
							</cfif>	

					</td>
				</tr>		
			</table>
		</td>
	</tr>
	
</table>    
  

</body>
</html>

		
<cfelseif page eq "3">
<!---------------------MODALITÉS ----------------------->


<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top" align="center">
						<h2>MODALIT&Eacute;S P&Eacute;DAGOGIQUES</h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center">			
		
			<cfinclude template="estimate_summary2.cfm">
			
			<br>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">						
											
<br>
<strong>PUBLIC VIS&Eacute;</strong><br>
Tout public, professionnel ou particulier. La formation est adapt&eacute;e au niveau du stagiaire.

<br><br><strong>PR&Eacute;-REQUIS</strong><br>
Visioconf&eacute;rence : Sur le plan p&eacute;dagogique aucun pr&eacute;requis.
Le contenu de la formation est adapt&eacute; au niveau et aux besoins du stagiaire.
Sur le plan mat&eacute;riel : un ordinateur PC ou MAC / Une connexion Internet sont n&eacute;cessaires.


<br><br><strong>OBJECTIFS DE LA FORMATION</strong><br>
L’objectif de cette formation est de :
<br>- Consolider les acquis de l'apprenant dans la langue cible du point de vue grammatical, lexical et syntaxique
<br>- Renforcer la fluidité de son discours à l’oral
<br>- Rendre ses écrits simples ou complexes plus efficaces
<br>- Idiomatiser son usage de la langue cible
<br>- Réactiver ses connaissances passives afin de lui permettre de mobiliser sa langue cible plus rapidement et efficacementen contexte professionnel formel ou informel
<br>- Le faire gagner en confiance lorsqu'il produit un discours écrit ou oral en langue cible


<br><br><strong>BESOINS DE L'APPRENANT</strong><br>

<u>Prise de parole professionnelle :</u>
<br>
L&rsquo;apprenant a besoin d&rsquo;am&eacute;liorer compr&eacute;hension et expression orales pour &ecirc;tre plus s&ucirc;r de lui lors de conversations en langue cible, notamment quand il participe &agrave; des r&eacute;unions ou quand il r&eacute;pond au t&eacute;l&eacute;phone. Il conviendra de r&eacute;activer son vocabulaire, aujourd&rsquo;hui passif, pour lui permettre de le mobiliser activement.
<br>
<!--- <u>Conversation de tous les jours :</u><br> --->
<!--- L&rsquo;apprenant d&eacute;sire d&eacute;velopper ses comp&eacute;tences dans la langue cible pour des raisons tout d&rsquo;abord personnelles. Il souhaite apprendre cette langue pour le plaisir. Les champs d&rsquo;apprentissage sont donc libres et ont surtout pour objectif de renforcer ses acquis et de lui faire acqu&eacute;rir plus de vocabulaire pour qu&rsquo;il puisse s&rsquo;exprimer dans toute une s&eacute;rie de situations de la vie de tous les jours, plut&ocirc;t informelles.  --->
<!--- <br> --->
L&rsquo;apprenant n&rsquo;exclut pas de pouvoir ou de devoir un jour utiliser sa langue cible dans le cadre professionnel. Dans un second temps, il sera donc possible d'orienter la formation vers des aspects plus professionnels de la langue cible. Ce n&rsquo;est toutefois pas une priorit&eacute; pour l'apprenant.
<br>
<u>Compr&eacute;hension orale :</u><br>
On effectuera un travail sur la compr&eacute;hension orale. On pourra aider le collaborateur &agrave; reconstruire un message sur la base de mots ou d&rsquo;expressions cl&eacute;s, &agrave; poser les bonnes questions pour amener son interlocuteur &agrave; reformuler sa pens&eacute;e de fa&ccedil;on plus simple, et tout simplement le familiariser avec diff&eacute;rents accents et vitesses d&rsquo;&eacute;locution.
<br>
<u>Compr&eacute;hension &eacute;crite :</u><br>
L'apprenant r&eacute;alisera un travail de compr&eacute;hension &eacute;crite afin de le familiariser avec les tournures formelles et le langage de l'&eacute;criture business, presse ou acad&eacute;mique dans la langue cible.
<br>
<u>Ma&icirc;trise grammaticale &amp; syntaxique :</u><br>
Le programme visera &agrave; b&acirc;tir ou consolider un socle de connaissances grammaticales et syntaxiques en lien avec le niveau de d&eacute;part de l'apprenant. Il conviendra de reprendre les bases, identifier les lacunes et enrichir les constructions syntaxiques de l'apprenant.
<br>
<u>Travail sur la confiance en soi :</u><br>
L'apprenant a identifi&eacute; un blocage &agrave; l'heure de s'exprimer dans la langue cible. H&eacute;siter sur la langue peut donner une impression de moins performer ou d&rsquo;&ecirc;tre jug&eacute;. L&rsquo;apprenant peut &eacute;galement se sentir frustr&eacute; de ne pas trouver les mots pour exprimer sa pens&eacute;e aussi pr&eacute;cis&eacute;ment qu&rsquo;il le ferait dans sa propre langue. L&rsquo;un des enjeux de ce programme sera de lui redonner confiance en lui.
<br>
<u>D&eacute;veloppement du vocabulaire :</u><br>
L'apprenant ressent des difficult&eacute;s &agrave; exprimer pr&eacute;cis&eacute;ment sa pens&eacute;e dans la langue cible. Il a observ&eacute; qu&rsquo;il lui manque du vocabulaire. Il conviendra donc d'une part de r&eacute;activer son vocabulaire passif pour lui permettre de le mobiliser plus activement, et d'autre part, de travailler sur l'acquisition de nouveaux mots sur des th&eacute;matiques professionnelles et informelles.
<br>
<u>N&eacute;cessit&eacute; d'une langue commune :</u><br>
La phase d'&eacute;valuation a permis d'identifier que le recours &agrave; une langue commune serait n&eacute;cessaire dans le cadre de ce parcours. Les &eacute;quipes p&eacute;dagogiques de WEFIT veilleront donc &agrave; positionner sur ce programme un formateur bilingue et &agrave; adapter les supports afin de faciliter l'apprentissage.  
<br>
<u>Langue cible pour niveaux avanc&eacute;s :</u><br>
En raison du niveau d&eacute;j&agrave; avanc&eacute; de l'apprenant, tout un pan du programme sera orient&eacute; vers la ma&icirc;trise de techniques de communication pouss&eacute;es dans la langue cible (techniques de pr&eacute;sentation avanc&eacute;es, techniques de n&eacute;gociation, r&eacute;daction technique, etc.). Un travail sera r&eacute;alis&eacute; afin de rendre la langue plus idiomatique.
<br>
<u>Comp&eacute;tence linguistique &agrave; vis&eacute;e touristique :</u><br>
L&rsquo;apprenant travaillera sur la ma&icirc;trise de la langue cible dans des situations de la vie de tous les jours, notamment pour le tourisme. On abordera des th&eacute;matiques telles que la r&eacute;servation de vols et d&rsquo;h&ocirc;tels ou encore le &laquo; kit de survie &raquo; dans la langue cible.
<br>
<u>Terminologie m&eacute;tier :</u><br>
Une partie du programme sera orient&eacute;e sur l'acquisition du vocabulaire m&eacute;tier dont l'apprenant a besoin dans le cadre de ses activit&eacute;s professionnelles. Cela incluera la langue cible professionnelle transverse (comp&eacute;tences et terminologie commune &agrave; diff&eacute;rents postes: t&eacute;l&eacute;phone, email, meetings etc.), la langue cible professionnelle li&eacute;e &agrave; la fonction de l'apprenant (terminologie et usages techniques) et la langue cible professionnelle du secteur d'activit&eacute; de l'apprenant. 
<br>
<u>Comp&eacute;tence r&eacute;dactionnelle en langue cible :</u><br>
L'apprenant souhaite am&eacute;liorer sa ma&icirc;trise de la langue &eacute;crite. On travaillera sur la structure de ses &eacute;crits et le style n&eacute;cessaire &agrave; chaque type de production &eacute;crite (langue &eacute;crite du business, &eacute;crits acad&eacute;miques, communication &agrave; vis&eacute;e marketing,...). Un travail sera effectu&eacute; sur les registres de langue &agrave; l'&eacute;crit.
<br>
<u>Travail sur la compr&eacute;hension / accent :</u><br>
L&rsquo;apprenant d&eacute;sire am&eacute;liorer son accent. On inclura donc un travail sur la phon&eacute;tique et la prononciation des mots et des sons. Nous encouragerons l&rsquo;apprenant &agrave; s&rsquo;enregistrer pour qu&rsquo;il puisse prendre conscience de lui-m&ecirc;me des sons qui lui posent probl&egrave;me.
<!--- <br><br> --->
<!--- <em><u>Compr&eacute;hension des non-natifs</u></em> --->
<!--- <br><br> --->
<!--- L&rsquo;apprenant d&eacute;sire travailler sur sa compr&eacute;hension des non-natifs, qui peut poser probl&egrave;me en raison d'accents moins fr&eacute;quemment entendus dans les m&eacute;dias et des r&eacute;f&eacute;rentiels linguistiques diff&eacute;rents (i.e les non-natifs traduisent leur pens&eacute;e depuis leur propre langue, qui peut s&rsquo;av&eacute;rer tr&egrave;s diff&eacute;rente de la langue maternelle de l'apprenant). --->
<!--- <br><br> --->


<br><br><br><strong>MOYENS P&Eacute;DAGOGIQUES</strong><br>
L'&eacute;quipe p&eacute;dagogique met &agrave; disposition de l'apprenant des ressources dont la nature varie en fonction de la th&eacute;matique de chaque cours :
<br>- Ressources con&ccedil;ues par les &eacute;quipes p&eacute;dagogiques de WEFIT en vue de l'acquisition d'une comp&eacute;tence pr&eacute;cise en langue cible ou de la ma&icirc;trise d'un aspect grammatical, syntaxique ou terminologique de la langue cible &ndash; Ressources multim&eacute;dias diverses 
<br>- Ressources tir&eacute;es du contexte professionnel de l'apprenant (approche ad hoc ou ateliers) Afin de maintenir l'int&eacute;r&ecirc;t et la motivation de l'apprenant, les natures de ressources seront altern&eacute;es, tout comme l'approche du formateur.

<br><br><br><strong>CONTENUS, NATURE DES TRAVAUX DEMAND&Eacute;S ET TEMPS ESTIM&Eacute; DE R&Eacute;ALISATION</strong><br>
Visioconf&eacute;rence : Les cours auront lieu sur une plateforme de visioconf&eacute;rence et/ou par t&eacute;l&eacute;phone. Les travaux auront pour but de maximiser le temps de parole de l&rsquo;apprenant quelle que soit la ressource utilis&eacute;e. La nature des ressources varie : pr&eacute;sentations, ressources Multim&eacute;dias (vid&eacute;os, pistes audio, podcasts&hellip;), supports de travail du stagiaire&hellip; Le choix de la dur&eacute;e des cours est laiss&eacute; au stagiaire : 30min, 45min, 60min ou plus. A sa demande, le formateur peut lui proposer des exercices pour r&eacute;viser avant le prochain cours. Les exercices seront alors disponibles sur son espace personnel. Le temps estim&eacute; de r&eacute;alisation des exercices de r&eacute;vision est de 30 minutes.

<br><br><br><strong>SUIVI PÉDAGOGIQUE</strong><br>
Des &eacute;valuations de d&eacute;but et de fin de formation seront organis&eacute;es lors de chaque parcours. Une validation des acquis est effectu&eacute;e r&eacute;guli&egrave;rement au fil des modules de formation. Visioconf&eacute;rence / Pr&eacute;sentiel : Un reporting est &eacute;dit&eacute; tous les mois. Il recense l'&eacute;tat d'avancement et de r&eacute;alisation des heures et permet donc de suivre la consommation. Des &laquo; review lessons &raquo; (le&ccedil;ons de r&eacute;vision) ainsi qu'une &eacute;valuation finale ont lieu durant le parcours de formation. Des &laquo; lessons notes &raquo; sont fournies au stagiaire pour formaliser les acquis de chaque cours.


					</td>
				</tr>		
			</table>
		</td>
	</tr>
	
</table>    
  

</body>
</html>

<cfelseif page eq "4">
<!---------------------ADMIN ----------------------->


<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td valign="top" align="center">
						<h2>MODALIT&Eacute;S ADMINISTRATIVES & FINANCI&Egrave;RES</h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="100%" align="center">			
		
			<cfinclude template="estimate_summary2.cfm">
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">				
<br><br><strong>SUIVI ADMINISTRATIF</strong><br>
L'organisme de formation s'engage &agrave; transmettre la feuille d'&eacute;margement ou l'attestation de fin de formation sign&eacute;e par les diff&eacute;rentes parties. Elle reprend la date de l'action, les heures correspondantes et la d&eacute;nomination du module. Dans le cadre d'une certification &agrave; la fin de la formation, l'organisme s'engage &agrave; transmettre le certificat. Si besoin, l'organisme transmet un justificatif d'assiduit&eacute;.

<br><br><br><strong>COMP&Eacute;TENCES ET QUALIFICATIONS DES PERSONNES CHARG&Eacute;ES D'ASSISTER LE STAGIAIRE</strong><br>
Les personnes du service client charg&eacute;es d'assister les b&eacute;n&eacute;ficiaires parlent obligatoirement fran&ccedil;ais &amp; anglais, et id&eacute;alement une troisi&egrave;me langue. Ces personnes sont r&eacute;actives et p&eacute;dagogues afin d'assurer un suivi et des &eacute;changes de qualit&eacute;. Le stagiaire peut contacter le service client pour toute demande (probl&egrave;me technique, question relative au contenu des cours&hellip;) du lundi au vendredi de 8h &agrave; 18h, par mail service@wefitgroup.com ou par t&eacute;l&eacute;phone 01.83.62.32.46. Les cours peuvent &ecirc;tre programm&eacute;s &agrave; tout moment et se d&eacute;rouler sur son lieu de travail. De plus le stagiaire a acc&egrave;s &agrave; une interface personnelle 7j/7, 24h/24 gr&acirc;ce &agrave; des identifiants transmis en d&eacute;but de formation. Il peut se connecter via le site www.wefitgroup.com. Le service client s'engage &agrave; r&eacute;pondre dans les meilleurs d&eacute;lais &agrave; un email qui lui est adress&eacute; (dans l'heure qui suit), et ce notamment pour les urgences. Au plus tard, le service client r&eacute;pond dans les 24h. Lorsque le stagiaire effectue un appel t&eacute;l&eacute;phonique, la r&eacute;ponse du service client est imm&eacute;diate. Si le service client est d&eacute;j&agrave; en ligne, il rappelle juste apr&egrave;s et laisse un email si besoin.
<br>Visioconf&eacute;rence : Les formateurs dispensant les cours en pr&eacute;sentiel ou webconf&eacute;rence sont tous natifs de la langue enseign&eacute;e. Ils poss&egrave;dent au minimum un Bachelor ainsi qu'une certification en langue. En plus de leur exp&eacute;rience acad&eacute;mique dans l'enseignement, ils disposent d&rsquo;une exp&eacute;rience professionnelle dans le milieu de l'entreprise.


<br><br><br><strong>CONDITIONS DE LANCEMENT DE FORMATION</strong><br>
- La formation ne pourra d&eacute;buter qu'apr&egrave;s r&eacute;ception de la pr&eacute;sente convention sign&eacute;e par vos soins.<br>
- L'Appenant s'engage &agrave; respecter le d&eacute;lai initialement pr&eacute;vu de la formation (cf. "P&eacute;riode de formation" ci-dessus).
			
<br><br><br><strong>DÉDIT OU ABANDON</strong><br>	
- En cas de r&eacute;siliation de la pr&eacute;sente convention par LE CLIENT moins de 7 jours francs avant le d&eacute;but de l'action de formation, L'ORGANISME DE FORMATION retiendra sur le co&ucirc;t total les sommes qu'il aura r&eacute;ellement d&eacute;pens&eacute;es ou engag&eacute;es pour la r&eacute;alisation de l'action.
<br>- En cas de modification unilat&eacute;rale par L'ORGANISME DE FORMATION de l'une des composantes de la formation, LE CLIENT se r&eacute;serve le droit de mettre fin &agrave; la pr&eacute;sente convention. Le d&eacute;lai d'annulation &eacute;tant toutefois limit&eacute; &agrave; 7 jours francs avant la date pr&eacute;vue de commencement de l'une des actions mentionn&eacute;es &agrave; la pr&eacute;sente convention, il sera, dans ce cas, proc&eacute;d&eacute; &agrave; une r&eacute;sorbtion anticip&eacute;e de la convention.
<br>- En cas d'abandon de la formation par un ou plusieurs apprenants, LE CLIENT s'engage &agrave; verser &agrave; l'ORGANISME DE FORMATION les sommes correspondant aux heures consomm&eacute;es.
<br>- Dans le cadre d'un financement direct de la part du CLIENT, des dispositions particuli&egrave;res peuvent n&eacute;anmoins &ecirc;tre appliqu&eacute;es en cas de transfert d'heures de formation d'un apprenant sur un nouvel apprenant, sous r&eacute;serve de faire partie de la m&ecirc;me entit&eacute; et de ne pas ventiler le reliquat d'heures sur plusieurs apprenants. Les frais de dossier et les actions pr&eacute;alables au d&eacute;ploiement du nouvel apprenant seront factur&eacute;s 100.00&euro; HT.

<br><br><br><strong>DATE D'EFFET, VALIDIT&Eacute; DE LA CONVENTION &amp; DIFF&Eacute;RENDS</strong><br>	
- La pr&eacute;sente convention est dite annuelle. Elle prend effet &agrave; compter de la date de signature pour s'achever un an plus tard.
<br>- L'APPRENANT s'engage &agrave; consommer ses unit&eacute;s d'enseignement dans la p&eacute;riode d&eacute;finie &agrave; l'Article 1 de la pr&eacute;sente convention. En cas de non-respect de la p&eacute;riode de formation, une prolongation de la p&eacute;riode de formation est possible dans la mesure o&ugrave; celle-ci ne d&eacute;passe pas la date de fin de validit&eacute; de la convention, soit un an &agrave; compter de la signature de celle-ci.
<br>- Si une contestation ou un diff&eacute;rend ne peuvent &ecirc;tre r&eacute;gl&eacute;s &agrave; l'amiable, le Tribunal de Paris sera seul comp&eacute;tent pour se prononcer sur le litige.
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
</table>    
  

</body>
</html>

</cfif>

