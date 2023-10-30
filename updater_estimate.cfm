<cfprocessingdirective pageencoding="windows-1252">

<cfif not isdefined("n_id")>

	<cfset get_account = obj_query.oget_account(a_id="#a_id#",a_list="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

	<!------ CF TRICK FOR DATEPICKER -------------->
	<cfif day(f_date_start) lte "12">
		<cfset f_date_start = "#dateformat(f_date_start,'yyyy-dd-mm')#">
	<cfelse>
		<cfset f_date_start = "#dateformat(f_date_start,'yyyy-mm-dd')#">
	</cfif>	

	<cfif day(f_date_end) lte "12">
		<cfset f_date_end = "#dateformat(f_date_end,'yyyy-dd-mm')#">
	<cfelse>
		<cfset f_date_end = "#dateformat(f_date_end,'yyyy-mm-dd')#">
	</cfif>	
	
	<cfif isdefined("training_pack")>

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

	<cfdocument localUrl="yes" format="pdf" unit="cm" overwrite="yes" pagetype="A4" marginbottom="5" marginright="0.5" marginleft="0.5" margintop="2" filename="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf">
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

	<cfset page = "0">
	<cfinclude template="./tpl/estimate_content_2.cfm">
	
	<cfdocumentitem type="pagebreak" />	
	
	<cfset page = "1">
	<cfinclude template="./tpl/estimate_content_2.cfm">
	
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = "2">
	<cfinclude template="./tpl/estimate_content_2.cfm">
	
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = "3">
	<cfinclude template="./tpl/estimate_content_2.cfm">
	
	<cfdocumentitem type="pagebreak" />
	
	<cfset page = "4">
	<cfinclude template="./tpl/estimate_content_2.cfm">
	
	<cfdocumentitem type = "footer">
	<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
		<tr>
			<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
				<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left">
							<span style="font-size:13px;"><strong>WEFIT</strong></span><br>
							<span style="font-size:10px"><em>Vincent GEST, Pr&eacute;sident de WEFIT Group</em></span><br>
						</td>
					</tr>
					<tr>
						<td align="center">
							<img src="./assets/img/signature_wefit.jpg" width="150" align="center">
						</td>
					</tr>
				</table>
			</td>
			<td width="4%"></td>
			<td width="48%" style="border:1px solid #ECECEC" valign="top" height="120">
				<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left">
							<span style="font-size:13px;"><strong>LE CLIENT</strong></span><br>
						</td>
					</tr>
				</table>
			</td>
			<td width="30%"></td>
		</tr>
	</table>
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:9px; margin-bottom:0px; margin-top:5px" width="900">
		<tr>
			<!---<td width="15%">
			<td width="3%" valign="top">
				<img src="./assets/img/logo_wefit_100.jpg" width="40" align="left">
			</td>--->
			<td valign="top" align="center">
				WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE
				<br>D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
				<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
			</td>
		</tr>	
	</table>    
	</cfdocumentitem> 

	</cfdocument>
	
	
	<cfset togo = "tm_estimate_sign.cfm?training_pack=#training_pack#&n_id=#n_id#&a_company=#a_company#&a_address=#a_address#&a_zipcode=#a_zipcode#&a_city=#a_city#&a_country=#a_country#&a_ctc=#a_ctc#&f_learner=#f_learner#&f_date_start=#f_date_start#&f_date_end=#f_date_end#">
		
		
	<cfif training_pack eq "card">
		<cfset togo = togo&"&f_certif=#f_certif#&f_id=#f_id#">
	<cfelseif training_pack eq "pack">
		<cfset togo = togo&"&pack_id=#pack_id#&tppack_id=#tppack_id#">
	</cfif>
	
	<cfloop from="1" to="#f_learner#" index="cor">
	<cfset togo = togo&"&f_lastname_#cor#=#evaluate('f_lastname_#cor#')#&f_firstname_#cor#=#evaluate('f_firstname_#cor#')#">
	</cfloop>
	
	<cflocation addtoken="no" url="#togo#">
	
	</cfif>

<cfelse>


	<cfset myImage = ImageReadBase64(signature_base64)> 		

	<cfimage source="#myImage#" destination="./admin/temp/#n_id#.png" action="write" overwrite="yes">
	<cfimage source="./admin/temp/#n_id#.png" action="resize" width="60%" height="60%" destination="./admin/temp/#n_id#.png" overwrite="yes">

	<cfset go_sign=ImageNew("",200,100,"argb")> 
	<cfset ImageSetAntialiasing(go_sign)> 

	<!--- Draw the text. --->  
	<cfset attr2=StructNew()> 
	<cfset attr2.size=11> 
	<cfset attr2.style="italic"> 
	<cfset attr2.font="DejaVu Sans"> 
	<cfset attr3=StructNew()> 
	<cfset attr3.size=11> 
	<cfset attr3.style="italic"> 
	<cfset attr3.font="DejaVu Sans"> 
	<cfset ImageSetDrawingColor(go_sign,"black")> 
	<cfset ImageDrawText(go_sign,"Le #dateformat(now(),'dd/mm/yyyy')#",0,65,attr2)> 
	<cfset ImageDrawText(go_sign,"par #a_ctc#",0,80,attr3)> 

	<!--- Write the text image to a file. ---> 
	<cfimage action="write" source="#go_sign#" destination="./admin/temp/text_#n_id#.png" overwrite ="yes"> 



	<!--- Watermark the txt image --->
	<cfpdf action="addwatermark" source="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" image="./admin/temp/text_#n_id#.png" destination="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" overwrite="yes" foreground="yes" opacity="8" showOnPrint="yes" position="380,87">
	<!--- Watermark the signature --->
	<cfpdf action="addWatermark" source="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" image="./admin/temp/#n_id#.png" destination="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" overwrite="yes" foreground="yes" opacity="8" showOnPrint="yes" position="330,60">

	
	
	<cfmail from="W-LMS WEFIT <finance@wefitgroup.com>" to="start@wefitgroup.com" subject="Devis de formation TM" type="html" server="localhost">
	R&eacute;ception de devis
	
	<cfmailparam file="#SESSION.BO_ROOT#/admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf">
	
	</cfmail>
		
	<cflocation addtoken="no" url="./tm_estimate_download.cfm?n_id=#n_id#&k=1">


</cfif>

