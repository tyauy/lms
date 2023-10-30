<cfoutput>

<cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
SELECT kw.keyword_name_#SESSION.LANG_CODE# as keyword_name, kw.keyword_id 
FROM lms_sessionmaster_keywordid_cor skc
INNER JOIN lms_keyword kw ON kw.keyword_id = skc.keyword_id
WHERE skc.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND kw.keyword_cat_id = 3
ORDER BY keyword_name ASC
</cfquery>

<div class="container_resource card rounded border <cfif elearning_user_id neq "">border-#level_alias#</cfif> shadow-sm" id="container_#sessionmaster_id#">
    <cfif elearning_user_id neq "">
        <div class="triangle triangle_#level_alias#"></div>
        <i class="fa-sharp fa-light fa-check text-white triangle_check"></i>
    </cfif>
    <div class="card-body">
        
        <cfif tp_orientation_id eq "6">
            <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="80" align="left" class="mr-2">
            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="80" align="left" class="mr-2">
            <cfelse>
                <img src="../assets/img/wefit_lesson.jpg" width="80" align="left" class="mr-2">
            </cfif>
        <cfelse>
            <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="80" align="left" class="mr-2">
            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="80" align="left" class="mr-2">
            <cfelse>
                <img src="../assets/img/wefit_lesson.jpg" width="80" align="left" class="mr-2">
            </cfif>
        </cfif>

        <h6 class="m-0">
            
            <!---<img src="../assets/img_formation/2.png" width="30">
            #obj_function.get_level_thumb(sm_level_id,"30")#--->
            #sessionmaster_name#<br>
            <cfif not isdefined("read_mode")>
                <span class="badge badge-pill bg-white border border-#level_alias# text-#level_alias# px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#level_alias# - #level_name#</span>
            </cfif>
    
            
        </h6>

        <cfif tp_orientation_id eq "6">
            <small class="text-red">#sessionmaster_video_duration#<cfif sessionmaster_grammar neq ""> | #sessionmaster_grammar#</cfif><cfif sessionmaster_objectives neq ""> | #sessionmaster_objectives#</cfif></small>
        </cfif>

        <p class="mt-2 mb-1">
            <cfif not isdefined("read_mode")>
                <small> #mid(sessionmaster_description,1,200)# [...]</small>
            <cfelse>
                <small> #sessionmaster_description#</small>
            </cfif>
        </p>



        <!--- FOR DISPLAYING EL TOOLS OR JUST READ ONLY SYLLABUS ---->
        <cfif not isdefined("read_mode")>
        <div class="d-flex justify-content-between">

            <div>
                <cfloop query="get_kw">
                    <span class="badge badge-pill bg-white border border-dark p-1 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                </cfloop>
            </div>

            <div>

                <cfif elearning_user_id neq "">
                    <div class="ml-2 float-left">
                        <a class="btn btn-sm btn-#level_alias# btn_add_tp" id="module_#elearning_module_id#" data-status="up" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-floppy-disk fa-lg"></i>
                            #obj_translater.get_translate('btn_tp_added')#
                        </a>
                    </div>
                <cfelse>
                    <div class="ml-2 float-left">
                        <a class="btn btn-sm btn-outline-#level_alias# btn_add_tp" id="module_#elearning_module_id#" data-status="in" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-floppy-disk fa-lg"></i>
                            #obj_translater.get_translate('btn_tp_add')#
                        </a>
                    </div>
                </cfif>
                

                <div class="ml-2 float-left" align="left">
                    <cfif tp_orientation_id neq "6">
                        <a class="btn btn-sm btn-#level_alias#" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            PLAY NOW
                        </a>
                    <cfelse>
                        <button class="btn btn-sm btn-#level_alias# btn_player <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            PLAY NOW
                        </button>
                    </cfif>
                </div>

            </div>

        </div>
        </cfif>

    </div>   

    

</div>
</cfoutput>