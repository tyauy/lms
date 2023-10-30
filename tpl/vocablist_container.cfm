<cfif isdefined("voc_cat_id") AND isdefined("lang_select") AND isdefined("lang_select_id")>
<cfsilent>

<!--- QUERIES --->
<cfquery name="get_cat_name" dataSource="#SESSION.BDDSOURCE#">
	SELECT * 
	FROM lms_vocabulary_category
	WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">
</cfquery>


<cfquery name="get_voc" dataSource="#SESSION.BDDSOURCE#">
	SELECT v.*,
	vtfr.voc_type_name_fr as voc_type_name_fr,
	vten.voc_type_name_en as voc_type_name_en,
	vtde.voc_type_name_de as voc_type_name_de,
	vcat.voc_cat_name_#lang_select# as voc_cat
	
	FROM lms_vocabulary v
	
	LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
	LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
	LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
	
	
	LEFT JOIN lms_vocabulary_category vcat ON v.voc_cat_id = vcat.voc_cat_id
	
	<cfif voc_cat_id lt 1>
	INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_id
	</cfif>
	
	WHERE <cfif voc_cat_id lt 1>uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		  <cfelse>v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#"></cfif>
	
	ORDER BY <cfif voc_cat_id eq -1>voc_cat, </cfif>voc_word_#lang_select# ASC	
</cfquery>

<cfswitch expression="#lang_translate#">
	<cfcase value="fr"><cfset lang_translate_id = 1></cfcase>
	<cfcase value="en"><cfset lang_translate_id = 2></cfcase>
	<cfcase value="de"><cfset lang_translate_id = 3></cfcase>
	<cfcase value="es"><cfset lang_translate_id = 4></cfcase>
	<cfcase value="it"><cfset lang_translate_id = 5></cfcase>
</cfswitch>

</cfsilent>


<!------  PDF START  ------>
<cfdocument format="pdf" localUrl="yes" <!---filename="#get_cat_name.voc_cat_name_en#.pdf"---> unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="3">

	<cfdocumentitem type = "header">
		<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px;" width="100%" cellpadding="0">	
			<tr>
				<td width="180" valign="top">
				<cfoutput><img src="../assets/img/logo_wefit_260.jpg"><br><br></cfoutput>
				</td>
				<td width="15"></td>
				<td valign="top" align="left"></td>
			</tr>
		</table>	
	</cfdocumentitem>


<!------ PDF CONTENT ------>

	


	<!-- Variables Declarations -->
	<cfsilent>
		<cfif isdefined("lang_translate") AND lang_translate neq "">
			<cfset nb_row = 19>
		<cfelse>
			<cfset nb_row = 20>
		</cfif>
		
		<cfset nb_diff = 3>
		<cfset mystart = 1>

		<cfset nb_page = #get_voc.recordcount# \ #nb_row#>
		<cfset words_left = #get_voc.recordcount# - (#nb_row# * #nb_page#) + #nb_diff#>
		
	</cfsilent>
	
	<cfif get_voc.recordcount lt 3>
		<cfset nb_row = #get_voc.recordcount#>
		<cfset nb_page = 1>
		<cfinclude template="./vocablist_content.cfm">
	<cfelse>


	<!-- Create content -->
	<cfloop index="i" from="1" to="#nb_page#" step="1">

		<cfinclude template="./vocablist_content.cfm">
		<cfif #i# lt #nb_page# || #words_left# neq 0>
			<cfdocumentitem type = "pagebreak"/>
		</cfif>
		<cfset mystart += #nb_row#>
		<cfif i eq 1>
			<cfset nb_row += #nb_diff#>
		</cfif>
	</cfloop>
	
	<cfif #words_left# neq 0>
		<cfset nb_row = #words_left#>
		<cfinclude template="./vocablist_content.cfm">
	</cfif>
	</cfif>


<!------ FOOTER ------>
	<cfdocumentitem type = "footer">
		<div align="center"><cfoutput>#cfdocument.currentpagenumber#/#nb_page + 1#</cfoutput></div>
		<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-top:5px; margin_bottom:0px;" width="100%" cellpadding="0">
			<tr>
				<td align="center">
					<cfoutput><img src="../assets/img/logo_wefit_260.jpg" width="120"></cfoutput>
					<br><br>
					WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
					D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
					<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
				</td>
			</tr>	
		</table>
	</cfdocumentitem>

</cfdocument>



<!--- <cflocation addtoken="no" url="http://winegroup.synten.com/elisa/#get_cat_name.voc_cat_name_en#.pdf"> --->

<!--- <cfheader name="Content-Disposition" value="attachment; filename=#cat.en_name#.pdf"> --->
<!--- <cfcontent type="application/octet-stream" file="#expandPath('.')#\#cat.en_name#.pdf"> --->
</cfif>