<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfquery name="get_scorm_module" datasource="#SESSION.BDDSOURCE#">
	SELECT sm.sessionmaster_name, sm.sessionmaster_id,
	tp.tpmaster_name_#SESSION.LANG_CODE# as _tpmaster_name, 
	tm.module_name_#SESSION.LANG_CODE# as _module_name, 
	tm.module_description_#SESSION.LANG_CODE# as _module_description, 
	tm.module_level, tm.module_id,
	lsm.scorm_index, lsm.scorm_type, test
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id
	LEFT JOIN lms_scorm_mapping lsm ON lsm.scorm_id = sm.sessionmaster_id
	LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id
	WHERE formation_id = 2
	AND tp.tpmaster_prebuilt = 0
	AND sm.sessionmaster_online_el = 1


	AND sm.sessionmaster_id = 725



	ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
</cfquery>

<!--- <cfquery name="get_module" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM lms_tpmodulemaster2 ORDER BY module_name ASC --->
<!--- </cfquery>					 --->
							
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		
		<cfset title_page = "Storiz">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfdump var="#get_scorm_module#">
			<div class="row">
	
				<cfoutput query="get_scorm_module" group="module_id">

					<div class="col-md-12">

						<div class="row">

							<h5 class="d-inline"> #_module_name#</h5>
							<hr class="border-#module_level# mb-1 mt-2">
						
						</div>

						<cfoutput group="sessionmaster_id">

							<div class="border-top p-2">


								<div class="float-left">    

									#sessionmaster_id# -

									#sessionmaster_name#

									<a class="btn btn-sm btn-#module_level#" href="el_play_sco_parser.cfm?sco=#sessionmaster_id#">
										Go module
									</a>
								</div>

							</div>


							<table id="table_tp" class="table table-sm mt-3" width="100%">
								<thead>
									<tr bgcolor="##F3F3F3">
										<th></th>
										<th><label>Index</label></th>
										<th><label>type</label></th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody id="tbody_sortable">
								
									<cfoutput>
									
									<tr id="tr_1">
										<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>
										<td>	
											#scorm_index#
										</td>
										<td>									
											#scorm_type#
										</td>
										<td>									
											#test#
										</td>
										<td>
											<a id="r_#sessionmaster_id#_#scorm_index#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>
										</td>
									</tr>
									
									
									</cfoutput>
								
								
								</tbody>
							</table>
						</cfoutput>
					</div>
				</cfoutput>
			</div>
		</div>
	</div>
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	
})
</script>

</body>
</html>