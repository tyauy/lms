




<cfoutput query="get_session">
                        
<div class="row">
    <div class="col-md-6 mt-4">
        <div class="border-top border-info p-2 h-100">
            <h6 class="text-info">#obj_translater.get_translate('modal_supports')#</h6>
            <cfset material_exists = 0>
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
                <cfset material_exists = 1>
                <a href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
            </cfif>
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                <cfset material_exists = 1>
                <a href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_wsk')#</a><br>
            </cfif>	
            <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx")>
                <cfset material_exists = 1>
                <a href="./assets/materials/#sessionmaster_ressource#_WS.pptx" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
            </cfif>
            </cfif>
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.ppt")>
                <cfset material_exists = 1>
                <a href="./assets/materials/#sessionmaster_ressource#_WS.ppt" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
            </cfif>

            <!--- CUSTOM PJ DISPLAY --->
            <cfif isDefined("t_id")>
                <cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	
                <cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
                    
                <cfif dirQuery.recordcount GT 0>
                    <table class="table table-sm table-bordered" id="file_holder">

                        <cfoutput>
                        <cfloop query="dirQuery">
                        <tr id="file_#dirQuery.currentRow#">
                            <td colspan="2">
                            <a href="./assets/lessons/#t_id#/#s_id#/#name#" target="_blank">
                                <span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 40ch;">#name#</span>
                            </a>
                        </td>
                        </tr>
                            
                        </cfloop>
                        </cfoutput>

                        <cfset material_exists = 1>
                    </table>
                </cfif>

            </cfif>

            <cfif material_exists eq "0">
                <span class="text-info"><em><small>#obj_translater.get_translate('alert_no_support')#</small></em></span>
            </cfif>

        </div>
    </div>
    <div class="col-md-6 mt-4">
        <div class="border-top border-warning p-2 h-100">
            <h6 class="text-warning">#obj_translater.get_translate('modal_support_video')#</h6>
            <cfloop from="1" to="5" index="cor">
                <cfif FileExists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
                    <cfset video = "1">
                    <a href="./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4" class="text-warning" target="_blank"><i class="fas fa-video"></i> #obj_translater.get_translate('modal_link_video')# #cor#</a><br>
                </cfif>
            </cfloop>
            <cfif not isdefined("video")>
            <span class="text-warning"><em><small>#obj_translater.get_translate('alert_no_video')#</small></em></span>
            </cfif>
        </div>
    </div>
    <!--- // TODO REMOVE WHEN LESSON NOTE 2.0 IS ONLINE --->
    <div class="col-md-6 mt-4">
        <div class="border-top border-success p-2 h-100">
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
    </div>
    <div class="col-md-6 mt-4">
        <div class="border-top border-danger p-2 h-100">
            <h6 class="text-danger">#obj_translater.get_translate('modal_support_audio')#</h6>
            <cfloop from="1" to="5" index="cor">
                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
                    <cfset audio = "1">
                    <a href="./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" class="text-danger" target="_blank"><i class="fas fa-volume-up"></i> #obj_translater.get_translate('modal_link_audio')# #cor#</a><br>
                </cfif>
            </cfloop>
            <cfif not isdefined("audio")>
            <span class="text-danger"><em><small>#obj_translater.get_translate('alert_no_audio')#</small></em></span>
            </cfif>
        </div>
    </div>
</div>

</cfoutput>