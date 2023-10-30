<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,4,12">
	<cfinclude template="./incl/incl_secure.cfm">		

	<cfparam name="wemail_cat" default="1">
	
	<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
	SELECT `wemail_category` FROM `lms_wemail` GROUP BY  wemail_category ORDER BY wemail_category
	</cfquery>
	

	<cfif not isdefined("list_lang") OR list_lang eq "">
		<cfset list_lang = "en">
	</cfif>

	<cfset selected_lang = listGetAt(list_lang, 1, ",")>
	  
	
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
      
		<cfset title_page = "Vocabulary list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">
					
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
						<div class="card-body">
						
										
							<h5 class="card-title d-inline">Vocab List</h5>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											
							
							<form class="form_upload_token_batch" name="form_upload_token_batch">
								
								<label for="doc_attach_batch" class="btn btn-lg btn-block btn-primary" style="cursor: pointer;">
									<i class="fa-light fa-file-excel fa-2x"></i> <i id="loading_xlsx" class="fas fa-spinner fa-spin fa-2x text-white collapse"></i>
									<br>
									Import WEMAIL LIST
								</label>
								<input type="file" id="doc_attach_batch" class="token_attach" name="doc_attach" accept=".xlsx" style="display:none">
	
								<!--- <input type="hidden" name="a_id" value="<cfoutput>#a_id#</cfoutput>">
								<input type="hidden" name="s_id" value="<cfoutput>#ts_id#</cfoutput>">	 --->
							</form>
							<!--- <a href="#" class="btn btn-info pull-right btn_create_vocab">Add vocab list</a> --->
								
							<br><br>
							
							<select name="wemail_category" class="select_voc_cat form-control">								
							<cfoutput query="get_category">
							<option value="#get_category.wemail_category#" <cfif isdefined("wemail_cat") AND wemail_cat eq get_category.wemail_category>selected</cfif>>#wemail_category#</option>
							</cfoutput>							
							</select>
							
							
							<br><br>
							
							<cfif isdefined("wemail_cat")>
								<cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_wemail WHERE wemail_category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wemail_cat#">
								</cfquery>


								<table class="table table-sm m-0">
			
									<tr>
										<th>subject</th>
										<th>subcategory</th>
										<th>sample_1</th>
										<th>sample_2</th>
										<th>sample_3</th>
										<th>sample_4</th>
										<th>sample_5</th>
										<th>sample_6</th>
										<th>sample_7</th>
										<th>sample_8</th>
										<th>del</th>
									</tr>
										
									<cfoutput query="get_wemail">
	
									<!--- <form action="db_updater_resource.cfm" method="post"> --->
										<tr>
											<td>
												#wemail_subject#
											</td>
											<td>
												#wemail_subcategory#
											</td>
											<td>
												<textarea name="wemail_sample_1" class="form-control form-control-sm">#wemail_sample_1#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_2" class="form-control form-control-sm">#wemail_sample_2#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_3" class="form-control form-control-sm">#wemail_sample_3#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_4" class="form-control form-control-sm">#wemail_sample_4#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_5" class="form-control form-control-sm">#wemail_sample_5#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_6" class="form-control form-control-sm">#wemail_sample_6#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_7" class="form-control form-control-sm">#wemail_sample_7#</textarea>
											</td>
											<td>
												<textarea name="wemail_sample_8" class="form-control form-control-sm">#wemail_sample_8#</textarea>
											</td>
											
											
											<td>
												<a class="btn btn-sm btn-danger" href="db_updater_wemail.cfm?act=del_wemail&wemail_cat=#wemail_cat#&wemail_id=#wemail_id#">DEL</a>
											</td>
											
											<!--- <td align="center" colspan="10">
												<input type="hidden" name="act" value="updt_wemail">
												<input type="hidden" name="wemail_cat" value="#wemail_cat#">
												<input type="submit" class="btn btn-info btn-sm" value="MAJ">
											</td> --->
										
										</tr>
									<!--- </form> --->
									
								</cfoutput>
									
								
								</table>

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

<script>
$( document ).ready(function() {

	<!--- global vars --->
	voc_id = "";
	lang_code = "";
	
	$('.select_voc_cat').change(function(event) {		
		document.location.href="db_vocab_wemail.cfm?wemail_cat="+$(this).val();	
	});
	
	// $('.btn_create_vocab').click(function(event) {	
	// 	event.preventDefault();		
		
	// 	$('#window_item_lg').modal({keyboard: true});
	// 	$('#modal_title_lg').text("Ajouter Vocabulary list");
	// 	$('#modal_body_lg').load("modal_window_ressource.cfm?new_vocab=1", function() {});
	// });

	
	
	
});
	

</script>

</body>
</html>