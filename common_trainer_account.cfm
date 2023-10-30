<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,3,4,5,6,8,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfparam name="tab" default="general">


<cfif SESSION.USER_PROFILE neq "TRAINER" AND not isdefined("p_id")>
    <cflocation addtoken="no" url="index.cfm">
<cfelse>
    <cfif SESSION.USER_PROFILE eq "TRAINER">
        <cfset p_id = SESSION.USER_ID>
        <cfset u_id = SESSION.USER_ID>
    </cfif>

	<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>
    <!--- <cfset get_tps = obj_tp_get.oget_tps(p_id="#p_id#",m_id="12")> --->
    <cfquery name="get_ops" dataSource="#SESSION.BDDSOURCE#"> 
        SELECT t.tp_id FROM lms_tpplanner p
        INNER JOIN lms_tp t ON t.tp_id = p.tp_id
        WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        AND t.method_id = 12 LIMIT 1
    </cfquery>

    <cfset p_id = get_planner.user_id>
    <cfset u_id = get_planner.user_id>
    <cfset user_gender = get_planner.user_gender>
    <cfset user_name = get_planner.user_name>
    <cfset user_email = get_planner.user_email>
    <cfset user_email_2 = get_planner.user_email_2>
    <cfset user_alias = get_planner.user_alias>
    <cfset user_firstname = get_planner.user_firstname>
    <cfset user_phone = get_planner.user_phone>	
    <cfset user_phone_code = get_planner.user_phone_code>	
    <cfset avail_id = get_planner.avail_id>
    <cfset user_based = get_planner.user_based>	
    <cfset user_resume = get_planner.user_resume>
    <cfset user_abstract = get_planner.user_abstract>
    <cfset user_video = get_planner.user_video>
    <cfset user_create = get_planner.user_create>
    <cfset user_video_link = get_planner.user_video_link>

    <cfset country_id_solo = get_planner.country_id>
    <cfset interest_id_solo = get_planner.interest_id>
    <cfset function_id_solo = get_planner.function_id>
    <cfset certif_id_solo = get_planner.certif_id>
    <!--- <cfset perso_id_solo = get_planner.perso_id> --->
    
    <cfset user_remind_1d = get_planner.user_remind_1d>
    <cfset user_remind_3h = get_planner.user_remind_3h>
    <cfset user_remind_15m = get_planner.user_remind_15m>	
    <cfset user_remind_missed = get_planner.user_remind_missed>
    <cfset user_send_late_canceled_24h = get_planner.user_send_late_canceled_24h>
    <cfset user_send_late_canceled_6h = get_planner.user_send_late_canceled_6h>
    <cfset user_remind_cancelled = get_planner.user_remind_cancelled>
    <cfset user_remind_scheduled = get_planner.user_remind_scheduled>

    <cfset user_remind_sms_15m = get_planner.user_remind_sms_15m>
    <cfset user_remind_sms_missed = get_planner.user_remind_sms_missed>
    <cfset user_remind_sms_scheduled = get_planner.user_remind_sms_scheduled>	

    <cfset user_blocker = get_planner.user_blocker>	
    <!--- <cfset user_timezone = get_planner.user_timezone>
    <cfset user_timezone_id = get_planner.timezone_id> --->
    <cfset user_lang = get_planner.user_lang>
    <cfset user_password = get_planner.user_password>

    <cfset user_status_name = get_planner.user_status_name>
    <cfset user_status_id = get_planner.user_status_id>
    <cfset user_status_css = get_planner.user_status_css>

    <cfset user_type_id = get_planner.user_type_id>
    <cfset user_type_name = get_planner.user_type_name>

    <cfloop list="#SESSION.LIST_PT#" index="cor">
    <cfset "user_qpt_#cor#" = evaluate("get_planner.user_qpt_#cor#")>
    <cfset "user_qpt_lock_#cor#" = evaluate("get_planner.user_qpt_lock_#cor#")>
    </cfloop>

    <cfset user_lst = get_planner.user_lst>
    <cfset user_lst_lock = get_planner.user_lst_lock>

    <cfset user_add_learner = get_planner.user_add_learner>
    <cfset user_add_course = get_planner.user_add_course>
    <cfset user_add_weight = get_planner.user_add_weight>
    
    <!------------------ OBJ QUERIES ----------------->
    <cfset get_teaching_solo = obj_query.oget_teaching(p_id="#p_id#")>
    <cfset get_speaking_solo = obj_query.oget_speaking(p_id="#p_id#")>
    <cfset get_personnality_solo = obj_query.oget_personnality(p_id="#p_id#")>
    <cfset get_method_solo = obj_query.oget_method(p_id="#p_id#")>
    <cfset get_country_solo = obj_query.oget_country(p_id="#p_id#")>
    <cfset get_experience_solo = obj_query.oget_experience(p_id="#p_id#")>
    <cfset get_cursus_solo = obj_query.oget_cursus(p_id="#p_id#")>
    <cfset get_interest_solo = obj_query.oget_interest(p_id="#p_id#")>
    <cfset get_function_solo = obj_query.oget_function(p_id="#p_id#")>
    <cfset get_expertise_business_solo = obj_query.oget_expertise_business(p_id="#p_id#")>
    <cfset get_certif_solo = obj_query.oget_certif(p_id="#p_id#")>
    <cfset get_techno_solo = obj_query.oget_techno(p_id="#p_id#")>
    <cfset get_about_solo = obj_query.oget_about(p_id="#p_id#")>
    <cfset get_paragraph_solo = obj_query.oget_paragraph(p_id="#p_id#")>

    <cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#p_id#")>
    <cfset get_result_lst = obj_query.oget_result_lst(p_id="#p_id#")>
    <cfset get_workinghour = obj_query.oget_workinghour(p_id="#p_id#")>

    <cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#p_id#")>

    <cfinvoke component="api/users/user_trainer_get" method="get_trainer_teach_ready" returnvariable="user_ready">
        <cfinvokeargument name="user_id" value="#p_id#">
    </cfinvoke>

    <cfinvoke component="api/users/user_trainer_get" method="get_trainer_links" returnvariable="get_trainer_links">
        <cfinvokeargument name="u_id" value="#p_id#">
    </cfinvoke>

    <cfset get_todo = obj_task_get.oget_log(u_id="#p_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
    <cfset get_feedback = obj_task_get.oget_log(u_id="#p_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>

</cfif>

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	.nav-link {
		color: #999 !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}

    .btn-outline-info {
        border: 1px solid #51bcda !important;
    }

</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfif SESSION.USER_PROFILE eq "learner">
			<cfset title_page = "#obj_translater.get_translate('title_page_my_trainer')#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_common_trainer_trainerview')#">
		</cfif>
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  	  
            <cfif isdefined("k")>
                <cfif k eq "1">
                <div class="alert alert-success" role="alert">
                    <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                </div>
                <cfelseif k eq "2">
                <div class="alert alert-success" role="alert">
                    <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_trainer_ok')#</cfoutput></em></div>
                </div>
                <cfelseif k eq "3">
                <div class="alert alert-success" role="alert">
                    <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_mdp_trainer_reinit')#</cfoutput></em></div>
                </div>
                </cfif>
            
            </cfif>

            <cfinclude template="./incl/incl_nav_trainer.cfm">
		
            <div class="row">
				
                <div class="col-md-12">
                    
                    <div class="card border">

                        <div class="card-body p-2">
                            
                            <!--- <cfoutput> --->
                            <div class="row justify-content-middle">
            
                                <div class="col-lg-3 pt-3" align="center">

                                    <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

                                        <cfoutput>
                                        
                                            <div id="container_picture" align="center">		
                                            #obj_lms.get_thumb(user_id="#p_id#",size="100")#
                                            </div>

                                            <div align="center">
                                            <!--- <form method="post" id="form_picture" name="form_picture" onsubmit="return submit_form_picture();">
                                            <input type="file" name="file_picture" id="file_picture" accept="image/jpeg" required>
                                            <input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
                                            <input type="submit" class="btn btn-info btn-sm" value="upload">
                                            </form> --->
                                            <a href="##" class="btn btn-sm btn_trainer_edit btn-info" id="trainer_photovideo">photo</a>
                                            </div>
        

                                        <h5 class="title">#user_firstname# [<a href="index.cfm?user_name=#user_email#&upass=#user_password#">GO</a>]</h5>
                                        <a href="##" class="btn btn-sm btn_trainer_edit <cfif user_type_id eq "1">btn-danger<cfelse>btn-info</cfif>" id="edit_status">#user_type_name#</a>
                                        <a href="##" class="btn btn-sm btn_trainer_edit btn-info" id="edit_status">#user_status_name#</a>
                                        
                                        <cfif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1") OR SESSION.USER_PROFILE eq "TRAINERMNG">
                                        
                                                <a class="btn btn-sm <cfif get_todo.recordcount neq "0">btn-warning<cfelse>btn-danger</cfif> btn_view_log" id="u_#u_id#" href="##"><i class="fal fa-edit"></i> #get_todo.recordcount# TO DO</a>
                                                <a class="btn btn-sm <cfif get_feedback.recordcount neq "0">btn-info<cfelse>btn-danger</cfif> btn_view_log" id="u_#u_id#" href="##"><i class="fal fa-book"></i> #get_feedback.recordcount# FEEDBACK</a>
                                                <!--- <a class="btn btn_view_log2" id="u_#u_id#" href="##"><i class="fal fa-sticky-note"></i></a> --->
                                                 <!--- <a class="btn btn-info btn_meet_wefit" id="u_#u_id#" href="##"><i class="fa fa-calendar"></i> RDV SETUP</a> --->
                                        
                                            
                                        </cfif>

                                        </cfoutput>

                                        <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/video.mp4")>
                                            <cfoutput>
                                            <video controls preload width="100%" height="100" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/photo_video.jpg")>poster="./assets/user/#p_id#/photo_video.jpg"</cfif>>
                                                <source src="#SESSION.BO_ROOT_URL#/assets/user/#p_id#/video.mp4" type="video/mp4">
                                            </video>
                                            </cfoutput>
                                        </cfif>
                                        
                                        <cfif user_video_link neq "">
                                            <i class="fal fa-video fa-2x"></i>
                                            <br>
                                            <label>Video Link</label>
                                            <br>
                                            <cfoutput><a href="#user_video_link#" target="blank">#user_video_link#</a></cfoutput>
                                        </cfif>


                                    <cfelseif SESSION.USER_PROFILE eq "TRAINER">
                                        <cfoutput>
                                        #obj_lms.get_thumb(user_id="#p_id#",size="100")#					
                                        <h5 class="title">#user_firstname# <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>[<a href="index.cfm?user_name=#user_email#&upass=#user_password#">GO</a>]</cfif></h5>
                                        <a href="##" class="btn btn_trainer_edit <cfif user_type_id eq "1">btn-danger<cfelse>btn-info</cfif>" id="edit_status">#user_type_name#</a>
                                        </cfoutput>
                                    </cfif>

                                
                                </div>
                                
                                
                                <div class="col-lg-6" align="center">

                                    <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                        <cfoutput>
                                            <table class="table table-bordered table-sm bg-white m-0">
                                                <tr>
                                                    <td colspan="2" class="bg-light text-dark">
                                                    <strong> #obj_translater.get_translate('table_th_details')#</strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_details"><i class="fal fa-edit"></i></button></div>
                                                    </td>
                                                </tr>
                                                <!--- <cfif user_video_link neq "">
                                                <tr>						
                                                    <td width="25%" class="bg-light"><label>Video Link</label></td>									
                                                    <td width="75%">#user_video_link#</td>			
                                                </tr>
                                                </cfif> --->
                                                <cfif user_phone neq "">
                                                <tr>						
                                                    <td width="25%" class="bg-light"><label>Phone</label></td>									
                                                    <td width="75%">
                                                        <cfif user_phone_code neq "" AND (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>+#user_phone_code#</cfif> 
                                                        #user_phone#
                                                    </td>		
                                                </tr>
                                                </cfif>
                                                <!---<tr>
                                                    <th colspan="2" class="bg-light"><label>#obj_translater.get_translate('table_th_login')#</label></th>
                                                </tr>--->
                                                <tr>
                                                    <td width="25%" class="bg-light"><label>#obj_translater.get_translate('table_th_email')#</label></td>
                                                    <td>#user_email#</td>
                                                </tr>
                                                <tr>			
                                                    <td width="25%" class="bg-light"><label>#obj_translater.get_translate('table_th_password')#</label></td>
                                                    <td>
                                                        <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                                        <a href="##" class="btn_mdp_launch">[#obj_translater.get_translate('btn_reset')# ]</a>
                                                        <cfelseif SESSION.USER_PROFILE eq "trainer">
                                                        <a href="##" class="btn_edit_mdp">[#obj_translater.get_translate('btn_reset')# ]</a>
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </cfoutput>
                                    </cfif>

                                    <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

                                        <div class="table table-bordered bg-white">
                                            <div class="row bg-light text-dark m-0">
                                              <div class="col p-0"><small><strong>Lang</strong></small></div>
                                              <div class="col p-0"><small><strong>W FR</strong></small></div>
                                              <div class="col p-0"><small><strong>W GER</strong></small></div>
                                              <div class="col p-0"><small><strong>TEST</strong></small></div>
                                              <div class="col p-0"><small><strong>GROUP</strong></small></div>
                                              <div class="col p-0"><small><strong>CLASSIC</strong></small></div>
                                              <div class="col p-0"><small><strong>TM</strong></small></div>
                                              <div class="col p-0"><small><strong>VIP</strong></small></div>
                                              <div class="col p-0"><small><strong>CHILD</strong></small></div>
                                              <div class="col p-0"><small><strong>GYM</strong></small></div>
                                              <div class="col p-0"><small><strong>ASS</strong></small></div>
                                            </div>
                                            <cfoutput query="user_ready">
                                                <div class="row m-0" >
                                                    <div class="col p-0">
                                                        <span class="lang-sm" lang="#lcase(formation_code)#"></span>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_france eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is B2B">OK</a>
                                                        <cfelseif user_ready_france eq "2">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is B2B">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                    <cfif user_ready_germany eq "1">
                                                        <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is from account : CPR FRANCE / CPF FRANCE MKT / POLE EMPLOI / B2C WEB...">OK</a>
                                                    <cfelseif user_ready_germany eq "2">
                                                        <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                    <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is from account : CPR FRANCE / CPF FRANCE MKT / POLE EMPLOI / B2C WEB...">NO</a>
                                                        </cfif>
                                                    </div>
                                            
                                                    <div class="col p-0">
                                                        <cfif user_ready_test eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is TEST">OK</a>
                                                        <cfelseif user_ready_test eq "2">
                                                        <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is TEST">NO</a>
                                                        </cfif>
                                                    </div>
                                                    
                                                    <div class="col p-0">
                                                        <cfif user_ready_group eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top">OK</a>
                                                                    <cfelseif user_ready_group eq "2">
                                                                    <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top">NO</a>
                                                        </cfif>
                                                    </div>
                                                
                                                    <div class="col p-0">
                                                        <cfif user_ready_classic eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is CLASSIC">OK</a>
                                                                        <cfelseif user_ready_classic eq "2">
                                                                    <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is CLASSIC">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_tm eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is TM">OK</a>
                                                        <cfelseif user_ready_tm eq "2">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is TM">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_vip eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is VIP">OK</a>
                                                        <cfelseif user_ready_vip eq "2">
                                                                <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is VIP">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_children eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is a CHILD">OK</a>
                                                        <cfelseif user_ready_children eq "2">
                                                                <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is a CHILD">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_partner eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is a Gymglish Learner">OK</a>
                                                        <cfelseif user_ready_partner eq "2">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner is a Gymglish Learner">NO</a>
                                                        </cfif>
                                                    </div>
                                                    <div class="col p-0">
                                                        <cfif user_ready_assessment eq "1">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-success" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner want an ASSESSMENT">OK</a>
                                                        <cfelseif user_ready_assessment eq "2">
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-warning" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Will be displayed if the learner is SUSPENDED">SUS</a>
                                                        <cfelse>
                                                            <a href="##" class="btn btn-sm p-1 btn_trainer_edit btn-danger" id="edit_ready" data-toggle="tooltip" data-placement="top" title="Won't be displayed if the learner want an ASSESSMENT">NO</a>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </cfoutput>
                                        </div>
                                 
                                        <cfoutput>
                                            <cfif get_ops.recordCount eq 0>
                                                <a href="common_tp_details.cfm?_ops=1&_p_id=#p_id#&t_id=" class="btn btn-info">OPS TP</a>
                                            <cfelse>
                                                <a href="common_tp_details.cfm?t_id=#get_ops.tp_id#" class="btn btn-info">OPS TP</a>
                                            </cfif>
                                        </cfoutput>
                                        
                                    </cfif>

                                </div>


                                <div class="col-lg-3 mb-2" align="center">
                                    <cfoutput>
                                    <table class="table table-bordered table-sm bg-white mb-4">
                                        <tr>
                                            <th colspan="2" class="bg-light text-dark">
                                                #obj_translater.get_translate('table_th_visio_techno')#
                                                <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_techno"><i class="fal fa-edit"></i></button></div>
                                             </th>
                                        </tr>
                                        <!-- Begin the loop through the "get_techno_list" query -->
                                        <cfloop query="get_techno_list">
                                        
                                            <!-- Check if the "user_techno_link" value is not null or empty -->
                                            <cfif len(trim(get_techno_list.user_techno_link))>
                                            
                                            <!-- If the value is not null or empty, display the row -->
                                            <tr>
                                                <td width="50%" class="bg-light">
                                                <label>
                                                    #get_techno_list.techno_alias# 
                                                    
                                                    <!-- Display a star icon if the "user_techno_preferred" value is 1 -->
                                                    <cfif get_techno_list.user_techno_preferred eq "1">
                                                    <i class="fas fa-star text-warning"></i>
                                                    </cfif>
                                                </label>
                                                </td>
                                                
                                                <!-- Display a hyperlink to the "user_techno_link" -->
                                                <td class="text-right">
													<a id='#get_techno_list.user_techno_link#' class="btn btn-sm btn-outline-warning markup-copy">Copy link</a>
												</td>
                                            </tr>
                                            
                                            </cfif>
                                            
                                        </cfloop>
  
                                    </table>
                                   </cfoutput>
                                </div>


                            </div>
                            

                        </div>

                    </div>

                </div>

            </div>

			
            <div class="row">

                <div class="col-md-12">					
                                        
                    <div class="card border">
                        
                        <div class="card-body">

                            <div id="accordion">

                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_specials" <cfif isdefined("trainer_specials")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                        <h5 class="my-1"><i class="fal fa-globe-europe" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_trainer_location_and_language')#</cfoutput></h5>
                                    </button>                                            
                                </div>
                                
                                <div id="trainer_specials" class="<cfif isdefined("trainer_specials")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">
    
                                    <cfif isdefined("trainer_specials")>
                                        <div class="alert alert-success" role="alert" id="alert_specials">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>
                                    
                                    <div class="row">

                                        <div class="col-lg-4">

                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput></strong>
                                                    </td>
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_localisation')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_language"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><cfoutput>#get_country_solo.country_name#</cfoutput></td>
                                                    <td><cfoutput>#user_based#</cfoutput></td>
                                                </tr>
                                            </table>                                                            

                                        </div>

                                        
                                        <div class="col-lg-4">
                        
                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td colspan="2">
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_teached_language')#</cfoutput></strong>
                                                    </td>
                                                    <cfif SESSION.USER_PROFILE neq "TRAINER">
                                                        <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_teached_accent')#</cfoutput></strong>
                                                    </td>
                                                    </cfif>
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_teached_level')#</cfoutput>	</strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_language"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                
                                                <cfoutput>
                                                <cfloop query="get_teaching_solo">	
                                                <cfquery name="get_level_teaching" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_level WHERE level_id IN (#get_teaching_solo.level_id#) ORDER BY level_id
                                                </cfquery>							
                                                <tr>
                                                    <td width="5%">
                                                    <span class="lang-sm" lang="#lcase(get_teaching_solo.formation_code)#"></span>
                                                    </td>
                                                    <td width="30%">
                                                    #get_teaching_solo.formation_name#
                                                    </td>
                                                    <cfif SESSION.USER_PROFILE neq "TRAINER">
                                                    <td width="15%">
                                                    <cfif get_teaching_solo.accent_name eq "">
                                                        -
                                                    <cfelse>
                                                        #get_teaching_solo.accent_name#
                                                    </cfif>
                                                    </td>
                                                    </cfif>
                                                    <td width="40%">
                                                    <cfloop query="get_level_teaching">
                                                    <span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_teaching.level_alias# </span>
                                                    </cfloop>
                                                    </td>
                                                </tr>
                                                </cfloop>	
                                            </cfoutput>
                                                
                                            </table>

                                        </div>

                                        <div class="col-lg-4">
                                            
                                            <table class="table table_speaking table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td colspan="2">
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_language')#</cfoutput></strong>
                                                    </td>
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('level')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_language"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                <cfoutput>
                                                <cfloop query="get_speaking_solo">				
                                                <tr class="tr_speaking_#speaking_id#">
                                                    <td width="5%">
                                                    <span class="lang-sm" lang="#lcase(get_speaking_solo.formation_code)#"></span>
                                                    </td>
                                                    <td width="35%">
                                                    #get_speaking_solo.formation_name#
                                                    </td>
                                                    <td width="50%">
                                                        <cfset level_id = get_speaking_solo.level_id>
                                                        <div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                        
                                                    </td>
                                                </tr>
                                                </cfloop>	
                                            </cfoutput>
                                                
                                            </table>

                                        </div>


                                    </div>
                                </div>							                                                
    
    



















                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_about" <cfif isdefined("trainer_about")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                    <h5 class="my-1"><i class="fal fa-user-secret"></i> <cfoutput>#obj_translater.get_translate('card_trainer_about')#</cfoutput></h5>
                                    </button>
                                </div>


                                <div id="trainer_about" class="<cfif isdefined("trainer_about")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">

                                    <cfif isdefined("trainer_about")>
                                        <div class="alert alert-success" role="alert" id="alert_about">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>

                                    <div class="row">

                                        <div class="col-lg-5">

                                            <table class="table table_teaching table-borderless border">
                                                <cfif get_about_solo.recordcount neq 0>
                                                    <cfoutput>
                                                    <cfloop query="get_about_solo">
                                                        <tr>
                                                            <td class="bg-light text-dark" width="40%">
                                                                <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_about"><i class="fal fa-edit"></i></button></div>
                                        
                                                                <strong>#quest#</strong>
                                                            </td>
                                                            <td>
                                                                #user_about_desc#
                                                            </td>
                                                        </tr>
                                                    </cfloop>
                                                    </cfoutput>
                                                </cfif>
                                                    
                                            </table>                                                            

                                        </div>

                                        <div class="col-lg-4">

                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_about_paragraph')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_about"><i class="fal fa-edit"></i></button></div>
                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <cfif get_paragraph_solo.recordcount neq 0>
                                                            <p align="justify"><cfoutput>#get_paragraph_solo.user_about_desc#</cfoutput></p>
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </table>                                                            

                                        </div>

                                        <div class="col-lg-3">

                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_personnality')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_about"><i class="fal fa-edit"></i></button></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <cfoutput>
                                                        <cfloop query="get_personnality_solo">
                                                            <cfif get_personnality_solo.user_id neq "">
                                                                #perso_name#<br>
                                                            </cfif>
                                                        
                                                        </cfloop>
                                                        </cfoutput>
                                                    </td>
                                                </tr>
                                            </table>                                                            

                                        </div>

                                    </div>

                                </div>
                                





























                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_xp" <cfif isdefined("trainer_xp")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                        <h5 class="my-1"><i class="fal fa-file-alt"></i> <cfoutput>#obj_translater.get_translate('table_th_experience')#</cfoutput></h5>                                                            
                                    </button>
                                </div>
                                
                                <div id="trainer_xp" class="<cfif isdefined("trainer_xp")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">
                                    
                                   <cfif isdefined("trainer_xp")>
                                        <div class="alert alert-success" role="alert" id="alert_xp">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <table class="table table-borderless border">
                                                <tbody class="table_experience">
                                                    <tr class="bg-light text-dark">
                                                        <td>
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong>
                                                        </td>
                                                        <td>
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_experience')#</cfoutput></strong>
                                                            <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_experience"><i class="fal fa-edit"></i></button></div>
                                                        </td>
                                                    </tr>
                                                    <cfoutput>
                                                    <cfloop query="get_experience_solo">
                                                    <tr class="e_#experience_id#">
                                                        <td>
                                                            #ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_experience_solo.experience_start,'mm'))# #year(get_experience_solo.experience_start)# > 
                                                            <cfif get_experience_solo.experience_today eq "1">
                                                                #obj_translater.get_translate("today")#
                                                            <cfelse>
                                                            #ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_experience_solo.experience_end,'mm'))# #year(get_experience_solo.experience_end)#
                                                            </cfif>
                                                        </td>
                                                        <td>
                                                            <strong>#get_experience_solo.experience_title#</strong><br>
                                                            <cfif get_experience_solo.experience_localisation neq ""><p class="my-1">[#get_experience_solo.experience_localisation#]</p></cfif>
                                                            <p class="my-1">#replacenocase(get_experience_solo.experience_description,chr(10),"<br>","ALL")#</p>
                                                        </td>
                                                    </tr>
                                                    </cfloop>
                                                    </cfoutput>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
























                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_cursus" <cfif isdefined("trainer_cursus")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                    <h5 class="my-1"><i class="fal fa-graduation-cap"></i> <cfoutput>#obj_translater.get_translate('table_th_education')#</cfoutput></h5>
                                    </button>
                                </div>
                                
                                <div id="trainer_cursus" class="<cfif isdefined("trainer_cursus")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">

                                    <cfif isdefined("trainer_cursus")>
                                        <div class="alert alert-success" role="alert" id="alert_xp">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <table class="table table-borderless border">
                                                <tbody class="table_cursus">
                                                    <tr class="bg-light text-dark">
                                                        <td>
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong>
                                                        </td>
                                                        <td>
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_education')#</cfoutput></strong>
                                                        </td>
                                                        <td>

                                                            <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_cursus"><i class="fal fa-edit"></i></button></div>
                                                        
                                                        </td>
                                                    </tr>

                                                    <cfoutput>
                                                    <cfloop query="get_cursus_solo">
                                                    <tr class="c_#cursus_id#">
                                                        <td>
                                                            #ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_cursus_solo.cursus_start,'mm'))# #year(get_cursus_solo.cursus_start)# > 
                                                            <cfif get_cursus_solo.cursus_today eq "1">
                                                                #obj_translater.get_translate("today")#
                                                            <cfelse>
                                                            #ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_cursus_solo.cursus_end,'mm'))# #year(get_cursus_solo.cursus_end)#
                                                            </cfif>
                                                        </td>
                                                        <td>
                                                            <strong>#get_cursus_solo.cursus_title#</strong><br>
                                                            <cfif get_cursus_solo.cursus_localisation neq ""><p class="my-1">[#get_cursus_solo.cursus_localisation#]</p></cfif>
                                                            <p class="my-1">#replacenocase(get_cursus_solo.cursus_description,chr(10),"<br>","ALL")#</p>
                                                        </td>
                                                        <td>
                                                            <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/certif_#cursus_id#.pdf") OR fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/certif_#cursus_id#.jpg")>
                                                                <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/certif_#cursus_id#.pdf")>
                                                                    <a target="_blank" href="#SESSION.BO_ROOT_URL#/assets/user/#p_id#/certif_#cursus_id#.pdf" class="btn btn-info btn-sm my-0"><i class="fal fa-eye"></i> #obj_translater.get_translate('btn_view')#</a>
                                                                <cfelse>
                                                                    <a target="_blank" href="#SESSION.BO_ROOT_URL#/assets/user/#p_id#/certif_#cursus_id#.jpg" class="btn btn-info btn-sm my-0"><i class="fal fa-eye"></i> #obj_translater.get_translate('btn_view')#</a>
                                                                </cfif>
                                                                <a class="btn btn-danger btn-sm btn_trainer_edit my-0" id="del_cursusupload_#cursus_id#_#p_id#"><i class="fal fa-trash-alt"></i> #obj_translater.get_translate('btn_update')#</a>
                                                                <a class="btn btn-danger btn-sm btn_cursus_delete my-0" id="del_#cursus_id#_#p_id#"><i class="fal fa-trash-alt"></i> #obj_translater.get_translate('btn_delete')#</a>
                                                            <cfelse>
                                                                <button class="btn btn-info btn-sm btn_trainer_edit my-0" id="edit_cursusupload_#cursus_id#"><i class="fal fa-upload"></i> UPLOAD</button>
                                                            </cfif>
                                                        </td>
                                                    </tr>
                                                    </cfloop>
                                                    </cfoutput>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                                    
                                





















                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_interest" <cfif isdefined("trainer_interest")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                    <h5 class="my-1"><i class="fal fa-tasks-alt"></i> Skills & Interests</h5>
                                    </button>
                                </div>


                                <div id="trainer_interest" class="<cfif isdefined("trainer_interest")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">

                                    <cfif isdefined("trainer_interest")>
                                        <div class="alert alert-success" role="alert" id="alert_xp">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>
                                    
                                    <div class="row">

                                        <div class="col-lg-6">
                                                
                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_business')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_interest"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <cfif get_function_solo.recordcount neq "0">                                                            
                                                            <cfoutput>
                                                            <cfloop query="get_function_solo">
                                                                <span class="badge badge-pill bg-white border p-2 mb-2 badge-light font-weight-normal">#keyword_name#</span>
                                                            </cfloop>
                                                            </cfoutput>
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </table>  

                                        </div>


                                        <div class="col-lg-6">

                                            <table class="table table_teaching table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_interests')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_interest"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <cfif get_interest_solo.recordcount neq "0">                                                            
                                                            <cfoutput>
                                                            <cfloop query="get_interest_solo">
                                                                <span class="badge badge-pill bg-white border p-2 mb-2 badge-light font-weight-normal">#keyword_name#</span>
                                                            </cfloop>
                                                            </cfoutput>
                                                        </cfif>
                                                    </td>
                                                </tr>
                                            </table>                                                            

                                        </div>

                                    </div>

                                </div>




                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_expertise" <cfif isdefined("trainer_expertise")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                    <h5 class="my-1"><i class="fal fa-file-certificate"></i> <cfoutput>#obj_translater.get_translate('table_th_expertise')#</cfoutput></h5>
                                    </button>
                                </div>


                                <div id="trainer_expertise" class="<cfif isdefined("trainer_expertise")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">

                                    <cfif isdefined("trainer_expertise")>
                                        <div class="alert alert-success" role="alert" id="alert_xp">
                                            <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </cfif>

                                    <div class="row">

                                        <div class="col-lg-6">
                                                
                                            <table class="table table_business_expertise table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_expertise_business_area')#</cfoutput></strong>
                                                    </td>
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_expertise_practical')#</cfoutput></strong>
                                                    </td>
                                                    <td>
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_expertise_taught')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_expertise"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                <cfoutput query="get_expertise_business_solo">
                                                    <tr class="tr_expertise_#expertise_business_id#">
                                                        <td>#keyword_name#</td>
                                                        <td>
                                                            <cfif expertise_business_practical_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_practical_duration# <cfif expertise_business_practical_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
                                                        </td>
                                                        <td>
                                                            <cfif expertise_business_teaching_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_teaching_duration# <cfif expertise_business_teaching_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
                                                        </td>
                                                    </tr>
                                                </cfoutput>
                                                
                                            </table>  

                                        </div>

                                        <div class="col-lg-6">
                                                
                                            <table class="table table_certif table-borderless border">
                                                <tr class="bg-light text-dark">
                                                    <td colspan="2">
                                                        <strong><cfoutput>#obj_translater.get_translate('table_th_exam_preparation')#</cfoutput></strong>
                                                        <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_expertise"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                    </td>
                                                </tr>
                                                <cfoutput query="get_certif_solo">
                                                <tr>
                                                    <cfif get_certif_solo.user_id neq "">
                                                        <td>#certif_name#</td>
                                                    </cfif>
                                                    
                                                </tr>
                                                </cfoutput>
                                                
                                            </table>  

                                        </div>

                                    </div>

                                </div>







                                <cfif listFindNoCase("FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND SESSION.USER_ISMANAGER eq 1>
                                    <div>
                                        <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_docs" <cfif isdefined("trainer_docs")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                        <h5 class="my-1"><i class="fal fa-signature"></i> <cfoutput>WEFIT TRAINING</cfoutput></h5>
                                        </button>
                                    </div>
								
									<div id="trainer_docs" class="collapse" data-parent="#accordion">
										<table class="table m-0">
											<tr>
												<td valign="top">
													<div class="row">
										
														<!--- ! BO_ROOT_URL --->
														<!--- <cfset dir_go = "/home/www/wnotedev1/admin/user_doc/#u_id#/"> --->
														<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#u_id#/#hash(u_id)#">
										
														<div class="col-md-6">
															<table class="table table-sm table-bordered" id="file_holder">
										
																<!--- <tr>
																	<th class="bg-light" colspan="2">
																	<div align="center"><label>PI&Egrave;CE JOINTE</label></div>
																	</th>
																</tr> --->
																	
																<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
																
																<cfif dirQuery.recordcount eq "0">
																	<tr id="file_none">
																		<td colspan="2" align="center"><em>Aucun fichier</em></td>
																	</tr>
																<cfelse>
																
																	<cfoutput>
																	<cfloop query="dirQuery">
																	<tr id="file_#dirQuery.currentRow#">
																		<!--- <th class="bg-light" width="30%">
																		<label>Fichier</label>
																		</th> --->
																		<td colspan="2">
																		<a href="./assets/user/#u_id#/#hash(u_id)#/#name#" target="_blank">
																			<span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 40ch;">#name#</span>
																		</a>
																		
																		<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
																		<!---  --->
																		<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="#name#" id="delete_doc_#dirQuery.currentRow#"><i class="fal fa-trash-alt"></i></i></a>
																	</td>
																	</tr>
																	
																	</cfloop>
																	</cfoutput>
																
																</cfif>
														
															</table>
														</div>
														
														<div class="col-md-6">
										
															<form id="form_doc" name="form_doc">
										
															<table class="table table-sm table-bordered">
											
																<tr>
																	<td>
										
																		<input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc,.pptx">
										
																	</td>
																	<td>
																		<!--- <input type="hidden" name="t_id" value="<cfoutput>#t_id#</cfoutput>">
																		<input type="hidden" name="s_id" value="<cfoutput>#s_id#</cfoutput>"> --->
																		<input type="hidden" name="dir_go" value="<cfoutput>#dir_go#</cfoutput>">
																		<input type="submit" class="btn btn-info btn-sm" id="doc_upload_submit" value="upload">
																	</td>
																	
																</tr>
																<tr>
																	<td colspan="2">
																		<div class="progress">
																			<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_doc" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
																		</div>
																	</td>
																</tr>
															</table>
										
															</form>
										
														</div>
														
													</div>
													
												</td>
											</tr>
										</table>
									</div>
								</cfif>













                                <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                <div>
                                    <button class="btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_contracts" <cfif isdefined("trainer_contracts")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                    <h5 class="my-1"><i class="fal fa-signature"></i> <cfoutput>Charter, Contracts & Docs</cfoutput></h5>
                                    </button>
                                </div>
                            
                                <div id="trainer_contracts" class="collapse" data-parent="#accordion">
                                
                                    <table class="table table-sm">
                                        <tr>
                                            <th class="bg-light" colspan="2">
                                                <label>Charte du formateur</label>
                                            </th>
                                            <td>
                                                <div class="float-right"><a class="btn btn-info btn-sm btn_trainer_edit_charter my-0" href="trainer_sign.cfm?view=trainer_charter&p_id=<cfoutput>#p_id#</cfoutput>"><i class="fal fa-edit"></i></a></div>
                                            
                                            </th>
                                        </tr>
                                        <tr>
                                            <th class="bg-light" colspan="2">
                                                <label>Contrat formateur</label>
                                            </th>
                                            <td>
                                                <div class="float-right"><a class="btn btn-info btn-sm btn_trainer_edit_contract my-0" href="trainer_sign.cfm?view=trainer_contract&p_id=<cfoutput>#p_id#</cfoutput>"><i class="fal fa-edit"></i></a></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <cfdirectory directory="/home/www/wnotedev1/admin/contract/#p_id#/" name="dirQuery" action="LIST">
	
                                            <cfoutput query="dirQuery">
                                                <td>
                                                    <a href="tpl/trainer_contract_view.cfm?name=#name#&p_id=#p_id#" target="_blank">#name#</a>
                                                <!--- <a href="updater_upload.cfm?lesson_delete=#name#&l_id=#l_id#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
                                                </td>
                                            </cfoutput>
                                        </tr>
                                        <tr>
                                            <th class="bg-light" width="120">
                                                <label>Usefull links</label>
                                             </th>
                                            <td>
                                                <div class="container_links">
                                                    <table class="table">
                                                    <cfoutput query="get_trainer_links">
                                                    <tr>
                                                        <td>#link_name#</td>
                                                        <td><a href="#link_url#">#mid(link_url,1,50)# [...]</a></td>
                                                    </tr>
                                                    </cfoutput>
                                                </table>
                                                </div>

                                            </td>
                                        </tr>
                                    </table>
                                
                                </div>
                                </cfif>






























                                    <cfif (SESSION.USER_PROFILE eq "trainer" AND SESSION.USER_STATUS_ID eq "4") OR (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
                                    <div>
                                        <button class="btn btn-outline-btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_settings" <cfif isdefined("trainer_settings")>aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                            <h5 class="my-1"><i class="fal fa-cog"></i> <cfoutput>#obj_translater.get_translate('accordion_settings')#</cfoutput></h5>
                                        </button>
                                    </div>
                                    
                                    <div id="trainer_settings" class="<cfif isdefined("trainer_settings")>collapse show<cfelse>collapse</cfif>" data-parent="#accordion">

                                        <cfif isdefined("trainer_settings")>
                                            <div class="alert alert-success" role="alert" id="alert_settings">
                                                <div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></em></div>
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </cfif>

                                        <div class="row">
                                            
                                            <div class="col-lg-6">
                                                    
                                                <table class="table table_teaching table-borderless border">
                                                    <tr class="bg-light text-dark">
                                                        <td colspan="2">
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_params')#</cfoutput></strong>
                                                            <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_settings"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_lms_language')#</cfoutput></label></td>
                                                        <td>
                                                            <cfoutput><span class="lang-sm lang-lbl" lang="#lcase(user_lang)#"></span></cfoutput>
                                                        </td>
                                                    </tr>
                                                    <!--- <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_timezone')#</cfoutput></label></td>
                                                        <td><cfoutput>#user_timezone#</cfoutput></td>
                                                    </tr> --->
                                                    <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_blocker')#</cfoutput></label></td>
                                                        <td><cfoutput><cfif user_blocker eq "0">#obj_translater.get_translate('no')#<cfelse>#user_blocker# min</cfif></cfoutput></td>
                                                    </tr>
                                                    <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                                        <tr>
                                                            <td><label><cfoutput>weight</cfoutput></label></td>
                                                            <td><cfoutput>#user_add_weight#</cfoutput></td>
                                                        </tr>
                                                    </cfif>
                                                </table>  

                                            </div>

                                            <div class="col-lg-6">
                                                    
                                                <table class="table table_teaching table-borderless border">
                                                    <tr class="bg-light text-dark">
                                                        <td colspan="4">
                                                            <strong><cfoutput>#obj_translater.get_translate('table_th_notifications')#</cfoutput></strong>
                                                            <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_settings"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="25%"><label><cfoutput>#obj_translater.get_translate('table_th_24h')#</cfoutput></label></td>
                                                        <td width="25%"><cfif user_remind_1d eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                        <td width="25%"><label><cfoutput>#obj_translater.get_translate('table_th_scheduled_lesson')#</cfoutput></label></td>
                                                        <td width="25%"><cfif user_remind_scheduled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                    </tr>
                                                    <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_3h')#</cfoutput></label></td>
                                                        <td><cfif user_remind_3h eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_cancelled_lesson')#</cfoutput></label></td>
                                                        <td><cfif user_remind_cancelled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                    </tr>
                                                    <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_15m')#</cfoutput></label></td>
                                                        <td><cfif user_remind_15m eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_th_missed_lesson')#</cfoutput></label></td>
                                                        <td><cfif user_remind_missed eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                    </tr>
                                                </table>  

                                            </div>

                                            <div class="col-lg-6">
                                                    
                                                <table class="table table_teaching table-borderless border">
                                                    <tr class="bg-light text-dark">
                                                        <td colspan="4">
                                                            <strong><cfoutput>#obj_translater.get_translate('table_trainer_notif_cancel_title')#</cfoutput></strong>
                                                            <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit p-1" id="edit_settings"><i class="fal fa-edit" aria-hidden="true"></i></button></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="25%"><label><cfoutput>#obj_translater.get_translate('table_trainer_notif_cancel_24h')#</cfoutput></label></td>
                                                        <td width="25%"><cfif user_send_late_canceled_24h eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                        <td width="25%"></td>
                                                        <td width="25%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td><label><cfoutput>#obj_translater.get_translate('table_trainer_notif_cancel_6h')#</cfoutput></label></td>
                                                        <td><cfif user_send_late_canceled_6h eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </table>  

                                            </div>

                                        </div>

                                    </div>

                                    </cfif>
                                            
                                            <!---<tr>
                                                <th colspan="4" class="bg-light">
                                                    <label><cfoutput>#obj_translater.get_translate('table_th_notifications_sms')#</cfoutput></label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td><label><cfoutput>#obj_translater.get_translate('table_th_15m')#</cfoutput></label></td>
                                                <td><cfif user_remind_sms_15m eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                                <td><label><cfoutput>#obj_translater.get_translate('table_th_missed_lesson')#</cfoutput></label></td>
                                                <td><cfif user_remind_sms_missed eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td><label><cfoutput>#obj_translater.get_translate('table_th_scheduled_lesson')#</cfoutput></label></td>
                                                <td><cfif user_remind_sms_scheduled eq "1"><i class="fal fa-check-circle text-success"></i><cfelse><i class="fal fa-times-circle text-danger"></i></cfif></td>
                                            </tr>--->
                                            




































                                <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>	
                                <!-------------------------------- TESTS --------------------------->
                                <div>
                                    <button class="btn btn-outline-btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#tests">
                                        <h5 class="my-1"><i class="fal fa-tasks"></i> <cfoutput>#obj_translater.get_translate('table_th_tests')#</cfoutput> </h5>
                                    </button>
                                </div>
                                
                                <div id="tests" class="collapse" data-parent="#accordion">
                                
                                    <cfoutput>
                                        <cfloop list="#SESSION.LIST_PT#" index="lang_select">
                                        <cfset get_distinct_pt = obj_query.oget_distinct_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#")>
                                                
                                        <cfif get_distinct_pt.recordcount neq "0">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="card border">
                                                        <cfloop query="get_distinct_pt">
                                                            <cfif quiz_user_group_id neq "">
                                                            <div class="d-flex align-items-center">
                                                                <div class="m-2">
                                                                    <img src="./assets/img/training_#lang_select#.png" width="50"></span>
                                                                </div>
                                                                <div class="m-2">
                                                                    #obj_dater.get_dateformat(quiz_user_start)#
                                                                </div>
                                                                <div class="m-2">
                                                                    <cfif pt_speed eq "fpt">
                                                                        <span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
                                                                        <!--- FULL PLACEMENT TEST --->
                                                                    <cfelseif pt_speed eq "qpt">
                                                                        <span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
                                                                        <!--- QUICK PLACEMENT TEST --->
                                                                    </cfif>
                                                                </div>
                                                                <div class="m-2">
                                                                    <cfset get_pt = obj_query.oget_pt(u_id="#u_id#",quiz_type="qpt_#lang_select#",quiz_user_group_id="#quiz_user_group_id#")>
                                                                    <cfset quiz_type = get_pt.quiz_type>
																	<cfif isDefined("quiz_type") AND quiz_type neq "">
																		<cfinclude template="./incl/incl_pt_result.cfm">
																	</cfif>
                                                                </div>	
                                                                <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                                                <div class="m-2">
                                                                    <cfoutput>
                                                                    <a href="updater_quiz.cfm?del_qpt_#lang_select#=1&u_id=#u_id#&quiz_user_group_id=#quiz_user_group_id#" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-trash-alt"></i></a>
                                                                    </cfoutput>	
                                                                </div>	
                                                                </cfif>																	
                                                            </div>
                                                            </cfif>
                                                        </cfloop>
                                                    </div>
                                                </div>
                                            </div>
                                        <cfelse>
                                            <cfif evaluate("user_qpt_#lang_select#") neq "" AND (evaluate("user_qpt_lock_#lang_select#") eq "0" OR evaluate("user_qpt_lock_#lang_select#") eq "")>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="card border">
                                                            <cfoutput>
                                                                <cfif findnocase("A0",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "success">
                                                                <cfelseif findnocase("A1",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "success">
                                                                <cfelseif findnocase("A2",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "primary">
                                                                <cfelseif findnocase("B1",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "info">
                                                                <cfelseif findnocase("B2",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "warning">
                                                                <cfelseif findnocase("C1",evaluate("user_qpt_#lang_select#"))>
                                                                    <cfset css = "danger">
                                                                </cfif>
                                                                <div class="d-flex align-items-center">
                                                                    <div class="m-2">
                                                                        <img src="./assets/img/training_#lang_select#.png" width="50"></span>
                                                                    </div>
                                                                    <div class="m-2">
                                                                        #obj_translater.get_translate('text_not_verified')#
                                                                    </div>
                                                                    <div class="m-2">
                                                                        <a class="badge badge-#css# badge-pill p-3 mt-2 font-weight-normal text-white" style="font-size:14px">
                                                                        #obj_translater.get_translate('table_th_global_level')#
                                                                        <br>
                                                                        <h6 class="mt-1 mb-0">#evaluate("user_qpt_#lang_select#")#</h6>
                                                                        </a>
                                                                    </div>																			
                                                                </div>
                                                            </cfoutput>		
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfif>
                                        </cfif>
                                    </cfloop>
                                    </cfoutput>
                                
                                    <table class="table table-sm">
                                        <tr>
                                            <td width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_mini_lst')#</cfoutput></label></td>
                                            <cfif user_lst neq "">
                                                <cfif get_result_lst.recordcount neq "0">
                                                    <td>
                                                    <cfif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end neq "">
                                                        <cfoutput><a href="##" class="btn btn-sm btn-success btn_view_quiz" id="quser_#get_result_lst.quiz_user_id#">#obj_translater.get_translate('btn_results_test')#</a></cfoutput>
                                                    <cfelseif get_result_lst.recordcount neq "0" AND get_result_lst.quiz_user_end eq "">
                                                        <cfif SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "learner">
                                                        <cfoutput><a href="./quiz.cfm?quiz_user_id=#get_result_lst.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-danger">#obj_translater.get_translate('btn_continue')# test</a></cfoutput>
                                                        </cfif>																
                                                    </cfif>	
                                                    </td>	
                                                    <td align="right">
                                                    <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>															
                                                        <cfoutput>
                                                        <a href="updater_quiz.cfm?del_lst=1&p_id=#p_id#" class="btn btn-outline-success btn-sm my-0"><i class="far fa-trash-alt"></i></a>
                                                        </cfoutput>															
                                                    </cfif>	
                                                    </td>															
                                                </cfif>
                                            <cfelse>
                                                <td colspan="2">
                                                <cfif SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "learner">
                                                    <a href="quiz_start.cfm?t=lst" class="btn btn-sm btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
                                                </cfif>
                                                </td>
                                            </cfif>
                                        </tr>
                                    </table>
                                        
                                </div>
                                </cfif>
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                 <cfif SESSION.USER_PROFILE eq "trainer"> 
                                 <cfif SESSION.USER_STATUS_ID eq "4"> 

                                    <!-------------------------------- SIGNATURE --------------------------->
                                <div>
                                    <button class="btn btn-outline-btn btn-outline-info btn-block text-left p-3" data-toggle="collapse" data-target="#trainer_sign">
                                        <h5 class="my-1"><i class="fal fa-signature"></i> <cfoutput>#obj_translater.get_translate('card_trainer_signature')#</cfoutput>  </h5>
                                    </button>
                                </div>

                                <div id="trainer_sign" class="collapse" data-parent="#accordion">
                                
                                     <table class="table table-sm"> 
                                         <tr> 
                                             <th class="bg-light"> 
                                                 <label><cfoutput>#obj_translater.get_translate('card_trainer_signature')#</cfoutput></label> 
                                                 <div class="float-right"><button class="btn btn-info btn-sm btn_trainer_edit_signature my-0"><i class="fal fa-edit"></i></button></div> 
                                             </th> 
                                         </tr> 
                                         <tr> 
                                             <td align="center"> 
                                             <div class="border"> 
                                                 <cfoutput>#obj_lms.get_trainer_signature(p_id="#p_id#", size="300")#</cfoutput> 
                                             </div> 
                                             </td> 
                                         </tr> 
                                     </table> 
                                
                                
                                 </div> 
                                </cfif> 
                                </cfif>
                                            
                                
                                            
            
                        </div>
                        
                    </div>
                
                </div>
                    
				
			</div>
			
		</div>
			
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
    <cfinclude template="./incl/incl_scripts_param.cfm">
</cfif>

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">


<script>

    function submit_form_picture() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_picture"));

        console.log(fd),

		$.ajax({
			url        : './components/trainer.cfc?method=upload_picture',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				return jqXHR;
			},
			success    : function ( data )
			{
                console.log(data);
					$("#container_picture").empty().append('<img src="./assets/user/<cfoutput>#p_id#</cfoutput>/photo.jpg" class="rounded-circle" width="180">');
			}
		});

	};

$(document).ready(function() {
<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>


    <cfoutput>

        // Attach a click event listener to any element with class "markup-copy" on the document
$(document).on("click", ".markup-copy", async function(event) {
  // Prevent the default action of clicking on a link or button
  event.preventDefault();

  // Get the value of the "id" attribute of the clicked element
  var link = $(this).attr("id");

  try {
    // Use the Clipboard API to write the link to the clipboard
    await navigator.clipboard.writeText(link);

    // If the copy was successful, display an alert message with the link
    alert("#encodeForJavaScript(obj_translater.get_translate('alert_link_copied'))#: " + link);
  } catch (error) {
    // If the copy failed, display an error message
    alert("Failed to copy link to clipboard. Please try again.");
  }
});

    </cfoutput>

	/******************** VIEW LOG *****************************/	
	$('.btn_view_log').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Follow-Up");
		$('#modal_body_xl').load("modal_window_log.cfm?u_id="+u_id, function() {});
	});

    
    $('.btn_trainer_edit_signature').click(function(event) {	
        event.preventDefault();		
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_title_xl').text("Signature");
        $('#modal_body_xl').load("modal_window_trainer.cfm?display=signature", function() {});
    });



	<cfoutput>
	$('.btn_view_qpt').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_group_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&u_id=#p_id#", function() {});
	})

    $('.btn_view_quiz').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#p_id#", function() {});
	})

	</cfoutput>
	
	$('.btn_trainer_edit').click(function(event) {
		event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
		var display = idtemp[1];
        var id = idtemp[2];
		$('#window_item_xl').modal({keyboard: true});
		/*$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_avail_edit')#</cfoutput>");*/
        if(typeof id != 'undefined')
        {
            $('#modal_body_xl').load("modal_window_trainer.cfm?display="+display+"&p_id=<cfoutput>#p_id#</cfoutput>&id="+id);
        }            
        else
        {
            $('#modal_body_xl').load("modal_window_trainer.cfm?display="+display+"&p_id=<cfoutput>#p_id#</cfoutput>");
        }
	});


	<cfif isdefined("view") AND view eq "validate">
		$('#window_item_xl_unclosable').modal({keyboard: false,backdrop:'static'});
		$('#modal_title_xl_unclosable').text("<cfoutput>#obj_translater.get_translate('js_modal_title_welcome')#</cfoutput>");		
		$('#modal_body_xl_unclosable').load("modal_window_trainer.cfm?display=welcome");
	<cfelseif isdefined("view") AND view eq "confirm">
		$('#window_item_xl_unclosable').modal({keyboard: false,backdrop:'static'});
		$('#modal_title_xl_unclosable').text("<cfoutput>#obj_translater.get_translate('js_modal_title_welcome')#</cfoutput>");		
		$('#modal_body_xl_unclosable').load("modal_window_trainer.cfm?display=confirm");
	</cfif>
	

    $('.btn_mdp_launch').click(function(event) {	
        event.preventDefault();
        $('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("R\u00e9initialiser mot de passe");
        $('#modal_body_lg').load("modal_window_launch_trainer.cfm?mdp_launch=1&p_id=<cfoutput>#p_id#</cfoutput>", function() {});
    });
    
    $('.btn_edit_mdp').click(function(event) {	
        event.preventDefault();
        $('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");
        $('#modal_body_lg').load("_modal_window_mdp_reset.cfm?reinit=1", function() {});

    });
	
	</cfif>

    <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

    var handler_remove = function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		idtemp = idtemp.split("delete_doc_");
		var doc_pos = idtemp[1];
		var doc_name = $(this).attr("name");
		console.log("hello", doc_pos, doc_name);

		var fd = new FormData();
		fd.set("name", doc_name);
		fd.set("u_id", <cfoutput>#u_id#</cfoutput>);

		$.ajax({
		url        : './api/users/user_trainer_post.cfc?method=delete_learner_doc',
		type       : 'POST',
		data       : fd,
		enctype	   : 'multipart/form-data',
		contentType: false,
		cache      : false,
		processData: false,
		success    : function ( data )
		{

			console.log("yeah", data)
			// console.log(obj.CLIENTFILE)
			$("#file_" + doc_pos ).remove();

		}
	});

    };
    $(".remove_doc").bind("click",handler_remove);

    
    $("#doc_upload_submit").click(function(event) {
	<!--- function submit_form_doc() { --->
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_doc"));

        console.log("submit_form_doc");
		$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=upload_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_doc").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_doc").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{

				var doc_length = $('#file_holder tr').length;
				const obj = JSON.parse(data);
				// console.log("yeah", data)
				console.log(doc_length)
				console.log(obj)

				setTimeout(function (){

					if (!obj.FILEWASOVERWRITTEN) {
						$("#file_none").empty();
						var new_doc = '<tr id="file_'+ (doc_length + 1) + '"><td colspan="2">';
						new_doc += '<a href="./assets/user/<cfoutput>#u_id#</cfoutput>/<cfoutput>#hash(u_id)#</cfoutput>/'+ obj.CLIENTFILE + '" target="_blank">'+ obj.CLIENTFILE + '</a>';
						<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
						new_doc += '<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="'+ obj.CLIENTFILE + '" id="delete_doc_'+ (doc_length + 1) + '">';
						new_doc += '<i class="fal fa-trash-alt"></i></i></a></td></tr>;';
						$("#file_holder").append(new_doc);

						$(".remove_doc").bind("click",handler_remove);
					}

					// if ((doc_length + 1) > 3)  {
					// 	$("#doc_upload_submit").prop("disabled",true);
					// 	$("#doc_attach").prop("disabled",true);
					// }
					

					$("#progress_doc").css("width","0%");	
				}, 1000);

			}
		});
			
					
	});
    </cfif>

    $('.btn_cursus_delete').click(function(event) {
		event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        console.logid(idtemp);

		var cursus_id = idtemp[1];
        var p_id = idtemp[2];
	});

});

</script>




</body>
</html>
