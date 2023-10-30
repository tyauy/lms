<!--- <cfset lang_el = "en"> --->
<!--- <style>
.transcript-word {
    cursor: pointer;
    border-bottom: 1px dashed #007bff;
}
</style> --->
<cfquery name="get_el_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT 
sm.sessionmaster_id, sm.sessionmaster_md, sm.level_id as sm_level_id, sm.sessionmaster_name, sm.sessionmaster_code, sm.sessionmaster_video_duration,sm.sessionmaster_grammar, sm.sessionmaster_objectives, sm.sessionmaster_ressource,
CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
sm.sessionmaster_transcript_fr, sm.sessionmaster_transcript_en, sm.sessionmaster_transcript_de, sm.sessionmaster_transcript_es, sm.sessionmaster_transcript_it
FROM lms_tpsessionmaster2 sm
<!----INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#) --->
WHERE sessionmaster_online_el = 1
AND sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
SELECT kw.keyword_name_#SESSION.LANG_CODE# as keyword_name, kw.keyword_id 
FROM lms_sessionmaster_keywordid_cor skc
INNER JOIN lms_keyword kw ON kw.keyword_id = skc.keyword_id
WHERE skc.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfoutput query="get_el_sessionmaster">
    

    <!--- <cfif SESSION.USER_ID eq "202">


        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.en-US.txt")>
                
            <cffile action="read" file="#SESSION.BO_ROOT_URL#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.en-US.txt" variable="parse_sub" charset="utf-8">
    
            </cffile>
            <cfloop list="#parse_sub#" index="cor" delimiters="#chr(13)##chr(10)#"> 
                <cfif !isnumeric(mid(cor,1,2))>
                    #cor# <br>
                <cfelse>
                    <cfset sec = mid(cor,7,2)>
                    <cfset min = mid(cor,4,2)*60>
                    <cfset go = sec+min>
                    <button class="btn btn-sm btn-info jump_go" data-timego="#go#">#go#</button><br>
                </cfif>
            </cfloop>
                
        </cfif>
    </cfif> --->

    
    <div class="shadow-sm rounded border m-0 w-100 bg-light">

        <div class="card-body">
    
            <div class="row">
    
                <!--- <div class="col-md-3">
                
                    <div class="card">
                                    
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                            <img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                            <img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
                        <cfelse>
                            <img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
                        </cfif>
                        
                    </div>
                    
                </div> --->
    
                <div class="col-md-12">
    
                    <div class="d-flex flex-column h-100">
                    
                        <div>
                            <h5 class="m-0">
                            <!--- <img src="./assets/img_formation/2.png" width="32" class="border_thumb mr-1">
                            
                            <img src="./assets/img_level/A1.svg" width="32" class="mr-1"> --->
                            #sessionmaster_name#
                            </h5>
                            <small class="text-red">#sessionmaster_video_duration#<cfif sessionmaster_grammar neq ""> | #sessionmaster_grammar#</cfif><cfif sessionmaster_objectives neq ""> | #sessionmaster_objectives#</cfif></small>

                        </div>
                    
                        <div>
                            <p class="mt-1 mb-0">
    
                                <!--- <small></small> --->
                                #sessionmaster_description#

                                <br>

                                #obj_function.get_level_thumb(sm_level_id,"30")#
<!---                                 
    
                                <img src="./assets/img_level/B1.svg" width="30" align="left" class="mr-1 mt-2">
                                <img src="./assets/img_level/B2.svg" width="30" align="left" class="mr-1 mt-2">
                                <img src="./assets/img_level/C1.svg" width="30" align="left" class="mr-1 mt-2"> --->


                                <cfif get_kw.recordcount neq "0">
    
                                    <cfloop query="get_kw">
                                    <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                                    </cfloop>
    
                                </cfif>
                                   <!---  
                                <cfif get_keyword_tracking_business.recordcount neq "0">
    
                                    <strong><i class="fal fa-briefcase" aria-hidden="true"></i> Business Skills :</strong>
                                    <br>
                                    <cfloop query="get_keyword_tracking_business">
                                    <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                                    </cfloop>
                                    <br><br>
    
                                </cfif>
    
                                <cfif get_vocab_tracking.recordcount neq "0">
                                    <strong><i class="fal fa-language" aria-hidden="true"></i> Vocab List :</strong>
                                    <br>
                                    <cfloop query="get_vocab_tracking">
                                    <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#voc_cat_name#</span>
                                    </cfloop>
                                    <br><br>
    
                                </cfif>
    
                                <cfif get_mapping_tracking.recordcount neq "0">
                                    <strong><i class="fal fa-spell-check" aria-hidden="true"></i> Language Points :</strong>
                                    <br>
                                    <cfloop query="get_mapping_tracking">
                                    <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#mapping_name#</span>
                                    </cfloop>
                                    <br><br>
    
                                </cfif> --->
    
                                
                            </p>
                        </div>
    
                    </div>
    
                </div>
    
            </div>
    
        </div>
    
    </div>

    <!--- <div class="w-100 mt-4">
        <h5 class="d-inline"><i class="fa-thin fa-video text-red fa-lg mr-2"></i>Vidéo</h5>
        <hr class="border-danger mb-1 mt-2">
    </div> --->

    <cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.mp4")>


        <div class="d-flex justify-content-center">

                
            <div class="btn btn-link btn_change_window_tab text-red" id="menu_transcript" data-toggle="collapse" href="##collapse_transcript">
            <h5><i class="fa-light fa-files"></i></h5> Transcript
            </div>
    
            <!--- <div class="btn btn-link btn_change_window_tab disabled" id="menu_quiz" <!---data-toggle="collapse" href="##collapse_quiz"--->>
            <h5><i class="fa-light fa-screwdriver-wrench"></i></h5> Practice
            </div>
    
            <div class="btn btn-link btn_change_window_tab disabled" id="menu_vocab">
            <h5><i class="fa-light fa-language"></i></h5> Vocab list
            </div> --->
    
            <div class="btn btn-link btn_change_window_tab" id="menu_quiz" data-toggle="collapse" href="##collapse_quiz">
                <h5><i class="fa-light fa-list-check"></i></h5> Validation Quiz
            </div>


                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                <div class="btn btn-link btn_change_window_tab" id="menu_WS" data-toggle="collapse" href="##collapse_WS">
                    <h5><i class="fa-light fa-lg fa-file-alt"></i></h5>#obj_translater.get_translate('btn_el_support')#</div>
                </div>
                <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                <div class="btn btn-link btn_change_window_tab" id="menu_WSK" data-toggle="collapse" href="##collapse_WSK">
                    <h5><i class="fa-light fa-lg fa-file-alt"></i></h5>#obj_translater.get_translate('btn_el_support')#</div>
                </div>
                </cfif>
                
                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
                <div class="btn btn-link btn_change_window_tab" id="menu_K" data-toggle="collapse" href="##collapse_K">
                    <h5><i class="fa-light fa-lg fa-file-alt"></i></h5>#obj_translater.get_translate('btn_el_keys')#</div>
                </div>
                </cfif>



            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                
            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                
            </cfif>
                
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
               
            </cfif>


    
        </div>

        <hr class="border-danger mt-0 mb-1">

        <div class="row justify-content-center mt-4">
            <div class="col-md-6">

                    
                <video id="video_el" class="sticky-top pt-3" controls controlsList="nodownload" width="100%" id="video_#get_el_sessionmaster.sessionmaster_id#" poster="../assets/img_material/#sessionmaster_id#.jpg">
                <source src="#SESSION.BO_ROOT_URL#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.mp4" type="video/mp4">

                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.en-US.vtt")>
                    <track 
                    kind="subtitles" 
                    src="#SESSION.BO_ROOT_URL#/assets/materials_video/#get_el_sessionmaster.sessionmaster_ressource#.en-US.vtt" 
                    srclang="en"
                    label="Anglais">
                </cfif>

                </video>


                <small><cfoutput>#obj_translater.get_translate('alert_subtitle_available')#</cfoutput></small>
            
            
            
            </div>
            <div class="col-md-6">



                
            
            
                <div class="collapse collapse_tab show" id="collapse_transcript">
            
                    <ul class="nav nav-tabs mt-3" id="title_list" role="tablist">
                        <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
            
                            <cfif cor eq "fr">
                                <cfset f_id = "1">
                            <cfelseif cor eq "en">
                                <cfset f_id = "2">
                            <cfelseif cor eq "de">
                                <cfset f_id = "3">
                            <cfelseif cor eq "es">
                                <cfset f_id = "4">
                            <cfelseif cor eq "it">
                                <cfset f_id = "5">
                            </cfif>
                
                            <cfif evaluate("sessionmaster_transcript_#cor#") neq "">
                            <li class="nav-item">		
                            <a href="##transcript_#cor#" class="nav-link <cfif cor eq "en">active</cfif>" role="tab" data-toggle="tab">
                                <img src="./assets/img_formation/#f_id#.png" width="30"></span>
                            </a>
                            </li>
                            </cfif>
                        </cfloop>        
                    </ul>
                
                    <div class="tab-content">
                        
            
                        <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
                        <cfif evaluate("sessionmaster_transcript_#cor#") neq "">
                
                            <div role="tabpanel" class="tab-pane <cfif cor eq "en">active show</cfif>" id="transcript_#cor#" style="margin-top:15px;">
                                <cfset sessionmaster_transcript_go = replaceNoCase(evaluate("sessionmaster_transcript_#cor#"),"<p>&nbsp;</p>","","ALL")>
                                <cfset sessionmaster_transcript_go = reReplace(sessionmaster_transcript_go,"\b(\d{2}):(\d{2})\b","µ\1:\2","ALL")>
                                <!--- #sessionmaster_transcript_go# --->
            
            
            
                                <cfloop list="#sessionmaster_transcript_go#" index="cor2" delimiters="µ">
                                    
                                    <cfif isnumeric(mid(cor2,1,2))>
                                        
                                        <cfset min = mid(cor2,1,2)*60>
                                        <cfset sec = mid(cor2,4,2)>
                                        <cfset go = sec+min>
                                    
                                        <button class="btn btn-sm btn-info jump_go" data-timego="#go#">GO TO #mid(cor2,1,5)#</button>
                                        <br>
                                       <!-- Wrap each word with a span tag -->
                                    <cfloop list="#mid(cor2,6,len(cor2))#" index="word" delimiters=" ">
                                        <span class="transcript-word" data-toggle="tooltip" title="">#word#</span> 
                                    </cfloop>
                                    </cfif>
            
                                </cfloop>
            
            
            
            
                                
                                <!--- <cfset sec = mid(cor,7,2)>
                                <cfset min = mid(cor,4,2)*60>
                                <cfset go = sec+min> --->
            
                                <!--- #sessionmaster_transcript_go# --->
                            </div>
                
                        </cfif>
                        </cfloop>                                   
                    </div>
                </div>
            
            
            
                <div class="collapse collapse_tab" id="collapse_quiz">
            
                    <div align="center">
            
                        <cfquery name="get_quiz_unit" datasource="#SESSION.BDDSOURCE#">
                            SELECT *
                            FROM lms_quiz
                            WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND quiz_type = 'unit'
                            AND quiz_active = 1
                            LIMIT 1
                            </cfquery>
                            
                            <cfloop query="get_quiz_unit">
            
                                <cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                                </cfquery>
            
                                <cfif get_result_unit.recordcount eq "0">
            
            
                                    <div class="bg-white border mr-2 rounded container_btn_view_quiz" style="position:relative">
                                        
            
                                       
            
                                        <!--- <cfdump var = "#get_module_id#"> --->
                                        <a class="btn btn-link m-0 btn_start_quiz_video" id="q_#quiz_id#">
                                            <div align="center">
                                            <cfloop from="1" to="5" index="star"><i class="fa-light fa-star"></i></cfloop>
                                            <br>Validation Quiz
                                            </div>	
                                        </a>
            
                                        <!--- <br>
            
                                        <div class="progress" style="height:5px">
                                            <div class="progress-bar progress-bar-striped bg-success progress-bar-animated bg-#level_alias#" role="progressbar" style="width: #elearning_progress#%" aria-valuenow="#elearning_progress#" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div> --->
                                    
                                    </div>
            
                           
                                    
            
                                    <!--- <a class="btn btn-outline-#level_css# mr-0 ml-0 btn_start_quiz" id="q_#quiz_id#" <!---href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" target="_blank"--->>
                                        Validation Quiz
                                        <br>
                                        <cfloop from="1" to="5" index="star"><i class="fa-light fa-star"></i></cfloop>
                                    </a> --->
                                <cfelse>
            
                                    <cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
                                    SELECT SUM(ans_gain) as score
                                    FROM lms_quiz_result
                                    WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_unit.quiz_user_id#">
                                    </cfquery>
                                    
                                    <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
                                    SELECT SUM(ans_gain) as quiz_score
                                    FROM lms_quiz_answer a 
                                    INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
                                    INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
                                    WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                                    </cfquery>
            
                                    <cfif get_result_score.score neq "">
                                        <cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
                                    <cfelse>
                                        <cfset global_note = "0">
                                    </cfif>
            
                                    <cfif global_note gte 80>
                                        <cfset cssgo = "success">
                                    <cfelseif global_note gt 20 AND global_note lt 80>
                                        <cfset cssgo = "warning">
                                    <cfelseif global_note lte 20>
                                        <cfset cssgo = "danger">
                                    </cfif>
            
                                    <div class="bg-white border mr-2 rounded container_btn_view_quiz" style="position:relative">
                                    
            
                                        <a class="btn btn-link m-0 btn_view_quiz_video" id="quiz_#quiz_id#">
                                            <div align="center">
                                            <i class="<cfif global_note gte 20>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 40>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 60>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 80>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 100>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
                                            <br>Validation Quiz
                                            </div>											
                                        </a>
                                        
                                    </div>
                                    <!--- <a class="btn btn-outline-#level_alias# mr-0 ml-0 btn_view_quiz_video" id="quiz_#get_result_unit.quiz_user_id#">
                                        Validation Quiz
                                        <br>
            
                                        <cfif get_result_score.score neq "">
                                            <cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
                                        <cfelse>
                                            <cfset global_note = "0">
                                        </cfif>
                    
                                        <cfif global_note gte 80>
                                            <cfset cssgo = "success">
                                        <cfelseif global_note gt 20 AND global_note lt 80>
                                            <cfset cssgo = "warning">
                                        <cfelseif global_note lte 20>
                                            <cfset cssgo = "danger">
                                        </cfif>
                                        
                                        <i class="<cfif global_note gte 20>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 40>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 60>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 80>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 100>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
            
                                    </a> --->
                                    
                                </cfif>
            
                            </cfloop>

                            <div id="container_quiz_video">

                            </div>
            
            
                        <!--- $('.btn_view_quiz_video').click(function(event) {	
                            event.preventDefault();		
                            var idtemp = $(this).attr("id");
                            var idtemp = idtemp.split("_");
                            var quiz_user_id = idtemp[1];	
                            $('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
                            $('##window_item_xl').modal({keyboard: true});
                            $('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
                        })
                         --->
                    </div>
                
                </div>


                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") AND not fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                    <div class="collapse collapse_tab" id="collapse_WS">
                        <div class="container">
                            <div class="row mt-2">
                                <div class="col-md-12">
                                <iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WS"></iframe>
                                </div>
                            </div>
                        </div>											
                    </div>
                <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                    <div class="collapse collapse_tab" id="collapse_WSK">
                        <div class="container">
                            <div class="row mt-2">
                                <div class="col-md-12">
                                <iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=WSK"></iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfif>
                    
                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
                    <div class="collapse collapse_tab" id="collapse_K">
                        <div class="container">
                            <div class="row mt-2">
                                <div class="col-md-12">
                                <iframe width="100%" height="600" src="view_container.cfm?sm_md=#sessionmaster_md#&tdoc=K"></iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </cfif>

                

            </div>
        </div>

    <cfelse>
        
        <div align="center">
            Houston, we have a problem...
        </div>
    </cfif>

</cfoutput>


<script>
$(document).ready(function() {
   
    
	/****** INIT BOOSTRAP COMPONENTS *******/	
	// $('[data-toggle="popover"]').popover({
    //     trigger: 'focus',
    //     html: true
    //     });
    //     $('[data-toggle="tooltip"]').tooltip();
    //     $(".transcript-word").click(function() {
    //     event.stopPropagation();  // Stop the event from bubbling up the DOM tree
    //     var wordToTranslate = $(this).text();
    //     console.log(wordToTranslate);
    //     var clickedElement = $(this);  // Store reference to the clicked word

    //     // Call a ColdFusion function or another endpoint to get the translation
    //     $.post('translateWord.cfm', { word: wordToTranslate }, function(translatedWord) {
    //         clickedElement.attr('title', translatedWord);  // Set the title attribute with the translated word
    //     });
    // });

   <!--- var hoverTimeout;

$(".transcript-word").hover(function() {
    var wordToTranslate = $(this).text();
    var hoveredElement = $(this);  // Store reference to the hovered word

    hoverTimeout = setTimeout(function() {
        // Check if the word has already been translated to avoid unnecessary API calls
        if(!hoveredElement.attr('title')) {
            // Call a ColdFusion function or another endpoint to get the translation
            $.post('translateWord.cfm', { word: wordToTranslate }, function(translatedWord) {
                hoveredElement.attr('title', translatedWord);  // Set the title attribute with the translated word
            });
        }
    }, 1000);  // 1000ms = 1 second delay

}, function() {
    // This function is executed when the mouse leaves the word
    clearTimeout(hoverTimeout);  // Cancel the translation request if the mouse leaves before 2 seconds
}); --->



    $('.btn_change_window_tab').click(function() {
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var tab = idtemp[1];
        // alert(tab);

        
        $('.collapse_tab').collapse("hide");

        
        $('#collapse_'+tab).collapse("show");

        $('.btn_change_window_tab').removeClass("text-red");
        $(this).addClass("text-red");

    });

    var myvideo = document.getElementById('video_el');

    $('.jump_go').click(function() {
        event.preventDefault();
        myvideo.currentTime = $(this).attr("data-timego");
        myvideo.play();

    });
    
    $('.btn_start_quiz_video').click(function() {
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var q_id = idtemp[1];	

        $('.container_btn_view_quiz').hide();
        $('#container_quiz_video').load("./modal_window_quiz_play_test.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});

    });


    $('.btn_view_quiz_video').click(function() {
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var q_id = idtemp[1];	

        $('.container_btn_view_quiz').hide();
        $('#container_quiz_video').load("./modal_window_quiz.cfm?window_origin=div&quiz_id="+q_id+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {});

    });

});


// var myvideo = document.getElementById('video_el'),
// jumplink = document.getElementById('jump');

// jumplink.addEventListener("click", function (event) {
//     event.preventDefault();
//     myvideo.play();
//     myvideo.pause();
//     myvideo.currentTime = 7;
// }, false);

</script>