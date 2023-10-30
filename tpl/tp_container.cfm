<cfif isdefined("tppack_id")>

<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
SELECT sm.*, tc.sessionmaster_schedule_duration, tp.tpmaster_name_#SESSION.LANG_CODE# as tpmaster_name, m.module_id, m.module_name_#SESSION.LANG_CODE# as module_name, tc.sessionmaster_rank, m.module_description_#SESSION.LANG_CODE# as module_description
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 m ON sm.module_id = m.module_id	

WHERE tp.tpmaster_prebuilt = 1 AND tp.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tppack_id#">
ORDER BY tc.sessionmaster_rank ASC 
</cfquery>	
	
	
<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" <!----filename="../admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf"--->>
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

<cfinclude template="tp_content.cfm">

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

</cfif>


