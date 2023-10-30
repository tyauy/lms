<script>
tinymce.init({
	selector:'#lesson_pta_achievement,#lesson_feedback,#lesson_pta_initial',
	branding: false,
	contextmenu: "link image imagetools table spellchecker",
	contextmenu_never_use_native: true,
	draggable_modal: false,
	menubar: '',	
	toolbar: 'undo redo | bold italic underline numlist bullist link',
	plugins: "lists,link",
	browser_spellcheck: true,
	paste_data_images: false,
	invalid_elements : "img",
});
</script>

<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>

<cfset get_tp = obj_tp_get.oget_tp(t_id="#get_lessonnote.tp_id#")>

<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>



<cfset lesson_intro_text = #obj_translater.get_translate_complex('ln_pta_intro_text', formation_id)#>
<cfset lesson_footer_text = #obj_translater.get_translate_complex('ln_pta_footer_text', formation_id)#>
<!---COMPLEX
START_RM--->
<!--- <cfif formation_id eq "1"> --->
	<!--- <cfset lesson_intro_text = "Bonjour #get_lessonnote.user_firstname#, --->
<!--- vous &ecirc;tes arriv&eacute;(e) au terme de votre parcours de formation, et je souhaite vous f&eacute;liciter pour votre travail et vos efforts ! Pour bien pr&eacute;parer la suite, voici votre rapport de formation contenant les points-cl&eacute;s de votre apprentissage."> --->
	<!--- <cfset lesson_footer_text = "Merci d'avoir choisi WEFIT, n'h&eacute;sitez pas &agrave; revenir vers nous si vous voulez poursuivre l'aventure ! --->

<!--- L'&eacute;quipe WEFIT vous souhaite une bonne continuation ! --->
<!--- "> --->
<!--- <cfelseif formation_id eq "2"> --->
	<!--- <cfset lesson_intro_text = "Hello #get_lessonnote.user_firstname#, --->
<!--- you have reached the end of your Training Program and I would like to congratulate you for your work and effort! In order to move forward, let us look back a bit. Below is a report which will recount what transpired during your training."> --->
	<!--- <cfset lesson_footer_text = "Thank you for choosing WEFIT and for all your hard work. We hope that you enjoyed your training with us and that it met with your requirements. --->

<!--- Please do not hesitate to contact us if you need any further information. --->

<!--- Best Regards --->
<!--- "> --->
<!--- <cfelseif formation_id eq "3"> --->
	<!--- <cfset lesson_intro_text = "Hallo # get_lessonnote.user_firstname #, --->
<!--- Sie haben das Ende Ihres Trainingsprogramms erreicht und wir gratulieren Ihnen zu Ihrer Arbeit und Ihrem Einsatz! Im Folgenden finden Sie einen detailierten Trainingsbericht, in dem die behandelten Themen sowie Ihr Fortschritt zusammengefasst sind."> --->
	<!--- <cfset lesson_footer_text = "Vielen Dank, dass Sie sich für ein Training mit WEFIT entschieden haben. Wir hoffen, dass Ihnen Ihr Training gefallen hat und Ihre Erwartungen erfüllt wurden. --->

<!--- Bitte zögern Sie nicht, uns zu kontaktieren, wenn Sie weitere Informationen benötigen. --->

<!--- Freundliche Grüße --->
<!--- "> --->
<!--- <cfelseif formation_id eq "4"> --->
	<!--- <cfset lesson_intro_text = "Hello #get_lessonnote.user_firstname#, --->
<!--- you have reached the end of your Training Program and I would like to congratulate you for your work and effort! In order to move forward, let us look back a bit. Below is a report which will recount what transpired during your training."> --->
	<!--- <cfset lesson_footer_text = "Thank you for choosing WEFIT and for all your hard work. We hope that you enjoyed your training with us and that it met with your requirements. --->

<!--- Please do not hesitate to contact us if you need any further information. --->

<!--- Best Regards --->
<!--- "> --->
<!--- <cfelseif formation_id eq "5"> --->
	<!--- <cfset lesson_intro_text = "Hello #get_lessonnote.user_firstname#, --->
<!--- you have reached the end of your Training Program and I would like to congratulate you for your work and effort! In order to move forward, let us look back a bit. Below is a report which will recount what transpired during your training."> --->
	<!--- <cfset lesson_footer_text = "Thank you for choosing WEFIT and for all your hard work. We hope that you enjoyed your training with us and that it met with your requirements. --->

<!--- Please do not hesitate to contact us if you need any further information. --->

<!--- Best Regards --->
<!--- "> --->
<!--- </cfif> --->
<!---END_RM--->

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#lang_temp# as skill_objectives FROM lms_skill
</cfquery>



<cfif get_lessonnote.note_id neq "">

	<cfset u_id = get_lessonnote.user_id>
	<cfset lesson_intro = get_lessonnote.lesson_intro>
	
	<cfset na_skill_id = get_lessonnote.ln_skill_id>
	<cfset na_keyword_id = get_lessonnote.ln_keyword_id>
	<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
	<cfset lesson_feedback = get_lessonnote.lesson_feedback>
	
	<cfset lesson_pta_initial = get_lessonnote.lesson_pta_initial>
	<cfset lesson_pta_achievement = get_lessonnote.lesson_pta_achievement>
	
	<cfset lesson_formation = get_lessonnote.formation_name>	
	<cfset lesson_footer = get_lessonnote.lesson_footer>
	
	<cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
	SELECT e.eval_id, eq.equ_name_#lang_temp# as equ_name, eq.equ_group_#lang_temp# as equ_group, eq.equ_id, er.equ_result
	FROM lms_eval e
	INNER JOIN lms_eval_question eq ON eq.eval_id = e.eval_id
	LEFT JOIN lms_eval_result er ON er.equ_id = eq.equ_id
	WHERE e.eval_id = 1 AND (er.note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#"> OR er.note_id IS NULL)
	</cfquery>
	
<cfelse>

	<cfset u_id = get_lessonnote.user_id>
	<cfset lesson_intro = lesson_intro_text>
	
	<cfset na_skill_id = get_lessonnote.u_skill_id>
	<cfset na_keyword_id = get_lessonnote.u_keyword_id>
	
	<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
	<cfset lesson_feedback = "">
	
	<cfset lesson_pta_initial = "">
	<cfset lesson_pta_achievement = "">
	
	<cfset lesson_formation = get_lessonnote.formation_name>
	<cfset lesson_footer = lesson_footer_text>
	
	<cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
	SELECT e.eval_id, eq.equ_name_#lang_temp# as equ_name, eq.equ_group_#lang_temp# as equ_group, eq.equ_id
	FROM lms_eval e
	INNER JOIN lms_eval_question eq ON eq.eval_id = e.eval_id
	WHERE e.eval_id = 1
	</cfquery>
	
</cfif>

	<div class="row">
		<div class="col-md-12">
			<div class="p-1">
				<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="0" class="table-bordered">		
					
					<tr>
						<td rowspan="7" width="200" bgcolor="#FFF">
							<cfoutput>#obj_lms.get_thumb_session(get_lessonnote.sessionmaster_code,get_lessonnote.sessionmaster_id)#</cfoutput>
						</td>
					</tr>
					<tr>
						<td width="200" class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_course_title',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><strong><cfoutput>#get_lessonnote.sessionmaster_name#</cfoutput></strong></span>
						</td>
					</tr>	
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_trainer',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.planner_firstname#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_learner',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.user_firstname# #get_lessonnote.user_name#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_date',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#dateformat(get_lessonnote.lesson_start,'dd/mm/yyyy')#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_time',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</cfoutput></span>
						</td>
					</tr>							
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_duration_short',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.lesson_duration# m</cfoutput></span>
						</td>
					</tr>		
				</table>
			</div>
		</div>
	</div>
	
	<cfform action="updater_ln.cfm" method="post" id="form_ln">	
	<div class="row">
		<div class="col-md-12 mt-3">
			
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h2>	

			<div class="bg-light p-2 m-1 border">
			
				<h6>You wanted to learn <cfoutput>#lesson_formation#</cfoutput> because*</h6>
				<em><small><cfoutput>*At least one skill has to be checked</cfoutput></small></em>
			
				<div class="row mt-2">
						
					<div class="col-md-6">
					<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
					<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(na_skill_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>							
					</cfoutput>
					</div>
					
					<div class="col-md-6">
					<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
					<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(na_skill_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>				
					</cfoutput>
					</div>
					
				</div>
				
				<br>
				<div align="center" style="color:#FF0000;"><small><strong><cfoutput>#obj_translater.get_translate('ln_warning_image_disabled',formation_id)#</cfoutput></strong></small></div>
				<br>
				
				<h6>Initial needs / Areas of improvement*</h6>
				<em><small><cfoutput>*Mandatory</cfoutput></small></em>
				<p style="margin-top:10px">
				<textarea name="lesson_pta_initial" id="lesson_pta_initial" class="form-control" placeholder=""><cfoutput>#lesson_pta_initial#</cfoutput></textarea>
				</p>
				
			</div>
		
			<br>
			
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>PERFORMANCE DURING THE TRAINING*</cfoutput></h2>	



			<div class="m-1">
			
			<em>*Mandatory - 5: Excellent&nbsp;&nbsp;&nbsp;4: Very good&nbsp;&nbsp;&nbsp;3: Good&nbsp;&nbsp;&nbsp;2: Satisfactory&nbsp;&nbsp;&nbsp;1: Poor</em>
			
			<table class="table table-bordered">
			
				<cfoutput query="get_eval" group="equ_group">
								
				<tr class="bg-light">
					<td><strong>#equ_group#</strong></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">1</span></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">2</span></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">3</span></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">4</span></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">5</span></td>
					<td width="10" align="center"><span class="badge badge-pill badge-secondary">N/A</span></td>
				</tr>
				
				<cfoutput>
				
				<tr>
					<td>
						#equ_name#
					</td>
					<td width="10" bgcolor="##ff7c7c" align="center">
						<input type="radio" name="q_#equ_id#" value="1" <cfif isdefined("equ_result") AND equ_result eq "1">checked</cfif>>
					</td>
					<td width="10" bgcolor="##fbb962" align="center">
						<input type="radio" name="q_#equ_id#" value="2" <cfif isdefined("equ_result") AND equ_result eq "2">checked</cfif>>
					</td>
					<td width="10" bgcolor="##e7ef00" align="center">
						<input type="radio" name="q_#equ_id#" value="3" <cfif isdefined("equ_result") AND equ_result eq "3">checked</cfif>>
					</td>
					<td width="10" bgcolor="##c6e885" align="center">
						<input type="radio" name="q_#equ_id#" value="4" <cfif isdefined("equ_result") AND equ_result eq "4">checked</cfif>>
					</td>
					<td width="10" bgcolor="##49b734" align="center">
						<input type="radio" name="q_#equ_id#" value="5" <cfif isdefined("equ_result") AND equ_result eq "5">checked</cfif>>
					</td>
					<td width="10" bgcolor="##ECECEC" align="center">
						<input type="radio" name="q_#equ_id#" value="0" <cfif isdefined("equ_result") AND equ_result eq "0">checked</cfif>>
					</td>
				</tr>
				
				</cfoutput>
				
				</cfoutput>

			</table>

			</div>
			
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:25px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_achievement',formation_id)#</cfoutput></h2>	
			
			<div class="bg-light p-2 m-1 mt-3 border">
			
			
			<h6>You are now able to:*</h6>
			<em><small>*Mandatory</small></em>
			<div style="margin:5px 0px 10px 0px; border-top:1px solid ##000; width:100%"></div>
			<p style="margin-top:10px">
			<textarea name="lesson_pta_achievement" id="lesson_pta_achievement" class="form-control" placeholder="Some facts you learned today"><cfoutput>#lesson_pta_achievement#</cfoutput></textarea>
			</p>	
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback_tips',formation_id)#:</cfoutput>*</h6>
			<em><small>*Mandatory (<cfoutput>#obj_translater.get_translate('ln_title_min_char',formation_id)#</cfoutput>)</small></em>
			<textarea name="lesson_feedback" id="lesson_feedback" class="form-control" placeholder="Feedback trainer (min. 150 chr.)" style="border:1px solid #871E2C"><cfoutput>#lesson_feedback#</cfoutput></textarea>
			
			
	
		</div>
			

		
	</div>
	
</div>

		<cfoutput>
		<cfif get_lessonnote.note_id neq "">
		<input type="hidden" name="t_id" value="#get_lessonnote.tp_id#">
		<input type="hidden" name="updt_ln" value="1">
		<input type="hidden" name="l_id" value="#get_lessonnote.lesson_id#">
		<input type="hidden" name="note_id" value="#get_lessonnote.note_id#">
		<input type="hidden" name="lesson_intro" value="#lesson_intro#">
		<input type="hidden" name="lesson_footer" value="#lesson_footer#">
		<cfelse>
		<input type="hidden" name="t_id" value="#get_lessonnote.tp_id#">
		<input type="hidden" name="ins_ln" value="1">
		<input type="hidden" name="l_id" value="#get_lessonnote.lesson_id#">
		<input type="hidden" name="lesson_intro" value="#lesson_intro#">
		<input type="hidden" name="lesson_footer" value="#lesson_footer#">
		</cfif>
		</cfoutput>
		
		<div align="center">
		<br>
		<label><input type="checkbox" name="finalise_lesson" class="finalise_lesson" value="1"><cfoutput>#obj_translater.get_translate('modal_ln_finalize',formation_id)#</cfoutput></label>		
		</div>
		
		<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
		
		<script>
		$(document).ready(function() {	
			
			$("#form_ln").submit(function(event) {

				var eval_table = [];
					
				$.each($("input[name^='q_']:checked"), function(){
					eval_table.push($(this).val());					
				});	
				if(eval_table.length != "12")
				{
					alert("Please fill the performance table.");
					return false;
				}		
					
				if($(".finalise_lesson").is(':checked'))
				{
					var skill_id = [];
					$.each($("input[id='skill_id']:checked"), function(){
						skill_id.push($(this).val());					
					});	
					
					if(skill_id.length == "0")
					{
					alert("Please select at least one skill.")
					return false;			
					}
					
					var tofill = "Not enough characters for : ";
					var o = $("#lesson_feedback").val().length;
					var p = $("#lesson_pta_achievement").val().length;
					var q = $("#lesson_pta_initial").val().length;

					if(o<=150)
					{
						
						if(o<=150){
							tofill = tofill+"\n Feedback - "+o+ " characters (150 needed)";
						}
						alert(tofill);
						return false;
					}
					
					
				}
				
			});
			
		});
		</script>
		
</cfform>