<cfparam name="showheader" default="#SESSION.showheader#">
<cfparam name="cur_rank_session" default="0">

<cfif cur_rank_session eq 0>
    <cfif isDefined("SESSION.cur_rank_session") AND SESSION.cur_rank_session neq "">
        <cfset cur_rank_session = SESSION.cur_rank_session>
    </cfif>
</cfif>


<cfset __shortminute = obj_translater.get_translate('short_minute')>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#",l_by="yes")>
<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>
<cfset progress_completed = 0>
<cfset progress_total = 0>
<cfoutput query="get_session" group="session_id">
    <cfset progress_total += 1>
    <cfif status_id neq "">
        <cfset progress_completed += 1>
    <cfelse>
        <cfif cur_rank_session eq 0>
            <cfset cur_rank_session = session_rank>
        </cfif>
    </cfif>

</cfoutput>

<cfset first_lesson_booked = 0>
<cfset last_lesson_left = 0>

<cfif progress_completed gt 0>
    <cfset first_lesson_booked = 1>
</cfif>

<cfif progress_completed eq progress_total + 1>
    <cfset last_lesson_left = 1>
</cfif>

<style>
    .scrolling-wrapper{
        overflow-x: auto;

    }
    #scroll1::-webkit-scrollbar {
        height: 10px;
    }
    #scroll1::-webkit-scrollbar-track {
        border-radius: 8px;
        background-color: #e7e7e7;
        border: 1px solid #cacaca;
    }
    #scroll1::-webkit-scrollbar-thumb {
        border-radius: 8px;
        background-color: #CCCCCC;
    }


    
    /* .testcenter {
    margin: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    } */
</style>

<!----------------------- SHOWHEADER = 1 >> LAUNCHING ----------------->
<cfif showheader eq 1>
    <div class="row">
        
        <div class="col-md-12">

            <div class="bg-white shadow-sm p-2">

                <cfif isDefined("SESSION.CUR_STEP") AND SESSION.CUR_STEP eq "3">
                <div class="d-flex w-100 justify-content-between align-items-center">
                    
                    
                    <cfoutput>
                    <div class="badge badge-pill border bg-light bg-white p-2 px-4 font-weight-normal" style="font-size:100% !important">
                        <div class="d-flex">
                            <!--- <div>
                                <img src="./assets/img/<cfif randrange(1,2) eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" width="30">
                            </div> --->
                            <div>
                                <strong>#obj_translater.get_translate('btn_choose_trainer')#</strong>
                               
                                <div class="mt-1">
                                #obj_translater.get_translate('limit_trainer_max')#
                                </div>
                            </div>
                            <div class="ml-2">
                                <button class="btn btn-sm btn-outline-info btn_edit_trainer mb-0">#obj_translater.get_translate('btn_add')#</button>
                                                        
                            </div>
                        </div>
                    </div>
                    </cfoutput>

                    <div class="font-weight-normal ml-2" style="font-size:100% !important">
                        <div class="d-flex align-items-center">
                            <div>
                                <h6 class="m-0"><cfoutput>#obj_translater.get_translate('sidemenu_learner_tp')#</cfoutput></h6>
                                <div class="display_tp_progress">
                                    <cfoutput>#progress_total - progress_completed# <cfoutput>#obj_translater.get_translate('btn_remaining_courses')#</cfoutput></cfoutput>	
                                </div>
                            </div>

                            <div class="ml-2">
                                <cfoutput>
                                    <form <!---action="updater_form.cfm"---> method="post">
                                        <input type="hidden" name="u_id" value="#SESSION.USER_ID#">
                                        <input type="hidden" name="t_id" value="#t_id#">
                                        <input type="hidden" name="form_type" value="affect_trainer">
                                        <input type="submit" id="btn_validate_tp" class="btn btn-lg btn-info mb-0 <!---btn_view_tp---> <cfif progress_total eq 0>disabled<cfelse><cfif (progress_completed/progress_total)*100 LT 1>disabled</cfif></cfif>" id="tp_#t_id#" value="#obj_translater.get_translate('btn_validate')#">
                                    </form>
                                </cfoutput>
                            </div>
                        </div>
                    
                    </div>


                </div>
                </cfif>


                            
                            <!--- <cfoutput>
                                <div class="progress w-100 mt-2" style="height:6px">
                                    <div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated text-dark" role="progressbar" aria-valuenow="#(progress_completed/progress_total)*100#" aria-valuemin="0" aria-valuemax="100" style="width: #(progress_completed/progress_total)*100#%;"> 
                                    <!--- &nbsp;  --->
                                    </div>
                                </div>
                            </cfoutput> --->

                            <!--- <cfoutput>
                            <div class="w-100 mb-3 d-flex justify-content-center align-items-center">
                                <div>
                                    <!--- <img src="./assets/img_formation/#get_tp.formation_id#.png" width="35" class="mr-1"> --->
                                    <h5 class="d-inline"> #obj_translater.get_translate('card_title_visio')# #get_tp.formation_name# 20h
                                    
                                        #obj_translater.get_translate("with")#

                                        <cfloop query="tp_trainer">
                                            <span class="badge badge-pill border border-dark p-2 pr-3 font-weight-normal" id="pill_215209" style="font-size:16px">
                                                <div class="d-flex">
                                                    <div>
                                                        #obj_lms.get_thumb(user_id="#planner_id#",size="40",responsive="yes")#
                                                    </div>
                                                    <div>
                                                        <strong>
                                                            #planner#
                                                        </strong>
                                                        <br>
                                                        <a class="btn btn-sm btn-link text-info btn_view_trainer m-0 p-0 pt-1" id="trainer_#planner_id#">
                                                            Info
                                                        </a>
                                                        <cfif (listFindNoCase("1,2,3,4", get_tp.formation_id)) AND get_tp.method_id neq "11">
                                                            <cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE) AND (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND get_tp.method_id neq "2">
                                                                <a class="btn btn-sm btn-link text-info btn_del_trainer m-0 p-0 pt-1" <cfif tp_trainer.recordCount lte 1>disabled</cfif> id="trainer_#planner_id#" >#obj_translater.get_translate("btn_remove")# </a>
                                                            </cfif>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </span>
                                        </cfloop>

                                        <cfif user_type_id neq "7">
                                        <cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE)>
                                            <cfif (listFindNoCase("1,2,3,4", get_tp.formation_id)) AND (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND get_tp.method_id eq "1">
                                                <span class="badge badge-pill border border-dark bg-white p-2 font-weight-normal">
                                                    <div class="d-flex">
                                                        <div>
                                                            <img src="./assets/img/unknown_male.png" width="40">
                                                        </div>
                                                        <div>
                                                            <button class="btn btn-sm btn-link text-info btn_edit_trainer pb-0">#obj_translater.get_translate('btn_add')#</button>
                                                        </div>
                                                    
                                                    <!--- <p>#obj_translater.get_translate('limit_trainer_max')#</p> --->
                                                </span>
                                            </cfif>
                                        </cfif>
                                        </cfif>


                                    </h5>
                                </div>
                                
                            </div>
                            </cfoutput> --->


                            <!--- <div class="card border">
                                <div class="card-body">
                                    <div class="row" align="center">
                                        <div class="col-md-4">
                                                        
                                            <img src="./assets/img/" width="90">
                                                                    
                                        </div>
                                        <div class="col-md-4">
                                                        
                                            <small><cfoutput>#obj_translater.get_translate('launching_max_trainer_warning')#</cfoutput></small>
                             
                                        </div>
                                        <div class="col-md-4">
                                                        
                                            <button class="btn btn-outline-info btn_edit_trainer">#obj_translater.get_translate('btn_add')#</button>
                                                                    
                                        </div>
                                    </div>
                                </div>
                            </div> --->
                
                

                <div class="scrolling-wrapper d-flex flex-row flex-nowrap mt-3 pb-2 pt-1" id="scroll1">
                <!--- <ul id="sortable"> --->

                    <!--- <cfloop from="1" to="20" index="go">
                        <li class="border m-1 mb-2 shadow-sm bg-white">
                            <small><strong>Cours <cfoutput>#go#</cfoutput></strong></small>
                            <br>
                            <img src="./assets/img/unknown_male.png" class="tthumb_5" width="30" title="" style="border-radius:50%; border: 2px solid #CCCCCC !important;" align="center">
                        
                        </li>
                    </cfloop> --->

                    <!--- <cfoutput query="get_session" group="session_id">
                        <cfif lesson_id neq "">
                            <div id="a_#dateformat(lesson_start,'yyyy-mm-dd')#_#timeFormat(lesson_start,'hh_mm')#_#planner_id#" class="cursored col-sm-1 border border-danger bg-white p-1 m-1 mb-2 shadow-sm" style="line-height:14px !important">
                                <div class="d-flex justify-content-between">
                                    <div class="d-none d-lg-block">
                                        <img src="./assets/user/#planner_id#/photo.jpg" class="tthumb_#session_rank#" width="30" style="border-radius:50%; border: 2px solid ##8A2128 !important;" align="left">
                                    </div>
                                    <div class="ml-2">
                                        <small><strong class="d-none d-md-block">## #session_rank#</strong></small>
                                        
                                        <small>#lsDateTimeFormat(lesson_start,'dd/mm ', 'fr')#</small>				
                                        <br>
                                        <small>#lsDateTimeFormat(lesson_start,'HH:nn', 'fr')#</small>
                                    </div>
                                    <div class="ml-auto">
            
                                        <button id="btns_#session_rank#" class="p-1 btn-link btn_del_session">
                                            <i class="fa-sharp fa-solid fa-circle-xmark text-info"></i>
                                        </button>
                                    </div>
                                </div>
                                <cfif SESSION.USER_ID eq 202>
                                    <br>
                                    <a class="btn btn-sm btn-outline-info btn_view_session_test" id="s_#session_id#" href="##"><i class="fas fa-eye"></i>Details</a>
                                </cfif>
                                
                            </div>
                        <cfelse>
                            
                            <div id="tr_#session_rank#" class="col-sm-1 border bg-light p-1 m-1 mb-2 shadow-sm" style="line-height:14px !important">
                                
                                <cfset temp = randrange(1,2)>
                                
                                <div class="d-flex">
                                    <div class="d-none d-lg-block">
                                        <img src="./assets/img/<cfif temp eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" class="tthumb_#session_rank#" width="30" style="border-radius:50%;" align="left">
                                    </div>
                                    <div class="ml-2 d-inline">
                                        <small><strong class="d-none d-md-block">Cours #session_rank#</strong> </small>
                                    
                                    <small>#session_duration# min</small>		
                                    </div>
                                </div>
                                <cfif SESSION.USER_ID eq 202>
                                    <br>
                                    <a class="btn btn-sm btn-outline-info btn_view_session_test" id="s_#session_id#" href="##"><i class="fas fa-eye"></i>Details</a>
                                </cfif>
                            </div>
                        
                        </cfif>
                    </cfoutput> --->

                    <cfoutput query="get_session" group="session_id">

                        <cfif lesson_id neq "">
                            <div id="tr_#session_rank#" class="bg-light border rounded mr-2 shadow-sm" style="line-height:14px !important">
                                <!--- <td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td> --->
                                
                                    <div <cfif status_id eq 1 OR status_id eq "">id="rkl_#session_rank#"</cfif> class="d-flex text-nowrap flex-nowrap p-1 w-100 <cfif status_id eq 1 OR status_id eq "">bg-warning btn_display_session<cfelse>disabled bg-success</cfif> text-white display_text_action font-weight-normal" style="cursor:pointer;">
                                        <div class="" width="30">
                                            <img src="./assets/user/#planner_id#/photo.jpg" class="tthumb_#session_rank#" width="30" title="" style="border-radius:50%; border: 2px solid ##8A2128 !important; margin-right:3px">
                                        </div>
                                        <div>
                                            <small>#obj_translater.get_translate('table_th_course')#
                                            <span id="rkl_textnb_#session_rank#"><strong>#session_rank#</strong></span> 
                                            <br>
                                            <!--- <cfif isDefined("SESSION.CUR_STEP") AND SESSION.CUR_STEP eq "3">
                                                <strong>#sessionmaster_name#</strong>
                                                <br>
                                            </cfif> --->
                                            <strong>#session_duration# #__shortminute#</strong>
                                            </small>
                                        </div>
                                    </div>
                                

                                <!--- <div class="p-1" <cfif status_id eq 1 OR status_id eq "">id="rkl_text_#session_rank#"</cfif> style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 32ch;"> --->
                                    <div class="m-1 p-2 badge badge-pill bg-white border <cfif status_id eq 1 OR status_id eq "">border-warning<cfelse>border-success</cfif>" <cfif status_id eq 1 OR status_id eq "">id="rkl_text_#session_rank#"</cfif>>
                                        #lsDateTimeFormat(lesson_start,'dd/mm ', 'fr')#
                                        #lsDateTimeFormat(lesson_start,'HH:nn', 'fr')#
                                        <cfif status_id eq 1 AND ((first_lesson_booked eq 1 AND sessionmaster_id neq 695) OR (progress_completed eq 1))>
                                        <button id="btns_#session_rank#" class="btn-link btn_del_session m-0 pl-1 pr-0">
                                            <i class="fa-sharp fa-solid fa-circle-xmark text-info"></i>
                                        </button>
                                        </cfif>
                                    </div>

                                    
                                <!--- <a <cfif status_id eq 1 OR status_id eq "">id="btns_#session_rank#"</cfif> class="btn <cfif status_id eq 1 OR status_id eq "">btn-warning btn_del_session<cfelse>disabled btn-secondary</cfif> btn-sm float-right"><i class="far fa-times"></i></a> --->
                            
                                    <!--- <cfif SESSION.USER_ID eq 202 or SESSION.USER_ID eq "2072" or SESSION.USER_ID eq "2586">
                                        <a class="btn btn-link text-info btn_view_session_test" id="s_#session_id#" href="##"><i class="fas fa-eye"></i></a>
                                        </cfif>

                                         --->
                            </div>
                        <cfelse>
                            <div id="tr_#session_rank#" class="col-sm-1 cursored bg-light border <!---border-red---> rounded mr-2 p-1 shadow-sm" style="line-height:14px !important; width:140px !important">
                                
                                <cfset temp = randrange(1,2)>

                                <div id="rkl_#session_rank#" class="d-flex display_text_action <cfif (last_lesson_left eq 1 AND sessionmaster_id eq 694)>btn_display_session</cfif> <cfif (first_lesson_booked eq 0 AND session_rank eq 1) OR (first_lesson_booked eq 1 AND sessionmaster_id neq 694)>btn_display_session</cfif> text-nowrap flex-nowrap p-1 w-100 <cfif cur_rank_session eq session_rank>selected_rk</cfif>" style="display:inline-block; white-space: nowrap;">
                                    <!--- <div class="" width="30"> --->
                                        <img src="./assets/img/<cfif temp eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" class="tthumb_#session_rank# d-none d-lg-block" width="30" title="" style="border-radius:50%;  margin-right:3px" align="left">
                                    <!--- </div> --->
                                    <div class=" text-nowrap flex-nowrap">
                                        <small>#obj_translater.get_translate('table_th_course')#
                                        <span id="rkl_textnb_#session_rank#"><strong>#session_rank#</strong></span> 
                                        <br>
                                        <!--- <cfif isDefined("SESSION.CUR_STEP") AND SESSION.CUR_STEP eq "3">
                                            <strong>#sessionmaster_name#</strong>
                                            <br>
                                        </cfif> --->
                                        <strong>#session_duration# #__shortminute#</strong>
                                            </span>
                                        </small>
                                    </div>
                                </div>
                                <!--- <br>
                                <a id="btns_#session_rank#" class="btn btn-warning btn_del_session disabled btn-secondary btn-sm float-right"><i class="far fa-times"></i></a> --->
                                <!--- <cfif SESSION.USER_ID eq 202 or SESSION.USER_ID eq "2072" or SESSION.USER_ID eq "2586">
                                    <br>
                                    <a class="btn btn-sm btn-outline-info btn_view_session_test" id="s_#session_id#" href="##"><i class="fas fa-eye"></i></a>
                                </cfif> --->
                            </div>


                        </cfif>


                    </cfoutput>

                    <!--- <li class="">
                        <small><strong>Cours #session_rank#</strong></small>
                        <br>
                        <img src="./assets/img/unknown_male.png" class="tthumb_5" width="30" title="" style="border-radius:50%; border: 2px solid ##CCCCCC !important;" align="center">
                    
                    </li>

                    <li>

                        <cfoutput><a href="##" class="btn btn-info btn-block btn_view_tp mt-2 <cfif (progress_completed/progress_total)*100 LT 20>disabled</cfif>" id="tp_#t_id#">#obj_translater.get_translate('btn_validate')#</a></cfoutput>
                            

                    </li> --->
                <!--- </ul> --->
                </div>
    
    
                    
    
            </div>

        </div>
        
    </div>


<!----------------------- SHOWHEADER = 2 >> LAUNCHING PARTNER ----------------->
<cfelseif showheader eq 2>
    <div class="row">
			
        <div class="col-md-12">

            <div class="bg-white shadow-sm">

                <div class="row justify-content-center">
                    <div class="col-sm-12 col-md-4 col-lg-3">

                        <div class="d-flex border border-info justify-content-between p-2">
                            <div>
                                <h6 class="m-0"><cfoutput>#obj_translater.get_translate('sidemenu_learner_tp')#</cfoutput></h6>
                                <div class="badge display_tp_progress">
                                    <cfoutput>#progress_total - progress_completed# #obj_translater.get_translate('btn_remaining_courses')#</cfoutput>	
                                </div>
                            </div>

                            <div>
                                <cfif SESSION.CUR_STEP eq "2">
                                    <cfoutput><input type="submit" id="btn_validate_tp" class="btn btn-info m-0 <!---btn_view_tp---><cfif progress_total eq 0>disabled<cfelse><cfif (progress_completed/progress_total)*100 LT 20>disabled</cfif></cfif>" id="tp_#t_id#" value="#obj_translater.get_translate('btn_continue')#"></cfoutput>
                                <cfelseif SESSION.CUR_STEP eq "3">
                                    <cfoutput>
                                        <form action="updater_form.cfm" method="post">
                                            <input type="hidden" name="u_id" value="#SESSION.USER_ID#">
                                            <input type="hidden" name="t_id" value="#t_id#">
                                            <input type="hidden" name="form_type" value="affect_trainer">
                                            <input type="submit" id="btn_validate_tp" class="btn btn-info m-0 <!---btn_view_tp---> <cfif progress_total eq 0>disabled<cfelse><cfif (progress_completed/progress_total)*100 LT 20>disabled</cfif></cfif>" id="tp_#t_id#" value="#obj_translater.get_translate('btn_continue')#">
                                        </form>
                                    </cfoutput>
                                </cfif>
                            </div>
                        

                            
                            <!--- <cfoutput>
                                <div class="progress w-100 mt-2" style="height:6px">
                                    <div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated text-dark" role="progressbar" aria-valuenow="#(progress_completed/progress_total)*100#" aria-valuemin="0" aria-valuemax="100" style="width: #(progress_completed/progress_total)*100#%;"> 
                                    <!--- &nbsp;  --->
                                    </div>
                                </div>
                            </cfoutput> --->

                            
                            
                        </div>
                    </div>
                
                </div>
                

                <div class="scrolling-wrapper row flex-row flex-nowrap mt-3 pb-1 pt-1" id="scroll1">
                    <!--- <ul id="sortable"> --->
        
                <cfoutput query="get_session" group="session_id">
                    <cfif lesson_id neq "">
                        <div id="a_#dateformat(lesson_start,'yyyy-mm-dd')#_#timeFormat(lesson_start,'hh_mm')#_#planner_id#" class="cursored col-sm-1 border border-danger bg-white p-1 m-1 mb-2 shadow-sm btn_book_lesson" style="line-height:14px !important">
                            <div class="d-flex justify-content-between">
                                <div class="d-none d-lg-block">
                                    <img src="./assets/user/#planner_id#/photo.jpg" class="tthumb_#session_rank#" width="30" style="border-radius:50%; border: 2px solid ##8A2128 !important;" align="left">
                                </div>
                                <div class="ml-2">
                                    <small><strong class="d-none d-md-block">## #session_rank#</strong></small>
                                    
                                    <small>#lsDateTimeFormat(lesson_start,'dd/mm ', 'fr')#</small>				
                                    <br>
                                    <small>#lsDateTimeFormat(lesson_start,'HH:nn', 'fr')#</small>
                                </div>
                                <div class="ml-auto">
        
                                    <button class="p-1 btn-link">
                                        <i class="fa-sharp fa-solid fa-circle-xmark text-info"></i>
                                    </button>
                                </div>
                            </div>
                            
                        </div>
                    <cfelse>
                        <div id="tr_#session_rank#" class="col-sm-1 border bg-light p-1 m-1 mb-2 shadow-sm" style="line-height:14px !important">
                            
                            <cfset temp = randrange(1,2)>
                            
                            <div class="d-flex">
                                <div class="d-none d-lg-block">
                                    <img src="./assets/img/<cfif temp eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" class="tthumb_#session_rank#" width="30" style="border-radius:50%;" align="left">
                                </div>
                                <div class="ml-2 d-inline">
                                    <small><strong class="d-none d-md-block">#obj_translater.get_translate('lessons')# #session_rank#</strong> </small>
                                
                                <small>#session_duration# #obj_translater.get_translate('short_minute')#</small>		
                                </div>
                            </div>
                        </div>
                    
                    </cfif>
                </cfoutput>
        
                    <!--- </ul> --->
                </div>

                
                

            </div>

        </div>

    </div>
</cfif>

<script>
    $(document).ready(function() {

            $('.btn_edit_trainer').click(function(event) {
            event.preventDefault();
            <cfif get_trainer.recordCount lt "3">
                $('#window_item_xl').modal({keyboard: true});
                $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_choose_trainer'))#</cfoutput>");	
                $('#modal_body_xl').empty();	
                $('#modal_body_xl').load("<cfoutput>modal_window_tptrainer.cfm?t_id=#t_id#&single=1</cfoutput>");
            <cfelse>
            alert("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#</cfoutput>");
            </cfif>
		
	    });

        <cfif (cur_rank_session + 5) GT progress_total>
            const element = document.getElementById("rkl_<cfoutput>#progress_total#</cfoutput>");
            element.scrollIntoView({block: "center"});
        <cfelse>
            const element = document.getElementById("rkl_<cfoutput>#(cur_rank_session + 5)#</cfoutput>");
            element.scrollIntoView({block: "center"});
        </cfif>
        
    })
</script>