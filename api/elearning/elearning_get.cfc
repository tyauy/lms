<cfcomponent>

     


    <cffunction name="get_module" access="remote" returnformat="plain" output="true" description="Display the EL resources">


		<cfargument name="f_id" type="numeric" required="no" default="2">
        <cfargument name="obj_id" type="numeric" required="no" default="2">
        <cfargument name="lvl_id" type="numeric" required="no">
		<cfargument name="kw_id" type="any" required="no">
        <cfargument name="lvl_big_alias" type="any" required="no">

        
        <cfset obj_translater = createobject("component", "comp.translater")>
        <cfset obj_function = createobject("component", "comp.functions")>

     
		<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
        SELECT 

        em.elearning_module_id,
        emg.elearning_module_group_name, emg.elearning_module_group_id, emg.tp_orientation_id,
        sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource,
        CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
        CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
        l.level_id, l.level_alias, sm.level_id as sm_level_id,
        emu.elearning_user_id, emu.elearning_active
        
        FROM lms_elearning_module em
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id
        INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
        INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 

        LEFT JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id
        LEFT JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id
        LEFT JOIN lms_level l ON l.level_id = sm.level_id

        <cfif obj_id eq "6">
            INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
        </cfif>

        LEFT JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1

        LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

        WHERE emg.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">

        AND sm.sessionmaster_online_el = 1

        AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
        
        <cfif lvl_big_alias eq "A">
            AND (sm.level_id = "1" OR sm.level_id = "2")
        <cfelseif lvl_big_alias eq "B">
            AND (sm.level_id = "3" OR sm.level_id = "4")
        <cfelseif lvl_big_alias eq "C">
            AND (sm.level_id = "5" OR sm.level_id = "6")
        </cfif>
        
        GROUP BY em.elearning_module_id
        ORDER BY emc.elearning_module_group_id, em.elearning_module_id
        </cfquery>

        <cfif get_module.level_alias eq "">
            <cfset level_alias = "red">
        <cfelse>
            <cfset level_alias = get_module.level_alias>
        </cfif>
        <!--- <cfdump var="#get_module#"> --->

        <div id="accordion_module">

            <cfoutput query="get_module" group="elearning_module_group_id">
            <div class="mt-3">
            
                <div class="shadow-sm rounded-bottom border border-#level_alias# m-0 w-100 bg-light">
                    
                    <div class="p-2" class="btn btn-primary" type="button" data-toggle="collapse" data-target="##module_group_#elearning_module_group_id#" aria-expanded="<!---<cfif tp_orientation_id eq "6">true<cfelse>false</cfif>--->false" aria-controls="module_group_#elearning_module_group_id#">
                        
                        <div class="d-flex">

                            <div>
                                <cfif tp_orientation_id eq "6">
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                <cfelse>
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                </cfif>


                            </div>
                                
                                
                            <div class="flex-grow-1 p-2">
                                
                                <div>

                                    #obj_function.get_level_thumb(level_id,"40")#


                                    <!--- <cfif level_alias neq "">
                                        <img src="./assets/img_level/#level_alias#.svg" width="40" align="left" class="mr-2">
                                    <cfelse>
                                        <img src="./assets/img_level/B1.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/B2.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/C1.svg" width="40" align="left" class="mr-2">
                                    </cfif> --->
                                    
                                
                                    <strong class="text-#level_alias# ml-2">
                                        <h5 class="d-inline"> #elearning_module_group_name#</h5>
                                    </strong>
                                    
                                    <hr class="border-#level_alias# mb-1 mt-3">
                                    <!--- <span class="text-danger fw-bold float-right"><small> Dernière activité : -</small></span> --->
                                
                                </div>
                                
                            </div>

                        </div>

                    </div>

                    <div class="card-body collapse <!---<cfif tp_orientation_id eq "6">show</cfif>--->" id="module_group_#elearning_module_group_id#" data-parent="##accordion_module">
            
                        <div class="row">
                            
                            <cfoutput>

                                <div class="col-md-6">
                                <cfinclude template="../../incl/incl_module_el.cfm">
                                </div>  

                            </cfoutput>
                            
                            </div>
            
                    </div>
            
                </div>
            </div>
            </cfoutput>

        </div>

	</cffunction>





    <cffunction name="get_el_sessionmaster" access="remote" returnformat="plain" output="true" description="Display the EL Video Resource">

		<cfargument name="kw_id" type="any" required="no" default="106">
		<cfargument name="f_id" type="numeric" required="no" default="2">

        <cfquery name="get_el_sessionmaster" datasource="#SESSION.BDDSOURCE#">
        SELECT 

        em.elearning_module_id,
        emg.elearning_module_group_name, emg.elearning_module_group_id, 
        sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource,
        CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
        CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
        l.level_id, l.level_alias,
        etu.elearning_tp_user_id,
        emg.tp_orientation_id
        
        FROM lms_elearning_module em
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id
        INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
        INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 

        INNER JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id
        INNER JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id
        LEFT JOIN lms_level l ON l.level_id = emg.level_id

        LEFT JOIN lms_elearning_tp_user etu ON etu.elearning_module_id = em.elearning_module_id AND etu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

        WHERE emg.tp_orientation_id = 6

        <!--- AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
        AND emg.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#"> --->

        AND sm.sessionmaster_online_el = 1

        GROUP BY em.elearning_module_id
        ORDER BY emc.elearning_module_group_id, em.elearning_module_id
        </cfquery>

<!--- <cfdump var="#get_module#"> --->

        <div id="accordion_module">

            
            <div class="mt-3">
            
                <div class="shadow-sm rounded-bottom border border-red m-0 w-100 bg-light">
                    
                    <!--- <div class="p-2" class="btn btn-primary" type="button" data-toggle="collapse" data-target="##module_group_#elearning_module_group_id#" aria-expanded="false" aria-controls="module_group_#elearning_module_group_id#">
                        
                        <div class="d-flex">

                            <div>
                                <!--- <i class="fa-light fa-earth-europe fa-lg mr-1 text-#level_alias#"></i>  --->
                                <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                                    <img src="../assets/img_material/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                                    <img src="../assets/img_material/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                <cfelse>
                                    <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                </cfif>
                            </div>
                                
                                
                            <div class="flex-grow-1 p-2">
                                
                                <div>
                                    <img src="./assets/img_level/#level_alias#.svg" width="40" align="left" class="mr-2">
                                
                                    <strong class="text-#level_alias#">
                                        <h5 class="d-inline"> #elearning_module_group_name#</h5>
                                    </strong>
                                    
                                    <hr class="border-#level_alias# mb-1 mt-3">
                                    <span class="text-danger fw-bold float-right"><small> Dernière activité : 07/01/2023</small></span>
                                
                                </div>
                                
                            </div>

                        </div>

                    </div>

                    <div class="card-body collapse" id="module_group_#elearning_module_group_id#" data-parent="##accordion_module"> --->
                    <div class="card-body">
                        <div class="row">
                            <cfoutput query="get_el_sessionmaster">

                            <cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
                            SELECT kw.keyword_name_#SESSION.LANG_CODE# as keyword_name, kw.keyword_id 
                            FROM lms_sessionmaster_keywordid_cor skc
                            INNER JOIN lms_keyword kw ON kw.keyword_id = skc.keyword_id
                            WHERE skc.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">
                            ORDER BY keyword_name ASC
                            </cfquery>


                            <div class="col-md-6">
                                <div class="card rounded border shadow-sm">

                                    <div class="card-body">
                                        
                                        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                                            <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="80" align="left" class="mr-2">
                                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                                            <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="80" align="left" class="mr-2">
                                        <cfelse>
                                            <img src="../assets/img/wefit_lesson.jpg" width="80" align="left" class="mr-2">
                                        </cfif>

                                        <h6 class="m-0">
                                            #sessionmaster_name#
                                        </h6>

                                        <small class="text-red">#sessionmaster_video_duration#<cfif sessionmaster_grammar neq ""> | #sessionmaster_grammar#</cfif><cfif sessionmaster_objectives neq ""> | #sessionmaster_objectives#</cfif></small>

                                        <p class="mt-2 mb-1">
                                            <small> #mid(sessionmaster_description,1,200)# [...]</small>
                                        </p>

                                        <cfloop query="get_kw">
                                            <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                                        </cfloop>
                                        <img src="./assets/img_level/B1.svg" width="30" align="left" class="mr-1 mt-2">
                                        <img src="./assets/img_level/B2.svg" width="30" align="left" class="mr-1 mt-2">
                                        <img src="./assets/img_level/C1.svg" width="30" align="left" class="mr-1 mt-2">


                                    </div>   
                                    <div class="card-footer bg-light border-top" align="right">
                                        <div class="d-flex justify-content-end align-items-end">
                                            <!--- <div align="center">
                                                <img src="./assets/img_formation/2.png" width="40" class="border_thumb mt-1"> 
                                            </div> --->
                                            <div class="ml-2" align="left">
                                                <a class="btn btn-sm btn-outline-red btn_add_tp" id="sm_#sessionmaster_id#" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                                                    <i class="fa-thin fa-plus fa-lg"></i>
                                                    SAVE FOR LATER
                                                </a>
                                            </div>

                                            <div class="ml-2" align="left">
                                                <button class="btn btn-sm btn-red btn_player <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                                                    <i class="fa-thin fa-circle-play fa-lg"></i>
                                                    PLAY MODULE
                                                </button>
                                            </div>

                                        </div>
                                        
                                    </div>

                                    

                                </div>    
                            </div>
                            </cfoutput>
                            
                        </div>
            
                    </div>
            <!---
                </div>
            </div> --->
            

        </div>

	</cffunction>




















    <cffunction name="get_module_row" access="remote" returnformat="plain" output="true" description="Display the EL resources">

		<cfargument name="f_id" type="numeric" required="no" default="2">
        <cfargument name="obj_id" type="numeric" required="no" default="2">
        <cfargument name="lvl_id" type="numeric" required="no">
		<cfargument name="kw_id" type="any" required="no">
		<cfargument name="read_mode" type="any" required="no">
        
        <cfset obj_translater = createobject("component", "comp.translater")>
        <cfset obj_function = createobject("component", "comp.functions")>

     
		<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
        SELECT 
        tm.module_id, CASE WHEN tm.module_name_#SESSION.LANG_CODE# IS NOT NULL AND tm.module_name_#SESSION.LANG_CODE# <> " " THEN tm.module_name_#SESSION.LANG_CODE# ELSE module_name END AS module_name,
        em.elearning_module_id,
        sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource, sm.tp_orientation_id,
        CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
        CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
        l.level_id, l.level_alias, l.level_name_#SESSION.LANG_CODE# as level_name,
        emu.elearning_user_id, emu.elearning_active
        
        FROM lms_elearning_module em
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id
        INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
        INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 
        INNER JOIN lms_tpmodulemaster2 tm on tm.module_id = sm.module_id 

        LEFT JOIN lms_level l ON l.level_id = sm.level_id

        <cfif obj_id eq "6" OR obj_id eq "1">
            <cfif kw_id neq "0">
            INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
            </cfif>
        </cfif> 


        LEFT JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1

        LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

        WHERE sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">

        <cfif not isdefined("read_mode")>
            AND elearning_module_path REGEXP '^-?[0-9]+$'
            AND sm.sessionmaster_online_el = 1
        <cfelse>
            AND ((sm.sessionmaster_online_el = 1 AND elearning_module_path REGEXP '^-?[0-9]+$') OR sm.sessionmaster_online_visio = 1)
        </cfif>

        AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
        
        <cfif lvl_id neq "0">
        AND sm.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#">
        </cfif>

        AND sm.level_id <> "3,4,5"
        
        GROUP BY sm.sessionmaster_id, em.elearning_module_id
        ORDER BY sm.module_id, em.elearning_module_id
        </cfquery>

        <cfif get_module.level_alias eq "">
            <cfset level_alias = "red">
        <cfelse>
            <cfset level_alias = get_module.level_alias>
        </cfif>
        <!--- <cfdump var="#get_module#"> --->

        <div id="accordion_module">

            <!--- <cfif isdefined("read_mode")>
                <cfdump var="#get_module#">
            </cfif> --->
            <cfoutput query="get_module" group="module_id">
            <div class="mb-3">
            
                <div class="shadow-sm rounded-bottom border border-#level_alias# m-0 w-100 bg-light">
                    
                    <div class="p-2 cursored" data-toggle="collapse" data-target="##module_group_#module_id#" aria-expanded="<!---<cfif tp_orientation_id eq "6">true<cfelse>false</cfif>--->false" aria-controls="module_group_#module_id#">
                        
                        <div class="d-flex">

                            <div>
                                <!---<cfif fileexists("#SESSION.BO_ROOT#/assets/img_module/#module_id#.jpg")>	
                                <img src="./assets/img_module/#module_id#.jpg" width="80" align="center">
                                </cfif>--->


                                <cfif tp_orientation_id eq "6">
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                <cfelse>
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                </cfif> 


                            </div>
                                
                                
                            <div class="flex-grow-1 p-2">
                                
                                <div>

                                    #obj_function.get_level_thumb(level_id,"40")#


                                    <!--- <cfif level_alias neq "">
                                        <img src="./assets/img_level/#level_alias#.svg" width="40" align="left" class="mr-2">
                                    <cfelse>
                                        <img src="./assets/img_level/B1.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/B2.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/C1.svg" width="40" align="left" class="mr-2">
                                    </cfif> --->
                                    
                                
                                    <strong class="text-#level_alias# ml-2">
                                        <cfset module_name_clear = replacenocase(module_name,"A1 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"A2 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"B1 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"B2 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"C1 - ","","ALL")>
                                        <h5 class="d-inline">#module_name_clear#</h5>
                                    </strong>
                                    
                                    <hr class="border-#level_alias# mb-1 mt-3">
                                    <!--- <span class="text-danger fw-bold float-right"><small> Dernière activité : -</small></span> --->
                                
                                </div>
                                
                            </div>

                        </div>

                    </div>

                    <div class="card-body collapse <!---<cfif tp_orientation_id eq "6">show</cfif>--->" id="module_group_#module_id#" data-parent="##accordion_module">
            
                        <cfoutput>
                        <div class="row">
                            <div class="col-md-12">
                                <!--- #module_id# --->
                            <cfinclude template="../../incl/incl_module_el_row.cfm">
                            </div>  
                        </div>
                        </cfoutput>
            
                    </div>
            
                </div>
            </div>
            </cfoutput>

        </div>

	</cffunction>









    <cffunction name="get_sessionmaster_row" access="remote" returnformat="plain" output="true" description="Display the EL resources">

		<cfargument name="f_id" type="numeric" required="no" default="2">
        <cfargument name="obj_id" type="numeric" required="no" default="2">
        <cfargument name="lvl_id" type="numeric" required="no">
		<cfargument name="kw_id" type="any" required="no">
        
        <cfset obj_translater = createobject("component", "comp.translater")>
        <cfset obj_function = createobject("component", "comp.functions")>

     
		<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
        SELECT 
        tm.module_id, CASE WHEN tm.module_name_#SESSION.LANG_CODE# IS NOT NULL AND tm.module_name_#SESSION.LANG_CODE# <> " " THEN tm.module_name_#SESSION.LANG_CODE# ELSE module_name END AS module_name,
         sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource, sm.tp_orientation_id,
        CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
        CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
        l.level_id, l.level_alias, l.level_name_#SESSION.LANG_CODE# as level_name
        
        FROM lms_tpsessionmaster2 sm
        INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
        INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 
        INNER JOIN lms_tpmodulemaster2 tm on tm.module_id = sm.module_id 

        LEFT JOIN lms_level l ON l.level_id = sm.level_id

        <cfif obj_id eq "6" OR obj_id eq "1">
            <cfif kw_id neq "0">
            INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
            </cfif>
        </cfif> 

        WHERE sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">


        AND (sm.sessionmaster_online_el = 1 OR sm.sessionmaster_online_visio = 1)


        AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
        
        <cfif lvl_id neq "0">
        AND sm.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#">
        </cfif>

        AND sm.level_id <> "3,4,5"
        
        GROUP BY sm.sessionmaster_id
        ORDER BY sm.module_id
        </cfquery>

        <cfif get_module.level_alias eq "">
            <cfset level_alias = "red">
        <cfelse>
            <cfset level_alias = get_module.level_alias>
        </cfif>
        <!--- <cfdump var="#get_module#"> --->

        <div id="accordion_module">

            <!--- <cfif isdefined("read_mode")>
                <cfdump var="#get_module#">
            </cfif> --->
            <cfoutput query="get_module" group="module_id">
            <div class="mb-3">
            
                <div class="shadow-sm rounded-bottom border border-#level_alias# m-0 w-100 bg-light">
                    
                    <div class="p-2 cursored" data-toggle="collapse" data-target="##module_group_#module_id#" aria-expanded="<!---<cfif tp_orientation_id eq "6">true<cfelse>false</cfif>--->false" aria-controls="module_group_#module_id#">
                        
                        <div class="d-flex">

                            <div>
                                <!---<cfif fileexists("#SESSION.BO_ROOT#/assets/img_module/#module_id#.jpg")>	
                                <img src="./assets/img_module/#module_id#.jpg" width="80" align="center">
                                </cfif>--->


                                <cfif tp_orientation_id eq "6">
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                <cfelse>
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="140" class="mr-2">
                                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                                        <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="140" class="mr-2">
                                    <cfelse>
                                        <img src="../assets/img/wefit_lesson.jpg" width="140" class="mr-2">
                                    </cfif>
                                </cfif> 


                            </div>
                                
                                
                            <div class="flex-grow-1 p-2">
                                
                                <div>

                                    #obj_function.get_level_thumb(level_id,"40")#


                                    <!--- <cfif level_alias neq "">
                                        <img src="./assets/img_level/#level_alias#.svg" width="40" align="left" class="mr-2">
                                    <cfelse>
                                        <img src="./assets/img_level/B1.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/B2.svg" width="40" align="left" class="mr-2">
                                        <img src="./assets/img_level/C1.svg" width="40" align="left" class="mr-2">
                                    </cfif> --->
                                    
                                
                                    <strong class="text-#level_alias# ml-2">
                                        <cfset module_name_clear = replacenocase(module_name,"A1 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"A2 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"B1 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"B2 - ","","ALL")>
                                        <cfset module_name_clear = replacenocase(module_name_clear,"C1 - ","","ALL")>
                                        <h5 class="d-inline">#module_name_clear#</h5>
                                    </strong>
                                    
                                    <hr class="border-#level_alias# mb-1 mt-3">
                                    <!--- <span class="text-danger fw-bold float-right"><small> Dernière activité : -</small></span> --->
                                
                                </div>
                                
                            </div>

                        </div>

                    </div>

                    <div class="card-body collapse <!---<cfif tp_orientation_id eq "6">show</cfif>--->" id="module_group_#module_id#" data-parent="##accordion_module">
            
                        <cfoutput>
                        <div class="row">
                            <div class="col-md-12">
                                <!--- #module_id# --->
                                <cfset elearning_user_id = 0>
                            <cfinclude template="../../incl/incl_module_el_row.cfm">
                            </div>  
                        </div>
                        </cfoutput>
            
                    </div>
            
                </div>
            </div>
            </cfoutput>

        </div>

	</cffunction>







    <cffunction name="get_module_card" access="remote" returnformat="plain" output="true" description="Display the EL resources in cards">


		<cfargument name="f_id" type="numeric" required="no" default="2">
        <cfargument name="obj_id" type="numeric" required="no" default="2">
        <cfargument name="lvl_id" type="numeric" required="no">
		<cfargument name="kw_id" type="any" required="no">

        
        <cfset obj_translater = createobject("component", "comp.translater")>
        <cfset obj_function = createobject("component", "comp.functions")>

     
		<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
            SELECT 
            tm.module_id, CASE WHEN tm.module_name_#SESSION.LANG_CODE# IS NOT NULL AND tm.module_name_#SESSION.LANG_CODE# <> " " THEN tm.module_name_#SESSION.LANG_CODE# ELSE module_name END AS module_name,
            em.elearning_module_id,
            sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource, sm.tp_orientation_id,
            CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
            CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
            l.level_id, l.level_alias, l.level_name_#SESSION.LANG_CODE# as level_name,
            emu.elearning_user_id, emu.elearning_active
            
            FROM lms_elearning_module em
            INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id
            INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
            INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 
            LEFT JOIN lms_tpmodulemaster2 tm on tm.module_id = sm.module_id 
    
            LEFT JOIN lms_level l ON l.level_id = sm.level_id
    
            <cfif obj_id eq "6" OR obj_id eq "1">
                <cfif kw_id neq "0">
                INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
                </cfif>
            </cfif>
    
            LEFT JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1
    
            LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    
            WHERE sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">
    
            <cfif not isdefined("read_mode")>
                AND elearning_module_path REGEXP '^-?[0-9]+$'
                AND sm.sessionmaster_online_el = 1
            <cfelse>
                AND ((sm.sessionmaster_online_el = 1 AND elearning_module_path REGEXP '^-?[0-9]+$') OR sm.sessionmaster_online_visio = 1)
            </cfif>
    
            AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
            
            <cfif lvl_id neq "0">
            AND sm.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#">
            </cfif>
    
            AND sm.level_id <> "3,4,5"
            
            GROUP BY em.elearning_module_id, sm.sessionmaster_id
            ORDER BY sm.module_id, em.elearning_module_id
            </cfquery>

        <cfif get_module.level_alias eq "">
            <cfset level_alias = "red">
        <cfelse>
            <cfset level_alias = get_module.level_alias>
        </cfif>
<!--- <cfdump var="#get_module#"> --->

            
        <div class="mt-3">
            
            <div class="row">

                <cfoutput query="get_module">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                    <cfinclude template="../../incl/incl_module_el_card.cfm">
                    </div>  
                </cfoutput>
            
            </div>
        
        </div>


	</cffunction>



</cfcomponent>