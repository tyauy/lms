<!DOCTYPE html>

<cfsilent>

    <cfparam name="f_id" default="2">

    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
    </cfquery>

    <cfloop list="1,2,6" index="cor">
    <cfquery name="get_session_access_#cor#" datasource="#SESSION.BDDSOURCE#">
    SELECT
    em.elearning_module_id, em.elearning_module_path, 
    sm.sessionmaster_id, sm.tp_orientation_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource,
    CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
    CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
    CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
    tm.module_id, CASE WHEN tm.module_name_#SESSION.LANG_CODE# IS NOT NULL AND tm.module_name_#SESSION.LANG_CODE# <> " " THEN tm.module_name_#SESSION.LANG_CODE# ELSE module_name END AS module_name,
    l.level_alias, l.level_id, sm.level_id as sm_level_id,
    emu.update_date, emu.elearning_completion

    
    FROM lms_elearning_module em
    INNER JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id	
    INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
    INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 
    LEFT JOIN lms_tpmodulemaster2 tm on tm.module_id = sm.module_id 
    
    LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    LEFT JOIN lms_level l ON l.level_id = sm.level_id

    WHERE sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">

    GROUP BY em.elearning_module_id, sm.sessionmaster_id
    ORDER BY sm.module_id, em.elearning_module_id
    </cfquery>
    </cfloop>

</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>
    </style>
</head>

<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "*WEFIT LMS*">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row mt-3">
    
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        
                        <div class="card border bg-light">
                    
                            <div class="card-body">
                                                
                                <div class="d-flex w-100 justify-content-around" align="center">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-thin fa-timer fa-2x text-red mr-4"></i>
                                        <div>
                                            <cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
                                            <cfoutput>#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#</cfoutput>
                                            <cfelse>
                                            -
                                            </cfif>
                                            <br><small><strong><cfoutput>#obj_translater.get_translate('table_th_total_lms')#</cfoutput></strong></small>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="fa-thin fa-gauge-high fa-2x text-red mr-4"></i>
                                        <div>
                                            -<br><small><strong><cfoutput>#obj_translater.get_translate('table_th_progress')#</cfoutput></strong></small>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="fa-thin fa-circle-check fa-2x text-red mr-4"></i>
                                        <div>
                                            0<br><small><strong><cfoutput>#obj_translater.get_translate('table_th_completed_course')#</cfoutput></strong></small>
                                        </div>
                                    </div>
                                    <!--- <div>
                                        <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                        <br> --->
                                        34<br><small><strong>Skills maîtrisées</strong></small>
                                    </div> --->
                                    <div class="d-flex align-items-center">
                                        <!--- <span class="badge badge-pill badge-red"><h4 class="mt-1">A2.2</h4></span>
                                        <br> --->

                                        <div class="d-flex align-items-center">
                                            <cfif StructKeyExists(SESSION.USER_LEVEL,'en')>
                                                <cfset level_sub_id = SESSION.USER_LEVEL['en'].level_sub_id>
                                                <cfset level_id = SESSION.USER_LEVEL['en'].level_id>
                                                <cfif level_sub_id neq "">
                                                    <cfoutput><img src="./assets/img_sublevel/#level_sub_id#_plain.svg" width="35" class="mr-4"></cfoutput>
                                                <cfelse>
                                                    <cfoutput><img src="./assets/img_level/#level_id#.svg" width="35" class="mr-4"></cfoutput>
                                                </cfif>
                                            <cfelse>
                                                -
                                            </cfif>
                                        </div>

                                        <div>

                                            

                                            -<br><small><strong><cfoutput>#obj_translater.get_translate('card_learner_your_level')#</cfoutput></strong></small>
                                        </div>
                                    </div>
                                </div>
                
                            </div>
                        </div>

                    </div>

                </div>

                <!---------------------- NO ACTIVITY, DISPLAY GRID ------------------------->
                <cfif get_session_access_1.recordcount eq "0" AND get_session_access_2.recordcount eq "0" AND get_session_access_6.recordcount eq "0">

                    <div class="row">

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card header_rounded_top">
                                <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_1.jpg">
                                <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
                                                
                                    <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_business_english')#</cfoutput></h5>
                                    <p align="center">
                                        <cfoutput>#obj_translater.get_translate('card_desc_business_english')#</cfoutput>
                                    </p>
                                    <div align="center" class="mt-auto">
                                        <button class="btn btn-outline-red btn_open_el" data-menu="business"><cfoutput>#obj_translater.get_translate('btn_add_resource_business')#</cfoutput></button>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card header_rounded_top">
                                <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_2.jpg">
                                <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
                                                
                                    <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_general_english')#</cfoutput></h5>
                                    <p align="center">
                                        <cfoutput>#obj_translater.get_translate('card_desc_general_english')#</cfoutput>
                                    </p>
                                    <div align="center" class="mt-auto">
                                        <button class="btn btn-outline-red btn_open_el" data-menu="general"><cfoutput>#obj_translater.get_translate('btn_add_resource_general')#</cfoutput></button>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card header_rounded_top">
                                <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_6.jpg">
                                <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
                                                
                                    <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_video')#</cfoutput></h5>
                                    <p align="center">
                                        <cfoutput>#obj_translater.get_translate('card_desc_video')#</cfoutput>
                                    </p>
                                    <div align="center" class="mt-auto">
                                        <button class="btn btn-outline-red btn_open_el" data-menu="video"><cfoutput>#obj_translater.get_translate('btn_add_resource_video')#</cfoutput></button>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card header_rounded_top">
                                <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_3.jpg">
                                <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
                                                
                                    <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_prepa_certif')#</cfoutput></h5>
                                    <p align="center">
                                        <cfoutput>#obj_translater.get_translate('card_desc_prepa_certif')#</cfoutput>
                                    </p>
                                    <div align="center" class="mt-auto">
                                        <a class="btn btn-outline-red" href="el_certif.cfm"><cfoutput>#obj_translater.get_translate('btn_train')#</cfoutput></a>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>	
        
                    </div>


                <cfelse>


                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist" align="center">
                        <button class="nav-link active border-0" data-toggle="tab" data-target="#tp_business" type="button" role="tab" aria-controls="tp_business" aria-selected="true">
                            <div class="d-flex">
                                <div>
                                    <img class="mr-3 img_rounded" src="./assets/img/orientation_1.jpg" width="130">
                                </div>
                                <div align="left">
                                    <h5 style="font-size:18px" class="mb-0">
                                        <strong class="text-dark mb-0"><cfoutput>#obj_translater.get_translate('card_title_business_english')#</cfoutput></strong>
                                    </h5>
                                    <span><cfoutput>#obj_translater.get_translate('card_desc_business_english')#</cfoutput></span>
                                </div>
                            </div>
                        </button>
                        <button class="nav-link border-0" data-toggle="tab" data-target="#tp_general" type="button" role="tab" aria-controls="tp_general" aria-selected="false">
                            <div class="d-flex">
                                <div>
                                    <img class="mr-3 img_rounded" src="./assets/img/orientation_2.jpg" width="130">
                                </div>
                                <div align="left">
                                    <h5 style="font-size:18px" class="mb-0">
                                        <strong class="text-dark mb-0"><cfoutput>#obj_translater.get_translate('card_title_general_english')#</cfoutput></strong>
                                    </h5>
                                    <span><cfoutput>#obj_translater.get_translate('card_desc_general_english')#</cfoutput></span>
                                </div>
                                <!--- <div class="ml-auto">
                                    <a href="#" class="btn btn-sm btn-red btn-circle btn_open_el" data-menu="general"><i class="fa-light fa-plus"></i></a>
                                </div> --->
                            </div>
                        </button>
                        <button class="nav-link border-0" data-toggle="tab" data-target="#tp_video" type="button" role="tab" aria-controls="tp_video" aria-selected="false">
                            <div class="d-flex">
                                <div>
                                    <img class="mr-3 img_rounded" src="./assets/img/orientation_6.jpg" width="130">
                                </div>
                                <div align="left">
                                    <h5 style="font-size:18px" class="mb-0">
                                        <strong class="text-dark mb-0"><cfoutput>#obj_translater.get_translate('card_title_video')#</cfoutput></strong>
                                    </h5>
                                    <span><cfoutput>#obj_translater.get_translate('card_desc_video')#</cfoutput></span>
                                </div>
                                <!--- <div class="ml-auto">
                                    <a href="#" class="btn btn-sm btn-red btn_open_el" data-menu="video"><i class="fa-light fa-plus"></i></a>
                                </div> --->
                            </div>
                       </button>
                    </div>
                </nav>


                <div class="tab-content">
                    <div class="tab-pane show active" id="tp_business" role="tabpanel">
                        <div class="card" style="margin-top:-1px !important">
                            <div class="card-body">

                                <cfif get_session_access_2.recordcount eq "0">

                                    <div class="d-flex justify-content-center">
                                        <div class="card rounded border shadow-sm bg-light" align="center">
                                            <div class="card-body">
                                                <cfoutput>#obj_translater.get_translate('alert_no_business_filled')#</cfoutput>
                                                <br>
                                                <a href="#" class="btn btn-red btn_open_el" data-menu="business"><cfoutput>#obj_translater.get_translate('btn_add_resource_business')#</cfoutput></a>
                                            </div>
                                        </div>
                                    </div>

                                <cfelse>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="business"> <cfoutput>#obj_translater.get_translate('btn_add_resource_business')#</cfoutput></button>
                                        </div>
                                    </div>

                                    <cfoutput query="get_session_access_2" group="module_id">

                                        <cfoutput>
                                            <cfset level_alias = get_session_access_2.level_alias>
                                            <cfinclude template="./incl/incl_module_el_session.cfm">
                                        </cfoutput>
                                        
                                    </cfoutput>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="business"> <cfoutput>#obj_translater.get_translate('btn_add_resource_business')#</cfoutput></button>
                                        </div>
                                    </div>

                                </cfif>
                            </div>
                        </div>                        
                    </div>

                    <div class="tab-pane" id="tp_general" role="tabpanel">
                        <div class="card" style="margin-top:-1px !important">
                            <div class="card-body">

                                <cfif get_session_access_1.recordcount eq "0">

                                    <div class="d-flex justify-content-center">
                                        <div class="card rounded border shadow-sm bg-light" align="center">
                                            <div class="card-body">
                                                <cfoutput>#obj_translater.get_translate('alert_no_general_filled')#</cfoutput>
                                                <br>
                                                <a href="#" class="btn btn-red btn_open_el" data-menu="general"><cfoutput>#obj_translater.get_translate('btn_add_resource_general')#</cfoutput></a>
                                            </div>
                                        </div>
                                    </div>

                                <cfelse>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="general"> <cfoutput>#obj_translater.get_translate('btn_add_resource_general')#</cfoutput></button>
                                        </div>
                                    </div>

                                    <cfoutput query="get_session_access_1" group="module_id">

                                        <cfoutput>
                                            <cfset level_alias = get_session_access_1.level_alias>
                                            <cfinclude template="./incl/incl_module_el_session.cfm">
                                        </cfoutput>
                                        
                                    </cfoutput>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="general"> <cfoutput>#obj_translater.get_translate('btn_add_resource_general')#</cfoutput></button>
                                        </div>
                                    </div>

                                </cfif>

                            </div>
                        </div>                        
                    </div>

                    <div class="tab-pane" id="tp_video" role="tabpanel">
                        <div class="card" style="margin-top:-1px !important">
                            <div class="card-body">

                                <cfif get_session_access_6.recordcount eq "0">

                                    <div class="d-flex justify-content-center">
                                        <div class="card rounded border shadow-sm bg-light" align="center">
                                            <div class="card-body">
                                                <cfoutput>#obj_translater.get_translate('alert_no_video_filled')#</cfoutput>
                                                <br>
                                                <a href="#" class="btn btn-red btn_open_el" data-menu="video"><cfoutput>#obj_translater.get_translate('btn_add_resource_video')#</cfoutput></a>
                                            </div>
                                        </div>
                                    </div>

                                <cfelse>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="video"> <cfoutput>#obj_translater.get_translate('btn_add_resource_video')#</cfoutput></button>
                                        </div>
                                    </div>

                                    <cfoutput query="get_session_access_6">
                                        
                                        <!---<cfset level_alias = get_session_access_1.level_alias>--->
                                        
                                        <cfinclude template="./incl/incl_module_el_video.cfm">
                                        
                                    </cfoutput>

                                    <div class="row">
                                        <div class="col-sm-12" align="right">
                                        <button class="btn btn-sm btn-outline-red btn_open_el" data-menu="video"> <cfoutput>#obj_translater.get_translate('btn_add_resource_video')#</cfoutput></button>
                                        </div>
                                    </div>

                                </cfif>

                            </div>
                        </div>                        
                    </div>

                </div>


            </cfif>

        </div>
        
        <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
        
    </div>
    
      
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">

    <cfinclude template="./incl/incl_scripts_param.cfm">
        
<script>
$(document).ready(function() {

    <!--- reload page on refocus --->
    window.onblur= function() {
        window.onfocus= function () {
            // console.log(localStorage);
            let el_adv = localStorage.getItem("el_adv");
            // console.log(el_adv);
            if (el_adv) {
                localStorage.removeItem("el_adv")
                location.reload(true)
            }
    }};



    $('#modal_body_xl').on('hidden.bs.modal', function (e) {
        $('#modal_body_xl').empty();
    });

    $('#window_item_el_video').on('hidden.bs.modal', function (e) {
        // $('#window_item_el_video').empty();
        for(i=0; i<100; i++)
        {
            window.clearInterval(i);
        }
    });



    var handler_add_module_tp = function add_module_tp(){
        event.preventDefault();
        sm_id = $(this).attr('data-smid');
        module_id = $(this).attr('data-mid');
        lvl_alias = $(this).attr('data-lalias');
        _status = $(this).attr('data-status');
        _trigger = $(this).attr('data-trigger');
        var obj = $(this);

        // console.log("sm_id" + sm_id);
        // console.log("module_id" + module_id);
        // console.log("lvl_id" + lvl_id);

        $.ajax({
			url: 'api/tracking/tracking_post.cfc?method=insert_elearning_session',
			type: 'POST',
			data : {
                user_id: <cfoutput>#SESSION.USER_ID#</cfoutput>,
                module_id: module_id
            },
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
                if (_trigger == "module_el_work")
                    if (_status == 'in') {
                        $("#containerdash_"+sm_id).hide();

                    } else if (_status == 'up') {
                        $("#containerdash_"+sm_id).hide();
                    }
                else
                {
                    if (_status == 'in') {
                        // alert("module ajouté");
                        
                        $("#containerdash_"+sm_id).prepend("<div class='triangle triangle_"+lvl_alias+"'></div><i class='fa-sharp fa-light fa-check text-white triangle_check'></i>");
                        $("#containerdash_"+sm_id).addClass("border-"+lvl_alias);
                        obj.removeClass('btn-outline-'+lvl_alias);
                        obj.addClass('btn-'+lvl_alias);
                        obj.attr('data-status','up');           
                        obj.empty();
                        obj.append('<i class="fa-thin fa-check fa-lg"></i> AJOUTÉ AU PARCOURS');

                    } else if (_status == 'up') {
                        // alert("module Supprimé");

                        $("#containerdash_"+sm_id).find(".triangle").remove();
                        $("#containerdash_"+sm_id).removeClass("border-"+lvl_alias);
                        obj.removeClass('btn-'+lvl_alias);
                        obj.addClass('btn-outline-'+lvl_alias);
                        obj.attr('data-status','in');
                        obj.empty();
                        obj.append('<i class="fa-thin fa-plus fa-lg"></i> AJOUTER AU PARCOURS');
                        
                    }
                }
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

    }
    $(".btn_add_tp").bind("click",handler_add_module_tp);




    let go_el_1 = 0;
	let go_el_2 = 0;

	$('.btn_open_el').click(function(event) {
		event.preventDefault();
        var menugo = $(this).attr('data-menu');
		go_el_1 = 0;
		$('#window_item_el_syllabus').modal({backdrop: 'static', keyboard: false});
		$('#modal_title_el_syllabus').text("*WEFIT LMS*");
		$('#modal_body_el_syllabus').empty();
		$('#modal_body_el_syllabus').load("modal_window_el_syllabus.cfm?display="+menugo, function() {});
	});	

	$('#window_item_el_syllabus .close').click(function(event) {
		// alert("close");
		$('#window_item_el_syllabus').modal('hide');
		go_el_1 = 1;
		sm_id = 0;
	});	


	$('#window_item_el_syllabus').on('hidden.bs.modal', function (e) {
		//alert("trigger syllabus details + go_el_1"+go_el_1); 
		console.log("sm_id "+sm_id);
		if (go_el_1 == "0" && sm_id != "0") {
			go_el_1 = 1;
			go_el_2 = 0;
			$('#window_item_el_video').modal({<!---backdrop: 'static',keyboard: false--->});
			$('#modal_title_el_video').text("*WEFIT LMS*");
			$('#modal_body_el_video').empty();
			$('#modal_body_el_video').load("modal_window_el_video.cfm?sm_id="+sm_id);
		}
        else
        {
            location.reload();
        }
	});

	$('#window_item_el_video').on('hidden.bs.modal', function (e) {
		// alert("trigger video details hide + go_el_2"+go_el_2); 
		if (go_el_2 == "0") {
			go_el_1 = 0;
			go_el_2 = 1;
			
			$('#modal_body_el_video').empty();
			$('#window_item_el_syllabus').modal('show');
		}
	});

    $('.btn_player_work').click(function(event) {		
        event.preventDefault();
        var sm_id = $(this).attr('data-smid');
        $('#window_item_el_video').modal({<!---backdrop: 'static',keyboard: false--->});
        $('#modal_title_el_video').text("*WEFIT LMS*");
        $('#modal_body_el_video').empty();
        $('#modal_body_el_video').load("modal_window_el_video.cfm?sm_id="+sm_id);
        go_el_2 = 1;
        go_el_1 = 1;
    
    })

    $('.btn_start_quiz').click(function(event) {		
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var q_id = idtemp[1];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({backdrop: 'static', keyboard: true});
        $('#modal_body_xl').load("modal_window_quiz_play_test.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});
    
    })
    
    $('.btn_view_quiz').click(function(event) {	
        event.preventDefault();		
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var quiz_id = idtemp[2];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_body_xl').load("modal_window_quiz.cfm?quiz_id="+quiz_id+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {});
    })
    
});
</script>

</body>
</html>