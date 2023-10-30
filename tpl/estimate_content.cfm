<cfif page eq "1">

<cfset ht_total = "0">

<cfif f_learner lt 1>
<cfset f_learner = 1>
</cfif>

<cfif isdefined("tracker") and tracker eq "34D1F91FB2E514B8576FAB1A75A89A6B">
<cfset visio_pu = "45">
<cfelse>
<cfset visio_pu = "55">
</cfif>

<cfset visio_q = listgetat(f_package,"2","_")>
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
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; border:1px solid #333333" width="100%" cellpadding="10">
							<tr>
								<td>
								<cfif isdefined("a_id")>
									<cfoutput>
									<strong>#get_account.account_name#</strong>
									<br>
									#get_account.account_address#<cfif get_account.account_address2 neq ""><br> - #get_account.account_address2#</cfif>
									<br>
									#get_account.account_postal# #get_account.account_city#
									<br>
									#get_account.account_country#
									</cfoutput>
								<cfelse>
									<cfoutput>
									<strong>#a_company#</strong>
									<br>
									#a_address#
									<br>
									#a_zipcode# #a_city# - #a_country#
									<br>
									#a_ctc#
									</cfoutput>
								</cfif>
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
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="5">
				<tr>
					<td valign="top" align="center">
						<h2 style="margin-bottom:1px">DEVIS DE FORMATION FOAD</h2>
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
							<tr bgcolor="##FFFFFF">
								<td align="center"><img src="./assets/img/picto_methode_3.png" width="30"></td>
								<td>e-Learning</td>
								<td align="center"><cfif findnocase("en",f_package) OR findnocase("de",f_package)>#f_learner#</cfif></td>
								<td align="center"><cfif findnocase("en",f_package) OR findnocase("de",f_package)>12<cfelse>#el_q#</cfif></td>
								<td align="center">mois</td>
								<td align="center"><cfif el_total neq "0">#el_pu# &euro;<cfelse>-</cfif></td>
								<td align="right"><cfif findnocase("en",f_package) OR findnocase("de",f_package)>inclus<cfelse><cfif el_total neq "0">#numberformat(el_total,'____.__')# &euro;<cfelse>-</cfif></cfif></td>
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
							</tr>
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
							<cfif f_package eq "en">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ANGLAIS<br>Acc&egrave;s illimit&eacute; e-Learning ESSENTIAL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_package eq "fr">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : FRAN&Ccedil;AIS<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_package eq "de">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ALLEMAND<br>Acc&egrave;s illimit&eacute; e-Learning ESSENTIAL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_package eq "es">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ESPAGNOL<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
							</tr>
							<cfelseif f_package eq "it">
							<tr bgcolor="#FFFFFF">
								<td colspan="2">Langue : ITALIEN<br>Fin de formation : <cfoutput>#dateformat(f_date_end,'dd/mm/yyy')#</cfoutput></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="center"></td>
								<td align="right"></td>
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
							<cfif f_learner gt 5>
							<tr>
								<cfoutput>
								<cfloop from="6" to="#f_learner#" index="cor">
								<cfif isdefined("f_lastname_#cor#")><td width="20%">#ucase(evaluate("f_lastname_#cor#"))# #evaluate("f_firstname_#cor#")#</td></cfif>
								</cfloop>
								</cfoutput>
							</tr>
							</cfif>

						</table>
						<br>
						<h3>CONDITIONS FINANCI&Egrave;RES</h3>
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="4" cellspacing="0">
							<tr>
								<td bgcolor="#FAFAFA" width="30%">Conditions de r&egrave;glement</td>
								<td>50% d&eacute;but de formation / 50% &agrave; &eacute;ch&eacute;ance
								
								</td>
							</tr>
							<tr>
								<td bgcolor="#FAFAFA">Dur&eacute;e de validit&eacute; devis</td>
								<td>1 mois</td>
							</tr>
							<tr>
								<td bgcolor="#FAFAFA">
									P&eacute;riode de formation
								</td>
								<td>
									<cfoutput>Du #f_date_start# au #f_date_end#</cfoutput>
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
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td> &Agrave; Paris, le <cfoutput>#dateformat(now(),'dd/mm/yyyy')#</cfoutput>
				</tr>			
			</table>
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
				<tr>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left">
									<span style="font-size:13px;"><strong>WEFIT</strong></span><br>
									<span style="font-size:10px"><em>Vincent GEST, Pr&eacute;sident de WEFIT Group</em></span><br>
								</td>
							</tr>
							<tr>
								<td align="center">
									<img src="./assets/img/signature_wefit.jpg" width="150" align="center">
								</td>
							</tr>
						</table>
					</td>
					<td width="4%"></td>
					
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left">
									<span style="font-size:13px;"><strong>LE CLIENT</strong></span><br>
								</td>
							</tr>
							<tr>
								<td align="center">
								
								</td>
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
						<h2>PROGRAMME DE FORMATION FOAD</h2>
						<h3><cfoutput>#visio_q#</cfoutput> heures de formation VISIO (ELEARNING INCLUS)</h3>
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
							
						<cfif findnocase("en",f_package)>
						<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
							<!---<cfoutput query="get_session" group="session_id">--->
							
							<cfif f_package eq "en_20">
								<cfset tpgo = "91">
							<cfelseif f_package eq "en_30">
								<cfset tpgo = "107">
							<cfelseif f_package eq "en_40">
								<cfset tpgo = "123">
							</cfif>
							
							<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
							SELECT sessionmaster_id FROM lms_tpmastercor2 WHERE tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpgo#"> ORDER BY sessionmaster_rank
							</cfquery>
							
							<cfset listgo = "">
							
							<cfoutput query="get_session">
							<cfset listgo = listappend(listgo,sessionmaster_id)>
							</cfoutput>
							<!--- <cfset listgo = "695,739,740,768,741,744,742,743,750,751,752,753,748,749,731,732,733,882,883,694">	 --->
							<cfoutput>
							<cfset counter = "0">
							<cfloop list="#listgo#" index="cor">
							<cfset counter++>
							
							<cfquery name="get_session_description" datasource="#SESSION.BDDSOURCE#">
							SELECT sm.*, tpm.sessionmaster_schedule_duration	FROM lms_tpsessionmaster2 sm 
							INNER JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
							WHERE sm.sessionmaster_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
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
									<span style="font-size:12px;">#get_session_description.sessionmaster_schedule_duration# min</span>
								</td>
								<td bgcolor="##FFFFFF">
									<span style="font-size:12px;"><strong>#get_session_description.sessionmaster_name#</strong></span>
									<br>
									#get_session_description.sessionmaster_description#
								</td>
								<!---<td bgcolor="##FFFFFF">
									<span style="font-size:12px;"><strong>#sessionmaster_description#</strong></span>
								</td>--->
							</tr>
							</cfloop>
							</cfoutput>
						</table>		
						<cfelse>
							<cfset module_list_1 = "Auxiliaires Avoir et &Ecirc;tre,Pr&eacute;sent de l'indicatif,Pass&eacute;-compos&eacute; / Pass&eacute; simple,Imparfait,Imp&eacute;ratif,Futur simple,Conditionnel,Pr&eacute;positions de temps et de lieux,Verbes &agrave; pr&eacute;position,Verbes pronominaux,Nombre cardinaux et ordinaux">
							<cfset module_list_2 = "Masculin/ f&eacute;minin,Accord des adjectifs,Expressions idiomatiques,La comparaison,Liens logiques,Prononciation (le e-muet, les liaisons),Syntaxe g&eacute;n&eacute;rale,Accord des adjectifs,Interrogation,Subjonctif,Le discours rapport&eacute;">
							<cfset module_list_3 = "Usages au t&eacute;l&eacute;phone,Animer une pr&eacute;sentation,Mises en situations professionnelles,Jeux de r&ocirc;les,Entretiens">
							<cfset module_list_4 = "Participer et intervenir en r&eacute;union,Comprendre et r&eacute;diger des documents professionnels,Accueillir des visiteurs,Savoir n&eacute;gocier,D&eacute;crire des produits/ses services/son poste">
							
							<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:10px" width="100%" cellpadding="5" cellspacing="1">		
								<tr>
									<td colspan="4">
										<span style="font-size:14px;"><strong><cfoutput><cfif findnocase("fr",f_package)>Français<cfelseif findnocase("de",f_package)>Allemand<cfelseif findnocase("es",f_package)>Espagnol<cfelseif findnocase("it",f_package)>Italien</cfif> - GENERAL</cfoutput></strong></span>
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
										<span style="font-size:14px;"><strong><cfoutput><cfif findnocase("fr",f_package)>Français<cfelseif findnocase("de",f_package)>Allemand<cfelseif findnocase("es",f_package)>Espagnol<cfelseif findnocase("it",f_package)>Italien</cfif> - PROFESSIONNEL</cfoutput></strong></span>
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
		
			<cfinclude template="estimate_summary.cfm">
			
<br>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">						
											
<br>
<strong>PUBLIC VIS&Eacute;</strong><br>
Tout public, professionnel ou autre. La formation est adapt&eacute;e au niveau du stagiaire.
<br><br><br><strong>PR&Eacute;-REQUIS</strong><br>
Visioconf&eacute;rence : Sur le plan p&eacute;dagogique aucun pr&eacute;requis.
Le contenu de la formation est adapt&eacute; au niveau et aux besoins du stagiaire.
Sur le plan mat&eacute;riel : un ordinateur PC ou MAC / Une connexion Internet sont n&eacute;cessaires.
<br><br><br><strong>MOYENS P&Eacute;DAGOGIQUES</strong><br>
L'&eacute;quipe p&eacute;dagogique met &agrave; disposition de l'apprenant des ressources dont la nature varie en fonction de la th&eacute;matique de chaque cours : - Ressources con&ccedil;ues par les &eacute;quipes p&eacute;dagogiques de WEFIT en vue de l'acquisition d'une comp&eacute;tence pr&eacute;cise en langue cible ou de la ma&icirc;trise d'un aspect grammatical, syntaxique ou terminologique de la langue cible &ndash; Ressources multim&eacute;dias diverses - Ressources tir&eacute;es du contexte professionnel de l'apprenant (approche ad hoc ou ateliers) Afin de maintenir l'int&eacute;r&ecirc;t et la motivation de l'apprenant, les natures de ressources seront altern&eacute;es, tout comme l'approche du formateur.
<br><br><br><strong>CONTENUS, NATURE DES TRAVAUX DEMAND&Eacute;S ET TEMPS ESTIM&Eacute; DE R&Eacute;ALISATION</strong><br>
Visioconf&eacute;rence : Les cours auront lieu sur une plateforme de visioconf&eacute;rence et/ou par t&eacute;l&eacute;phone. Les travaux auront pour but de maximiser le temps de parole de l&rsquo;apprenant quelle que soit la ressource utilis&eacute;e. La nature des ressources varie : pr&eacute;sentations, ressources Multim&eacute;dias (vid&eacute;os, pistes audio, podcasts&hellip;), supports de travail du stagiaire&hellip; Le choix de la dur&eacute;e des cours est laiss&eacute; au stagiaire :
30min, 45min, 60min ou plus. A sa demande, le formateur peut lui proposer des exercices pour r&eacute;viser avant le prochain cours. Les exercices seront alors disponibles sur son espace personnel. Le temps estim&eacute; de r&eacute;alisation des exercices de r&eacute;vision est de 30 minutes.
<br><br><br><strong>MODALIT&Eacute;S DE SUIVI ET D'&Eacute;VALUATION SP&Eacute;CIFIQUES</strong>
<br><u>Suivi administratif</u><br>
L'organisme de formation s'engage &agrave; transmettre la feuille d'&eacute;margement ou l'attestation de fin de formation sign&eacute;e par les diff&eacute;rentes parties. Elle reprend la date de l'action, les heures correspondantes et la d&eacute;nomination du module. Dans le cadre d'une certification &agrave; la fin de la formation, l'organisme s'engage &agrave; transmettre le certificat. Si besoin, l'organisme transmet un justificatif d'assiduit&eacute;.
<br><u>Suivi p&eacute;dagogique</u><br>
Des &eacute;valuations de d&eacute;but et de fin de formation seront organis&eacute;es lors de chaque parcours. Une validation des acquis est effectu&eacute;e r&eacute;guli&egrave;rement au fil des modules de formation. Visioconf&eacute;rence / Pr&eacute;sentiel : Un reporting est &eacute;dit&eacute; tous les mois. Il recense l'&eacute;tat d'avancement et de r&eacute;alisation des heures et permet donc de suivre la consommation. Des &laquo; review lessons &raquo; (le&ccedil;ons de r&eacute;vision) ainsi qu'une &eacute;valuation finale ont lieu durant le parcours de formation. Des &laquo; lessons notes &raquo; sont fournies au stagiaire pour formaliser les acquis de chaque cours.
<br><br><strong>COMP&Eacute;TENCES ET QUALIFICATIONS DES PERSONNES CHARG&Eacute;ES D'ASSISTER LE STAGIAIRE</strong><br>
Les personnes du service client charg&eacute;es d'assister les b&eacute;n&eacute;ficiaires parlent obligatoirement fran&ccedil;ais &amp; anglais, et id&eacute;alement une troisi&egrave;me langue. Ces personnes sont r&eacute;actives et p&eacute;dagogues afin d'assurer un suivi et des &eacute;changes de qualit&eacute;. Le stagiaire peut contacter le service client pour toute demande (probl&egrave;me technique, question relative au contenu des cours&hellip;) du lundi au vendredi de 8h &agrave; 18h, par mail service@wefitgroup.com ou par t&eacute;l&eacute;phone 01.83.62.32.46. Les cours peuvent &ecirc;tre programm&eacute;s &agrave; tout moment et se d&eacute;rouler sur son lieu de travail. De plus le stagiaire a acc&egrave;s &agrave; une interface personnelle 7j/7, 24h/24 gr&acirc;ce &agrave; des identifiants transmis en d&eacute;but de formation. Il peut se connecter via le site www.wefitgroup.com. Le service client s'engage &agrave; r&eacute;pondre dans les meilleurs d&eacute;lais &agrave; un email qui lui est adress&eacute; (dans l'heure qui suit), et ce notamment pour les urgences. Au plus tard, le service client r&eacute;pond dans les 24h. Lorsque le stagiaire effectue un appel t&eacute;l&eacute;phonique, la r&eacute;ponse du service client est imm&eacute;diate. Si le service client est d&eacute;j&agrave; en ligne, il rappelle juste apr&egrave;s et laisse un email si besoin. Visioconf&eacute;rence / Pr&eacute;sentiel Les formateurs dispensant les cours en pr&eacute;sentiel ou webconf&eacute;rence sont tous natifs de la langue enseign&eacute;e. Ils poss&egrave;dent au minimum un Bachelor ainsi qu'une certification en langue. En plus de leur exp&eacute;rience acad&eacute;mique dans l'enseignement, ils disposent d&rsquo;une exp&eacute;rience professionnelle dans le milieu de l'entreprise.

					</td>
				</tr>		
			</table>
		</td>
	</tr>
	
</table>    
  

</body>
</html>
			
			
</cfif>

