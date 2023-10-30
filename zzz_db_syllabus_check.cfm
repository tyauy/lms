<cfif isdefined("sm_id") AND isdefined("updt") AND isdefined("tpmaster_id") AND isdefined("module_id")>

<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_tpsessionmaster2 SET module_id = #module_id# WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>
	
<cfif isdefined("tpmastercor_id")>

	<cfquery name="updt_master" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpmastercor2 SET tpmaster_id = #tpmaster_id# WHERE tpmastercor_id = #tpmastercor_id#
	</cfquery>


</cfif>

<cfoutput>
sm_id  = #sm_id#<br>
tpmastercor_id = #tpmastercor_id#<br>
tpmaster_id = #tpmaster_id#<br>
module_id = #module_id#<br>
</cfoutput>




<br>

<cfabort>
</cfif>

<!DOCTYPE html>

<cfsilent>

<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT sm.sessionmaster_id, sm.sessionmaster_name, sm.module_id as md_id<!---, tp.tpmaster_id as tpm_id--->

FROM lms_tpsessionmaster2 sm 
<!--- LEFT JOIN lms_tpmastercor2 tc ON sm.sessionmaster_id = tc.sessionmaster_id  --->
<!--- LEFT JOIN lms_tpmaster2 tp ON tp.tpmaster_id = tc.tpmaster_id --->

WHERE 
sm.sessionmaster_online_visio = 1 
AND sm.sessionmaster_id <> 694
AND sm.sessionmaster_id <> 695
AND sm.sessionmaster_id <> 696
AND sm.sessionmaster_id <> 697
AND sm.sessionmaster_id <> 1063
AND sm.sessionmaster_id <> 1112
AND sm.sessionmaster_id <> 769
<!--- AND tp.formation_id = 2 --->
ORDER BY sm.module_id ASC
<!--- LIMIT 120 --->
</cfquery>

<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpmodulemaster2
</cfquery>

<cfquery name="get_tpmaster" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpmaster2 WHERE tpmaster_prebuilt = 0 ORDER BY tpmaster_level
</cfquery>



</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : #obj_translater.get_translate('title_page_common_materials')#">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
			

			<div class="row">
				<div class="col-md-12">

					<table class="table table-bordered table-sm bg-white">
						<tr align="center">	
							<td class="bg-light font-weight-bold">ID</td>					
							<td class="bg-light font-weight-bold">Name</td>	
							<td class="bg-light font-weight-bold">Module</td>
							<td class="bg-light font-weight-bold">Module list</td>
							<td class="bg-light font-weight-bold">Tpmaster 1</td>	
							<td class="bg-light font-weight-bold">Container 1</td>
							<td>Action</td>
						</tr>
						<cfoutput query="get_sessionmaster">
						

<cfquery name="get_tpmaster_solo" datasource="#SESSION.BDDSOURCE#">
SELECT tpm.tpmaster_id as tpm_id, tpm.tpmastercor_id
FROM lms_tpmastercor2 tpm
INNER JOIN lms_tpmaster2 tp ON tp.tpmaster_id = tpm.tpmaster_id
WHERE tpm.sessionmaster_id = #sessionmaster_id#
AND tp.tpmaster_prebuilt = 0
</cfquery>

<form action="db_syllabus_check.cfm" method="post">
						<tr align="center">	
							<td>
							#sessionmaster_id#
							
							<!--- <cfif get_sessionmaster.tpm_id neq ""><cfdump var="#get_tpmodulemaster#"></cfif> --->
							</td>
							<td><a href="db_syllabus_edit.cfm?sm_id=#sessionmaster_id#" target="_blank">#sessionmaster_name#</a></td>		
							<td>#md_id#</td>
							<td>
							<select name="module_id" class="form-control">
							<cfloop query="get_module">
							<option value="#get_module.module_id#" <cfif get_sessionmaster.md_id eq get_module.module_id>selected</cfif>>#get_module.module_name#</option>
							</cfloop>
							<option value="" <cfif get_sessionmaster.md_id eq "">selected</cfif>>---------</option>
							</select>
							</td>
							<td>#get_tpmaster_solo.tpm_id#</td>
							<td>
							
							<select name="tpmaster_id" class="form-control">
							<cfloop query="get_tpmaster">
							<option value="#get_tpmaster.tpmaster_id#" <cfif get_tpmaster_solo.tpm_id eq get_tpmaster.tpmaster_id>selected</cfif>>#get_tpmaster.tpmaster_level# - #get_tpmaster.tpmaster_name#</option>
							</cfloop>
							<option value="" <cfif get_tpmaster_solo.tpm_id eq "">selected</cfif>>---------</option>
							
							</select>
							</td>
							<td>
							<!--- <cfif get_sessionmaster.tpm_id neq ""> --->
							<!--- <select name="tpmaster_id" class="form-control"> --->
							<!--- <cfloop query="get_tpmaster"> --->
							<!--- <option value="#get_tpmaster.tpmaster_id#" <cfif get_tpmodulemaster.tpmaster_id eq get_tpmodulemaster.tpmaster_id>selected</cfif>>#get_tpmaster.tpmaster_name#</option> --->
							<!--- </cfloop> --->
							<!--- </select> --->
							<!--- </cfif> --->
							<cfif get_tpmaster_solo.tpmastercor_id neq "">
							#get_tpmaster_solo.tpmastercor_id#
							<input type="hidden" name="tpmastercor_id" value="#get_tpmaster_solo.tpmastercor_id#">
							<input type="hidden" name="sm_id" value="#sessionmaster_id#">
							<input type="hidden" name="updt" value="1">
							<input type="submit" class="btn btn-sm btn-info" value="UPDT">
							</cfif>
							</td>
						</tr>
						
</form>
						</cfoutput>	
					</table>
							
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>
$(function() {


	<!--- $('.btn_create_ressource').click(function(event) {	 --->
		<!--- event.preventDefault();		 --->
		<!--- var idtemp = $(this).attr("id"); --->
		<!--- var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50); --->
		<!--- $('#window_item_lg').modal({keyboard: true}); --->
		<!--- $('#modal_title_lg').text("Ajouter ressource"); --->
		<!--- $('#modal_body_lg').load("modal_window_ressource.cfm?new_resource=1&f_id="+idtemp, function() {}); --->
	<!--- }); --->
	
})

</script>

</body>
</html>