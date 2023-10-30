<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfparam name="f_id" default="2">

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.tpmaster_name
FROM lms_tpmaster2 tp
LEFT JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id
WHERE (tp.tpmaster_prebuilt = 0 OR tp.tpmaster_id = 15)
AND sm.sessionmaster_online_visio = 1

ORDER BY sm.sessionmaster_id ASC
</cfquery>

<!--- <cfquery name="get_module" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM lms_tpmodulemaster2 ORDER BY module_name ASC --->
<!--- </cfquery>					 --->
							
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		
		<cfset title_page = "TP Pre-filled">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row">
				<div class="col-md-12">
				<a href="db_tpprefilled_list.cfm?f_id=2" class="btn btn-info <cfif f_id eq "2">active</cfif>">English</a>
				<a href="db_tpprefilled_list.cfm?f_id=3" class="btn btn-info <cfif f_id eq "3">active</cfif>">German</a>
				<a href="db_tpprefilled_list.cfm?f_id=4" class="btn btn-info <cfif f_id eq "4">active</cfif>">Spanish</a>
					<!---<ul class="nav nav-tabs" id="tp_list" role="tablist">
						<cfoutput query="get_formation">
						<li class="nav-item">		
						<a href="##f_#formation_id#" id="form_#formation_id#" class="nav-link <cfif f_id eq formation_id>active</cfif>" role="tab" data-toggle="tab">
						#obj_lms.get_formation_icon(formation_code,formation_name)#
						</a>
						</li>
						</cfoutput>
					</ul>

					<div class="tab-content">
						<cfloop query="get_formation">
						<div role="tabpanel" class="tab-pane <cfif f_id eq get_formation.formation_id>active show</cfif>" id="f_<cfoutput>#formation_id#</cfoutput>" style="margin-top:15px;">--->
							
										
							<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
							SELECT *
							FROM lms_tpmaster2 tp
							INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
							INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
							<cfif not isdefined("tpmaster_id")>
							WHERE tp.tpmaster_prebuilt = 1
							<cfelse>
							WHERE tp.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
							</cfif>
							AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
							ORDER BY tp.tpmaster_level, tp.tpmaster_id, tp.tpmaster_hour, tc.sessionmaster_rank ASC
							</cfquery>	
							
							<!--- <cfdump var="#get_sm#"> --->
							<cfif not isdefined("tpmaster_id")>
							<ul class="nav nav-tabs" id="tp_list" role="tablist">
								<cfoutput query="get_sm" group="tpmaster_level">
								<li class="nav-item">		
								<a href="##f_#replace(tpmaster_level,"/","","ALL")#" class="nav-link <cfif tpmaster_level eq "A1/A2">active</cfif>" role="tab" data-toggle="tab">
								#tpmaster_level#
								</a>
								</li>
								</cfoutput>
								<li class="nav-item">		
								<a href="#add_tpprefilled" class="nav-link " role="tab" data-toggle="tab">
								<i class="fal fa-plus-square"></i>
								</a>
								</li>
							</ul>
							</cfif>
							
							
						<cfif not isdefined("tpmaster_id")>
						<div class="tab-content">
						<cfset counter = 0> 		
						<cfoutput query="get_sm" group="tpmaster_level">
						<div role="tabpanel" class="tab-pane <cfif tpmaster_level eq "A1/A2">active show</cfif>" id="f_#replace(tpmaster_level,"/","","ALL")#" style="margin-top:15px;">
													
													
							
							<cfoutput group="tpmaster_id">
							<cfset counter = 0> 
							<table class="table table-bordered table-sm bordered">
								<tr class="bg-light">
									<td colspan="5">
									<cfif fileexists("#SESSION.BO_ROOT#/assets/img_tpmaster/#tpmaster_img#")>
										<img src="./assets/img_tpmaster/#tpmaster_img#" width="80">
									<cfelse>
										<img src="./assets/img/wefit_lesson.jpg" width="80">
									</cfif>
									<strong>#tpmaster_id# - #tpmaster_name# - #tpmaster_hour#H - #tpmaster_lesson_duration#min</strong></td>
									<td><a target="_blank" href="./tpl/tp_container.cfm?tppack_id=#tpmaster_id#" class="btn btn-warning">PDF</a></td>
								</tr>
							<cfoutput>
							<cfset counter = counter+sessionmaster_schedule_duration> 
								<tr class="bg-white">
									<td>#sessionmaster_rank# - #tpmastercor_id#</td>
									<td>#sessionmaster_id#</td>
									<td><cfif tpmastercor_name_fr neq "">#tpmastercor_name_fr#<cfelse>#sessionmaster_name#</cfif></td>
									<td>
									<cfif tpmastercor_mapping_id neq "">
																
										<cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
											SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#tpmastercor_mapping_id#) AND mapping_category = 'grammar'
										</cfquery>
										
										<div class="col-md-3">	
											<cfif get_mapping_grammar.recordcount neq "0">Grammar<br></cfif>
											
											<cfloop query="get_mapping_grammar">
											
											<cfif findnocase("A1",level)>
												<cfset css = "success">
											<cfelseif findnocase("A2",level)>
												<cfset css = "primary">
											<cfelseif findnocase("B1",level)>
												<cfset css = "info">
											<cfelseif findnocase("B2",level)>
												<cfset css = "warning">
											<cfelseif findnocase("C1",level)>
												<cfset css = "danger">
											</cfif>
											
											<span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
											</cfloop>
										</div>
										
										<cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#">
											SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#tpmastercor_mapping_id#) AND mapping_category = 'vocabulary'
										</cfquery>
										
										<div class="col-md-3">	
											<cfif get_mapping_vocabulary.recordcount neq "0">Vocabulary<br></cfif>
											
											<cfloop query="get_mapping_vocabulary">
											
											<cfif findnocase("A1",level)>
												<cfset css = "success">
											<cfelseif findnocase("A2",level)>
												<cfset css = "primary">
											<cfelseif findnocase("B1",level)>
												<cfset css = "info">
											<cfelseif findnocase("B2",level)>
												<cfset css = "warning">
											<cfelseif findnocase("C1",level)>
												<cfset css = "danger">
											</cfif>
											
											<span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
											</cfloop>
										</div>
										
									<cfelse>
									
									<div class="col-md-6"></div>
									
									</cfif>
									</td>
									
									
									<td>#sessionmaster_schedule_duration# min</td>
									<td>
									<cfif sessionmaster_id eq "1183">
									<a class="btn btn-info btn-sm btn_edit_session" id="tpmastercor_#tpmastercor_id#">EDIT</a>
									</cfif>
									<a class="btn btn-info btn-sm" href="db_updater.cfm?del=1&tpmaster_id=#tpmaster_id#&tpmastercor_id=#tpmastercor_id#&f_id=#f_id#">Delete</a>
									</td>
								</tr>
							</cfoutput>
								<tr class="bg-white">
									<td colspan="4"></td>
									<td><strong>#counter/60# H</strong></td>
									<td></td>
								</tr>
								<!--- <tr class="bg-white"> --->
									<!--- <form action="db_updater.cfm" action="post"> --->
									<!--- <td>ADD MODULE</td> --->
									<!--- <td></td> --->
									<!--- <td><select class="form-control" name="module_id"> --->
									<!--- <cfloop query="get_module"> --->
									<!--- <option value="#get_module.module_id#">#get_module.module_name#</option> --->
									<!--- </cfloop> --->
									<!--- </select> --->
									<!--- </td> --->
									<!--- <td></td> --->
									<!--- <td> --->
									<!--- <input type="hidden" name="tpmaster_id" value="#tpmaster_id#"> --->
									<!--- <input type="submit" class="btn btn-info" value="go"></td> --->
									<!--- </form> --->
								<!--- </tr> --->
								<tr class="bg-white">
									<form action="db_updater.cfm" action="post">
									<td>ADD LESSON</td>
									<td></td>
									<td></td>
									<td><select class="form-control" name="sm_id">
									<cfloop query="get_session_access">
									<option value="#get_session_access.sessionmaster_id#" <cfif get_session_access.sessionmaster_id eq "1183">selected</cfif>>#get_session_access.sessionmaster_id# #get_session_access.sessionmaster_name#</option>
									</cfloop>
									</select>
									</td>
									<td>
									<select class="form-control" name="h">
									<option value="30">30 min</option>
									<option value="60" selected>1 h</option>
									</select>
									</td>
									<td>
									<input type="hidden" name="f_id" value="#f_id#">
									<input type="hidden" name="tpmaster_id" value="#tpmaster_id#">
									<input type="submit" class="btn btn-info" value="go"></td>
									</form>
								</tr>
							</table>
							</cfoutput>
							
						</div>
						</cfoutput>
<!--------------------------------------------------------------------------------------------------------------->
						<div role="tabpanel" class="tab-pane" id="add_tpprefilled" style="margin-top:15px;">
							
							<cfoutput>
							<form action="db_updater.cfm" method="post" enctype="multipart/form-data">

							<table class="table table-bordered table-sm">
													
								<!----------------->
								<tr class="bg-white">
									<td width="10%">
										NAME
									</td>
									<td width="90%" colspan="3">
										<ul class="nav nav-tabs" id="title_list" role="tablist">
										<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
										
										<li class="nav-item">		
											<a href="##insert_name_#lg#" class="nav-link<cfif lg eq #SESSION.LANG_CODE#> active</cfif>" role="tab" data-toggle="tab">											
											<span class="lang-sm" lang="#lg#"></span>
											</a>
										</li>
										
										</cfloop>
										</ul>
										<div class="tab-content">
											<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
											
											<div role="tabpanel" class="tab-pane<cfif lg eq #SESSION.LANG_CODE#> active show</cfif>" id="insert_name_#lg#" style="margin-top:15px;">
												<input type="text" class="form-control" name="insert_name_#lg#" value="">
											</div>
											
											</cfloop>											
										</div>
									</td>
								</tr>
								
								<tr class="bg-white">
									<td width="20%">
										LEVEL
									</td>
									<td width="30%">
										<select name="insert_level" class="form-control">
											<cfloop list="A1/A2,A2,B1,B1/B2,B2,C1,C1/C2" index="lvl">
											<option value="#lvl#">
											#lvl#
											</option>
											</cfloop>
										</select>
									</td>
									<td width="20%">
										FORMATION LANGUAGE
									</td>
									<td width="30%">
										<select name="insert_formation_lg" class="form-control">
											<option value="2">English</option>
											<option value="3">German</option>
											<option value="4">Spanish</option>
										</select>
									</td>
								</tr>

								<tr class="bg-white">
									<td width="20%">
									NB HOURS
									</td>
									<td width="30%">
										<select name="insert_tp_hour" class="form-control">
											<option value="5">5</option>
											<option value="10">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
											<option value="30">30</option>
											<option value="35">35</option>
											<option value="40">40</option>
										</select>
									</td>
									<td width="20%">
									LESSON DURATION
									</td>
									<td width="30%">
										<select name="insert_lesson_duration" class="form-control">
											<option value="30">30 min</option>
											<option value="45">45 min</option>
											<option value="60">1 h</option>
										</select>
									</td>
								</tr>

								<tr class="bg-white">

									<td colspan="4" align="center">
									<input type="hidden" name="insert_tpprefilled" value="1">
									<input type="submit" class="btn btn-outline-info" value="ADD">
									</td>
									
								</tr>
							</table>
							</form>
							
							</cfoutput>
							
						</div>
<!--------------------------------------------------------------------------------------------------------------->
						<cfelse>
						<table class="table table-bordered table-sm">
						<cfset counter = 0> 
							<cfoutput query="get_sm" group="tpmaster_id">
								<tr class="bg-light">
									<td colspan="5"><strong>#tpmaster_id# - #tpmaster_name# - [#tpmaster_hour#h]</strong></td>
								</tr>
							<cfoutput>
							<cfset counter = counter+sessionmaster_schedule_duration> 
								<tr class="bg-white">
									<td>#sessionmaster_rank#</td>
									<td><cfif tpmastercor_name_fr neq "">#tpmastercor_name_fr#<cfelse>#sessionmaster_name#</cfif></td>
									<td>
									<cfif tpmastercor_mapping_id neq "">
																
																	
										<!--- <br> --->
										<!--- <small>#__card_keywords# :</small> --->
										<cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
											SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#tpmastercor_mapping_id#) AND mapping_category = 'grammar'
										</cfquery>
										
										<div class="col-md-3">	
											<cfif get_mapping_grammar.recordcount neq "0">Grammar<br></cfif>
											
											<cfloop query="get_mapping_grammar">
											
											<cfif findnocase("A1",level)>
												<cfset css = "success">
											<cfelseif findnocase("A2",level)>
												<cfset css = "primary">
											<cfelseif findnocase("B1",level)>
												<cfset css = "info">
											<cfelseif findnocase("B2",level)>
												<cfset css = "warning">
											<cfelseif findnocase("C1",level)>
												<cfset css = "danger">
											</cfif>
											
											<span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
											</cfloop>
										</div>
										
										<cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#">
											SELECT level, mapping_id as m_id, mapping_name FROM lms_mapping WHERE mapping_id IN (#tpmastercor_mapping_id#) AND mapping_category = 'vocabulary'
										</cfquery>
										
										<div class="col-md-3">	
											<cfif get_mapping_vocabulary.recordcount neq "0">Vocabulary<br></cfif>
											
											<cfloop query="get_mapping_vocabulary">
											
											<cfif findnocase("A1",level)>
												<cfset css = "success">
											<cfelseif findnocase("A2",level)>
												<cfset css = "primary">
											<cfelseif findnocase("B1",level)>
												<cfset css = "info">
											<cfelseif findnocase("B2",level)>
												<cfset css = "warning">
											<cfelseif findnocase("C1",level)>
												<cfset css = "danger">
											</cfif>
											
											<span class="badge badge-#css# font-weight-normal" style="font-size:13px">#level# - #mapping_name#</span><br>
											</cfloop>
										</div>
										
									<cfelse>
									
									<div class="col-md-6"></div>
									
									</cfif>
									</td>
									<td>#sessionmaster_schedule_duration# min</td>
									<td>
									<cfif sessionmaster_id eq "1183">
									<a class="btn btn-info btn-sm btn_edit_session" id="tpmastercor_#tpmastercor_id#">EDIT</a>
									</cfif>
									<a class="btn btn-info btn-sm" href="db_updater.cfm?del=1&tpmaster_id=#tpmaster_id#&tpmastercor_id=#tpmastercor_id#&f_id=#f_id#">Delete</a>
									</td>
								</tr>
							</cfoutput>
								<tr class="bg-white">
									<td colspan="3"></td>
									<td><strong>#counter/60# H</strong></td>
									<td></td>
								</tr>
								<!--- <tr class="bg-white"> --->
									<!--- <form action="db_updater.cfm" action="post"> --->
									<!--- <td>ADD MODULE</td> --->
									<!--- <td><select class="form-control" name="module_id"> --->
									<!--- <cfloop query="get_module"> --->
									<!--- <option value="#get_module.module_id#">#get_module.module_name#</option> --->
									<!--- </cfloop> --->
									<!--- </select> --->
									<!--- </td> --->
									<!--- <td></td> --->
									<!--- <td> --->
									<!--- <input type="hidden" name="tpmaster_id" value="#tpmaster_id#"> --->
									<!--- <input type="submit" class="btn btn-info" value="go"></td> --->
									<!--- </form> --->
								<!--- </tr> --->
								<tr class="bg-white">
									<form action="db_updater.cfm" action="post">
									<td>ADD LESSON</td>
									<td><select class="form-control" name="sm_id">
									<cfloop query="get_session_access">
									<option value="#get_session_access.sessionmaster_id#" <cfif get_session_access.sessionmaster_id eq "1183">selected</cfif>>#get_session_access.sessionmaster_id# #get_session_access.sessionmaster_name#</option>
									</cfloop>
									</select>
									</td>
									<td></td>
									<td>
									<select class="form-control" name="h">
									<option value="30">30 min</option>
									<option value="60" selected>1 h</option>
									</select>
									</td>
									<td>
									<input type="hidden" name="f_id" value="#f_id#">
									<input type="hidden" name="tpmaster_id" value="#tpmaster_id#">
									<input type="submit" class="btn btn-info" value="go"></td>
									</form>
								</tr>
							</cfoutput>
							</table>
						
						</cfif>
							
							<!---<div align="center">
							<form action="db_updater.cfm" action="post">
							<input type="text" name="tpmaster_name" class="form-control">
							<cfoutput>
							<input type="hidden" name="formation_id" value="#formation_id#">
							<input type="hidden" name="create" value="1">
							<input type="submit" class="btn btn-info" value="GO">
							</cfoutput>
							</form>
							</div>--->
							
						<!---</div>
						</cfloop>
						
					</div>--->
					
					
						
					
				</div>
			</div>
		</div>
			
		
	</div>
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	<!--- $('.btn_create_prebuilt').click(function(event) { --->
	<!--- event.preventDefault(); --->
	<!--- $('##window_item_lg').modal({keyboard: true}); --->
	<!--- $('##modal_title_lg').text("Creer parcours prebuilt");		 --->
	<!--- $('##modal_body_lg').load("modal_window_prebuilt.cfm?t_id=#t_id#"); --->
	<cfoutput>
	$('.btn_edit_session').click(function(event) {
	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tpmastercor_id = idtemp[1];	
		<!--- alert(tpmastercor_id); --->
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Edit lesson");		
		$('##modal_body_xl').load("modal_window_session_edit.cfm?f_id=#f_id#&tpmastercor_id="+tpmastercor_id);
	});
	</cfoutput>
	

	
})
</script>

</body>
</html>