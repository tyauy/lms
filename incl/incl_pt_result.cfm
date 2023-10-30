<cfif get_pt.recordcount neq "0">

    <cfif isDefined("get_pt.quiz_global_level")>
        <cfoutput>

            <a id="fpt_#get_pt.quiz_user_group_id#" class="badge badge-pill badge-#get_pt.quiz_global_css# p-3 mt-2 font-weight-normal btn_view_qpt cursored text-white" style="font-size:14px">
                #obj_translater.get_translate('btn_global_level')#
                <h6 class="mt-1 mb-0">#get_pt.quiz_global_level#</h6> 
            </a>
            <span id="fpt_#get_pt.quiz_user_group_id#" class="badge badge-pill border border-#get_pt.quiz_grammar_css# py-2 px-3 font-weight-normal text-#get_pt.quiz_grammar_css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_grammar")#">
                #obj_translater.get_translate('btn_grammar')#
                <h6 class="mt-1 mb-0">#get_pt.quiz_grammar_level#</h6> 
            </span>
            <span id="fpt_#get_pt.quiz_user_group_id#" class="badge badge-pill border border-#get_pt.quiz_listening_css# py-2 px-3 font-weight-normal text-#get_pt.quiz_listening_css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_listening")#">
                #obj_translater.get_translate('btn_listening')#
                <h6 class="mt-1 mb-0">#get_pt.quiz_listening_level#</h6> 
            </span>
            <span id="fpt_#get_pt.quiz_user_group_id#" class="badge badge-pill border border-#get_pt.quiz_reading_css# py-2 px-3 font-weight-normal text-#get_pt.quiz_reading_css#" style="font-size:12px;min-width:80px" data-toggle="tooltip" title="#obj_translater.get_translate("tooltip_skill_reading")#">
                #obj_translater.get_translate('btn_reading')#
                <h6 class="mt-1 mb-0">#get_pt.quiz_reading_level#</h6> 
            </span>
    
        </cfoutput>
    </cfif>
    
    
<cfelse>
                
        <cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">
            <!---<cfoutput><a href="./quiz.cfm?new_quiz=1&quiz_id=#start_quiz#&pt_type=#pt_type#&pt_speed=qpt" class="btn btn btn-success">QUICK PLACEMENT TEST</a></cfoutput>--->
            <cfif isdefined("pt_type") AND (isdefined("t_id") AND t_id neq "")>
                <cfoutput><button class="btn btn btn-success btn_pass_fpt_#pt_type#" <cfif pt_type eq "end" AND isdefined("tp_remain_go") AND tp_remain_go gt 0.5>disabled</cfif>>#uCase(obj_translater.get_translate('text_full_placement_test'))#</button></cfoutput>
            <cfelse>
                <cfoutput><button class="btn btn btn-success btn_pass_fpt">#uCase(obj_translater.get_translate('text_full_placement_test'))#</button></cfoutput>
            </cfif>
        </cfif>

</cfif>