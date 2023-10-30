<cfparam name="lang_select_id" default="2">
<!--- <cfparam name="URL.voc_cat_id" default="1"> --->
<cfparam name="URL.lang_select" default="fr">
<cfparam name="URL.lang_translate" default="en">
<cfparam name="subm" default="vocabulary">
<cfparam name="voc_group" default="47">
<cfif isDefined("URL.voc_cat_id")>
    <cfset voc_cat_id=URL.voc_cat_id>
<cfelse>
    <cfset voc_cat_id=0>
</cfif>

<cfset lang_select=#URL.lang_select#>
<cfset lang_translate=#URL.lang_translate#>
<!--- Check if required variables are defined --->
<cfif isdefined("voc_cat_id") AND isdefined("lang_select") AND isdefined("lang_select_id")>
    <cfsilent>
        <!--- Fetch the category name for the given voc_cat_id --->
        <cfquery name="get_cat_name" dataSource="#SESSION.BDDSOURCE#">
            SELECT * 
            FROM lms_vocabulary_category
            WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">
        </cfquery>

        <!--- Fetch vocabulary details based on the language and category --->
        <cfquery name="get_voc_total_count" dataSource="#SESSION.BDDSOURCE#">
            SELECT COUNT(*) AS total_count
            FROM lms_vocabulary_new v
            LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id                 
            <cfif voc_cat_id lt 1>
                INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_group
                WHERE uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                <cfelse>
                Where v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">
            </cfif>
                    AND formation_code in ('#lang_translate#', '#lang_select#')
        </cfquery>
      


        <!--- Set the language translation ID based on the selected language --->
        <cfswitch expression="#lang_translate#">
            <cfcase value="fr"><cfset lang_translate_id = 1></cfcase>
            <cfcase value="en"><cfset lang_translate_id = 2></cfcase>
            <cfcase value="de"><cfset lang_translate_id = 3></cfcase>
            <cfcase value="es"><cfset lang_translate_id = 4></cfcase>
            <cfcase value="it"><cfset lang_translate_id = 5></cfcase>
        </cfswitch>
    </cfsilent>


 <!--- Generate a PDF file with vocabulary details --->
 <cfdocument format="pdf" localUrl="yes" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="3">
        <!--- PDF header --->
        <cfdocumentitem type="header">
            <table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px;" width="100%" cellpadding="0">    
                <tr>
                    <td width="180" valign="top">
                        <cfoutput><img src="../assets/img/logo_wefit_260.jpg"><br><br>                    </cfoutput>
                    </td>
                    <td width="15"></td>
                    <td valign="top" align="left"></td>
                </tr>
            </table>    
        </cfdocumentitem>

        <!--- PDF content --->
        <cfsilent>
            <!--- Set the number of rows per page and other variables based on whether translation is defined --->
            <cfif isdefined("lang_translate") AND lang_translate neq "">
                <cfset nb_row = 19>
            <cfelse>
                <cfset nb_row = 20>
            </cfif>
            
            <cfset nb_diff = 3>
            <cfset mystart = 1>

            <cfset words_left = #get_voc_total_count.recordcount#>

            
        </cfsilent>
        <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

<!-----  TITLE & INTRO TEXT  ----->
	<cfif #mystart# eq 1>
	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:10px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td width="100%" align="center">
						<h2 align="center">	
						<cfif #voc_cat_id# gt 0>
							<cfoutput>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)#: #evaluate("get_cat_name.voc_cat_name_#lang_select#")#</cfoutput>
						<cfelse>
							<cfoutput>#obj_translater.get_translate("table_th_my_vocab_list",lang_select_id)#</cfoutput>
						</cfif>
						
						</h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<cfif #voc_cat_id# gt 0>
	<tr>
		<td valign="top">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; margin-top:5px;" width="100%" cellpadding="10" cellspacing="0">
				<tr>
					<td>
						<cfoutput>#obj_translater.get_translate_complex('intro_vocablist')#</cfoutput>
					</td>
				</tr>		
			</table>
		</td>
	</tr>
	</cfif>
	<cfset nb_row -= #nb_diff#>
	</cfif>
</table>
        
        <!--- Check if the record count is less than 3 --->
        <cfif get_voc_total_count.recordcount lt 3>
            <cfset nb_row = #get_voc_total_count.recordcount#>
            <cfset nb_page = 1>
            <cfinclude template="./el_vocablist_content.cfm">
        <cfelse>
            <!--- Create content for multiple pages --->
            <cfloop index="i" from="1" to="#nb_page#" step="1">
                <cfinclude template="./el_vocablist_content.cfm">
                <cfif #i# lt #nb_page# || #words_left# neq 0>
                    <cfdocumentitem type="pagebreak"/>
                </cfif>
                <cfset mystart += #nb_row#>
                <cfif i eq 1>
                    <cfset nb_row += #nb_diff#>
                </cfif>
            </cfloop>
            
            <!--- Include remaining words if any --->
            <cfif #words_left# neq 0>
                <cfset nb_row = #words_left#>
                <cfinclude template="./el_vocablist_content.cfm">
            </cfif>
        </cfif>

        <!--- PDF footer --->
        <cfdocumentitem type="footer">
            <div align="center"><cfoutput>#cfdocument.currentpagenumber#/#cfdocument.totalpagecount#</cfoutput></div>


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
 

</cfif>

