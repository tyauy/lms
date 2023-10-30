<cfsilent>

	<!------ INITIALIZE NEW QUIZ -------->
	<cfif isdefined("quiz_id") AND isdefined("new_quiz")>

		<cfif isdefined("del_quiz")>
			<cfset temp = obj_lms.remove_quiz_results(quiz_id="#quiz_id#",u_id="#SESSION.USER_ID#")>
		</cfif>
		
		<cfquery name="get_current" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		WHERE qc.qu_ranking = 1 AND qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>

		<cfquery name="quiz_ins" datasource="#SESSION.BDDSOURCE#" result="insert_quiz">
		INSERT INTO lms_quiz_user (
		user_id,
		quiz_id,
		quiz_user_start,
		current_qu_id,
		current_visited
		<cfif isdefined("tp_id")>
		, tp_id
		</cfif>
		<cfif isdefined("pt_type")>
		, pt_type
		</cfif>
		<cfif isdefined("pt_speed")>
		, pt_speed
		</cfif>
		<cfif isdefined("quiz_user_group_id")>
		, quiz_user_group_id
		</cfif>
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_current.qu_id#">,
		0
		<cfif isdefined("tp_id")>
		, <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
		</cfif>
		<cfif isdefined("pt_type")>
		, <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
		</cfif>
		<cfif isdefined("pt_speed")>
		, <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		<cfif isdefined("quiz_user_group_id")>
		, <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
		</cfif>
		)
		</cfquery>

		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(quiz_user_id) as id FROM lms_quiz_user
		</cfquery> --->

		<cfset quiz_user_id = insert_quiz.generatedkey>
		<cfset current_qu = insert_quiz.generatedkey>

		<cfif not isdefined("quiz_user_group_id")>
			<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_quiz_user SET quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
			</cfquery>

			<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
				SELECT quiz_formation_id FROM lms_quiz WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
			</cfquery>

			<!--- TODO mettre  quiz_formation_id,  --->
			<cfquery name="quiz_ins" datasource="#SESSION.BDDSOURCE#" result="insert_quiz">
				INSERT INTO lms_quiz_user_score (
				quiz_user_group_id,
				quiz_formation_id,
				user_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation.quiz_formation_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				)
			</cfquery>

			<cfif isdefined("tp_id") AND isdefined("pt_type")>
				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `lms_quiz_user_tp`(`tp_id`, `quiz_user_group_id`, `type`) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
						)
				</cfquery>
			</cfif>
			
		</cfif>

	</cfif>


	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_name, qu.current_qu_id, qu.current_visited, (SELECT COUNT(qu_id) AS lms_quiz_question FROM lms_quiz_cor WHERE quiz_id = q.quiz_id) as quiz_nbqu
	FROM lms_quiz_user qu 
	INNER JOIN lms_quiz q ON qu.quiz_id = q.quiz_id
	WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>

	<cfif get_quiz.recordcount eq "">
		<div class="alert alert-danger">Error in lodaing data</div>
	<cfelse>

		<!--- GET QUESTION INFO ---->
		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.*, qc.qu_ranking
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		WHERE qc.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.current_qu_id#">  AND qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.quiz_id#">
		</cfquery>
		
		<!--- UPDATE QUIZ  VISIT IF NEVER DISPLAYED---->
		<cfif get_quiz.current_visited eq "0">
		<cfquery name="updt_question" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_user qu SET current_visited = 1
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		</cfquery>
		<cfset first_visit = 1>
		</cfif>
		
		<cfif isdefined("f")>
		<cfset first_visit = 1>
		</cfif>	

		<!--- GET ANSWER INFO ---->
		<cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
		SELECT qa.*
		FROM lms_quiz_answer qa
		WHERE qa.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.current_qu_id#"> 
		ORDER BY qu_id, sub_id
		</cfquery>

		<cfset progress = (get_question.qu_ranking/get_quiz.quiz_nbqu)*100>
		
	</cfif>
	
</cfsilent>

			


<!-------- ADD A NO ANSWER ALERT ------------>
<!--- <div id="window_item" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal-title-sm" class="modal-title"><cfoutput>#obj_translater.get_translate('alert_warning')#</cfoutput></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal-body-sm" class="modal-body">
			<cfoutput>#obj_translater.get_translate('alert_no_answer')#</cfoutput>
			</div>
        </div>
    </div>
</div> --->
	


<div class="row">	
    <cfif get_question.qu_timer neq "">
    <div class="col-md-3">
    
        
        <div class="card border">
            <div class="card-body">
                <h6 class="border-bottom border-gray pb-2 mb-2"><cfoutput>#obj_translater.get_translate('card_quiz_timer')#</cfoutput> <cfif get_question.qu_timer eq "">(<cfoutput>#obj_translater.get_translate('desactivated')#</cfoutput>)</cfif></h6>
            
                <div id="countdown"><h5 class="float-left pt-1 pr-2"><span id="sec" class="badge badge-pill badge-primary bg-info"><cfoutput><cfif isdefined("ccd")>#ccd#<cfelse>#get_question.qu_timer#</cfif></cfoutput></span></h5></div>

                    
                <div class="mt-3">
                    <div class="progress">
                        <div id="p_bar" class="progress-bar progress-bar-striped progress-bar-animated bg-info" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                    </div>
                </div>
            </div>
        </div>
        
    
    </div>
    </cfif>
    
    <div class="col-md-9">

        <div class="card border">
            <div class="card-body">
            <form id="question" <!---action="quiz_work.cfm"---> method="post">
            <!---<cfif isdefined("quiz_user_id") AND not findnocase("quiz_eval.cfm", cgi.script_name)><a class="btn btn-sm btn-outline-info float-right mr-2" href="#" id="quiz_stop">Suspendre le test</a></cfif>--->

                <!---<h3><cfoutput>#get_quiz.quiz_name#</cfoutput></h3>

                <div class="progress">
                <cfoutput><div class="progress-bar progress-bar-striped active progress-bar-success" style="width: #progress#%"></div></cfoutput>
                </div>--->



                <!---------------- QUESTION ------------------->
                <cfoutput query="get_question">

                <h5 class="border-bottom border-gray pb-2 mb-3">
                <cfif qu_category eq "grammar" OR qu_category eq "Grammatik" OR qu_category eq "Grammaire">
                    <i class="fa-thin fa-marker"></i> 
                <cfelseif qu_category eq "reading" OR qu_category eq "Leseverstehen">
                    <i class="fa-thin fa-book-open"></i> 
                <cfelseif qu_category eq "listening" OR qu_category eq "Hörverstehen">
                    <i class="fa-thin fa-volume-up"></i> 
                <cfelseif qu_category eq "vocabulary" OR qu_category eq "Vokabular" OR qu_category eq "Vocabulaire" OR qu_category eq "Wortschatz">
                    <i class="fa-thin fa-book"></i> 
                <cfelseif qu_category eq "part 1">
                    [Part 1]
                <cfelseif qu_category eq "part 2">
                    [Part 2]
                <cfelseif qu_category eq "part 3">
                    [Part 3]
                <cfelseif qu_category eq "part 4">
                    [Part 4]
                <cfelseif qu_category eq "part 5">
                    [Part 5]
                <cfelseif qu_category eq "part 6">
                    [Part 6]
                <cfelseif qu_category eq "part 7">
                    [Part 7]
                </cfif>
                
                #obj_translater.get_translate('question')# #qu_ranking#/#get_quiz.quiz_nbqu# : #qu_title#
                </h5>

                <cfif material_id neq "">

                <cfloop list="#material_id#" index="cor">
                    <cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
                    SELECT ma.material_url, ma.material_type FROM lms_material ma WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> 
                    </cfquery>
                    
                    <cfif get_material.material_type eq "image">
                        <p>
                            <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#">
                        </p>
                    <cfelseif get_material.material_type eq "audio">
                        <p>
                        <audio controls="controls">
                            <source src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#" type="audio/mp3" />
                            Votre navigateur n'est pas compatible
                        </audio>
                        <small><a href="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#" target="_blank">
                            <cfoutput>#obj_translater.get_translate('quiz_audio_help')#</cfoutput>
                        </a></small>
                        </p>
                    <cfelse>
                    
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.jpg")>
                        <p>
                            <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.jpg">
                        </p>
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.png")>
                        <p>
                            <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.png">
                        </p>
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.mp3")>
                        <p>
                        <audio controls="controls">
                            <source src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.mp3" type="audio/mp3" />
                            Votre navigateur n'est pas compatible
                        </audio>
                        <small><a href="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.mp3" target="_blank">
                            <cfoutput>#obj_translater.get_translate('quiz_audio_help')#</cfoutput>
                        </a></small>
                        </p>
                        </cfif>
                    
                    </cfif>
                </cfloop>

                </cfif>

                

                <cfif qu_text neq "" OR qu_text_fr neq "" OR qu_text_en neq "" OR qu_text_de neq "" OR qu_text_es neq "" OR qu_text_it neq "">
                
                <div class="border border-dark p-3">
                    
                    <cfif SESSION.LANG_CODE eq "fr">
                        <cfif qu_text_fr neq "">#qu_text_fr#<cfelse>#qu_text#</cfif>								
                    <cfelseif SESSION.LANG_CODE eq "en">
                        <cfif qu_text_en neq "">#qu_text_en#<cfelse>#qu_text#</cfif>
                    <cfelseif SESSION.LANG_CODE eq "de">
                        <cfif qu_text_de neq "">#qu_text_de#<cfelse>#qu_text#</cfif>
                    <cfelseif SESSION.LANG_CODE eq "es">
                        <cfif qu_text_es neq "">#qu_text_es#<cfelse>#qu_text#</cfif>
                    <cfelseif SESSION.LANG_CODE eq "it">
                        <cfif qu_text_it neq "">#qu_text_it#<cfelse>#qu_text#</cfif>
                    <cfelse>
                        #qu_text#
                    </cfif>
                
                </div>
                
                </cfif>
                
                
                <cfif qu_header neq "">
                    <div class="alert alert-info mt-4 pt-3" role="alert" style="font-size:18px">					
                    #qu_header#
                    </div>
                </cfif>
                
                
                </cfoutput>
                
                
                
                <!---------------- ANSWER ------------------->

                <div class="mt-2">
                <cfif get_question.qu_type eq "radio" OR get_question.qu_type eq "checkbox" OR get_question.qu_type eq "text">
                <!---<h5 class="border-bottom border-gray pb-2 mb-3 mt-5"><cfoutput>#obj_translater.get_translate('answer')#</cfoutput></h5>--->
                
                    <!---- GROUP ANSWER ONLY FOR RADIO BTN ---->
                    <cfif get_question.qu_type eq "radio">
                        <cfif get_question.qu_advise neq "">
                            <cfoutput><small class="mt-2"><em>#get_question.qu_advise#</em></small><br></cfoutput>
                        </cfif>
                        <div class="btn-group-toggle" data-toggle="buttons">
                    <cfelseif get_question.qu_type eq "checkbox">
                        <cfif get_question.qu_advise neq "">
                            <cfoutput><small class="mt-2"><em>#get_question.qu_advise#</em></small><br></cfoutput>
                        </cfif>
                        <div class="btn-group-toggle" data-toggle="buttons">
                    <cfelseif get_question.qu_type eq "text">
                        <cfif get_question.qu_advise neq "">
                            <cfoutput><small class="mt-2"><em>#get_question.qu_advise#</em></small><br></cfoutput>
                        </cfif>
                    </cfif>
                    <br>
                    <cfoutput query="get_answer">
                    
                        <cfif ans_type eq "checkbox">
                        
                            <label class="btn btn-outline-info mr-2 font-weight-normal clearfix" style="text-transform:none !important; color:##51bcda; font-size:15px">
                            
                            <input type="checkbox" class="ans_id" name="ans_id" id="#ans_id#" value="#ans_id#">
                            
                            <cfif ans_text neq "">#ans_text#<cfelse>
                                <cfif SESSION.LANG_CODE eq "fr">
                                    <cfif ans_text_fr neq "">#ans_text_fr#<cfelse>#ans_text#</cfif>								
                                <cfelseif SESSION.LANG_CODE eq "en">
                                    <cfif ans_text_en neq "">#ans_text_en#<cfelse>#ans_text#</cfif>
                                <cfelseif SESSION.LANG_CODE eq "de">
                                    <cfif ans_text_de neq "">#ans_text_de#<cfelse>#ans_text#</cfif>
                                <cfelseif SESSION.LANG_CODE eq "es">
                                    <cfif ans_text_es neq "">#ans_text_es#<cfelse>#ans_text#</cfif>
                                <cfelseif SESSION.LANG_CODE eq "it">
                                    <cfif ans_text_it neq "">#ans_text_it#<cfelse>#ans_text#</cfif>
                                </cfif>
                            </cfif>
                            </label>
                            <br>
                            
                        <cfelseif ans_type eq "radio">
                            
                            <cfif material_id neq "">
                            
                                <input type="radio" class="ans_id mt-3 mr-2 float-left" name="ans_id" id="#ans_id#" value="#ans_id#">
                                
                                <cfloop list="#material_id#" index="cor">
                                    <cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
                                    SELECT ma.material_url, ma.material_type FROM lms_material ma WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> 
                                    </cfquery>
                                    <cfif get_material.material_type eq "image">
                                    <p>
                                        <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#">
                                    </p>
                                    <cfelseif get_material.material_type eq "audio">
                                    <p>
                                    <audio controls="controls">
                                        <source src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#" type="audio/mp3" />
                                        Votre navigateur n'est pas compatible
                                    </audio>
                                    </p>
                                    </cfif>
                                </cfloop>
                                
                                <label for="#ans_id#" style="font-size:14px">
                                <cfif ans_text neq "">#ans_text#<cfelse>
                                    <cfif SESSION.LANG_CODE eq "fr">
                                        <cfif ans_text_fr neq "">#ans_text_fr#<cfelse>#ans_text#</cfif>								
                                    <cfelseif SESSION.LANG_CODE eq "en">
                                        <cfif ans_text_en neq "">#ans_text_en#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "de">
                                        <cfif ans_text_de neq "">#ans_text_de#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "es">
                                        <cfif ans_text_es neq "">#ans_text_es#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "it">
                                        <cfif ans_text_it neq "">#ans_text_it#<cfelse>#ans_text#</cfif>
                                    </cfif>
                                </cfif>
                                </label>
                                
                            <cfelse>
                            
                                <label class="btn btn-outline-info mr-2 font-weight-normal btn-block mb-0" style="text-transform:none !important; color:##51bcda; font-size:15px">
                                
                                <input type="radio" class="ans_id" name="ans_id" id="#ans_id#" value="#ans_id#">
                                
                                <cfif ans_text neq "">#ans_text#<cfelse>
                                    <cfif SESSION.LANG_CODE eq "fr">
                                        <cfif ans_text_fr neq "">#ans_text_fr#<cfelse>#ans_text#</cfif>								
                                    <cfelseif SESSION.LANG_CODE eq "en">
                                        <cfif ans_text_en neq "">#ans_text_en#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "de">
                                        <cfif ans_text_de neq "">#ans_text_de#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "es">
                                        <cfif ans_text_es neq "">#ans_text_es#<cfelse>#ans_text#</cfif>
                                    <cfelseif SESSION.LANG_CODE eq "it">
                                        <cfif ans_text_it neq "">#ans_text_it#<cfelse>#ans_text#</cfif>
                                    </cfif>
                                </cfif>
                                
                                </label>
                            
                            </cfif>
                        
                            <!---<cfelseif ans_type eq "audio" AND material_url_ans neq "">
                            <audio controls="controls">
                                <source src="#material_url_ans#" type="audio/mp3" />
                                Votre navigateur n'est pas compatible
                            </audio>--->
                        
                        <cfelseif ans_type eq "text">
                            <div class="alert alert-info mt-4 pt-3" role="alert" style="font-size:18px">
                            Write the correct answer : <input type="text" class="ans_id" name="ans_id" id="#ans_id#" value="">
                            </div>
                        </cfif>
                        
                        
                    </cfoutput>
                    
                    <!---- GROUP ANSWER ONLY FOR RADIO BTN ---->
                    <cfif get_question.qu_type eq "radio">
                    </div>
                    <cfelseif get_question.qu_type eq "checkbox">
                    </div>
                    </cfif>
                    
                    <!---<cfelseif get_question.qu_type eq "text">

                    <h5 class="border-bottom border-gray pb-2 mb-3 mt-5"><cfoutput>#obj_translater.get_translate('answer')#</cfoutput></h5>
                    Write the correct answer : <input type="text" class="ans_id form-control" name="ans_id" id="#ans_id#" value="">--->

                <cfelseif get_question.qu_type eq "textarea">

                    <h5 class="border-bottom border-gray pb-2 mb-3 mt-4"><cfoutput>#obj_translater.get_translate('answer')#</cfoutput></h5>
                    <textarea class="ans_id form-control" name="ans_id"></textarea>

                </cfif>
                
                </div>

                <cfoutput>
                <input type="hidden" name="qu_type" value="#get_question.qu_type#">
                <input type="hidden" name="quiz_user_id" value="#quiz_user_id#">
                <input type="hidden" name="qu_id" value="#get_quiz.current_qu_id#">
                <input type="hidden" name="ins" value="1">
                <input type="hidden" name="act" id="act" value="go">
                </cfoutput>


                <div class="d-block text-center mt-3">
                <input type="submit" id="send_go" class="btn btn-info btn-lg" value="<cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput>">
                </div>
            
            </form>
            </div>
        </div>

    </div>
    
</div>

<script>
$(document).ready(function() {

	/*$('#send_go').prop( "disabled", false );
	$("#send_go").removeAttr("disabled");*/

$("#question").submit(function(event){
    event.preventDefault();
    $.ajax({				 
        url: './api/quiz/quiz_post.cfc?method=quiz_work',
        type: "POST",
        data:$(this).serialize(),
        datatype : "html",
        success : function(result, statut){
            console.log(result);

            
            var result = $.parseJSON(result);
            clearInterval(interval);
            // console.log(result["QUIZ_USER_ID"]);
            var quiz_user_id = result["QUIZ_USER_ID"];
            
            if(result.hasOwnProperty("end_quiz"))
            {

                $('#modal_body_xl').empty();
                $('#modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {});
            
            }
            else
            {
                
                $('#modal_body_xl').empty();
                $('#modal_body_xl').load("modal_window_quiz_play.cfm?quiz_user_id="+quiz_user_id, function() {});
            }

            
           
        }
    });
});





<!--- IF REFRESH > BOOT USER TO THE NEXT QUESTION ---->
<cfif not isdefined("first_visit")>
	$("#question").submit();
	$('#send_go').prop( "disabled", true );
</cfif>
	

var ok_submit = 0;

<cfif get_question.qu_timer neq "">
var counter = <cfoutput><cfif isdefined("ccd")>#ccd#<cfelse>#get_question.qu_timer#</cfif></cfoutput>;
var w_bar = 100;
var w_second = 100/counter;
var interval = setInterval(function() {
	counter--;	
	w_bar = w_bar-w_second;
	jQuery('#countdown #sec').html(counter);
	$("#p_bar").css("width",w_bar+"%")
	if (counter == 0) {
		clearInterval(interval);
		ok_submit = -1;
		$("#question").submit();
		$('#send_go').prop("disabled",true);
	}
}, 1000);
<cfelse>
    var interval = setInterval(function() {}, 1000);
</cfif>


jQuery.fn.preventDoubleSubmission = function() {
  $(this).on('submit',function(e){
    var $form = $(this);

	
	if($("#act").val() != "stop")
	{
		<cfif get_question.qu_type eq "radio" OR get_question.qu_type eq "checkbox">
		$(".ans_id").each(function(index){
		
			if($(this).prop("checked")==true)
			{
				ok_submit = 1;
				$('#send_go').prop("disabled",true);
				return false;
			}
			
		})
		

		if(ok_submit == "0")
		{
			// $('#window_item').modal({keyboard: true});

            alert("no anwser");
			return false;
		}
		</cfif>
	}


	if ($form.data('submitted') === true) {
		e.preventDefault();
	} else {
		$form.data('submitted', true);
		/*$('#send_go').prop( "disabled", true );*/
	}
  });
  return this;
};

$('#question').preventDoubleSubmission();



$(".ans_id").change(function(event){
	$('#send_go').prop("disabled",false);
	/*alert("change");*/
	
});


$("#quiz_stop").click(function(event) {
	event.preventDefault();
	$("#act").val("stop");
	$("#question").submit();
	$('#send_go').prop( "disabled", true );
});

<cfif get_question.qu_type eq "select">

	<cfoutput query="get_answer" group="sub_id">
		
		$("###qu_id#_#sub_id#").attr('name', 'ans_id');	
		$("###qu_id#_#sub_id#").addClass('form-control');
		$("###qu_id#_#sub_id#").append('<option value="0">-------------</option>')	
		<cfoutput>
		$("###qu_id#_#sub_id#").append('<option value="#ans_id#">#ans_text#</option>')
		</cfoutput>
		
	</cfoutput>

<cfelseif get_question.qu_type eq "text">	

	$("input[type=text]").attr('name', 'ans_id');	
	$("input[type=text]").addClass('form-control');
	$("input[type=text]").prop('required',true);
	$("input[type=text]").css('width',"150");
	$("input[type=text]").css('display',"inline");
	
</cfif>

});
</script>


	
	
</body>
</html>