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

<div class="container_resource card rounded border <cfif elearning_user_id neq "">border-red</cfif> shadow-sm" id="container_#sessionmaster_id#" style="min-height:200px">
    <cfif elearning_user_id neq "">
        <div class="triangle triangle_red"></div>
        <i class="fa-sharp fa-light fa-check text-white triangle_check"></i>
    </cfif>

    <cfif tp_orientation_id eq "6">
        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
            <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="80" align="left" class="mr-2 card-img-top">
        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
            <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="80" align="left" class="mr-2 card-img-top">
        <cfelse>
            <img src="../assets/img/wefit_lesson.jpg" width="80" align="left" class="mr-2 card-img-top">
        </cfif>
    <cfelse>
        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
            <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="80" align="left" class="mr-2 card-img-top">
        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
            <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="80" align="left" class="mr-2 card-img-top">
        <cfelse>
            <img src="../assets/img/wefit_lesson.jpg" width="80" align="left" class="mr-2 card-img-top">
        </cfif>
    </cfif>

    <div class="card-body">

        <h6 class="m-0" style="text-transform:none !important">
            #sessionmaster_name#
        </h6>

        <cfif not isdefined("read_mode")>
            <span class="badge badge-pill bg-white border border-#level_alias# text-#level_alias# px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#level_alias# - #level_name#</span>
        </cfif>

    </div>   

    <cfif not isdefined("read_mode")>
    <div class="card-footer bg-light border-top" align="right">
        <div class="d-flex justify-content-end align-items-end">
            <a class="btn-link text-red" data-toggle="tooltip" data-placement="top" title="#sessionmaster_description#">[details]</a>

                <cfif elearning_user_id neq "">
                    <div class="ml-2" align="left">
                        <a class="btn btn-sm btn-red btn_add_tp" id="module_#elearning_module_id#" data-status="up" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-floppy-disk fa-lg"></i>
                            <!--- #obj_translater.get_translate('btn_tp_added')# --->
                        </a>
                    </div>
                <cfelse>
                    <div class="ml-2" align="left">
                        <a class="btn btn-sm btn-outline-red btn_add_tp" id="module_#elearning_module_id#" data-status="in" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el">
                            <i class="fa-thin fa-floppy-disk fa-lg"></i>
                            <!--- #obj_translater.get_translate('btn_tp_add')# --->
                        </a>
                    </div>
                </cfif>
                

                <div class="ml-2" align="left">
                    <cfif tp_orientation_id neq "6">
                        <a class="btn btn-sm btn-red" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            
                        </a>
                    <cfelse>
                        <button class="btn btn-sm btn-red btn_player <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                            <i class="fa-thin fa-circle-play fa-lg"></i>
                            
                        </button>
                    </cfif>
                </div>

        </div>
        
    </div>
    </cfif>

    

</div>
</cfoutput>


<script>
    $(document).ready(function() {
        
        $('[data-toggle="tooltip"]').tooltip();

    })

</script>