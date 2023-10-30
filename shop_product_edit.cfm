<!DOCTYPE html>
<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">		

	<cfif isdefined("p_id")>
		<cfquery name="get_product" datasource="#SESSION.BDDSOURCE#">
		SELECT p.*, pa.attribute_id, pa.attribute_name, pv.variation_id, 
		pv.variation_name_#SESSION.LANG_CODE# as variation_name, pv.price_unit 
		FROM product p 
		LEFT JOIN product_attribute pa ON pa.product_id = p.product_id
		LEFT JOIN product_variation pv ON pv.attribute_id = pa.attribute_id
		WHERE p.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfquery>
	<cfelseif isdefined("c_id")>
		<cfquery name="get_coupon" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM product_coupon WHERE coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
		</cfquery>
	<!---<cfelse>
		<cflocation addtoken="no" url="db_product_list.cfm">--->
	</cfif>
	
	<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
		SELECT group_id, group_name FROM account_group
		ORDER BY group_name ASC 
	</cfquery>
	
	<cfquery name="get_products" datasource="#SESSION.BDDSOURCE#">
	SELECT *
	FROM product p
	LEFT JOIN product_category p_cat ON p_cat.category_id = p.category_id
	ORDER BY p.category_id
</cfquery>

<cfquery name="get_cert_list" datasource="#SESSION.BDDSOURCE#">
	SELECT certif_id, certif_name FROM lms_list_certification WHERE certif_active = 1 OR certif_active = 0 ORDER BY certif_name
</cfquery>

<cfset country_varlist = "français,anglais,allemand,espagnol,italien,portuguais,russe,mandarin,néerlandais,flamand,suédois">
<cfset version_varlist = "general,business">
<cfset pack_varlist = "5 h,10 h,15 h,20 h">

	<cfquery name="get_product_cat" datasource="#SESSION.BDDSOURCE#">
		SELECT category_id as cat_id, category_name_#SESSION.LANG_CODE# as category_name
		FROM product_category 
	</cfquery>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Products">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">
					
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
					
					
					<cfif isdefined('p_id')>
					
						<form action="db_updater.cfm" method="post">
						<div class="card-body">
							<cfoutput>
							<h5 class="card-title d-inline">#get_product.product_name#</h5>
							</cfoutput>
							
							<table class="table table-bordered table-sm" style="margin-bottom:0px;">
							<!------ PAGE ------>
								<cfoutput>
								<tr class="bg-white">
									<td width="20%">
										Product page title
									</td>
									<td>
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_title_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active show</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>active show</cfif>" id="updt_title_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="updt_title_#lg#" value="#evaluate('get_product.product_title_#lg#')#">
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									
									</td>
								</tr>
								
								<tr class="bg-white">
									<td width="20%">
										Product page description
									</td>
									<td>
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_desc_page_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active show</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>active show</cfif>" id="updt_desc_page_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="updt_desc_page_#lg#" value="#evaluate('get_product.product_desc_#lg#')#">
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								</cfoutput>
							<!------ CATEGORY ------>
								<tr class="bg-white">
									<td width="20%">
										Product Category
									</td>
									<td>
									<cfoutput>
										<cfset cur_cat = #get_product.category_id#>
										<select name="updt_cat" class="form-control">
										<cfloop query="get_product_cat">
										<option value="#cat_id#" <cfif #cat_id# eq #cur_cat#> selected="selected"</cfif>>
										#category_name#
										</option>
										</cfloop>
										</select>
									</cfoutput>
									</td>
								</tr>
							<!------ NAME ------>	
								<tr class="bg-white">
									<td width="20%">
										Product Name
									</td>
									<td width="80%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_name_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>show active</cfif>" id="updt_name_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="updt_name_#lg#" value="#evaluate('get_product.product_name_#lg#')#">
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								
								<!------ SUB NAME ------>	
								<tr class="bg-white">
									<td width="20%">
										Product SubName
									</td>
									<td width="80%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_subname_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>show active</cfif>" id="updt_subname_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="updt_subname_#lg#" value="#evaluate('get_product.product_subname_#lg#')#">
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								
								<!------ ABSTRACT ------>	
								<tr class="bg-white">
									<td width="20%">
										Product Abstract
									</td>
									<td width="80%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_abstract_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>show active</cfif>" id="updt_abstract_#lg#" style="margin-top:15px;">
												<textarea name="updt_abstract_#lg#" class="form-control">#evaluate('get_product.product_abstract_#lg#')#</textarea>
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
								<!------ DESCRIPTION ------>	
								<tr class="bg-white">
									<td width="20%">
										Product Description
									</td>
									<td width="80%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_description_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>show active</cfif>" id="updt_description_#lg#" style="margin-top:15px;">
												<textarea name="updt_description_#lg#" class="form-control product_text">#evaluate('get_product.product_description_#lg#')#</textarea>
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
							<!------ DESCRIPTION LONG ----->
								<tr class="bg-white">
									<td width="20%">
										Product Description Long
									</td>
									<td width="80%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										<cfoutput>
										<li class="nav-item">		
											<a href="##updt_description_long_#lg#" class="nav-link <cfif SESSION.LANG_CODE eq #lg#>active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										</cfoutput>
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											<cfoutput>
											<div role="tabpanel" class="tab-pane <cfif SESSION.LANG_CODE eq #lg#>show active</cfif>" id="updt_description_long_#lg#" style="margin-top:15px;">
												<textarea name="updt_description_long_#lg#" rows="10" style="height:150px !important; width:100%" width="100%">#evaluate('get_product.product_description_long_#lg#')#</textarea>
											</div>
											</cfoutput>
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
								
							
							</table>
							
							<div id="variation_accordion">
								<table class="table table-bordered table-sm mt-0 mb-0" style="border-top:none;">
								<tr class="bg-white">
									<td width="20%" style="border-top:none;">
										TYPE: 
									</td>
									<td style="border-top:none;">
											<div class="form-group mb-0">
												<input type="radio" id="product_type_simple" name="product_type" value="simple" <cfif get_product.product_type eq "simple">checked </cfif>data-toggle="collapse" data-target="#simple" aria-expanded="true" aria-controls="simple">
												<label for="product_type_simple" class="p-2"> Simple </label>
												<input type="radio" id="product_type_variable" name="product_type" value="variable" <cfif get_product.product_type eq "variable">checked </cfif>data-toggle="collapse" data-target="#variable" aria-expanded="true" aria-controls="variable">
												<label for="product_type_variable" class="p-2"> Variable </label>
											</div>
									</td>
								</tr>
								</table>
						
							
							
							<div align="center">
							<cfoutput>
							<input type="hidden" name="updt_product" value="#p_id#">
							</cfoutput>
							<input type="submit" value="Enregistrer produit" class="btn btn-info">
							</div>

							</form>


						
							
							<!------------------------------------------------>
							<!----------- ATTRIBUTES / VARIATIONS ------------>
							<!------------------------------------------------>
							<form action="db_updater.cfm" method="post">
							
							<div  id="simple" class="collapse<cfif get_product.product_type eq 'simple'>show </cfif>" data-parent="#variation_accordion">
							<cfoutput>
							<table class="table table-bordered table-sm mt-0 mb-0" style="border-top:none;">
								
							<tr class="bg-white">
								<td width="20%" style="border-top:none;">Certification</td>
								<td style="border-top:none;">
									<select name="insert_certif" class="form-control">
										<option value="0">NO CERTIF</option>
										<cfloop query="get_cert_list">
											<option value="#certif_id#" <cfif get_product.certif_id eq #certif_id#>selected</cfif>>#certif_name#</option>
										</cfloop>
									</select>
								</td>
							</tr>
							
							<tr class="bg-white">
								<td width="20%">Price</td>
								<td>
									<input type="number" step="0.01" min="0.00" max="10000.00" name="unit_price" value="#get_product.product_price_unit#">
								</td>
							</tr>
							</table>
							</cfoutput>
							</div>
								
								
								
							<div id="variable" class="collapse <cfif get_product.product_type eq 'variable'>show</cfif>" data-parent="#variation_accordion">
							<cfoutput>
							<table class="table table-bordered table-sm mt-0 mb-0" style="border-top:none;">
							<tr>
							<td>
									ATTRIBUTS : 
							</td>
							</tr>
							<tr class="bg-white">
								
								<td style="border-top:none;">
										
									<table class="table table-borderless table-sm" style="border:none;">
									
										
										
										
										<cfsilent>
										<cfquery name="get_attributes" datasource="#SESSION.BDDSOURCE#">
											SELECT * FROM product_attribute WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
										</cfquery>
										</cfsilent>
										
										<cfset countvar = 1>
										<cfloop query="get_attributes">
										
										<cfsilent>
											<cfset var_cat = #lcase('#attribute_name#')#>
											<cfif var_cat eq "langue">
												<cfset varlist = #country_varlist#>
											<cfelseif var_cat eq "version">
												<cfset varlist = #version_varlist#>
											<cfelseif var_cat eq "pack">
												<cfset varlist = #pack_varlist#>
											<cfelseif var_cat eq "Durée">
												<cfset varlist = #pack_varlist#>
											</cfif>
										</cfsilent>
										
										<tr id="attr_#countvar#">
										<td>
										
											<table class="table table-bordered table-sm">
													
												<tr class="attribute_#countvar#">
													<td width="25%">
														Type:
													</td>
													<td width="40%">
														<select id="#countvar#" name="insert_attribute_#countvar#" class="form-control insert_attribute">
															<option value="Langue" <cfif var_cat eq "langue">selected</cfif>>language</option>
															<option value="Version" <cfif var_cat eq "version">selected</cfif>>version</option>
															<option value="Pack" <cfif var_cat eq "pack">selected</cfif>>pack</option>
															<option value="Durée" <cfif var_cat eq "durée">selected</cfif>>durée</option>
														</select>
													</td>
													<td>
														<div align="right">
															<div class="btn btn-danger rm_attribute" id="#countvar#">Supprimer l'attribut</div>
														</div>
													</td>
												</tr>
												<tr><td colspan="3">
												<table class="table table-borderless table-sm variation_#countvar#"><!--- countvar pour n° attribut --->
													<tr class="mt-2 mb-2">
														<td width="25%">Variations:</td> 
														<td width="35%"><u>Désignation</u></td> 
														<td width="20%"><u>Price Unit</u></td> 
														<td width="20%"><u>Group</u></td> 												
													</tr>
													<div class="form-group">
													<cfloop list="#varlist#" index="cur_var">
														<cfquery name="get_var" datasource="#SESSION.BDDSOURCE#">
															SELECT * FROM product_variation WHERE attribute_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attribute_id#"> AND variation_name_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cur_var#">
														</cfquery>
														<tr>
															<td>
																<div class="m-2">
																	<cfif var_cat eq "langue">
																		<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
																			SELECT formation_id FROM lms_formation WHERE formation_name_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cur_var#">
																		</cfquery>
																		<cfset cur_val = #get_formation.formation_id#>
																	<cfelse>
																		<cfset cur_val = #cur_var#>
																	</cfif>
																	<input type="checkbox" <cfif get_var.recordcount() neq 0>checked </cfif>id="insert_variation_#cur_var#" name="insert_variation_#countvar#_#cur_var#" value="#cur_val#">
																	<label for="insert_variation_#cur_var#" class="p-2"> #cur_var# </label>
																</div>
															</td>
															<td class="pr-4">
																<select name="insert_varcertif_#countvar#_#cur_var#" class="form-control">
																	<option value="0">NO CERTIF</option>
																	<cfloop query="get_cert_list">
																		<option value="#certif_id#" <cfif get_var.recordcount() neq 0 and get_var.certif_id eq #certif_id#> selected</cfif>>#certif_name#</option>
																	</cfloop>
																</select>
															</td>
															<td>
																<input type="number" step="0.01" name="varprice_#countvar#_#cur_var#" placeholder="00.00" <cfif get_var.recordcount() neq 0>value="#get_var.price_unit#"</cfif>>
															</td>
															<td>
																<input type="number" step="0.01" name="vargroup_#countvar#_#cur_var#" placeholder="00.00" <cfif get_var.recordcount() neq 0>value="#get_var.group_unit#"</cfif>>
															</td>
														</tr>
													</cfloop>
													</div>
												</table>
												</td></tr>
											</table>
											<cfset countvar += 1>
										</cfloop>
										
										
										
										
										
										
										</td>
										</tr>
											
										<tr class="last_tr">
											<td align="center"><div class="btn btn-outline-info mt-3 p-2 btn_add_var" id="#countvar#"> Ajouter une variation </div></td>
										</tr>
									</table>
										
								</td>
							</tr>
							</table>
							</cfoutput>
							</div>
							</div>
						</div>
								<!------------------------------------------------>
							
							<div align="center">
							<cfoutput>
							<input type="hidden" name="updt_product_var" value="#p_id#">
							</cfoutput>
							<input type="submit" value="Enregistrer attributs" class="btn btn-info">
							</div>
						</div>
						</form>
						
					</cfif>
					
					
					
					<cfif isdefined('new_coupon')>
						<form action="db_updater.cfm" method="post">
						<div class="card-body">
							<cfoutput>
							<h5 class="card-title d-inline">Add a new promotional code</h5>
							
							<table class="table table-borderless table-sm" style="margin-bottom:0px; border: 1px solid grey;" cellpadding="3">
								<tr>
									<td width="20%" style="border-bottom:1px solid grey;">Code :</td>
									<td width="25%" style="border-bottom:1px solid grey;"><input type="text" class="form-control" name="coupon_code" placeholder="XXXX"></td>
									<td width="5%" style="border-right:1px solid grey; border-bottom:1px solid grey;"></td>
									<td width="20%" style="border-bottom:1px solid grey;">Limit uses :<br><small>(0 for no limit)</small></td>
									<td width="25%" style="border-bottom:1px solid grey;"><input type="number" step="1" name="use_limit" value="0"></td>
									<td width="5%" style="border-bottom:1px solid grey;"></td>
								</tr>
								<tr>
									<td width="20%" style="border-bottom:1px solid grey;">Group :</td>
									<td width="25%" width="80%" style="border-bottom:1px solid grey;">
										<!--- <cfselect class="form-control" name="group_id" query="get_group" display="group_name" value="group_id" selected="#get_coupon.group_id#"></cfselect> --->
										<select class="form-control" name="c_group">
											<option value="0" selected>---Select Group---</option>
											<cfloop query="get_group">
											<option value="#get_group.group_id#">#get_group.group_name#</option>
											</cfloop>
										</select>
									</td>
									<td width="5%" style="border-right:1px solid grey; border-bottom:1px solid grey;"></td>
									<td width="20%" style="border-bottom:1px solid grey;">User :</td>
									<td width="25%" style="border-bottom:1px solid grey;"><input type="number" name="c_user_id"></td>
									<td width="5%" style="border-bottom:1px solid grey;"></td>
								</tr>
								<tr>
									<td style="border-bottom:1px solid grey;">discount (HT):</td>
									<td style="border-bottom:1px solid grey;"><input type="decimal" step="0.01" class="form-control" name="coupon_discount" placeholder="00.00"></td>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"></td>
									<td style="border-bottom:1px solid grey;">type : </td>
									<td style="border-bottom:1px solid grey;">
										<select name="coupon_type" class="form-control">
											<option value="euro"> &euro; </option>
											<option value="pourcent"> % </option>
										</select>
									</td>
									<td style="border-bottom:1px solid grey;"></td>
								</tr>
								<tr>
									<td style="border-bottom:1px solid grey;">date start : </td>
									<td style="border-bottom:1px solid grey;"><input type="date" name="date_start" value="#dateformat(now(), 'yyyy-mm-dd')#"></td>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"></td>
									<td style="border-bottom:1px solid grey;">date end : </td>
									<td style="border-bottom:1px solid grey;"><input type="date" name="date_end" value="#dateformat(dateadd('yyyy',1,now()), 'yyyy-mm-dd')#"></td>
									<td style="border-bottom:1px solid grey;"></td>
								</tr>
								<tr>
								<td>products :</td>
								<td colspan="5">
								<table class="table table-md">
									<tr class="add_line">
										<cfset count = 0>
										<td width="75%" align="center"><div align="center"><div id="#count#" class="btn btn-outline-info btn_add_cpn_product"><i class="far fa-plus"></i></div></div></td>
										<td width="25%"></td>
									</tr>
								</table>
								</td>
								</tr>
								<tr>
									<td colspan="6">
										<input type="hidden" name="add_cpn" value="1">
										<!---<input type="hidden" name="nb_product" value="#count#">--->
										<input type="hidden" name="c_valid" value="1"> 
										<div align="center"><input type="submit" class="btn btn-outline-info" value=" Ajouter le coupon"></div>
									</td>
								</tr>
							</table>
							</cfoutput>
						</div>
						</form>
					</cfif>
					
					<cfif isdefined('c_id')>
						<form action="db_updater.cfm" method="post">
						<div class="card-body">
							<cfoutput>
							<h5 class="card-title d-inline">#get_coupon.coupon_code#</h5>
							</cfoutput>
							
							<cfoutput query="get_coupon">
							<table class="table table-borderless table-sm" style="margin-bottom:0px; border: 1px solid grey">
							
								<tr>
									<td width="20%"  style="border-right:1px solid grey; border-bottom:1px solid grey;">
										Coupon n° #coupon_id#
									</td>
									<td width="40%"  style="border-bottom:1px solid grey;">
										 CODE : 
									</td>
									<td width="40%"  style="border-bottom:1px solid grey;">
										<input type="text" class="form-control" name="coupon_code" value="#coupon_code#">
									</td>
								</tr>

								<tr>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"> ACTIVE : </td>
									<td colspan="2" class="text-center" style="border-bottom:1px solid grey;">
										<label>
											<input name="c_valid" type="checkbox" <cfif coupon_valid eq 1>checked</cfif> value="1"> 
										</label>
									</td>
								</tr>

								<tr>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"> GROUP / USER : </td>
									<td style="border-bottom:1px solid grey;">
										<!--- <cfselect class="form-control" name="group_id" query="get_group" display="group_name" value="group_id" selected="#get_coupon.group_id#"></cfselect> --->
										<select class="form-control" name="c_group">
											<option value="0" <cfif group_id eq "0" OR group_id eq "">selected</cfif>>---Select Group---</option>
											<cfloop query="get_group">
											<option value="#get_group.group_id#" <cfif get_coupon.group_id eq get_group.group_id>selected</cfif>>#get_group.group_name#</option>
											</cfloop>
										</select>
									</td>
									<td style="border-bottom:1px solid grey;">
										<input type="text" class="form-control" name="c_user_id" value="#get_coupon.user_id#">
									</td>
								</tr>

								<tr>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"> DISCOUNT : </td>
									<td style="border-bottom:1px solid grey;">
										<input type="decimal" step="0.01" class="form-control" name="coupon_discount" placeholder="00,00" value="#coupon_discount#">
										<!--- <input type="number" class="form-control" name="coupon_discount" value="#coupon_discount#"> --->
									</td>
									<td style="border-bottom:1px solid grey;">
										<select name="coupon_type" class="form-control">
											<option value="euro"> &euro; </option>
											<option value="pourcent"> % </option>
										</select>
									</td>
								</tr>
								
								<tr>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"> USES LIMIT : </td>
									<td style="border-bottom:1px solid grey;">
										<input type="number" step="1" name="use_limit" value="#coupon_use_limit#">
									</td>
									<td style="border-bottom:1px solid grey;">
										( current uses: #coupon_use# )
									</td>
								</tr>
										
								<tr>
									<td style="border-right:1px solid grey; border-bottom:1px solid grey;"> DATES (START-END) : </td>
									<td style="border-bottom:1px solid grey;">
										<input type="date" name="date_start" value="#dateformat('#coupon_start#', 'yyyy-mm-dd')#" placeholder="#dateformat('#coupon_start#', 'yyyy-mm-dd')#">
									</td>
									<td style="border-bottom:1px solid grey;">
										<input type="date" name="date_end" value="#dateformat('#coupon_end#', 'yyyy-mm-dd')#" placeholder="#dateformat('#coupon_end#', 'yyyy-mm-dd')#">
									</td>
								</tr>
								
								<tr>
									<td style="border-bottom:1px solid grey; border-right:1px solid grey;">
										PRODUCT:
									</td>
									<td style="border-bottom:1px solid grey;" colspan="2">
										<table class="table table-borderless table-sm mt-2">
											<cfset count = 0>
											<cfif product_id neq "0">
												<cfloop list="#product_id#" index="cur_product">
												<cfset count += 1>
												<tr id="line_product_#count#">
													<td width="85%">
														<select name="product_#count#" class="form-control">
															<cfloop query="get_products">
																<option value="#product_id#" <cfif cur_product eq #product_id#>selected</cfif>>#product_name#</option>
															</cfloop>
														</select>
													</td>
													<td>
														<div align="center"><div class="btn rm_cpn_product" id="#count#"><i class="far fa-trash-alt"></i></div></div>
													</td>
												</tr>
												</cfloop>
											</cfif>
											<tr class="add_line">
												
												<td colspan="2"><div align="center"><div id="#count+1#" class="btn btn-outline-info btn_add_cpn_product"><i class="far fa-plus"></i></div></div></td>
												<cfset count += 1>
											</tr>
										</table>
									</td>
								</tr>
								
										
								<tr>
									<td colspan="3">
										<input type="hidden" name="updt_cpn" value="#coupon_id#">
										<input type="hidden" name="nb_product" id="nb_product" value="#count#">
										<div align="center"><input type="submit" class="btn btn-outline-info" value=" Appliquer les modifications "></div>
									</td>
								</tr>
							
							</table>
							</cfoutput>
							
							
							
							
							
							
						</div>
						</form>
					</cfif>
				</div>
					
				</div>
				
			</div>
			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$( document ).ready(function() {

	count_prdt = parseInt(0);

	tinymce.init({
		selector:'.product_text',
		branding: false,
		contextmenu: "link image imagetools table spellchecker",
		contextmenu_never_use_native: true,
		draggable_modal: false,
		menubar: '',	
		toolbar: 'undo redo | bold italic underline | code',
		plugins: "lists,code",
		fontsize_formats: '11px 12px 14p'
	});

	
	
	var handler_rm_cpn_product = function rm_cpn_product(){
		event.preventDefault();
				
		var product_count = $(this).attr("id");
	
		$('#line_product_'+product_count).empty();
			
	}	
	
	$('.rm_cpn_product').bind("click", handler_rm_cpn_product);
	
	$('.btn_add_cpn_product').click(function(event) {
		event.preventDefault();
		count_prdt += 1;
		var product_count = $(this).attr("id");
		
		var_cur_count = parseInt(product_count) + parseInt(count_prdt);
	
		liner = "";
		liner += '<tr id="line_product_'+var_cur_count+'">';
		liner += '<td width="85%">';
		liner += '<select name="product_'+var_cur_count+'" class="form-control">';
		
		$.ajax({				 
			url: 'components/queries.cfc?method=oget_products_json',
			type: "POST",
			data : {},
			datatype : "html",
			success : function(result, statut){
				
				var result = $.parseJSON(result);

				$.each(result['DATA'], function(i, obj) {
				
					liner += '<option value="'+obj[0]+'">'+obj[1]+'</option>';
				
				});
				
		
			liner += '</select>';
			liner += '</td>';
			liner += '<td>';
			liner += '<div align="center"><div class="btn rm_cpn_product" id="'+var_cur_count+'"><i class="far fa-trash-alt"></i></div></div>';
			liner += '</td>';
			liner += '</tr>';
		
			$('.add_line').before(liner);

			$("#nb_product").val(var_cur_count);
		
			$('.rm_cpn_product').bind("click", handler_rm_cpn_product);
			}
		});
		
	});

	
	country_varlist = ["français","anglais","allemand","espagnol","italien","portuguais","russe","mandarin","néerlandais","flamand","suédois"];
	version_varlist = ["general","business"];
	pack_varlist = ["5 h","10 h","15 h","20 h"];
	
	count = parseInt(0);

	$('.btn_add_var').click(function(event) {
		event.preventDefault();

		var countvar = parseInt($(this).attr("id"));
		var countvar = countvar+count;
		console.log(countvar);
		count = count+1;
		var varlist = country_varlist;


		var liner = '';
		liner += '<tr id="attr_'+countvar+'">';
		liner += '<td>';
		
		liner += '<table class="table table-bordered table-sm">';
													
		liner += '<tr class="attribute_'+countvar+'">';
		liner += '<td width="25%"> Type: </td>';
		liner += '<td width="40%"><select id="'+countvar+'" name="insert_attribute_'+countvar+'" class="form-control insert_attribute">';
		liner += '<option value="Langue">language</option>';
		liner += '<option value="Version">version</option>';
		liner += '<option value="Pack">pack</option>';
		liner += '<option value="Durée">durée</option>';
		liner += '</select></td>';
		liner += '<td><div align="right"><div class="btn btn-danger rm_attribute" id="'+countvar+'">Supprimer l attribut</div></div></td>';
		liner += '</tr>';
		
		
		liner += '<tr><td colspan="3">';
		liner += '<table class="table table-borderless table-sm variation_'+countvar+'">';
												
		liner += '<tr class="mt-2 mb-2">';
		liner += '<td width="25%">Variations:</td>';
		liner += '<td width="35%"><u>Désignation</u></td>';
		liner += '<td width="20%"><u>Price Unit</u></td>';
		liner += '<td width="20%"><u>Group</u></td>';												
		liner += '</tr>';
		
		liner += '<div class="form-group">';
				
		$.each(varlist, function( index, var_name ) {
		liner += '<tr><td>';				
				
		liner += '<div class="m-2">';
		liner += '<input type="checkbox" id="insert_variation_'+var_name+'" name="insert_variation_'+var_name+'" value="'+var_name+'">';
		liner += '<label for="insert_variation_'+countvar+'_'+var_name+'" class="p-2"> '+var_name+' </label>';
		liner += '</div>';
				
		liner += '</td>';
				
		liner += '<td class="pr-4">';
		<cfoutput>
		liner += '<select name="insert_varcertif_'+countvar+'_'+var_name+'" class="form-control">';
		liner += '<option value="0">NO CERTIF</option>';
		<cfloop query="#get_cert_list#">
		liner += '<option value="#certif_id#">#certif_name#</option>';
		</cfloop>
		liner += '</select>';
		liner += '</cfoutput>';
		
		liner += '</td>';
				
		liner += '<td>';
		liner += '<input type="number" step="0.01" name="varprice_'+countvar+'_'+var_name+'" placeholder="00.00">';
		liner += '</td>';
				
		liner += '<td>';
		liner += '<input type="number" step="0.01" name="vargroup_'+countvar+'_'+var_name+'" value="1.00">';
		liner += '</td>';
				
		liner += '</tr>';
		});
				
		liner += '</div>';
		
		liner += '</table>';
		liner += '</td></tr>';
		
		
		
		
		
		liner += '</table>';
		
		liner += '</td></tr>';

		

		
		$(".last_tr").before(liner);
		$('.insert_attribute').bind("change", handler_var_change);
		$('.rm_attribute').bind("click", handler_rm_attr);
				
	});
			
	
	
	var handler_var_change = function var_change(){
				
		var countvar = $(this).attr("id");
		$('.variation_'+countvar).empty();
					
		if ($(this).val() == "Langue"){
			var varlist = country_varlist;
			var attr = "langue";
		}
		if ($(this).val() == "Version"){
			var varlist = version_varlist;
			var attr = "version";
		}
		if ($(this).val() == "Pack"){
			var varlist = pack_varlist;
			var attr = "pack";
		}
		
		
		var liner = '';
		liner += '<tr class="mt-2 mb-2">';
		liner += '<td width="25%">Variations:</td>';
		liner += '<td width="35%"><u>Certification</u></td>';
		liner += '<td width="20%"><u>Price Unit</u></td>';
		liner += '<td width="20%"><u>Group</u></td>';												
		liner += '</tr>';
		liner += '<div class="form-group">';
		
				
		$.each(varlist, function( index, var_name ) {
		liner += '<tr><td>';				
				
		liner += '<div class="m-2">';
		liner += '<input type="checkbox" id="insert_variation_'+countvar+'_'+var_name+'" name="insert_variation_'+countvar+'_'+var_name+'" value="'+var_name+'">';
		liner += '<label for="insert_variation_'+var_name+'" class="p-2"> '+var_name+' </label>';
		liner += '</div>';
				
		liner += '</td>';
				
		liner += '<td class="pr-4">';
		<cfoutput>
		liner += '<select name="insert_varcertif_'+countvar+'_'+var_name+'" class="form-control">';
		liner += '<option value="0">NO CERTIF</option>';
		<cfloop query="#get_cert_list#">
		liner += '<option value="#certif_id#">#certif_name#</option>';
		</cfloop>
		liner += '</select>';
		liner += '</cfoutput>';
		liner += '</td>';
				
		liner += '<td>';
		liner += '<input type="number" step="0.01" name="varprice_'+countvar+'_'+var_name+'" placeholder="00.00">';
		liner += '</td>';
				
		liner += '<td>';
		liner += '<input type="number" step="0.01" name="vargroup_'+countvar+'_'+var_name+'" value="1.00">';
		liner += '</td>';
				
		liner += '</tr>';
		});
				
		liner += '</div>';
				
		$('.variation_'+countvar).append(liner);
		
	}
	
	$('.insert_attribute').bind("change", handler_var_change);
	
	var handler_rm_attr = function rm_attr(){
				
		var countvar = $(this).attr("id");
		$('#attr_'+countvar).empty();
	}
	
	$('.rm_attribute').bind("click", handler_rm_attr);
});
</script>

</body>
</html>