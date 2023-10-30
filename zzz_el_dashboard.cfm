<cfsilent>

    <cfparam name="f_id" default="2">

    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
    </cfquery>

    <cfloop list="1,2,6" index="cor">
    <cfquery name="get_session_access_#cor#" datasource="#SESSION.BDDSOURCE#">
    SELECT
    em.elearning_module_id, em.elearning_module_path, 
    sm.sessionmaster_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration, sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource,
    CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
    CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
    CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,

    emg.tp_orientation_id,
    <!---tm.module_name_#SESSION.LANG_CODE# as _module_name, 
    tm.module_description_#SESSION.LANG_CODE# as _module_description, 
    tm.module_level, tm.module_id,--->
    l.level_alias, l.level_id,
    emu.update_date, emu.elearning_completion

    
    FROM lms_elearning_module em    
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = em.sessionmaster_id	

    INNER JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id

    INNER JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id


    <!---INNER JOIN lms_elearning_session_user esu ON esu.elearning_session_id = em.elearning_module_id --->
    INNER JOIN lms_elearning_module_user emu ON emu.elearning_module_id = em.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND elearning_active = 1

    LEFT JOIN lms_level l ON l.level_id = emg.level_id

    <!---LEFT JOIN lms_elearning_cor ec ON ec.elearning_session_id = es.elearning_session_id
    LEFT JOIN lms_elearning e ON e.elearning_id = ec.elearning_id
    LEFT JOIN lms_elearning_session_cor esc ON esc.elearning_session_id = es.elearning_session_id
   


    LEFT JOIN lms_tpmodulemaster2 tm ON tm.module_id = sm.module_id --->
    <!---WHERE esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    AND esu.active = 1--->

    WHERE emg.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">

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
          
            <cfset title_page = "WEFIT ELEARNING ESSENTIAL">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row">
    
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        
                        <div class="card border bg-light">
                    
                            <div class="card-body">
                                                
                                <div class="d-flex w-100 justify-content-around" align="center">
                                    <div>
                                        <!--- <i class="fal fa-users fa-2x text-info"></i>
                                        <br> --->
                                        <cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
                                        <cfoutput>#obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#</cfoutput>
                                        <cfelse>
                                        -
                                        </cfif>
                                        <br><small><strong>Temps passé Total</strong></small>
                                    </div>
                                    <div>
                                        <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                        <br> --->
                                        -<br><small><strong>Progression</strong></small>
                                    </div>
                                    <div>
                                        <!--- <i class="fal fa-spell-check fa-2x text-info"></i>
                                        <br> --->
                                        0<br><small><strong>Cours complétés</strong></small>
                                    </div>
                                    <!--- <div>
                                        <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                        <br> --->
                                        34<br><small><strong>Skills maîtrisées</strong></small>
                                    </div> --->
                                    <div>
                                        <!--- <span class="badge badge-pill badge-red"><h4 class="mt-1">A2.2</h4></span>
                                        <br> --->

                                        <cfif StructKeyExists(SESSION.USER_LEVEL,'en')>
                                            <cfset level_sub_id = SESSION.USER_LEVEL['en'].level_sub_id>
                                            <cfset level_id = SESSION.USER_LEVEL['en'].level_id>
                                            <cfif level_sub_id neq "">
                                                <cfoutput><img src="./assets/img_sublevel/#level_sub_id#_plain.svg" width="30"></cfoutput>
                                            <cfelse>
                                                <cfoutput><img src="./assets/img_level/#level_id#_plain.svg" width="30"></cfoutput>
                                            </cfif>
                                        <cfelse>
                                            -
                                        </cfif>

                                        
                                        <br>
                                        <small><strong>Mon Niveau</strong></small>
                                    </div>
                                </div>
                
                            </div>
                        </div>

                    </div>

                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div id="accordion">

                            <div class="card border">

                                <div class="card-body">

                                    <div class="w-100 mb-3 card_menu" data-toggle="collapse" data-target="#collapse_business" aria-expanded="true" aria-controls="collapse_business">
                                        <div class="d-flex">
                                            <div>
                                                <img src="./assets/img/orientation_1.jpg" align="left" width="100" class="mr-2"> 
                                            </div>
                                            <div>
                                                <h5 class="mb-0"><cfoutput>Business English</cfoutput></h5>
                                                Se perfectionner en Anglais dans un secteur en particulier
                                            </div>
                                            <div class="ml-auto">
                                                <a href="#" class="btn btn-sm btn-outline-red btn_open_el" data-menu="business"><i class="fa-light fa-file-circle-plus"></i> Ajouter des ressources</a>
                                            </div>
                                        </div>
                                        <hr class="border-red mb-1 mt-3">
                                    </div>

                                    <div id="collapse_business" class="collapse show" data-parent="#accordion">
                                    
                                        <cfif get_session_access_2.recordcount eq "0">

                                            <div class="d-flex justify-content-center">
                                                <div class="card rounded border shadow-sm bg-light" align="center">
                                                    <div class="card-body">
                                                        Votre parcours Business English est vide, ajoutez des ressources !
                                                        <br>
                                                        <a href="#" class="btn btn-outline-red btn_open_el" data-menu="business">Ajouter des resources</a>
                                                    </div>
                                                </div>
                                            </div>

                                        <cfelse>

                                            <cfoutput query="get_session_access_2">

                                                <cfset level_alias = get_session_access_2.level_alias>
                                                
                                                <cfinclude template="./incl/incl_module_el_work.cfm">
                                                
                                            </cfoutput>

                                        </cfif>


                                        <!--- <div class="shadow-sm rounded-bottom border border-B1 m-0 w-100 bg-light">
                    
                                            <div class="p-2" type="button" data-toggle="collapse" data-target="#module_group_13" aria-expanded="true" aria-controls="module_group_13">
                                                
                                                <div class="d-flex">
                                                        
                                                        
                                                    <div class="flex-grow-1 p-2">
                                                        
                                                        <div>
                                                            <img src="./assets/img_level/B1.svg" width="40" align="left" class="mr-2">
                                                        
                                                            <strong class="text-B1">
                                                                <h5 class="d-inline"> Making the right impression</h5>
                                                            </strong>
                                                            
                                                            <hr class="border-B1 mb-1 mt-3">
                                                            <span class="text-danger fw-bold float-right"><small> Dernière activité : -</small></span>
                                                        
                                                        </div>
                                                        
                                                    </div>
                        
                                                </div>
                        
                                            </div>
                                    
                                        </div> --->


                                    </div>

                                </div>

                            </div>

                            <div class="card border">

                                <div class="card-body">

                                    <div class="w-100 mb-3 card_menu" data-toggle="collapse" data-target="#collapse_general" aria-expanded="false" aria-controls="collapse_general">
                                        <div class="d-flex">
                                            <div>
                                                <img src="./assets/img/orientation_2.jpg" align="left" width="100" class="mr-2"> 
                                            </div>
                                            <div>
                                                <h5 class="mb-0"><cfoutput>General English</cfoutput></h5>
                                                S'améliorer au quotidien pour discuter et voyager par exemple
                                            </div>
                                            <div class="ml-auto">
                                                <a href="#" class="btn btn-sm btn-outline-red btn_open_el" data-menu="general"><i class="fa-light fa-file-circle-plus"></i> Ajouter des ressources</a>
                                            </div>
                                        </div>
                                        <hr class="border-red mb-1 mt-3">
                                    </div>

                                    <div id="collapse_general" class="collapse" data-parent="#accordion">
                                    
                                        <cfif get_session_access_1.recordcount eq "0">

                                            <div class="d-flex justify-content-center">
                                                <div class="card rounded border shadow-sm bg-light" align="center">
                                                    <div class="card-body">
                                                        Votre parcours General English est vide, ajoutez des ressources !
                                                        <br>
                                                        <a href="#" class="btn btn-outline-red btn_open_el" data-menu="business">Ajouter des resources</a>
                                                    </div>
                                                </div>
                                            </div>

                                        <cfelse>

                                            <cfoutput query="get_session_access_1">

                                                <cfset level_alias = get_session_access_1.level_alias>
                                                
                                                <cfinclude template="./incl/incl_module_el_work.cfm">
                                                
                                            </cfoutput>

                                        </cfif>


                                    </div>

                                </div>

                            </div>

                            <div class="card border">

                                <!--- <cfdump var="#get_session_access_6#"> --->

                                <div class="card-body">

                                    <div class="w-100 mb-3 card_menu" data-toggle="collapse" data-target="#collapse_video" aria-expanded="false" aria-controls="collapse_video">
                                        <div class="d-flex">
                                            <div>
                                                <img src="./assets/img/orientation_6.jpg" align="left" width="100" class="mr-2"> 
                                            </div>
                                            <div>
                                                <h5 class="mb-0"><cfoutput>Vidéothèque</cfoutput></h5>
                                                Travailler sur des conférences, des sujets variés...
                                            </div>
                                            <div class="ml-auto">
                                                <a href="#" class="btn btn-sm btn-outline-red btn_open_el" data-menu="video"><i class="fa-light fa-file-circle-plus"></i> Ajouter des ressources</a>
                                            </div>
                                        </div>
                                        <hr class="border-red mb-1 mt-3">
                                    </div>

                                    <div id="collapse_video" class="collapse" data-parent="#accordion">
                                        
                                        <cfif get_session_access_6.recordcount eq "0">

                                            <div class="d-flex justify-content-center">
                                                <div class="card rounded border shadow-sm bg-light" align="center">
                                                    <div class="card-body">
                                                        Votre vidéothèque est vide, trouvez une conférence qui vous intéresse !
                                                        <br>
                                                        <a href="#" class="btn btn-outline-red btn_open_el" data-menu="business">Ajouter des resources</a>
                                                    </div>
                                                </div>
                                            </div>

                                        <cfelse>

                                            <cfoutput query="get_session_access_6">
                                                
                                                <cfset level_alias = get_session_access_1.level_alias>
                                                
                                                <cfinclude template="./incl/incl_module_el_work.cfm">
                                                
                                            </cfoutput>

                                        </cfif>

                                    </div>

                                </div>

                            </div>


                                <div class="row">
                    
                                    <div class="col-md-8 col-sm-12">

                                        <div class="row justify-content-center">
                                    

                
                
                
                                            <!---  --->
                
                                        <!--- <cfdump var="#get_session_access#"> --->
                
                                        <!--- <cfoutput query="get_session_access" group="elearning_session_id">
                
                                        <div class="card border">
                                            <div class="card-body">
                
                                                <div class="d-flex">
                                                    <div>
                                                        <img src="./assets/img_level/#module_level#.svg" width="40">
                                                    </div>
                                                    <div class="w-100 ml-2">
                
                                                        <h5 class="d-inline"> #_module_name#</h5>
                                                        <hr class="border-#module_level# mb-1 mt-2">
                                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 07/01/2023</small></span>
                                                   
                                                    </div>
                                                </div>
                
                
                                                <!--- <div class="row mt-2">
                    
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        
                                                                                
                                                        <div class="d-flex w-100 justify-content-around" align="center">
                                                            <div>
                                                                <!--- <i class="fal fa-users fa-2x text-info"></i>
                                                                <br> --->
                                                                123<br><small><strong>Ressources</strong></small>
                                                            </div>
                                                            <div>
                                                                <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                                                <br> --->
                                                                12%<br><small><strong>En cours</strong></small>
                                                            </div>
                                                            <div>
                                                                <!--- <i class="fal fa-spell-check fa-2x text-info"></i>
                                                                <br> --->
                                                                123<br><small><strong>Finalisées</strong></small>
                                                            </div>
                                                        </div>
                                                
                                                    </div>
                                                </div> --->
                
                                                <!--- looping on module --->
                                                <cfoutput>
                
                                                <div class="row mt-2">
                    
                                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                                        
                                                        <!--- <cfloop from="1" to="2" index="cor"> --->
                                                        <div class="border-top p-2">
                
                                                            <div class="float-left">       
                                                                <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="120" class="mr-2">
                                                            </div>   
                
                                                            <div class="float-left">    
                                                                #module_name#
                
                                                                <!--- <cfif module_difficulty neq "">
                                                                    <cfif module_difficulty lte 3><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                                    
                                                                    <cfif module_difficulty lte 2><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                                
                                                                    <cfif module_difficulty lte 1><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                                </cfif> --->
                                                                
                                                                <cfif update_date neq "">
                                                                    <br>
                                                                    <span class="text-danger fw-bold float-right"><small> Dernière activité : #update_date#</small></span>
                                                                    <br>
                                                                    <span class="text-danger fw-bold float-right"><small> Completion : #elearning_completion# %</small></span>
                                                                </cfif>
                                                                
                
                                                            </div>
                
                                                            <div class="float-right">    
                                                                
                                                                <!--- <small>Mots-clés :</small>
                                                                <span class="badge badge-info">Relation client</span> <span class="badge badge-info">Téléphone</span> 
                                                                <br>
                                                                <small>Grammaire :</small>
                                                                <span class="badge badge-info">Modal verbs</span> 	 --->
                                                                
                                                                <!--- <a class="btn btn-sm btn-outline-red btn_view_session" id="sm_703" href="#"><i class="fas fa-eye" aria-hidden="true"></i> Details</a> --->
                                                                
                                                                <!--- <a class="btn btn-sm btn-outline-red">
                                                                    <i class="fas fa-book" data-toggle="tooltip" data-placement="top" title="Support de cours" aria-hidden="true"></i><span class="sr-only">Support de cours</span>
                                                                </a>
                                                                
                                                                <a class="btn btn-sm btn-outline-red">
                                                                    <i class="fas fa-volume-up" data-toggle="tooltip" data-placement="top" title="Contient de l'audio" aria-hidden="true"></i><span class="sr-only">Contient de l'audio</span>
                                                                </a> --->
                                                                
                                                                <a class="btn btn-sm btn-link ">
                                                                    <h3 class="m-0"><i class="fa-thin fa-language"></i></h3>
                                                                   
                                                                     Vocabulary
                                                                </a>
                
                                                                <a class="btn btn-sm btn-link ">
                                                                    <h3 class="m-0"><i class="fa-thin fa-list-check"></i></h3>
                                                                    Training Quizz
                                                                </a>
                
                                                                <a class="btn btn-sm btn-link">
                                                                    <h3 class="m-0"><i class="fa-thin fa-envelope"></i></h3>
                                                                    email templates
                                                                </a>
                
                                                                <a class="btn btn-sm btn-outline-#module_level#" href="el_play_sco.cfm?sco=#elearning_id#" target="_blank">
                                                                    <h3 class="m-0"><i class="fa-thin fa-circle-play"></i></h3>
                                                                    PLAY MODULE
                                                                </a>
                                                                
                                                                <a class="btn btn-sm btn-outline-#module_level#" href="##">
                                                                    Validation Quiz
                                                                </a>
                                                                
                                                                <!--- <div class="p-1 pull-right cursored btn_like_session" id="sm_703"><i class="far fa-heart fa-lg grey" aria-hidden="true"></i></div> --->
                                                               
                                                            </div>
                
                                                        </div>
                
                                                    </div>
                
                                                </div>
                                                </cfoutput>
                
                                            </div>
                                        </div>
                                        </cfoutput> --->
                
                
                                </div>


                            </div>

                        </div>

                    </div>

                </div>

            </div>
                
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
    // handler_del_elearning_session = function del_elearning_session(){
    //     event.preventDefault();
    //     var idtemp = $(this).attr("id");
    //     var idtemp = idtemp.split("_");
    //     es_id = idtemp[2];

    //     console.log(es_id)
        
    //     $.ajax({
    //         url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
    //         type : 'POST',
    //         data : {
    //             user_id:'<cfoutput>#SESSION.USER_ID#</cfoutput>',
    //             elearning_session_id:es_id
    //         },				
    //         success : function(result, status) {
    //             window.location.reload(true);
    //         }
    //     });

    // };
    // $(".del_elearning_session").bind("click",handler_del_elearning_session);

    // handler_add_elearning_session = function add_elearning_session(){
    //     event.preventDefault();

    //     var es_id = $('#new_elearning_session_id').val();
    //     console.log(es_id)
        
    //     $.ajax({
    //         url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
    //         type : 'POST',
    //         data : {
    //             user_id:'<cfoutput>#SESSION.USER_ID#</cfoutput>',
    //             elearning_session_id:es_id
    //         },				
    //         success : function(result, status) {
    //             window.location.reload(true);
    //         }
    //     });

    // };
    // $(".btn_add_elearning_session").bind("click",handler_add_elearning_session);







    var handler_add_module_tp = function add_module_tp(){
        event.preventDefault();
        sm_id = $(this).attr('data-smid');
        module_id = $(this).attr('data-mid');
        lvl_alias = $(this).attr('data-lalias');
        _status = $(this).attr('data-status');
        _trigger = $(this).attr('data-trigger');
        var obj = $(this);

        console.log("sm_id" + sm_id);
        console.log("module_id" + module_id);
        // console.log("lvl_id" + lvl_id);

        $.ajax({
			url: 'api/tracking/tracking_post.cfc?method=insert_elearning_progress',
			type: 'POST',
			data : {
                user_id: <cfoutput>#SESSION.USER_ID#</cfoutput>,
                module_id: module_id,
                display_module: 1
            },
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
                if (_trigger == "module_el_work")
                    if (_status == 'in') {
                        $("#container_"+sm_id).hide();

                    } else if (_status == 'up') {
                        $("#container_"+sm_id).hide();
                    }
                else
                {
                    if (_status == 'in') {
                        // alert("module ajouté");
                        
                        $("#container_"+sm_id).prepend("<div class='triangle triangle_"+lvl_alias+"'></div><i class='fa-sharp fa-light fa-check text-white triangle_check'></i>");
                        $("#container_"+sm_id).addClass("border-"+lvl_alias);
                        obj.removeClass('btn-outline-'+lvl_alias);
                        obj.addClass('btn-'+lvl_alias);
                        obj.attr('data-status','up');           
                        obj.empty();
                        obj.append('<i class="fa-thin fa-check fa-lg"></i> AJOUTÉ AU PARCOURS');

                    } else if (_status == 'up') {
                        // alert("module Supprimé");

                        $("#container_"+sm_id).find(".triangle").remove();
                        $("#container_"+sm_id).removeClass("border-"+lvl_alias);
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
		$('#modal_title_el_syllabus').text("eLearning Syllabus");
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
			$('#modal_title_el_video').text("Vidéo");
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
        $('#modal_title_el_video').text("Vidéo");
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
        $('#modal_body_xl').load("modal_window_quiz_play.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});
    
    })
    
    $('.btn_view_quiz').click(function(event) {	
        event.preventDefault();		
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var quiz_user_id = idtemp[1];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {});
    })
    
});
</script>

</body>
</html>