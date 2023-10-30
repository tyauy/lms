<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <cfinclude template="./incl/incl_head.cfm">
</head>

    <cfsilent>

    <cfset secure = "2,5,6,4,12">
    <cfinclude template="./incl/incl_secure.cfm">

    <cfparam name="f_id" default="2">
    <cfparam name="lang_select" default="en">
    <cfparam name="url.quiz_id" default="0">
    <cfparam name="url.current_qu_id" default="0">




    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation
    </cfquery>
    
    <cfquery name="get_quiz_question" datasource="#SESSION.BDDSOURCE#">
        SELECT qq.qu_text,
            qq.qu_header,
            qq.qu_id,
            qa.ans_text,
            qqc.mapping_id,
            q.quiz_name,
            q.quiz_id
        FROM  lms_quiz_question qq
        LEFT JOIN lms_quiz_question_mapping_cor qqc on qqc.qu_id = qq.qu_id
        INNER JOIN lms_quiz_answer qa ON qq.qu_id = qa.qu_id AND qa.ans_iscorrect = 1
        INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
        INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
        WHERE qq.is_treated = 0 
        <cfif url.quiz_id neq 0>
        AND q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.quiz_id#">
        AND qq.qu_id <> <cfqueryparam cfsqltype="cf_sql_integer" value="#url.current_qu_id#">
        </cfif>
        AND q.quiz_id <> 3
        ORDER BY qu_id asc
        LIMIT 1
    </cfquery>
    
    

    <cfset qu_id = get_quiz_question.qu_id>
    
    <cfset m_id = "">
    <cfoutput query="get_quiz_question">
        <cfset m_id = listappend(m_id,mapping_id)>
    </cfoutput>
    <cftry>
        <cfif NOT isDefined("qu_id") OR NOT isNumeric(qu_id)>
            <cfthrow message="qu_id is not defined or not numeric. Value: #qu_id#">
        </cfif>
    
        <cfif get_quiz_question.recordCount eq 0>
            <cfthrow message="get_quiz_question returned no results.">
        </cfif>
        <cfquery name="updt_qq" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_quiz_question SET is_treated = 1 WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
        </cfquery>
        <cfcatch>
         <cfset logFile = ExpandPath("./api/mapping/qu_id_debug.log")>
            <cflog file="#logFile#" text="Error occurred: #cfcatch.message#. qu_id: #qu_id#">
        </cfcatch>
    </cftry>
    <cfset logFile = ExpandPath("./api/mapping/qu_id_debug.log")>

<cfif isdefined("quiz_id")>
	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
        SELECT q.*, sm.* FROM lms_quiz q
        INNER JOIN lms_tpsessionmaster2 sm ON q.sessionmaster_id = sm.sessionmaster_id 
	    INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
	    INNER JOIN lms_tpmaster2 tp ON tc.tpmaster_id = tp.tpmaster_id 
	    LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
        WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
        </cfquery>

</cfif>
<cfif isdefined("#get_quiz.sessionmaster_id#")>
	<cfquery name="get_sm_level" datasource="#SESSION.BDDSOURCE#">
        SELECT sm.*,l.level_alias FROM  lms_tpsessionmaster2 sm 
	    INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
	    INNER JOIN lms_tpmaster2 tp ON tc.tpmaster_id = tp.tpmaster_id 
        inner join lms_level l on l.level_id=sm.level_id
	    LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
        WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.sessionmaster_id#">
    </cfquery>
</cfif>
	
	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.sessionmaster_name, sm.sessionmaster_id, sm.level_id, q.quiz_id, q.quiz_type, q.quiz_name, tp.*, m.module_name, m.module_id 
	FROM lms_quiz q
	INNER JOIN lms_tpsessionmaster2 sm ON q.sessionmaster_id = sm.sessionmaster_id 
	INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
	INNER JOIN lms_tpmaster2 tp ON tc.tpmaster_id = tp.tpmaster_id 
	LEFT JOIN lms_tpmodulemaster2 m ON m.module_id = sm.module_id	
	WHERE tp.tpmaster_id <> 15 AND tp.tpmaster_prebuilt = 0
	ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_id, q.quiz_id
	</cfquery>

    	<cfquery name="get_other_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_name
	FROM lms_quiz q
	WHERE quiz_type <> "exercice" AND quiz_type <> "unit"
	ORDER BY quiz_type, quiz_name
	</cfquery>	

<cfquery name="get_total_questions" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(*) AS total_questions
    FROM lms_quiz_question
    WHERE is_treated IN (0, 2)
   
</cfquery>

<cfquery name="get_treated_questions" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(*) AS treated_questions
    FROM lms_quiz_question
    WHERE is_treated = 2
 
</cfquery>

<cfset percentage_treated = (get_treated_questions.treated_questions / get_total_questions.total_questions) * 100>


</cfsilent>   

<body>

<div class="wrapper">

    <cfinclude template="./incl/incl_sidebar.cfm">

    <div class="main-panel">
    
        <cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : #obj_translater.get_translate('title_page_common_materials')#">
        <cfinclude template="./incl/incl_nav.cfm">

            
        <div class="content">

            <div class="container">

                <cfif isdefined("k")>
                    <div class="alert alert-success">
                        Question correctly mapped ! Next one now...
                    </div>
                </cfif>

                <!--- <div class="row justify-content-end">

                    <div class="col-md-2">
                        
                        <select class="form-control" onChange="document.location.href='db_mapping_list.cfm?f_id='+$(this).val()">
                        <cfoutput query="get_formation">
                        <option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
                        </cfoutput>
                        <select>

                    </div>
                
                </div> --->

                <div class="row mt-2">
                 
                    <div class="col-md-12">
                        <cfif SESSION.PROFILE_ID NEQ 4>
                            <cfoutput>
                                Log file path: #logFile#
                            </cfoutput>
                            
                            <cfoutput>
                                <h6>Percentage of Questions Mapped</h6>
                                <div class="progress" style="margin-bottom: 20px;">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="#percentage_treated#" aria-valuemin="0" aria-valuemax="100" style="width: #percentage_treated#%;">#NumberFormat(percentage_treated, '9.99')#%</div>
                                </div>
                            </cfoutput>
                        </cfif>
                     
                        <div class="card">
                        
                            <div class="card-body">
                               
                                <div> 
                                 
                                    <select name="quiz_id" class="select_quiz form-control">
                                        <cfoutput query="get_session_access" group="tpmaster_level">
                                            <optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
                                                <cfoutput group="tpmaster_id">
                                                    <optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
                                                        <cfoutput group="module_id">
                                                            <optgroup label="------- #ucase(module_name)#">								
                                                                <cfoutput>
                                                                    <cfif quiz_id neq "">
                                                                        <option value="#get_session_access.quiz_id#" 
                                                                        <cfif url.quiz_id eq get_session_access.quiz_id>selected</cfif>
                                                                        >
                                                                        #get_session_access.quiz_id#- SM:#sessionmaster_id# - #sessionmaster_name# [#quiz_type#] || #quiz_name#
                                                                        </option>
                                                                        
                                                                    </cfif>					
                                                                </cfoutput>
                                                            </optgroup>
                                                        </cfoutput>
                                                    </optgroup>
                                                </cfoutput>
                                            </optgroup>
                                        </cfoutput>
                                    </select>
                                    
                                </div>
                                <div align="left">
                                    <strong>Material</strong> : <cfoutput>#get_quiz.sessionmaster_name#</cfoutput>
                                    <br>
                                    <strong>Level</strong>:
                                    <span id="quiz_level"><cfif isNull(get_sm_level.level_alias) or len(trim(get_sm_level.level_alias)) eq 0>
                                        N/A
                                    <cfelse>
                                        <cfoutput>#get_sm_level.level_alias#</cfoutput></span>
                                    </cfif>

                                    <br>
                                    <strong>Quiz name</strong> : <cfoutput>#get_quiz_question.quiz_name#</cfoutput>
                                    
                                    
                                </div>
                                

                                <cfoutput>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr>
                                            <th scope="col">Question ID</th>
                                            <th scope="col">Question Text</th>
                                            <th scope="col">Question Header</th>
                                            <th scope="col">Answer</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="quiz-question-id">#get_quiz_question.qu_id#</td>
                                        <td id="question_cell">#get_quiz_question.qu_text#</td>
                                        <td id="header_cell">#get_quiz_question.qu_header#</td>
                                        <td id="answer_cell">#get_quiz_question.ans_text#</td>
                                    </tr>
                                    </tbody>
                                </table>  
                                </cfoutput>
                                
                            </div>

                        </div>

                    </div>

                </div>

          
                <div>
                <form id="go_mapping">

                    <div class="mb-3 bg-light p-3 border rounded mt-3">

                        <input type="hidden" name="quiz_id" id="quiz_id" value="<cfoutput>#get_quiz_question.quiz_id#</cfoutput>">
                        <input type="hidden" name="qu_id" id="qu_id" value="<cfoutput>#qu_id#</cfoutput>">
                        
                        <div class="explanation-container">
                            <label for="qu_advise_en"><strong>Help from AI for Incorrect Answers Explanations <button type="button" id="btn_explanation_suggest" class="btn btn-sm btn-primary mt-2">Suggest explanation</button></strong></label>
                            <br>
                            <div id="explanation_suggest" >

<div class="spinner-border text-danger collapse" id="loader_explanation" role="status">
<span class="sr-only">Loading...</span>
</div>


                            </div>
                        </div>

                    </div>

                    <div class="mb-3 bg-light p-3 border rounded mt-3">

                        <div>
                            <strong>Help from AI for suggesting mapping points <button type="button" id="btn_mapping_suggest" class="btn btn-sm btn-primary mt-2">Suggest Mapping</button></strong>
                            <br>
                            
                            <div id="mapping_suggest" >

<div class="spinner-border text-danger collapse" id="loader_mapping" role="status">
<span class="sr-only">Loading...</span>
</div>


                            </div>
                        </div>
                    </div>



                    <h6>Explanation for Incorrect Answers</h6>
                    <textarea id="qu_advise_en" name="qu_advise_en" rows="4" class="form-control" placeholder="Click on suggest explanation for help ;)"></textarea>
                            

                    <h6>Mapping point</h6>  

                <!--- <ul class="nav nav-tabs" id="title_list" role="tablist">
                    <li class="nav-item">		
                        <a href="#mapping" class="nav-link active" role="tab" data-toggle="tab">
                        
                        </a>
                    </li> --->
                    <!--- <li class="nav-item">		
                        <a href="#interests" class="nav-link" role="tab" data-toggle="tab">
                        Interests
                        </a>
                    </li>
                    <li class="nav-item">		
                        <a href="#business" class="nav-link" role="tab" data-toggle="tab">
                        Business function
                        </a>
                    </li> --->
                <!--- </ul> --->

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active show" id="mapping" style="margin-top:15px;">
                        
                        <cfinclude template="./incl/incl_mapping_edit.cfm"> 

                    </div>

                    <!--- <div role="tabpanel" class="tab-pane" id="interests" style="margin-top:15px;">
                        interests
                    </div>

                    <div role="tabpanel" class="tab-pane" id="business" style="margin-top:15px;">
                        business
                    </div> --->
                </div>


                
                <div class="row justify-content-center">

                    <div class="col-md-3">
                        <cfoutput><input type="hidden" name="qu_id" value="#qu_id#"></cfoutput>
                       <cfoutput> <a href="db_mappingperquestion.cfm?quiz_id=#url.quiz_id#&current_qu_id=#get_quiz_question.qu_id#" class="btn btn-outline-red">SKIP</a></cfoutput>

                        <button class="btn btn-red">SAVE & CONTINUE</button>

                    </div>

                </div>


            </form></div>

            </div>

        </div>

    <cfinclude template="./incl/incl_footer.cfm">  

    </div>
    
</div>

<cfinclude template="./incl/incl_scripts.cfm">
<cfquery name="getLMSMappings" datasource="#SESSION.BDDSOURCE#">
    Select mapping_name_en, level 
    from lms_mapping
    where formation_id=2

    AND mapping_category != 'NA'
</cfquery>

<cfset lms_mappings_json = serializeJSON(getLMSMappings)>


<script>
	$(document).ready(function(){

        $('#btn_mapping_suggest').on('click', function() {
                    // Get the necessary inputs (question_cell, answer_cell, lms_mappings)
                    var question_cell = $('#question_cell').text() || $('#header_cell').text();  
                    var answer_cell = $('#answer_cell').text();  
                    var quiz_level = $('#quiz_level').text(); 
                    if (quiz_level.trim() === '') {
                    $('#quiz_level').text('N/A');
                };
                var lmsMappings = <cfoutput>#lms_mappings_json#</cfoutput>;

                $('#loader_mapping').collapse("show");

                $.ajax({
                    url: './api/mapping/mapping_get.cfc?method=getMappingSuggestion',
                    method: 'POST',
                    data: {
                        question_cell: question_cell,
                        answer_cell: answer_cell,
                        quiz_level: quiz_level,
                        lms_mappings: JSON.stringify(lmsMappings),
                    },
                success: function(response) {
                console.log('Mapping suggestion:', response);
                var suggestions = JSON.parse(response).suggestion;
                var suggestionList = suggestions.split('\n').filter(function(item) { return item; });
                var formattedSuggestions = suggestionList.map(function(item, index) {
                    return '<div>' + item + '</div>';
                }).join('');
                $('#mapping_suggest').html(formattedSuggestions);
                $('#loader_mapping').collapse("hide");
                


            },


                error: function(error) {
                    console.error('Error getting mapping suggestion:', error);
                }
            });

        });



        $('#btn_explanation_suggest').click(function() {
            // Get the question and answer text
            // Check if #answer_cell is empty, if it is then take the value of #header_cell
            var questionText = $('#question_cell').text() || $('#header_cell').text();  
            // Get answer
            var questionAnswer = $('#answer_cell').text();  
            console.log(questionText);
            console.log(questionAnswer);
            
            $('#loader_explanation').collapse("show");
            $.ajax({
                url : './api/mapping/mapping_get.cfc?method=send_go',
                method : 'POST',
                data: JSON.stringify({
                    'question_text': questionText,
                    'question_answer': questionAnswer
                }),
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                success : function(result) {
                    // Wrap the explanation text in <strong> tags to make it bold
                    $('#explanation_suggest').html(result.placeholder);
                    $('#loader_explanation').collapse("hide");

                },
                error: function(error) {
                    console.error('Error fetching placeholder:', error);
                }
            });
        });

    

    $(".select_quiz").change(function(){
        var selectedQuizId = $(this).val();
        window.location.href = "db_mappingperquestion.cfm?quiz_id=" + selectedQuizId;
    });
});

 // Show or hide the toggle switch based on the primary checkbox state.
 $('.mapping-checkbox').on('change', function() {
        var $toggleSwitchDiv = $(this).siblings('.custom-switch');
        var $toggleSwitch = $toggleSwitchDiv.find('.toggle-main-switch');
        if ($(this).prop('checked')) {
            $toggleSwitchDiv.removeClass('d-none').prop('disabled', false);
            $toggleSwitch.prop('disabled', false);
        } else {
            $toggleSwitchDiv.addClass('d-none').prop('disabled', true);
            $toggleSwitch.prop('checked', false).prop('disabled', true);
        }
    });

    $('#go_mapping').submit(function(event) {
    event.preventDefault();
    var quiz_id = $('#quiz_id').val();

    var formData = $(this).serializeArray(); // Gets form data as an array

        // Remove any existing 'qu_id' entries from formData
        formData = formData.filter(item => item.name !== 'qu_id');

        // Get the correct 'qu_id' value from the input field
        var qu_id = $('#qu_id').val();

        // Add the correct 'qu_id' entry into formData
        if(qu_id) {
            formData.push({name: 'qu_id', value: qu_id});
        } else {
            console.error('qu_id is not present or has an invalid value');
            return;
        }

        // Ensure mapping_id and qu_id are present in formData
        var hasMappingId = formData.some(item => item.name === 'mapping_id');
        var hasQuId = formData.some(item => item.name === 'qu_id');

        if (!hasMappingId || !hasQuId) {
            console.error('Required data not present in formData');
            return;
        }

            var mainMappingId = 0;

    $(".mapping-checkbox:checked").each(function() {
        if ($(this).siblings('.custom-switch').find('.toggle-main-switch').prop('checked')) {
            mainMappingId = $(this).val();
        }
    });

    // Add mainMappingId to the formData array
    formData.push({name: "main_mapping_id", value: mainMappingId});

    // Add adviceText to formData array
    var adviceText = $("#qu_advise_en").val();
    formData.push({name: "qu_advise", value: adviceText});

    console.log(formData);
    var nextqu = Number(qu_id) + 1;

    console.log("next question"+nextqu);
    $.ajax({
        url : './api/mapping/mapping_post.cfc?method=updt_mapping',
        method : 'POST',
        data: $.param(formData), // Convert array back to URL-encoded string
        success : function(result, status) {
            window.location.href="db_mappingperquestion.cfm?k=1&quiz_id="+quiz_id+"&current_qu_id="+nextqu;
        }
    });
});


</script>

</body>
</html>