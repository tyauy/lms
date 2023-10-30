<!DOCTYPE html>						
						
<html lang="fr">

<head>
	<meta charset="utf-8"/>
</head>

<body>	

<cfset lg_list = "fr,en,de,es">

<!------------------------------------------------------------------------------->	
<!-------------------------   SHORT  -------------------------------------------->	
<!------------------------------------------------------------------------------->

<cfif isdefined('import')>			
	

<cfset comp_list = "general,alert,button,form,modal,table">

	<cfset to_write_final = '<?xml version="1.0" encoding="UTF-8"?>
<content>'>

	
	<cfspreadsheet action="read" src="../translation/trad_short.xls" sheet=1 format="html" name="spreadsheetData">
	
	<cfset datas = replace(spreadsheetData, "</TD>", "", "ALL")>
	
	<cfdump var="#datas#">
	
	<cfset lines = datas.split("<TR>")>
	
	<cfset start_item = 4>
	
	<cfset cur_comp = "">
	<!--- <CONTENT> --->
	
	<cfloop array=#lines# index ="cur_line">
	<cfif cur_line neq "" and start_item eq 0>
		<cfset cells = cur_line.split("<TD>")>
		
		<cfset tmp_comp = #cells[3]#>
		<cfset tmp_comp = #trim(tmp_comp)#>
		<cfif cur_comp != tmp_comp and tmp_comp neq "&nbsp;">
			<cfif cur_comp eq "">
				<cfset to_write_final = #to_write_final# & '
<section name="#tmp_comp#">'>
			<cfelse>
				<cfset to_write_final = #to_write_final# & '</section>
<section name="#tmp_comp#">'>
			</cfif>
			<cfset cur_comp = #tmp_comp#>
		</cfif>
		
		

		<cfset cur_id = #cells[4]#>
		<cfset cur_id = #trim(cur_id)#>
		<cfif cur_id neq "&nbsp;" and cur_id[1] neq '<'>
		
		
		<!--- WRITE COMPONENTS --->
<cfset to_write = '	
<item_translate ID="#cur_id#">'>	
	
			<cfset "to_write_final" = #to_write_final# & to_write>
			
			<!--- WRITE ITEM TRANSLATE --->
			<cfset cur_cell = 5>
			<cfloop list="#lg_list#" index="lg">
			
				<cfset text_ok = #cells[cur_cell]#>
				<cfset text_ok = #trim(text_ok)#>

			
<cfset to_write = '
<item_translate_#lg#>
	<![CDATA[#text_ok#]]>
</item_translate_#lg#>'>
			
				<cfset "to_write_final" = #to_write_final# & to_write>
				
				<cfset cur_cell = '#evaluate("#cur_cell# + 1")#'>
				
			</cfloop>
			
			<!--- CLOSE COMPONENTS --->
		
			<cfset "to_write_final" = #to_write_final# & "</item_translate>">		
		
		</cfif>
	<cfelse>
		<cfset start_item = '#evaluate("#start_item# - 1")#'>
	</cfif>
		
	</cfloop>
	
	<!--- <CONTENT> --->

<cfset to_write_final = #to_write_final# & "</section>
">
<cfset to_write_final = to_write_final & "</content>">

	<cffile action="write" addnewline="yes" file="#SESSION.BO_ROOT#/translation/short.xml" output="#to_write_final#" mode="777">


<!------------------ EXPORT ------------------>
<!-------------------------------------------->
<cfelseif isdefined('export')>

	<cfset my_xml_comp = XMLParse('../translation/translation_short.xml')>
	
	<cfset my_array_comp = XMLSearch(my_xml_comp, "//section['item_translate']")>
	
	<!--- <cfdump var="#my_array_comp#"> --->

	<cfset sObj=SpreadsheetNew()>
	<cfset SpreadSheetMergeCells(sObj, 1, 1, 1, 4)>
	
	<cfset SpreadsheetSetCellValue(sObj, "Write the correct translation in the right cell. CARREFULL: text inside angle brackets don't need any translate and need to stay the same, at the right place in the text (usefull for design on the web) ; IDEM for text inside '$$' (variables like user's name to replace when printing the text)", 1, 1)>
	<cfset FormatStruct = {}>
	<cfset FormatStruct.fontsize = "13">
	<cfset FormatStruct.verticalalignment = "vertical_top"> 
	<cfset FormatStruct.textwrap = "TRUE">
	<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
	<cfset SpreadSheetSetRowHeight(sObj, 1, 40)>

	
	
	<cfset SpreadsheetAddRow(sObj, " ,TYPE,_ID,FR,EN,DE,ES", 3, 1)>
	<cfset SpreadsheetFormatRow(sObj,{fgcolor="light_blue"}, 3)>

	
	<cfset count_row = 4>
	<cfloop array="#my_array_comp#" index="section">
		
		
		<cfset cur_section = "#section['xmlAttributes']['name']#">
		
		<cfset components = "#section['xmlChildren']#">

		<cfloop array="#components#" index="cur_comp">
		
			<cfset cur_id = "#cur_comp['xmlAttributes']['ID']#">
			
			<cfset SpreadsheetSetCellValue(sObj, "#cur_section#", count_row, 2)>
			<cfset SpreadsheetSetCellValue(sObj, "#cur_id#", count_row, 3)>
			<cfset FormatStruct = {}>
			<cfset FormatStruct.textwrap = "TRUE">
			
			<cfset count = 1>
			<cfloop from="1" to="#ListLen(lg_list)#" index="cur_lg">
				<cfset to_write = "#cur_comp['xmlChildren'][count]#">
				<cfset to_write = "#trim(to_write['xmlText'])#">

				<cfset SpreadsheetSetCellValue(sObj, "#to_write#", count_row, "#count + 3#")>
				
				<cfif cur_lg eq 4 AND to_write eq "">
					<cfset SpreadsheetSetCellValue(sObj, "TO TRANSLATE", count_row, 1)>
					<!--- <cfset FormatStruct.fgcolor = "grey_25_percent"> --->
				<cfelse>
					<cfset SpreadsheetSetCellValue(sObj, "DONE", count_row, 1)>
				</cfif>
				
				<cfset count = '#evaluate("#count# + 1")#'>
			</cfloop>
			
			
			<cfif cur_lg eq 4><cfdump var="#to_write#"><br></cfif>
			

			<!--- <cfset is_pair = #evaluate('#count_row# MOD 2')#> --->
			<!--- <cfif #is_pair# neq 0> --->
				<!--- <cfset FormatStruct.fgcolor = "grey_25_percent"> --->
			<!--- </cfif> --->
			<cfset SpreadsheetFormatCellRange(sObj,FormatStruct,count_row, 1, count_row, 10)>

			<!--- <cfoutput> --->
			<!--- #count_row#_ #is_pair# - #cur_id# <br> --->
			<!--- </cfoutput> --->
				
			
			<cfset count_row = '#evaluate("#count_row# + 1")#'>
		</cfloop>

	</cfloop>
	
	<cfset SpreadSheetSetColumnWidth(sObj,1,15)>
	<cfset SpreadSheetSetColumnWidth(sObj,2,10)>
	<cfset SpreadSheetSetColumnWidth(sObj,3,25)>
	<cfset SpreadSheetSetColumnWidth(sObj,4,35)>
	<cfset SpreadSheetSetColumnWidth(sObj,5,35)>
	<cfset SpreadSheetSetColumnWidth(sObj,6,35)>
	<cfset SpreadSheetSetColumnWidth(sObj,7,35)>
	



<cfheader name="Content-Disposition" value="inline; filename=components_translations.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">	
	
	
<!------------------------------------------------------------------------------->	
<!-------------------------   COMPLEX ------------------------------------------->	
<!------------------------------------------------------------------------------->	
	

<!------------------ IMPORT ------------------>
<!-------------------------------------------->
<cfelseif isdefined('import_complex')>
	
	<cfspreadsheet action="read" src="../translation/trad_complex.xls" sheet=1 format="html" name="spreadsheetData">
	
	<cfset lines = spreadsheetData.split("<TR>")>
	<cfset cur_page = " ">
	<cfset start_item = 4>
	
	<!--- <CONTENT> --->
	<cfset first_line = 1>
	<cfloop array=#lines# index ="cur_line">
	<cfif cur_line neq "" and start_item eq 0>
		<cfset cells = cur_line.split("<TD>")>
		
		<cfset tmp_page_name = #cells[2]#>
		<cfset tmp_page_name = tmp_page_name.split("</TD>")>
		<cfset tmp_page = #trim(tmp_page_name[1])#>

		<cfset cur_id = #cells[3]#>
		<cfset cur_id = cur_id.split("</TD>")>
		<cfset cur_id = #trim(cur_id[1])#>
		<cfset cur_cell = 4>
<cfif tmp_page neq "&nbsp;">		
		<cfloop list="#lg_list#" index="lg">
			<!--- WRITE PAGES --->
			<cfif tmp_page neq cur_page>
<cfif first_line eq 0>
<cfset to_write = '</page> 
<page name="#tmp_page#">'> 
 <cfelse>
 <cfset "to_write_#lg#" = "">
 <cfset to_write = '<?xml version="1.0" encoding="UTF-8"?>
<content>
<page name="#tmp_page#">'> 
 <cfif lg eq listgetat(lg_list, #evaluate(listlen(lg_list))#)><cfset first_line = 0></cfif>
 </cfif>
				
				<cfset "to_write_#lg#" = #evaluate('to_write_#lg#')# & to_write>
				
			</cfif>
			
			<!--- WRITE ITEM TRANSLATE --->
			<cfset text_ok = #cells[cur_cell]#>
			<cfset text_ok = text_ok.split("</TD>")>
			<cfset text_ok = #trim(text_ok[1])#>
			<cfif text_ok eq "&nbsp;">
				<cfset text_ok = "">
			</cfif>
				
			
<cfset to_write = '	<item_translate ID="#cur_id#">
<![CDATA[#text_ok#]]>
</item_translate>'>
			
			<cfset "to_write_#lg#" = #evaluate('to_write_#lg#')# & to_write>
			
			<cfset cur_cell = '#evaluate("#cur_cell# + 1")#'>
			
		</cfloop>
</cfif>
		<cfset cur_page = "#tmp_page#">
	<cfelse>
		<cfset start_item = '#evaluate("#start_item# - 1")#'>
	</cfif>
		
	</cfloop>
	
	<!--- <CONTENT> --->


<cfloop list="#lg_list#" index="cur_lg">
<cfoutput>
<cfset "to_write_#cur_lg#" = "#evaluate('to_write_#cur_lg#')#" & "</page>

</content>">
</cfoutput>
	<cffile action="write" addnewline="yes" file="#SESSION.BO_ROOT#/translation/trad_#cur_lg#.xml" output="#evaluate('to_write_#cur_lg#')#" mode="777">
</cfloop>
	
	<cfdump var="#lines#">
		
		
		
<!------------------ EXPORT ------------------>
<!-------------------------------------------->
<cfelseif isdefined('export_complex')>	
	<cfset my_xml_fr = XMLParse('../translation/translation_fr.xml')>
	<cfset my_xml_en = XMLParse('../translation/translation_en.xml')>
	<cfset my_xml_de = XMLParse('../translation/translation_de.xml')>
	<cfset my_xml_es = XMLParse('../translation/translation_es.xml')>
	
	<cfset my_array_fr = XMLSearch(my_xml_fr, "//page['item_tanslate']")>
	<cfset my_array_en = XMLSearch(my_xml_en, "//page['item_tanslate']")>
	<cfset my_array_de = XMLSearch(my_xml_de, "//page['item_tanslate']")>
	<cfset my_array_es = XMLSearch(my_xml_es, "//page['item_tanslate']")>

	<cfset sObj=SpreadsheetNew()>
	<cfset SpreadSheetMergeCells(sObj, 1, 1, 1, 4)>
	
	<cfset SpreadsheetSetCellValue(sObj, "Write the correct translation in the right cell. CARREFULL: text inside angle brackets don't need any translate and need to stay the same, at the right place in the text (usefull for design on the web) ; IDEM for text inside '$$' (variables like user's name to replace when printing the text)", 1, 1)>
	<cfset FormatStruct = {}>
	<cfset FormatStruct.fontsize = "13">
	<cfset FormatStruct.textwrap = "TRUE">
	<cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
	<cfset SpreadSheetSetRowHeight(sObj, 1, 40)>

	
	
	<cfset SpreadsheetAddRow(sObj, "PAGE,TEXT_ID,FR,EN,DE,ES", 3, 1)>
	<cfset SpreadsheetFormatRow(sObj,{fgcolor="light_blue"}, 3)>

	
	<cfset count_row = 4>
	<cfset count = 1>
	<cfloop array="#my_array_fr#" index="idx">
		
		
		<cfset my_page = "#idx['xmlAttributes']['name']#">
		
		<cfset my_children = "#idx['xmlChildren']#">
		<cfset en_children = "#evaluate('my_array_en[#count#]["xmlChildren"]')#">
		<cfset de_children = "#evaluate('my_array_de[#count#]["xmlChildren"]')#">
		<cfset es_children = "#evaluate('my_array_es[#count#]["xmlChildren"]')#">

		<cfset count_child = 1>
		<cfloop array="#my_children#" index="child">
		
			<cfset my_id = "#child['xmlAttributes']['ID']#">
			
			<cfset my_text = "#child['xmlText']#">
			<cfset en_text = '#en_children["#count_child#"]["xmlText"]#'>
			<cfset de_text = "#evaluate('de_children[#count_child#]["xmlText"]')#">
			<cfset es_text = "#evaluate('es_children[#count_child#]["xmlText"]')#">

			<cfset SpreadsheetSetCellValue(sObj, "#my_page#", count_row, 1)>
			<cfset SpreadsheetSetCellValue(sObj, "#my_id#", count_row, 2)>
			<cfset SpreadsheetSetCellValue(sObj, "#my_text#", count_row, 3)>
			<cfset SpreadsheetSetCellValue(sObj, "#en_text#", count_row, 4)>
			<cfset SpreadsheetSetCellValue(sObj, "#de_text#", count_row, 5)>
			<cfset SpreadsheetSetCellValue(sObj, "#es_text#", count_row, 6)>
			
			<cfset FormatStruct = {}>
			<cfset FormatStruct.textwrap = "TRUE">

			<cfset is_pair = #evaluate('#count_row# MOD 2')#>
			<cfif #is_pair# neq 0>
				<cfset FormatStruct.fgcolor = "grey_25_percent">
			</cfif>
			<cfset SpreadsheetFormatRow(sObj,FormatStruct,count_row)>


				
			
			<cfset count_row = '#evaluate("#count_row# + 1")#'>
			
			<cfset count_child = '#evaluate("#count_child# + 1")#'>
		</cfloop>

	<cfset count = '#evaluate("#count# + 1")#'>
	</cfloop>
	
	<cfset SpreadSheetSetColumnWidth(sObj,1,20)>
	<cfset SpreadSheetSetColumnWidth(sObj,2,25)>
	<cfset SpreadSheetSetColumnWidth(sObj,3,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,4,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,5,50)>
	<cfset SpreadSheetSetColumnWidth(sObj,6,50)>
	



<cfheader name="Content-Disposition" value="inline; filename=../translation/translations_translation.xls">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">	
	
	
<!----------------------------------------------------------------------------->	
<cfelseif isdefined('EXP')><!---export_complex_bdd--->	

	<cfset my_xml_fr = XMLParse('../translation/translation_fr.xml')>
	<cfset my_xml_en = XMLParse('../translation/translation_en.xml')>
	<cfset my_xml_de = XMLParse('../translation/translation_de.xml')>
	<cfset my_xml_es = XMLParse('../translation/translation_es.xml')>
	
	<cfset my_array_fr = XMLSearch(my_xml_fr, "//page['item_tanslate']")>
	<cfset my_array_en = XMLSearch(my_xml_en, "//page['item_tanslate']")>
	<cfset my_array_de = XMLSearch(my_xml_de, "//page['item_tanslate']")>
	<cfset my_array_es = XMLSearch(my_xml_es, "//page['item_tanslate']")>

	
	
	<cfset count_row = 4>
	<cfset count = 1>
	<cfloop array="#my_array_fr#" index="idx">
		
		
		<cfset my_page = "#idx['xmlAttributes']['name']#">
		
		<cfset my_children = "#idx['xmlChildren']#">
		<cfset en_children = "#evaluate('my_array_en[#count#]["xmlChildren"]')#">
		<cfset de_children = "#evaluate('my_array_de[#count#]["xmlChildren"]')#">
		<cfset es_children = "#evaluate('my_array_es[#count#]["xmlChildren"]')#">

		<cfset count_child = 1>
		<cfloop array="#my_children#" index="child">
		
			<cfset my_id = "#child['xmlAttributes']['ID']#">
			
			<cfset my_text = "#child['xmlText']#">
			<cfset en_text = '#en_children["#count_child#"]["xmlText"]#'>
			<cfset de_text = "#evaluate('de_children[#count_child#]["xmlText"]')#">
			<cfset es_text = "#evaluate('es_children[#count_child#]["xmlText"]')#">



			<cfquery name="ins_complex_trads" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_translation_long
			(
			translation_long_code,
			translation_long_type,
			translation_long_string_fr,
			translation_long_string_en,
			translation_long_string_de,
			translation_long_string_es
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#my_id#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#my_page#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#my_text#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#en_text#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#de_text#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#es_text#">
			)
			</cfquery>


			
			<cfset count_row = '#evaluate("#count_row# + 1")#'>
			
			<cfset count_child = '#evaluate("#count_child# + 1")#'>
		</cfloop>

	<cfset count = '#evaluate("#count# + 1")#'>
	</cfloop>
		
	
</cfif>


</body>
</html>