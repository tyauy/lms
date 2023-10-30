<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset list_formation = "1,2,3,4,5,9,6,8,12,13">

<cfparam name="a_id" default="#listgetat(SESSION.USER_ACCOUNT_RIGHT_ID,1)#">
<cfparam name="training_pack" default="pack">
<cfparam name="learner_choice" default="new">


<cfparam name="step" default="1">

<cfparam name="pack_id" default="1">
<cfparam name="tppack_id" default="1">


<cfparam name="f_id" default="2">
<cfparam name="f_h" default="10">
<cfparam name="f_ph" default="55">
<cfparam name="f_learner" default="1">
<cfparam name="f_firstname_1" default="">
<cfparam name="f_lastname_1" default="">
<cfparam name="f_certif" default="0">


<cfset get_account = obj_query.oget_account(a_id="#a_id#",a_list="#SESSION.USER_ACCOUNT_RIGHT_ID#")>
<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

<cfset a_company = get_account.account_name>
<cfset a_address = get_account.account_address>
<cfset a_address2 = get_account.account_address2>
<cfset a_zipcode = get_account.account_postal>
<cfset a_city = get_account.account_city>
<cfset a_country = get_account.account_country>
<cfset a_ctc = "#SESSION.USER_NAME#">

<cfquery name="get_order_context" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_context
</cfquery>

<cfquery name="get_subrogation" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT account_name, account_id FROM account a WHERE type_id = 4 ORDER BY account_name
</cfquery>

<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
SELECT fp.*, f.formation_name_#SESSION.LANG_CODE# as formation_name 
FROM lms_formation_pack fp
INNER JOIN lms_formation f ON f.formation_id = fp.formation_id
WHERE pack_new = 1 AND pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
</cfquery>

<cfif get_formation_pack.tpmaster_id neq "">
<cfquery name="get_tpmaster_ex" datasource="#SESSION.BDDSOURCE#">
SELECT tpmaster_id, tpmaster_name, tpmaster_hour, tpmaster_level 
FROM lms_tpmaster2 tp
WHERE tp.tpmaster_id IN (#get_formation_pack.tpmaster_id#)
ORDER BY tpmaster_level
</cfquery>
</cfif>

<cfquery name="get_price_unit" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_group_price WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#">
</cfquery>

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_fr as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN (#list_formation#)
</cfquery>	


<!---
<cfquery name="get_learner_account" datasource="#SESSION.BDDSOURCE#">
SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_id FROM user u WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> AND profile_id = 3
</cfquery>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_id, account_name, account_address, account_postal, account_city, account_country, account_f_name, account_f_address, account_f_postal, account_f_city, account_f_country FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> 
</cfquery>--->

<cfif SESSION.USER_ACCOUNT_RIGHT_ID neq "">
	<cfset get_learner_account = obj_query.oget_learner(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#",o_by="account_id")>
</cfif>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "1/3 - G&eacute;n&eacute;rer Devis de formation">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<form onSubmit="return check_form()" action="updater_estimate.cfm" method="post">
			<div class="row" style="margin-top:10px">
				<div class="col-lg-8 offset-lg-2 col-md-12">
				
					<div class="row">
				
						<div class="col-4" align="center">						
							<span class="btn btn-link">
							<cfif step eq "1">
							<h2 class="mb-1"><i class="fad fa-tasks text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">1 - DEVIS</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-tasks text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">1 - DEVIS</span></h4>
							</cfif>
							</span>								
						</div>
						<div class="col-4" align="center">
							<span class="btn btn-link">
							<cfif step eq "2">
							<h2 class="mb-1"><i class="fad fa-file-signature text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">2 - SIGNATURE</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-file-signature text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">2 - SIGNATURE</span></h4>
							</cfif>
							</span>			
						</div>
						<div class="col-4" align="center">
							<span class="btn btn-link">
							<cfif step eq "3">
							<h2 class="mb-1"><i class="fad fa-clipboard-check text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">3 - FINALISATION</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-clipboard-check text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">3 - FINALISATION</span></h4>
							</cfif>
							</span>								
						</div>
						
					</div>
			
					<div class="card border-top border-info">						
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">
									<div class="card-title">
										<h4 class="mt-1"><i class="fad fa-building text-info"></i> Client / Coordonnées</h4>
									</div>
									<cfoutput>
									<div class="bg-light p-2 m-1 mt-3 border border-info">
										
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Compte*</label>
											<div class="col-sm-9">
												<select class="form-control" name="a_id" onchange="document.location.href='tm_estimate_create.cfm?a_id='+$(this).val()<cfif isdefined("pack_id")>+'&pack_id=#pack_id#</cfif>'">
												<cfloop query="get_account_tm">
												<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
												</cfloop>					
												</select>	
											</div>
										</div>
										
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Soci&eacute;t&eacute;*</label>
											<div class="col-sm-9">
												<input class="form-control form-control-sm"  type="text" name="a_company" value="#a_company#" placeholder="Soci&eacute;t&eacute;" required="yes">
											</div>
										</div>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Adresse*</label>
											<div class="col-sm-9">
											<input class="form-control form-control-sm"  type="text" name="a_address" value="#a_address#" placeholder="Adresse" required="yes">
											</div>
										</div>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">CP / Ville / Pays*</label>
											<div class="col-sm-2">
											<input class="form-control form-control-sm"  type="text" name="a_zipcode" value="#a_zipcode#" placeholder="Code Postal" required="yes">
											</div>
											<div class="col-sm-4">
											<input class="form-control form-control-sm"  type="text" name="a_city" value="#a_city#" placeholder="Ville" required="yes">
											</div>
											<div class="col-sm-3">
											<input class="form-control form-control-sm"  type="text" name="a_country" value="#ucase(a_country)#" placeholder="Pays" required="yes">
											</div>
										</div>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Donneur d'ordre*</label>
											<div class="col-sm-9">
											<input class="form-control form-control-sm" type="text" name="a_ctc" value="#a_ctc#" placeholder="Pr&eacute;nom Nom" required="yes">
											</div>
										</div>
										
									</div>
									</cfoutput>									
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-md-12">
									<div class="card-title">
										<h4 class="mt-1"><i class="fad fa-road text-info"></i> Formation</h4>
									</div>
								</div>
							</div>
							<div class="row">	
									
								<div class="col-md-6">
									<div class="p-2 m-1 mt-2 h-100 <cfif training_pack eq "pack">bg-light border border-info<cfelse>border bg-white</cfif>" id="card_pack">
										<label><h6><input type="radio" name="training_pack" class="training_pack" value="pack" <cfif training_pack eq "pack">checked="checked"</cfif>> Formation catalogue</h6></label>
										
										
										
										<cfif SESSION.GROUP_PRICE_REDUCTION neq "0">
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Prix catalogue</label>
											<div class="col-sm-9">
												<span class="badge badge-info" style="font-size:14px"><cfoutput>- #SESSION.GROUP_PRICE_REDUCTION# %</cfoutput></span> sur prix public
											</div>
										</div>
											</cfif>		
											<!--- <cfif get_price_unit.recordcount neq "0"> --->
												<!--- <cfoutput> --->
													<!--- <cfloop list="#list_formation#" index="cor"> --->
													<!--- <cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#"> --->
													<!--- SELECT formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> --->
													<!--- </cfquery> --->
														<!--- <cfset col = evaluate("get_price_unit.price_#cor#")> --->
														<!--- <tr> --->
															<!--- <th class="bg-light"><span class="lang-sm" lang="#get_formation_solo.formation_code#"></span> #get_formation_solo.formation_name#</th> --->
															<!--- <td class="bg-white">#numberformat(col,'____')# &euro;</td> --->
														<!--- </tr>	 --->
													<!--- </cfloop> --->
												<!--- </cfoutput> --->
											<!--- <cfelse> --->
												<!--- <tr> --->
												<!--- <td colspan="3"> --->
												<!--- <small><em>Donn&eacute;es non applicables pour le moment</em></small> --->
												<!--- </td> --->
												<!--- </tr> --->
											<!--- </cfif> --->
										
										
										
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Pack*</label>
											<div class="col-sm-9">
												<select name="pack_id" id="pack_id" class="form-control form-control" <cfif training_pack eq "card">disabled</cfif>>
													<cfoutput query="get_formation_pack" group="formation_id">
													<optgroup label="#formation_name#">
													<cfoutput>
													<option value="#pack_id#" <cfif pack_id eq get_formation_pack.pack_id>selected</cfif>>#pack_name# - <cfif SESSION.GROUP_PRICE_REDUCTION neq "0">#numberformat(((100-SESSION.GROUP_PRICE_REDUCTION)/100)*pack_amount_ht,'____')#<cfelse>#pack_amount_ht#</cfif> &euro; HT</option>
													</cfoutput>
													</cfoutput>
												</select>
											</div>
										</div>
										
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Parcours*</label>
											<div class="col-sm-9">
												<select name="tppack_id" id="tppack_id" class="form-control" <cfif training_pack eq "card">disabled</cfif>>
													<cfif get_formation_pack.tpmaster_id neq "">
													<option value="0">---CHOISIR PARCOURS----</option>
													<cfoutput query="get_tpmaster_ex" group="tpmaster_level">
													<optgroup label="#tpmaster_level#">
													<cfoutput>
													<option value="#tpmaster_id#" <cfif tppack_id eq get_tpmaster_ex.tpmaster_id>selected</cfif>>#tpmaster_hour# H - #tpmaster_name#</option>
													</cfoutput>
													</cfoutput>
													<cfelse>
													<option value="0">---N/A----</option>
													</cfif>
												</select>
											</div>
										</div>
										

										<div class="row mt-5" id="show_amount_pack">
											<div class="col-md-12" align="center">
												<h6>Tarif pour 1 apprenant : <span id="amount_learner_pack">345</span> &euro; HT</h6>
											</div>
										</div>
									</div>
									
									
									
								</div>
								<div class="col-md-6">
									
									<div class="p-2 m-1 mt-2 h-100 <cfif training_pack eq "card">bg-light border border-info<cfelse>border bg-white</cfif>" id="card_card">
										<label><h6><input type="radio" name="training_pack" class="training_pack" value="card" <cfif training_pack eq "card">checked="checked"</cfif>> Formation &agrave; la carte</h6></label>
										
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Langue*</label>
											<div class="col-sm-9">
											<select class="form-control" name="f_id" id="f_id" <cfif training_pack eq "pack">disabled</cfif>>
												<cfoutput query="get_formation">
												<option value="#formation_id#" <cfif formation_id eq f_id>selected</cfif>>#formation_name#</option>
												</cfoutput>
											</select>									
											</div>
										</div>
										
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Prix horaire*</label>
											<div class="col-sm-3">
												<!---<input type="text"  name="f_price" id="f_price" value="15" class="form-control d-inline" style="width:80px" <cfif training_pack eq "pack">disabled</cfif>> <span class="d-inline">&euro;</span>--->
												<span class="badge badge-info" id="amount_training" style="font-size:15px">-</span> &euro;
											</div>
										</div>
										<cfoutput>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Heures*</label>
											<div class="col-sm-2">
												<input type="number" min="5" max="120" name="f_h" id="f_h" value="#f_h#" class="form-control" required="yes" validate="integer" style="width:80px" <cfif training_pack eq "pack">disabled</cfif>>
											</div>
										</div>
										</cfoutput>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Certification*</label>
											<div class="col-sm-9">
												<label><input type="radio" name="f_certif" class="f_certif" value="0" <cfif training_pack eq "pack">disabled</cfif> <cfif f_certif eq "0">checked</cfif>> Aucune certification</label>
												<br>
												<label><input type="radio" name="f_certif" class="f_certif" value="1" <cfif training_pack eq "pack">disabled</cfif> <cfif f_certif eq "1">checked</cfif>> Certification LINGUASKILL ou BRIGHT</label>
											</div>
										</div>
										<div class="row mt-2" id="show_amount_card">
											<div class="col-md-12" align="center">
												<h6>Tarif pour 1 apprenant : <span id="amount_learner_card">345</span> &euro; HT</h6>
											</div>
										</div>
									</div>
									
									
									
									
								</div>
							</div>
							
							<cfoutput>
							<div class="row mt-4">
								<div class="col-md-12">
									<div class="bg-light p-2 m-1 mt-2 border border-info">
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Début souhaité de formation </label>
											<div class="col-sm-9">
												<div class="controls controls-sm">
													<div class="input-group">
														<cfif isdefined("f_date_start")>														
															<cfset dateform = dateformat(f_date_start,'dd/mm/yyyy')>
														<cfelse>
															<cfset dateform = dateformat(dateadd('d',7,now()),'dd/mm/yyyy')>
														</cfif>
														<input id="f_date_start" name="f_date_start" type="text" class="datepicker form-control" value="#dateform#" />
														<label for="f_date_start" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
													</div>
												</div>
											</div>
										</div>
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Fin de formation <span style="cursor:pointer" class="badge badge-info" role="button" data-toggle="tooltip" data-placement="top" title="La formation doit être obligatoirement réalisée pendant la période spécifiée.">?</span></label>
											<div class="col-sm-9">
												<div class="controls controls-sm">
													<div class="input-group">
														<cfif isdefined("f_date_end")>
															<cfset dateto = dateformat(f_date_end,'dd/mm/yyyy')>
														<cfelse>
															<cfset dateto = dateformat(dateadd('yyyy',1,dateform),'dd/mm/yyyy')>
														</cfif>														
														<input id="f_date_end" name="f_date_end" type="text" class="datepicker form-control" value="#dateto#" />
														<label for="f_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							</cfoutput>
								
								
								
							<div class="row mt-4">
								<div class="col-md-12">
									<div class="card-title">
										<h4 class="mt-1"><i class="fad fa-user-friends text-info"></i> Apprenant(s)</h4>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-12">
								
									<!---<div class="col-md-12">
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Fin de formation</label>
											<div class="col-sm-9">
											<div class="controls controls-sm">
												<div class="input-group">
													<input id="f_date_end" name="f_date_end" type="text" class="datepicker form-control" value="#dateformat(dateadd("m",2,now()),'dd/mm/yyyy')#" />
													<label for="f_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
												</div>
											</div>
											</div>
										</div>
										
									</div>--->
									
										
									<div class="p-2 m-1 mt-2 <cfif learner_choice eq "new">bg-light border border-info<cfelse>border bg-white</cfif>" id="learner_new">
										<label><h6><input type="radio" name="learner_choice" class="learner_choice" value="new" <cfif learner_choice eq "new">checked="checked"</cfif>> Nouveau(x) compte(s) apprenant(s)</h6></label>
										
										<cfoutput>
										<div class="form-group row">
											<label class="col-sm-3 col-form-label">Nombre d'apprenants*</label>
											<div class="col-sm-2">
												<input type="number" min="1" max="25" name="f_learner" id="f_learner" value="#f_learner#" class="form-control" required="yes" validate="integer">
											</div>
										</div>
										
										<div id="container_learners">
										<cfloop from="1" to="#f_learner#" index="cor">
										<div id="container_learner_#cor#">
										<div class="form-group row mt-1">
											<label class="col-sm-3 col-form-label">Apprenant #cor#</label>
											<div class="col-sm-4">
											<input class="form-control" type="text" name="f_lastname_#cor#" value="#evaluate('f_lastname_#cor#')#" placeholder="Nom #cor#" required="yes">
											</div>
											<div class="col-sm-4">
											<input class="form-control" type="text" name="f_firstname_#cor#" value="#evaluate('f_firstname_#cor#')#" placeholder="Pr&eacute;nom #cor#" required="yes">
											</div>
										</div>
										</div>
										</cfloop>
										</div>
										</cfoutput>
										
									</div>
									
									<cfif SESSION.USER_ACCOUNT_RIGHT_ID neq "">
									<div class="p-2 m-1 mt-2 <cfif learner_choice eq "exists">bg-light border border-info<cfelse>border bg-white</cfif>" id="learner_exists">
										<label><h6><input type="radio" disabled name="learner_choice" class="learner_choice" value="exists" <cfif learner_choice eq "exists">checked="checked"</cfif>> Compte Apprenant existant (bient&ocirc;t disponible)</h6></label>
										<table class="table bck_grey">
											<tr>
												<td>
												<select id="learner_select" class="form-control" name="learner_id" value="user_id">
												<cfoutput query="get_learner_account" group="account_id">
													<optgroup label="#account_name#">
													<cfoutput>
														<option value="#user_id#">#ucase(user_name)# #user_firstname#</option>
													</cfoutput>
													</optgroup>
												</cfoutput>
												</select>
												</td>
											</tr>								
										</table>
									</div>
									</cfif>
							
									<div class="row">
										<div class="col-md-12" align="center">
											<h4>Total pour <span id="total_learner">1</span> apprenant(s) : <span id="amount_learners">345</span> &euro; HT</h4>
										</div>
									</div>
							
								<div align="center">
								
								<input type="hidden" id="amount_training_pu" name="amount_training_pu" value="">
								<input type="submit" value="G&eacute;n&eacute;rer devis" class="btn btn-info">
								
								</div>

							
										
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
		
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(function() {
	var nb_learner = <cfoutput>#f_learner#</cfoutput>;
	
	var obj_price = [<cfoutput query="get_formation_pack">{"pack_id":"#pack_id#","pack_amount_ht":"<cfif SESSION.GROUP_PRICE_REDUCTION neq "0">#numberformat(((100-SESSION.GROUP_PRICE_REDUCTION)/100)*pack_amount_ht,'____')#<cfelse>#numberformat(pack_amount_ht,'____')#</cfif>"},</cfoutput>{"pack_id":"0","pack_amount_ht":"0"}];
	
	<cfif get_price_unit.recordcount neq "0">	
	var obj_price_h = [<cfoutput><cfloop list="#list_formation#" index="cor"><cfset col = evaluate("get_price_unit.price_#cor#")>{"f_id":"#cor#","pack_amount_ht":"#numberformat(col,'____')#"},</cfloop></cfoutput>];
	<cfelse>
	var obj_price_h = [
	{"f_id":"1","pack_amount_ht":"60"},
	{"f_id":"2","pack_amount_ht":"55"},
	{"f_id":"3","pack_amount_ht":"60"},
	{"f_id":"4","pack_amount_ht":"60"},
	{"f_id":"5","pack_amount_ht":"60"},
	{"f_id":"6","pack_amount_ht":"60"},
	{"f_id":"8","pack_amount_ht":"60"},
	{"f_id":"9","pack_amount_ht":"60"},
	{"f_id":"12","pack_amount_ht":"60"},
	{"f_id":"13","pack_amount_ht":"60"}
	];
	</cfif>
	
	function calculate()
	{
	
		if ($('input[name="training_pack"]:checked').val() == "pack") {
		
			var pack_id = $("#pack_id").val();
			$.each(obj_price, function(i, obj) {
				if(obj.pack_id == pack_id){
					var training_price = obj_price[i].pack_amount_ht;
					var training_total = training_price*nb_learner;
					
					$("#show_amount_card").hide();
					$("#show_amount_pack").show();
					
					$("#amount_learner_pack").text(training_price);					
					$("#total_learner").text(nb_learner);
					$("#amount_learners").text(training_total);
				}
			});
		}
		else
		{
			var f_id = $("#f_id").val();
			$.each(obj_price_h, function(i, obj) {
				if(obj.f_id == f_id){
					price_unit = obj_price_h[i].pack_amount_ht;
				}
			});
			
			var training_price = $("#f_h").val()*price_unit;
			
			var choice_certif = $('input[class="f_certif"]:checked').val();
			if(choice_certif != "0")
			{
			training_price = training_price+70;
			}
			
			var training_total = training_price*nb_learner;
			
			$("#show_amount_card").show();
			$("#show_amount_pack").hide();
			
			
			$("#amount_training_pu").val(price_unit);
			$("#amount_training").text(price_unit);
			$("#amount_learner_card").text(training_price);
			$("#total_learner").text(nb_learner);
			$("#amount_learners").text(training_total);
			
		}
	
	}
	
	$("#fp_id").change(function() {
		calculate();
	})
	$("#f_id").change(function() {
		calculate();
	})
	$("#f_h").change(function() {
		calculate();
	})
	$(".f_certif").change(function() {
		calculate();
	})
	
	
	$(".training_pack").change(function() {
		if($(this).val() == "card")
		{
			$("#f_id").prop("disabled",false);
			$("#f_h").prop("disabled",false);
			$(".f_certif").prop("disabled",false);			
			$("#pack_id").prop("disabled",true);
			$("#tppack_id").prop("disabled",true);
			
			
			$("#card_pack").removeClass("bg-light");
			$("#card_pack").addClass("bg-white");
			$("#card_pack").removeClass("border-info");
			
			$("#card_card").addClass("bg-light");
			$("#card_card").addClass("border-info");
			$("#card_card").removeClass("bg-white");
			
			calculate();
		}
		else
		{
			
			$("#f_id").prop("disabled",true);
			$("#f_h").prop("disabled",true);
			$(".f_certif").prop("disabled",true);			
			$("#pack_id").prop("disabled",false);
			$("#tppack_id").prop("disabled",false);
			
			$("#card_pack").removeClass("bg-white");
			$("#card_pack").addClass("bg-light");
			$("#card_pack").addClass("border-info");
			
			$("#card_card").removeClass("bg-light");
			$("#card_card").removeClass("border-info");
			$("#card_card").addClass("bg-white");
			
			calculate();
		}
		
	
	})
	
	$(".learner_choice").change(function() {
		if($(this).val() == "new")
		{
			<!--- $("#f_id").prop("disabled",false); --->
			<!--- $("#f_h").prop("disabled",false); --->
			<!--- $(".f_certif").prop("disabled",false);			 --->
			<!--- $("#pack_id").prop("disabled",true); --->
			<!--- $("#tppack_id").prop("disabled",true); --->
			
			$("#learner_select").prop("disabled",false);
			
			$("#learner_exists").removeClass("bg-light");
			$("#learner_exists").addClass("bg-white");
			$("#learner_exists").removeClass("border-info");
			
			$("#learner_new").addClass("bg-light");
			$("#learner_new").addClass("border-info");
			$("#learner_new").removeClass("bg-white");
			
			calculate();
		}
		else
		{
			
			<!---  --->
			<!--- $("#f_h").prop("disabled",true); --->
			<!--- $(".f_certif").prop("disabled",true);			 --->
			<!--- $("#pack_id").prop("disabled",false); --->
			<!--- $("#tppack_id").prop("disabled",false); --->
			
			$("#learner_select").prop("disabled",false);
			
			$("#learner_exists").removeClass("bg-white");
			$("#learner_exists").addClass("bg-light");
			$("#learner_exists").addClass("border-info");
			
			$("#learner_new").removeClass("bg-light");
			$("#learner_new").removeClass("border-info");
			$("#learner_new").addClass("bg-white");
			
			calculate();
		}
		
	
	})
	
	$("#f_learner").change(function() {

		nb_learner = parseInt($(this).val());
		if(nb_learner >= 25)
		{
		nb_learner = "25";
		$(this).val("25");
		}
		var max_value = nb_learner+1;
		//alert(max_value);
		
		for (var i=1; i<=nb_learner; i++) {
		
			if (!$("#container_learner_"+i).length) {
				var to_create = "<div id='container_learner_"+i+"'>";
				to_create = to_create+"<div class='form-group row'>";
				to_create = to_create+"<label class='col-sm-3 col-form-label'>Apprenant "+i+"</label>";
				to_create = to_create+"<div class='col-sm-4'>";
				to_create = to_create+"<input class='form-control' type='text' name='f_lastname_"+i+"' value='' placeholder='Nom "+i+"' required='yes'>";	
				to_create = to_create+"</div>";
				to_create = to_create+"<div class='col-sm-4'>";
				to_create = to_create+"<input class='form-control' type='text' name='f_firstname_"+i+"' value='' placeholder='Pr&eacute;nom "+i+"' required='yes'>";
				to_create = to_create+"</div>";
				to_create = to_create+"</div>";
				to_create = to_create+"</div>";
				$("#container_learners").append(to_create);
				}
			}
			
		for (var j=max_value; j<=25; j++) {
			$("#container_learner_"+j).remove();
		
		}
		calculate();

	});
	
	
	
	$("#f_date_start").datepicker({
		weekStart: 1,
		minDate:0,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#f_date_end").datepicker( "option", "minDate", selectedDate );	
			d = $(this).datepicker("getDate");
			$("#f_date_end").datepicker("setDate", new Date(d.getFullYear()+1,d.getMonth(),d.getDate()));	
			f_date_start = $('#f_date_start').datepicker("getDate");
			f_date_start = moment(f_date_start).format('YYYY-MM-DD');
		}		
	})

	
	$("#f_date_end").datepicker({
		defaultDate: "+1w",
		changeMonth: true,
		dateFormat:"dd/mm/yy",
		numberOfMonths: 1
	});
	
	calculate();
	
	
	$("#tppack_id").change(function() {
		if($(this).val() != 0)
		{
		$("#tppack_id").removeClass("border border-danger")
		}
	});
	
	
})

function check_form()
{

	<cfif get_formation_pack.tpmaster_id neq "">
	var choice_package = $('input[class="training_pack"]:checked').val();

	if(choice_package == "card") {
		return true;
	}
	else
	{
		if($("#tppack_id").val() == "0")
		{
			alert("Veuillez choisir un parcours de formation SVP.");
			$("#tppack_id").addClass("border border-danger");
			return false;
		}
		return true;
	}
	<cfelse>
	return true;
	</cfif>
}
</script>



</body>
</html>