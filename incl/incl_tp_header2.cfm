<cfoutput>

    <cfset get_tp_trainer = obj_tp_get.oget_tp_trainer(tp_id)>
    <cfquery name="get_count_session" datasource="#SESSION.BDDSOURCE#">
        SELECT COUNT(session_id) as nb FROM lms_tpsession
        WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
    </cfquery>
    
    <cfquery name="count_participant_tp" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(*) as nb
    FROM lms_lesson2_attendance la 
    LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
    WHERE t.tp_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> 
    AND la.subscribed = 1
    </cfquery>
    
    <cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
    <cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
    <cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
    <cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
    <cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
    
    <cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
    <cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
    
    <cfset tp_done_go = tp_completed_go+tp_inprogress_go>
    
    <cfquery name="get_subscribed_tp" datasource="#SESSION.BDDSOURCE#">
        SELECT user_id FROM lms_tpuser
        WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
        AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        AND tpuser_active = 1
    </cfquery>
    
    
    <div class="card border border-#tplevel_alias# mb-2">
        <!--- <cfif get_subscribed_tp.recordCount GT 0>
        <div class="bg-#tplevel_alias# text-white p-1" align="right">
            <h6 class="m-1"><i class="fa-light fa-bell-on text-white"></i> #obj_translater.get_translate('vc_card_subscribed')#</h6>
        </div>
        </cfif> --->
    
        <cfif tp_status_id eq "1">
            <div class="bg-dark text-white p-1" align="right">
                <h6 class="m-1"><i class="fa-light fa-timer text-white"></i> #obj_translater.get_translate('coming_soon')#</h6>
            </div>
        </cfif>
    
        <div class="card-body">
    
            <div class="row">
                <div class="col-md-3">
                    <cfif fileexists("#SESSION.BO_ROOT_URL#/assets/img_tp/#tp_id#.jpg")>
                        <img width="250" src="#SESSION.BO_ROOT_URL#/assets/img_tp/#tp_id#.jpg" class="mr-2">
                    </cfif>
                </div>
    
                <div class="col-md-9">
    
                    <div class="d-flex">
                        <div>
                            <img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mr-1"> 
                            <cfif level_id neq "">
                                <img src="./assets/img_level/#tplevel_alias#.svg" width="40">
                            </cfif>
                        </div>
                        <div class="mt-1 ml-2">
                            <h5 class="d-inline">#tp_name#</h5>
                        </div>
    
                    </div>
    
                    
                    <div class="w-100 mt-2"> 
                        <cfset temp = obj_lms.get_progress_bar_virtual(css="#tplevel_alias#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")>
                        #temp#
                    </div>
    
                    <div class="mt-2"> 
                        #tp_description#
                    </div>
    
                </div>
    
            </div>
    
            
    
            
            
    
            <div class="d-flex justify-content-around align-items-center mt-3" align="center">
                <div>
                    <i class="fa-thin fa-list-check fa-2x text-#tplevel_alias# mb-2"></i>
                    <br>
                    <strong>#get_count_session.nb# </strong><br>#obj_translater.get_translate('lessons')#
                </div>
                <div>
                    <i class="fa-thin fa-timer fa-2x text-#tplevel_alias# mb-2"></i>
                    <br>
                    <strong>#tp_session_duration# #obj_translater.get_translate('short_minute')#</strong><br>#obj_translater.get_translate('vc_legend_lesson_duration')#
                </div>
                <div>
                    <i class="fa-thin fa-users fa-2x text-#tplevel_alias# mb-2"></i>
                    <br>
                    <strong>#count_participant_tp.nb#</strong><br>#obj_translater.get_translate('vc_legend_followers')#
                </div>
                <!---<div>
                    <i class="fa-thin fa-hourglass-clock fa-2x text-#tplevel_alias# mb-2"></i>
                    <br>
                    <strong>14</strong><br>Cours restants
                </div>--->
                <div class="d-flex justify-content-center">
                    <cfloop query="get_tp_trainer">
                        <div class="mr-3">
                        #obj_lms.get_thumb(planner_id,55)#
                        <br>
                        <strong>#get_tp_trainer.planner#</strong>
                        <!--- <br>
                    #obj_translater.get_translate('btn_trainer')# --->
                        </div>
                    </cfloop>
                    <!--- #obj_function.get_thumb_border(user_id="#get_tp_trainer.planner_id#",size="40",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#
                    <br> --->
                </div>
    
            </div>
    
            
            <!--- <div class="row mt-4">
    
                <div class="col-md-12">
               
                    <cfif isdefined("view") AND listfind(view,"subscribe")>
                        <cfif get_subscribed_tp.recordCount GT 0>
                            <button class="<cfif tp_status_id neq "2">disabled</cfif> btn btn-#tplevel_alias# float-right btn_subscribe_class" data-tid="#tp_id#" id="subscribe_#tp_id#"><i class="fa-light fa-bell-slash"></i> #obj_translater.get_translate('vc_btn_unfollow_tp')#</button>
                        <cfelse>
                            <button class="<cfif tp_status_id neq "2">disabled</cfif> btn btn-outline-#tplevel_alias# float-right btn_subscribe_class" data-tid="#tp_id#" id="subscribe_#tp_id#"><i class="fa-light fa-bell-on"></i> #obj_translater.get_translate('vc_btn_follow_tp')#</button>
                        </cfif>
                    </cfif>
                
                    <cfif isdefined("view") AND listfind(view,"details")>
                        <button class="<cfif tp_status_id neq "2">disabled</cfif> btn btn-outline-#tplevel_alias# float-right btn_view_tp" id="details_#tp_id#">#obj_translater.get_translate('vc_btn_details_tp')#</button>
                    </cfif>
                   
                </div>
    
            </div> --->
    
        </div>
    </div>
    </cfoutput>