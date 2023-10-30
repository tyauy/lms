<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,3,4,5,6,7,8,9">
<cfinclude template="./incl/incl_secure.cfm">

<!--- <cfif isdefined("SESSION.ACCESS_EL") AND listlen(SESSION.LIST_ACCESS_EL) gte "1">
<cfparam name="f_id" default="#listgetat(SESSION.LIST_ACCESS_EL,1)#">
<cfelse> --->
<cfparam name="f_id" default="3">
<!--- </cfif> --->

<cfparam name="subm" default="email">

<cfparam name="lang_select" default="en">
<cfparam name="lang_translate" default="">
<!---<cfif isdefined("url.lang_select")>
<cfset lang_translate = "">
<cfelse>
<cfparam name="lang_translate" default="">
</cfif>--->


<cfif subm eq "vocabulary" AND not isdefined("voc_cat_select")>
	<cfset voc_cat_select = RandRange("1","45")>
</cfif>
<cfif subm eq "vocabulary_perso" AND not isdefined("voc_cat_select")>
	<cfset voc_cat_select = 0>
</cfif>


<cfif isdefined("SESSION.ACCESS_EL")>

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE <cfif listlen(SESSION.LIST_ACCESS_EL) GTE "1">formation_id IN (#SESSION.LIST_ACCESS_EL#)<cfelse>formation_id <= 5</cfif>
</cfquery>	

</cfif>
		
</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
h1,h2,h3,h4,h5{
	font-family: 'Titillium Web', sans-serif;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_tools')#">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="row">
				<div class="col-md-12">
					
					<div class="card border">
						<div class="card-body">
						
						
							<cfif subm eq "email">
							
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-circle-envelope fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('title_page_common_wemail')#</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>

								<div class="row">
									<div class="col-md-12">
										
										<cfif isdefined("SESSION.ACCESS_EL")>
										<div class="pull-right">			
										<select class="form-control" onChange="document.location.href='common_tools.cfm?subm=email&f_id='+$(this).val()">
										<cfoutput query="get_formation">
											<cfif formation_id eq "3">
												<option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
											</cfif>
										</cfoutput>
										<select>
										</div>
										</cfif>
									
										
										<cfoutput><p>#obj_translater.get_translate_complex('intro_mail_template')#</p></cfoutput>
										
										<br>
									</div>
								</div>
								
								<cfif not isdefined("SESSION.ACCESS_EL")>
									<cfinclude template="./incl/incl_noaccess.cfm">
								<cfelse>
											
								<cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
								SELECT w.wemail_id, w.wemail_category, w.wemail_subcategory, w.wemail_category_clean, w.wemail_subject, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category) as nb, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category AND wemail_sample_1 IS NOT NULL) as nb_notnull FROM lms_wemail w WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY w.wemail_category, w.wemail_subcategory, w.wemail_subject 
								</cfquery>
									
								<h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_wemail_search')#</cfoutput></h6>
								
								<form id="form-global_search" name="global_search" class="mt-2">
									<div class="typeahead__container">
										<div class="typeahead__field">
											<div class="typeahead__query">
												<input class="js_typeahead_wemail" name="wemail[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
											</div>
											<div class="typeahead__button">
												<button type="submit">
													<i class="typeahead__search-icon"></i>
												</button>
											</div>
										</div>
									</div>
								</form>
								
								<br><br>
								<h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_wemail_category')#</cfoutput></h6>
							
								<div class="row">
									<div class="col-md-3">
										<div class="tree mt-2" id="tree_wemail1">
											<ul style="padding:0px">	
												<cfif f_id eq "2">
													<cfset startrow = "1">
													<cfset maxrows = "16">
												<cfelseif f_id eq "3">
													<cfset startrow = "1">
													<cfset maxrows = "8">
												</cfif>
												<cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
													<li>
														<span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
														
														<ul>
														<cfif wemail_subcategory neq "">
															<cfoutput group="wemail_subcategory">
																<li style="display:none"> <span>#wemail_subcategory#</span>
																	<ul>
																		<cfoutput group="wemail_subject">
																			<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
																		</cfoutput>
																	</ul>													
																</li>
															</cfoutput>
														<cfelse>											
															<cfoutput group="wemail_subject">
																<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
															</cfoutput>
														</cfif>
														
														</ul>
													</li>
												</cfoutput>
												
											</ul>
										</div>
									</div>
									<div class="col-md-3">
										<div class="tree mt-2" id="tree_wemail2">
											<ul style="padding:0px">	
												<cfif f_id eq "2">
													<cfset startrow = "190">
													<cfset maxrows = "16">
												<cfelseif f_id eq "3">
													<cfset startrow = "36">
													<cfset maxrows = "8">
												</cfif>
												<cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
													<li>
														<span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
														
														<ul>
														<cfif wemail_subcategory neq "">
															<cfoutput group="wemail_subcategory">
																<li style="display:none"> <span>#wemail_subcategory#</span>
																	<ul>
																		<cfoutput group="wemail_subject">
																			<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
																		</cfoutput>
																	</ul>													
																</li>
															</cfoutput>
														<cfelse>											
															<cfoutput group="wemail_subject">
																<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
															</cfoutput>
														</cfif>
														
														</ul>
													</li>
												</cfoutput>
											
											</ul>
										</div>
									</div>
									<div class="col-md-3">
										<div class="tree mt-2" id="tree_wemail3">
											<ul style="padding:0px">	
												<cfif f_id eq "2">
													<cfset startrow = "380">
													<cfset maxrows = "16">
												<cfelseif f_id eq "3">
													<cfset startrow = "73">
													<cfset maxrows = "8">
												</cfif>
												<cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
													<li>
														<span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
														
														<ul>
														<cfif wemail_subcategory neq "">
															<cfoutput group="wemail_subcategory">
																<li style="display:none"> <span>#wemail_subcategory#</span>
																	<ul>
																		<cfoutput group="wemail_subject">
																			<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
																		</cfoutput>
																	</ul>													
																</li>
															</cfoutput>
														<cfelse>											
															<cfoutput group="wemail_subject">
																<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
															</cfoutput>
														</cfif>
														
														</ul>
													</li>
												</cfoutput>
												
											</ul>
										</div>
									</div>
									<div class="col-md-3">
										<div class="tree mt-2" id="tree_wemail4">
											<ul style="padding:0px">	
												<cfif f_id eq "2">
													<cfset startrow = "897">
													<cfset maxrows = "50">
												<cfelseif f_id eq "3">
													<cfset startrow = "97">
													<cfset maxrows = "8">
												</cfif>
												<cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
													<li>
														<span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
														
														<ul>
														<cfif wemail_subcategory neq "">
															<cfoutput group="wemail_subcategory">
																<li style="display:none"> <span>#wemail_subcategory#</span>
																	<ul>
																		<cfoutput group="wemail_subject">
																			<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
																		</cfoutput>
																	</ul>													
																</li>
															</cfoutput>
														<cfelse>											
															<cfoutput group="wemail_subject">
																<li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
															</cfoutput>
														</cfif>
														
														</ul>
													</li>
												</cfoutput>
												
											</ul>
										</div>
									</div>
									
								</div>
								
								</cfif>
													
							<cfelseif find("vocabulary", subm)>
							
								<cfset voc_btn_class = "fal fa-heart-square fa-2x btn_add_uvoc cursored">
								<cfif subm eq "vocabulary_perso">
									<cfset voc_btn_class = "fal fa-trash-alt fa-lg btn_rm_uvoc cursored">
								</cfif>
							
								<div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_#subm#_list')#</cfoutput></h5>
									<hr class="border-dark mb-3 mt-2">
								</div>

							
								<div class="row">
									<div class="col-xl-12">
										<cfif subm eq "vocabulary">
											
											<cfoutput><p class="mt-2">#obj_translater.get_translate_complex('intro_vocablist')#</p></cfoutput>
											
										</cfif>
										<br>
									</div>
								</div>
								
								<cfif not isdefined("SESSION.ACCESS_EL")>
									<cfinclude template="./incl/incl_noaccess.cfm">
								<cfelse>
								
									<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
									SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
									</cfquery>
									
									<cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
									SELECT v.voc_id, v.voc_word_#lang_select# as voc_word, v.voc_desc_#lang_select# as voc_desc, vc.voc_cat_name_#lang_select# as voc_cat_name, v.voc_cat_id
									FROM lms_vocabulary v
									INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
									
									WHERE voc_cat_online = 1									
									</cfquery>
									
									<cfif lang_select eq "en">
										<cfset lg_translate_select = "2">
									<cfelseif lang_select eq "fr">
										<cfset lg_translate_select = "1">
									<cfelseif lang_select eq "de">
										<cfset lg_translate_select = "3">
									</cfif>
									
									<cfif isdefined("voc_cat_select")>
										
									<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
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
									
									<cfif subm eq "vocabulary_perso">
										INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_id
									</cfif>
									
									WHERE <cfif subm eq "vocabulary_perso">uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
										  <cfelse>v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_select#"></cfif>  
									ORDER BY <cfif voc_cat_select eq -1>voc_cat, </cfif>voc_word_#lang_select#
									</cfquery>
									</cfif>
									
								
								
								<div class="row mt-3">
								
									<div class=<cfif subm eq "vocabulary">"col-md-4"<cfelse>"col-md-12"</cfif>>
									
										<div class="border bg-light p-2 h-100">
											<h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_settings')#</cfoutput></h6>
																						
											<div class="row mt-3">
												<label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('table_th_lrn_language')#</cfoutput></label>
												<div class="col-sm-8">
													<select class="form-control lang_select" name="lang_select">
														<option value="en" <cfif lang_select eq "en">selected</cfif>>English</option>
														<option value="fr" <cfif lang_select eq "fr">selected</cfif>>Fran&ccedil;ais</option>
														<option value="de" <cfif lang_select eq "de">selected</cfif>>Deutsch</option>
													</select>
												</div>
											</div>
											<div class="row mt-3">
												<label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('table_th_translation')#</cfoutput></label>
												<div class="col-md-8">
												<cfoutput>
												<cfloop list="en,fr,de" index="cor">
												<cfif cor neq lang_select>
												<label><input type="radio" name="lang_translate" class="lang_translate" id="lang_#cor#" value="#cor#" <cfif listfind(lang_translate,"#cor#")>checked</cfif>> <span class="lang-sm lang-lbl" lang="#cor#"></span></label> &nbsp;&nbsp;&nbsp;
												</cfif>
												</cfloop>
												</cfoutput>
												</div>
											</div>
											
											<cfif get_vocabulary.recordcount neq 0>
											<div class="row mt-3">
												<label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('btn_export')#</cfoutput></label>
												<div class="col-md-8">
												<cfoutput><a target="_blank" href="./tpl/vocablist_container.cfm?voc_cat_id=#voc_cat_select#&lang_select=#lang_select#&lang_select_id=#lg_translate_select#&<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-sm btn-primary"><i class="fad fa-file-pdf btn_export_list" id="export_#voc_cat_select#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
															
												</div>
											</div>
											</cfif>
										</div>
									
									</div>
									
									 
									<cfif subm eq "vocabulary">
									<div class="col-md-4">
									
										<div class="border bg-light p-2 h-100">
											<h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_thematic_list')#</cfoutput></h6>
									
											<div class="row mt-3">
												<div class="col-md-12">
													<select class="form-control voc_cat_select" name="voc_cat_select">
													<cfoutput query="get_category">
													<!---<a class="btn btn-sm <cfif voc_cat_select eq get_category.voc_cat_id>btn-outline-info active<cfelse>btn-outline-info</cfif> mb-0 py-0" href="common_tools.cfm?subm=vocabulary&voc_cat_select=#voc_cat_id#">#voc_cat_name#</a>--->
													<option value="#voc_cat_id#" <cfif voc_cat_select eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
													</cfoutput>
													</select>
												</div>
											</div>
										</div>
									
									</div>
									
									<div class="col-md-4">
										
										<div class="border bg-light p-2 h-100">
										
											<h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_vocab_search')#</cfoutput></h6>
											
											<div class="row mt-3">
												<div class="col-md-12">											
													<form id="form-global_search" name="global_search">
														<div class="typeahead__container">
															<div class="typeahead__field">
																<div class="typeahead__query">
																	<input class="js_typeahead_voc" name="vocabulary[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
																</div>
															</div>
														</div>
													</form>
												</div>
												
											</div>
										</div>
										
									</div>
									</cfif>
									
									
									
									
								</div>
									
								
								<cfif get_vocabulary.recordcount eq 0 && subm eq "vocabulary_perso">
								<div>
									<br>
									<p>
									
									<cfoutput>#obj_translater.get_translate_complex('empty_my_vocablist')#</cfoutput>
									
									</p>
								</div>
								<cfelseif isdefined("voc_cat_select")>
								<cfset sort_active = "fas fa-sort fa-1x">
								<cfset sort_desactive = "fal fa-sort fa-1x">
									
								<div class="row">
											
									<div class="col-md-12">
									
										<table <cfif lang_translate neq "">class="table table-bordered table-responsive mt-3"<cfelse>class="table table-bordered mt-3"</cfif>>
											<tr class="bg-light">
												<cfoutput>
												
												
												
												<th width="2%"></th>
												<th nowrap><label class="order_choice cursored" id="#lang_select#_0">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate_select#")#<cfif subm eq "vocabulary_perso">  <i class=<cfif voc_cat_select eq 0>"#sort_active#"<cfelse>"#sort_desactive#"</cfif>></i></cfif></label></th>
												<th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate_select#")#</label></th>
												<th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate_select#")#</label></th>
												
												<cfloop list="en,fr,de" index="cor">
												<cfif listfind(lang_translate,cor)>
												<cfif cor eq "en">
													<cfset lg_translate = "2">
												<cfelseif cor eq "fr">
													<cfset lg_translate = "1">
												<cfelseif cor eq "de">
													<cfset lg_translate = "3">
												</cfif>
												<th width="2%"></th>
												<th><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate#")#</label></th>
												<th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate#")#</label></th>
												<!--- <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th> --->
												</cfif>
												</cfloop>
												
												<cfif subm eq "vocabulary_perso">
												<th nowrap><label class="order_choice cursored" id="#lang_select#_-1">#obj_translater.get_translate(id_translate="table_th_vocab_category",lg_translate="#lg_translate_select#")#  <i class=<cfif voc_cat_select eq -1>"#sort_active#"<cfelse>"#sort_desactive#"</cfif>></i></label></th>
												</cfif>
												
												<th width="3%"></th>
												
												</cfoutput>
											</tr>
											
											<cfoutput query="get_vocabulary">
											<tr id="#SESSION.USER_ID#_#voc_id#">
											
												<cfif lang_select eq "en">
													<cfset td_color = "ecd9d9">
												<cfelseif lang_select eq "fr">
													<cfset td_color = "c6cbe1">
												<cfelseif lang_select eq "de">
													<cfset td_color = "c8d4ca">
												</cfif>
												
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													<a name="#voc_id#"></a>
													<span class="lang-sm" lang="#lang_select#"></span>
												</td>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													<strong>#evaluate('voc_word_#lang_select#')#</strong>
												</td>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													#evaluate('voc_type_name_#lang_select#')#
												</td>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													#evaluate('voc_desc_#lang_select#')#
												</td>
												
												
												<cfloop list="en,fr,de" index="cor">
												<cfif listfind(lang_translate,cor)>
												<cfif cor eq "en">
													<cfset td_color = "ecd9d9">
												<cfelseif cor eq "fr">
													<cfset td_color = "c6cbe1">
												<cfelseif cor eq "de">
													<cfset td_color = "c8d4ca">
												</cfif>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													<span class="lang-sm" lang="#cor#"></span>
												</td>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													<strong>#evaluate('voc_word_#cor#')#</strong>
												</td>
												<td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
													#evaluate('voc_type_name_#cor#')#
												</td>
												<!--- <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>> --->
													<!--- #evaluate('voc_desc_#cor#')# --->
												<!--- </td> --->
												</cfif>
												</cfloop>
												
												<cfif subm eq "vocabulary_perso">
													<td class="bg-light">
														#voc_cat#
													</td>
												</cfif>
												
												<td class="bg-white">
													<cfif subm eq "vocabulary">
														<cfsilent>
															<cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">SELECT * FROM user_vocablist WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#voc_id#></cfquery>
														</cfsilent>
														<cfif check_uvoc.recordcount neq 0>
															<i class="fas fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
														<cfelse>
															<i class="#voc_btn_class#" id="#SESSION.USER_ID#_#voc_id#"></i>
														</cfif>
													<cfelse>													
															<i class="#voc_btn_class#" id="#SESSION.USER_ID#_#voc_id#"></i>
													</cfif>
												</td>
												
											</tr>
											</cfoutput>
										</table>
									</div>
									
								</div>
									
								</cfif>
								
								</cfif>
								
							<cfelseif subm eq "video">
							
							<!---<div class="row">
								<div class="col-xl-10">
									<h5 class="d-inline mr-4">S&eacute;lection vid&eacute;o</h5>
								</div>
							</div>

							<br>
							
							<div class="row">
					
								<div class="col-md-3">
								

									<div style="max-width:854px"><div style="position:relative;height:0;padding-bottom:56.25%"><iframe src="https://embed.ted.com/talks/tara_winkler_why_we_need_to_end_the_era_of_orphanages" width="854" height="480" style="position:absolute;left:0;top:0;width:100%;height:100%" frameborder="0" scrolling="no" allowfullscreen></iframe></div></div>

									<em>Credits : TED TALKS / visit <a href="https://www.ted.com/talks/tara_winkler_why_we_need_to_end_the_era_of_orphanages/reading-list">website</a></em>

								</div>
								
								<div class="col-md-3">
								

									<div style="max-width:854px"><div style="position:relative;height:0;padding-bottom:56.25%"><iframe src="https://embed.ted.com/talks/cynthia_breazeal_the_rise_of_personal_robots" width="854" height="480" style="position:absolute;left:0;top:0;width:100%;height:100%" frameborder="0" scrolling="no" allowfullscreen></iframe></div></div>

								</div>
								
								<div class="col-md-3">
								

									<div style="max-width:854px"><div style="position:relative;height:0;padding-bottom:56.25%"><iframe src="https://embed.ted.com/talks/heather_knight_silicon_based_comedy" width="854" height="480" style="position:absolute;left:0;top:0;width:100%;height:100%" frameborder="0" scrolling="no" allowfullscreen></iframe></div></div>

								</div>
								
								<div class="col-md-3">

									<div style="max-width:854px"><div style="position:relative;height:0;padding-bottom:56.25%"><iframe src="https://embed.ted.com/talks/renee_lertzman_how_to_turn_climate_anxiety_into_action" width="854" height="480" style="position:absolute;left:0;top:0;width:100%;height:100%" frameborder="0" scrolling="no" allowfullscreen></iframe></div></div>

								</div>
								
							</div>--->
							
							
							<cfelseif subm eq "ulinks">
							
							<!---<div class="row">
								<div class="col-xl-10">
									<h5 class="d-inline mr-4">Useful links</h5>
								</div>
							</div>

							<br>


								<div class="col-md-4">
									<div class="card border">
										<div class="card-body">
											
											<h6>MOOC</h6> <small></small>
											
											<ul style="list-style: square">
											<li><a href="https://www.edx.org/course/subject/language" target="_blank">EDX.org</a></li>
											<li><a href="https://www.fun-mooc.fr/" target="_blank">Fun MOOC</a></li>
											<li><a href="https://www.my-mooc.com/" target="_blank">My MOOC</a></li>
											<li><a href="https://mooec.com/" target="_blank">MOOEC</a></li>
											<li><a href="https://www.mooc-list.com/" target="_blank">MOOC LIST</a></li>
											<li><a href="https://www.coursera.org/" target="_blank">COURSERA</a></li>
											</ul>
											
										</div>
									</div>
								</div>

							</div>--->
							
							</cfif>
						
					</div>		
				</div>		
				
			</div>			
		</div>
			
	</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfif isdefined("SESSION.ACCESS_EL")>
<script>
$(document).ready(function() {
		
	<cfif subm eq "email">
    $('#tree_wemail1 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail1 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });
	
	$('#tree_wemail2 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail2 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });

	
	$('#tree_wemail3 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail3 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });

	$('#tree_wemail4 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail4 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });


	$('.btn_view_wemail').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idt = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Wemail");
		$('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+idt, function() {});
	});
	
	$.typeahead({
		input: '.js_typeahead_wemail',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',
		/*matcher: function(item) {
			return true
		}*/
		
		dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
		
		group: {
			template: "{{group}}"
		},
		
		source: {
			
			<cfoutput query="get_wemail" group="wemail_category">
			#replacenocase(wemail_category_clean,' ','','ALL')# : {
			
				display:"wemail_subject",
				href:"",
				data:[
					<cfoutput group="wemail_subject">
					{
					"wemail_id": #wemail_id#,
					"wemail_subject": "#wemail_subject#"
					},
					</cfoutput>
				]
			
			},
			</cfoutput>
		},
		callback: {
		
			onClickAfter: function (node, a, item, event) {
	 
				event.preventDefault;
				
				$('#window_item_lg').modal({keyboard: true});
				$('#modal_title_lg').text("Email Template");
				$('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+item.wemail_id, function() {});
			
	 
			}			
		}
	});
	
	</cfif>
	
	<cfif subm eq "vocabulary_perso">
	$( ".btn_rm_uvoc" ).click(function() {
			
		var id_temp = $(this).attr("id");
		if (id_temp != 0) {
			<!-- $('#'+id_temp).append("<div class='spinner-border' role='status'></div>");			 -->
				
			var idtemp = id_temp.split("_");
			var uid = idtemp[0];
			var vid = idtemp[1];

			$.ajax({
				url : './components/vocabulary_perso.cfc?method=rm_user_voc',
				type : 'POST',
				data : {act:"rm_user_voc", uid:uid, vid:vid},
					
				success : function(resultat, status) {
				
					$("#"+id_temp).remove();
				}
			});
				
			$(this).attr('id', '0');
			
			
		}
	});
	
	
	$(".order_choice").click(function() {
		var c = $(this).attr("class");


		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split('_');
			var lg = idtemp[0];
			var order = idtemp[1];
		
			
			var other = -1;
			if (order != -1) {var other = 0}
			console.log(order);

			
			if (order == -1) {
				<cfoutput>
					document.location.href="common_tools.cfm?subm=#subm#&voc_cat_select=-1&lang_select=#lang_select#";
				</cfoutput>
			}
			if (order == 0) {
			
				<cfoutput>
					document.location.href="common_tools.cfm?subm=#subm#&voc_cat_select=0&lang_select=#lang_select#";
				</cfoutput>
			}

		
		
	});
	</cfif>
	
	
	
	<cfif subm eq "vocabulary" or subm eq "vocabulary_perso">
	
	$('.lang_translate').click(function(event) {	

		var lang_translate = [];
		if($('#lang_en').is(":checked")){lang_translate.push("en")}
		if($('#lang_fr').is(":checked")){lang_translate.push("fr")}
		if($('#lang_de').is(":checked")){lang_translate.push("de")}

		<cfoutput>
		document.location.href="common_tools.cfm?subm=#subm#&voc_cat_select=#voc_cat_select#&lang_select=#lang_select#&lang_translate="+lang_translate;
		</cfoutput>
		
	});
	
	
	$('.lang_select').change(function(event) {	

		var lang_select = $('.lang_select').val();
		
		<cfoutput>
		document.location.href="common_tools.cfm?subm=#subm#&voc_cat_select=#voc_cat_select#&lang_select="+lang_select+"&lang_translate=#lang_translate#";
		</cfoutput>
		
	});
	
	$('.voc_cat_select').change(function(event) {	

		var voc_cat_select = $('.voc_cat_select').val();
		
		<cfoutput>
		document.location.href="common_tools.cfm?subm=#subm#&voc_cat_select="+voc_cat_select+"&lang_select=#lang_select#&lang_translate=#lang_translate#";
		</cfoutput>
		
	});
	</cfif>
	
	<cfif subm eq "vocabulary">
	
	$( ".btn_add_uvoc" ).click(function() {

		var id_temp = $(this).attr("id");
		
			<!-- $('#'+id_temp).append("<div class='spinner-border' role='status'></div>"); -->
			
			var idtemp = id_temp.split("_");
			var uid = idtemp[0];
			var vid = idtemp[1];
			
			var c = $(this).attr("class");
			
			if ( c == "fal fa-heart-square fa-2x btn_add_uvoc cursored") {
			$.ajax({
				url : './components/vocabulary_perso.cfc?method=add_user_voc',
				type : 'POST',
				data : {act:"add_user_voc", uid:uid, vid:vid},
				success : function(resultat, status) {
				}
			});
			$(this).attr('class', 'fas fa-heart-square fa-2x btn_add_uvoc cursored');
			}
			
			if ( c != "fal fa-heart-square fa-2x btn_add_uvoc cursored") {
			$.ajax({
				url : './components/vocabulary_perso.cfc?method=rm_user_voc',
				type : 'POST',
				data : {act:"rm_user_voc", uid:uid, vid:vid},
				success : function(resultat, status) {
				}
			});
			$(this).attr('class', 'fal fa-heart-square fa-2x btn_add_uvoc cursored');
			}
		
	});
	



	$.typeahead({
		input: '.js_typeahead_voc',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',
		/*matcher: function(item) {
			return true
		}*/
		
		dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
		
		group: {
			template: "{{group}}"
		},
		
		source: {
			
			<cfoutput query="get_vocabulary_all" group="voc_cat_id">
			<cfif voc_cat_id neq "35">
			"#encodeForJavaScript(voc_cat_name)#" : {
			
				display:"voc_word",
				href:"",
				data:[
					<cfoutput>
					{
					"voc_id": #voc_id#,
					"voc_word": "#encodeForJavaScript(trim(voc_word))#",
					"voc_category": "#encodeForJavaScript(trim(voc_cat_name))#",
					"voc_cat_id": "#voc_cat_id#"					
					},
					</cfoutput>
				]
			
			},
			</cfif>
			</cfoutput>
		},
		callback: {
		
			onClickAfter: function (node, a, item, event) {
	 
				event.preventDefault;
				<cfoutput>				
				document.location.href='common_tools.cfm?subm=#subm#&lang_select=#lang_select#&lang_translate=#lang_translate#&voc_cat_select='+item.voc_cat_id+'&v_id='+item.voc_id+'##'+item.voc_id;
				</cfoutput>			
			}			
		}
	});
	
	</cfif>
	
});
</script>
</cfif>

</body>
</html>