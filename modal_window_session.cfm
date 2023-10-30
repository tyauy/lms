<cfif isdefined("s_id") OR isdefined("sm_id")>

	<cfif isdefined("s_id")>
	<cfset get_session_description = obj_query.oget_session_description(s_id="#s_id#")>
	<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT tp_id FROM `lms_tpsession` WHERE `session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">  LIMIT 1
	</cfquery>
		<cfset t_id = get_tp.tp_id>
	<cfelseif isdefined("sm_id")>
	<cfset get_session_description = obj_query.oget_session_description(sm_id="#sm_id#")>
	</cfif>
		
	<cfoutput query="get_session_description">



		<cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>


			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
				<cfset poster_go = "../assets/img_material/#sessionmaster_code#.jpg">
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
				<cfset poster_go = "../assets/img_material/#sessionmaster_id#.jpg">
			<cfelse>
				<cfset poster_go = "../assets/img/wefit_lesson.jpg">
			</cfif>


			<table width="100%" align="center">					
				<tr>
					<td width="15%"></td>
					<td width="70%">
						<video id="video_el" controls controlsList="nodownload" width="100%" id="video_#sessionmaster_id#" poster="#poster_go#">
							<source src="#SESSION.BO_ROOT_URL#/assets/materials_video/#sessionmaster_ressource#.mp4" type="video/mp4">
				
							<cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.en-US.vtt")>
								<track 
								kind="subtitles" 
								src="#SESSION.BO_ROOT_URL#/assets/materials_video/#sessionmaster_ressource#.en-US.vtt" 
								srclang="en"
								label="Anglais">
							</cfif>
				
							</video>
					</td>
					<td width="15%"></td>
				</tr>
			</table>

		<cfelse>

			<table width="100%" align="center">					
				<tr>
					<td width="25%"></td>
					<td width="50%">
						#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#")#
					</td>
					<td width="25%"></td>
				</tr>
			</table>

		</cfif>


	


	<table class="table table-sm mt-1">					
		<tr>
			<th class="bg-light" width="25%"><label>#obj_translater.get_translate('table_th_course_title')#</label></th>
			<td>
				#sessionmaster_name#
			</td>
		</tr>
		<cfif sessionmaster_duration neq "">
		<tr>
			<th class="bg-light" width="25%">
				<label>#obj_translater.get_translate('table_th_estimated_time')#</label> 
			</th>
			<td>
				#obj_translater.get_translate('text_about')# #sessionmaster_duration# m
			</td>
		</tr>
		</cfif>
		
		
		
		
		<!---<tr>
			<th class="bg-light" width="20%">
				<label>Niveau</strong> 
			</th>
			<td>
				XX
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="20%">
				<label>Th&egrave;mes</strong> 
			</th>
			<td>
				XX
			</td>
		</tr>--->
		<cfif sessionmaster_description neq "">
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_course_description')#</label> 
			</th>
			<td>
				#sessionmaster_description#
			</td>
		</tr>
		</cfif>
		<cfif sessionmaster_objectives neq "">
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_course_objectives')#</label> 
			</th>
			<td>
				#sessionmaster_objectives#
			</td>
		</tr>
		</cfif>
		<cfif sessionmaster_grammar neq "">
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_course_grammar')#</label> 
			</th>
			<td>
				#sessionmaster_grammar#
			</td>
		</tr>
		</cfif>
		<cfif sessionmaster_vocabulary neq "">
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_course_vocabulary')#</label> 
			</th>
			<td>
				#sessionmaster_vocabulary#
			</td>
		</tr>
		</cfif>
		<cfif keyword_id neq "">
		<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
		SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
		</cfquery>
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_keywords')#</label> 
			</th>
			<td>
				<cfloop query="get_keyword"><span class="badge badge-info">#keyword_name#</span> </cfloop>
			</td>
		</tr>
		</cfif>

		<cfif grammar_id neq "">
		<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
		SELECT grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#)
		</cfquery>
		<tr>
			<th class="bg-light" width="20%">
				<label>#obj_translater.get_translate('table_th_grammar')#</label> 
			</th>
			<td>
				<cfloop query="get_grammar"><span class="badge badge-info">#grammar_name#</span> </cfloop>
			</td>
		</tr>
		</cfif>

	</table>
	<style>
@media only screen and (min-width : 768px) {
    .is-table-row {
        display: table;
    }
    .is-table-row [class*="col-"] {
        float: none;
        display: table-cell;
        vertical-align: top;
    }
}
</style>	
<div class="row">
	<div class="col-md-6 mt-4">
		<div class="border-top border-info p-2 h-100">
			<h6 class="text-info">#obj_translater.get_translate('modal_supports')#</h6>
			<cfset material_exists = 0>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
				<cfset material_exists = 1>
				<a href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
			</cfif>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
				<cfset material_exists = 1>
				<a href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_wsk')#</a><br>
			</cfif>	
			<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx")>
				<cfset material_exists = 1>
				<a href="./assets/materials/#sessionmaster_ressource#_WS.pptx" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
			</cfif>
			</cfif>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.ppt")>
				<cfset material_exists = 1>
				<a href="./assets/materials/#sessionmaster_ressource#_WS.ppt" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
			</cfif>

			<!--- CUSTOM PJ DISPLAY --->
			<cfif isDefined("t_id")>
				<cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	
				<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
					
				<cfif dirQuery.recordcount GT 0>
					<table class="table table-sm table-bordered" id="file_holder">

						<cfoutput>
						<cfloop query="dirQuery">
						<tr id="file_#dirQuery.currentRow#">
							<td colspan="2">
							<a href="./assets/lessons/#t_id#/#s_id#/#name#" target="_blank">
								<span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 40ch;">#name#</span>
							</a>
						</td>
						</tr>
							
						</cfloop>
						</cfoutput>

						<cfset material_exists = 1>
					</table>
				</cfif>

			</cfif>

			<cfif material_exists eq "0">
				<span class="text-info"><em><small>#obj_translater.get_translate('alert_no_support')#</small></em></span>
			</cfif>

		</div>
	</div>
	<div class="col-md-6 mt-4">
		<div class="border-top border-warning p-2 h-100">
			<h6 class="text-warning">#obj_translater.get_translate('modal_support_video')#</h6>
			<cfloop from="1" to="5" index="cor">
				<cfif FileExists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
					<cfset video = "1">
					<a href="./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4" class="text-warning" target="_blank"><i class="fas fa-video"></i> #obj_translater.get_translate('modal_link_video')# #cor#</a><br>
				</cfif>
			</cfloop>
			<cfif not isdefined("video")>
			<span class="text-warning"><em><small>#obj_translater.get_translate('alert_no_video')#</small></em></span>
			</cfif>
		</div>
	</div>
	<div class="col-md-6 mt-4">
		<div class="border-top border-success p-2 h-100">
			<h6 class="text-success">#obj_translater.get_translate('modal_support_quiz')#</h6>
			
			<cfif quiz_id neq "" AND quiz_id neq "0">
				<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
				SELECT * FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session_description.sessionmaster_id#">
				</cfquery>
				<table class="table table-borderless table-sm">
				<cfloop query="get_quiz">
					<tr>
						<td>
							<a href="##" class="text-success">#quiz_name#</a>
						</td>
						<td>
					<cfquery name="get_result_exercice" datasource="#SESSION.BDDSOURCE#">
					SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz.quiz_id#">
					</cfquery>
					<cfif get_result_exercice.recordcount eq "0">																			
						<a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-success" title="#obj_translater.get_translate('btn_go_test')#"><i class="fas fa-play"></i></a>
					<cfelse>
						<a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-success float-right btn_restart_quiz" title="#obj_translater.get_translate('btn_start_again')#"><i class="fas fa-sync-alt"></i></a>																
						<cfif get_result_exercice.recordcount neq "0" AND get_result_exercice.quiz_user_end neq "">
							<a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_exercice.quiz_user_id#" title="#obj_translater.get_translate('btn_results_test')#"><i class="fas fa-tasks"></i> </a>
						</cfif>																		
					</cfif>
						</td>
					</tr>
				</cfloop>
				</table>
			<cfelse>
			<span class="text-success"><em><small>#obj_translater.get_translate('alert_no_quiz')#</small></em></span>
			</cfif>
			
		</div>
	</div>
	<div class="col-md-6 mt-4">
		<div class="border-top border-danger p-2 h-100">
			<h6 class="text-danger">#obj_translater.get_translate('modal_support_audio')#</h6>
			<cfloop from="1" to="5" index="cor">
				<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
					<cfset audio = "1">
					<a href="./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" class="text-danger" target="_blank"><i class="fas fa-volume-up"></i> #obj_translater.get_translate('modal_link_audio')# #cor#</a><br>
				</cfif>
			</cfloop>
			<cfif not isdefined("audio")>
			<span class="text-danger"><em><small>#obj_translater.get_translate('alert_no_audio')#</small></em></span>
			</cfif>
		</div>
	</div>
</div>
<cfif voc_cat_id neq "">

<cfset lang_select = "en">
<cfset lang_translate = "fr">

<div class="row justify-content-center">
	<div class="col-md-6 mt-4">
		<div class="border-top border-primary p-2 h-100">
			<h6 class="text-primary">#obj_translater.get_translate('sidemenu_learner_vocab_list')#</h6>
			
			<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
			SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (#voc_cat_id#) ORDER BY voc_cat_name
			</cfquery>
				
			<cfloop query="get_category">
			<a class="text-primary btn_view_vocab" id="vocab_#voc_cat_id#" href="##">#voc_cat_name#</a><br>
			</cfloop>
			
		</div>
	</div>
</div>
</cfif>
</div>
		

	</cfoutput>
	
	
<script>
$(document).ready(function() {

	<cfoutput>
	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	
		if(confirm('#encodeForJavaScript(obj_translater.get_translate('js_restart_quiz_confirm'))#')){
			document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
		}
	})

	$('.btn_view_quiz').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#SESSION.USER_ID#", function() {});
	})

	$('.btn_view_vocab').click(function(event) {
		event.preventDefault();
		$('body').addClass('modal-open');		
		$('##window_item_lg').modal("hide");
		$('##modal_body_lg').empty();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var voc_cat_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('btn_el_vocab_list'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_vocab.cfm?voc_cat_id="+voc_cat_id, function() {});
	})



	$('##window_item_xl').on('hide.bs.modal', function () {
	$('body').removeClass('modal-open');
});

	

	</cfoutput>
	
})
	
</script>
</cfif>
