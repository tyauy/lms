<!--- <cfset list_go = "140,12291,13307,7453,141,26383,12656,2549,6336,82,26856,11614,8036,3484,87,527,15467,27152,15092,161,12119,151,26408,89,91,173,8354,513,10048,177,11700,94,432,4829,15351,5781,26837,15093,504,26444,12098,98,15090,11699,26403,6039,27173,26410,10076,11697,100,14478,15100,26768,14497,15217,13906,15097,13641,138,8039,14690,12484,8353,105,12840,12842,23881,4825,11406,11198,2913,162,2632,3708,12128,8351,23882,8037,26382,11739,157,15332,15091,26777,139,27132,12096,12127,15101,15095,11073,26379,14496,26838,8038,27129,13145,2586,26384,15099,142,305,121,11950,183,186,13312,7428,15537,8035,5349">

<cfloop list="#list_go#" index="user_id">

	<cfset get_teaching_solo = obj_query.oget_teaching(p_id="#user_id#")>

	<cfquery name="get_payment_info" datasource="#SESSION.BDDSOURCE#">
		SELECT visio_rate
		FROM user_payment 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
	</cfquery>

	<cfloop query="get_teaching_solo">

		<cfloop list="1,6" index="cat_id">

			<cfloop list="1,10,11,12" index="method_id">

				<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO user_pricing
				(
				user_id,
				formation_id,
				pricing_amount,
				pricing_cat,
				pricing_method,
				pricing_currency
				)
				VALUES
				(
					'#user_id#',
					#get_teaching_solo.formation_id#,
					<cfif method_id eq "10" OR method_id eq "11">'#get_payment_info.visio_rate+5#',<cfelse>'#get_payment_info.visio_rate#',</cfif>
					'#cat_id#',
					'#method_id#',
					'EUR'

				)
				</cfquery>

			</cfloop>


		</cfloop>

	</cfloop>


	<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO user_pricing
	(
	user_id,
	formation_id,
	pricing_amount,
	pricing_cat,
	pricing_method,
	pricing_currency
	)
	VALUES
	(
	'#user_id#',
	2,
	'50',
	7,
	1,
	'EUR'
	)
	</cfquery>

	
</cfloop>


<cfabort> --->

<!DOCTYPE html>
<cfif listFindNoCase("FINANCE,TRAINERMNG,CS", SESSION.USER_PROFILE)>

<cfsilent>
	

	<cfset get_teaching_solo = obj_query.oget_teaching(p_id="#p_id#")>


	<cfquery name="get_payment_info" datasource="#SESSION.BDDSOURCE#">
		SELECT payment_id, payment_type, payment_iban, payment_name, payment_address, 
		payment_postal, payment_city, payment_country, payment_siret, payment_vat
		FROM user_payment 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>

	<!--- <cfquery name="get_pricing_info" datasource="#SESSION.BDDSOURCE#">
		SELECT pricing_id, user_id, formation_id, pricing_amount, pricing_currency
		FROM user_pricing
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery> --->

	<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
		SELECT cat_id, cat_name_#SESSION.LANG_CODE# as cat_name
		FROM lms_tpsession_category 
		ORDER BY `cat_id` ASC
	</cfquery>

	<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
		SELECT method_id, method_name_#SESSION.LANG_CODE# as method_name
		FROM lms_lesson_method 
		WHERE method_id in (1,2,10,11,12)
		ORDER BY `method_id` ASC
	</cfquery>

	<cfquery name="get_paid" datasource="#SESSION.BDDSOURCE#">
		SELECT user_paid_global, user_paid_missed, user_paid_tva
		FROM user 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>

	<cfquery name="get_tva" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
		SELECT `tva_id`, `tva_rate` FROM settings_tva
	</cfquery>


</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
	<style>
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	.nav-link {
		color: #999 !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}
	</style>

</head>
	


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfoutput><cfset title_page = #obj_translater.get_translate("title_page_common_trainer_avail")#></cfoutput>
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif isdefined("k")>
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em><cfoutput>#obj_translater.get_translate("alert_modif_ok")#</cfoutput></em></div>
			</div>
			</cfif>
		
			<cfinclude template="./incl/incl_nav_trainer.cfm">

			
			<div class="row">
	
				<div class="col-md-7">
				
					<div class="card border">
						<div class="card-body">
							<cfloop query="get_teaching_solo">

							<form class="form_pricing" name="form_pricing">
									<cfoutput>
										<span class="lang-sm" lang="#lcase(get_teaching_solo.formation_code)#"></span>
									</cfoutput>

								<table class="table table_pricing border bg-white">
									<tr style="background-color:#ECECEC">
										<td colspan="2">
											<!--- <cfoutput>#obj_translater.get_translate('table_th_teached_language')#</cfoutput> --->
											Method
										</td>
										<cfloop query="get_category">
											<td>
												<cfoutput>#cat_name#</cfoutput>
											</td>
										</cfloop>
									</tr>
									<cfoutput query="get_method">		
									<tr class="tr_teaching_#method_id#">
										<td width="5%">
										</td>
										<td width="20%">
											#get_method.method_name#
										</td>


										<cfloop query="get_category">
											<cfquery name="get_pricing" datasource="#SESSION.BDDSOURCE#">
												SELECT pricing_id, pricing_amount, pricing_currency
												FROM user_pricing up 
												WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
												AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_teaching_solo.formation_id#">
												AND pricing_cat = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_category.cat_id#">
												AND pricing_method = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_method.method_id#">
											</cfquery>


											<td>
												<input type="number" step="0.1" name="<cfif get_pricing.recordCount GT 0>update<cfelse>insert</cfif>_#get_teaching_solo.formation_id#_#get_method.method_id#_#get_category.cat_id#" 
												class="form-control form-control-sm" value="<cfif get_pricing.recordCount GT 0>#get_pricing.pricing_amount#</cfif>">
											</td>
										</cfloop>

									</tr>
									</cfoutput>	
									<tr class="table-info last_tr_teaching">
								
										<td colspan="<cfoutput>#get_category.recordCount + 1#</cfoutput>">

										</td>
										<td>
											<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
											<input type="hidden" name="lang" value="<cfoutput>#get_teaching_solo.formation_id#</cfoutput>">
											<input type="submit" class="btn btn-sm btn-info btn_add_pricing" value="<cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>">				
										</td>
									</tr>
								</table>
							</form>
						</cfloop>

						</div>
					</div>
				
				</div>
				
				<div class="col-md-5">
				
					<div class="card border">
						<div class="card-body">
							<h6 class="card-title"></h6>
							<form id="form_payement" name="form_payement">

							<div class="bg-light p-2 m-1 border">
								<h6 align="center" class="text-info">Info</h6>
								<br>
							
								<table class="table table-sm table-bordered bg-white">
									<tr>
										<td width="30%"><label>Name</label></td>
										<td>
											<input type="text" name="payment_name" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_name#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>Address</label></td>
										<td>
											<input type="text" name="payment_address" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_address#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>City</label></td>
										<td>
											<input type="text" name="payment_city" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_city#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>Postal</label></td>
										<td>
											<input type="text" name="payment_postal" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_postal#</cfoutput>">
										</td>
									</tr>
									<tr>
										<!--- <td><label>Country</label></td>
										<td>
											<input type="text" name="payment_country" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_country#</cfoutput>">
										</td> --->
									</tr>
								</table>
				
								<table class="table table-sm table-bordered bg-white">
									<tr>
										<td width="30%"><label>IBAN</label></td>
										<td>
											<input type="text" name="payment_iban" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_iban#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>Tax number</label></td>
										<td>
											<input type="text" name="payment_siret" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_siret#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>Type</label></td>
										<td>
											<input type="text" name="payment_type" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_type#</cfoutput>">
										</td>
									</tr>
									<tr>
										<td><label>vat</label></td>
										<td>
											<input type="text" name="payment_vat" class="form-control form-control-sm" value="<cfoutput>#get_payment_info.payment_vat#</cfoutput>">
											<!--- <input type="number" name="invoice_tva" id="invoice_tva" class="form-control form-control-sm" value="<cfoutput></cfoutput>"> --->
										</td>
									</tr>
									<!--- <tr>
										<td><label>invoice_name</label></td>
										<td><input type="text" name="invoice_name" class="form-control form-control-sm" value="<cfoutput>#invoice_name#</cfoutput>"></td>
									</tr> --->
	
									
									
									
									<tr>
										<td colspan="2" align="right">
											<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
											<cfif isDefined("get_payment_info.payment_id")><input type="hidden" name="payment_id" value="<cfoutput>#get_payment_info.payment_id#</cfoutput>"></cfif>
											<input type="submit" class="btn btn-sm btn-info btn_add_payment_info" value="<cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>">				
										</td>
									</tr>
									
					
								</table>
				
							</div>
							</form>

						</div>
					</div>
					<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<div class="card border">
						<div class="card-body">
							<h6 class="card-title"></h6>
							<!--- <form id="form_bonus" name="form_bonus"> --->

							<div class="bg-light p-2 m-1 border">
								<h6 align="center" class="text-info">Paid</h6>
								<br>
				
								<table class="table table-sm table-bordered bg-white">
									<tr>
										<td><label>Global</label></td>
										<td>
											<input type="checkbox" class="m-1 form-check-input" id="teacher_global_payement" value="0">
										</td>
									</tr>
									<tr>
										<td><label>Missed</label></td>
										<td>
											<input type="checkbox" class="m-1 form-check-input" id="teacher_missed_payement" value="0">
										</td>
									</tr>
									<tr>
										<td><label>TVA</label></td>
										<td>
											<select name="invoice_tva" id="teacher_tva_payement" class="form-control form-control-sm invoice_tva">
												<cfloop query="get_tva">
													<cfoutput>
														<option value="#tva_id#" <cfif tva_id eq "#get_paid.user_paid_tva#">selected</cfif>>
															<cfif tva_rate neq "0">
																#tva_rate#
															<cfelse>
																N/A
															</cfif>
														</option>
													</cfoutput>
												</cfloop>
											</select>
										</td>
									</tr>
									
									<!--- <tr>
										<td colspan="2" align="right">
											<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
											<cfif isDefined("get_payment_info.payment_id")><input type="hidden" name="payment_id" value="<cfoutput>#get_payment_info.payment_id#</cfoutput>"></cfif>
											<input type="submit" class="btn btn-sm btn-info btn_add_payment_info" value="<cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>">				
										</td>
									</tr> --->
									
					
								</table>
				
							</div>
							<!--- </form> --->

						</div>
					</div>
					</cfif>
				
				</div>
			</div>
			
			
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>
$(document).ready(function() {
	$(".form_pricing").submit(function( event ) {
		// alert($(this).serialize());
		event.preventDefault();
		console.log(event.target);
		console.log($(event.target).serialize());
		$.ajax({				 
			url: './api/users/user_trainer_post.cfc?method=updt_pricing',
			type: 'POST',
			data: $(event.target).serialize(),
			success : function(result, status){
				console.log(result);
				// window.location.reload(true);
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});

	});

	$("#form_payement").submit(function( event ) {
		// alert($(this).serialize());
		event.preventDefault();
		// console.log(event.target);
		$.ajax({				 
		url: './api/users/user_trainer_post.cfc?method=updt_payement',
		type: 'POST',
			data: $(event.target).serialize(),
			success : function(result, status){
				console.log(result);
				if (result == "0") {
					alert("Attention ! une erreur est survenue, les changements n'ont pas pu être appliqués");
				} else {
					alert("Saved");
				}
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});

	});

	<cfif get_paid.user_paid_global eq "1">
		$('#teacher_global_payement').prop('checked', true);
	</cfif>
	<cfif get_paid.user_paid_missed eq "1">
		$('#teacher_missed_payement').prop('checked', true);
	</cfif>


	$( "#teacher_global_payement" ).change(function(event) {
        $.ajax({
			url : './api/users/user_trainer_post.cfc?method=switch_user_paid',
			type : 'POST',
			data : {
				u_id: <cfoutput>#p_id#</cfoutput>
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
    });

	$( "#teacher_missed_payement" ).change(function(event) {
		$.ajax({
			url : './api/users/user_trainer_post.cfc?method=switch_user_paid_missed',
			type : 'POST',
			data : {
				u_id: <cfoutput>#p_id#</cfoutput>
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
	});


	$( "#teacher_tva_payement" ).change(function(event) {

		console.log();
		
		$.ajax({
			url : './api/users/user_trainer_post.cfc?method=switch_user_paid_tva',
			type : 'POST',
			data : {
				u_id: <cfoutput>#p_id#</cfoutput>,
				tva_id: $(this).val()
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
	});

});

</script>
	
</body>
</html>
</cfif>