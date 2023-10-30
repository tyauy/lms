<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,4,5,12">
	<cfinclude template="./incl/incl_secure.cfm">		
    <cfif not isDefined("f_id")>
        <cfset f_id = 2>
    </cfif>

    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation
    </cfquery>	

    <cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
        SELECT elearning_module_id, elearning_module_path, tsm.sessionmaster_id, tsm.sessionmaster_name
        FROM lms_elearning_module em
        LEFT JOIN lms_tpsessionmaster2 tsm ON tsm.sessionmaster_id = em.sessionmaster_id
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
      
		<cfset title_page = "Elearning module list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">

                <div class="col-md-12">
                    <!--- <input type="button" class="btn btn-sm btn-info" id="new_module" value="New module"> --->
                <!--- <form action="updater_elearning.cfm" method="post" enctype="multipart/form-data">
                    <cfoutput>
                    <div class="row">
                        <div class="col-md-2">
                            <input type="text" id="module_name" name="module_name" placeholder="Nom" class="form-control form-control-sm" value="">
                        </div>
                        <!--- <div class="col-md-2">
                            <input type="text" id="module_path" name="module_path" placeholder="Identifiant" class="form-control form-control-sm" value="">
                        </div> --->
                        <div class="col-md-2">
                            <input type="number" id="module_difficulty" name="module_difficulty" placeholder="difficulty" class="form-control form-control-sm" value="">
                        </div>
                        <div class="col-md-1">
                            <label for="doc_attach_preview" class="form-control form-control-sm m-0" style="cursor: pointer;">
                                + preview
                            </label>
                            <input type="file" id="doc_attach_preview" class="elearning_attach" name="doc_attach_preview" accept=".jpg,.png"
                            <!--- data-session='#token_session_id#' --->
                            class="form-control" style="display:none">
                        </div>
                        <div class="col-md-3">
                            <!--- <label for="doc_attach_elearning" class="form-control form-control-sm m-0" style="cursor: pointer;">
                                + module
                            </label>
                            <input type="file" id="doc_attach_elearning" class="elearning_attach" name="doc_attach_elearning" accept=".zip"
                            <!--- data-session='#token_session_id#' --->
                            class="form-control" style="display:none"> --->


							<cfdirectory action="list" directory="#SESSION.BO_ROOT#/assets/scorm" recurse="false" name="myList" type="dir" sort="name asc">
							<select class="form-control" name="module_path">
								<cfloop query="myList">
									<option value="#name#">#name#</option>
								</cfloop>
							</select>

                        </div>
                        <div class="col-md-1">
							<cfoutput><input type="submit" id="submit_module_create" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#"></cfoutput>
                        </div>
                    </div>
                    </cfoutput>
                </form> --->
                </div>


                <table id="table_token" class="table table-sm bg-white">
                    <tr class="bg-light">
                        <th></th>
                        <th>
                            ID
                        </th>
                        <th>
                            Name	
                        </th>
                        <th>
                            Identifiant	
                        </th>
                        <th>
                            Test
                        </th>
                        <th>
                            +
                        </th>
                    </tr>
                    <cfoutput query="get_modules">
                        <tr>
                            <td>
                                <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="120" class="mr-2">
                                <!--- <cfif module_thumbs neq "">
                                    <img src="../assets/img_elearning/#module_thumbs#" width="120" class="mr-2">
                                <cfelse>
                                    <label for="doc_attach_preview_#elearning_id#" class="form-control form-control-sm m-0" style="cursor: pointer;">
                                        + preview
                                    </label>
                                    <input type="file" id="doc_attach_preview_#elearning_id#" class="elearning_attach" name="doc_attach_preview_#elearning_id#" accept=".jpg,.png"
                                    <!--- data-session='#token_session_id#' --->
                                    class="form-control" style="display:none">
                                </cfif> --->
                            </td>
                            <td>
                                #elearning_module_id#
                            </td>
                            <td>
                                #sessionmaster_name#
                                <!--- <small>#module_name#</small> --->
								<!--- <input type="text" id="module_name" name="module_name" class="form-control form-control-sm" value="#module_name#"> --->
                            </td>
                            <td>
                                #elearning_module_path#
                            </td>
                            <td>
                                <a class="btn btn-sm" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank">
                                    <i class="fa-thin fa-circle-play"></i>
                                    PLAY MODULE
                                </a>
                            </td>
                            <!--- <td>
                                <span class="badge badge-pill badge-#token_status_css# p-1">#token_status_name# </span>
                            </td> --->
                            <td>
                                <input type="hidden" name="elearning_module_id" value="#elearning_module_id#">
                                <!--- <input type="submit" id="submit_module_update" class="btn btn-info" value="MAJ"> --->
                                <!--- <a class="btn btn-danger btn_module_delete" id="del_#elearning_module_id#"><i class="fal fa-trash-alt"></i></a> --->
                            </td>
                        </tr>
                    </cfoutput>
                </table>
			</div>
			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {


});

</script>
  
  
</body>
</html>