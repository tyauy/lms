<!DOCTYPE html>

<cfsilent>

<cfparam name="lev_id" default="1">
<cfset menu_type = "training">

<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
	<cfparam name="f_id" default="2">
	<cfset u_id = SESSION.USER_ID>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">
	<cfparam name="f_id" default="2">
	<cfset u_id = SESSION.USER_ID>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	<cfparam name="f_id" default="2">
	<cfset u_id = SESSION.USER_ID>
	
<cfelseif SESSION.USER_PROFILE eq "TM">
	<cfparam name="f_id" default="2">
	<cfset u_id = SESSION.USER_ID>
</cfif>

<cfset list_formation_access = "1,2,3,4,5">

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">

SELECT sm.sessionmaster_name, sm.sessionmaster_id, sm.module_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.sessionmaster_description, sm.keyword_id, sm.grammar_id, 
tp.tpmaster_id, tp.tpmaster_name, tm.module_name, 
ll.level_id, ll.level_alias, ll.level_css, ll.level_name_#SESSION.LANG_CODE# as level_name
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
LEFT JOIN lms_level ll ON ll.level_id = sm.level_id	
WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
AND tp.tpmaster_prebuilt = 0
AND sm.sessionmaster_online_visio = 1
AND sm.level_id <> "0"
ORDER BY sm.level_id, tp.tpmaster_id, sm.module_id ASC


<!---
SELECT tc.*, sm.*, tp.*, tm.module_name, ll.level_id, ll.level_alias, ll.level_css, COUNT(q.quiz_id) as quiz_id
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
LEFT JOIN lms_level ll ON ll.level_id = sm.level_id	
LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
AND tp.tpmaster_prebuilt = 0
AND sm.sessionmaster_online_visio = 1
 <cfif lev_id eq "fav">
	<cfif isdefined("SESSION.USER_SHORTLIST") AND SESSION.USER_SHORTLIST neq "">
	AND sm.sessionmaster_id IN (#SESSION.USER_SHORTLIST#)
	<cfelse>
	AND 1 = 2
	</cfif>
<cfelseif lev_id eq "el">
	<cfif isdefined("SESSION.USER_EL_LIST") AND SESSION.USER_EL_LIST neq "">
	AND sm.sessionmaster_id IN (#SESSION.USER_EL_LIST#)
	<cfelse>
	AND 1 = 2
	</cfif>
<cfelse>
AND tp.tpmaster_level like '%#lev_id#%'		
</cfif>
GROUP BY sm.sessionmaster_id
ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name --->
</cfquery>


<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id <= 5
</cfquery>	

<cfset __text_about = obj_translater.get_translate('text_about')>
<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
<cfset __tooltip_add_favourite = obj_translater.get_translate('tooltip_add_favourite')>
<cfset __tooltip_remove_favourite = obj_translater.get_translate('tooltip_remove_favourite')>

<cfset __card_keywords = obj_translater.get_translate('card_keywords')>
<cfset __card_grammar = obj_translater.get_translate('card_grammar')>
<cfset __btn_details = "Details">


<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id <> "2"
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
</cfquery>

</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
h1,h2,h3,h4,h5,h6{
	font-family: 'Titillium Web', sans-serif;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_visio_library')#">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<cfif SESSION.USER_PROFILE eq "learner">
            <cfinclude template="./incl/incl_nav_visio.cfm">
			</cfif>
			
			<div class="row mt-3">
				<div class="col-md-12">
				
					<div class="card mb-3 border">
						<div class="card-body">

							<h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate("title_page_common_materials")#</cfoutput></h5>
							<hr class="mt-0 border-red">

							<!--- <div class="w-100">
								<h5 class="d-inline"><i class="fa-thin fa-photo-film-music fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate("title_page_common_materials")#</cfoutput></h5>
								<hr class="border-dark mb-3 mt-2">
							</div> --->
						
							<div id="accordion_level">

							<div class="row">
								<div class="col-xl-12">
									<h6 class="d-inline mr-4"><cfoutput>#obj_translater.get_translate("card_level")#</cfoutput> : </h6>
									
									<cfoutput query="get_session_access" group="level_id">		

										<a class="btn btn-outline-#level_alias# <!---<cfif lev_id eq level_id>active</cfif>--->" type="button" <!---href="common_syllabus.cfm?f_id=#f_id#&lev_id=#level_id#"----> data-toggle="collapse" data-target="##collapse_#level_id#" aria-expanded="<!---<cfif lev_id eq level_id>true<cfelse>--->false<!---</cfif>--->">#level_alias#<br>#level_name#</a>
									
									</cfoutput>


									<!---<a class="btn <cfif lev_id eq "search">btn-warning active<cfelse>btn-link</cfif>" type="button" href="common_syllabus.cfm?f_id=#f_id#&lev_id=search"><i class="fas fa-search"></i> <br>Recherche</a>--->
							
								
									<div class="pull-right">			
									<select class="form-control" onChange="document.location.href='common_syllabus.cfm?f_id='+$(this).val()">
									<cfoutput query="get_formation">
									<option value="#formation_id#" <cfif not listfind(list_formation_access,formation_id)>disabled<cfelse><cfif f_id eq formation_id>selected</cfif></cfif>>#formation_name#</option>
									</cfoutput>
									<select>
									</div>
								
								</div>
							</div>
									
							<div class="row">
						
								<div class="col-md-12">

									

									<!--- <cfif get_session_access.recordcount eq "0">
									
										<cfif lev_id eq "fav">
										<div class="alert alert-warning mt-3" role="alert">
											<div class="media">
												<i class="fas fa-heart fa-3x mr-3"></i>
												<div class="media-body">
													<cfoutput>#obj_translater.get_translate_complex('no_favourite_lesson_yet')#</cfoutput>
												</div>
											</div>								
										</div>
										<cfelseif lev_id neq "fav" AND lev_id neq "search">
										<div class="alert alert-info mt-3" role="alert">
											<div class="media">
												<i class="fas fa-laptop fa-3x mr-3"></i>
												<div class="media-body">
													<cfoutput>#obj_translater.get_translate_complex('no_access_library')#</cfoutput>
												</div>
											</div>								
										</div>
										</cfif>
										
									<cfelse> --->
									
									

									<cfoutput query="get_session_access" group="level_id">
									<div class="collapse <!---<cfif lev_id eq level_id>show</cfif>--->" id="collapse_#level_id#" data-parent="##accordion_level">

										<div class="row">
										
											<div class="col-xl-2">
												<!--- <cfset counter = 0> --->
												<cfoutput group="tpmaster_id">
													<!--- <cfset counter++> --->
													<button class="btn btn-submenu btn-outline-#level_alias# btn-block <!---<cfif counter eq "1">active</cfif>--->" data-toggle="collapse" data-target="##tp_#tpmaster_id#" aria-expanded="<!---<cfif counter eq "1">true<cfelse>--->false<!---</cfif>--->" style="text-align:center">
													#tpmaster_id# - #tpmaster_name# 
													</button>
												</cfoutput>			
											</div>
													
											<div class="col-xl-10">
													
												<cfset counter = 0>
													
													<cfoutput group="tpmaster_id">
													<!--- <cfset counter++> --->
														
													<div id="tp_#tpmaster_id#" class="collapse <!---<cfif counter eq "1">show</cfif>--->" data-parent="##collapse_#level_id#">
														
														<cfoutput group="module_id">												
														<div class="border mb-3 bg-light">
															<div class="card-body">
																<div class="card-title"><strong><cfif module_id neq "">#ucase(module_name)#<cfelse>DIVERSE</cfif></strong></div>
														
																<!---<div class="table table-responsive mt-2" style="margin-bottom:0px !important">--->
																<table class="table bg-white mt-2" style="margin-bottom:0px !important">
																<cfoutput>
																<tr>	
																	<td class="d-none d-lg-table-cell">
																	#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="50")#
																	</td>
																	<td width="2%">
																		<cfif level_alias neq "">
																			<div class="badge bg-#level_alias#">#level_alias#</div>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
																		<i class="fas fa-book text-#level_alias#" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
																		<i class="fas fa-volume-up text-#level_alias#" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
																		</cfif>
																	</td>
																	<td width="2%">
																		<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
																		<i class="fas fa-video text-#level_alias#" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
																		</cfif>
																	</td>
																	<!--- <td width="2%">
																		<cfif quiz_id neq "" AND quiz_id neq "0">
																		<i class="fas fa-tasks text-#level_alias#" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
																		</cfif>
																	</td> --->
																	<td width="20%" class="sessionmaster_title">
																		#sessionmaster_name#
																		<br>
																		<span class="btn_view_session" id="sm_#sessionmaster_id#">
																		<!---<small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small>--->
																		</span>
																	</td>
																	
																	<!---<td>
																		<cfif sessionmaster_rank neq "">
																		<span class="badge">#__lesson# #sessionmaster_rank#</span>
																		</cfif>
																	</td>--->
																	<!---<td width="5%">
																		<small>#__text_about# #sessionmaster_duration# m</small>
																	</td>--->
																	<td>
																		<span style="font-size:12px">#mid(sessionmaster_description,1,120)# [...]</span>
																		
																		<cfif keyword_id neq "">
																		<br>
																		<small>#__card_keywords# :</small>
																		<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
																		SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
																		</cfquery>
																		<cfloop query="get_keyword"><span class="badge badge-info">#keyword_name#</span> </cfloop>
																		</cfif>


																		<cfif grammar_id neq "">
																		<br>
																		<small>#__card_grammar# :</small>
																		<cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
																		SELECT grammar_name FROM lms_grammar WHERE grammar_id IN (#grammar_id#)
																		</cfquery>
																		<cfloop query="get_grammar"><span class="badge badge-info">#grammar_name#</span> </cfloop>
																		</cfif>		
																	</td>
																	<td width="10%">
																		
																		<a class="btn btn-sm btn-outline-#level_alias# btn_view_session" id="sm_#sessionmaster_id#" href="##"<!--- data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"--->><i class="fas fa-eye"></i> #__btn_details#</a>
																		<!---<a class="btn btn-sm btn-outline-#css#" id="sm_#sessionmaster_id#" href="learner_practice.cfm?sm_id=#sessionmaster_id#"<!--- data-toggle="tooltip" data-placement="top" title="WeLearning"--->><i class="fas fa-laptop"></i> WeLearning</a>--->
																		
																	</td>
																	
																	<!--- <td width="5%">
																		<cfif isdefined("SESSION.USER_SHORTLIST") AND listfind(SESSION.USER_SHORTLIST,#sessionmaster_id#)>
																		<div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#"><i class="fas fa-heart fa-lg red"></i></div>
																		<cfelse>
																		<div class="p-1 pull-right cursored btn_like_session" id="sm_#sessionmaster_id#"><i class="far fa-heart fa-lg grey"></i></div>
																		</cfif>
																	</td> --->
																</tr>
																</cfoutput>			
																</table>
																<!---</div>--->
															</div>	
														</div>	
														</cfoutput>	
													</div>
														
													</cfoutput>
													
												</div>	
											</div>	
													
										
										</div>	
									</cfoutput>
									</div>	
								
								</div>	
							</div>		
						</div>		
					</div>		
					
				</div>			
			</div>
				
		</div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script>
$(function() {

	/****** INIT BOOSTRAP COMPONENTS *******/	
	$('[data-toggle="popover"]').popover({
	  trigger: 'focus',
	  html: true
	});
	$('[data-toggle="tooltip"]').tooltip({html: true});
		
	
	<cfoutput>
	/******************** VIEW SESSION DETAILS *****************************/
	$('.btn_view_session').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var sgo = idtemp.substr(0,2);
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		<cfif SESSION.USER_ID eq "202" or SESSION.USER_ID eq "2072">
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_title_xl').text("#obj_translater.get_translate('js_modal_title_session')#");
			if(sgo == "sm")
			{$('##modal_body_xl').load("modal_window_session_read.cfm?sm_id="+idtemp, function() {});}
			else
			{$('##modal_body_xl').load("modal_window_session_read.cfm?s_id="+idtemp, function() {});}
		<cfelse>
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_title_xl').text("#obj_translater.get_translate('js_modal_title_session')#");
			if(sgo == "sm")
			{$('##modal_body_xl').load("modal_window_session.cfm?sm_id="+idtemp, function() {});}
			else
			{$('##modal_body_xl').load("modal_window_session.cfm?s_id="+idtemp, function() {});}

		</cfif>
	});
	</cfoutput>
	
	$('.btn_like_session').click(function(event) {		
		event.preventDefault();
		var sm_id = $(this).attr("id");
		var sm_id = sm_id.substr(sm_id.indexOf("_")+1,50);
		var obj_cor = $(this);
		obj_cor.empty();
		obj_cor.append('<i class="fas fa-spinner fa-spin"></i>');
		$.ajax({
			url : 'updater.cfc?method=shortlist',
			type : 'POST',	   
			<cfoutput>
			data : {sm_id: sm_id},
			</cfoutput>		   
			success : function(resultat, statut){
				obj_cor.empty();
				if(resultat == "off"){
					obj_cor.append('<i class="fas fa-heart fa-lg grey"></i>');
				}
				else
				{
					obj_cor.append('<i class="fas fa-heart fa-lg red"></i>');
				}
			},
			error : function(resultat, statut, erreur){
				alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
			},
			complete : function(resultat, statut){}
		})
	});
	
	$('.btn_help').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
				
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_help')#</cfoutput>");
		$('#modal_body_lg').load("modal_window_help.cfm?h="+idtemp, function() {});
		
	});
	 
})

</script>

</body>
</html>