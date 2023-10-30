<cfoutput>

<cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
SELECT kw.keyword_name_#SESSION.LANG_CODE# as keyword_name, kw.keyword_id 
FROM lms_sessionmaster_keywordid_cor skc
INNER JOIN lms_keyword kw ON kw.keyword_id = skc.keyword_id
WHERE skc.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">
ORDER BY keyword_name ASC
</cfquery>
    
<cfif level_alias eq "">
    <cfset level_css = "red">
<cfelse>
    <cfset level_css = level_alias>
</cfif>

<div class="container_resource card rounded border <cfif elearning_user_id neq "">border-#level_css#</cfif> shadow-sm" id="container_#sessionmaster_id#">
    <cfif elearning_user_id neq "">
        <div class="triangle triangle_#level_css#">
    </div>
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
            <!---#sessionmaster_id# - --->#sessionmaster_name#
        </h6>

        <cfif tp_orientation_id eq "6">
            <small class="text-red">#sessionmaster_video_duration#<cfif sessionmaster_grammar neq ""> | #sessionmaster_grammar#</cfif><cfif sessionmaster_objectives neq ""> | #sessionmaster_objectives#</cfif></small>
        </cfif>

        <p class="mt-2 mb-1">
            <small> #mid(sessionmaster_description,1,200)# [...]</small>
        </p>

        <img src="../assets/img_formation/2.png" width="30">

        <!--- level_id >> #level_id# --->
        #obj_function.get_level_thumb(sm_level_id,"30")#

        <!--- <cfif tp_orientation_id eq "6">
            <img src="./assets/img_level/B1.svg" width="30" align="left" class="mr-1 mt-2">
            <img src="./assets/img_level/B2.svg" width="30" align="left" class="mr-1 mt-2">
            <img src="./assets/img_level/C1.svg" width="30" align="left" class="mr-1 mt-2">
        <cfelse>
            <img src="../assets/img_level/#level_alias#.svg" width="30">
        </cfif> --->
        <cfloop query="get_kw">
            <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
        </cfloop>

        <!--- <p class="mt-2">
            <small> #sessionmaster_description#</small>
        </p> --->
    </div>   
    <div class="card-footer bg-light border-top" align="right">
        <div class="d-flex justify-content-end align-items-end">


                <!--- <div align="center">
                    <img src="./assets/img_formation/2.png" width="40" class="border_thumb mt-1"> 
                </div> --->
                <cfif elearning_user_id neq "">
                    <div class="ml-2" align="left">
                        <a class="btn btn-sm btn-#level_css# btn_add_tp" id="module_#elearning_module_id#" data-status="up" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-check fa-lg"></i>
                            #obj_translater.get_translate('btn_tp_added')#
                        </a>
                    </div>
                <cfelse>
                    <div class="ml-2" align="left">
                        <a class="btn btn-sm btn-outline-#level_css# btn_add_tp" id="module_#elearning_module_id#" data-status="in" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-plus fa-lg"></i>
                            #obj_translater.get_translate('btn_tp_add')#
                        </a>
                    </div>
                </cfif>
                

                <div class="ml-2" align="left">
                    <cfif tp_orientation_id neq "6">
                        <a class="btn btn-sm btn-#level_css#" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            QUICK PLAY
                        </a>
                    <cfelse>
                        <button class="btn btn-sm btn-#level_css# btn_player <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            QUICK PLAY
                        </button>
                    </cfif>
                </div>

        </div>
        
    </div>

    

</div>
</cfoutput>