<cfparam name="pt_type" default="">
<cfparam name="vc_test" default="0">
<cfif isdefined("SESSION.TP_ID")>
    <cfset t_id = SESSION.TP_ID>
<cfelse>
    <cfset t_id = "">
</cfif>

<!------------ WANT TO PASS FULL PT ----->
<cfif choice eq "fpt">

    <div class="row">
        <div class="col-md-12 mt-3">
            <cfoutput>
            <div class="media">
                <img class="mr-3 img_rounded" src="./assets/img/qpt_#f_code#.jpg" width="200">
                <div class="media-body">
                    <h5 class="mt-0"><cfoutput>#obj_translater.get_translate('js_modal_title_pt')#</cfoutput></h5>
                    
                    <!--- <cfif vc_test neq "0">
                    #obj_translater.get_translate_complex('start_qpt_vc_warning')#
                    </cfif> --->
                    
                    #obj_translater.get_translate_complex('start_qpt_progress')#
                </div>
            </div>

            <br>

            <div align="center" class="mt-3">			
                <cfset get_distinct_pt = obj_query.oget_distinct_pt(u_id="#SESSION.USER_ID#",t_id="#t_id#",quiz_type="qpt_#f_code#",pt_type="#pt_type#",pt_speed="fpt")>
                <cfset start_quiz = obj_query.oget_first_pt(quiz_type="qpt_#f_code#")>
                
                <!--- <cfdump var="#get_distinct_pt#"> --->
                <cfif get_distinct_pt.recordcount eq "0">
                    <cfoutput>
                    <form action="quiz.cfm" method="post">
                        <cfif isdefined("SESSION.TP_ID")>
                            <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                        </cfif>
                        <input type="hidden" name="pt_speed" value="fpt">
                        <input type="hidden" name="pt_type" value="#pt_type#">
                        <input type="hidden" name="quiz_id" value="#start_quiz#">
                        <input type="hidden" name="new_quiz" value="1">
                        <button type="submit" class="btn btn-lg btn-info">#obj_translater.get_translate('btn_go_test')# <i class="fad fa-arrow-right"></i></button>
                    </form>
                    </cfoutput>
                </cfif>
            
            </div>	
            </cfoutput>
        </div>			
    </div>


<!------------ WANT TO PASS QUICK PT ----->
<cfelseif choice eq "qpt">

    <cfset get_qpt_all = obj_query.oget_qpt_all(quiz_type="qpt_#f_code#")>
        
    <div class="row">
        <div class="col-md-12 mt-3">
            
            <cfoutput>
            <div class="alert bg-light text-dark border" role="alert">
                <div class="media">
                    <img src="./assets/img/qpt_#f_code#.jpg" class="mr-4" align="left" width="190">
                    <div class="media-body">
                    #obj_translater.get_translate_complex('start_qpt_subtitle')#
                    </div>
                </div>	
            </div>
            </cfoutput>

            <div class="mt-3">			
                
                <!---<h5 align="center">Vous avez une idée de votre niveau ?</h5>
                    
                Validez votre niveau en choisissant le test associé. En fonction de votre score, vous aurez la possibilité les tests de niveau supérieur ou inférieur.<br><br>
                --->
                <div class="card-deck btn-group-toggle m-0" data-toggle="buttons">
                    <cfoutput query="get_qpt_all">
                        <cfset get_pt = obj_query.oget_pt(u_id="#SESSION.USER_ID#",quiz_type="#quiz_type#",t_id="#t_id#",level_id="#level_id#")>
					
                        <label class="btn btn-lg btn-outline-#level_css# card p-2 ml-0 mr-2 my-2 cursored select_quiz" style="white-space:normal">
                            <input type="radio" name="level_id" class="level_id" value="#level_id#" autocomplete="off">		
                            <h4><span class="badge badge-pill badge-#level_css# border border-light">#quiz_alias#</span></h4>
                            <div class="card-body px-1">
                                #level_name#
                                <br><br>

                                <cfif get_pt.recordcount neq "0">
                                    <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#SESSION.USER_ID#",quiz_user_id="#get_pt.quiz_user_id#")>
                                    <!---#get_result_detail_pt.score# / 20--->
                                    <cfif get_result_detail_pt.score lte "5">
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                        <i class="fas fa-lg fa-star text-secondary"></i>
                                        <i class="fas fa-lg fa-star text-secondary"></i>
                                    <cfelseif get_result_detail_pt.score gt "5" AND get_result_detail_pt.score lte "15">
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                        <i class="fas fa-lg fa-star text-secondary"></i>
                                    <cfelseif get_result_detail_pt.score gt "15">
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                        <i class="fas fa-lg fa-star text-warning"></i>
                                    </cfif>
                                </cfif>
                                
                            </div>
                        </label>
                    </cfoutput>
                </div>

                <cfoutput query="get_qpt_all">
                    <cfset get_pt = obj_query.oget_pt(u_id="#SESSION.USER_ID#",quiz_type="#quiz_type#",t_id="#t_id#",level_id="#level_id#")>
						
                    <div id="explain_#level_id#" class="explain_quiz collapse p-3 border border-#level_css#">
                        <h5 class="text-#level_css#">#quiz_name#</h5>
                        <br>
                        <cfif get_pt.recordcount neq "0">
                            <cfset get_result_detail_pt = obj_query.oget_result_detail_pt(u_id="#SESSION.USER_ID#",quiz_user_id="#get_pt.quiz_user_id#")>
                            <!---#get_result_detail_pt.score# / 20--->
                        </cfif>
                        #level_desc#
                        <cfif get_pt.recordcount eq "0">
                        <!---<div align="center">
                            <form action="quiz.cfm" method="post">
                                <cfif isdefined("SESSION.TP_ID")>
                                    <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                                </cfif>
                                <input type="hidden" name="pt_speed" value="qpt">
                                <input type="hidden" name="pt_type" value="start">
                                <input type="hidden" name="quiz_id" value="#quiz_id#">
                                <input type="hidden" name="new_quiz" value="1">
                                <button type="submit" class="btn btn-lg btn-#level_css#">#obj_translater.get_translate('btn_go_test')# #quiz_alias# <i class="fal fa-arrow-right"></i></button>
                            </form>
                        </div>--->
                         </cfif>
                    </div>
                </cfoutput>
            
            </div>				
            
        </div>			
    </div>
    <script>
    $(document).ready(function() {
    
        $('.select_quiz').change(function() {
            event.preventDefault();
            var test = $("input[class='level_id']:checked").val();
            $(".explain_quiz").hide();
            $('#explain_'+test).show();
        });

    });
    </script>
</cfif>