<cfsetting requestTimeOut = "9000" />


<cfparam name="export_all" default="0">
<cfparam name="view_only" default="0">
<cfparam name="mail" default="0">

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfparam name="p_id" default="#listGetAt(SESSION.TRAINER_EXPORT_LIST, 1)#">

<cfparam name="start_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="end_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="use_date" default="0">

<cfif use_date eq 0>
	<cfset periode_name = "#msel##ysel#">
<cfelse>
	<cfset periode_name = "#start_date#">
</cfif>
<cfset dir_go = "/home/www/wnotedev1/admin/trainer_inv/#periode_name#">

<cfif not directoryExists(dir_go)>
	<cfdirectory directory="#dir_go#" action="create" mode="777">
</cfif>

<cfif export_all eq 1>
	<cfset _list = SESSION.TRAINER_EXPORT_LIST>
<cfelse>
	<cfset _list = p_id>
</cfif>

<cfloop list="#_list#" index="p_id">

	<p><cfoutput>#p_id#</cfoutput></p>
	
<cfsilent>

<cfif use_date eq 0>
	<cfset get_lessons = obj_query.oget_lessons(p_id="#p_id#",st_id="5",period_month="#tselect#",orderby="trainer_firstname",pmissed="1",invoicing="1")>
<cfelse>
	<cfset get_lessons = obj_query.oget_lessons(p_id="#p_id#",st_id="5",start_range="#start_date#",end_range="#end_date#",orderby="trainer_firstname",pmissed="1",invoicing="1")>
</cfif>


<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT
	u.user_firstname, u.user_name, u.user_temp_alias, u.user_alias, u.user_email,
	st.tva_rate,
	up.payment_iban,
	up.payment_name,
	up.payment_address, up.payment_postal, up.payment_city, up.payment_country, 
	up.payment_siret, up.payment_vat
	FROM user u
	INNER JOIN user_payment up ON up.user_id = u.user_id
	LEFT JOIN settings_tva st ON st.tva_id = u.user_paid_tva
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	LIMIT 1
</cfquery>

<cfquery name="get_total" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(l.lesson_duration) as total_dur, SUM( (pricing_amount * (l.lesson_duration / 60) )) as amount_total, 
	pricing_amount, cat.cat_name_#SESSION.LANG_CODE# as cat_name, f.formation_code,
	lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias
	FROM lms_lesson2 l
	INNER JOIN lms_tpsession s ON s.session_id = l.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
	INNER JOIN lms_lesson_method lm ON lm.method_id = tp.method_id
	INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
	INNER JOIN user u2 ON u2.user_id = l.planner_id
	INNER JOIN user_pricing uprice ON uprice.user_id = u2.user_id 
	INNER JOIN lms_tpsession_category cat ON cat.cat_id = sm.sessionmaster_cat_id AND cat.cat_public = 1
	AND uprice.formation_id = tp.formation_id
	AND uprice.pricing_cat = sm.sessionmaster_cat_id
	AND uprice.pricing_method = l.method_id

	WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL

	AND (lesson_ghost != 1 OR lesson_ghost IS NULL)

	AND ( l.status_id = 5 OR (l.status_id = 4 AND u2.user_paid_missed = 1))

	AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">

	<cfif use_date eq 0>
		AND DATE_FORMAT(l.completed_date, "%Y-%m") =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
	<cfelse>
		AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#start_date#"> 
		AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#end_date#">
	</cfif>

	GROUP BY cat.cat_id, tp.formation_id, tp.method_id
</cfquery>

<cfset total_hours = 0>
<cfset total_amount = 0>


<cfloop query="get_total">

	<cfset total_hours = total_hours + get_total.total_dur>
	<cfset total_amount = total_amount + get_total.amount_total>

</cfloop>

</cfsilent>

<cfif view_only eq 0>


	<cfdocument localUrl="yes" format="pdf" filename="#dir_go#/pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf" overwrite="yes" unit="cm"  pagetype="A4" marginbottom="3" marginright="1.5" marginleft="1.5" margintop="3" >
	<cfdocumentitem type = "header">
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:50px" width="100%" cellpadding="0">
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
	<!--- <cfoutput><cfdump var="#get_order#"></cfoutput> --->
	<cfinclude template="invoice_trainer_content.cfm">

	<cfdocumentitem type="pagebreak"></cfdocumentitem>

	<cfinclude template="invoice_trainer_content_detail.cfm">

	<cfdocumentitem type = "footer">
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-bottom:0px; margin-top:0px" width="900">
		<tr>
			<td valign="top" align="center">
				<img src="../assets/img/logo_wefit_260.jpg" width="130">
				<br><br>
				WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
				D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
	<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
			</td>
		</tr>	
	</table>    
	</cfdocumentitem> 

	</cfdocument>

	<cfif mail eq 1>

		<cfset user_firstname = get_user.user_firstname>
		<!--- #get_user.user_email#,finance@wefitgroup.com --->
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_user.user_email#,finance@wefitgroup.com" subject="Your invoice for #listgetat(SESSION.LISTMONTHS_EN,msel)# #ysel# / Votre facture de #listgetat(SESSION.LISTMONTHS,msel)# #ysel#" type="html" server="localhost">
			<cfset lang = "fr">
			<cfinclude template="/email/email_trainer_invoice.cfm">
			<cfmailparam file = "#dir_go#/pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf" type="application/pdf">
		</cfmail>

	</cfif>

	<!--- <cfquery name="insert_trainer_invoice_info" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO user_invoice_info(
			user_invoice_info_user, 
			user_invoice_info_mail_sent, 
			user_invoice_info_path, 
			user_invoice_info_selector
			) 
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#mail#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#dir_go#/pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf">,
			<cfif use_date eq 0>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
			<cfelse>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#start_date#">
			</cfif>
			)
		ON DUPLICATE KEY UPDATE 
		<cfif mail eq 1> user_invoice_info_mail_sent = 1,</cfif>
		user_invoice_info_modified = NOW()
	</cfquery> --->

	<cfinvoke component="api/users/user_trainer_post" method="insert_item_invoice_trainer" returnvariable="perso">
		<cfinvokeargument name="user_id" value="#p_id#">
		<cfinvokeargument name="mail_sent" value="#mail#">
		<cfinvokeargument name="path" value="#dir_go#/pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf">
		<cfinvokeargument name="selector" value="#periode_name#">
		<cfinvokeargument name="hours" value="#total_hours#">
		<cfinvokeargument name="amount" value="#total_amount#">
	</cfinvoke>


</cfif>

</cfloop>


<cfif export_all eq 1>

<cfset fileName = periode_name />

<cfdirectory action = "list" directory = "#dir_go#" name = "getAllFiles"  type="file" />
<cfzip action="zip" file="#dir_go#/#fileName#.zip" overwrite="yes" >
	<cfloop query="getAllFiles">    
		<cfzipparam  source="#dir_go#/#getAllFiles.name#">
	</cfloop>
</cfzip>

<cfheader name = "Content-disposition" value = 'attachment; filename="#fileName#.zip"'>
<cfcontent deleteFile="true" file="#dir_go#/#fileName#.zip" type="application/x-zip-compressed" >

</cfif>


<cfif view_only eq 1>
	<!--- We recreate the pdf for display because we don't want it to be accessible via url --->
	<cfdocument localUrl="yes" format="pdf" saveasname="pdf_#get_user.user_firstname#_#get_user.user_name#_#periode_name#.pdf" overwrite="yes" unit="cm"  pagetype="A4" marginbottom="3" marginright="1.5" marginleft="1.5" margintop="3" >
		<cfdocumentitem type = "header">
		<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:50px" width="100%" cellpadding="0">
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
		<!--- <cfoutput><cfdump var="#get_order#"></cfoutput> --->
		<cfinclude template="invoice_trainer_content.cfm">
		
		<cfdocumentitem type="pagebreak"></cfdocumentitem>
		
		<cfinclude template="invoice_trainer_content_detail.cfm">
		
		<cfdocumentitem type = "footer">
		<table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-bottom:0px; margin-top:0px" width="900">
			<tr>
				<td valign="top" align="center">
					<img src="../assets/img/logo_wefit_260.jpg" width="130">
					<br><br>
					WEFIT GROUP SAS - 168, rue de la Convention 75015 PARIS, FRANCE<br>
					D&eacute;claration d&rsquo;activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d&rsquo;Ile de France
		<br>RCS PARIS 510 689 649 (2011B03340) &ndash; www.wefitgroup.com
				</td>
			</tr>	
		</table>    
		</cfdocumentitem> 
		
	</cfdocument>
	
<cfelse>
	<cfif use_date eq 0>
		<cflocation addtoken="no" url="../cs_invoicing.cfm?mode=2&msel=#msel#&ysel=#ysel#">
	<cfelse>
		<cflocation addtoken="no" url="../cs_invoicing.cfm?mode=2&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#">
	</cfif>
</cfif>