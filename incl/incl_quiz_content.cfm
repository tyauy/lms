<cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
</cfquery>

<cfoutput>
<div class="col-md-6">
        
    <div class="card border bg-light mt-3">
    
        <div class="card-body">

            <div class="media">

                <img src="./assets/img/logo_toeic.jpg" width="120" class="mr-2">
                <div class="media-body">
                    <!--- #quiz_id# #quiz_name# --->
                    <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-info">#obj_translater.get_translate('btn_all_level')#<span></h6>
                    <small>#quiz_description#</small>
                    
                    <div class="clearfix"></div>
                    <div class="float-right">
                    

                        <cfif get_result.recordcount eq "0">
                        
                            <button class="btn btn-sm btn-outline-info btn_start_quiz" id="q_#quiz_id#">#obj_translater.get_translate('btn_go_test')#</button>
                            
                        <cfelse>
                            <!--- <a href="##" class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_reading.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                    
                            <cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq ""> --->
                                <a href="##" class="btn btn-sm btn-outline-info btn_view_quiz" id="quserto_#get_result.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                            <!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
                                <a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
                            <!--- </cfif> --->
                    
                        </cfif>	


                        
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</cfoutput>