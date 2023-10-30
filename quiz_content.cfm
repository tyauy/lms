<!DOCTYPE html>

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
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_current.qu_id#">,
		0
		)
		</cfquery>

		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(quiz_user_id) as id FROM lms_quiz_user
		</cfquery> --->

		<cfset quiz_user_id = insert_quiz.generatedkey>
		<cfset current_qu = insert_quiz.generatedkey>

	</cfif>


	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_name, qu.current_qu_id, qu.current_visited, (SELECT COUNT(qu_id) AS lms_quiz_question FROM lms_quiz_cor WHERE quiz_id = q.quiz_id) as quiz_nbqu
	FROM lms_quiz_user qu 
	INNER JOIN lms_quiz q ON qu.quiz_id = q.quiz_id
	WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> 
	AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>

	<cfif get_quiz.recordcount eq "">
		<cflocation addtoken="no" url="index.cfm">
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

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body style="margin:0px; padding:0px; border:0px">

<div class="content">
	
	<div class="row">	
		<cfif get_question.qu_timer neq "">
		<div class="col-md-3">
		
			
			<div class="card">
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

			<div class="card">
				<div class="card-body">
				<form id="question" action="quiz_work.cfm" method="post">
				<!---<cfif isdefined("quiz_user_id") AND not findnocase("quiz_eval.cfm", cgi.script_name)><a class="btn btn-sm btn-outline-info float-right mr-2" href="#" id="quiz_stop">Suspendre le test</a></cfif>--->

					<!---<h3><cfoutput>#get_quiz.quiz_name#</cfoutput></h3>

					<div class="progress">
					<cfoutput><div class="progress-bar progress-bar-striped active progress-bar-success" style="width: #progress#%"></div></cfoutput>
					</div>--->



					<!---------------- QUESTION ------------------->
					<cfoutput query="get_question">

					<h5 class="border-bottom border-gray pb-2 mb-3">
					<cfif qu_category eq "grammar" OR qu_category eq "Grammatik" OR qu_category eq "Grammaire">
						<i class="fad fa-marker"></i> 
					<cfelseif qu_category eq "reading" OR qu_category eq "Leseverstehen">
						<i class="fad fa-book-open"></i> 
					<cfelseif qu_category eq "listening" OR qu_category eq "Hörverstehen">
						<i class="fad fa-volume-up"></i> 
					<cfelseif qu_category eq "vocabulary" OR qu_category eq "Vokabular" OR qu_category eq "Vocabulaire" OR qu_category eq "Wortschatz">
						<i class="fad fa-book"></i> 
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
					
					#obj_translater.get_translate('question')# #qu_ranking# : #qu_title#
					</h5>

					<cfif material_id neq "">

					<cfloop list="#material_id#" index="cor">
						<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
						SELECT ma.material_url, ma.material_type FROM lms_material ma WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> 
						</cfquery>
						
						<cfif get_material.material_type eq "image">
							<p>
								<img src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#">
							</p>
						<cfelseif get_material.material_type eq "audio">
							<p>
							<audio controls="controls">
							  <source src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#" type="audio/mp3" />
							  Votre navigateur n'est pas compatible
							</audio>
							</p>
						<cfelse>
						
							<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.jpg")>
							<p>
								<img src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#.jpg">
							</p>
							<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.png")>
							<p>
								<img src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#.png">
							</p>
							<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.mp3")>
							<p>
							<audio controls="controls">
							  <source src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#.mp3" type="audio/mp3" />
							  Votre navigateur n'est pas compatible
							</audio>
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
											<img src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#">
										</p>
										<cfelseif get_material.material_type eq "audio">
										<p>
										<audio controls="controls">
										  <source src="http://lms.wefitgroup.com/assets/materials/#get_material.material_url#" type="audio/mp3" />
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
								
									<label class="btn btn-outline-info mr-2 font-weight-normal" style="text-transform:none !important; color:##51bcda; font-size:15px">
									
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
									<br>
								
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
		
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script>
$(document).ready(function() {

	/*$('#send_go').prop( "disabled", false );
	$("#send_go").removeAttr("disabled");*/


<!--- IF REFRESH > BOOT USER TO THE NEXT QUESTION ---->
<cfif not isdefined("first_visit")>
	$("#question").submit();
	$('#send_go').prop( "disabled", true );
</cfif>
	

var ok_submit = 0;

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
			$('#window_item').modal({keyboard: true});
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


<!-------- MODAL SKELETON ------------>
<div id="window_item" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal-title-sm" class="modal-title"><cfoutput>#obj_translater_alert.get_translate('alert_warning')#</cfoutput></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal-body-sm" class="modal-body">
			<cfoutput>#obj_translater_alert.get_translate('alert_no_answer')#</cfoutput>
			</div>
        </div>
    </div>
</div>
	
	
	
</body>
</html>