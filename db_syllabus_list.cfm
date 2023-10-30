<!DOCTYPE html>

<cfsilent>

<cfparam name="f_id" default="2">
<cfparam name="lev_id" default="1">

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.*, tm.module_name, tpo.tp_orientation_name_fr, ll.level_alias, ll.level_css, em.elearning_module_id,
(SELECT COUNT(sessionmaster_id) FROM lms_tpsession tps2 WHERE tps2.sessionmaster_id = sm.sessionmaster_id) as nb
FROM lms_tpsessionmaster2 sm

LEFT JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
LEFT JOIN lms_tpmaster2 tp ON tp.tpmaster_id = tc.tpmaster_id	

  

LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
LEFT JOIN lms_tporientation tpo ON tpo.tp_orientation_id = sm.tp_orientation_id	
LEFT JOIN lms_level ll ON ll.level_id = sm.level_id	

LEFT JOIN lms_elearning_module em ON em.sessionmaster_id = sm.sessionmaster_id	



WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
AND sm.level_id = '#lev_id#'
AND tp.tpmaster_prebuilt = 0

GROUP BY sm.sessionmaster_id
ORDER BY sm.level_id, tp.tpmaster_id, sm.module_id
</cfquery>
	

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id <= 5
</cfquery>	

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_alias, level_name
FROM lms_level
</cfquery>	


<cfset __text_about = obj_translater.get_translate('text_about')>
<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : #obj_translater.get_translate('title_page_common_materials')#">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
			

			<div class="row">
				<div class="col-md-12">

					<ul class="nav nav-tabs" id="tp_list" role="tablist">
						<cfoutput query="get_formation">
						<li class="nav-item">
						<a href="db_syllabus_list.cfm?f_id=#formation_id#" class="nav-link <cfif f_id eq formation_id>active</cfif>">
						#obj_lms.get_formation_icon(formation_code,formation_name)#
						</a>
						</li>
						</cfoutput>
					</ul>

					<div class="row mt-3">
					
						<div class="col-md-12">
							
                            <cfoutput query="get_level">
                                <a class="btn <cfif lev_id eq level_id>btn-#level_alias#<cfelse>btn-outline-#level_alias#</cfif>" type="button" href="db_syllabus_list.cfm?f_id=#f_id#&lev_id=#level_id#"> #level_alias#<br> <cfif level_id eq "0">N/A<cfelse>#level_name#</cfif></a>
							</cfoutput>
							<cfif f_id eq "2" OR f_id eq "4">
							<cfoutput>

							<a class="btn <cfif lev_id eq "3,4,5">btn-primary<cfelse>btn-outline-primary</cfif>" type="button" href="db_syllabus_list.cfm?f_id=#f_id#&lev_id=3,4,5"> B1,B2,C1<br>To check</a>
							</cfoutput>
							</cfif>

				            <cfoutput query="get_session_access" group="level_id">
										
									<div class="collapse show" id="collapse_#level_id#">
									
									<cfoutput group="tpmaster_id">
									
										<button class="btn btn-outline-#level_alias# btn-block text-left" data-toggle="collapse" data-target="##tp_#replace(level_id,",","_","ALL")#_#tpmaster_id#" aria-expanded="true">
										#tpmaster_name# #tpmaster_id#
										</button>
										
										<div id="tp_#replace(level_id,",","_","ALL")#_#tpmaster_id#" class="collapse" data-parent="##collapse_#replace(level_id,",","_","ALL")#">
											<div class="table table-responsive-sm">
											<table class="table table-bordered table-sm bg-white">
												<tr align="center">	
                                                    
													<td class="bg-light font-weight-bold" width="40">ID</td>
													<td class="bg-light font-weight-bold" width="40">Level</td>
													<td colspan="3" class="bg-light font-weight-bold" width="40"><i class="fa-light fa-camera-web"></i></td>
													<td colspan="3" class="bg-light font-weight-bold" width="40"><i class="fa-light fa-laptop"></i></td>		
													<td class="bg-light font-weight-bold">Name</td>
													<td class="bg-light font-weight-bold" width="40">Type</td>
													<td class="bg-light font-weight-bold"><img src="./assets/img_level/global.svg"></td>
													
													<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
													<td class="bg-light font-weight-bold"><span class="lang-sm" lang="#lg#"></span></td>
													</cfloop>

													<td class="bg-light font-weight-bold" width="40">Use(s)</td>
													
													<td class="bg-light font-weight-bold" width="40">Quiz</td>	
													<!---<td class="bg-light font-weight-bold" width="40">KW</td>	--->
													<td class="bg-light font-weight-bold" width="40">INT</td>	
													<td class="bg-light font-weight-bold" width="40">MAP</td>	
													<td class="bg-light font-weight-bold" width="40">Support</td>	
													<td class="bg-light font-weight-bold" width="40">Edit</td>	
													
													<!--- <td class="bg-light font-weight-bold" width="40">K_ID</td>
													<td class="bg-light font-weight-bold" width="40">SK_ID</td>
													<td class="bg-light font-weight-bold" width="40">GR_ID</td>
													<td class="bg-light font-weight-bold" width="40">MAP_ID</td>
													<td class="bg-light font-weight-bold">Desc.</td>
													<td class="bg-light font-weight-bold">Obj.</td>
													<td class="bg-light font-weight-bold">Gram.</td>
													<td class="bg-light font-weight-bold">Voc.</td>									 --->
													<!--- <td class="bg-light font-weight-bold" width="40">VISIO READY</td>	 --->
													<!--- <td class="bg-light font-weight-bold">Est.</td>							
													<td class="bg-light font-weight-bold" width="40">EL READY</td>	
													<td class="bg-light font-weight-bold">Est.</td> --->
													<!--- <td class="bg-light font-weight-bold" width="40">LN Gram.</td>
													<td class="bg-light font-weight-bold" width="40">LN Voc.</td> --->
													<!--- <td class="bg-light font-weight-bold" width="40">PPT/PDF</td>
													<td class="bg-light font-weight-bold" width="40">AUDIO</td>
													<td class="bg-light font-weight-bold" width="40">EX QUIZ</td>	
													<td class="bg-light font-weight-bold" width="40">VOC LIST</td>													
													<td class="bg-light"></td> --->
												</tr>
												
												<cfoutput group="module_id">
												<cfif module_id neq "">
												<tr>	
													<td colspan="26" class="bg-light font-weight-bold">#ucase(module_name)#</td>
												</tr>
												</cfif>

													<cfoutput>
                                                    <tr <cfif sessionmaster_online_visio eq "0" AND sessionmaster_online_el eq "0">style="background-color:##CCC"</cfif>>	
                                                        <td>#sessionmaster_id#</td>
                                                        <td>#obj_function.get_level_thumb(level_id,"30")#</td>
														
														<cfif sessionmaster_online_visio neq "0">
															<td><i class="fa-solid text-#level_alias# fa-camera-web"></i></td>
															<td>
																<cfif sessionmaster_online_visio eq "1">
																	<span class="text-#level_alias#">online</span>
																<cfelseif sessionmaster_online_visio eq "2">
																	<span class="text-red">to review</span>
																</cfif>
															</td>
															<td>
																<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
																	<img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="40" class="mr-2">
																<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
																	<img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="40" class="mr-2">
																<cfelse>
																	<img src="../assets/img/wefit_lesson.jpg" width="40" class="mr-2">
																</cfif>
															</td>
														<cfelse>
															<td colspan="3">-</td>
														</cfif>


														<cfif sessionmaster_online_el neq "0">
															<td><i class="fa-solid text-#level_alias# fa-laptop"></i></td>
															<td>
																<cfif sessionmaster_online_el eq "1">
																	<span class="text-#level_alias#">online</span>
																<cfelseif sessionmaster_online_el eq "2">
																	<span class="text-red">to review</span>
																</cfif>
															</td>
															<td>
																<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
																	<img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="40" class="mr-2">
																<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
																	<img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="40" class="mr-2">
																<cfelse>
																	<img src="../assets/img/wefit_lesson.jpg" width="40" class="mr-2">
																</cfif>
															</td>
														<cfelse>
															<td colspan="3">-</td>
														</cfif>

														<td><a href="db_syllabus_edit.cfm?sm_id=#sessionmaster_id#" target="_blank">#sessionmaster_name#</a></td>
														
														<td width="50">
														<span class="badge badge-pill border">
															<cfif tp_orientation_id eq "1">
																General
															<cfelseif tp_orientation_id eq "2">	
																Business
															<cfelseif tp_orientation_id eq "3">	
																Grammar
															<cfelseif tp_orientation_id eq "4">	
																Certif
															<cfelseif tp_orientation_id eq "6">	
																Video
															</cfif>
														</span>
														</td>

														<td align="center">
															<cfif sessionmaster_name neq "" AND sessionmaster_description neq "">
															<i class="fas fa-check-circle" style="color:##20b027"></i>
															<cfelse>
																<i class="fas fa-times-circle" style="color:##FA0000"></i>
															</cfif>
															</td>
															
														<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
														<td align="center">
														<cfif evaluate("sessionmaster_name_#lg#") neq "" AND evaluate("sessionmaster_description_#lg#") neq "">
														<i class="fas fa-check-circle" style="color:##20b027"></i>
														<cfelse>
															<i class="fas fa-times-circle" style="color:##FA0000"></i>
														</cfif>
														</td>
														</cfloop>
														
														<td>
															#nb#
														</td>
														<td align="center">
															<cfquery name="get_quiz_unit" datasource="#SESSION.BDDSOURCE#">
															SELECT COUNT(quiz_id) as nb FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND quiz_type = "unit"
															</cfquery>
															<cfif get_quiz_unit.nb neq "0">
																<a class="btn btn-sm btn-#level_alias#"><i class="fa-light fa-tasks"></i></a>
															</cfif>
														</td>
														
														<td>
															<cfquery name="get_kwid" datasource="#SESSION.BDDSOURCE#">
															SELECT COUNT(skdc.keyword_id) as nb FROM lms_sessionmaster_keywordid_cor skdc
															INNER JOIN lms_keyword2 kw ON kw.keyword_id = skdc.keyword_id AND kw.parent_id = 0
															WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">
															</cfquery>
															<cfif get_kwid.nb neq "0"><i class="fas fa-check-circle" style="color:##20b027"></i><cfelse><i class="fas fa-times-circle" style="color:##ff0000"></i></cfif>
														
														</td>

														<td>	
															<cfif mapping_id neq ""><i class="fas fa-check-circle" style="color:##20b027"></i><cfelse><i class="fas fa-times-circle" style="color:##ff0000"></i></cfif>
														</td>

														<td>
															<a class="btn_view_session btn btn-sm btn-#level_alias#" id="sm_#sessionmaster_id#" href="##"><i class="fa-light fa-book"></i></a>

														</td>
														<td align="center">
															<a class="btn btn-sm btn-#level_alias#" id="sm_#sessionmaster_id#" href="db_syllabus_edit.cfm?sm_id=#sessionmaster_id#"><i class="fas fa-edit"></i></a>
														</td>

                                                    </tr>
												</cfoutput>
	
												
                                                 <!--- <cfoutput>
												
												<tr <cfif sessionmaster_online_visio eq "0">class="bg-secondary"</cfif>>	
													<td>
														<cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>
															<a class="btn btn-sm btn-success btn_player_work" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#"><i class="fas fa-video" aria-hidden="true"></i></a>
														</cfif>
													</td>
													<td>
														<cfif fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.en-US.vtt")>
															<a class="btn btn-sm btn-success"><i class="fas fa-files" style="color:##FFFFFF" aria-hidden="true"></i></a>
														</cfif>
													</td>
													<td align="center">
														<cfquery name="get_quiz_unit" datasource="#SESSION.BDDSOURCE#">
														SELECT COUNT(quiz_id) as nb FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND quiz_type = "unit"
														</cfquery>
														<cfif get_quiz_unit.nb neq "0">
															<a class="btn btn-sm btn-success"><i class="fas fa-tasks" style="color:##FFFFFF" aria-hidden="true"></i></a>
														</cfif>
													</td>
													<td width="50" align="center">
													<a href="#SESSION.BO_ROOT_URL#/learner_practice.cfm?sm_id=#sessionmaster_id#&u_id=411" target="_blank">#sessionmaster_id#</a>
													
													</td>
													<td width="50">
														<!--- level_id -- #level_id# --->
													#obj_function.get_level_thumb(level_id,"40")#
													<!--- <cfif tpmaster_id gte "1340">
														#sessionmaster_grammar#
													</cfif> --->
													</td>
													<td width="50">
													<span class="badge badge-pill">#tp_orientation_name_fr#</span>
													</td>
													<td width="50">
														#obj_lms.get_thumb_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="40")#
														<cfif tpmaster_id gte "1340">
															<br><a href="#sessionmaster_description#" target="_blank">[IMG_GO]</a>
														</cfif>
													</td>
													<td width="300">
														<cfif sessionmaster_new eq "1">
													<span class="badge badge-danger">New</span>&nbsp;
													</cfif>
														#sessionmaster_name#
														<br>
														<cfif tpmaster_id gte "1340">
															<strong>#sessionmaster_grammar#</strong>
															<br>
															<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
															<cfif evaluate("sessionmaster_transcript_#lg#") neq "">
																<img src="./assets/img_formation/#lg#.png" width="20">
															</cfif>
															</cfloop>
														</cfif>

													</td>
													<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
													<td align="center">
													<cfif evaluate("sessionmaster_name_#lg#") neq "" AND evaluate("sessionmaster_description_#lg#") neq "">
													<i class="fas fa-check-circle" style="color:##20b027"></i>
													</cfif>
													<cfif tpmaster_id gte "1340" AND formation_id eq "2" AND tpmaster_id lt "1411">
														<cfset new_url = mid(sessionmaster_url,1,len(sessionmaster_url)-2)>
														<a href="#new_url##lg#" target="_blank">[VIDEO_#lg#]</a>
													<cfelseif formation_id eq "4">
														<cfset new_url = "https://www.linguahouse.com"&sessionmaster_url>
														<a href="#new_url#" target="_blank">[GO LINK]</a>
													</cfif>
													</td>
													</cfloop>
													<td align="center">
														<cfif keyword_id eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													#sessionmaster_ressource#
														</td>
													<td align="center">
														<cfif skill_id eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													</td>
													<td align="center">
														<cfif grammar_id eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													</td>
													<td align="center">
														<cfif mapping_id eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													</td>
													<td>
														<cfif sessionmaster_description eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><small style="color:##000 !important">#mid(sessionmaster_description,1,10)# [...]</small></cfif>
													</td>
													<td>
														<cfif sessionmaster_objectives eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><small style="color:##000 !important">#mid(sessionmaster_objectives,1,10)# [...]</small></cfif>
													</td>
													<td>
														<cfif sessionmaster_grammar eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><small style="color:##000 !important">#mid(sessionmaster_grammar,1,10)# [...]</small></cfif>
													</td>
													<td>
														<cfif sessionmaster_vocabulary eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><small style="color:##000 !important">#mid(sessionmaster_vocabulary,1,10)# [...]</small></cfif>
													</td>
													<td>
														<span class="text-dark">#sessionmaster_duration#m</span>
													</td>
													<td>
														<span class="text-dark">#sessionmaster_el_duration#m</span>
													</td>
													<td align="center">
														<cfif sessionmaster_ln_grammar eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													</td>
													<td align="center">
														<cfif sessionmaster_ln_vocabulary eq ""><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---><cfelse><i class="fas fa-check-circle" style="color:##20b027"></i></cfif>
													</td> 
													<td align="center">
														<cfif sessionmaster_support_bool eq "1">
														<a class="btn_view_session" id="sm_#sessionmaster_id#" href="##"><i class="fas fa-book" style="color:##20b027"></i></a>
														<cfelse>
														<!---<i class="fas fa-times-circle" style="color:##ff0000"></i>--->
														</cfif>
													</td>
													<td align="center">
														<cfif sessionmaster_audio_bool eq "1">
														<a class="btn_view_session" id="sm_#sessionmaster_id#" href="##"><i class="fas fa-volume-up" style="color:##20b027"></i></a>
														<cfelse>
														<!---<i class="fas fa-times-circle" style="color:##ff0000"></i>--->
														</cfif>
													</td>
													<!--- <td align="center">
														<cfif sessionmaster_video_bool eq "1">
														<a class="btn_view_session" id="sm_#sessionmaster_id#" href="##"><i class="fas fa-video" style="color:##20b027"></i></a>
														<cfelse>
														<!---<i class="fas fa-times-circle" style="color:##ff0000"></i>--->
														</cfif>
													</td> --->
													<td align="center">
														<cfquery name="get_quiz_exercice" datasource="#SESSION.BDDSOURCE#">
														SELECT COUNT(quiz_id) as nb FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND quiz_type = "exercice"
														</cfquery>
														<cfif get_quiz_exercice.nb neq "0">
														<a class="btn_view_session" id="sm_#sessionmaster_id#" href="##"><i class="fas fa-tasks" style="color:##20b027"></i></a><br>
														</cfif>
													</td>
													<td align="center">
														<cfif voc_cat_id neq ""><i class="fas fa-check-circle" style="color:##20b027"></i><cfelse><!---<i class="fas fa-times-circle" style="color:##ff0000"></i>---></cfif>
													</td>
													
													
												</tr>
												</cfoutput> --->
												</cfoutput>					
											</table>
											</div>											
										</div>
									
									</cfoutput>
									<button class="btn btn-#level_alias# btn_create_ressource" type="button" id="add_#formation_id#">Ajouter</button>
								
									</div>
									
								</cfoutput>	
							
							
						
						</div>
				
					</div>
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>
$(function() {


$('.btn_player_work').click(function(event) {		
	event.preventDefault();
	var sm_id = $(this).attr('data-smid');
	$('#window_item_el_video').modal({<!---backdrop: 'static',keyboard: false--->});
	$('#modal_title_el_video').text("Vidéo");
	$('#modal_body_el_video').load("modal_window_el_video.cfm?sm_id="+sm_id);

})
$('#window_item_el_video').on('hidden.bs.modal', function (e) {
	$('#modal_body_el_video').empty();
});



<cfoutput>
<cfloop list="1,2,3,4,5" index="form_cor">
$('##collapse_#form_cor#_A').on('show.bs.collapse', function () {
$('##collapse_#form_cor#_B1').collapse('hide');
$('##collapse_#form_cor#_B2').collapse('hide');
$('##collapse_#form_cor#_C').collapse('hide'); 
})

$('##collapse_#form_cor#_B1').on('show.bs.collapse', function () {
$('##collapse_#form_cor#_A').collapse('hide');
$('##collapse_#form_cor#_B2').collapse('hide');
$('##collapse_#form_cor#_C').collapse('hide'); 
})

$('##collapse_#form_cor#_B2').on('show.bs.collapse', function () {
$('##collapse_#form_cor#_A').collapse('hide');
$('##collapse_#form_cor#_B1').collapse('hide');
$('##collapse_#form_cor#_C').collapse('hide'); 
})

$('##collapse_#form_cor#_C').on('show.bs.collapse', function () {
$('##collapse_#form_cor#_A').collapse('hide');
$('##collapse_#form_cor#_B1').collapse('hide'); 
$('##collapse_#form_cor#_B2').collapse('hide'); 
})
</cfloop>
</cfoutput>


	$('.btn_create_ressource').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter ressource");
		$('#modal_body_lg').load("modal_window_ressource.cfm?new_resource=1&f_id="+idtemp, function() {});
	});
	
})

</script>

</body>
</html>