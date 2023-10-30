<cfparam name="p_id">
<cfparam name="sh" default="">
<cfparam name="contract_lang" default="en">
<cfparam name="generate" default="">
<cfparam name="temp" default="contract_#lsDateFormat(now(),'dd_mm_yyyy', 'fr')#">
<cfparam name="signature_base64" default="">
<cfparam name="save" default="0">

<!--- <cfif isdefined("id") AND isdefined("sh") AND isdefined("generate") AND isdefined("temp")> --->
<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>

<cfif  signature_base64 neq "" AND save eq 1 AND p_id neq "">

	<cfset dir_go = "/home/www/wnotedev1/admin/contract/#p_id#/">

	<cfif not directoryExists(dir_go)>
			
		<cfdirectory directory="#dir_go#" action="create" mode="777">
		
	</cfif>

	<!--- <cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_signature 
	WHERE signature_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
	AND signature_hash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sh#">
	</cfquery> --->

<cfdocument format="pdf" filename="#dir_go#/#temp#.pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2">
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

	<cfif contract_lang eq "fr">
		<cfinclude template="./trainer_contract_content_fr.cfm">
	<cfelse>
		<cfinclude template="./trainer_contract_content_en.cfm">
	</cfif>

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

<cflocation addtoken="no" url="https://lms.wefitgroup.com/common_trainer_account.cfm?p_id=#p_id#&k=4">


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


<cfif contract_lang eq "fr">
	<cfinclude template="./trainer_contract_content_fr.cfm">
<cfelse>
	<cfinclude template="./trainer_contract_content_en.cfm">
</cfif>


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