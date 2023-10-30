<!DOCTYPE html>
<html lang="fr">
<head>
	<cfif isdefined('reload')>
	<meta http-equiv="refresh" content="0;url=<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/db_module_list.cfm">
	</cfif>
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="5">
	
	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>
 
 <!--- <cfif isdefined('reload') and reload eq 1> --->
 <!--- <cfset reload = 0> --->
 <!--- <script language="javascript"> --->
           <!--- window.location.reload(true); --->
 <!--- </script> --->

 <!--- </cfif> --->

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
	SELECT module_id, module_name, module_name_fr, module_name_en, module_name_de, module_name_es, module_name_it, module_description_fr, module_description_en, module_description_de,  module_description_es, module_description_it, module_level
	FROM lms_tpmodulemaster2
	ORDER BY module_level
</cfquery>

</cfsilent>

	


<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		
		<cfset title_page = "Modules">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row">
				<div class="col-md-12">
				
				
				
					<ul class="nav nav-tabs" id="module_list" role="tablist">
						<cfoutput query="get_modules" group="module_level">
						<li class="nav-item">		
							<a href="##f_#replace(module_level,"/","","ALL")#" class="nav-link <cfif module_level eq "A1/A2">active</cfif>" role="tab" data-toggle="tab">
							#module_level#
							</a>
						</li>
						</cfoutput>
						<li class="nav-item">
							<a href="#f_add" class="nav-link" role="tab" data-toggle="tab">
								<i class="far fa-plus"></i>
							</a>
						</li>
					</ul>
				
				
					<div class="tab-content">
						 
						<!--- <cfdump var="#get_modules#"> --->
						<cfloop list="A1/A2,A2,B1,B1/B2,B2,C1,C1/C2" index="tab_level">
						
						<div role="tabpanel" class="tab-pane <cfif tab_level eq "A1/A2">active show</cfif>" <cfoutput>id="f_#replace("#tab_level#","/","","ALL")#"</cfoutput> style="margin-top:15px;">
							<cfoutput query="get_modules">
							<cfif module_level eq tab_level>
							<form action="db_updater.cfm" method="post" enctype="multipart/form-data">

							<table class="table table-bordered table-sm">
								<tr class="bg-light">
									<th colspan="2"><strong>#module_id# - #module_name# </strong></th>
								</tr>
								
								
								<!----------------->
								<tr class="bg-white">
									<td width="10%">
										NAME
									</td>
									<td width="90%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										
										<li class="nav-item">		
											<a href="##update_name_#lg#_#module_id#" class="nav-link<cfif lg eq #SESSION.LANG_CODE#> active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											
											<div role="tabpanel" class="tab-pane<cfif lg eq #SESSION.LANG_CODE#> active show</cfif>" id="update_name_#lg#_#module_id#" style="margin-top:15px;">
												<input type="text" class="form-control" name="update_name_#lg#" value="#evaluate('module_name_#lg#')#">
											</div>
											
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
								<tr class="bg-white">
									<td width="10%">
										DESCRIPTION
									</td>
									<td width="90%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										
										<li class="nav-item">		
											<a href="##update_description_#lg#_#module_id#" class="nav-link<cfif lg eq #SESSION.LANG_CODE#> active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											
											<div role="tabpanel" class="tab-pane<cfif lg eq #SESSION.LANG_CODE#> active show</cfif>" id="update_description_#lg#_#module_id#" style="margin-top:15px;">
												<input type="text" class="form-control" name="update_description_#lg#" value="#evaluate('module_description_#lg#')#">
											</div>
											
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
								
								
								
							
								
								
								<tr class="bg-white">
									<td>ADD JPG	<cfif FileExists("#SESSION.BO_ROOT#/assets/img_module/#module_id#.jpg")> <img class="ml-3" src="./assets/img_module/#module_id#.jpg" width="120" align="center"></cfif></td>
									<td>
										<input type="file" name="add_picture" accept=".jpg">
									</td>
								</tr>
								
								<tr class="bg-white">
									<td><input type="hidden" name="updt_module" value="#module_id#"></td>
		
									<td width="30%"><input id="#module_id#" type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_update')#"></td>
									
								</tr>
								
								

							</table>
							</form>	
							</cfif>
							</cfoutput>
						</div>
						

						
						</cfloop>
						
						
						
						
						
						<!---- ADD NEW MODULE ----->
						<div role="tabpanel" class="tab-pane" <cfoutput>id="f_add"</cfoutput> style="margin-top:15px;">
						<cfoutput>
							<form action="db_updater.cfm" method="post" enctype="multipart/form-data">

							<table class="table table-bordered table-sm">
													
								
							<tr class="bg-white">
								<td width="10%">
									LEVEL
								</td>
								<td width="90%">
									<select name="insert_level" class="form-control">
										<cfloop list="A1/A2,A2,B1,B1/B2,B2,C1,C1/C2" index="lvl">
										<option value="#lvl#">
										#lvl#
										</option>
										</cfloop>
									</select>
								</td>
								
								
								
								<!----------------->
								<tr class="bg-white">
									<td width="10%">
										NAME
									</td>
									<td width="90%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										
										<li class="nav-item">		
											<a href="##insert_name_#lg#" class="nav-link<cfif lg eq #SESSION.LANG_CODE#> active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											
											<div role="tabpanel" class="tab-pane<cfif lg eq #SESSION.LANG_CODE#> active show</cfif>" id="insert_name_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="insert_name_#lg#" value="">
											</div>
											
											</cfloop>											
										</div>
									</td>
								</tr>
								
								
								<tr class="bg-white">
									<td width="10%">
										DESCRIPTION
									</td>
									<td width="90%">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										
										<li class="nav-item">		
											<a href="##insert_description_#lg#" class="nav-link<cfif lg eq #SESSION.LANG_CODE#> active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											
											<div role="tabpanel" class="tab-pane<cfif lg eq #SESSION.LANG_CODE#> active show</cfif>" id="insert_description_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="insert_description_#lg#" value="">
											</div>
											
											</cfloop>											
										</div>
									</td>
								</tr>
								

							
								
								<tr class="bg-white">
									<td><input type="hidden" name="insert_module" value="1"></td>
		
									<td width="30%"><input type="submit" class="btn btn-outline-info" value="ADD"></td>
									
								</tr>
								
								

							</table>
							</form>	
						</cfoutput>
						</div>
						
						
						
						
					</div>
				
				
				

				
				
				</div>
			</div>
		</div>
	
	</div>
	
<cfinclude template="./incl/incl_footer.cfm">
	
</div>

  
<cfinclude template="./incl/incl_scripts.cfm">



<script>
$(document).ready(function() {
	
	
})
</script>

</body>
</html>
