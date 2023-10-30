<!DOCTYPE html>

<cfset SESSION.ACCESS_VIRTUALCLASS = "1">

<cfsilent>

<cfparam name="date_ref" default="#dateformat(now(),'yyyy-mm-dd')#">

<cfset subm = "virtual_home">
<cfset secure = "2,5,6,3,4,7,8,9,11,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name
FROM lms_level
WHERE level_id NOT IN (0,6) 
</cfquery>

<!--- <cfif StructKeyExists(SESSION.USER_LEVEL,'en')>
        <cfset level_sub_id = SESSION.USER_LEVEL['en'].level_sub_id>
        <cfset level_id = SESSION.USER_LEVEL['en'].level_id>
        <cfif level_sub_id neq "">
            <cfoutput><img src="./assets/img_sublevel/#level_sub_id#_plain.svg" width="30"></cfoutput>
        <cfelse>
            <cfoutput><img src="./assets/img_level/#level_id#_plain.svg" width="30"></cfoutput>
        </cfif>
    <cfelse>
        -
    </cfif> --->

<cfset get_tp_user = obj_tp_get.oget_tps(st_id="2",u_id="#SESSION.USER_ID#",m_id="10")>
<!--- <cfset get_tp_virtual = obj_tp_get.oget_tps(st_id="2",m_id="10",no_users="1")> --->
<cfset tp_list = "">
<cfoutput query="get_tp_user">
    <cfset tp_list = listappend(tp_list,tp_id)>
</cfoutput>


</cfsilent>
	
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "WEFIT Virtual Classroom">
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">

            <cfif isdefined("k")>
                <div class="row">
                    <div class="col-md-12">
                        <cfif k eq "1">									
                            <div class="alert alert-success mb-5" role="alert">
                                <cfoutput>#obj_translater.get_translate('vc_alert_tp_follow')#</cfoutput>
                            </div>
                        <cfelseif k eq "2">									
                            <div class="alert alert-success mb-5" role="alert">
                                <cfoutput>#obj_translater.get_translate('vc_alert_tp_unfollow')#</cfoutput>
                            </div>
                        </cfif>
                    </div>
                </div>
            </cfif>
                    
            <!---
            <div class="row justify-content-md-center mb-5">
    
                <div class="col-md-auto">
                    <a href="_AD_elearning_dashboard.cfm" class="<cfif findnocase("dashboard", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Visio</a> 
                    | 
                    <a href="_AD_elearning_dashboard.cfm" class="<cfif findnocase("dashboard", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">eLearning</a> 
                    | 
                    <a href="learner_virtual.cfm" class="<cfif findnocase("virtual", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Virtual Classroom</a>
                    | 
                    <a href="_AD_elearning_skill.cfm" class="<cfif findnocase("skill", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">My Skills</a>
                    | 
                    <a href="_AD_elearning_ressources.cfm" class="<cfif findnocase("ressource", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Syllabus</a>
                    | 
                    Language : <img src="./assets/img/training_en.png" width="20">
                        
                </div>
            
            </div>
        --->

            
            <div class="d-flex justify-content-center bg-light pt-3">

                <cfif get_tp_user.recordcount neq "0">
        
                    <cfoutput query="get_tp_user">
                        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                            <div class="card border-top border-red mb-3">
                                <div class="card-body btn_view_tp cursored" id="tp_#tp_id#">
                                    <div align="center">
                                        <img src="./assets/img_formation/#formation_id#.png" width="30" class="border_thumb mr-1"> 
                                        <img src="./assets/img_level/#tplevel_alias#.svg" width="30"><br>
                                        #tp_name#
                                    </div>											
                                </div>
                            </div>
                        </div>
                    </cfoutput>
        
                </cfif>
        
                <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                            
                    <div class="card border-top border-red mb-3 btn_view_all_tp cursored" id="lvl_1">
                        <div class="card-body">
                            <div align="center"><i class="fa-thin fa-book fa-2x"></i><br><span><cfoutput>#obj_translater.get_translate('vc_btn_all_tp')#</cfoutput></span></div>											
                        </div>
                    </div>
        
                </div>

            </div>


            <div class="row mt-4">

                <div class="col-md-12" id="calendar_content">
                    <div class="card border h-100">
                        <div class="card-body">
                            
                            <div class="w-100 d-flex justify-content-between">
                                <h5 class="d-inline mb-2"><i class="fa-thin fa-calendar-week fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('vc_card_title')#</cfoutput></h5>
                                <div>
                                    <cfoutput query="get_level">
                                        <img src='./assets/img_level/#level_alias#.svg' width='30'> #level_name# &nbsp;&nbsp;&nbsp;
                                    </cfoutput>
                                </div>    
                            </div>
                            <hr class="border-dark mb-1 mt-0">

                            <div class="w-100 d-flex justify-content-center">

                                <cfoutput>
                                   
                                    <a class="btn btn-outline-red btn_prev_week"><i class="fa-solid fa-chevrons-left"></i> <cfoutput>#obj_translater.get_translate('btn_prev')#</cfoutput></a>
                                    <a class="btn btn-outline-red btn_next_week"><cfoutput>#obj_translater.get_translate('btn_next')#</cfoutput> <i class="fa-solid fa-chevrons-right"></i></a>
                                </cfoutput>

                            </div>

                            <div class="row m-0 mt-3" id="container_vc">

                            </div>


<!--- <cfdump var="#get_tp_user#"> --->

                             <!--- <a class="btn btn-sm btn-outline-red btn_test"><i class="fa-solid fa-chevrons-left"></i></a> --->
                                


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

<script>

$( document ).ready(function() {
    
    date_ref = "<cfoutput>#date_ref#</cfoutput>";
   
// console.log(date_ref);
    $('.btn_next_week').click(function(event) {
        let date_format_db = moment(date_ref).add(7,'days').format('YYYY-MM-DD');
        date_ref = date_format_db;
        display_week(date_ref);
    });	

    $('.btn_prev_week').click(function(event) {
        let date_format_db = moment(date_ref).add(-7,'days').format('YYYY-MM-DD');
        date_ref = date_format_db;
        display_week(date_ref);
    });	


    function display_week(date_ref) {
        // console.log(date_ref);
        $("#container_vc").empty();
        $.ajax({				 
            url: './api/virtualclass/virtualclass_get.cfc?method=oget_vc_week',
            type: "POST",
            data: {date_ref:date_ref},
            datatype : "html",
            success : function(result, statut){
                // console.log(result);            
                $("#container_vc").append(result);
                $(".btn_view_lesson").bind("click",view_tp);
            }
        })
    }
    display_week(date_ref);


    function view_tp() {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];
        // alert(tp_id);
        $('#modal_body_xl').empty();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&tp_id="+tp_id, function() {});
	}



    <cfif get_tp_user.recordcount eq "0" AND not isDefined("SESSION.VC_INTRO_MODAL_SHOW")>
        $('#window_item_lg').modal({keyboard: false,backdrop:'static'});
        $('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('title_page_trainer_index')#</cfoutput>");		
        $('#modal_body_lg').load("modal_window_info.cfm?show_info=explain_virtualclass", function() {});

        $('#window_item_lg').on('hide.bs.modal', function (e) {
            document.getElementById("video_tuto_vc").pause();
        })

        <cfset SESSION.VC_INTRO_MODAL_SHOW = 1>
    </cfif>

    $('.btn_switch').click(function(event) {
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];	
        console.log(tp_id);	
        displayid = './calendar/get_data_lms_calendar.cfm?get_virtual_lesson=1&tp_id='+tp_id;
        if($(this).prop("checked") == true)
        {
            $('#calendar').fullCalendar('addEventSource', displayid);
        }
        else
        {
            $('#calendar').fullCalendar('removeEventSource', displayid);
        }
	
    });	
    

    $('.btn_view_tp').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];
        // alert(tp_id);
        $('#modal_body_xl').empty();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&tp_id="+tp_id, function() {});
	});

    var handler_view_all_tp = function view_all_tp(){
        event.preventDefault();	
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var lvl_id = idtemp[1];	
        $('#modal_body_xl').empty();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_virtual.cfm?referrer=vc&lvl_id="+lvl_id, function() {});
	};				
    $(".btn_view_all_tp").bind("click",handler_view_all_tp);

    $('#window_item_xl').on('hidden.bs.modal', function (e) {
        window.location.reload(true);
    })

})


$(document).on('hidden.bs.modal', function (event) {
  if ($('.modal:visible').length) {
    $('body').addClass('modal-open');
  }
});


</script>

</body>
</html>