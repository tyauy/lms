<cfif not isdefined("n_id")>

	<cfif isdefined("a_company") AND isdefined("a_address") AND isdefined("a_zipcode") AND isdefined("a_city") AND isdefined("a_country") AND isdefined("a_ctc") AND isdefined("f_package") AND isdefined("f_learner")>

	<cfquery name="insert_img" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_signature
	(
	signature_name
	)
	VALUES
	(
	"temp"
	)
	</cfquery>

	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT max(signature_id) as id FROM lms_signature
	</cfquery>

	<cfset n_id = get_max.id>

	<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="3" marginright="0.5" marginleft="0.5" margintop="2" filename="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf">
	<cfdocumentitem type = "header">
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px" width="100%" cellpadding="0">
		<tr>
			<td width="180" valign="top">
			<img src="./assets/img/logo_wefit_260.jpg" width="220"><br>
			</td>
			<td width="15"></td>
			<td valign="top" align="left">
			</td>
		</tr>	
	</table>
	</cfdocumentitem> 

	<cfset page = "1">
	<cfinclude template="./tpl/estimate_content.cfm">

	<!--- <cfif findnocase("en", f_package)> --->
	
	<cfset page = "2">
	<cfdocumentitem type="pagebreak" />
	<cfinclude template="./tpl/estimate_content.cfm">
	<!--- </cfif> --->
	
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = "3">
	<cfinclude template="./tpl/estimate_content.cfm">
	
	<cfdocumentitem type = "footer">
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:0px; margin-top:0px" width="900">
		<tr>
			<td valign="top" align="center">
				<img src="./assets/img/logo_wefit_260.jpg" width="120">
				<br><br>
				WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
				D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
	<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
			</td>
		</tr>	
	</table>    
	</cfdocumentitem> 

	</cfdocument>
	
	<cfset togo = "_fne_subscribe_sign.cfm?n_id=#n_id#&a_company=#a_company#&a_address=#a_address#&a_zipcode=#a_zipcode#&a_city=#a_city#&a_country=#a_country#&a_ctc=#a_ctc#&f_learner=#f_learner#&f_package=#f_package#&f_date_end=#f_date_end#&f_date_start=#f_date_start#&f_certif=#f_certif#">
	<cfloop from="1" to="#f_learner#" index="cor">
	<cfset togo = togo&"&f_lastname_#cor#=#evaluate('f_lastname_#cor#')#&f_firstname_#cor#=#evaluate('f_firstname_#cor#')#">
	</cfloop>
	<cflocation addtoken="no" url="#togo#">
	
	</cfif>

<cfelse>


	<cfset myImage = ImageReadBase64(signature_base64)> 		

	<cfimage source="#myImage#" destination="./admin/temp/#n_id#.png" action="write" overwrite="yes">

	<cfset go_sign=ImageNew("",200,100,"argb")> 
	<cfset ImageSetAntialiasing(go_sign)> 

	<!--- Draw the text. --->  
	<cfset attr2=StructNew()> 
	<cfset attr2.size=11> 
	<cfset attr2.style="italic"> 
	<cfset attr2.font="SansSerif.bold"> 
	<cfset attr3=StructNew()> 
	<cfset attr3.size=11> 
	<cfset attr3.style="italic"> 
	<cfset attr3.font="SansSerif.bold"> 
	<cfset ImageSetDrawingColor(go_sign,"black")> 
	<cfset ImageDrawText(go_sign,"Le #dateformat(now(),'dd/mm/yyyy')#",0,68,attr2)> 
	<cfset ImageDrawText(go_sign,"par #a_ctc#",0,82,attr3)> 

	<!--- Write the text image to a file. ---> 
	<cfimage action="write" format="png" source="#go_sign#" destination="./admin/temp/text_#n_id#.png" overwrite ="yes"> 



	<!--- Watermark the txt image --->
	<cfpdf action="addwatermark" source="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" image="./admin/temp/text_#n_id#.png" destination="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" overwrite="yes" foreground="yes" opacity="8" showOnPrint="yes" position="380,200">
	<!--- Watermark the signature --->
	<cfpdf action="addWatermark" source="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" image="./admin/temp/#n_id#.png" destination="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" overwrite="yes" foreground="yes" opacity="8" showOnPrint="yes" position="320,140">

	
	
	<cfmail from="W-LMS WEFIT <finance@wefitgroup.com>" to="start@wefitgroup.com" subject="Devis de formation WEBOOST" type="html" server="localhost">
	R&eacute;ception de devis
	
	<cfmailparam file="#SESSION.BO_ROOT#/admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf">
	
	</cfmail>
		
	<cflocation addtoken="no" url="./_fne_subscribe.cfm?n_id=#n_id#&k=1">


</cfif>

