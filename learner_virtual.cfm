<!DOCTYPE html>

<cfset SESSION.ACCESS_VIRTUALCLASS = "1">

<cfsilent>

<cfparam name="date_ref" default="#dateformat(now(),'yyyy-mm-dd')#">

<cfif isdefined("SESSION.LIST_ACCESS_EL") AND listlen(SESSION.LIST_ACCESS_EL) eq "1" AND listfind(SESSION.LIST_ACCESS_EL,"3")>
    <cfparam name="f_id" default="3">
<cfelse>
    <cfparam name="f_id" default="2">
</cfif>

<cfif f_id eq "2">
    <cfset f_code = "en">
<cfelseif f_id eq "3">
    <cfset f_code = "de">
</cfif>

<cfset subm = "virtual_home">

<cfset secure = "2,5,6,3,4,7,8,9,13,12,11">
<cfinclude template="./incl/incl_secure.cfm">	
<cfset hide_setup = "1">

<cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tp_user">
    <cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
    <cfinvokeargument name="m_id" value="10">
    <cfinvokeargument name="f_id" value="#f_id#">
</cfinvoke>


<cfset f_list = "en">
<cfif isDefined("SESSION.ACCESS_VIRTUALCLASS_LANG")>
    <cfset f_list = SESSION.ACCESS_VIRTUALCLASS_LANG>
</cfif>

<cfif f_list eq "de">
    <cfset f_id = 3>
</cfif>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name
    FROM lms_level
    WHERE level_id NOT IN (0,6)
    <cfif f_id eq 3>
        AND level_id < 4
    </cfif>
</cfquery>

<cfset tp_list = "">
<cfoutput query="get_tp_user">
    <cfset tp_list = listappend(tp_list,tp_id)>
</cfoutput>

<cfset __lesson = obj_translater.get_translate('lesson')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __with = obj_translater.get_translate('with')>
<cfset __min = obj_translater.get_translate('short_minute')>
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
<cfset __btn_not_scheduled = obj_translater.get_translate('global_not_scheduled')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset __btn_note = obj_translater.get_translate('btn_note')>
<cfset __btn_remaining_seats = obj_translater.get_translate('vc_btn_remaining_seats')>
<cfset __btn_view_series = obj_translater.get_translate('btn_view_series')>
<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
<cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>		

</cfsilent>
	
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">

            <cfinclude template="./incl/incl_nav_vc.cfm">
            
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

            <div class="row mt-3">

                <div class="col-md-12">

                    <div class="card">

                        <div class="card-body">

                            <div class="w-100 d-flex justify-content-between">

                                <div class="btn-group-toggle" data-toggle="buttons">
                                    <cfoutput query="get_level">
                                        <label class="btn btn-sm btn_change_level my-0 btn-outline-#level_alias# <cfif level_id eq "1">active</cfif> <cfif f_id eq "3" AND level_id gte "4">disabled</cfif>" data-levelid="#level_id#" data-toggle="collapse" data-target="##collapse_#level_id#" <cfif level_id eq "1">aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                            <input type="radio" name="level_id" id="level_id" value="1" autocomplete="off">
                                            <img src="./assets/img_level/#level_alias#.svg" width="30"> #level_name#
                                        </label>
                                    </cfoutput>	
                                    <cfif f_id eq "2">
                                        <label class="btn btn-sm btn_change_level my-0 btn-outline-red" data-levelid="0" data-toggle="collapse" data-target="#collapse_certif" aria-expanded="false">
                                            <input type="radio" name="level_id" id="level_id" value="0" autocomplete="off">
                                            <i class="fa fa-light fa-file-certificate fa-lg mr-2 py-3"></i><cfoutput>#obj_translater.get_translate('card_title_prepa_certif')#</cfoutput>
                                            
                                        </label>
                                    </cfif>
                                </div>
                    
                                <div align="center">
                                    <cfif listFindNoCase(f_list, "en")>
                                        <a href="?f_id=2"><img src="./assets/img_formation/2<cfif f_id neq "2">_nb</cfif>.png" width="36"></a>
                                    </cfif>
                                    <cfif listFindNoCase(f_list, "de")>
                                        <a href="?f_id=3"><img src="./assets/img_formation/3<cfif f_id neq "3">_nb</cfif>.png" width="36"></a>
                                    </cfif>
                                </div>

                                <div align="center">
                                    <i class="fa-thin fa-2x fa-list mr-2 text-info" id="btn_collapse_list" aria-hidden="true"></i>
                                    <i class="fa-thin fa-2x fa-calendar-week text-dark" id="btn_collapse_grid" aria-hidden="true"></i>
                                </div>
                    
                            </div>

                            <hr>
                            

                            <!-------------------LEVEL NEXT VC VIEW --------------------->
                            <div class="core_list_collapse collapse show">
                                
                                <div id="accordion_level">

                                    <cfloop query="get_level">

                                        <cfquery name="get_tp_virtual" datasource="#SESSION.BDDSOURCE#">
                                        SELECT tp_id, formation_id 
                                        FROM lms_tp 
                                        WHERE level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">
                                        AND method_id = 10 
                                        AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                                        AND tp_status_id = 2
                                        </cfquery>

                                        <div id="collapse_<cfoutput>#level_id#</cfoutput>" class="<cfif level_id neq "1">collapse<cfelse>collapse show</cfif>" data-parent="#accordion_level">
                                            
                                            <cfif StructKeyExists(SESSION.USER_LEVEL,'#f_code#')>
                                                
                                                <cfset lvl_id = SESSION.USER_LEVEL['#f_code#'].level_id>
                                                <cfset lvl_verified = SESSION.USER_LEVEL['#f_code#'].level_verified>

                                                <cfif lvl_verified eq "1">

                                                    <cfif lvl_id lt level_id-1>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-12">
                                                            <div class="bg-light text-dark border p-3" align="center">
                                                                <i class="align-self-center fa-solid fa-info-circle fa-lg mr-3"></i>
                                                                <cfoutput>#obj_translater.get_translate('alert_level_insufficient')#</cfoutput>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    </cfif>

                                                <cfelse>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-12">
                                                            <div class="bg-light text-dark border p-3" align="center">
                                                                <i class="align-self-center fa-solid fa-info-circle fa-lg mr-3"></i>
                                                                <cfoutput>#obj_translater.get_translate('alert_level_unverified')#</cfoutput>
                                                                <br>
                                                                <cfoutput>
                                                                <a href="##" class="btn btn-red p-2 m-2 cursored btn_pass_fpt" id="fcode_#f_code#">
                                                                    #obj_translater.get_translate('btn_fpt')#
                                                                </a>
                                                                </cfoutput>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </cfif>

                                            <cfelse>

                                                <div class="row justify-content-center">
                                                    <div class="col-md-12">
                                                        <div class="bg-light text-dark border p-3" align="center">
                                                            <i class="align-self-center fa-solid fa-info-circle fa-lg mr-3"></i>
                                                            <cfoutput>#obj_translater.get_translate('alert_level_unknown')#</cfoutput>
                                                            <br>
                                                            <cfoutput>
                                                            <a href="##" class="btn btn-red p-2 m-2 cursored btn_pass_fpt" id="fcode_#f_code#">
                                                                #obj_translater.get_translate('btn_fpt')#
                                                            </a>
                                                            </cfoutput>
                                                            
                                                        </div>
                                                    </div>
                                                </div>

                                            </cfif>
                                                                
                                            <div class="row">
                                                <cfloop query="get_tp_virtual">

                                                    <cfinvoke component="api/virtualclass/virtualclass_get" method="oget_session_vc" returnvariable="get_session_vc">
                                                        <cfinvokeargument name="t_id" value="#get_tp_virtual.tp_id#">
                                                    </cfinvoke>

                                                    <!--- <cfdump var="#get_session_vc#"> --->

                                                    <cfoutput query="get_session_vc">

                                                        <cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
                                                        SELECT COUNT(*) as nb
                                                        FROM lms_lesson2_attendance la 
                                                        LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
                                                        WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
                                                        AND subscribed = 1
                                                        </cfquery>

                                                        <!--- <cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
                                                        SELECT tpuser_active
                                                        FROM lms_tpuser 
                                                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
                                                        AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                                                        </cfquery> --->

                                                        <cfif count_participant.nb neq "0">
                                                            <cfset seats_total = tp_max_participants>
                                                            <cfset seats_used = count_participant.nb>
                                                            <cfset seats_remaining = tp_max_participants-count_participant.nb>
                                                        <cfelse>
                                                            <cfset seats_total = tp_max_participants>
                                                            <cfset seats_used = 0>
                                                            <cfset seats_remaining = tp_max_participants>
                                                        </cfif>
                                                        
                                                        <cfif get_session_vc.level_id eq get_level.level_id>
                                                        <div class="col-xl-6 col-lg-6 mb-3">
                                                            <!--- subscribed = #subscribed#<br> --->
                                                            
                                                            <cfset display_tab = tp_name>
                                                            <cfinclude template="./incl/incl_session_container.cfm">
                                                        </div>
                                                        </cfif>
                                                    </cfoutput>

                                                </cfloop>
                                            </div>

                                        </div>
                                        
                                    </cfloop>

                                    <!---------------- CERTIFICATIONS ------------->
                                    <cfif f_id eq "2">
                                    <div id="collapse_certif" class="collapse" data-parent="#accordion_level">
                                    
                                        <cfquery name="get_tp_virtual" datasource="#SESSION.BDDSOURCE#">
                                        SELECT tp_id, formation_id 
                                        FROM lms_tp 
                                        WHERE (level_id = 0 OR level_id IS NULL)
                                        AND method_id = 10 
                                        AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                                        AND tp_status_id = 2
                                        </cfquery>


                                        <div class="row">
                                            <cfloop query="get_tp_virtual">

                                                <cfinvoke component="api/virtualclass/virtualclass_get" method="oget_session_vc" returnvariable="get_session_vc">
                                                    <cfinvokeargument name="t_id" value="#get_tp_virtual.tp_id#">
                                                </cfinvoke>

                                                <!--- <cfdump var="#get_session_vc#"> --->

                                                <cfoutput query="get_session_vc">

                                                    <cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
                                                    SELECT COUNT(*) as nb
                                                    FROM lms_lesson2_attendance la 
                                                    LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
                                                    WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
                                                    AND subscribed = 1
                                                    </cfquery>

                                                    <cfif count_participant.nb neq "0">
                                                        <cfset seats_total = tp_max_participants>
                                                        <cfset seats_used = count_participant.nb>
                                                        <cfset seats_remaining = tp_max_participants-count_participant.nb>
                                                    <cfelse>
                                                        <cfset seats_total = tp_max_participants>
                                                        <cfset seats_used = 0>
                                                        <cfset seats_remaining = tp_max_participants>
                                                    </cfif>
                                                     
                                                    <cfif get_session_vc.level_id eq "0" OR get_session_vc.level_id eq "">
                                                    <div class="col-xl-6 col-lg-6 mb-3">
                                                        <!--- subscribed = #subscribed#<br> --->
                                                        
                                                        <cfset display_tab = tp_name>
                                                        <cfinclude template="./incl/incl_session_container.cfm">
                                                    </div>
                                                    </cfif>
                                                </cfoutput>

                                            </cfloop>
                                        </div>

                                    </div>
                                    </cfif>

                                </div>
                            </div>

                            <!-------------------CALENDAR VIEW --------------------->
                            <div class="core_grid_collapse collapse">

                                <div class="row">

                                    <div class="col-md-12" id="calendar_content">
                                        <!--- <div class="card border h-100">
                                            <div class="card-body"> --->
                                                
                                                <!--- <div class="w-100 d-flex justify-content-between">
                                                    <h5 class="d-inline mb-2"><i class="fa-thin fa-users-viewfinder fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('vc_card_title')#</cfoutput></h5>
                                                </div>
                                                <hr class="border-dark mb-1 mt-0"> --->

                                                <div class="w-100 d-flex justify-content-center">

                                                    <cfoutput>
                                                        <a class="btn btn-outline-red btn_prev_week"><i class="fa-solid fa-chevrons-left"></i> <cfoutput>#obj_translater.get_translate('btn_prev')#</cfoutput></a>
                                                        <a class="btn btn-outline-red btn_next_week"><cfoutput>#obj_translater.get_translate('btn_next')#</cfoutput> <i class="fa-solid fa-chevrons-right"></i></a>
                                                    </cfoutput>

                                                </div>

                                                <div class="row m-0 mt-3" id="container_vc">

                                                </div>

                                            <!--- </div>
                                        </div> --->
                                    
                                    </div>

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

<cfinclude template="./incl/incl_scripts_lesson.cfm">

<script>

$( document ).ready(function() {

    <cfif listFindNoCase("LEARNER,GUEST,TEST,TM", SESSION.USER_PROFILE)>

        <cfif StructKeyExists(SESSION.USER_LEVEL,'#f_code#')>
            // <cfif SESSION.USER_LEVEL['#f_code#'].level_verified eq 0>
            //     $('#window_item_xl').modal({keyboard: false});
            //     $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#</cfoutput>");
            //     $('#modal_body_xl').load("modal_window_qpt_launch.cfm?f_code=en&choice=fpt&pt_type=start&vc_test=1", function() {});
            // </cfif>
        <cfelse>
            $('#window_item_xl').modal({keyboard: false});
            $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#</cfoutput>");
            $('#modal_body_xl').load("modal_window_qpt_launch.cfm?f_code=en&choice=fpt&pt_type=start&vc_test=1", function() {});
        </cfif>

    </cfif>
    
    <cfoutput>
    $('.btn_pass_fpt').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var f_code = idtemp[1];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt_launch.cfm?f_code="+f_code+"&choice=fpt", function() {});
	})
    </cfoutput>

    $('#btn_collapse_list').click(function(event) {
        
        $("#btn_collapse_list").removeClass("text-dark");
        $("#btn_collapse_list").addClass("text-info");

        $("#btn_collapse_grid").removeClass("text-info");
        $("#btn_collapse_grid").addClass("text-dark");

        $(".core_list_collapse").collapse("show");
        $(".core_grid_collapse").collapse("hide");

    })

    $('#btn_collapse_grid').click(function(event) {

        $("#btn_collapse_list").removeClass("text-info");
        $("#btn_collapse_list").addClass("text-dark");

        $("#btn_collapse_grid").removeClass("text-dark");
        $("#btn_collapse_grid").addClass("text-info");

        $(".core_list_collapse").collapse("hide");
        $(".core_grid_collapse").collapse("show");

    })

    date_ref = "<cfoutput>#date_ref#</cfoutput>";
    level_id = "<cfoutput>1</cfoutput>";
    f_id = "<cfoutput>#f_id#</cfoutput>";
    _today =  moment().format('YYYY-MM-DD')
    $('.btn_change_level').click(function(event) {
        level_id = $(this).data("levelid");
        display_week(date_ref);
    })

    $('.btn_next_week').click(function(event) {
        let date_format_db = moment(date_ref).add(7,'days').format('YYYY-MM-DD');
        date_ref = date_format_db;
        display_week(date_ref);
    });	

    $('.btn_prev_week').click(function(event) {
        let date_format_db = moment(date_ref).add(-7,'days').format('YYYY-MM-DD');
        if (date_format_db >= _today) {
            date_ref = date_format_db;
            display_week(date_ref);
        }
    });	


    function display_week(date_ref) {
        // console.log(date_ref);
        $("#container_vc").empty();
        // alert(level_id);
        $.ajax({				 
            url: './api/virtualclass/virtualclass_get.cfc?method=oget_vc_week_level',
            type: "POST",
            data: {date_ref:date_ref,level_id:level_id,f_id:f_id},
            datatype : "html",
            success : function(result, statut){
                // console.log(result);            
                $("#container_vc").append(result);
                $(".btn_join_class").off("click",handler_join_class);
                $(".btn_join_class").bind("click",handler_join_class);
                $(".btn_view_tp").off("click",handler_view_tp);
                $(".btn_view_tp").bind("click",handler_view_tp);
            }
        })
    }
    display_week(date_ref);

})


$(document).on('hidden.bs.modal', function (event) {
  if ($('.modal:visible').length) {
    $('body').addClass('modal-open');
  }
});
</script>



</body>
</html>




