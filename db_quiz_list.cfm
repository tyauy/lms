<!DOCTYPE html>

<cfsilent>

<cfif isdefined("quiz_id") AND isdefined("quiz_erase")>
<cfset temp = obj_lms.remove_quiz_global(quiz_id="#quiz_id#")>
</cfif>
	
	
	<cfif isdefined("quiz_id")>
	
	<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
	SELECT qq.qu_id, qq.qu_text, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.qu_timer, qq.qu_type, qq.qu_header, qcat.category_#SESSION.LANG_CODE# as category_name
	FROM lms_quiz_question qq
	INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
	LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
	INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
	WHERE q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	ORDER BY qc.qu_ranking ASC
	</cfquery>
	
	</cfif>
	
	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.sessionmaster_name, sm.sessionmaster_id, q.quiz_id, q.quiz_type, q.quiz_name, tp.*, m.module_name, m.module_id 
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
	
		
		
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Quiz list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
				<div class="row">
					
					<div class="col-lg-10 offset-lg-1 col-md-12">
						
						<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title d-inline">Quiz</h5>
								
								<a href="#" class="btn btn-info pull-right btn_create_quiz">ADD QUIZ</a>
								
								<br><br>
								<select name="quiz_id" class="select_quiz form-control">
								<!---<cfoutput query="get_quiz">
								<option value="#quiz_id#" <cfif isdefined("url.quiz_id") AND url.quiz_id eq get_quiz.quiz_id>selected</cfif>>
								<cfif module_name neq "">[#module_name#]</cfif> #quiz_name#
								</option>
								</cfoutput>--->
								
								
								<cfoutput query="get_session_access" group="tpmaster_level">
								<optgroup label="[ #obj_translater.get_translate('level')# #tpmaster_level# ]">
								<cfoutput group="tpmaster_id">
								<optgroup label="--- [ #tpmaster_level# ] #tpmaster_name#">
								<cfoutput group="module_id">
								<optgroup label="------- #ucase(module_name)#">								
								
								<cfoutput>
								<cfif quiz_id neq ""><option value="#quiz_id#" <cfif isdefined("url.quiz_id") AND url.quiz_id eq quiz_id>selected</cfif>>#sessionmaster_id# - #sessionmaster_name# [#quiz_type#] || #quiz_name#</option></cfif>					
								</cfoutput>
								
								</optgroup>
								</cfoutput>
								
								</optgroup>
								</cfoutput>
								
								</optgroup>
								</cfoutput>
								
								</select>
								
								<br>
								<br>
								
								<select name="quiz_id" class="select_quiz_other form-control">

								<cfoutput query="get_other_quiz">
								<option value="#quiz_id#" <cfif isdefined("url.quiz_id") AND url.quiz_id eq quiz_id>selected</cfif>>#quiz_name# [#quiz_type#]</option>		
								</cfoutput>

								</select>
								
							</div>
							
						
						</div>
						
						
						
						
						
						
						<cfif isdefined("quiz_id")>
						
						<div class="card border-top border-info">
						
							<div class="card-body">
						
								<h5 class="card-title">D&eacute;tails question</h5>
								<cfoutput>
								<a onclick="if(confirm('sur sur ?')){document.location.href='db_quiz_list.cfm?quiz_id=#quiz_id#&quiz_erase=1';}" href="##" class="btn btn-outline-info float-right"><i class="fas fa-times"></i> Suppr</a>
								<a href="db_quiz_edit.cfm?quiz_id=#quiz_id#" class="btn btn-outline-info float-right"><i class="fas fa-edit"></i> Edit Quiz</a>
								</cfoutput>
								<br><br>	
								<table class="table table-sm">
									<tr bgcolor="#F3F3F3">
										<!---<th>
										ID
										</th>--->
										<th>
										ID
										</th>
										<th>
										Comp&eacute;tence
										</th>
										<th>
										N&deg;
										</th>
										<th>
										Question
										</th>
										<th width="40%">
										Analyse r&eacute;ponse
										</th>
										<th width="5%">
										Action
										</th>
									</tr>
									<cfset counter = 0>
									<cfloop query="get_question">
									<cfset counter ++>
									<cfif counter/2 eq round(counter/2)><cfset color_tr = "F2F2F2"><cfelse><cfset color_tr = "FFFFFF"></cfif>
									
									<tr bgcolor="<cfoutput>###color_tr#</cfoutput>">
										<cfoutput>
										<td>#get_question.qu_id#</td>
										<td>#get_question.category_name#</td>
										<td>#get_question.qu_ranking#</td>
										<td>
										<strong>#get_question.qu_timer# sec | <span class="badge <cfif get_question.qu_type eq "radio">badge-primary<cfelseif get_question.qu_type eq "checkbox">badge-success<cfelseif get_question.qu_type eq "text">badge-info</cfif>">#get_question.qu_type#</span></strong>
										<cfif get_question.qu_text neq "">
										<div class="border p-2">#get_question.qu_text#</div>
										<br>
										</cfif>
										<cfif get_question.qu_header neq "">
										#get_question.qu_header#
										</cfif> 
										</td>
										</cfoutput>
										
										<td>
										<cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
										SELECT COUNT(DISTINCT(sub_id)) as nbsub
										FROM lms_quiz_answer
										WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
										</cfquery>
										
											<table class="table table-bordered table-sm">
											<cfloop from="1" to="#get_sub.nbsub#" index="sub_id">	
												<tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
												
													<cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
													SELECT ans_id, ans_text, sub_id, ans_iscorrect, ans_type, ans_gain
													FROM lms_quiz_answer
													WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
													</cfquery>
													
													<td width="50%">
													<!---<span class="label label-success">R&eacute;ponse(s) possibles</span><br>--->

													<cfoutput query="get_answer">
														<cfif ans_iscorrect eq "1">
															<strong><span class="badge <cfif ans_type eq "radio">badge-primary<cfelseif ans_type eq "checkbox">badge-success<cfelseif ans_type eq "text">badge-info</cfif>">#ans_type#</span></strong> - <i class="fas fa-check" style="color:##1eff00"></i> #ans_text# - +#ans_gain# - #ans_id#<br>
														<cfelse>
														<strong><span class="badge <cfif ans_type eq "radio">badge-primary<cfelseif ans_type eq "checkbox">badge-success<cfelseif ans_type eq "text">badge-info</cfif>">#ans_type#</span></strong> - <i class="fas fa-times" style="color:##ea1000"></i> #ans_text#<br>
														</cfif>
													</cfoutput>
													</td>
													
						

												</tr>
											
											</cfloop>	
											</table>
										
										</td>
										<td>
										<cfoutput><a href="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#get_question.qu_id#" class="btn btn-sm btn-outline-info float-right"><i class="fas fa-edit"></i> Edit Qu</a></cfoutput>
										</td>
									</tr>
									</cfloop>
								</table>
								
							</div>		
						</div>
						</cfif>
					</div>
				</div>
				
			</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$( document ).ready(function() {
	$('.select_quiz').change(function(event) {		
		document.location.href="db_quiz_list.cfm?quiz_id="+$(this).val();	
	});
	
	$('.select_quiz_other').change(function(event) {		
		document.location.href="db_quiz_list.cfm?quiz_id="+$(this).val();	
	});
	
	$('.btn_create_quiz').click(function(event) {	
		event.preventDefault();		

		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter quiz");
		$('#modal_body_lg').load("modal_window_ressource.cfm?new_quiz=1", function() {});
	});
	
	
});
</script>
</body>
</html>