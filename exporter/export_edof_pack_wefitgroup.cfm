<!DOCTYPE html>						
						
<html lang="fr">

<head>
	<meta charset="utf-8"/>
</head>

<body>





<!------------------ IMPORT ------------------>
<!-------------------------------------------->
<cfif isdefined('import')>
	
	<cfspreadsheet action="read" src="edof_pack.xls" sheet=1 format="html" name="spreadsheetData">
	
	<cfset datas = replace(spreadsheetData, "</TD>", "", "ALL")>
	
	<cfset lines = datas.split("<TR>")>
	<cfset start_item = 5>

	<cfloop array=#lines# index ="cur_line">
	<cfif cur_line neq "" and start_item eq 0>
		<cfset cells = cur_line.split("<TD>")>
		
		<cfdump var="#cells#">
			
		<cfset cur_id = #cells[2]#>
		
		
		<cfif cur_id neq 0>
		<cfquery name="updt_edof_pack" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_formation_pack
		SET pack_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[3]#">,
			pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[4]#">,
			pack_hour = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[5]#">,
			pack_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[6]#">,
			pack_objectives = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[7]#">,
			pack_results = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[8]#">,
			pack_content = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[9]#">,
			pack_certif = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[10]#">,
			pack_amount_ht = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[11]#">,
			pack_amount_ttc = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[12]#">,
			pack_method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[13]#">,
			pack_destination_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cells[14]#">,
			pack_modalitites = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[15]#">,
			pack_keys = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[16]#">,
			pack_certif_info = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[17]#">
		WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cur_id#">	
		</cfquery>
		
		<cfelse>
		<cfquery name="insert_edof_pack" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_formation_pack
		(pack_formation_id, pack_name, pack_hour, pack_duration, pack_objectives, pack_results, pack_content, pack_certif, pack_amount_ht, pack_amount_ttc, pack_method_id, pack_destination_id, pack_modalitites, pack_keys, pack_certif_info)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[3]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[4]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[5]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[6]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[7]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[8]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[9]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[10]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[11]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[12]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[13]#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#cells[14]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[15]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[16]#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#cells[17]#">
		)
		</cfquery>
		</Cfif>
		
	<cfelse>
		<cfset start_item = '#evaluate("#start_item# - 1")#'>
	</cfif>
	</cfloop>









<!------------------ EXPORT ------------------>
<!-------------------------------------------->
<cfelseif isdefined('export')>	

<cfquery name="get_cpf_formation" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM lms_formation_pack
		WHERE pack_new=1
	</cfquery>
	
	<cfset sObj=SpreadsheetNew()>	
	
	<cfset SpreadSheetMergeCells(sObj, 1, 1, 1, 5)>
	
	<cfset SpreadsheetSetCellValue(sObj, "Ne pas toucher à l'intérieur des balises <> (utile à l'affichage: <br> = saut de ligne, <strong> = mettre en gras, <ul><li> = liste avec puces, <a href...> = lien)", 1, 1)>
	<cfset FormatStruct = {}>
	<cfset FormatStruct.fontsize = "13">
	<cfset FormatStruct.textwrap = "TRUE">
	<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
	<cfset SpreadSheetSetRowHeight(sObj, 1, 40)>
	
	<cfset FormatStruct = {}>
	<cfset FormatStruct.verticalalignment = "vertical_top"> 
	<cfset FormatStruct.textwrap = "TRUE">
	<cfset SpreadSheetMergeCells(sObj, 2, 2, 2, 4)>
	<cfset SpreadSheetSetCellValue(sObj, "Certifcation: 84165=LINGUASKILL | 84168=TOEIC | 84546=BRIGHT_ENGLISH | 86389=BRIGHT_GERMAN | 86390=BRIGHT_SPANISH | 85572=BRIGHT_ITALIAN | 85582=BRIGHT_FRENCH | 85577=BRIGHT_DUTCH | 85575=BRIGHT_PORTUGUESE | 85586=BRIGHT_RUSSIAN | 85584=BRIGHT_CHINESE | 95455=PIPPLET Flex Arabe", 2, 2)>
	

	
	<cfset SpreadSheetSetCellValue(sObj, "Méthodes: 1=VISIO, 2=F2F, 3=eLearning, 4=WEMAIL, 5=Immersion, 6=Certification, 7=Audit, 8=Evaluation", 2, 5)>
	
	<cfset SpreadSheetSetCellValue(sObj, "Destinations: 1=IH ABERDEEN, 2=IH BELFAST, 3=IH BRISTOL, 4=IH DUBLIN, 5=IH MALTA, 6=IH MANCHESTER, 7=IH NEWCASTLE, 8=IH LONDON, 9=IH BARCELONA, 10=IH MADRID, 11=IH MALAGA, 12=IH PALMA, 13=IH SAN SEBASTIAN, 14=IH SEVILLA, 15=IH VALENCIA, 16=IH BERLIN, 17=IH HEIDELBERG, 18=IH COLOGNE, 19=IH FRANCFORT, 20=IH FREIBURG, 21=DUBLIN - COUPLE MAHONY, 22=DUBLIN - COUPLE HILL, 24=IH NICE", 2, 6)>
	
	<cfset SpreadsheetFormatRow(sObj,FormatStruct,2)>	


	
	
	<cfset SpreadsheetAddRow(sObj, "id,formation_id,name,hour,duration,objectives,results,content,certif,amount ht,amount ttc,method id,destination id,modalités,keys,certif info", 4, 1)>
	<cfset SpreadsheetFormatRow(sObj,{fgcolor="light_blue"}, 4)>
	
	<cfset count_row = 5>
	<cfloop query="get_cpf_formation">
	
		<!--- <cfset SpreadsheetAddRow(sObj, "#pack_name#,#pack_hour#,#pack_duration#,#pack_objectives#,#pack_results#,#pack_content#", count_row, 1)> --->
		<cfset SpreadsheetSetCellValue(sObj, "#pack_id#", count_row, 1)>
		<cfset SpreadsheetSetCellValue(sObj, "#formation_id#", count_row, 2)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_name#", count_row, 3)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_hour#", count_row, 4)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_duration#", count_row, 5)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_objectives#", count_row, 6)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_results#", count_row, 7)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_content#", count_row, 8)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_certif#", count_row, 9)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_amount_ht#", count_row, 10)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_amount_ttc#", count_row, 11)>
		<cfset SpreadsheetSetCellValue(sObj, "#method_id#", count_row, 12)>
		<cfset SpreadsheetSetCellValue(sObj, "#destination_id#", count_row, 13)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_modalites#", count_row,14)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_keys#", count_row, 15)>
		<cfset SpreadsheetSetCellValue(sObj, "#pack_certif_info#", count_row, 16)>


		<cfset FormatStruct = {}>
		<cfset FormatStruct.textwrap = "TRUE">
		<cfset FormatStruct.verticalalignment = "vertical_top"> 

		<cfset is_pair = #evaluate('#count_row# MOD 2')#>
		<cfif #is_pair# neq 0>
			<cfset FormatStruct.fgcolor = "grey_25_percent">
		</cfif>
		<cfset SpreadsheetFormatRow(sObj,FormatStruct,count_row)>
		<cfset SpreadSheetSetRowHeight(sObj,count_row,30)> 
	<cfset count_row = '#evaluate("#count_row# + 1")#'>
	</cfloop>
	
	
	<cfset SpreadSheetSetColumnWidth(sObj,1,5)>
	<cfset SpreadSheetSetColumnWidth(sObj,3,30)>
	<cfset SpreadSheetSetColumnWidth(sObj,4,5)>
	<cfset SpreadSheetSetColumnWidth(sObj,5,5)>
	<cfset SpreadSheetSetColumnWidth(sObj,6,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,7,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,8,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,14,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,15,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,16,50)>


	
<cfheader name="Content-Disposition" value="inline; filename=cpf_formation.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">	
</cfif>

</body>

</html>
	