<cfif isdefined("o_id")>

<cfsilent>

	<cfset get_order = obj_order_get.oget_orders(o_id="#o_id#")>
	<cfset get_invoice = obj_order_get.oget_invoice(o_id="#o_id#",by_invoice=1,o_by="i_id")>


	<cfset cur_order = QueryGetRow(get_order, 1)>
	
	<cfoutput query="get_order">
		<cfset a_id = account_id>
		<cfset account_name = account_name>
		
		<cfset formation_name = formation_name>

		<cfset order_ref = order_ref>
		<cfset order_date = dateformat(order_date,'dd/mm/yyyy')>
		<cfset order_status_id = order_status_id>
		
		<cfset context_id = context_id>
		<cfset context_name = context_name>
		<cfset context_alias = context_alias>
		
		<cfset status_finance_id = order_status_id>
		<cfset status_finance_name = status_finance_name>
		<cfset status_finance_css = status_finance_css>
		
		<cfset u_id = user_id>
		<cfset u_firstname = user_firstname>
		<cfset u_name = user_name>
		<cfset order_start = dateformat(order_start,'dd/mm/yyyy')>
		<cfset order_end = dateformat(order_end,'dd/mm/yyyy')>

		
		<cfset order_start = dateformat(order_start,'dd/mm/yyyy')>
		<cfset order_end = dateformat(order_end,'dd/mm/yyyy')>


		<cfset order_conv = order_conv>
		<cfset order_bdc = order_bdc>
		<cfset order_apc = order_apc>
		<cfset order_avn = order_avn>
		<cfset order_avn2 = order_avn2>
		<cfset order_aff = order_aff>
		<cfset order_cert = order_cert>
		<cfset order_bf = order_bf>

		<cfset order_ref2 = order_ref2>
		<cfset order_comment = order_comment>

		<cfset pack_id = pack_id>
		<cfset formation_id = formation_id>
	</cfoutput>

	

	<!--- TODO a mettre dans api quand OK --->
	<cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
		SELECT u.user_id, u.user_name, u.user_firstname
		FROM orders_users ou
		INNER JOIN user u ON u.user_id = ou.user_id
		WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>

	<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT ap.provider_id, ap.provider_name, ap.provider_code, ap.provider_tva 
		FROM account_provider ap 
		INNER JOIN orders o ON ap.provider_id = o.provider_id 
		WHERE o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>

	<cfif get_provider.recordCount GT 0>
		<cfset cur_provider = QueryGetRow(get_provider, 1)>
	</cfif>
 

	<cfset get_order_invoice = obj_order_get.oget_orders_invoice(o_id="#o_id#")>	

	<cfquery name="get_package" datasource="#SESSION.BDDSOURCE#">
		SELECT oip.order_item_package_id, oip.account_id, oip.hour_qty,
		llm.method_id, llm.method_name_#SESSION.LANG_CODE# as method_name, 
		lf.formation_id, lf.formation_name_#SESSION.LANG_CODE# as formation_name, 
		llc.certif_id, llc.certif_name,
		lld.destination_id, lld.destination_name, 
		lle.elearning_id, lle.elearning_name, 
		lfp.pack_id, lfp.pack_name, 
		oip.date_begin, oip.date_end 
		FROM order_item_package oip
		LEFT JOIN lms_lesson_method llm ON llm.method_id = oip.method_id 
		LEFT JOIN lms_list_certification llc ON llc.certif_id = oip.certif_id
		LEFT JOIN lms_list_destination lld ON lld.destination_id = oip.destination_id
		LEFT JOIN lms_formation lf ON lf.formation_id = oip.formation_id
		LEFT JOIN lms_formation_pack lfp ON lfp.pack_id = oip.pack_id
		LEFT JOIN lms_list_elearning lle ON lle.elearning_id = oip.elearning_id
		WHERE oip.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
	</cfquery>

	<!--- <cfloop from="1" to="5" index="cor">
	
	<cfquery name="get_item_invoice_#cor#" datasource="#SESSION.BDDSOURCE#">
	SELECT oi.*, a.account_name 
	FROM order_item_invoice oi
	INNER JOIN account a ON oi.f_account_id = a.account_id
	WHERE oi.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#"> AND order_item_mode_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
	</cfquery>	
	
	<cfset "f_account_id_#cor#" = evaluate("get_item_invoice_#cor#").f_account_id>
	<cfset "f_account_name_#cor#" = evaluate("get_item_invoice_#cor#").account_name>
	<cfset "item_inv_hour_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_hour>
	<cfset "item_inv_unit_price_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_unit_price>
	<cfset "item_inv_fee_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_fee>
	<cfset "item_inv_total_#cor#" = evaluate("get_item_invoice_#cor#").item_inv_total>
	<cfset "user_id_#cor#" = evaluate("get_item_invoice_#cor#").user_id>
	<cfset "order_item_mode_id_#cor#" = evaluate("get_item_invoice_#cor#").order_item_mode_id>
	
	</cfloop> --->
	

	<!--- <cfquery name="get_opca" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	(
	SELECT account_name, account_id
	FROM account a WHERE type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4"> AND account_id <> 495 AND account_id <> 432 
	)
	UNION
	(
	SELECT "---SELECTION---" as account_name, "0" as account_id
	)
	ORDER BY account_name
	</cfquery>

	<cfquery name="get_edof" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT account_name, account_id FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="495">
	</cfquery>

	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT account_name, account_id FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
	</cfquery>

	<cfquery name="get_pole" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT account_name, account_id FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="432">
	</cfquery> --->

	<!--- <cfquery name="get_elearning" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_elearning
	</cfquery>

	<cfquery name="get_certification" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_certification
	</cfquery>

	<cfquery name="get_destination" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_destination
	</cfquery>	 --->

	<!--- <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
	SELECT formation_id, formation_code, formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
	</cfquery> --->

	<cfif pack_id neq "" AND pack_id neq 0>
	<cfquery name="get_syllabus" datasource="#SESSION.BDDSOURCE#">
		SELECT pack_id, pack_name FROM lms_formation_pack WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>
	</cfif>


	<cfset paid_total = 0>
	<cfset hour_total = 0>
	<cfset ht_total = 0>

	<cfset to_pay_total = 0>
	<cfset to_hour_total = 0>
	<cfset to_ht_total = 0>

</cfsilent>


	
<form action="updater_order.cfm">

<div class="row">
	<cfoutput>
	<div class="col-md-12" align="center">
		<!--- <a type="button" id="up_order_<cfoutput>#a_id#_#o_id#</cfoutput>" class="up_order btn btn-info">Modifier Order<i class="far fa-plus-circle"></i></a> --->

		<a href="https://sign.wefitgroup.com/wefit_convention_generatorV4.cfm?o_id=#o_id#" class="btn btn-info" target="_blank">Générer Conv</a>
		<!--- https://sign.wefitgroup.com/wefit_convention_generatorV3.cfm?cv_context=CPF%20HTT&o_id=21-6155&cv_language=PORTUGAIS&cv_method=ELEARNING&cv_mode=CONSO&cv_payment=30%20JOURS%20NET&cv_datefrom=44245&cv_dateto=44637&cv_company=CPF%20WGROUP%20EDOF&cv_opca=EDOF&cv_opca_ad1=Mon%20Compte%20Formation%20g%C3%A9r%C3%A9%20par%20la%20Caisse%20des%20D%C3%A9p%C3%B4ts%20et%20Consignations&cv_opca_ad2=56,%20rue%20de%20Lille%20&cv_opca_ad3=&cv_opca_ad4=75356&cv_opca_ad5=PARIS%2007%20SP&cv_dir_ad1=&cv_dir_ad2=&cv_dir_ad3=&cv_dir_name=%20&cv_dir_title=&cv_dir_fad=Mon%20Compte%20Formation%20g%C3%A9r%C3%A9%20par%20la%20Caisse%0D%0Ades%20D%C3%A9p%C3%B4ts%20et%20Consignations%20-%2056,%20rue%20de%20Lille%20-%20%2075356%20PARIS%2007%20SP%20-%20&cv_fname=Marie&cv_lname=ESENKAYA&cv_email=marie.ayse75@gmail.com&cv_phone=07%2082%2089%2022%2033&cv_certif=BRIGHT%20PORTUGAIS%20(Code%20CPF%20236368)&cv_opca_nbh=40&cv_opca_eurh=0&cv_opca_certif=0&cv_opca_fees=220&cv_dir_nbh=&cv_dir_eurh=&cv_dir_certif=&cv_dir_fees= --->

		<a href="https://sign.wefitgroup.com/wefit_avenant_generator.cfm?o_id=#o_id#" class="btn btn-info" class="btn btn-info disabled" target="_blank">Générer Avenant</a>
		<!--- https://sign.wefitgroup.com/wefit_avenant_generator.cfm?cv_context=CPF%20HTT&o_id=21-6155&cv_language=PORTUGAIS&cv_method=ELEARNING&cv_mode=CONSO&cv_payment=30%20JOURS%20NET&cv_datefrom=44245&cv_dateto=44637&cv_company=CPF%20WGROUP%20EDOF&cv_opca=EDOF&cv_apc_ref=EDOF%203886038338&cv_opca_ad1=Mon%20Compte%20Formation%20g%C3%A9r%C3%A9%20par%20la%20Caisse%20des%20D%C3%A9p%C3%B4ts%20et%20Consignations&cv_opca_ad2=56,%20rue%20de%20Lille%20&cv_opca_ad3=&cv_opca_ad4=75356&cv_opca_ad5=PARIS%2007%20SP&cv_dir_ad1=&cv_dir_ad2=&cv_dir_ad3=&cv_dir_name=%20&cv_dir_title=&cv_dir_fad=Mon%20Compte%20Formation%20g%C3%A9r%C3%A9%20par%20la%20Caisse%0D%0Ades%20D%C3%A9p%C3%B4ts%20et%20Consignations%20-%2056,%20rue%20de%20Lille%20-%20%2075356%20PARIS%2007%20SP%20-%20&cv_fname=Marie&cv_lname=ESENKAYA&cv_email=marie.ayse75@gmail.com&cv_phone=07%2082%2089%2022%2033&cv_certif=BRIGHT%20PORTUGAIS%20(Code%20CPF%20236368)&cv_opca_nbh=40&cv_opca_eurh=0&cv_opca_certif=0&cv_opca_fees=220&cv_dir_nbh=&cv_dir_eurh=&cv_dir_certif=&cv_dir_fees= --->


		<a href="https://sign.wefitgroup.com/wefit_generator3.cfm?o_id=#o_id#&doc_type=af" class="btn btn-info" target="_blank">Générer AF</a>
		
		<!--- <a href="" class="btn btn-info" class="btn btn-info disabled" target="_blank">Générer AF</a> --->
<!--- https://sign.wefitgroup.com/wefit_generator2.cfm?cv_context=CPF%20HTT&o_id=21-6155&cv_language=PORTUGAIS&cv_method=ELEARNING&cv_datefrom=44245&cv_dateto=44637&trainer_epf=&c_af=CPF%20WGROUP%20EDOF&fn_af=Marie&n_af=ESENKAYA&cv_certif=BRIGHT%20PORTUGAIS%20(Code%20CPF%20236368)&cv_opca_nbh=40&cv_dir_nbh= --->


		<cfif get_orders_users.recordCount LTE 1>
			<a href="https://sign.wefitgroup.com/wefit_generator3.cfm?o_id=#o_id#&doc_type=aff" class="btn btn-info" target="_blank">Générer AFF</a>
			<!--- https://sign.wefitgroup.com/wefit_generator2.cfm?cv_context=CPF%20HTT&o_id=21-6155&cv_language=PORTUGAIS&cv_method=ELEARNING&cv_datefrom=44245&cv_dateto=44637&trainer_epf=&c_aff=CPF%20WGROUP%20EDOF&fn_aff=Marie&n_aff=ESENKAYA&cv_certif=BRIGHT%20PORTUGAIS%20(Code%20CPF%20236368)&cv_opca_nbh=40&cv_dir_nbh= --->
		</cfif>
		
		<cfif status_finance_id eq 11>
			<!--- <a href="https://sign.wefitgroup.com/wefit_generator3.cfm?o_id=#o_id#&doc_type=aff" class="btn btn-info" target="_blank">Générer AFF</a> --->
			<a type="button" class="btn btn-info" target="_blank" href="./tpl/invoice_shop_view.cfm?o_id=#o_id#">SHOP PDF <i class="far fa-download"></i></a>
		</cfif>
	</div>
	</cfoutput>

</div>



<div class="row">
								
	<div class="col-md-12">
		
		<div class="bg-light p-2 m-1 border">
			<h6 align="center" class="text-red">1- Dossier</h6>
			<br>

			<div class="row">
								
				<div class="col-md-5">
					<table class="table table-sm table-bordered bg-white">
						<tr bgcolor="#ECECEC">
							<td align="center" colspan="5"><strong>Dossier de formation</strong></td>
						</tr>
						<tr>
							<td width="25%"><label>Order</label></td>
							<td>
							<h5 class="m-0"><span class="badge badge-pill text-white badge-default"><cfoutput>#order_ref#</cfoutput></span></h5>
							</td>
						</tr>
						<tr>
							<td><label>Statut</label></td>
							<td>
								<cfoutput><h6 class="m-0"><span class="badge badge-pill text-white badge-#status_finance_css#">#status_finance_name#</span></h5></cfoutput>
							</td>
						</tr>
						<tr>
							<td width="25%"><label>Convention</label></td>
							<td>
								<cfoutput>#context_alias#</cfoutput>
							</td>
						</tr>
						<tr>
							<td><label>&Eacute;dition/Close</label></td>
							<td>
								<cfoutput>#order_date#</cfoutput>
							</td>
						</tr>
						<tr>
							<td><label>Account</label></td>
							<td>
								<cfoutput><a href="crm_account_edit.cfm?a_id=#a_id#">#account_name#</a></cfoutput>
							</td>
						</tr>
						<tr>
							<td><label>Provider</label></td>
							<td>
								<cfif isDefined("cur_provider")>
									<cfoutput>#cur_provider.provider_name#</cfoutput>
								</cfif>
							</td>
						</tr>
						<tr>
							<td><label>Entre le</label></td>
							<td>
								<cfoutput>#order_start#</cfoutput>
							</td>
						</tr>										
						<tr>
							<td><label>Et le</label></td>
							<td>
								<cfoutput>#order_end#</cfoutput>						
							</td>
						</tr>		
						<tr>
							<td><label>Réf/N° client</label></td>
							<td><cfoutput>#order_ref2#</cfoutput></td>
						</tr>
						<tr>
							<td><label>Commentaires</label></td>
							<td><cfoutput>#order_comment#</cfoutput></td>
						</tr>
		
						
						<!---<tr>
							<td width="25%"><label>R&eacute;f&eacute;rent</label></td>
							<td>
								<cfselect class="form-control" name="contact_id" query="get_contact" display="contact_name" value="contact_id" <!---selected="#contact_id#"--->>
								<option value="0" <cfif contact_id eq "0">selected="selected"</cfif>>NC</option>
								</cfselect>
							</td>
						</tr>--->
						<!---<tr>
							<td><label>Adresse Si&egrave;ge</label></td>
							<td>
								<textarea class="form-control" name="order_address" placeholder="Adresse" required="yes" rows="2"><!---<cfoutput>#order_address#</cfoutput>---></textarea>
							</td>
						</tr>	--->									
					</table>
				</div>

				<div class="col-md-7">
					<cfif isdefined("o_id")>
					<table class="table table-sm table-bordered bg-white">
						<cfoutput>
							<tr bgcolor="##ECECEC">
								<td align="center" colspan="9"><strong>Documents administratifs - GLOBAL ORDER</strong></td>
							</tr>
							<tr>
								<td>
									<cfif order_conv neq "" AND fileexists("#SESSION.BO_ROOT#/admin/conv/#order_conv#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/conv/#order_conv#" target="_blank"><i class="fal fa-check"></i><br>CONV</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CONV</button>
									</cfif>
								</td>
								<td>
									<cfif order_bdc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bdc/#order_bdc#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bdc/#order_bdc#" target="_blank"><i class="fal fa-check"></i><br>BDC</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>BDC</button>
									</cfif>
								</td>
								<td>
									<cfif order_apc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/apc/#order_apc#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/apc/#order_apc#" target="_blank"><i class="fal fa-check"></i><br>APC</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>APC</button>
									</cfif>
								</td>
								<td>
									<cfif order_avn neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn/#order_avn#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn/#order_avn#" target="_blank"><i class="fal fa-check"></i><br>AVN</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AVN</button>
									</cfif>
								</td>
								<td>
									<cfif order_avn2 neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn2/#order_avn2#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn2/#order_avn2#" target="_blank"><i class="fal fa-check"></i><br>AVN2</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AVN2</button>
									</cfif>
								</td>
								<td>
									<cfif order_aff neq "" AND fileexists("#SESSION.BO_ROOT#/admin/aff/#order_aff#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/aff/#order_aff#" target="_blank"><i class="fal fa-check"></i><br>AFF</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AFF</button>
									</cfif>
								</td>
								<!--- <td>
									<cfif order_cda neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cda/#order_cda#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/cda/#order_cda#" target="_blank"><i class="fal fa-check"></i><br>CDA</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CDA</button>
									</cfif>
								</td> --->
								<td>
									<cfif order_cert neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cert/#order_cert#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/cert/#order_cert#" target="_blank"><i class="fal fa-check"></i><br>CERT</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CERT</button>
									</cfif>
								</td>
								<td>
									<cfif order_bf neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bf/#order_bf#")>
									<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bf/#order_bf#" target="_blank"><i class="fal fa-check"></i><br>BF</a>
									<cfelse>
									<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>BF</button>
									</cfif>
								</td>
							</tr>
							<tr>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_conv p-1" id="conv_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_bdc p-1" id="bdc_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_apc p-1" id="apc_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn p-1" id="avn_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn2 p-1" id="avn2_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_aff p-1" id="aff_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<!--- <td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_cda p-1" id="cda_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td> --->
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_cert p-1" id="cert_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
								<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_bf p-1" id="bf_#a_id#_#o_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							</tr>
						</cfoutput>			
					</table>

					<table class="table table-sm table-bordered bg-white">

						<cfset total_dur_tp = 0>
						<cfset nb_learner = get_orders_users.recordCount>
						<cfoutput query="get_orders_users">
							<tr>
								<td bgcolor="##ECECEC"><strong><a href="common_learner_account.cfm?u_id=#user_id#">#user_name# #user_firstname#</a></strong></td>
								
								<td>
									<cfif order_conv neq "" AND fileexists("#SESSION.BO_ROOT#/admin/conv/#user_id#/#order_conv#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/conv/#user_id#/#order_conv#" target="_blank"><i class="fal fa-check"></i><br>CONV</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_conv p-1" id="conv_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif order_bdc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bdc/#user_id#/#order_bdc#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bdc/#user_id#/#order_bdc#" target="_blank"><i class="fal fa-check"></i><br>BDC</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_bdc p-1" id="bdc_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif order_apc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/apc/#user_id#/#order_apc#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/apc/#user_id#/#order_apc#" target="_blank"><i class="fal fa-check"></i><br>APC</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_apc p-1" id="apc_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif order_avn neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn/#user_id#/#order_avn#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn/#user_id#/#order_avn#" target="_blank"><i class="fal fa-check"></i><br>AVN</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn p-1" id="avn_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif order_avn2 neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn2/#user_id#/#order_avn2#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn2/#user_id#/#order_avn2#" target="_blank"><i class="fal fa-check"></i><br>AVN2</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn2 p-1" id="avn2_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif nb_learner GT 1>
										<a href="https://sign.wefitgroup.com/wefit_generator3.cfm?o_id=#o_id#&doc_type=aff&u_id=#user_id#" class="btn btn-info p-1" target="_blank">Générer AFF</a>
									</cfif>

									<cfif order_aff neq "" AND fileexists("#SESSION.BO_ROOT#/admin/aff/#user_id#/#order_aff#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/aff/#user_id#/#order_aff#" target="_blank"><i class="fal fa-check"></i><br>AFF</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_aff p-1" id="aff_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>
								<td>
									<cfif order_cert neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#order_cert#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/cert/#user_id#/#order_cert#" target="_blank"><i class="fal fa-check"></i><br>CERT</a>
								</cfif>
								<button class="btn btn-sm btn-outline-danger btn-block btn_upl_cert p-1" id="cert_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<td>
									<cfif order_bf neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bf/#user_id#/#order_bf#")>
										<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bf/#user_id#/#order_bf#" target="_blank"><i class="fal fa-check"></i><br>BF</a>
									</cfif>
									<button class="btn btn-sm btn-outline-danger btn-block btn_upl_bf p-1" id="bf_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button>
								</td>

								<!--- <td><button class="btn btn-sm btn-outline-danger btn-block up_order_user p-1" id="conv_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td> --->

								<cfquery name="get_orders_users_dur" datasource="#SESSION.BDDSOURCE#">
									SELECT SUM(t.tp_duration) as _dur
									FROM lms_tpuser tu
									INNER JOIN lms_tp t ON t.tp_id = tu.tp_id AND t.method_id = 1
									WHERE tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
									AND t.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
								</cfquery>

								<td><strong>
									<cfif get_orders_users_dur._dur neq "" AND get_orders_users_dur._dur neq 0>
										<cfset total_dur_tp = total_dur_tp + get_orders_users_dur._dur>
										#(get_orders_users_dur._dur /60)#H
									<cfelse>
										0H
									</cfif>
								</strong></td>
							</tr>
							<!--- <tr>
							<td>
								<cfif order_conv neq "" AND fileexists("#SESSION.BO_ROOT#/admin/conv/#user_id#/#order_conv#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/conv/#user_id#/#order_conv#" target="_blank"><i class="fal fa-check"></i><br>CONV</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CONV</button>
								</cfif>
							</td>
							<td>
								<cfif order_bdc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bdc/#user_id#/#order_bdc#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bdc/#user_id#/#order_bdc#" target="_blank"><i class="fal fa-check"></i><br>BDC</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>BDC</button>
								</cfif>
							</td>
							<td>
								<cfif order_apc neq "" AND fileexists("#SESSION.BO_ROOT#/admin/apc/#user_id#/#order_apc#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/apc/#user_id#/#order_apc#" target="_blank"><i class="fal fa-check"></i><br>APC</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>APC</button>
								</cfif>
							</td>
							<td>
								<cfif order_avn neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn/#user_id#/#order_avn#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn/#user_id#/#order_avn#" target="_blank"><i class="fal fa-check"></i><br>AVN</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AVN</button>
								</cfif>
							</td>
							<td>
								<cfif order_avn2 neq "" AND fileexists("#SESSION.BO_ROOT#/admin/avn2/#user_id#/#order_avn2#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/avn2/#user_id#/#order_avn2#" target="_blank"><i class="fal fa-check"></i><br>AVN2</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AVN2</button>
								</cfif>
							</td>
							<td>
								<cfif order_aff neq "" AND fileexists("#SESSION.BO_ROOT#/admin/aff/#user_id#/#order_aff#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/aff/#user_id#/#order_aff#" target="_blank"><i class="fal fa-check"></i><br>AFF</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>AFF</button>
								</cfif>
							</td>
							<!--- <td>
								<cfif order_cda neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cda/#user_id#/#order_cda#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/cda/#user_id#/#order_cda#" target="_blank"><i class="fal fa-check"></i><br>CDA</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CDA</button>
								</cfif>
							</td> --->
							<td>
								<cfif order_cert neq "" AND fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#order_cert#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/cert/#user_id#/#order_cert#" target="_blank"><i class="fal fa-check"></i><br>CERT</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>CERT</button>
								</cfif>
							</td>
							<td>
								<cfif order_bf neq "" AND fileexists("#SESSION.BO_ROOT#/admin/bf/#user_id#/#order_bf#")>
								<a class="btn btn-sm btn-success btn-block text-white p-0" href="./admin/bf/#user_id#/#order_bf#" target="_blank"><i class="fal fa-check"></i><br>BF</a>
								<cfelse>
								<button class="btn btn-sm btn-outline-danger btn-block p-0"><i class="fal fa-times"></i><br>BF</button>
								</cfif>
							</td>
						</tr>
						<tr>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_conv p-1" id="conv_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_bdc p-1" id="bdc_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_apc p-1" id="apc_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn p-1" id="avn_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_avn2 p-1" id="avn2_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_aff p-1" id="aff_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<!--- <td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_cda p-1" id="cda_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td> --->
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_cert p-1" id="cert_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
							<td><button class="btn btn-sm btn-outline-danger btn-block btn_upl_bf p-1" id="bf_#a_id#_#o_id#_#user_id#"><i class="fal fa-upload" aria-hidden="true"></i></button></td>
						</tr> --->
					</cfoutput>
					<tr>
						<td colspan="9"> Total /H :</td>
						<td><cfoutput>#(total_dur_tp /60)#H</cfoutput></td>
					</tr>

					</table>

					</cfif>


				</div>

			</div>

		</div>
		

	</div>

</div>

<div class="row">
		
	<div class="col-md-6">
		
		<div class="bg-light p-2 m-1 border h-100">
			<h6 align="center" class="text-red">2- Package</h6>
			<br>		
			<table class="table table-sm table-bordered bg-white">
				<cfif pack_id neq "" AND pack_id neq 0>
					<tr bgcolor="#ECECEC">
						<td colspan="4" align="center"><strong>Package catalogue</strong></td>
					</tr>
					<cfoutput query="get_syllabus">
					<tr>
						<td colspan="4">
							#pack_name#
						</td>
					</tr>
					</cfoutput>
				</cfif>
				<tr bgcolor="#ECECEC">
					<td colspan="4" align="center"><strong>Package sur mesure</strong></td>
				</tr>
				<!--- <cfoutput query="get_formation"> --->
				<tr>
					<td>Formation</td>
					<td colspan="3">
					<!--- <cfselect name="formation_id" query="get_formation" display="formation_name" value="formation_id" selected="#formation_id#" class="form-control form-control-sm">
					</cfselect> --->
					<cfoutput>#formation_name#</cfoutput>
					</td>
				</tr>
				<!--- </cfoutput> --->
				<cfoutput query="get_package">
					<cfswitch expression="#get_package.method_id#"> 
						<!--- Visio --->
						<cfcase value="1">
	
							<tr>
								<td width="20%">Visio</td>
								<td width="20%">#get_package.hour_qty# h</td>
								<td width="40%"></td>
								<td width="20%">
									#LSdateformat(date_begin,'dd/mm/yyyy', SESSION.LANG_CODE)#
									#LSdateformat(date_end,'dd/mm/yyyy', SESSION.LANG_CODE)#
								</td>
							</tr>
	
						</cfcase>
						<!--- F2F --->
						<cfcase value="2">
	
							<tr>
								<td>F2F</td>
								<td>#get_package.hour_qty# h</td>
								<td></td>
								<td>
									#LSdateformat(date_begin,'dd/mm/yyyy', SESSION.LANG_CODE)#
									#LSdateformat(date_end,'dd/mm/yyyy', SESSION.LANG_CODE)#
								</td>
							</tr>
							
						</cfcase> 
						<!--- Elearning --->
						<cfcase value="3">
	
							<tr>
								<td>Elearning</td>	
								<td>
									<cfif get_package.hour_qty lt "30">
										#get_package.hour_qty# jour(s)	
									<cfelse>
										#get_package.hour_qty/30# mois
									</cfif>	
								</td>
								<td>
									<!--- <cfselect name="elearning_id" query="get_elearning" display="elearning_name" value="elearning_id" class="form-control form-control-sm">
									</cfselect> --->
									#get_package.elearning_name#
								</td>
								<td>
									#LSdateformat(date_begin,'dd/mm/yyyy', SESSION.LANG_CODE)#
									#LSdateformat(date_end,'dd/mm/yyyy', SESSION.LANG_CODE)#
								</td>	
							</tr>
							
						</cfcase>
						<!--- Immersion --->
						<cfcase value="6">
	
							<tr>
								<td>Immersion</td>
								<td>#get_package.hour_qty# h</td>
								<td>
									<!--- <cfselect name="destination_id" query="get_destination" display="destination_name" value="destination_id" class="form-control form-control-sm">
									</cfselect> --->
									#get_package.destination_name#
								</td>
								<td>
									#LSdateformat(date_begin,'dd/mm/yyyy', SESSION.LANG_CODE)#
									#LSdateformat(date_end,'dd/mm/yyyy', SESSION.LANG_CODE)#
								</td>
							</tr>
							
							
						</cfcase>
						<!--- Certif - get to be a row since we need to be able to have it on the factu as a separate entity --->
						<cfcase value="7">
	
							<tr>
								<td>Certif</td>
								<td colspan="3">
								<!--- <cfselect name="certif_id" query="get_certification" display="certif_name" value="certif_id" class="form-control form-control-sm">
								</cfselect> --->
								#get_package.certif_name#
								</td>
							</tr>
							
						</cfcase>
						<!--- <cfdefaultcase></cfdefaultcase>  --->
					</cfswitch>

				</cfoutput>
			</table>
		</div>
		
	</div>

	<div class="col-md-6">

		<div class="bg-light p-2 m-1 border h-100">
		<h6 align="center" class="text-red">3- Financement</h6>
		<br>
	

		<cfoutput>
		<cfset total_order = 0>
		<table class="table table-sm table-bordered bg-white">
			<tr bgcolor="##ECECEC">
				<td><strong>Type</strong></td>
				<td><strong>D&eacute;signation</strong></td>
				<td><strong>Nb L</strong></td>
				<td><strong>H.</strong></td>
				<td><strong>P.U.</strong></td>
				<td><strong>Fees</strong></td>
				<td align="right"><strong>Total</strong></td>
				<td align="center"><strong>+</strong></td>
			</tr>
			<cfset total_finance = 0>
			<cfloop query="get_order_invoice">
				<!--- FILLING VAR FOR INVOICING TOTAL --->
				<cfset to_pay_total = to_pay_total + item_inv_total>
				<cfset to_hour_total = to_hour_total + item_inv_hour>
				<cfset to_ht_total = to_ht_total + item_inv_total>
				<tr>

					<td>#order_item_mode_name#</td>

					<td>#account_name#</td>
					<td>#item_inv_nb_users#</td>	
					<td>#item_inv_hour#</td>	
					<td>#item_inv_unit_price#</td>	
					<td>#item_inv_fee#</td>
					<td align="right">#item_inv_total#</td>
					<cfset total_finance += item_inv_total>
					<td colspan="5" align="center">
						<a type="button" id="add_inv_#f_account_id#_#o_id#_#order_item_mode_id#_#order_item_mode_name#" class="add_invoice btn btn-sm btn-info"><i class="fal fa-plus"></i></a>
					</td>
				</tr>

			</cfloop>

			<tr bgcolor="##ECECEC">
				<td>TOTAL</td>

				<td colspan="5"></td>	
				<td align="right" colspan="2">#total_finance# € HT</td>
			</tr>


		</table>
		</cfoutput>
		
		
		</div>
		
		
		
	</div>
	
</div>

<div class="row mt-2">
		
	<div class="col-md-12">
		
		<div class="bg-light p-2 m-1 border">
		<h6 align="center" class="text-red">4- Facturation</h6>
		<br>

		<table class="table table-bordered bg-white">
			<tbody>
				<tr class="bg-light">
					<cfif listFindNoCase("FINANCE", SESSION.USER_PROFILE)>
						<th width="2%"><label></label></th>
					</cfif>
					<th width="7%" bgcolor="#eaffea"><label>INV REF </label></th>
					<th width="7%" bgcolor="#eaffea"><label>INV DATE </label></th>
					<th width="6%" bgcolor="#eaffea"><label>INV ST.</label></th>
					<th width="7%" bgcolor="#eaffea"><label>INV START </label></th>
					<th width="7%" bgcolor="#eaffea"><label>INV END </label></th>
					<th width="7%" bgcolor="#eaffea"><label>INV PAID </label></th>
					<th width="6%" bgcolor="#eaffea"><label>NB H </label></th>
					<th width="6%" bgcolor="#eaffea"><label>INV HT </label></th>
					<th width="5%" bgcolor="#d1eaf5"><label>ORD ID </label></th>
					<th width="7%" bgcolor="#d1eaf5"><label>ORD ST.</label></th>
					<th width="7%" bgcolor="#d1eaf5"><label>ORD HT </label></th>
					<th width="20%"><label>DESTINATAIRE </a></label></th>
					<th width="3%"><label>MAJ</label></th>
					<th width="3%"><label>PDF</label></th>
				</tr>

				<cfoutput query="get_invoice">
					<!--- <cfif invoice_paid neq ""><cfset paid_total = paid_total + invoice_paid></cfif> --->
					<cfif nbitem neq ""><cfset hour_total = hour_total + nbitem></cfif>
					<cfif invoice_amount neq ""><cfset ht_total = ht_total + invoice_amount></cfif>
				<tr>
					<cfif listFindNoCase("FINANCE", SESSION.USER_PROFILE)>
						<td><a type="button" class="delete_invoice" id="delete_invoice_#a_id#_#invoice_id#"><i class="far fa-trash"></i></a></td>
					</cfif>
					<td>#invoice_ref#</td>
					<td>#dateformat(invoice_date,'dd/mm/yyyy')#</td>
					<td><span class="badge badge-pill text-white badge-#status_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_name#</span></td>
					<td>#dateformat(invoice_start,'dd/mm/yyyy')#</td>
					<td>#dateformat(invoice_end,'dd/mm/yyyy')#</td>
					<td><cfif invoice_paid neq "">#dateformat(invoice_paid,'dd/mm/yyyy')#<cfelse>-</cfif></td>
					<td align="right"><strong>#numberformat(nbitem,'____.__')#</strong></td>
					<td align="right"><strong>#numberformat(invoice_amount,'____.__')# &euro;</strong></td>
					<td><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
					<td><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_name#</span></td>
					<td align="right"><strong>#numberformat(invoice_amount,'____.__')# &euro;</strong></td>
					<td><a href="crm_account_edit.cfm?a_id=#dest_id#"><small><strong>#mid(dest_name,1,30)#</strong></small></a></td>
					<td><a type="button" class="update_invoice" id="update_invoice_#dest_id#_#invoice_id#"><i class="far fa-plus-circle"></i></a></td>
					<td><a type="button" target="_blank" href="./tpl/invoice_view.cfm?invoice_ref=#invoice_ref#"><i class="far fa-download"></i></a></td>
				</tr>
				</cfoutput>
				<tr bgcolor="#eaffea">
					<td colspan="6">
						PAID
					</td>
					<!--- <td>
						<cfif isDefined("cur_provider")>
							<cfoutput>#paid_total + (paid_total * (cur_provider.provider_tva /100))#</cfoutput>&nbsp;&euro;
						<cfelse>
							<cfoutput>#paid_total#</cfoutput>&nbsp;&euro;
						</cfif>
					</td> --->
					<td>
						<cfoutput>#hour_total#</cfoutput> H
					</td>
					<td>
						<cfoutput>#ht_total#</cfoutput>&nbsp;&euro; HT
					</td>
				</tr>
				<tr bgcolor="#eaffea">
					<td colspan="6">
						REMAINING
					</td>
					<!--- <td>
						<cfif isDefined("cur_provider")>
							<cfoutput>#(to_pay_total - paid_total) + ((to_pay_total - paid_total) * (cur_provider.provider_tva /100))#</cfoutput>&nbsp;&euro;
						<cfelse>
							<cfoutput>#to_pay_total - paid_total#</cfoutput>&nbsp;&euro;
						</cfif>
					</td> --->
					<td>
						<cfoutput>#to_hour_total - hour_total#</cfoutput> H
					</td>
					<td>
						<cfoutput>#to_ht_total - ht_total#</cfoutput>&nbsp;&euro; HT
					</td>
				</tr>
			</tbody>
		</table>

		</div>
				
		</form>
	
<script>
$(document).ready(function() {

	$("#order_date").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy'
	})
	$("#order_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#order_end").datepicker( "option", "minDate", selectedDate );
			order_start = $('#order_start').datepicker("getDate");
			order_start = moment(order_start).format('YYYY-MM-DD');
		}		
	})
	$("#order_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			order_end = $('#order_end').datepicker("getDate");
			order_end = moment(order_end).format('YYYY-MM-DD');
		}	
	})
	
	$("#calcul").click(function() {
		calcul();
	})
	
	function calcul()	
	{
		function isFloat(n){
			return Number(n) === n && n % 1 !== 0;
		}

		$(".total_direct").val(parseFloat($(".nbh_direct").val())*parseFloat($(".pu_direct").val())+parseFloat($(".fee_direct").val()));
		$(".total_opco").val(parseFloat($(".nbh_opco").val())*parseFloat($(".pu_opco").val())+parseFloat($(".fee_opco").val()));
		$(".total_edof").val(parseFloat($(".nbh_edof").val())*parseFloat($(".pu_edof").val())+parseFloat($(".fee_edof").val()));
		$(".total_pe").val(parseFloat($(".nbh_pe").val())*parseFloat($(".pu_pe").val())+parseFloat($(".fee_pe").val()));
		$(".total_perso").val(parseFloat($(".nbh_perso").val())*parseFloat($(".pu_perso").val())+parseFloat($(".fee_perso").val()));
		
		var total_total = 0;
		total_total += parseFloat($(".total_direct").val());
		total_total += parseFloat($(".total_opco").val());
		total_total += parseFloat($(".total_edof").val());
		total_total += parseFloat($(".total_pe").val());
		total_total += parseFloat($(".total_perso").val());
	
		$(".total_total").val(total_total);
		
	}

	$('.btn_upl_conv').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];

		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_conv&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion convention");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	$('.btn_upl_bdc').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];

		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_bdc&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion Bon de Commande / Devis");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	$('.btn_upl_apc').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_apc&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion APC");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	$('.btn_upl_avn').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_avn&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion Avenant");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	$('.btn_upl_avn2').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_avn2&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion Avenant 2");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});

	$('.btn_upl_aff').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_aff&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion Attestation Fin de Formation");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	
	$('.btn_upl_cert').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_cert&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		$('#modal_title_xl').text("Gestion Certification");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});
	
	$('.btn_upl_bf').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		var o_id = idtemp[2];
		var u_id = idtemp[3];
		
		let to = "modal_window_order_upload.cfm?a_id="+a_id+"&o_id="+o_id+"&from=learner&act=upl_bf&ucb=<cfoutput>#u_id#</cfoutput>"
		if (u_id) { to+= "&u_id="+u_id; }
		
		$('#modal_title_xl').text("Gestion Bilan Formation");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load(to, function() {});
	});

	$('.up_order').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[2];
		var o_id = idtemp[3];

		console.log(a_id, o_id)
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Order - " + o_id);
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_order_create.cfm?a_id="+a_id+"&o_id="+o_id, function() {});
	});


	$('.add_invoice').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[2];
		var o_id = idtemp[3];
		var mode = idtemp[4];
		var name = idtemp[5];
		$('#modal_title_xl').text("Invoice - " + name);
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_order_invoice.cfm?a_id="+a_id+"&o_id="+o_id+"&mode="+mode, function() {});
	});

	$(".update_invoice").click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");

		var a_id = idtemp[2];
		var i_id = idtemp[3];
		var mode = idtemp[4];

		// console.log(a_id, i_id);

		$('#modal_title_xl').text("Invoice");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_order_invoice.cfm?i_id="+i_id+"&a_id="+a_id+"&o_id="+<cfoutput>#o_id#</cfoutput>, function() {});
	});

	$(".delete_invoice").click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");

		var a_id = idtemp[2];
		var i_id = idtemp[3];
		var mode = idtemp[4];

		if(confirm("Confirmer la suppression de l'invoice ?")) {
		
			$.ajax({
				url : './api/orders/orders_post.cfc?method=delete_invoice',
				type : 'POST',	   
				<cfoutput>
				data : {invoice_id: i_id},
				</cfoutput>
				success : function(resultat, statut){
					$('#window_item_xl').modal({keyboard: true});
					$('#modal_title_xl').text("Edition order <cfoutput>#o_id#</cfoutput>");
					$('#modal_body_xl').load("modal_window_order_read.cfm?o_id=<cfoutput>#o_id#</cfoutput>", function(){});

				},
				error : function(resultat, statut, erreur){
					// alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
				}
			})
		}

	});



});
</script>
</cfif>