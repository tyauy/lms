<!DOCTYPE html>
<style>
    .equal-widths{
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(110px, 10%));
        overflow-wrap: break-word;
        hyphens: manual;
    }
</style>
<cfsilent>

<cfparam name="f_id" default="2">
<cfparam name="lev_id" default="mytp">
<cfset menu_type = "training">

<cfif not isDefined("u_id") OR u_id eq "">
	<cfset u_id = 0>
</cfif>

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>
	<cfset user_type_id = SESSION.USER_TYPE_ID>

<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<!--- <cfset u_id = u_id> --->
	<!--- <cfset p_id = SESSION.USER_ID> --->
	
    <cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#SESSION.USER_ID#">
        <cfinvokeargument name="ust_id" value="2,3,4">
	</cfinvoke>

    <cfif u_id neq 0>
        <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
            <cfinvokeargument name="u_id" value="#u_id#">
        </cfinvoke>
        <cfset user_type_id = get_user.user_type_id>
    <cfelse>
        <cfset user_type_id = "4">
    </cfif>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

    <cfif u_id neq 0>
        <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
            <cfinvokeargument name="u_id" value="#u_id#">
        </cfinvoke>
        <cfset user_type_id = get_user.user_type_id>
    <cfelse>
        <cfset user_type_id = "4">
    </cfif>

</cfif>

<cfif isDefined("_ops") AND isDefined("_p_id") AND t_id eq "">

    <cfinvoke component="api/users/user_trainer_post" method="create_ops_tp" returnvariable="_t_id">
        <cfinvokeargument name="_p_id" value="#_p_id#">
    </cfinvoke>

    <cfset t_id = _t_id>

</cfif>

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",m_id="1,2,11")>

<cfif not isdefined("t_id")>
	<cfset t_id = get_tps.tp_id>
</cfif>

<cfif t_id eq "">
	<cfset t_id = get_tps.tp_id>
</cfif>

<cfset first_lesson_booked = 1>

<!--- <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")> --->
<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

    <cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>

    <cfquery name="get_first_lesson_verif" datasource="#SESSION.BDDSOURCE#">
        SELECT l.lesson_id FROM  lms_tpsession ts
        LEFT JOIN lms_lesson2 l  ON ts.session_id = l.session_id
        WHERE ts.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
        AND ts.sessionmaster_id = 695
    </cfquery>

    <cfif get_first_lesson_verif.recordCount GT 0>
        <cfif get_first_lesson_verif.lesson_id eq "">
            <cfset first_lesson_booked = 0>
        </cfif>
    </cfif>

<cfelse>
    <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
</cfif>

<cfset SESSION.TP_ID = t_id>
<cfset SESSION.TP_CANCEL_PTA = 0>

<cfif get_tp.tp_skill_id neq "">
<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id IN (#get_tp.tp_skill_id#)
</cfquery>
</cfif>
	

<cfset lang_select = lcase(get_tp.formation_code)>

<!------------------------- TRANSLATION ---------------------------->
<cfset __lesson = obj_translater.get_translate('lesson')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __with = obj_translater.get_translate('with')>
<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfset __card_tp_description = obj_translater.get_translate('card_tp_description')>
<cfset __card_tp_lessonnote = obj_translater.get_translate('card_tp_lessonnote')>
<cfset __card_tp_exercice = obj_translater.get_translate('card_tp_exercice')>
<cfset __card_tp_note = obj_translater.get_translate('card_tp_note')>


<cfset __modal_supports = obj_translater.get_translate('modal_supports')>
<cfset __modal_link_ws = obj_translater.get_translate('modal_link_ws')>
<cfset __modal_link_wsk = obj_translater.get_translate('modal_link_wsk')>
<cfset __modal_link_video = obj_translater.get_translate('modal_link_video')>
<cfset __modal_link_audio = obj_translater.get_translate('modal_link_audio')>

<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset __btn_note = obj_translater.get_translate('btn_note')>


<cfset __shortminute = obj_translater.get_translate('short_minute')>

<!------------------------- ATTENDANCE SHEETS ATTACHMENT ---------------------------->
<cfdirectory directory="#SESSION.BO_ROOT#/assets/attachment/" name="dirQuery" action="LIST">

<!------------------------- SCAN ALREADY ATTACHED Ts ---------------------------->
<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
	<meta charset="utf-8" />
	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	
	<style>
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
		<cfset title_page = "#obj_translater.get_translate('title_page_visio_f2f_tp')#">
        <cfif u_id neq 0>
            <cfset title_page &= ": #get_user.user_firstname# #ucase(get_user.user_name)#">
        </cfif>
		<cfelse>
		<cfset title_page = "#obj_translater.get_translate('title_page_visio_f2f_tp')#">
		</cfif>
		<cfset help_page = "help_tpbook">
		
		<cfinclude template="./incl/incl_nav.cfm">
			
		<div class="content">
            <!--- <cfif isdefined("SESSION.show_new_trainer")>
                <cfif SESSION.show_new_trainer neq "-1">
                    
                    <div class="alert alert-success" role="alert">
                        <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_trainer_ok')# #SESSION.show_new_trainer#</cfoutput> !</em></div>
                    </div>
                    
                <cfset SESSION.show_new_trainer = "-1">
                </cfif>
            </cfif> --->

			<cfif isdefined("k")>
				<cfif k eq "1">
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_tp_ok')#</cfoutput></em></div>
				</div>
				<cfelseif k eq "2">
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_lesson_ok')#</cfoutput></em></div>
				</div>
				<cfelseif k eq "3">
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_cancel_lesson_ok')#</cfoutput></em></div>
				</div>
				<cfelseif k eq "4">
				<div class="alert alert-success" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_sign_lesson_ok')#</cfoutput></em></div>
				</div>
				</cfif>
			</cfif>		

            <cfif isdefined("e")>
				<cfif e eq "1">
				<div class="alert alert-danger" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_booking_error')#</cfoutput></em></div>
				</div>
                <cfelseif e eq "2">
                    <div class="alert alert-danger" role="alert">
                        <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_notation_error')#</cfoutput></em></div>
                    </div>
				</cfif>
			</cfif>	
			
            <cfinclude template="./incl/incl_nav_visio.cfm">

			<cfinclude template="./incl/incl_nav_tp.cfm">	
          	
			
			<cfif get_tp.recordcount neq "0">
				
                <!---- TP WITH SCHEDULER METHOD --->
                <cfif get_tp.method_scheduler eq "scheduler">
                
                    <cfoutput>
                                                
                    <cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = get_tp.tp_scheduled></cfif>
                    <cfif get_tp.tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = get_tp.tp_inprogress></cfif>
                    <cfif get_tp.tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = get_tp.tp_cancelled></cfif>
                    <cfif get_tp.tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = get_tp.tp_missed></cfif>
                    <cfif get_tp.tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = get_tp.tp_completed></cfif>
                    
                    <cfif get_tp.tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = get_tp.tp_duration></cfif>
                    <cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
                    <!--- <cfif tp_remain_go eq 0>
                        <cfset SESSION.TP_CANCEL_PTA = SESSION.TP_ID>
                    </cfif> --->
                    <cfset tp_done_go = tp_completed_go+tp_inprogress_go>
                    
                    <!---- TP INCOMPLETE--->
                    <cfif get_tp.tp_duration neq get_tp.session_duration>
                        <cfset tp_anomaly = "1">
                        <!--- #tp_duration# // #session_duration# --->
                    <cfelse>
                        <cfset tp_anomaly = "0">
                    </cfif>		
                    
                    <div class="row">

                        <cfif get_tp.method_id eq "7">
                            <!---- TP CERTIFICATION --->
                            
                            <div class="col-md-4">
                                <div class="card border-top border-info h100">
                                    <div class="card-body">
                                        <!--- <h4 class="card-title">#obj_translater.get_translate('card_tp_resume')#</h4>
                                        <br><br> --->

                                        <h5 class="mb-2 text-dark" style="font-size:18px"><strong><cfoutput>#ucase(obj_translater.get_translate('card_tp_resume'))#</cfoutput></strong></h5>
                                        <hr class="mt-0 border-red">

                                        
                                        <cfinclude template="./widget/wid_tp_recap.cfm">
                                    </div>
                                </div>
                            </div>
                        
                        <cfelse>
                        
                            <div class="col-md-12">
                            
                                <div class="card-deck md-1">
                                        
                                    <div class="card border mb-3">
                                        <div class="card-body">

                                            <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('table_th_training')#</cfoutput></h5>
                                            <hr class="mt-0 border-red">

                                            <!--- <h6>#obj_translater.get_translate('table_th_training')#</h6> --->
                                            
                                            <table class="table table-borderless bg-white m-0">
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_tp')#</td>
                                                    <td>
                                                        <h6 class="m-0"><img src="./assets/img_formation/#get_tp.formation_id#.png" width="30"> #get_tp.tp_type_name# #get_tp.tp_duration/60# H</h6>
                                                    </td>
                                                </tr>
                                                <cfif get_tp.tp_formula_id neq "">
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_rythm')#</td>
                                                    <td>
                                                        <cfif get_tp.tp_formula_id gt 1>
                                                            #get_tp.tp_formula_name# #get_tp.tp_formula_nbcourse# #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#
                                                        <cfelse>
                                                            #get_tp.tp_formula_name#
                                                        </cfif>
                                                    </td>
                                                </tr>
                                                </cfif>
                                                <cfif get_tp.tp_orientation_id neq "">
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_type')#</td>
                                                    <td>
                                                        #get_tp.tp_orientation_name#
                                                    </td>
                                                </tr>
                                                </cfif>
                                                <cfif get_tp.tp_skill_id neq "">
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_skills')#</td>
                                                    <td>
                                                        <cfloop query="get_skill">
                                                        #get_skill.skill_name#
                                                        </cfloop>
                                                    </td>
                                                </tr>
                                                </cfif>
                                                <cfif get_tp.tp_interest_id neq "" OR get_tp.tp_function_id neq "">
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_themes')#</td>
                                                    <td>
                                                        
                                                        <span class="badge badge-pill bg-light border font-weight-normal p-2 cursored btn_read_keyword" id="tpkeyword_#t_id#"><strong>Themes</strong><br>
                                                        <cfif  get_tp.tp_interest_id neq "" OR  get_tp.tp_function_id neq "">
                                                        <i class="fas fa-star text-warning"></i>
                                                        <cfelse>-</cfif>
                                                        </span>
                                                    </td>
                                                </tr>
                                                </cfif>
                                            </table>
                                        </div>
                                    </div>
                                        
                                        
                              
                                        <!--- <div class="w-100 d-none d-sm-block d-md-block d-lg-block d-xl-none"></div> --->
                                            
                                            
                                        
                                    <div class="card border mb-3">
                                        <div class="card-body">

                                            <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('table_th_trainers')#</cfoutput></h5>
                                            <hr class="mt-0 border-red">

                                            <!--- <h5 class="mb-2 text-dark" style="font-size:18px"><strong><cfoutput>#obj_translater.get_translate('table_th_trainers')#</cfoutput></strong></h5>
                                            <hr class="mt-0 border-red"> --->

                                            <!--- <h6>#obj_translater.get_translate('table_th_trainers')#</h6> --->
                                            

                                            <cfloop query="tp_trainer">

                                                <div class="bg-light mb-2">

                                                    <div class="container">

                                                        <div class="row">
                                                        
                                                            <div class="col-xl-8">
                                                                
                                                                <div class="media p-2">
                                                                    #obj_lms.get_thumb(user_id="#planner_id#",size="50",responsive="yes")#
                                                                    <div class="media-body ml-2 ">
                                                                        <h6 class="mt-0 mb-1">#planner#</h6>
                                                                        
                                                                        <span class="text-break" style="text-decoration: none;  background-color: none;"><small>#planner_email#</small></span>
                                                                    </div>
                                                                </div>

                                                            </div>

                                                            <div class="col-xl-4">

                                                                <div>

                                                                    <div class="btn-group">
                                                                        <a class="btn btn-outline-info btn-sm btn_view_trainer" id="trainer_#planner_id#">
                                                                            Info
                                                                        </a>
                                                                        <cfif (listFindNoCase("1,2,3,4", get_tp.formation_id)) AND get_tp.method_id neq "11">
                                                                            <cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE) AND (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND get_tp.method_id neq "2">
                                                                                <a class="btn btn-outline-info btn-sm btn_del_trainer" <cfif tp_trainer.recordCount lte 1>disabled</cfif> id="trainer_#planner_id#"><i class="fa fa-times" aria-hidden="true"></i> </a>
                                                                            </cfif>
                                                                        </cfif>
                                                                    </div>
    
                                                                </div>
            
                                                            </div>

                                                        </div>

                                                    </div> 

                                                </div> 
                                                    

                                            </cfloop>

                                            
                                        </div>

                                        <!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND u_id eq 565>
                                            <div class="card-footer pt-0" align="center">
                                                <hr>
                                                <p>#obj_translater.get_translate('limit_trainer_max')#</p>
                                                <button class="btn btn-info btn-sm btn_edit_trainer">#obj_translater.get_translate('btn_add')#</button>
                                            </div>
                                        </cfif> --->

                                        <!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) OR SESSION.USER_ID eq 11743> --->
                                        <cfif user_type_id neq "7">
                                        <cfif !listFindNoCase("TRAINER,TEST", SESSION.USER_PROFILE)>
                                            <cfif (listFindNoCase("1,2,3,4", get_tp.formation_id)) AND (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND get_tp.method_id eq "1">
                                                <div class="card-footer pt-0" align="center">
                                                    <hr>
                                                    <p>#obj_translater.get_translate('limit_trainer_max')#</p>
                                                    <button class="btn btn-outline-red btn-sm btn_edit_trainer">#obj_translater.get_translate('btn_add')#</button>
                                                </div>
                                            </cfif>
                                        </cfif>
                                        </cfif>
                                    </div>
                                        
                                    <div class="card border mb-3">
                                        <div class="card-body">

                                            <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_activity')#</cfoutput></h5>
                                            <hr class="mt-0 border-red">


                                            <!--- <h6>#obj_translater.get_translate('card_activity')#</h6> --->
                                            <table class="table table-borderless bg-white m-0">
                    
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('badge_planned_f_p')#</td>
                                                    <td>
                                                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-warning" id="nb_toschedule"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></span></h6>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('badge_completed_f_p')#</td>
                                                    <td>
                                                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-success" id="nb_completed"><cfif tp_completed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_completed_go#",unit="min")#<cfelse>-</cfif></span></h6>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('badge_missed_f_p')#</td>
                                                    <td>
                                                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_missed"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></span></h6>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('badge_cancelled_f_p')#</td>
                                                    <td>
                                                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_cancelled"><cfif tp_cancelled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_cancelled_go#",unit="min")#<cfelse>-</cfif></span></h6>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('badge_remaining_f_p')#</td>
                                                    <td>
                                                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-primary" id="nb_remain"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></span></h6>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-light">#obj_translater.get_translate('table_th_deadline')#</td>
                                                    <td>
                                                        <cfif get_tp.tp_date_end lte now() AND get_tp.tp_vip eq "0">
                                                            <h6 class="m-0 text-danger"><i class="fas fa-exclamation-triangle text-danger"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                                                        <cfelse>
                                                            <cfif get_tp.tp_date_end lte dateadd("m",2,now())>
                                                                <h6 class="m-0 text-warning"><i class="fas fa-exclamation-triangle text-warning"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                                                            <cfelse>
                                                                <h6 class="m-0">#obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                                                            </cfif>
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                        </div>
                                    </div>
                                        
                                    
                                </div>
                                    
                                        
                                <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
                                    <cfif tp_anomaly eq "1">
                                    <div class="alert alert-danger" role="alert">
                                        <div class="text-center"><em>#obj_translater.get_translate('alert_tp_anomaly')#</em></div>
                                    </div>
                                    </cfif>
                                </cfif>

                                <cfif get_tp.tp_date_end lte now() AND get_tp.tp_vip eq "0">
                                    <div class="alert alert-danger" role="alert">
                                        <div class="text-center"><em>#obj_translater.get_translate('alert_tp_deadline')#</em></div>
                                    </div>
                                <cfelse>
                                    <!----<cfif tp_date_end lte dateadd("m",2,now())>
                                        <div class="alert alert-danger" role="alert">
                                            <div class="text-center"><em>#obj_translater.get_translate('alert_tp_deadline')#</em></div>
                                        </div>
                                    </cfif>---->
                                </cfif>

                            </div>
                        </cfif>
                    </div>
                    </cfoutput>
                
                <cfelse>
                    <!---- TP WITH SIMPLE METHOD --->
                
                    <div class="row">
                        <cfoutput>
                                    
                        <cfif get_tp.method_id eq "6">
                        <!---- TP IMMERSION --->
                        
                        <div class="col-md-4">
                            <div class="card border-top border-info h100">
                                <div class="card-body">
                                    <h4 class="card-title">#obj_translater.get_translate('card_tp_resume')#</h4>
                                    <br><br>
                                    <cfinclude template="./widget/wid_tp_recap.cfm">						
                                    
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="card border-top border-info h100">
                                <div class="card-body">
                                    
                                    <h4 class="card-title">Informations d&eacute;taill&eacute;es </h4>
                                    <br><br>
                                    <div class="row">						
                                        <div class="col-md-2">
                                            #obj_lms.get_tpdestination_icon(destination_id,150)#
                                        </div>
                                        <div class="col-md-10">
                                            <table class="table table-sm">
                                                <tr>
                                                    <td>#obj_translater.get_translate('table_th_destination')#</td>
                                                    <td>#destination_name#</td>
                                                </tr>
                                                <tr>
                                                    <td>#obj_translater.get_translate('table_th_address')#</td>
                                                    <td>#destination_details#</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                        
                        <cfelseif get_tp.method_id eq "3">
                        <!---- TP ELEARNING --->
                        
                        <div class="col-md-4">
                            <div class="card border-top border-info h100">
                                <div class="card-body">
                                    <h4 class="card-title">#obj_translater.get_translate('card_tp_resume')#</h4>
                                    <br><br>
                                    <cfinclude template="./widget/wid_tp_recap.cfm">
                                    
                                </div>
                            </div>
                        </div>
                        
                        </cfif>
                                
                        </cfoutput>
                    </div>

                </cfif>

               

					
                <cfif get_tp.method_scheduler eq "scheduler">
                    <!---- TP WITH SCHEDULER METHOD --->
                
                    <cfset get_session = obj_tp_get.oget_session(t_id="#t_id#")>

                    <!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND t_id eq 22897>
                        <cfdump var="#get_session#">
                    </cfif> --->
                    
                                
                    <div class="row mt-2">
                        <div class="col-md-12">          
                              
                            <!----------------- REMOVE FOR PARTNER LEARNER -------------------->
				            <cfif isdefined("user_type_id") AND  user_type_id neq "7">
                            <cfif u_id neq 0 AND listFindNoCase("1,11", get_tp.method_id) AND (listFindNoCase("LEARNER,TEST,CS", SESSION.USER_PROFILE)) AND listfindnocase(SESSION.LIST_PT,get_tp.formation_code)>
                                <div class="row">
                                    <div class="col-md-12">
                                        
                                        <div class="card border p-2">
                                            
                                            <div class="card-body" id="heading_pt">
                                                                        
                                                <div class="row">
                                                
                                                    <div class="col-md-12">
                                            
                                                        <div class="row">
                                                            
                                                        
                                                            <cfloop list="start,end" index="pt_type">
                                                                <cfif pt_type eq "end" AND SESSION.USER_PROFILE eq "test">

                                                                <cfelse>
                                                                
                                                                    <div class="col-md-6">
                                                                        <div class="row">
                                                                            <div class="col-md-2">	
                                                                                <div align="center">
                                                                                    <cfoutput><img class="card-img-top" src="./assets/img/qpt_#lang_select#.jpg" align="center"></cfoutput>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-10">
                                                                                <div class="row">
                                                                                    <div class="col-md-12">
                                                                                        <h6 class="p-0">
                                                                                            <cfif pt_type eq "start">
                                                                                                <cfoutput>#obj_translater.get_translate('card_start_level')#</cfoutput>
                                                                                            <cfelse>
                                                                                                <cfoutput>#obj_translater.get_translate('card_end_level')#</cfoutput>
                                                                                            </cfif>
                                                                                        </h6>
                    
                                                                                        <cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",t_id="#t_id#",pt_type="#pt_type#")>
                                                                                        <cfloop query="get_pt">

                                                                                            <cfif get_pt.quiz_global_score eq "">
                                                    
                                                                                                <cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
                                                                                                    <cfinvokeargument name="u_id" value="#u_id#">
                                                                                                    <cfinvokeargument name="quiz_user_group_id" value="#get_pt.quiz_user_group_id#">
                                                                                                </cfinvoke>
                                                                                
                                                                                                <cfset reload_pt = true>
                                                                                            </cfif>
                                                                                
                                                                                        </cfloop>
                                                    
                                                                                        <cfif isDefined("reload_pt")>
                                                                                            <cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",t_id="#t_id#",pt_type="#pt_type#")>
                                                                                        </cfif>

                                                                                        <cfinclude template="./incl/incl_pt_result.cfm">
                                                                                        
                                                                                    </div>
                                                                                    
                                                                                    <div class="col-md-2">
                                                                                            
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </cfif>
                                                            </cfloop>
                                                        </div>
                                                        
                                                    </div>
                                                    
                                                </div>
                                                
                                            </div>
            
                                        </div>
                                    </div>
                                </div>
                            </cfif>
                            </cfif>

                                <!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                    <div class="row">
                                        <div class="col-lg-3">	   
                                            <select class="form-control" id="sort_tp_table" name="sort_tp_table">
                                                <option value="-2">Rank &#129047;</option>
                                                <option value="-1">Rank &#129045;</option>
                                                <option value="0">Remaining</option>
                                                <option value="5">Completed</option>
                                                <option value="1">Booked</option>
                                            </select>                                 
                                        </div>
                                    </div>
                                </cfif> --->
                            
                            <ul id="sortable" class="tp_content">
                            <!--- <cfdump var = "#get_session#"> --->
                                <cfoutput query="get_session" group="session_id">

                                    <cfif session_name neq "">
                                        <cfset format_title = "#session_name#">
                                    <cfelse>
                                        <cfset format_title = "#sessionmaster_name#">
                                    </cfif>
                                    
                                    <li <cfif !listFindNoCase("695,694", sessionmaster_id)>class="active"</cfif> id="session_#session_id#_#sessionmaster_id#_#session_rank#" 
                                        data-status="#status_id == "" || status_id == 3 ? 0 : status_id#" data-rank="#session_rank#">
                                        
                                        <div class="card border p-1">
                                           

                                            <div class="card-body" id="heading_#session_id#">

                                            <cfoutput group="lesson_id"> 
                                                <cfif status_id eq "5"> 
                                                <div class="lesson_card" name="#lesson_id#"> 
                                                    <div class="col-12 alert alert-success alert-dismissible collapse" id="close_modal_success_#lesson_id#" role="alert">
                                                        <cfoutput>#obj_translater.get_translate('info_done_ratings')#</cfoutput> 
                                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                </cfif>
                                             </cfoutput>   
                                                <div class="row">
                                                    <cfif SESSION.USER_ID eq "28538" or SESSION.USER_ID eq "27578">
                                                       
                                                    </cfif> 
                                                    <!--------------------->
                                                    <!--- COL THUMBNAIL --->
                                                    <!--------------------->
                                                    <div class="col-lg-1">

                                                        <div align="center">
                                                            <cfdirectory directory="#SESSION.BO_ROOT#/assets/lessons/#t_id#/#session_id#" name="dirQuery" action="LIST">

                                                            <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                                                                <img src="./assets/img_material/#sessionmaster_code#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
                                                            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                                                                <img src="./assets/img_material/#sessionmaster_id#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
                                                                
                                                            <cfelse>
                                                                <cfif sessionmaster_id eq "695">
                                                                    <i class="fal fa-road fa-3x btn_view_session" id="s_#session_id#"></i>
                                                                <cfelseif sessionmaster_id eq "694">
                                                                    <i class="fal fa-tasks fa-3x btn_view_session" id="s_#session_id#"></i>                                                                    
                                                                </cfif>
                                                            </cfif>

                                                            <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER,LEARNER", SESSION.USER_PROFILE)>
                                                                <cfif sessionmaster_id neq "695" AND sessionmaster_id neq "694">
                                                                <div class="btn btn-info btn-sm p-0 m-0 handle" style="min-width:20px !important"><i class="fa-solid fa-arrows-alt"></i></div>
                                                                </cfif>
                                                            </cfif>

                                                        </div>
                                                    </div>
                                                    
                                                    <!------------------------->
                                                    <!--- COL TITLE + FLAGS --->
                                                    <!------------------------->
                                                    <div class="col-sm-3">
                                                        <h6 class="py-2 d-inline"><!---#__lesson#&nbsp;#session_rank# : --->#format_title# 
                                                            <cfif listFindNoCase("TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
                                                                <cfif listFindNoCase("696,697,769,1181,1182,1183,1197,1198,1201,1202,1199,1267", sessionmaster_id)>
                                                                    <i class="fal fa-edit btn_edit_session" id="ol_#session_id#"></i>
                                                                </cfif>
                                                                <i class="fal fa-download btn_edit_session_document" id="ol_#session_id#"></i>
                                                            </cfif>
                                                        </h6>
                                                        <br>
                                                        <span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-clock"></i> #session_duration# min</span> 
                                                        
                                                        <cfif level_id neq "">
                                                            <span class="badge badge-pill bg-white border border-#level_css# px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-chart-bar"></i> #level_alias#</span> 
                                                        </cfif>

                                                        <cfif origin_id neq "">
                                                            <cfquery name="get_origin_id" datasource="#SESSION.BDDSOURCE#">
                                                                SELECT origin_id, origin_name_#SESSION.LANG_CODE# as origin_name FROM lms_lesson_origin WHERE origin_id IN (#origin_id#)
                                                            </cfquery>
                                                            
                                                            <cfloop query="get_origin_id">
                                                                <span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal" style="font-size:14px">#origin_name#</span><br>
                                                            </cfloop>
                                                        </cfif>

                                                        
                                                        <cfif listfindnocase("10,11,12", get_tp.method_id)>
                                                            <span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fal fa-users"></i> #get_tp.method_name#</span> 
                                                        <cfelseif listfindnocase("12", get_tp.method_id)>
                                                            <span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fa-light fa-chalkboard-user"></i> #get_tp.method_name#</span> 
                                                        </cfif>

                                                        <cfif mapping_id neq "">
                                                        
                                                            <div class="row mt-2">
                                                                <div class="col-md-12">

                                                                <cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
                                                                    SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#mapping_id#) AND mapping_category = 'grammar'
                                                                </cfquery>
                                                                
                                                                    <cfloop query="get_mapping_grammar">
                                                                    
                                                                    <cfif findnocase("A1",level)>
                                                                        <cfset css = "success">
                                                                    <cfelseif findnocase("A2",level)>
                                                                        <cfset css = "primary">
                                                                    <cfelseif findnocase("B1",level)>
                                                                        <cfset css = "info">
                                                                    <cfelseif findnocase("B2",level)>
                                                                        <cfset css = "warning">
                                                                    <cfelseif findnocase("C1",level)>
                                                                        <cfset css = "danger">
                                                                    <cfelse>
                                                                        <cfset css = "danger">
                                                                    </cfif>
                                                                    
                                                                    <span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
                                                                    </cfloop>
                                                                
                                                            
                                                                </div>
                                                            </div>
                                                            
                                                        
                                                        </cfif>

            
                                                        <!--- <cfif get_session.keyword_id neq "">
                                                            
                                                            <div class="row mt-2">
                                                                <div class="col-md-12">

                                                                <cfquery name="get_keyword_id" datasource="#SESSION.BDDSOURCE#">
                                                                    SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#get_session.keyword_id#)
                                                                </cfquery>
                                                                
                                                                <cfloop query="get_keyword_id">
                                                                <span class="badge badge-dark font-weight-normal" style="font-size:13px">#keyword_name#</span><br>
                                                                </cfloop>
                                                            
                                                                </div>
                                                            </div>
                                                        
                                                        </cfif> --->

                                                    </div>

                                                    

                                                    <!------------------->
                                                    <!--- COL BOOKING --->
                                                    <!------------------->
                                                    <div class="col-sm-3">
                                                        
                                                        <cfif lesson_id neq "">
                                                        
                                                            <cfset note_id = "">
                                                            
                                                            <cfif lesson_unbookable eq "1">
                                                                <cfset need_book = "0">
                                                            <cfelse>
                                                                <cfset need_book = "1">
                                                            </cfif>
                                                          
                                                            <cfoutput group="lesson_id">
                                                             
                                                            
                                                            <!-------- DONT DISPLAY CANCELLED ---->
                                                            <cfif status_id neq "3" AND (lesson_ghost neq "1" OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
                                                               
                                                                <button class="btn btn-#status_css# btn-block btn_view_lesson" id="lesson_#lesson_id#">
                                                                    
                                                                    <div class="row">
                                                                        <!---<div>
                                                                            #obj_lms.get_thumb(user_id="#planner_id#",size="30",responsive="yes")#
                                                                        </div>--->
                                                                        <div class="col">
                                                                            #status_name#
                                                                            <br>
                                                                            #obj_dater.get_dateformat(lesson_start)#
                                                                            <br>
                                                                            #timeformat(lesson_start,'HH:mm')#-#timeformat(lesson_end,'HH:mm')#
                                                                            <br>
                                                                            #__with# #planner_firstname#
                                                                        </div>
                                                                        <cfif status_id neq "4" AND status_id neq "3" AND status_id neq "1" AND note_id neq "">
                                                                            <cfset note_id = note_id>
                                                                        <cfelseif status_id eq "1" AND !listFindNoCase("10,11,12", get_tp.method_id)>
                                                                            <!--- //! we display the cancel button and if the PTA is cancellable we fill the TP_CANCEL_PTA --->
                                                                            <cfif need_book neq 0 AND sessionmaster_id eq "694">
                                                                                <cfset SESSION.TP_CANCEL_PTA = SESSION.TP_ID>
                                                                            </cfif>
                                                                            
                                                                            <div class="col-sm-3">
                                                                                <a class="btn btn-sm btn-outline-danger btn_view_lesson float-right" role="button" data-toggle="tooltip" data-placement="top" title="#__cancel#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i></a>
                                                                            </div>
                                                                        </cfif>
                                                                        
                                                                    </div>																						
                                                                </button>

                                                                <cfif status_id eq "1">
                                                                    <cfset text_invite = encodeForURL("WEFIT LESSON with #ucase(planner_firstname)#")>
                                                                    <cfset desc_invite = encodeForURL("
                                                                    #obj_translater.get_translate('table_th_method')# : #ucase(method_name)#
                                                                    #obj_translater.get_translate('table_th_trainer')# : #ucase(planner_firstname)#
                                                                    #obj_translater.get_translate('table_th_duration_short')# : #lesson_duration#min 
                                                                    #obj_translater.get_translate('table_th_course')# : #sessionmaster_name#
                                                                    ")>
                                                                    <cfset start_invite = encodeForURL(dateformat(lesson_start,'yyyymmdd')&"T"&timeformat(lesson_start,'HHnnss')&"/"&dateformat(lesson_end,'yyyymmdd')&"T"&timeformat(lesson_end,'HHnnss'))>
                                                                    <cfset end_invite = "">
                                                                    <cfset link_go = "https://www.google.com/calendar/render?action=TEMPLATE&text=#text_invite#&details=#desc_invite#&dates=#start_invite#">
                                                                    
                                                                    <!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
                                                                        <div class="row">
                                                                            <div class="col-md-8">
                                                                                <div align="center"><a href="#link_go#" target="_blank"><img src="./assets/img/invite_gg.gif"></a></div>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="pull-right"><a href="./invite/invite_ics.cfm?l_id=#lesson_id#" class="" target="_blank">+iCal/Outlook</a></div>
                                                                            </div>
                                                                        </div>
                                                                    <!--- <cfelse>
                                                                        <div align="center"><a href="#link_go#" target="_blank"><img src="./assets/img/invite_gg.gif"></a></div>
                                                                    </cfif> --->

                                                                </cfif>
                                                            
                                                            </cfif>
                                                            <!-------- DONT ALLOW BOOKING IF LESSON ---->
                                                            <cfif status_id neq "3">
                                                                <cfset need_book = "0">
                                                            </cfif>												
                                                            </cfoutput>
                                                            
                                                        </cfif>

                                                        <!-------- ALLOW BOOKING IF LESSON, NOT CANCELLABLE, AND TP NOT OUTDATED, OR TP VIP ---->
                                                        <cfif (get_tp.tp_date_end gt now() OR get_tp.tp_vip eq "1") 
                                                        AND ((isdefined("need_book") AND need_book eq "1") OR lesson_id eq "")> 
                                                    
                                                            <cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST">
                                                                <cfif (listFindNoCase("1,2,10", get_tp.tp_status_id)) AND !listFindNoCase("2,10,11", get_tp.method_id)>

                                                                    <button class="btn btn-outline-warning p-2 btn_edit_calendar btn-block" id="s_#session_id#_#session_duration#_#method_id#_#t_id#" 
                                                                    <cfif (sessionmaster_id eq "694" AND tp_anomaly eq "1") OR (sessionmaster_id neq "695" AND first_lesson_booked eq "0") OR (tp_remain_go GT session_duration AND sessionmaster_id eq 694)>disabled</cfif>>
                                                                        #__btn_book_short#<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
                                                                    </button>

                                                                <cfelseif (listFindNoCase("2,10", get_tp.tp_status_id)) AND listFindNoCase("11", get_tp.method_id)>
                                                                    <!--- we look if the user can book group lesson anyway --->
                                                                    <cfquery name="get_user_leader" datasource="#SESSION.BDDSOURCE#">
                                                                        SELECT is_group_leader FROM lms_tpuser 
                                                                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                                                                        AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                                                                        AND tpuser_active = 1
                                                                    </cfquery>

                                                                    <cfif get_user_leader.recordCount eq 1>
                                                                        <cfif get_user_leader.is_group_leader eq 1>
                                                                            <button class="btn btn-outline-warning p-2 btn_edit_calendar btn-block" id="s_#session_id#_#session_duration#_#method_id#_#t_id#" 
                                                                            <cfif (sessionmaster_id eq "694" AND tp_anomaly eq "1") OR (tp_remain_go GT session_duration AND sessionmaster_id eq 694)>disabled</cfif>>
                                                                                #__btn_book_short#<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
                                                                            </button>
                                                                        </cfif>
                                                                    </cfif>
                                                                </cfif>
                                                            <cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                                                    <button class="btn btn-outline-warning p-2 btn_edit_calendar btn-block" id="s_#session_id#_#session_duration#_#method_id#_#t_id#" 
                                                                    <cfif (sessionmaster_id eq "694" AND tp_anomaly eq "1") OR (tp_remain_go GT session_duration AND sessionmaster_id eq 694)>disabled</cfif>>
                                                                        #__btn_book_short#<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
                                                                    </button>
                                                            <cfelseif SESSION.USER_PROFILE eq "TRAINER">
                                                                <cfif sessionmaster_id eq "695">
                                                                    <button class="btn btn-outline-warning p-2 btn_edit_calendar btn-block" id="s_#session_id#_#session_duration#_#method_id#_#t_id#" 
                                                                    <cfif (sessionmaster_id eq "694" AND tp_anomaly eq "1") OR (tp_remain_go GT session_duration AND sessionmaster_id eq 694)>disabled</cfif>>
                                                                        #__btn_book_short#<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
                                                                    </button>
                                                                <cfelse>
                                                                    <button class="btn btn-outline-warning p-2 btn_edit_calendar btn-block" id="s_#session_id#_#session_duration#_#method_id#_#t_id#" 
                                                                    <cfif (sessionmaster_id eq "694" AND tp_anomaly eq "1") OR (tp_remain_go GT session_duration AND sessionmaster_id eq 694)>disabled</cfif>>
                                                                        #__btn_book_short#<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
                                                                    </button>
                                                                </cfif>
                                                            </cfif>	

                                                        </cfif>

                                                        <!--- VC --->
                                                        <!--- AND SESSION.USER_PROFILE eq "LEARNER" --->

                                                        <!--- <cfif get_tp.method_id eq "10" AND status_id eq "1">
                                                            <div align="center">
                                                                <cfif subscribed eq 1>
                                                                    <button class="btn btn-info"> #obj_translater.get_translate('vc_btn_subscribed')#</button>
                                                                    <button class="btn btn-info btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#"> #obj_translater.get_translate('vc_btn_cancel_attendance')#</button>
                                                                <cfelse>
                                                                    <button class="btn btn-success btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#"> #obj_translater.get_translate('vc_btn_confirm_attendance')#</button>
                                                                </cfif>
                                                            </div>
                                                        </cfif> --->
                                            
                                                    </div>

                                                    <!----------------------->
                                                    <!--- COL BTN ACTIONS --->
                                                    <!----------------------->     
                                                    <div class="col-sm-5 btn-grid" align="right">
                                                        <div class="equal-widths">
                                                            <!----- RATE LESSON, IF learner or demo and lesson defined and completed  ONLY ON NEWER LESSON (1 MONTH) AND NOT ALREADY RATED---->    
                                                            <cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST"> 
                                                                <cfoutput group="lesson_id">
                                                                    <cfset l_id="#lesson_id#">  
                                                                    <cfif l_id neq "">
                                                                            <cfif status_id eq "5"> 
                                                                            
                                                                            <cfinvoke component="api/ratings/ratings_get" method="oget_lesson_rating" returnvariable="get_rating">
                                                                                <cfinvokeargument name="l_id" value="#l_id#">
                                                                            </cfinvoke>	
                                                                            <cfif get_rating.recordcount eq 0>
                                                                                <!---- RATING AVAIL ONLY ON NEWER LESSON (1 MONTH) --->
                                                                                <cfif lesson_start gt dateadd("m",-1,now())>
                                                                                    <cfinvoke component="api/ratings/badges_get" method="oget_lessontype" returnvariable="get_lesson_type">
                                                                                        <cfinvokeargument name="l_id" value="#l_id#">
                                                                                    </cfinvoke>		
                                                                                                   
                                                                                <button class="btn btn-outline-info btn_note_lesson p-1" style="min-height:82px !important;" id="l_#l_id#">#__btn_note#<br><i class="fal fa-star fa-2x mt-2"></i></button>				   
                                                                                </cfif>
                                                                                <cfelseif get_rating.recordcount neq "0" and (SESSION.USER_ID eq "28538" or SESSION.USER_ID eq "27578") >
                                                                                <button class="btn btn-info btn_rated_lesson p-1 disabled"  style="min-height:82px !important;" id="l_#l_id#">#__btn_note#<br><i class="fal fa-check fa-2x mt-2"></i></button>
                                                                            </cfif>
                                                                        </cfif>
                                                                    </cfif>
                                                                </cfoutput>
                                                            </cfif>
                                                            <!----- RESSOURCES---->        
                                                            <cfdirectory directory="#SESSION.BO_ROOT#/assets/lessons/#t_id#/#session_id#" name="dirQuery" action="LIST">
                                                            <cfif sessionmaster_id neq "696" AND sessionmaster_id neq "697" AND sessionmaster_id neq "695" AND sessionmaster_id neq "694" AND sessionmaster_id neq "1181" AND sessionmaster_id neq "1182" AND sessionmaster_id neq "1183" AND sessionmaster_id neq "769">
                                                                <button class="btn btn-sm btn-outline-info btn_view_session p-1" style="min-height:82px !important;" id="s_#session_id#">#obj_translater.get_translate('btn_el_resources')#
                                                                    <br> <cfif SESSION.LANG_CODE == "DE"> <br></cfif>
                                                                    
                                                                    <i class="fal fa-file-pdf fa-2x mt-2"></i></button>
                                                            <cfelseif dirQuery.recordcount GT 0>
                                                                <button class="btn btn-sm btn-outline-info btn_view_session p-1"  style="min-height:82px !important;" id="s_#session_id#">#obj_translater.get_translate('btn_el_resources')#
                                                                    <br>
                                                                    
                                                                    <i class="fal fa-file-pdf fa-2x mt-2"></i></button>
                                                            </cfif>
                                                            
                                                            <cfif SESSION.USER_ID eq 202 or SESSION.USER_ID eq "2072" or SESSION.USER_ID eq "2586" or SESSION.USER_ID eq "14714">
                                                                <!--- test here --->
                                                                <td width="10%">
                                                                                                                                
                                                                    <a class="btn btn-sm btn-outline-info btn_view_session_test" id="s_#session_id#" href="##"><i class="fa-light fa-eye"></i><br>Details</a>
                                                                    
                                                                </td>
                                                            </cfif>

                                                            <!----- LESSON NOTE---->
                                                            <cfoutput group="lesson_id">				
                                                               															
                                                            <cfif note_id neq "">
                                                                <!--- href="./tpl/ln_container.cfm?l_id=#lesson_id#" --->
                                                                <button class="btn btn-outline-info p-1 btn_open_ln" data-id="#lesson_id#" style="min-height:82px !important;" target="_blank" class="text-secondary">#__card_tp_lessonnote#
                                                                    <br>
                                                                    <i data-id="#lesson_id#" class="fal fa-clipboard-list-check fa-2x mt-2"></i>
                                                                </button>
                                                            </cfif>
                                                            </cfoutput>
                                                                
                                                            <!----- LESSON NOTE ATTACHMENT---->
                                                            <cfif lesson_id neq "">
                                                                <cfset counter = 0>
                                                                <cfloop query="dirQuery">
                                                                <cfif findnocase("#get_session.lesson_id#_",#dirQuery.name#)>
                                                                <cfset counter ++>
                                                                <button target="_blank" class="btn btn-sm btn-outline-info p-1" style="min-height:82px !important;" href="./assets/attachment/#dirQuery.name#">Attachment #counter#
                                                                    <br>
                                                                    <i class="fal fa-file-pdf fa-2x mt-2"></i></button>																		
                                                                </cfif>																					
                                                                </cfloop>
                                                            </cfif>

                                                            <!----- UPLOAD LN FOR F2F---->
                                                            <cfif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND method_id eq "2">
                                                                <button class="btn btn-sm btn-outline-info btn_ln_upload p-1" id="l_#lesson_id#" href="##" style="min-height:82px !important;">#__btn_upload_notes#
                                                                    <br>
                                                                    <i class="fal fa-file-upload fa-2x mt-2" title="#__tooltip_fill_ln#"></i> </button>
                                                            </cfif>
                                                            
                                                            <!----- ELEARNING VERSION ---->
                                                            <cfif sessionmaster_id neq "696" AND sessionmaster_id neq "697" AND sessionmaster_id neq "695" AND sessionmaster_id neq "694" AND sessionmaster_id neq "1181" AND sessionmaster_id neq "1182" AND sessionmaster_id neq "1183" AND sessionmaster_id neq "769" AND sessionmaster_id neq "1267" AND isdefined("SESSION.ACCESS_EL")>
                                                                <cfif sessionmaster_online_el eq "1">
                                                                    <a type="button" class="btn btn-outline-info p-1 btn_player_work <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-smid="#sessionmaster_id#" style="min-height:82px !important;">
                                                                        e-Learning	<br>	
                                                                        <i class="fal fa-laptop fa-2x mt-2"></i>								
                                                                    </a>
                                                                <cfelse>
                                                                    <!------------- VIDEO FORMAT ------------>
                                                                    <cfif tp_orientation_id eq "6">
                                                                        <a type="button" class="btn btn-outline-info p-1 btn_player_work <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-smid="#sessionmaster_id#" style="min-height:82px !important;">
                                                                            e-Learning	<br>	
                                                                            <i class="fal fa-laptop fa-2x mt-2"></i>								
                                                                        </a>
                                                                    <!------------- OLD SCHOOL FORMAT ------------>
                                                                    <cfelse>
                                                                        <a type="button" class="btn btn-outline-info p-1" href="./learner_practice.cfm?sm_id=#sessionmaster_id#" style="min-height:82px !important;">
                                                                            e-Learning
                                                                            <br><cfif SESSION.LANG_CODE == "DE"> <br></cfif>
                                                                            <i class="fal fa-laptop fa-2x mt-2"></i>
                                                                        </a>  
                                                                    </cfif>
                                                                    
                                                                </cfif>
                                                            </cfif>
                                                            
                                                            
                                                            
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                            </div>

                                        </div>
                                    
                                    </li>
                                </cfoutput>
                            </ul>

                        
                        </div>
                    </div>                   

                </cfif>
				
			<cfelse>

				<div class="row justify-content-md-center">

					<div class="col-md-6">
						<div class="alert alert-danger" role="alert">
							<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_tp')#</cfoutput></em></div>
						</div>
					</div>

				</div>
					
			</cfif>

		</div>
      
		<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">
 
<script>

    $(document).ready(function() {
    
        <!----------- TRAINER ONLY / CHANGE LEARNER ---------->
        <cfif SESSION.USER_PROFILE eq "TRAINER">	
            $('.change_learner').change(function(){
                document.location.href="common_tp_details.cfm?u_id="+$(this).val();	
            })	
        </cfif>
      
        <!----------- TRIGGER RATING POPUP ---------->
            <cfif isdefined("go_rating") and isDefined("go_l_id")>
            $('#window_item_lg').modal({keyboard: true});
            $('#modal_title_lg').text("*WEFIT LMS*");		
            $('#modal_body_lg').load("modal_window_ratings.cfm?l_id=<cfoutput>#go_l_id#</cfoutput>");
        </cfif>
        
        <!----------- NEW SESSION EDIT POPUP ---------->
        $('.btn_view_session_test').click(function(event) {	
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var s_id = idtemp[1];
    
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("<cfoutput>#obj_translater.get_translate('js_modal_title_session')#</cfoutput>");
            $('#modal_body_xl').load("modal_window_session_read.cfm?<cfoutput>t_id=#t_id#&u_id=#u_id#</cfoutput>&s_id="+s_id, function() {});
        });
    
    
        <cfif isdefined("go_rating") and isDefined("go_l_id")>
            $('#window_item_lg').modal({keyboard: true});
            $('#modal_title_lg').text("*WEFIT LMS*");		
            $('#modal_body_lg').load("modal_window_ratings.cfm?l_id=<cfoutput>#go_l_id#</cfoutput>");
        </cfif>
    
        <cfoutput>
    
        <!------ WHEN BOOKED 1st LESSON ---->
        <cfif isdefined("tp_firstlesson")>
            $('##window_item_lg').modal({keyboard: true});
            $('##modal_title_lg').text("*WEFIT LMS*");
            $('##modal_body_lg').load("modal_window_info.cfm?show_info=tp_firstlesson<cfif u_id neq 0>&u_id=#u_id#</cfif>&t_id=#t_id#", function() {});
        </cfif>
        
        <!------ WHEN COMONG FROM LAUNCHING ? ---->
        <cfif isdefined("show_result_qpt") AND isdefined("quser_id")>
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('btn_results_test'))#");
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id=#quser_id#&u_id=#u_id#&show_result=answer_analysis", function() {});
        </cfif>
    
        <!------ PLACEMENT TEST BUTTONS ---->
        $('.btn_pass_fpt_start').click(function(event) {	
            event.preventDefault();
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code=#lcase(lang_select)#&choice=fpt&pt_type=start", function() {});
        })
    
        $('.btn_pass_fpt_end').click(function(event) {	
            event.preventDefault();
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code=#lcase(lang_select)#&choice=fpt&pt_type=end", function() {});
        })
    
        <!------ WHEN NEW TRAINER CHOSEN - OBSOLETE ? ---->
        <!---<cfif isdefined("SESSION.show_new_trainer")>
            <cfif SESSION.show_new_trainer neq "-1">
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#");
            $('##modal_body_xl').empty();
            $('##modal_body_xl').load("modal_window_trainer_new.cfm?p_id=#SESSION.show_new_trainer#", function() {});
            </cfif>
        </cfif>--->
    
        <!------ POPUP WITH TRAINER RESUME ---->
        $('.btn_view_trainer').click(function(event) {	
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var p_id = idtemp[1];	
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#");
            $('##modal_body_xl').empty();
            $('##modal_body_xl').load("modal_window_trainerview.cfm?p_id="+p_id, function() {});
        });
        
        <!------ POPUP ADD TRAINER ---->
        $('.btn_edit_trainer').click(function(event) {
            event.preventDefault();
            <cfif tp_trainer.recordCount lt "3">
                $('##window_item_xl').modal({keyboard: true});
                $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_change_trainer'))#");	
                $('##modal_body_xl').empty();	
                $('##modal_body_xl').load("modal_window_tptrainer.cfm?t_id=#t_id#<cfif u_id neq 0>&u_id=#u_id#</cfif>&single=1");
            <cfelse>
               alert("#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#");
            </cfif>
            
        });
    
        // $('.btn_edit_trainer_2').click(function(event) {
        //     event.preventDefault();
        //     <cfif tp_trainer.recordCount lt "3">
        //         $('##window_item_xl').modal({keyboard: true});
        //         $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_change_trainer'))#");	
        //         $('##modal_body_xl').empty();	
        //         $('##modal_body_xl').load("_EM_modal_window_tptrainer.cfm?t_id=#t_id#<cfif u_id neq 0>&u_id=#u_id#</cfif>&single=1");
        //     <cfelse>
        //        alert("#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#");
        //     </cfif>
            
        // });
        <!------ POPUP REMOVE ---->
        $('.btn_del_trainer').click(function(event) {	
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var p_id = idtemp[1];
    
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_remove_trainer'))#");	
            $('##modal_body_xl').empty();	
            $('##modal_body_xl').load("modal_window_tp_remove_trainer.cfm?t_id=#t_id#&u_id=#u_id#&p_id="+p_id);
        });
    
        <!------ OPEN SCHEDULER FOR BOOKING LESSON ------>
        $('.btn_edit_calendar').click(function(event) {		
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var s_id = idtemp[1];		
            var s_dur = idtemp[2];
            var m_id = idtemp[3];
            var t_id = idtemp[4];
        
            $('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_book')# - "+s_dur+" min");
            $('##window_item_lg').modal({keyboard: true});
            $('##modal_body_lg').load("modal_window_calendar.cfm?m_id="+m_id+"&t_id="+t_id+"&u_id=#u_id#&s_dur="+s_dur+"&s_id="+s_id, function() {});
            
        });
        
        <!--------POP UP READ TP THEMES ----->
        $('.btn_read_keyword').click(function(event) {	
            event.preventDefault();		
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var t_id = idtemp[1];	
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_keywords'))#");
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_body_xl').load("modal_window_tp_keyword.cfm?t_id="+t_id, function() {});
        })
        
        <!------ VIEW PLACEMENT TEST RESULTS ------>
        $('.btn_view_qpt').click(function(event) {	
            event.preventDefault();		
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var quiz_user_group_id = idtemp[1];	
            <!--- alert(quiz_user_id); --->
            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('btn_results_test'))#");
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&u_id=#u_id#", function() {});
        })

        <!------ PLAY VIDEO RESOURCE IF EL VERSION ------>
        $('.btn_player_work').click(function(event) {		
            event.preventDefault();
            var sm_id = $(this).attr('data-smid');
            $('##window_item_el_video').modal({});
            $('##modal_title_el_video').text("*WEFIT LMS*");
            $('##modal_body_el_video').empty();
            $('##modal_body_el_video').load("modal_window_el_video.cfm?sm_id="+sm_id);
        
        })

        
        <!------ VIEW PLACEMENT TEST RESULTS ------>
        $("##sortable").sortable({
            items: "li.active",
            opacity: 0.5,
            containment: "parent",
            cursor: "move",
            scroll: true,
            handle: ".handle",
            /*revert: true,*/
            axis: "y",
            update: function (event, ui) {
                var lesson_rank_table = $(this).sortable("toArray");
                console.log(lesson_rank_table);
                
                 
                $.ajax({				  
                    url: './api/tp/tp_post.cfc?method=updt_rank', 
                    type: 'POST',				 
                    data : "lesson_rank_table="+lesson_rank_table, 
                    datatype : "html", 
                    success : function(resultat, statut){ 
                        console.log(resultat); 
                    }, 
                    error : function(resultat, statut, erreur){ 
                        /*console.log(resultat);*/ 
                    }, 
                    complete : function(resultat, statut){ 
                        /*console.log(resultat);*/ 
                    }	 
                }); 
            }
        });
        $("##sortable").disableSelection();
        
    
        <!------ UPLOAD MANUAL LESSON NOTES FOR ADMIN ------>
        <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
        $('.btn_ln_upload').click(function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var l_id = idtemp[1];	
            $('##window_item_lg').modal({keyboard: true});
            $('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");		
            $('##modal_body_lg').load("modal_window_ln_upload.cfm?t_id=#t_id#&u_id=#u_id#&l_id="+l_id);
        });
        </cfif>
        
        <!------ POPUP EDIT LESSON ------>
        $('.btn_edit_session').click(function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var s_id = idtemp[1];	
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_title_xl').text("Edit lesson");		
            $('##modal_body_xl').load("modal_window_session_edit.cfm?t_id=#t_id#&u_id=#u_id#&s_id="+s_id);
        });
        
        <!------ POPUP EDIT LESSON DOCUMENT ------>
        $('.btn_edit_session_document').click(function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var s_id = idtemp[1];	
            $('##window_item_xl').modal({keyboard: true});
            $('##modal_title_xl').text("Edit lesson Document");		
            $('##modal_body_xl').load("modal_window_session_upload.cfm?t_id=#t_id#&u_id=#u_id#&s_id="+s_id);
        });
        
        <!------ POPUP RATING LESSON ------>
        $('.btn_note_lesson').click(function(){
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var l_id = idtemp[1];	
            $('##window_item_lg').modal({keyboard: true,backdrop:'static'});
            $('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_note')#");		
            $('##modal_body_lg').load("modal_window_ratings.cfm?l_id="+l_id);
        });
        </cfoutput>
        
        <!------ POPUP VIEW LESSON NOTE ------>
        $('.btn_open_ln').click(function(event) {	
            event.preventDefault();
    
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("LESSON NOTE");
            $('#modal_body_xl').load("modal_window_ln_viewer.cfm?l_id="+event.target.dataset.id, function() {});
        });
    
        // Get local storage key about modal success, if not null show alert then flush localstorage
        if (localStorage.getItem("close_modal_success") != "") {
            $('#close_modal_success_'+localStorage.getItem("close_modal_success")).collapse('show');
            localStorage.setItem("close_modal_success", "");
        }
    
        <!------ OPEN GROUP TP MANAGEMENT ------>
        $('.btn_edit_tpgroup').click(function(event) {	
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var t_id = idtemp[1];
            var l_id = idtemp[2];
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("TP group");
            $('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
        });
        
        <!------ SORTING TP RANKING ------>
        $("#sort_tp_table").change(function(event) {
            // console.log($(this).val());
            let sort_by = $(this).val();
    
            $("#sortable").find("li").sort(function(a, b) {
                if (sort_by != "-1" && sort_by != "-2"  ) {
                    if (a.dataset.status == sort_by && b.dataset.status != sort_by) return -1;
                    if (a.dataset.status != sort_by && b.dataset.status == sort_by) return 1;
                    return 0;
                } else if (sort_by == "-1") {
                    return(Number(b.dataset.rank) - Number(a.dataset.rank));
                } else if (sort_by == "-2") {
                    return(Number(a.dataset.rank) - Number(b.dataset.rank));
                }
                return(Number(b.dataset.status) - Number(a.dataset.status));
            }).each(function(index, el) {
                $(el).parent().append(el);
            });
        });
        
    })	
    </script>

</body>
</html>
