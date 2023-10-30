<cfif isdefined("id") AND isdefined("sh") AND isdefined("generate") AND isdefined("temp")>

<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_signature 
WHERE signature_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
AND signature_hash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sh#">
</cfquery>

<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="3" filename="../img/#temp#.pdf" localUrl="yes">
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<tr>
		<td width="180" valign="top">
		<img src="../assets/img/logo_wefit_260.jpg" width="220"><br>
		</td>
		<td width="15"></td>
		<td valign="top" align="left"></td>
	</tr>	
</table>
</cfdocumentitem> 

<cfset page = "1">
<cfinclude template="./trainer_charter_content.cfm">
<cfdocumentitem type="pagebreak" />

<cfset page = "2">
<cfinclude template="./trainer_charter_content.cfm">
<cfdocumentitem type="pagebreak" />

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:20px" width="900" cellpadding="0">
	<tr>
		<td width="180" valign="top" align="center">
			<img src="./img/logo_wefit_260.jpg" width="120">
			<br><br>
			WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
			D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
		</td>
	</tr>	
</table>
</cfdocumentitem> 
</cfdocument>

<cfelse>

<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="3" localUrl="yes">
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<tr>
		<td width="180" valign="top">
		<img src="../assets/img/logo_wefit_260.jpg" width="220"><br>
		</td>
		<td width="15"></td>
		<td valign="top" align="left"></td>
	</tr>	
</table>
</cfdocumentitem> 

<cfset page = "1">
<cfinclude template="./trainer_charter_content.cfm">
<cfdocumentitem type="pagebreak" />

<cfset page = "2">
<cfinclude template="./trainer_charter_content.cfm">
<cfdocumentitem type="pagebreak" />

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:20px" width="900" cellpadding="0">
	<tr>
		<td width="180" valign="top" align="center">
			<img src="../assets/img/logo_wefit_260.jpg" width="120">
			<br><br>
			WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
			D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
		</td>
	</tr>	
</table>
</cfdocumentitem> 
</cfdocument>

</cfif>


