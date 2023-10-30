<cfif isdefined("a_id") OR (isdefined("a_company") AND isdefined("a_address") AND isdefined("a_zipcode") AND isdefined("a_city") AND isdefined("a_country") AND isdefined("a_ctc") AND isdefined("f_package") AND isdefined("f_learner"))>

<cfif isdefined("a_id")>
<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT a.*, s.sector_name, sz.size_name, t.type_name, ag.group_name, u.user_firstname, u.user_color, at.status_name, co1.country_name_fr as account_country_name, co2.country_name_fr as account_f_country_name

FROM account a
LEFT JOIN account_group ag ON ag.group_id = a.group_id 	
LEFT JOIN account_type t ON t.type_id = a.type_id
LEFT JOIN account_status at ON at.status_id = a.status_id
LEFT JOIN user u ON u.user_id = ag.manager_id
LEFT JOIN settings_sector s ON s.sector_id = a.sector_id
LEFT JOIN settings_size sz ON sz.size_id = a.size_id
LEFT JOIN settings_tva tva ON tva.tva_id = a.tva_id
LEFT JOIN settings_delay delay ON delay.delay_id = a.delay_id

LEFT JOIN settings_country co1 ON co1.country_id = a.account_country
LEFT JOIN settings_country co2 ON co2.country_id = a.account_f_country

WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfquery>
</cfif>
	
	
<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" filename="../admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf">
<cfdocumentitem type = "header">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
	<tr>
		<td width="180" valign="top">
		<img src="../assets/img/logo_wefit_260.jpg" width="220"><br>
		</td>
		<td width="15"></td>
		<td valign="top" align="left">
		</td>
	</tr>	
</table>
</cfdocumentitem> 

<cfinclude template="estimate_content.cfm">

<cfdocumentitem type = "footer">
<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:0px; margin-top:0px" width="900">
	<tr>
		<td valign="top" align="center">
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

<cflocation addtoken="no" url="estimate_container.cfm?n_id=#n_id#">
</cfif>


