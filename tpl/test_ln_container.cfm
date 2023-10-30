<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>	

<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="4" marginright="0.5" marginleft="0.5" margintop="2" <!---filename="../docs/CF_#cv_context_name#_#dateformat(now(),'yyyymmdd')#.pdf"--->>
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


<cfset page = 1>
<cfinclude template="./test_ln_content.cfm">
		


<cfdocumentitem type = "footer">


</cfdocumentitem> 
</cfdocument>