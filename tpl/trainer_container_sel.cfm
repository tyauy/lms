<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT u.*, u.user_id as u_id, c.country_name_#SESSION.LANG_CODE# as country_name
FROM user u
INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
INNER JOIN user_profile up ON upc.profile_id = up.profile_id
LEFT JOIN settings_country c ON c.country_id = u.country_id
WHERE upc.profile_id = 4 
AND user_id IN (#planner_id#)
ORDER BY user_firstname
</cfquery>

<cfdocument format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" localurl="yes" filename="../assets/export/CV_TRAINERS_#dateformat(now(),'yyyymmdd')#.pdf">
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

<cfoutput query="get_user">

<cfquery name="get_experience" datasource="#SESSION.BDDSOURCE#">
SELECT experience_id, experience_start, experience_end, experience_today, experience_title_#SESSION.LANG_CODE# as experience_title, experience_description_#SESSION.LANG_CODE# as experience_description, experience_localisation FROM user_experience
WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
ORDER BY experience_start DESC
</cfquery>

<cfquery name="get_cursus" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user_cursus
WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
ORDER BY cursus_start DESC
</cfquery>

<cfinclude template="./trainer_content.cfm">

<cfif currentrow neq recordcount>
<cfdocumentitem type="pagebreak" />
</cfif>


</cfoutput>

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

<cfoutput>
<cflocation addtoken="no" url="../assets/export/CV_TRAINERS_#dateformat(now(),'yyyymmdd')#.pdf">
</cfoutput>
