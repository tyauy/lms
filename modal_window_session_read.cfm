<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
<script type="text/javascript" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>


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
        background-color: #d55959;
    }


    <!--------------------------TO FIX ----------------------------->
    @media (max-width: 768px) { 
    .modal-xl {
        max-width: none !important;
        width: 80% !important;
    }
    }
</style>

<cfparam name="s_id">
<cfparam name="t_id">
<cfparam name="u_id" default="#SESSION.USER_ID#">
<cfparam name="tab" default="general">

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
</cfquery>

<!--- <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")> --->

<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>
<cfset l_id = get_session.lesson_id>



<!--- <cfset u_id = get_session.user_id> --->
<cfset SESSION.cur_rank_session = get_session.session_rank>

<!--- <cfdump var="#get_session#"> --->

<cfquery name="get_prev_session" datasource="#SESSION.BDDSOURCE#">
    SELECT s.session_id, s.session_rank FROM lms_tpsession s
    WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
    AND s.session_rank < #get_session.session_rank# 
    ORDER BY s.session_rank DESC
    LIMIT 1
</cfquery>

<cfquery name="get_next_session" datasource="#SESSION.BDDSOURCE#">
    SELECT s.session_id, s.session_rank FROM lms_tpsession s
    WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
    AND s.session_rank > #get_session.session_rank# 
    ORDER BY s.session_rank ASC
    LIMIT 1
</cfquery>

<cfquery name="get_all_session" datasource="#SESSION.BDDSOURCE#">
    SELECT s.session_id, s.session_rank 
    FROM lms_tpsession s
    WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
    ORDER BY s.session_rank ASC
</cfquery>


<div class="container">
    
    <!----------------------------- TOP NAV ----------------------------->
    <div class="container sticky-top bg-light border-bottom border-red mb-3">
        
        <div class="row">
            <div class="col-md-12">

                <div class="p-2">

                    <div class="scrolling-wrapper row flex-row flex-nowrap mt-3 pb-1 pt-1" id="scroll1">
                
                        <cfoutput query="get_all_session">
                            <cfif get_session.session_rank eq session_rank>
                                <div id="rkl_#session_rank#">
                                    <a class="btn btn-sm btn-red border-red" id="selected_menu" type="button">#session_rank#</a>
                                </div>
                            <cfelse>
                                <div id="rkl_#session_rank#">
                                <a class="btn btn-sm btn-outline-red btn_change_window_session" id="m_#session_id#" type="button">#session_rank#</a>
                                </div>
                            </cfif>
                        </cfoutput>

                    </div>
        
                </div>

            </div>
        </div>

        <!----------------------------- MENU SESSION SMALL DEVICES  ----------------------------->

        <div class="row d-block d-lg-none">

            <!-------------- PREV SESSION --------->
            <cfif get_prev_session.recordCount GT 0>
                <cfoutput query="get_prev_session">
                    <!--- <a class="btn btn-link btn_change_window_session" id="s_#session_id#" type="button">< prev</a> --->
                    <a title="Back" class="btn btn-outline-red flex-fill btn_change_window_session" id="s_#session_id#" type="button"><i class="fa-thin fa-backward"></i></h5></a>
                </cfoutput>
            <cfelse>
                <!--- <a class="btn btn-link" disabled type="button">< prev</a> --->
                <a title="Back" class="btn btn-outline-red  flex-fill" type="button" disabled><i class="fa-thin fa-backward"></i></h5></a>
            </cfif>



            <a title="General" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_general" type="button">
                <i class="fa-thin fa-files"></i>
            </a>

            <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                <a title="Customize" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_customize" type="button">
                    <i class="fa-thin fa-files"></i>
                </a>
            </cfif>

            <!--- <a class="btn btn-link flex-fill btn_change_window_tab" id="menu_files" type="button">
                <i class="fa-thin fa-files"></i>Attachements
            </a> --->

            <a title="Vocab" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_vocab" type="button">
                <i class="fa-thin fa-language"></i>
            </a>

            <a title="LN" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_note" type="button" <!---<cfif l_id eq "">disabled</cfif>--->>
                <i class="fa-thin fa-page-caret-down"></i>
            </a>

            <a title="Assessment" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_assessment" type="button" <!---<cfif l_id eq "">disabled</cfif>--->>
                <i class="fa-thin fa-starfighter-twin-ion-engine"></i>
            </a>

            <a title="Go further ?" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_further" type="button">
                <i class="fa-thin fa-laptop"></i>
            </a>

            <a title="Rate my lesson" class="btn btn-outline-red flex-fill btn_change_window_tab" id="menu_rating" type="button">
                <i class="fa-thin fa-star"></i>
            </a>




            <!-------------- NEXT SESSION --------->
            <cfif get_next_session.recordCount GT 0>
                <cfoutput query="get_next_session">
                    <!--- <a class="btn btn-link btn_change_window_session" id="s_#session_id#" type="button">< prev</a> --->
                    <a title="Next" class="btn btn-outline-red flex-fill btn_change_window_session" id="s_#session_id#" type="button" role="tab"><i class="fa-thin fa-forward"></i></h5></a>
                </cfoutput>
            <cfelse>
                <!--- <a class="btn btn-link" disabled type="button">< prev</a> --->
                <a title="Next" class="btn btn-outline-red flex-fill" type="button" role="tab" disabled><i class="fa-thin fa-forward"></i></a>
            </cfif>


        </div>



        
        <!----------------------------- MENU SESSION WIDE DEVICES  ----------------------------->
        
        <div class="row d-none d-lg-block">

            <div class="d-flex justify-content-center">

                <!-------------- PREV SESSION --------->
                <cfif get_prev_session.recordCount GT 0>
                    <cfoutput query="get_prev_session">
                        <!--- <button class="btn btn-link btn_change_window_session" id="s_#session_id#" type="button">< prev</button> --->
                        <button class="btn btn-link flex-fill btn_change_window_session" id="s_#session_id#" type="button">
                            <h5><i class="fa-light fa-backward"></i></h5> Back
                        </button>
                    </cfoutput>
                <cfelse>
                    <!--- <button class="btn btn-link" disabled type="button">< prev</button> --->
                    <button class="btn btn-link flex-fill" type="button" disabled>
                        <h5><i class="fa-light fa-backward"></i></h5> Back
                    </button>
                </cfif>



                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_general" type="button">
                    <h5><i class="fa-light fa-files"></i></h5> Général
                </button>

                <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                    <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_customize" type="button">
                        <h5><i class="fa-light fa-screwdriver-wrench"></i></h5> Customize
                    </button>
                </cfif>

                <!--- <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_files" type="button">
                    <h5><i class="fa-thin fa-files"></i></h5> Attachements
                </button> --->

                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_vocab" type="button">
                    <h5><i class="fa-light fa-language"></i></h5> Vocab list
                </button>

                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_note" type="button" <!---<cfif l_id eq "">disabled</cfif>--->>
                    <h5><i class="fa-light fa-page-caret-down"></i></h5> Lesson Notes
                </button>

                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_assessment" type="button" <!---<cfif l_id eq "">disabled</cfif>--->>
                    <h5><i class="fa-light fa-starfighter-twin-ion-engine"></i></h5> Assessment
                </button>
                
                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_further" type="button">
                    <h5><i class="fa-light fa-laptop"></i></h5> Go further ?
                </button>

                <button class="btn btn-link flex-fill btn_change_window_tab" id="menu_rating" type="button">
                    <h5><i class="fa-light fa-star"></i></h5> Rate my lesson
                </button>




                <!-------------- NEXT SESSION --------->
                <cfif get_next_session.recordCount GT 0>
                    <cfoutput query="get_next_session">
                        <!--- <button class="btn btn-link btn_change_window_session" id="s_#session_id#" type="button">< prev</button> --->
                        <button class="btn btn-link flex-fill btn_change_window_session" id="s_#session_id#" type="button" role="tab">
                            <h5><i class="fa-thin fa-forward"></i></h5> Next
                        </button>
                    </cfoutput>
                <cfelse>
                    <!--- <button class="btn btn-link" disabled type="button">< prev</button> --->
                    <button class="btn btn-link flex-fill" type="button" role="tab" disabled>
                        <h5><i class="fa-thin fa-forward"></i></h5> Next
                    </button>
                </cfif>




            </div>
        </div>

        <!--- <hr class="border-top border-danger m-0 mb-3"> --->
    
        
    </div>













    







    <div id="container_session" style="min-height:600px">








            <cfswitch expression="#tab#"> 



                <!--------------------------- GENERAL --------------------------------->
                
                <cfcase value="general">
                <!--- >>>>> <cfoutput>#t_id#</cfoutput> --->
                    <cfif l_id neq "">
                        <cfinclude template="./widget/wid_session_general.cfm">
                    <cfelse>
                        <cfset m_id=get_session.method_id>
                        <cfset s_dur=get_session.session_duration>
                        <cfinclude template="./widget/wid_session_general.cfm">
                    </cfif>
                </cfcase>


















                
                <!--------------------------- CUSTOMIZATION --------------------------------->

                <cfcase value="customize">
                    <!--- <cfset new_grammar_point = 1>
                    <cfinclude template="./widget/wid_session_customize.cfm"> --->

                    
                    

                </cfcase>





















                <!--------------------------- FILE ATTACH /// REMOVE --------------------------------->

                <!--- <cfcase value="files">

                    <div class="alert alert-danger">

                        TRANSFERT DANS CUSTOMIZE + GENERAL + KILL TAB
                    </div>

                    
                    <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                        <cfinclude template="./modal_window_session_upload.cfm">
                        <hr class="border-top border-danger">
                    </cfif>
                    <cfinclude template="./widget/wid_lesson_note_attachment.cfm">
                </cfcase>  --->





















                <!--------------------------- VOCAB MANAGEMENT --------------------------------->

                <cfcase value="vocab">


                    


                    <!--- <cfinclude template="./widget/wid_lesson_note_vocab.cfm"> --->
                    <!--- <cfinclude template="./widget/wid_session_vocab.cfm">   --->
                </cfcase>
















                <!--------------------------- LESSON NOTE MANAGEMENT --------------------------------->
                <cfcase value="note">
                    <!--- <cfinclude template="./widget/wid_session_note.cfm">                     --->
                </cfcase>


















                <!---------------------------ASSESSMENT MANAGEMENT --------------------------------->


                <cfcase value="assessment">

                    <!--- <div class="alert alert-danger">
                        LISTE DE SKILL 1 à 4
                    </div>

                    <div class="accordion" id="skills_accordion">
						
						<cfloop query="get_skill">
						
                            <cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
                            SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
                            FROM lms_skill_sub 
                            WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
                            </cfquery>

                            <div class="card border">
                                <div class="card-header p-4" id="<cfoutput>skill_#get_skill.skill_id#</cfoutput>" data-toggle="collapse" data-target="#div_<cfoutput>#get_skill.skill_id#</cfoutput>" aria-expanded="true" aria-controls="div_<cfoutput>#get_skill.skill_id#</cfoutput>">
                                    <h6 class="mb-0">
                                    <i class="<cfoutput>#get_skill.skill_icon#</cfoutput> fa-lg"></i> <cfoutput>#get_skill.skill_name#</cfoutput>
                                    </h6>
                                </div>

                                <div id="div_<cfoutput>#get_skill.skill_id#</cfoutput>" class="collapse <cfif get_skill.skill_id eq "1">show</cfif>" aria-labelledby="skill_<cfoutput>#get_skill.skill_id#</cfoutput>" data-parent="#skills_accordion">
                                    
                                    <div class="card-body">
                                    
                                        <cfset counter = 2>
                                            
                                        <cfloop query="get_skill_sub">

                                            <cfset _skill_id = get_skill_sub.skill_sub_id>
                                            <cfinclude template="./widget/wid_level_list.cfm">

                                            <table class="table bg-light table-borderless border">
                                                <tbody><tr align="center">
                                                
                                                    <td class="bg-light text-muted" width="150">
                                                    
                                                    
                                                    <i class="fa-thin fa-chart-user fa-2x"></i>
                                                    
                                                    <br>Aptitudes</td>
                                                    <td align="left">	
                                                        
                                                        <strong>Compréhension orale</strong>
                                                        <p>
                                                            Can generally understand the main idea of clear standard speech about work, family and leisure<br>Can generally understand language related to professional areas when delivery is slow and clear
                                        Can generally understand main point of news or TV programs 
                                                        </p>
                                                    </td>
                                                </tr>
                                            </tbody></table>

                                        </cfloop>

                                    </div>
                                </div>
                            </div>

						</cfloop>
                    </div>
                    --->


                    

                    <cfif l_id neq "">
                        <cfinclude template="./widget/wid_session_assessment.cfm">
                    </cfif>
                    
                </cfcase>
                






                <cfcase value="further">
                    <cfinclude template="./widget/wid_session_further.cfm">
                </cfcase>





                <cfcase value="rating">
                    <cfif l_id neq "">
                        <cfif get_session.status_id eq "5"> 
                            <cfset get_rating = obj_query.oget_rating(l_id)>
                            <cfif get_rating.recordcount eq 0>
                                <cfinclude template="./modal_window_ratings.cfm">
                            <cfelse>
                                <cfinclude template="./modal_window_rated.cfm">
                            </cfif>
                        </cfif>
                    </cfif>
                </cfcase>

                
                
            </cfswitch>

            <!--- </div> --->


        <!--- </div>

    </div> --->


    </div>

</div>

<script>
    $(document).ready(function() {

        var _setting = {<cfoutput>
            t_id:'#t_id#',
            s_id:'#s_id#',
            u_id:'#u_id#',
            tab:'#tab#'
        </cfoutput>}

        $('#menu_<cfoutput>#tab#</cfoutput>').addClass("text-red");
    
        $('.btn_change_window_session').click(function() {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var s_id = idtemp[1];

            $('#modal_body_xl').empty();
            _setting.s_id = s_id;
            $('#modal_body_xl').load("modal_window_session_read.cfm",_setting, function() {});
        });








        $('.btn_change_window_tab').click(function() {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var tab = idtemp[1];


            $('.btn_change_window_tab').removeClass("text-red");
            $(this).addClass("text-red");

            // console.log(tab);


            // $('#modal_body_xl').empty();
            // _setting.tab = tab;
            // $('#modal_body_xl').load("modal_window_session_read.cfm",_setting, function() {});


            _setting.tab = tab;

            $('#container_session').empty();
            $('#container_session').load("./widget/wid_session_"+tab+".cfm",_setting, function() {});
            


        });



        $('.lang_translate').click(function(event) {	

            var lang_translate = [];
            if($('#lang_en').is(":checked")){lang_translate.push("en")}
            if($('#lang_fr').is(":checked")){lang_translate.push("fr")}
            if($('#lang_de').is(":checked")){lang_translate.push("de")}

            $('#modal_body_xl').empty();
            console.log(_setting)
            $('#modal_body_xl').load("modal_window_session_read.cfm?lang_translate="+lang_translate,_setting, function() {});


        });





        <!------------------ A CODER !! PLACEMENT DU SCROLL EN FONCTION DU SESSION RANK HIGHLIGHT -------------->
        const element = document.getElementById("rkl_15");
        element.scrollIntoView({block: "center"})





    });
</script>