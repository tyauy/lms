<cfparam name="display" default="video">


<cfoutput>#obj_translater.get_translate_complex('intro_el_syllabus')#</cfoutput>

<h5 class="mb-2 mt-3 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_filter_search')#</cfoutput></h5>
<hr class="mt-0 border-red">

<div class="d-flex justify-content-center">
    
    
<div class="badge badge-pill border border-info bg-light p-2 pl-3" style="font-size:100% !important">
    <div class="d-flex">
        <div class="pt-2 text-secondary">
            <cfoutput>#obj_translater.get_translate('table_th_language')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></cfoutput>
        </div>
        <div class="ml-2">
            <!--- <button class="btn btn-block btn-sm btn-info btn_add_trainer mb-0"><cfoutput>#obj_translater.get_translate('btn_ichoose')#</cfoutput></button> --->
            <div class="ml-2"><img src="./assets/img_formation/2.png" width="35"></div>
        </div>
    </div>
</div> 

<div class="badge badge-pill border border-info bg-light p-2 pl-3 ml-2" style="font-size:100% !important" type="button" data-toggle="collapse" data-target="#collapse_obj" aria-expanded="false" aria-controls="collapse_obj">
    <div class="d-flex">
        <div class="pt-2">
            <cfoutput>#obj_translater.get_translate('btn_el_resources')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></cfoutput>
        </div>
        <div class="ml-2">
            <div class="img_obj ml-2">
                <cfif display eq "video">
                    <img src="./assets/img_orientation/orientation_6_tiny.jpg" width="35" class="mr-2 rounded">
                    <cfoutput>#obj_translater.get_translate('card_title_video')#</cfoutput>
                <cfelseif display eq "business">
                    <img src="./assets/img_orientation/orientation_1_tiny.jpg" width="35" class="mr-2 rounded">
                    <cfoutput>#obj_translater.get_translate('card_title_business_english')#</cfoutput>
                <cfelseif display eq "general">
                    <img src="./assets/img_orientation/orientation_2_tiny.jpg" width="35" class="mr-2 rounded">
                    <cfoutput>#obj_translater.get_translate('card_title_general_english')#</cfoutput>
                </cfif>
            </div>
        </div>
    </div>
</div>



<div class="badge badge-pill border border-info bg-light p-2 pl-3 ml-2" style="font-size:100% !important" type="button" data-toggle="collapse" data-target="#collapse_level" aria-expanded="false" aria-controls="collapse_level">
    <div class="d-flex">
        <div class="pt-2">
            <cfoutput>#obj_translater.get_translate('level')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></cfoutput>
        </div>
        <div class="ml-2">
            <div class="img_level ml-2">
                <cfif display eq "video">
                    <!--- <img src="./assets/img_level/global.svg" width="35"> --->
                    <img src="./assets/img_level/B.png" width="35">
                <cfelseif display eq "business">
                    <img src="./assets/img_level/B.png" width="35">
                <cfelseif display eq "general">
                    <img src="./assets/img_level/B.png" width="35">
                </cfif>
            </div>
        </div>
    </div>
</div>

</div>


<div class="accordion mt-2" id="accordion_filter">

    <div id="collapse_level" class="collapse" aria-labelledby="heading_level" data-parent="#accordion_filter">

        <div class="card-body">
        
            <div class="row justify-content-center">

                <cfoutput>
                <cfloop list="A,B,C" index="cor">
                    <cfif cor eq "A">
                        <cfset level_img = "A2.jpg">
                        <cfset level_desc = "#obj_translater.get_translate('card_title_A_level')#">
                    <cfelseif cor eq "B">
                        <cfset level_img = "B2.jpg">
                        <cfset level_desc = "#obj_translater.get_translate('card_title_B_level')#">
                    <cfelseif cor eq "C">
                        <cfset level_img = "C1.jpg">
                        <cfset level_desc = "#obj_translater.get_translate('card_title_C_level')#">
                    </cfif>
                    <div class="col-lg-3 col-md-3 col-sm-6">
                        <div class="card_module header_rounded_top">
                            <a class="btn_level" id="lvl_#cor#" data-levelalias="#cor#">
                            <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img_level/#level_img#">
                            <div class="card-body d-flex flex-column bg-light" style="min-height:110px">
                                <h6 class="text-center mt-1" style="font-size:16px !important">
                                    <img src="./assets/img_level/#cor#.png" width="40" class="mb-2">
                                    <br>
                                    #level_desc#
                                </h6>
                            </div>
                            </a>
                        </div>
                    </div>
                </cfloop>
                </cfoutput>
                


                <!--- <cfoutput query="get_level">
                <div class="col-lg-2 col-md-4 col-sm-6">
                    <div class="card_module">
                        <a class="btn_level <cfif level_id eq "1">disabled</cfif>" id="lvl_#level_id#" <cfif level_id eq "1">disabled=true</cfif> data-levelid="#level_id#" data-levelalias="#level_alias#">
                        <img class="card-img-top" src="./assets/img_level/#level_alias#.jpg">
                        <div class="card-body d-flex flex-column bg-light" style="min-height:110px">
                            <h6 class="text-center mt-1" style="font-size:16px !important">
                                <img src="./assets/img_level/#level_alias#.svg" width="40" class="mb-2">
                                <br>
                                #level_name#
                            </h6>
                        </div>
                        </a>
                    </div>
                </div>
                </cfoutput> --->

            </div>

        </div>
    </div>




    <div id="collapse_obj" class="collapse" aria-labelledby="heading_obj" data-parent="#accordion_filter">
        <div class="card-body">
        
            <div class="row justify-content-center">
                    
                <div class="col-lg-3 col-md-3 col-sm-6">

                    <div class="card_module header_rounded_top">
                        <a class="btn_obj" id="obj_2" data-objid="2">
                        <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_1.jpg">
                        <div class="card-body d-flex flex-column bg-light">
                                        
                            <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_business_english')#</cfoutput></h5>
                            <p align="center">
                                <cfoutput>#obj_translater.get_translate('card_desc_business_english')#</cfoutput>
                            </p>
                            
                        </div>
                        </a>
                    </div>
                
                </div>

                <div class="col-lg-3 col-md-3 col-sm-6">

                    <div class="card_module header_rounded_top">
                        <a class="btn_obj" id="obj_1" data-objid="1">
                        <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_2.jpg">
                        <div class="card-body d-flex flex-column bg-light">
                                        
                            <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_general_english')#</cfoutput></h5>
                            <p align="center">
                                <cfoutput>#obj_translater.get_translate('card_desc_general_english')#</cfoutput>
                            </p>
                            
                        </div>
                        </a>
                    </div>
                
                </div>

                <div class="col-lg-3 col-md-3 col-sm-6">

                    <div class="card_module header_rounded_top">
                        <a class="btn_obj" id="obj_6" data-objid="6">
                        <img class="header_rounded_top border-bottom-2 border-red" src="./assets/img/orientation_6.jpg">
                        <div class="card-body d-flex flex-column bg-light">
                                        
                            <h5 class="text-center mt-2"><cfoutput>#obj_translater.get_translate('card_title_video')#</cfoutput></h5>
                            <p align="center">
                                <cfoutput>#obj_translater.get_translate('card_desc_video')#</cfoutput>
                            </p>
                            
                        </div>
                        </a>
                    </div>

                </div>

            </div>

        </div>

    </div>
    
</div>



<!--- <h5 class="mb-2 mt-4 text-info" style="font-size:18px"><strong><cfoutput>#ucase(obj_translater.get_translate('btn_results'))#</cfoutput></strong></h5>
<hr class="mt-0 border-info"> --->

<h5 class="mb-2 mt-3 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('btn_results')#</cfoutput></h5>
<hr class="mt-0 border-red">

<div class="row justify-content-center container_theme_filter <cfif display neq "video">collapse</cfif>">
    <div class="col-md-12" align="center">
        <a class="btn btn-info btn_keyword" id="kw_89" data-kwid="89">
            Technology
        </a>
        <a class="btn btn-outline-info btn_keyword" id="kw_80" data-kwid="80">
            Entertainment
        </a>
        <a class="btn btn-outline-info btn_keyword" id="kw_85" data-kwid="85">
            Science
        </a>
        <a class="btn btn-outline-info btn_keyword" id="kw_76" data-kwid="76">
            Design
        </a>
        <a class="btn btn-outline-info btn_keyword" id="kw_106" data-kwid="106">
            Business
        </a>
        <a class="btn btn-outline-info btn_keyword" id="kw_86" data-kwid="86">
            Global Issues
        </a>
    </div>
</div>


<div class="row justify-content-center">

    <div class="col-lg-12">

        <div class="content_loader">

                
        </div>

    </div>

</div>

<!--- <div class="row justify-content-center">

    <div class="col-lg-4 col-md-4 col-sm-6">

        <div class="d-flex border card_module">
            <div>
                <img class="" src="./assets/img/orientation_1.jpg">
            </div>

        <a class="btn_action" id="act-1">
            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
                
                <h6 class="text-center mt-2" style="font-size:20px !important">POUR LE TRAVAIL</h6>

                
                <p align="center">
                    Se perfectionner en Anglais dans un secteur en particulier
                </p>
                
                
            </div>        
        </a>
        </div>   

    </div>


    <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="d-flex border card_module">
            <div>
                <img class="" src="./assets/img/orientation_2.jpg">
            </div>
            <a class="btn_action" id="act-2">
            
            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
                            
                <h6 class="text-center mt-2" style="font-size:20px !important">POUR LE PLAISIR</h6>

                
                <p align="center">
                    S'améliorer au quotidien pour discuter et voyager par exemple
                
                </p>
                
                
            </div>
            </a>
        </div>
    </div>

    <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="d-flex border card_module">
            <div>
                <img class="" src="./assets/img/orientation_3.jpg">
            </div>
            <a class="btn_action" id="act-3">
            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
                            
                <h6 class="text-center mt-2" style="font-size:20px !important">POUR UNE CERTIF</h6>

                
                <p align="center">
                TOEIC, Linguaskill, Bright, LTE.. Parcours personnalisés pour optimiser votre socre
                </p>
                
                
            </div>
            </a>
        </div>
    </div>	

</div> --->

<script>
$(document).ready(function() {
    

    <cfif display eq "video">
        // var lvl_id = 0;
        // var lvl_big_alias = 0;
        var lvl_id = 3;
        var lvl_big_alias = "B";
        var obj_id = 6;
        go_search(obj_id,lvl_id,lvl_big_alias,89);
    <cfelseif display eq "business">
        var lvl_id = 3;
        var lvl_big_alias = "B";
        var obj_id = 2;
        go_search(obj_id,lvl_id,lvl_big_alias,0);
    <cfelseif display eq "general">
        var lvl_id = 3;
        var lvl_big_alias = "B";
        var obj_id = 1;
        go_search(obj_id,lvl_id,lvl_big_alias,0);
    </cfif>

    // alert(obj_id);

    var handler_add_module_tp = function add_module_tp(){
        event.preventDefault();
        sm_id = $(this).attr('data-smid');
        module_id = $(this).attr('data-mid');
        lvl_alias = $(this).attr('data-lalias');
        _status = $(this).attr('data-status');
        var obj = $(this);

        console.log("sm_id" + sm_id);
        console.log("module_id" + module_id);
        console.log("lvl_id" + lvl_id);

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
                if (_status == 'in') {
                    // alert("module ajouté");
                    if(lvl_alias == "")
                    {
                        lvl_alias = "red";
                    }
                    $("#container_"+sm_id).prepend("<div class='triangle triangle_"+lvl_alias+"'></div><i class='fa-sharp fa-light fa-check text-white triangle_check'></i>");
                    $("#container_"+sm_id).addClass("border-"+lvl_alias);
                    obj.removeClass('btn-outline-'+lvl_alias);
                    obj.addClass('btn-'+lvl_alias);
                    obj.attr('data-status','up');           
                    obj.empty();
                    obj.append('<i class="fa-thin fa-check fa-lg"></i> <cfoutput>#encodeForJavascript(obj_translater.get_translate('btn_tp_added'))#</cfoutput>');

                } else if (_status == 'up') {
                    // alert("module Supprimé");
                    if(lvl_alias == "")
                    {
                        lvl_alias = "red";
                    }
                    $("#container_"+sm_id).find(".triangle").remove();
                    $("#container_"+sm_id).find(".fa-sharp").remove();
                    $("#container_"+sm_id).removeClass("border-"+lvl_alias);
                    obj.removeClass('btn-'+lvl_alias);
                    obj.addClass('btn-outline-'+lvl_alias);
                    obj.attr('data-status','in');
                    obj.empty();
                    obj.append('<i class="fa-thin fa-plus fa-lg"></i> <cfoutput>#encodeForJavascript(obj_translater.get_translate('btn_tp_add'))#</cfoutput>');
                    
                }
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

    }
    
    var handler_play_module = function trigger_modal(){
        sm_id = $(this).attr('data-smid');
        event.preventDefault();
        $('#window_item_el_syllabus').modal('hide');
    }

    function go_search(obj_id,lvl_id,lvl_big_alias,kw_id)
    {
        // alert(obj_id);
        $.ajax({
            url: './api/elearning/elearning_get.cfc?method=get_module',
            type: "POST",
            data: {lvl_id:lvl_id,obj_id:obj_id,kw_id:kw_id,lvl_big_alias:lvl_big_alias},
            datatype : "html",
            success : function(result, statut){
                // console.log(result);            
                $(".content_loader").append(result);
                $(".btn_add_tp").off("click");
                $(".btn_add_tp").bind("click",handler_add_module_tp);

                $(".btn_player").off("click");
                $(".btn_player").bind("click",handler_play_module);
                
            }
        })
    }

    //go_search(obj_id,lvl_id);

   

        

    // function go_search_video(kw_id)
    // {
    //     $.ajax({
    //         url: './api/elearning/elearning_get.cfc?method=get_el_sessionmaster',
    //         type: "POST",
    //         data: {kw_id:kw_id},
    //         datatype : "html",
    //         success : function(result, statut){
    //             // console.log(result);            
    //             $(".content_loader").append(result);
                
    //             $(".btn_player").off("click");
    //             $(".btn_player").bind("click",handler_play_module);

    //             $(".btn_add_tp").off("click");
    //             $(".btn_add_tp").bind("click",handler_add_module_tp);

    //         }
    //     })
    // }


    $(".btn_obj").click(function(event) {
        event.preventDefault();
        obj_id = $(this).attr('data-objid');
        lvl_alias = "B";
        <!---if(lvl_id == 0)
        {
            lvl_id = 3;
            lvl_alias = "B1";
        }---->
        // alert("obj_id "+obj_id);
        // alert("lvl_id "+lvl_id);

        $(".img_level").empty();
        var lvl_add = "<img src='./assets/img_level/"+lvl_alias+".png' width='35'>";
        $(".img_level").append(lvl_add);

        $(".container_theme_filter").hide();
        $(".content_loader").empty();
        $("#collapse_obj").collapse("hide");
        $(".img_obj").empty();

        if(obj_id == "1")
        {
            var obj_add = "<img src='./assets/img_orientation/orientation_2_tiny.jpg' width='35' class='mr-2 rounded'>General English";
            $(".container_theme_filter").hide();
            go_search(obj_id,lvl_id,"B",0);
        }
        else if(obj_id == "2")
        {
            var obj_add = "<img src='./assets/img_orientation/orientation_1_tiny.jpg' width='35' class='mr-2 rounded'>Business English";
            $(".container_theme_filter").hide();
            go_search(obj_id,lvl_id,"B",0);
        }
        else if(obj_id == "3")
        {
            var obj_add = "<img src='./assets/img_orientation/orientation_3_tiny.jpg' width='35' class='mr-2 rounded'>Prépa Certif";
            $(".container_theme_filter").hide();
            go_search(obj_id,lvl_id);
        }
        else if(obj_id == "6")
        {
            var obj_add = "<img src='./assets/img_orientation/orientation_6_tiny.jpg' width='35' class='mr-2'>Vidéothèque";
            $(".container_theme_filter").show();
            go_search(obj_id,lvl_id,"B",89);
            // $(".img_level").empty();
            // var lvl_add = "<img src='./assets/img_level/global.svg' width='35'>";
            // $(".img_level").append(lvl_add);

        }
        $(".img_obj").append(obj_add);
        

    });
   
    $(".btn_level").click(function(event) {
        event.preventDefault();
        lvl_id = $(this).attr('data-levelid');
        lvl_big_alias = $(this).attr('data-levelalias');

        // alert("obj_id "+obj_id);
        // alert("lvl_id "+lvl_id);

        

        $(".content_loader").empty();
        $("#collapse_level").collapse("hide");

        $(".img_level").empty();
        var lvl_add = "<img src='./assets/img_level/"+lvl_big_alias+".png' width='35'>";
        $(".img_level").append(lvl_add);

        if(obj_id == "6")
        {
            $(".container_theme_filter").show();
            // $(".img_obj").empty();
            // obj_id = "2";
            // var obj_add = "<img src='./assets/img_orientation/orientation_1_tiny.jpg' width='35' class='mr-2 rounded'>Business English";
            // $(".img_obj").append(obj_add);

            // alert(obj_id);
            //  alert(lvl_id);
            // alert(lvl_big_alias);
            go_search(obj_id,lvl_id,lvl_big_alias,89);

        }
        else
        {
            $(".container_theme_filter").hide();
            // alert(lvl_id);
            go_search(obj_id,lvl_id,lvl_big_alias,0);

        }


    });

    $(".btn_keyword").click(function(event) {
        event.preventDefault();

        var kw_id = $(this).attr('data-kwid');
        // var lvl_big_alias = "0";
        
        $(".content_loader").empty();
        
        $(".btn_keyword").removeClass("btn-info");
        $(".btn_keyword").removeClass("btn-outline-info");
        $(".btn_keyword").addClass("btn-outline-info");

        $(".img_level").empty();
        var lvl_add = "<img src='./assets/img_level/"+lvl_big_alias+".png' width='35'>";
        $(".img_level").append(lvl_add);


        $(this).removeClass("btn-outline-info");
        $(this).addClass("btn-info");
        // $("#collapse_level").collapse("hide");
        // $(".img_level").empty();
        // var lvl_add = "<img src='./assets/img_level/"+lvl_alias+".svg' width='50' class='mt-2'>";
        // $(".img_level").append(lvl_add);
// alert(kw_id);
        go_search(obj_id,lvl_id,lvl_big_alias,kw_id);

    });












//     $('.btn_meet_wefit').click(function(event) {
	
//     event.preventDefault();		
//     /*var idtemp = $(this).attr("id");
//     var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);*/
//     /*$('#window_item_lg').modal({keyboard: true});
//     $('#modal_title_lg').text("Meet WEFIT");*/
//     $('#modal_body_ctc').empty();		
//     $('#modal_body_ctc').load("modal_window_calendar_cs.cfm", function() {});
// });




});
</script>