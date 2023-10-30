<script>
tinymce.init({
	selector:'#lesson_open_main,#lesson_feedback,#lesson_grammar,#lesson_vocabulary',
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
	/*toolbar: 'undo redo | bold italic underline numlist bullist link | paste',
	paste_word_valid_elements: "b,strong,i,em,h1,h2",
	plugins: "lists,link,paste",
	remove_linebreaks : false*/
});
</script>


<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>

<cfset u_id = get_lessonnote.user_id>

<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfif isdefined("SESSION.LANG_CODE") AND isdefined("SESSION.LANG")><cfset lang_temp = SESSION.LANG_CODE><cfset formation_id = SESSION.LANG><cfelse><cfset lang_temp = "en"><cfset formation_id = 2></cfif></cfdefaultcase>
</cfswitch>


<!--- <cfset placeholder_open_main = #obj_translater.get_translate_complex('ln_placeholder_open_main',formation_id)#> --->
<cfset lesson_intro_text = #obj_translater.get_translate_complex('ln_lesson_intro_text',formation_id)#>
<cfset lesson_footer_text = #obj_translater.get_translate_complex('ln_lesson_footer_text',formation_id)#>



<cfif get_lessonnote.note_id neq "">

	<cfset lesson_intro = get_lessonnote.lesson_intro>
	
	<cfset sm_description = get_lessonnote.sessionmaster_description>
	<cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
	<cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
	<cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>
	
	<cfset lesson_open_main = get_lessonnote.lesson_open_main>	
	<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
	<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
	
	<cfset lesson_grammar = get_lessonnote.lesson_grammar>
	<cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>	
	<cfset lesson_add_misc = get_lessonnote.lesson_add_misc>	
	<cfset lesson_feedback = get_lessonnote.lesson_feedback>
	
	<cfset lesson_formation = get_lessonnote.formation_name>
	<cfset lesson_footer = get_lessonnote.lesson_footer>
	
<cfelse>

	<cfset lesson_intro = lesson_intro_text>

	<cfset sm_description = get_lessonnote.sessionmaster_description>
	<cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
	<cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
	<cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>

	<cfset lesson_open_main = "">
	<cfset lesson_grammar_id = get_lessonnote.sm_grammar_id>	
	<cfset lesson_skill_id = "">
	
	<cfif get_lessonnote.sm_skill_id neq "">
		<cfif get_lessonnote.sessionmaster_ln_grammar neq "">
		<cfset lesson_skill_id = listappend(lesson_skill_id,"5")>
		</cfif>
		<cfif get_lessonnote.sessionmaster_ln_vocabulary neq "">
		<cfset lesson_skill_id = listappend(lesson_skill_id,"6")>
		</cfif>
	</cfif>
	
	<cfif lesson_skill_id neq "" AND get_lessonnote.s_skill_id neq "">
		<cfset lesson_skill_id = lesson_skill_id & "," & get_lessonnote.s_skill_id>
	<cfelseif get_lessonnote.s_skill_id neq "">
		<cfset lesson_skill_id = get_lessonnote.s_skill_id>
	</cfif>
	
	<cfset lesson_grammar = get_lessonnote.sessionmaster_ln_grammar>
	<cfset lesson_vocabulary = get_lessonnote.sessionmaster_ln_vocabulary>	
	<cfset lesson_add_misc = "">
	<cfset lesson_feedback = "">
	
	<cfset lesson_formation = get_lessonnote.formation_name>
	<cfset lesson_footer = lesson_footer_text>
	
</cfif>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_name_#lang_temp# as skill_name FROM lms_skill
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #formation_id# ORDER BY grammar_cat_name
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #formation_id#
</cfquery>


	
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
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_description',formation_id)#</cfoutput> <cfoutput>(#obj_translater.get_translate('ln_title_automatic',formation_id)#)</cfoutput></h2>	
			
			<div class="bg-light p-2 m-1 border">
			<cfif sm_description neq "">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_main_description',formation_id)#</cfoutput></h6>		
			<p style="margin-top:10px"><cfoutput>#sm_description#</cfoutput></p>
			</cfif>
			<cfif sm_objectives neq "">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_objectives',formation_id)#</cfoutput></h6>									
			<p style="margin-top:10px"><cfoutput>#sm_objectives#</cfoutput></p>
			</cfif>
			<cfif sm_grammar neq "">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_grammar',formation_id)#</cfoutput></h6>									
			<p style="margin-top:10px"><cfoutput>#sm_grammar#</cfoutput></p>
			</cfif>
			<cfif sm_vocabulary neq "">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></h6>									
			<p style="margin-top:10px"><cfoutput>#sm_vocabulary#</cfoutput></p>
			</cfif>
			</div>
			
			<br>
			
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_today_teaching_points',formation_id)#</cfoutput></h2>	
			
			
			<!--- HERE BE LEVEL ADJUSTEMENT --->
			<cfif SESSION.USER_ID eq 202>
			<!--- <cfif get_lessonnote.tpmaster_type eq 6> --->
				<cfset _skill_id = lesson_skill_id>
				<cfif _skill_id neq "">
					<cfset show_desc = 1>
					<cfinclude template="./widget/wid_level_list.cfm">
				</cfif>
			<!--- </cfif> --->
			</cfif>


			<br>
			<div align="center" style="color:#FF0000;"><small><strong><cfoutput>#obj_translater.get_translate('ln_warning_image_disabled',formation_id)#</cfoutput></strong></small></div>

			<cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "769" OR get_lessonnote.sessionmaster_id eq "1181" OR get_lessonnote.sessionmaster_id eq "1183">
			<!--- OPEN OR TEST--->
			<div class="bg-light p-2 m-1 mt-3 border">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_main_discussion',formation_id)#</cfoutput>*</h6>
			<!--- <em><small><cfoutput>#obj_translater.get_translate('ln_placeholder_open_main',formation_id)#</cfoutput></small></em> --->
			<p style="margin-top:10px">
			<textarea name="lesson_open_main" id="lesson_open_main" class="form-control"><cfoutput>#lesson_open_main#</cfoutput></textarea>
			</p>
			</div>
			
			<cfelseif get_lessonnote.sessionmaster_id eq "697">
			<!--- WORKSHOP --->
			<div class="bg-light p-2 m-1 mt-3 border">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_did_work_on',formation_id)#</cfoutput>*</h6>
			<em><small><cfoutput>#obj_translater.get_translate_complex('ln_placeholder_open_main',formation_id)#</cfoutput></small></em>
			<p style="margin-top:10px">
			<textarea name="lesson_open_main" id="lesson_open_main" class="form-control"><cfoutput>#lesson_open_main#</cfoutput></textarea>
			</p>
			</div>
			
			<cfelse>									
			<!--- STRUCTURAL --->
			
			</cfif>
				
			<div class="bg-light p-2 m-1 mt-3 border">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_today_work_on',formation_id)#</cfoutput></h6>
			<div class="row">
				

				
				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
				<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(lesson_skill_id,skill_id)>checked</cfif>> #skill_name#</label><br>							
				</cfoutput>
				</div>
				
				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
				<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(lesson_skill_id,skill_id)>checked</cfif>> #skill_name#</label><br>				
				</cfoutput>
				</div>
				
			</div>
				
			<textarea name="lesson_add_misc" id="lesson_add_misc" class="form-control" placeholder="<cfoutput>#obj_translater.get_translate('ln_title_today_work_on_placeholder',formation_id)#</cfoutput>"><cfoutput>#lesson_add_misc#</cfoutput></textarea>
			
			</div>
			
			
			<div id="grammar_block" <cfif not listfind(lesson_skill_id,"5")>style="display: none"</cfif>>
			<div class="bg-light p-2 m-1 mt-3 border">
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_grammar_covered',formation_id)#</cfoutput></h6>
			<em><small>(<cfoutput>#obj_translater.get_translate('ln_title_sort_by_level',formation_id)#</cfoutput>)</small></em>
			
				<ul class="nav nav-tabs" id="grammar_list" role="tablist">
					<cfset counter = 0>
					<cfoutput query="get_grammar_level">
					<cfset counter ++>
					<li class="nav-item">		
					<a href="##g_#counter#" class="nav-link <cfif counter eq "1">active</cfif>" role="tab" data-toggle="tab">
					#grammar_level#
					</a>
					</li>
					</cfoutput>
				</ul>

				<div class="tab-content">
					
					<cfset counter = 0>
					<cfloop query="get_grammar_level">
					<cfset counter ++>
					
					<div role="tabpanel" class="tab-pane <cfif counter eq "1">active show</cfif>" id="g_<cfoutput>#counter#</cfoutput>" style="margin-top:15px;">
						
						<div class="row">
						
							<div class="col-md-12">
							
							<cfloop query="get_grammar_cat">
							
							<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
							SELECT * FROM lms_grammar WHERE grammar_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_grammar_cat.grammar_cat_id#"> AND grammar_level = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_grammar_level.grammar_level#"> ORDER BY grammar_name
							</cfquery>
						
							<cfif get_grammar.recordcount neq "0">
							<cfset display_point = "0">
							<div class="row mt-2">
								<div class="col-md-12">
									<cfoutput><a data-toggle="collapse" href="##gram_cat_#grammar_cat_id#_#get_grammar_level.grammar_level#" role="button" aria-expanded="false" aria-controls="gram_cat_#grammar_cat_id#_#get_grammar_level.grammar_level#"><i class="fas fa-plus-square"></i> <strong>#get_grammar_cat.grammar_cat_name#</strong></a></cfoutput>
								</div>
							</div>											
							
							<cfoutput query="get_grammar">
							<cfif listfind(lesson_grammar_id,grammar_id)><cfset display_point = "1"></cfif>	
							</cfoutput>
								
							<cfoutput><div class="collapse <cfif display_point eq "1">show</cfif>" id="gram_cat_#grammar_cat_id#_#get_grammar_level.grammar_level#"></cfoutput>
								<div class="row">
								<cfoutput query="get_grammar">
								<div class="col-md-4">
								<label><input type="checkbox" name="grammar_id" id="grammar_id" value="#grammar_id#" <cfif listfind(lesson_grammar_id,grammar_id)>checked</cfif>> #grammar_name#</label><br>							
								</div>
								</cfoutput>
								</div>
							</div>
							</cfif>
							
							</cfloop>
							
							</div>
							
						</div>
						
					</div>
					</cfloop>
					
				</div>
			
			
			
			<p style="margin-top:30px">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_grammar_explanation',formation_id)#</cfoutput></h6>
			<textarea name="lesson_grammar" id="lesson_grammar" class="form-control" placeholder="Grammar covered that is not specified above" ><cfoutput>#lesson_grammar#</cfoutput></textarea>
			</p>
			
			</div>
			</div>

			<div id="vocabulary_block" <cfif not listfind(lesson_skill_id,"6")>style="display: none"</cfif>>
			<div class="bg-light p-2 m-1 mt-3 border">
			<h6><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></h6>
			<textarea name="lesson_vocabulary" id="lesson_vocabulary" class="form-control" placeholder="Specify the vocabulary covered, if applicable"><cfoutput>#lesson_vocabulary#</cfoutput></textarea>	
			</div>
			</div>
			
			<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:25px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback',formation_id)#</cfoutput></h2>	
			
			<div class="bg-light p-2 m-1 mt-3 border">
			<em><small>(<cfoutput>#obj_translater.get_translate('ln_title_min_char',formation_id)#</cfoutput>)</small></em>
			<textarea name="lesson_feedback" id="lesson_feedback" class="form-control" placeholder="Feedback trainer (min. 150 chr.)" style="border:1px solid #871E2C"><cfoutput>#lesson_feedback#</cfoutput></textarea>
			</div>
			
		</div>
		
	</div>

	<cfoutput>							
	<cfif get_lessonnote.note_id neq "">
		<input type="hidden" name="updt_ln" value="1">
		<input type="hidden" name="l_id" value="#get_lessonnote.lesson_id#">
		<input type="hidden" name="note_id" value="#get_lessonnote.note_id#">								
		<input type="hidden" name="lesson_intro" value="#lesson_intro#">
		<input type="hidden" name="lesson_footer" value="#lesson_footer#">
	<cfelse>
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
	
	
	</cfform>






<script>
$(document).ready(function() {

	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
	$( ".level_select").change(function(event) {

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");

		console.log(idtemp)
		$.ajax({
			url : './api/users/user_post.cfc?method=up_user_level_ln',
			type : 'POST',
			data : {
				user_id: <cfoutput>#u_id#</cfoutput>,
				formation_id: <cfoutput>#formation_id#</cfoutput>,
				skill_id: idtemp[1],
				level_sub_id: idtemp[2]
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
	});
	</cfif>

	$(".skill_id").click(function() {
		var skill_id = [];
		$.each($("input[id='skill_id']:checked"), function(){
			skill_id.push($(this).val());
		});	
		var test_grammar = $.inArray("5",skill_id);
		var test_vocabulary = $.inArray("6",skill_id);
		if(test_grammar > -1 ){$("#grammar_block").show("fast");}else{$("#grammar_block").hide("fast");}
		if(test_vocabulary > -1 ){$("#vocabulary_block").show("fast");}else{$("#vocabulary_block").hide("fast");}

	});
	
	$("#form_ln").submit(function(event) {

		if($(".finalise_lesson").is(':checked'))
		{
			var tofill = "Not enough characters for : ";
			var o = $("#lesson_feedback").val().length;
			
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


