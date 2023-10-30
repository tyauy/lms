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

    <!--- <cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
        SELECT elearning_id, module_id, module_path, module_name FROM lms_elearning
    </cfquery>	 --->
    <cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
        SELECT elearning_module_id, elearning_module_path, tsm.sessionmaster_id, tsm.sessionmaster_name
        FROM lms_elearning_module em
        LEFT JOIN lms_tpsessionmaster2 tsm ON tsm.sessionmaster_id = em.sessionmaster_id
    </cfquery>	

	<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
		SELECT level_id, level_alias FROM lms_level
	</cfquery>

    <cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
        SELECT sm.sessionmaster_id, sm.sessionmaster_name
        FROM lms_tpsessionmaster2 sm
    </cfquery>

    <!--- 		tp.tpmaster_name_#SESSION.LANG_CODE# as _tpmaster_name,  --->

    <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
        SELECT emg.elearning_module_group_id, emg.elearning_module_group_name, 
        emg.elearning_module_group_creation, emg.tp_orientation_id,
        em.elearning_module_id, em.elearning_module_path,
        sm.sessionmaster_name, sm.sessionmaster_id,
		tm.module_name_#SESSION.LANG_CODE# as _module_name, 
		tm.module_description_#SESSION.LANG_CODE# as _module_description, 
		tm.module_level, tm.module_id,
        l.level_alias, l.level_css
        FROM lms_elearning_module_group emg
        LEFT JOIN lms_elearning_module_cor ec ON ec.elearning_module_group_id = emg.elearning_module_group_id
        LEFT JOIN lms_elearning_module em ON em.elearning_module_id = ec.elearning_module_id
        LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id	
        LEFT JOIN lms_tpmodulemaster2 tm ON tm.module_id = sm.module_id 
        LEFT JOIN lms_level l ON l.level_id = emg.level_id
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
                <form id="form_insert_session">
                    <div class="row">
                        <div class="col-md-3">
                            <input type="text" name="elearning_module_group_name" placeholder="Nom" class="form-control form-control-sm" value="">
                        </div>
						<div class="col-md-3">
							<select class="form-control" name="level_id">
								<cfoutput query="get_level">
								<!---<a class="btn btn-sm <cfif voc_cat_select eq get_category.voc_cat_id>btn-outline-info active<cfelse>btn-outline-info</cfif> mb-0 py-0" href="common_tools.cfm?subm=vocabulary&voc_cat_select=#voc_cat_id#">#voc_cat_name#</a>--->
								<option value="#level_id#">#level_alias#</option>
								</cfoutput>
							</select>
						</div>
						<!--- <div class="col-md-3">
							<select class="form-control elearning_id" name="elearning_id">
								<cfoutput query="get_modules">
								<!---<a class="btn btn-sm <cfif voc_cat_select eq get_category.voc_cat_id>btn-outline-info active<cfelse>btn-outline-info</cfif> mb-0 py-0" href="common_tools.cfm?subm=vocabulary&voc_cat_select=#voc_cat_id#">#voc_cat_name#</a>--->
								<option value="#elearning_id#">#module_name#</option>
								</cfoutput>
							</select>                        
						</div> --->
						<div class="col-md-3">
							<cfoutput><input type="submit" id="submit_session_create" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#"></cfoutput>
                        </div>
                    </div>
                </form>
                </div>
    
                <div class="col-md-12 col-sm-12">
                    
                    <cfoutput query="get_session" group="elearning_module_group_id">
                        <div class="card border">
                            <div class="card-body">
                                <div class="d-flex">
                                    <div>
                                        <img src="./assets/img_level/#level_alias#.svg" width="40">
                                    </div>
                                    <div class="w-100 ml-2">

                                        <h5 class="d-inline"> #elearning_module_group_name#</h5>
                                        <hr class="border-#level_alias# mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Crée le : #elearning_module_group_creation#</small></span>
                                    
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-lg-12 col-md-12 col-sm-12">

                                        Modules <br>

                                        <cfoutput group="elearning_module_id">

                                            <cfif elearning_module_id neq "">
                                            <div class="row mt-2">
                
                                                <div class="col-lg-12 col-md-12 col-sm-12">
                                                    
                                                    <!--- <cfloop from="1" to="2" index="cor"> --->
                                                    <div class="border-top p-2">
            
                                                        <div class="float-left">       
                                                            <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="120" class="mr-2">
                                                        </div>   
            
                                                        <div class="float-left">    
                                                            #elearning_module_group_name#
                                                            
                                                        </div>
            
                                                        <div class="float-right">    
                                                            <form>
                                                                <input type="hidden" name="elearning_module_id" value="#elearning_module_id#">
                                                                <input type="hidden" name="elearning_module_group_id" value="#elearning_module_group_id#">
                                                                <input type="hidden" name="delete" value="1">
                                                                <button type="button" class="btn btn-sm btn-outline-info btn_add_session_module">DELETE</button>
                                                            </form>
                                                                
                                                        </div>

                                                        <div class="float-right">    
            
                                                            <a class="btn btn-sm btn-outline-a1" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank">
                                                                <h3 class="m-0"><i class="fa-thin fa-circle-play"></i></h3>
                                                                PLAY MODULE
                                                            </a>
                                                            
                                                        </div>

                                                        
            
                                                    </div>
            
                                                </div>
            
                                            </div>
                                            </cfif>
                                        </cfoutput>
                                    </div>

                                </div>

                                
                                <div class="row mt-2 border-top">
                                    <form class="col-md-12">
                                        <div class="row mt-2">
                                        <div class="col-md-8">       
                                            <select class="form-control" name="elearning_module_id">
                                                <cfloop query="get_modules">
                                                <!---<a class="btn btn-sm <cfif voc_cat_select eq get_category.voc_cat_id>btn-outline-info active<cfelse>btn-outline-info</cfif> mb-0 py-0" href="common_tools.cfm?subm=vocabulary&voc_cat_select=#voc_cat_id#">#voc_cat_name#</a>--->
                                                <option value="#get_modules.elearning_module_id#">#get_modules.sessionmaster_name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
    
                                            <input type="hidden" name="elearning_module_group_id" value="#elearning_module_group_id#">
                                            <button type="button" class="btn btn-sm btn-outline-info btn_add_session_module">add</button>
                                            
                                        </div>
                                        </div>
                                    </form>
                                </div>
                               
                            </div>
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


    $('#submit_session_create').click(function(event) {
		event.preventDefault();

        var fd = new FormData(event.target.form);
        console.log(event.target.form)

        $.ajax({
			url: './api/elearning/elearning_post.cfc?method=insert_elearning_session',
			type: 'POST',
			data: $('#form_insert_session').serialize(),
			success : function(result, status){
				console.log(result);
                window.location.reload(true);
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});


	});

    $('.btn_add_session_module').click(function(event) {
		event.preventDefault();

        // var fd = new FormData(event.target.form);
        // console.log(event.target.form)

        $.ajax({
			url: './api/elearning/elearning_post.cfc?method=elearning_add_module',
			type: 'POST',
			data: $(this.form).serialize(),
			success : function(result, status){
				console.log(result);
                window.location.reload(true);
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});


	});

});

</script>
  
  
</body>
</html>