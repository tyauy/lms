<!---------------------CONTENT INVOICE----------------------->

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="80">
				<tr>
					<td width="100%" align="center">
						<h2>ATTESTATION DE FIN DE FORMATION</h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td valign="top">
			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="10" cellspacing="1">
				<tr>
					<td colspan="2">
					<h3>NOUS CERTIFIONS QUE</h3>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="50" align="center">
					<span style="font-size:15px;">					
					<cfoutput>#ucase(fn_aff)# #ucase(n_aff)#</cfoutput>
					<cfif isdefined("c_aff") AND c_aff neq ""><br><br><cfoutput>#ucase(c_aff)#</cfoutput></cfif>
					</span>
					</td>
				</tr>		
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="10" cellspacing="1">
				<tr>
					<td colspan="2">
						<h3>A R&Eacute;ALIS&Eacute; L'ACTION DE FORMATION SUIVANTE AVEC NOTRE ORGANISME</h3>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="120">
						<span style="font-size:12px;">R&eacute;f&eacute;rence WEFIT</span>
					</td>
					<td>
						<span style="font-size:12px;"><cfoutput>#o_id#</cfoutput></span>
					</td>
				</tr>				
				<tr bgcolor="#FFFFFF">
					<td width="120">
						<span style="font-size:12px;">Module</span>
					</td>
					<td>
						<span style="font-size:12px;"><cfoutput>#t_aff#</cfoutput></span>
					</td>
				</tr>	
				<cfif isdefined("l_aff")>
				<tr bgcolor="#FFFFFF">
					<td>
						<span style="font-size:12px;">Langue</span>
					</td>
					<td>
						<span style="font-size:12px;"><cfoutput>#l_aff#</cfoutput></span>
					</td>
				</tr>
				</cfif>				
				<tr bgcolor="#FFFFFF">
					<td>
						<span style="font-size:12px;">Date</span>
					</td>
					<td>
						<span style="font-size:12px;">Du <cfoutput>#dateformat(df_aff,'dd/mm/yyyy')#</cfoutput> au <cfoutput>#dateformat(dt_aff,'dd/mm/yyyy')#</cfoutput></span>
					</td>
				</tr>	
				<tr bgcolor="#FFFFFF">
					<td>
						<span style="font-size:12px;">Dur&eacute;e</span>
					</td>
					<td>
						<span style="font-size:12px;"><cfoutput>#d_aff#</cfoutput> heures</span>
					</td>
				</tr>	
							
			</table>
		</td>
	</tr>
	<tr>
		<td style="padding-top:100px">
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td> &Agrave; Paris, le <cfoutput>#dateformat(dateedit_aff,'dd/mm/yyyy')#</cfoutput>
				</tr>			
			</table>
		</td>	
	</tr>
	<tr>
		<td align="left" valign="top" style="padding-top:20px">	
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
				<tr>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left">
									<span style="font-size:13px;"><strong>WEFIT GROUP</strong></span><br>
									<span style="font-size:10px"><em>Vincent GEST, Pr&eacute;sident de WEFIT Group</em></span><br>
								
								</td>
							</tr>
							<tr>
								<td align="center">
									<img src="http://winegroup.synten.com/gateway/img/signature_wefit.jpg" align="center"><br><br>
								</td>
							</tr>
						</table>
					</td>
					<td width="4%"></td>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<span style="font-size:13px"><strong>L'APPRENANT(E)</strong></span><br>
						<span style="font-size:10px"><em>Signature</em></span>
						<br><br>
						<cfif isdefined("id") AND isdefined("sh") AND get_id.recordcount eq "1">
						<cfoutput><img src="http://winegroup.synten.com/gateway/img/#get_id.signature_src#.png" width="290" align="center"><br><br></cfoutput>
						</cfif>
						
					</td>
				</tr>
			</table>
		

		</td>
	</tr>
</table>           

</body>
</html>
