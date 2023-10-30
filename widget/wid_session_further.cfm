<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>

<!--- <cfquery name="get_session_elearning" datasource="#SESSION.BDDSOURCE#">
    SELECT es.elearning_session_id, es.elearning_session_name, es.elearning_session_creation_date,
    e.elearning_id, e.module_path, e.module_name, e.module_difficulty,
    sm.sessionmaster_name, sm.sessionmaster_id,
    tm.module_name_#SESSION.LANG_CODE# as _module_name, 
    tm.module_description_#SESSION.LANG_CODE# as _module_description, 
    tm.module_level, tm.module_id,
    l.level_alias, l.level_css,
    eu.update_date, eu.elearning_completion
    FROM lms_elearning_session es
    INNER JOIN lms_elearning_session_user esu ON esu.elearning_session_id = es.elearning_session_id
    LEFT JOIN lms_elearning_cor ec ON ec.elearning_session_id = es.elearning_session_id
    LEFT JOIN lms_elearning e ON e.elearning_id = ec.elearning_id
    LEFT JOIN lms_elearning_session_cor esc ON esc.elearning_session_id = es.elearning_session_id
    LEFT JOIN lms_elearning_user eu ON eu.elearning_id = e.elearning_id AND eu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = esc.sessionmaster_id	
    LEFT JOIN lms_tpmodulemaster2 tm ON tm.module_id = sm.module_id 
    LEFT JOIN lms_level l ON l.level_id = es.elearning_session_level
    WHERE esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    AND esu.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
    AND esu.active = 1
</cfquery> --->

<cfquery name="get_session_elearning" datasource="#SESSION.BDDSOURCE#">
    SELECT em.elearning_module_id, em.elearning_module_path,
    sm.sessionmaster_name, sm.sessionmaster_id,
    tm.module_name_#SESSION.LANG_CODE# as _module_name, 
    tm.module_description_#SESSION.LANG_CODE# as _module_description, 
    tm.module_level, tm.module_id,
    eu.update_date, eu.elearning_completion
    FROM lms_elearning_module em
    INNER JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.active = 1 AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id	
    LEFT JOIN lms_tpmodulemaster2 tm ON tm.module_id = sm.module_id 
    LEFT JOIN lms_elearning_module_user eu ON eu.elearning_module_id = em.elearning_module_id AND eu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    WHERE esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    AND esu.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
    AND esu.active = 1
</cfquery>


<div class="col-md-12 col-sm-12">
                    
        <div class="card border">
            <div class="card-body">
                <!--- <div class="d-flex">

                    <div class="w-100 ml-2">

                        <h5 class="d-inline"> Modules</h5>
                    
                    </div>
                </div> --->
                <div class="row mt-2">
                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <cfoutput query="get_session_elearning">

                            <cfif elearning_module_id neq "">
                            <div class="row mt-2">

                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    
                                    <!--- <cfloop from="1" to="2" index="cor"> --->
                                    <div class="border-top p-2">

                                        <div class="float-left">       
                                            <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="120" class="mr-2">
                                        </div>   

                                        <div class="float-left">    
                                            #sessionmaster_name#
                                            
                                            <cfif update_date neq "">
                                                <br>
                                                <span class="text-danger fw-bold float-right"><small> Dernière activité : #update_date#</small></span>
                                                <br>
                                                <span class="text-danger fw-bold float-right"><small> Completion : #elearning_completion# %</small></span>
                                            </cfif>
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
            </div>
        </div>
</div>

<cfoutput>
    <a href="_AD_elearning_dashboard.cfm" class="btn btn-outline-info p-2 btn-block">
        #obj_translater.get_translate('btn_more_info')#<br><i class="fal fa-book-alt fa-2x mt-2"></i>
    </a>
</cfoutput>

<cfoutput query="get_session">
                        
    <div class="border-success p-2 h-100">
        <h6 class="text-success">#obj_translater.get_translate('modal_support_quiz')#</h6>
        
        <cfif quiz_id neq "" AND quiz_id neq "0">
            <cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
            SELECT * FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.sessionmaster_id#">
            </cfquery>
            <table class="table table-borderless table-sm">
            <cfloop query="get_quiz">
                <tr>
                    <td>
                        <a href="##" class="text-success">#quiz_name#</a>
                    </td>
                    <td>
                <cfquery name="get_result_exercice" datasource="#SESSION.BDDSOURCE#">
                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.quiz_id#">
                </cfquery>
                <cfif get_result_exercice.recordcount eq "0">																			
                    <a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-success" title="#obj_translater.get_translate('btn_go_test')#"><i class="fas fa-play"></i></a>
                <cfelse>
                    <a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz" title="#obj_translater.get_translate('btn_start_again')#"><i class="fas fa-sync-alt"></i></a>																
                    <cfif get_result_exercice.recordcount neq "0" AND get_result_exercice.quiz_user_end neq "">
                        <a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_exercice.quiz_user_id#" title="#obj_translater.get_translate('btn_results_test')#"><i class="fas fa-tasks"></i> </a>
                    </cfif>																		
                </cfif>
                    </td>
                </tr>
            </cfloop>
            </table>
        <cfelse>
        <span class="text-success"><em><small>#obj_translater.get_translate('alert_no_quiz')#</small></em></span>
        </cfif>
        
    </div>
</cfoutput>