<!DOCTYPE html>

<cfsilent>
	<cfparam name="show" default="product">

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">		

	<cfquery name="get_product" datasource="#SESSION.BDDSOURCE#">
	SELECT p.*, pa.attribute_id, pa.attribute_name, pv.variation_id, pv.variation_name_#SESSION.LANG_CODE# as variation_name, pv.price_unit,
	pc.category_name_#SESSION.LANG_CODE# as category_name
	FROM product p 
	INNER JOIN product_category pc ON pc.category_id = p.category_id
	LEFT JOIN product_attribute pa ON pa.product_id = p.product_id
	LEFT JOIN product_variation pv ON pv.attribute_id = pa.attribute_id
	ORDER BY p.product_id
	</cfquery>
	
	<cfquery name="get_coupon" datasource="#SESSION.BDDSOURCE#">
	SELECT pc.*, u.user_name, u.user_firstname, u.user_id, u.user_email
	FROM product_coupon pc

	LEFT JOIN product_coupon_user cu ON cu.coupon_id = pc.coupon_id
	LEFT JOIN user u ON cu.coupon_user = u.user_id

	<cfif show eq "parrain">
		WHERE pc.user_id IS NOT NULL
		AND pc.user_id != ""
		AND pc.user_id != 0
	<cfelseif show eq "school">
		WHERE pc.group_id IS NOT NULL
		AND pc.group_id != ""
		AND pc.group_id != 0
	</cfif>
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
      
		<cfset title_page = "Product list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">
				
				<div class="col-md-2">
					<div class="card border-top border-info">
						<div class="card-body">
							<div align="center">
								Product : <input type="radio" class="btn btn-outline-info btn_show" name="show" value="product" <cfif show eq "product">checked</cfif>>
							</div>
						</div>
					</div>
				</div>
					
				<div class="col-md-2">
					<div class="card border-top border-info">
						<div class="card-body">
							<div align="center">
								Coupons : <input type="radio" class="btn btn-outline-info btn_show" name="show" value="coupon" <cfif show eq "coupon">checked</cfif>>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-2">
					<div class="card border-top border-info">
						<div class="card-body">
							<div align="center">
								Ecole : <input type="radio" class="btn btn-outline-info btn_show" name="show" value="school" <cfif show eq "school">checked</cfif>>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-2">
					<div class="card border-top border-info">
						<div class="card-body">
							<div align="center">
								Parrainage : <input type="radio" class="btn btn-outline-info btn_show" name="show" value="parrain" <cfif show eq "parrain">checked</cfif>>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
			<cfif show eq "product">
			<div class="row">
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
						<div class="card-body">
					
							<h5 class="card-title d-inline">Product</h5>
							
							<table class="table">
							<tr>
								<th>Catégorie</th>
								<th>ID</th>
								<th>Produit</th>
								<th>Subname</th>
								<th>Variations</th>
								<th width="80px">Action</th>
							</tr>
							<cfoutput query="get_product" group="product_id">
							<tr>
								<td><strong>#category_name#</strong></td>
								<td><strong>#product_id#</strong></td>
								<td>#product_name#</td>
								<td>#product_subname#</td>
								<td><cfoutput>#variation_name# </cfoutput></td>
								<td><a href="shop_product_edit.cfm?p_id=#product_id#" class="btn btn-info">Edit</a></td>
							</tr>
							</cfoutput>
							</table>
							
						</div>
						
					</div>
					
				</div>
			</div>
			</cfif>
				
			<cfif listFindNoCase("coupon,parrain,school",show)>
			<div class="row">
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
						<div class="card-body">
					
							<h5 class="card-title d-inline">Coupons</h5>
							
							<table class="table">
							<tr>
								<th>Code</th>
								<th>Product</th>
								<th>Reduction</th>
								<th>Activity</th>
								<th>Active</th>
								<cfif show eq "parrain">
									<th>Users</th>
								</cfif>
								<th >Action</th>
							</tr>
							<cfoutput query="get_coupon" group="coupon_id">
							<tr>
								<td><strong>#coupon_code#</strong></td>
								<td>#product_id#</td>
								<td>#coupon_discount# #coupon_type#</td>
								<td>#coupon_use# / #coupon_use_limit GT 0 ? coupon_use_limit : "-"#</td>
								<td>
									<!--- #coupon_valid ? "YES" : "NO"# --->
									<label>
										<input disabled name="c_valid" type="checkbox" <cfif coupon_valid eq 1>checked</cfif> value="1"> 
									</label>
								</td>
								<cfif show eq "parrain">
									<td>
										<cfoutput>
											<a href="common_learner_account.cfm?u_id=#user_id#" class="text-dark font-weight-bold">#ucase(user_name)#<br>#user_firstname#</a>
										</cfoutput>
									</td>
								</cfif>
								<td>
									<a href="shop_product_edit.cfm?c_id=#coupon_id#" class="btn btn-info"><i class="fa-light fa-pen-to-square"></i></a>
								</td>
									<td> <a href="shop_product_edit.cfm?c_id=#coupon_id#" class="btn btn-danger coupon_delete" id="btn_coupon_delete_#coupon_id#"><i class="fa-light fa-trash"></i></a></td>
								 
							</tr>
							</cfoutput>
							<tr>
								<td colspan="6" align="center">
								<a href="shop_product_edit.cfm?new_coupon=1" class="btn btn-info"><i class="fal fa-plus"></i></a>
								</td>
							</tr>
							</table>
							
						</div>
						
					</div>
					
				</div>
			</div>
			</cfif>
				
			
			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$( document ).ready(function() {
	$('.coupon_delete').click(function(event) {

		event.preventDefault();		
		var id = $(this).attr("id");
		var id = id.split("_");
		
		var c_id = id[3];
		/* console.log(c_id); */

		if(confirm("Confirmer la suppression du coupon ?")) {
		
			$.ajax({
            url:"./api/product/product_post.cfc?method=odelete_coupon",
            type: "POST",
            data : {c_id: c_id},
			success : function(resultat, statut){
					window.location.reload(true);
				},
            error: function(resultat, statut, erreur){ 
             
            },
            complete : function (resultat, statut){
               
            }
        });
		}
	

	});
	
	$('.btn_show').click(function(event) {
	
		<!--- var attr_p = $('.btn_activ_product').attr("checked"); --->
		<!--- console.log(attr_p); --->
	
		<!--- var attr = $('.btn_activ_coupon').attr("checked"); --->
		<!--- console.log(attr); --->
		
		var go = $(this).val();
		<!--- if (typeof attr !== typeof undefined && attr !== false) { --->
			<!--- var cpn = 0; --->
		<!--- } --->
		<!--- else { --->
			<!--- var cpn = 1; --->
		<!--- } --->
		
		<!--- if (typeof attr_p !== typeof undefined && attr_p !== false) { --->
			<!--- var prdt = 1; --->
		<!--- } --->
		<!--- else { --->
			<!--- var prdt = 0; --->
		<!--- } --->
	
		<cfoutput>
			document.location.href='shop_product_list.cfm?show='+go;
		</cfoutput>
	});
	
	
});
</script>

</body>
</html>