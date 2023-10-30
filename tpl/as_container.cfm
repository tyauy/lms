<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#u_id#">
</cfinvoke>

<!--- localurl="yes" - removed for base64 signature to work --->
<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="3" orientation = "landscape">
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<!---  get_user.account_id eq 37  --->
	<cfif get_user.group_id eq 25> 
		<tr>
			<td width="180" valign="top">
			<img src="../assets/img_group/logo-audavia.png" width="220"><br>
			</td>
			<td width="15"></td>
			<td valign="top" align="left">
			</td>
		</tr>	
	<cfelse>
		<tr>
			<td width="180" valign="top">
			<img src="../assets/img/logo_wefit_260.jpg" width="220"><br>
			</td>
			<td width="15"></td>
			<td valign="top" align="left">
			</td>
		</tr>	
	</cfif>
</table>
</cfdocumentitem> 

<cfinclude template="as_content.cfm">

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:20px" width="100%" cellpadding="0">
	<cfif get_user.group_id eq 25>
		<tr>
			<td width="100%" valign="top" align="center">
				<img src="../assets/img_group/logo-audavia.png" width="120">
				<br><br>
				<strong>AUDAVIA SARL</strong> - 141, avenue de Wagram - 75017 PARIS<br>

				D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 45125 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France - RCS PARIS 520 388 901 - NAF 8559A
				
			</td>
		</tr>	
	<cfelse>
	<tr>
		<td width="100%" valign="top" align="center">
			<img src="../assets/img/logo_wefit_260.jpg" width="120">
			<br><br>
<strong>WEFIT GROUP SAS</strong> - 168, rue de la Convention 75015 PARIS, FRANCE<br>
D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France - RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com

<br><br>
<strong>WEFIT DEUTSCHLAND</strong><br>
Weinbergweg 24 - 73630 Remshalden - +49 7151 2 59 40 54 - hello@wefitgroup.com



		</td>
	</tr>	
	</cfif>
</table>
</cfdocumentitem> 
</cfdocument>




