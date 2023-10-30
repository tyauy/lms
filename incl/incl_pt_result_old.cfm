<cfif get_pt.recordcount neq "0">

    <cfoutput>	
        
        <cfif get_pt.pt_speed eq "fpt">

            <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#u_id#",quiz_user_group_id="#get_pt.quiz_user_group_id#",quiz_user_id="")>
            <cfset get_quiz_score = obj_query.oget_quiz_score(quiz_type="#quiz_type#")>
<!--- <cfdump var="#get_quiz_score#"> --->
            <cfif get_result_detail_pt.score neq "">																				
                <cfset temp = round((get_result_detail_pt.score*15)/get_quiz_score.quiz_score)>
                <!--- <cfdump var="#temp#"> --->
                <cfif temp gt 0 AND temp lte 15>
                    <cfset sub_level = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
                    <cfif findnocase("A1",sub_level)>
                        <cfset css = "success">
                    <cfelseif findnocase("A2",sub_level)>
                        <cfset css = "primary">
                    <cfelseif findnocase("B1",sub_level)>
                        <cfset css = "info">
                    <cfelseif findnocase("B2",sub_level)>
                        <cfset css = "warning">
                    <cfelseif findnocase("C1",sub_level)>
                        <cfset css = "danger">
                    </cfif>	
                    <a id="fpt_#get_pt.quiz_user_group_id#_#get_pt.quiz_user_id#_#u_id#" class="badge badge-pill badge-#css# p-3 mt-2 font-weight-normal btn_view_qpt cursored text-white" style="font-size:14px">
                        #obj_translater.get_translate('btn_global_level')#
                        <h6 class="mt-1 mb-0">#sub_level#</h6> 
                        <!---[#get_result_detail_pt.score#/100] [#temp#/15] --->
                    </a>
                </cfif>
            </cfif>

            <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#u_id#",quiz_user_group_id="#get_pt.quiz_user_group_id#",skill_category="grammar",quiz_user_id="")>
            <cfset get_quiz_score = obj_query.oget_quiz_score(quiz_type="#quiz_type#",skill_category="grammar")>
            
<!--- <cfdump var="#get_quiz_score#"> --->
            <cfif get_result_detail_pt.score neq "">																				
                <cfset temp = round((get_result_detail_pt.score*15)/get_quiz_score.quiz_score)>
                <cfif temp gt 0 AND temp lte 15>
                    <cfset sub_level = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
                    <cfif findnocase("A1",sub_level)>
                        <cfset css = "success">
                    <cfelseif findnocase("A2",sub_level)>
                        <cfset css = "primary">
                    <cfelseif findnocase("B1",sub_level)>
                        <cfset css = "info">
                    <cfelseif findnocase("B2",sub_level)>
                        <cfset css = "warning">
                    <cfelseif findnocase("C1",sub_level)>
                        <cfset css = "danger">
                    </cfif>	
                    <span id="fpt_#get_pt.quiz_user_group_id#_#get_pt.quiz_user_id#_#u_id#" class="badge badge-pill border border-#css# py-2 px-3 font-weight-normal text-#css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_grammar")#">
                        <!--- <i class="fal fa-spell-check"></i>  --->
                        #obj_translater.get_translate('btn_grammar')#
                        <h6 class="mt-1 mb-0">#sub_level#</h6>
                        <!---[#get_result_detail_pt.score#/100] [#temp#/15] --->
                    </span>
                </cfif>
            </cfif>

            <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#u_id#",quiz_user_group_id="#get_pt.quiz_user_group_id#",skill_category="listening",quiz_user_id="")>
            <cfset get_quiz_score = obj_query.oget_quiz_score(quiz_type="#quiz_type#",skill_category="listening")>
<!--- <cfdump var="#get_quiz_score#"> --->
            <cfif get_result_detail_pt.score neq "">
                <cfset temp = round((get_result_detail_pt.score*15)/get_quiz_score.quiz_score)>
                <cfif temp gt 0 AND temp lte 15>
                    <cfset sub_level = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
                    <cfif findnocase("A1",sub_level)>
                        <cfset css = "success">
                    <cfelseif findnocase("A2",sub_level)>
                        <cfset css = "primary">
                    <cfelseif findnocase("B1",sub_level)>
                        <cfset css = "info">
                    <cfelseif findnocase("B2",sub_level)>
                        <cfset css = "warning">
                    <cfelseif findnocase("C1",sub_level)>
                        <cfset css = "danger">
                    </cfif>	
                    <span id="fpt_#get_pt.quiz_user_group_id#_#get_pt.quiz_user_id#_#u_id#" class="badge badge-pill border border-#css# py-2 px-3 font-weight-normal text-#css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_listening")#">
                        <!--- <i class="fal fa-head-side-headphones fa-lg" aria-hidden="true"></i>  --->
                        #obj_translater.get_translate('btn_listening')#
                        <h6 class="mt-1 mb-0">#sub_level#</h6>
                        <!---[#get_result_detail_pt.score#/100] [#temp#/15] --->
                    </span>
                </cfif>
            </cfif>

            <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#u_id#",quiz_user_group_id="#get_pt.quiz_user_group_id#",skill_category="reading",quiz_user_id="")>
            <cfset get_quiz_score = obj_query.oget_quiz_score(quiz_type="#quiz_type#",skill_category="reading")>
<!--- <cfdump var="#get_quiz_score#"> --->
            <cfif get_result_detail_pt.score neq "">
                <cfset temp = round((get_result_detail_pt.score*15)/get_quiz_score.quiz_score)>
                <cfif temp gt 0 AND temp lte 15>
                    <cfset sub_level = replace(listgetat(SESSION.LIST_SUBLEVEL,temp),"_",".","ALL")>
                    <cfif findnocase("A1",sub_level)>
                        <cfset css = "success">
                    <cfelseif findnocase("A2",sub_level)>
                        <cfset css = "primary">
                    <cfelseif findnocase("B1",sub_level)>
                        <cfset css = "info">
                    <cfelseif findnocase("B2",sub_level)>
                        <cfset css = "warning">
                    <cfelseif findnocase("C1",sub_level)>
                        <cfset css = "danger">
                    </cfif>	
                    <span id="fpt_#get_pt.quiz_user_group_id#_#get_pt.quiz_user_id#_#u_id#" class="badge badge-pill border border-#css# py-2 px-3 font-weight-normal text-#css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_reading")#">
                        <!--- <i class="fal fa-books fa-lg" aria-hidden="true"></i>  --->
                        #obj_translater.get_translate('btn_reading')#
                        <h6 class="mt-1 mb-0">#sub_level#</h6>
                        <!---[#get_result_detail_pt.score#/100] [#temp#/15] --->	
                    </span>
                </cfif>	
            </cfif>	

        <cfelse>

            <cfset get_result_global_pt = obj_query.oget_result_global_pt(u_id="#u_id#",quiz_user_group_id="#get_pt.quiz_user_group_id#")>
                
            <a id="fpt_#quiz_user_group_id#_#get_pt.quiz_user_id#_#u_id#" class="badge badge-pill badge-#get_result_global_pt.level_css# p-3 mt-2 font-weight-normal btn_view_qpt cursored text-white" style="font-size:14px">
                #obj_translater.get_translate('btn_global_level')#
                <h6 class="mt-1 mb-0">#get_result_global_pt.level_alias#</h6>
            </a>
            
        </cfif>
        
    <!---<a href="_AD_learner_skill.cfm?t_id=#t_id#&u_id=#u_id#" class="badge badge-pill bg-white border p-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-comments fa-lg" aria-hidden="true"></i></a> --->
    <!---<a href="_AD_learner_skill.cfm?t_id=#t_id#&u_id=#u_id#" class="badge badge-pill bg-white border p-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-edit fa-lg" aria-hidden="true"></i></a> --->
    
    </cfoutput>
    
<cfelse>
        
        <!--- <cfset start_quiz = obj_query.oget_first_pt(quiz_type="qpt_#lang_select#")> --->
        
        <cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">
            <!---<cfoutput><a href="./quiz.cfm?new_quiz=1&quiz_id=#start_quiz#&pt_type=#pt_type#&pt_speed=qpt" class="btn btn btn-success">QUICK PLACEMENT TEST</a></cfoutput>--->
            <cfif isdefined("pt_type") AND (isdefined("t_id") AND t_id neq "")>
                <cfoutput><button class="btn btn btn-success btn_pass_fpt_#pt_type#" <cfif pt_type eq "end" AND isdefined("tp_remain_go") AND tp_remain_go gt 0.5>disabled</cfif>>#uCase(obj_translater.get_translate('text_full_placement_test'))#</button></cfoutput>
            <cfelse>
                <cfoutput><button class="btn btn btn-success btn_pass_fpt">#uCase(obj_translater.get_translate('text_full_placement_test'))#</button></cfoutput>
            </cfif>
        </cfif>

</cfif>
