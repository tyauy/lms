<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfquery name="get_session_category" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsession_category WHERE cat_public = 1
</cfquery>

<cfquery name="get_wefit_session" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 WHERE sessionmaster_cat_id <> 1
</cfquery>

<cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#">
SELECT fc.* 
FROM lms_formation_pack fc
WHERE fc.pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
</cfquery>

<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
SELECT sm.*, tc.sessionmaster_rank, tc.sessionmaster_schedule_duration, fc.* ,
c.cat_name_#SESSION.LANG_CODE# as cat_name
FROM lms_formation_pack fc
INNER JOIN lms_tpmaster2 tp ON fc.tpmaster_id = tp.tpmaster_id 
LEFT JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpsession_category c ON c.cat_id = sm.sessionmaster_cat_id AND c.cat_public = 1
WHERE tp.tpmaster_prebuilt = 1
AND fc.pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
</cfquery>

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, q.quiz_id, tp.* FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
WHERE tp.tpmaster_prebuilt = 0 AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation_pack.formation_id#">
ORDER BY tpmaster_rank ASC, tc.sessionmaster_group, tc.sessionmaster_rank, sm.module_id
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

<style>
.item {
    position:relative;
    /*padding-top:20px;*/
    display:inline-block;
}
.notify-badge{
    position: absolute;
    right:5%;
    top:80%;
    background:red;
    text-align: center;
    border-radius: 5px;
    color:white;
   /* padding:5px 10px;*/
    font-size:14px;
}
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}

.sidebar-outer {
    position: relative;
}
.fixed {
    position: fixed;
}
</style>	

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Catalogue de formation">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
		
			<cfif isdefined("k") AND k eq "1">
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em>Modifications effectu&eacute;es.</em></div>
			</div>
			</cfif>
			
			
			<div class="row">
				<div class="col-md-12">
					<div class="card mr-3">
						<cfoutput>
						<cfform action="updater_tppack.cfm" method="post" id="tp_build">
						<div class="card-body">
							<h6 class="card-title">Description TP</h6>
							<div class="float-right">								
								<a class="btn btn-sm btn-primary" data-toggle="collapse" href="##tppack_#pack_id#" role="button" aria-expanded="false" aria-controls="tppack_#pack_id#">+</a>
							</div>
							<div class="collapse" id="tppack_#pack_id#">
							<table class="table table-sm mt-2">										
								<tr>
									<td class="bg-light" width="10%">
										Intitul&eacute;
									</td>
									<td>
									<input type="text" class="form-control" name="pack_name" value="#get_formation_solo.pack_name#">
									</td>
								</tr>
								<tr>
									<td class="bg-light" width="10%">
										Obj
									</td>
									<td>
									<textarea class="form-control" name="pack_objectives">#get_formation_solo.pack_objectives#</textarea>
									</td>
								</tr>
								<tr>
									<td class="bg-light">
										R&eacute;sultats
									</td>
									<td>
									<textarea class="form-control" name="pack_results">#get_formation_solo.pack_results#</textarea>
									</td>
								</tr>
								<tr>
									<td class="bg-light">
										Contenus
									</td>
									<td>
									<textarea class="form-control" name="pack_content">#get_formation_solo.pack_content#</textarea>
									</td>
								</tr>
								<tr>
									<td class="bg-light">
										Dur&eacute;e
									</td>
									<td>
									<select class="form-control" name="pack_hour">
									<cfloop from="5" to="60" index="cor">
									<option value="#cor#" <cfif get_formation_solo.pack_hour eq cor>selected</cfif>>#cor# h</option>
									</cfloop>
									</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<input type="hidden" name="pack_id" value="#pack_id#">
										<input type="hidden" name="updt_tppack" value="1">
										<input type="submit" class="btn btn-info" value="Update description">
									</td>
								</tr>									
							</table>
							</div>
						</div>
			
						</cfform>
						</cfoutput>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-5">

					<div class="card mr-3">
						<div class="card-body">
							<div class="row">
								<div class="col">
								<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_add_lesson')#</cfoutput></h6>
								</div>
								<div class="col">
								<cfset user_needs_duration = "60">
								<select class="form-control" name="session_duration" id="session_duration">
									<!---F2F TRICK TO PREVENT BOOKING LESS THAN 1h FOR F2F --->

									<option value="30" <cfif user_needs_duration eq "30">selected</cfif>>30 min</option>
									<option value="45" <cfif user_needs_duration eq "45">selected</cfif>>45 min</option>
									<option value="60" <cfif user_needs_duration eq "60">selected</cfif>>1h</option>	
									<option value="75" <cfif user_needs_duration eq "75">selected</cfif>>1h15</option>
									<option value="90" <cfif user_needs_duration eq "90">selected</cfif>>1h30</option>
									<option value="105" <cfif user_needs_duration eq "105">selected</cfif>>1h45</option>
									<option value="120" <cfif user_needs_duration eq "120">selected</cfif>>2h</option>										
									
								</select>
								</div>
							</div>
							
							<div id="accordion">
								
								<div class="mt-2">
									<button class="btn btn-warning btn-block" data-toggle="collapse" data-target="#tp_0" aria-expanded="true" aria-controls="collapseOne">
									WEFIT LESSON
									</button>
								</div>
								<div id="tp_0" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
									<table class="table table-sm bg-white">
										<cfoutput query="get_wefit_session">
										<tr>	
											<td width="50"><img src="./assets/img/wefit_lesson.jpg"  alt="" width="40" /></td>
											<td width="20">
												<span style="cursor:pointer" class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#">?</span>
											</td>
											<td width="200" class="sessionmaster_title">#sessionmaster_name#</td>
											<td width="120"></td>
											<td align="right"><a href="##" class="btn btn-sm btn-primary add_line" id="STS_#sessionmaster_id#_#sessionmaster_cat_id#"><i class="fas fa-arrow-right"></i></a></td>
										</tr>	
										</cfoutput>
										
																					
									</table>
								</div>
								
								<cfoutput query="get_session_access" group="tpmaster_biglevel">
								
								<cfif tpmaster_biglevel eq "A">
									<cfset id_acc = "A">
									<cfset css = "success">
								<cfelseif tpmaster_biglevel eq "B">
									<cfset id_acc = "B">
									<cfset css = "info">
								<cfelseif tpmaster_biglevel eq "C">
									<cfset id_acc = "C">
									<cfset css = "danger">
								</cfif>
								
								<div>
									<button class="btn btn-#css# btn-block" data-toggle="collapse" data-target="##tcat_#id_acc#" aria-expanded="true">
									[ #obj_translater.get_translate('level')# #tpmaster_level# ]
									</button>
								</div>
								
								<div id="tcat_#id_acc#" class="collapse" aria-labelledby="headingOne" data-parent="##accordion">
								
								<cfoutput group="tpmaster_id">
								
									<div>
										<button class="btn btn-outline-#css# btn-block text-left" data-toggle="collapse" data-target="##tp_#tpmaster_id#" aria-expanded="true">
										[ #tpmaster_level# ] #tpmaster_name# 
										</button>
									</div>
									
									<div id="tp_#tpmaster_id#" class="collapse" aria-labelledby="headingOne" data-parent="##tcat_#id_acc#">

										<table class="table table-sm bg-white">
											<cfoutput group="sessionmaster_group">
											<cfif sessionmaster_group neq "">
											<tr>	
												<td colspan="9" class="bg-light font-weight-bold">#ucase(sessionmaster_group)#</td>
											</tr>
											</cfif>
											<cfoutput>
											<tr>	
												<!---<td width="50">
												<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>
													<img src="./assets/img_material/thumbs/#sessionmaster_code#.jpg"  alt="" width="40" />
												<cfelse>
													<img src="./assets/img/wefit_lesson.jpg"  alt="" width="40" />
												</cfif>
												</td>--->
												<td width="20">
												
												<cfif sessionmaster_rank neq "">
												<span class="badge badge-#css#">#sessionmaster_rank#</span>
												</cfif>
												</td>
												<td width="300" class="sessionmaster_title">
												#sessionmaster_name#
												</td>
												<td width="120">
												<small>#__text_about# #sessionmaster_duration# m</small>
												</td>
												<td>
												<i style="cursor:pointer" class="fas fa-book text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
												</td>
												<td>
												<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
												<i style="cursor:pointer" class="fas fa-volume-up text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
												</cfif>
												</td>
												<td>
												<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1">
												<i style="cursor:pointer" class="fas fa-video text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
												</cfif>
												</td>
												<td>
												<cfif quiz_id neq "">
												<i style="cursor:pointer" class="fas fa-tasks text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
												</cfif>
												</td>
												<td align="right">
												<a href="##" class="btn btn-sm btn-#css# add_line" id="STS_#sessionmaster_id#_#sessionmaster_cat_id#"><i class="fas fa-arrow-right"></i></a>
												</td>
											</tr>
											</cfoutput>
											</cfoutput>
										</table>
									</div>
									</cfoutput>
								</div>
								</cfoutput>						
							</div>
						
						</div>
					</div>
				</div>
		
				<cfform action="updater_tppack.cfm" method="post" id="tp_build">
				<div class="col-md-6 sidebar-outer">
				
					<div class="row">
					
						<div class="fixed col-md-6 ml-0">
						
							<div class="card mr-5">
								<div class="card-body">
									<div class="row">
										<div class="col-md-12">
											<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_program')#</cfoutput></h6>

											
											<br><br>
										
											<div class="input-group">
											<input type="text" class="form-control" disabled value="0" id="tp_duration" style="text-align:right; background-color:##FFFFFF; min-width:80px">
											<div class="input-group-append">

												<div id="pindic" class="input-group-text bg-warning text-white">&nbsp;&nbsp;<strong>/ xxxx h</strong></div>
										
											</div>
											</div>	
											<div class="progress" style="margin:0px; width:100%">	

												<div id="pbar" class="progress-bar progress-bar-striped bg-success progress-bar-animated" style="width:<cfoutput>15</cfoutput>%">
	
												</div>
											</div>	
			
											<div class="float-right">
											<input type="submit" class="btn btn-outline-success btn_saver" value="Sauvegarder">											
											</div>
											
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">		
											
											<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_details')#</cfoutput></h6>
											<div style="height:350px; overflow:auto; -ms-overflow-style:scrollbar;" id="div_content">
												<table id="table_tp" class="table table-sm mt-3" width="100%">
													<thead>
														<tr bgcolor="#F3F3F3">
															<th width="1%"></th>
															<th width="3%"><label>N&deg;</label></th>
															<th width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_course_type')#</cfoutput></label></th>
															<th width="10%"><label><cfoutput>#obj_translater.get_translate('table_th_duration_short')#</cfoutput></label></th>
															<th><label><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></label></th>
															<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
															<th width="12%"></th>
														</tr>
													</thead>
													<tbody id="tbody_sortable">
													<cfif get_formation_pack.recordcount neq "0">
													
														<cfoutput query="get_formation_pack">
														
														<!---<tr class="unsortable bg-light" id="tr_#session_rank#">--->

														<tr id="tr_#sessionmaster_rank#">
															<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>
														
															<td>	
																<h5 class="d-inline"><span class="badge badge-pill badge-secondary">#sessionmaster_rank#</span></h5>
															</td>
															<td>
																<small>#cat_name#</small>
															</td>
															<td>
																<small>#sessionmaster_schedule_duration# min</small>
															</td>
															<td>									
																#sessionmaster_name#
															</td>
															<td>

																	
																	<a id="r_#sessionmaster_rank#_#sessionmaster_schedule_duration#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>
																	
																
																<!---<input type="hidden" class="session_final_rank" name="S_#session_id#" value="#session_rank#_#sessionmaster_id#_#session_duration#_#cat_id#_#session_rank#">--->
															</td>
														</tr>
														
														<tr class="unsortable bg-light last_tr"></tr>
														
														</cfoutput>
													<cfelse>
														<tr class="unsortable bg-light last_tr" id="tr_0"></tr>
													</cfif>
													
													
													</tbody>
												</table>
										</div>
									</div>
										
								</div>
									
							</div>	
						</div>
					</div>
				</div>
			</div>
			<!---<cfoutput>
			<input type="hidden" name="t_id" value="#t_id#">
			<input type="hidden" name="u_id" value="#u_id#">
			</cfoutput>
			<input type="hidden" name="updt_tp" value="1">--->
			</cfform>
		</div>
			
		
	</div>
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>
$(document).ready(function() {
	

    $('#tbody_sortable').sortable({
		items: "tr:not(.unsortable)",
		update: function(e, ui) {
			$("tr td:nth-child(2)").empty();
			reorder();			
		}
	});
	$("#tbody_sortable").disableSelection();
	
	
	$(".btn_remove_line").bind("click",remove_line);
	 
	function param_attach(event) {

		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Attacher cours");
		$('#modal_body_lg').load("modal_window_syllabus.cfm?s_id="+idtemp, function() {
		
		});
		
	}
	
	<!---
	total_duration = <cfoutput>#get_tp.tp_duration#</cfoutput>;
	<cfif tp_session_duration neq "0">
	counter = <cfoutput>#get_session.session_rank[get_session.recordcount]#</cfoutput>;
	<cfelse>
	counter = 1;
	</cfif>
	total_booked = <cfoutput>#tp_session_duration#</cfoutput>;
	
	
	function calculate()
		{
			$(".session_duration").each(function( index ) {
			  console.log( index + ": " + $( this ).val() );
			});	
		}
		
	$( ".session_duration" ).change(function() {
	  calculate()
	});
	
	
	function reorder()
	{
		$("#table_tp tr td:nth-child(2)").empty();
		$("#table_tp tr td:nth-child(2)").html(function() {
			return '<h5 class="d-inline"><span class="badge badge-pill badge-secondary">'+$(this).parent().index("#table_tp tr")+'</span></h5>';
		});
		
		$("#table_tp tr td:nth-child(2)").each(function( index ) {
			var valtemp = $(this).parent().find(".session_final_rank").val();
			/*alert(valtemp);*/
			var valtemp = valtemp.split("_");
			var idgo = valtemp[0];		
			var durtemp = valtemp[1];
			var sessiomaster_id = valtemp[2];	
			var session_cat = valtemp[3];
			var session_rank = $(this).parent().index("#table_tp tr");
			
			$(this).parent().find(".session_final_rank").val(idgo+"_"+durtemp+"_"+sessiomaster_id+"_"+session_cat+"_"+session_rank)
			
			/*console.log($(this).parent().find(".session_final_rank").val());*/
		});	
	}		
			
	function remove_line()
	{		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idgo = idtemp[1];		
		var durtemp = idtemp[2];

		/*alert(idgo);*/
		$("#tr_"+idgo).remove();
		total_booked -= parseInt(durtemp);
		var total_booked_hour = parseFloat(total_booked/60);
		$("#tp_duration").val(total_booked_hour);
		var pource = (+total_booked/+total_duration)*100;
		$("#pbar").css('width', pource+'%');
		
		if($(".session_adder").hasClass("d-none")){$(".session_adder").toggleClass("d-none");};
		
		
		if($(".btn_saver").hasClass("btn-info")){$(".btn_saver").removeClass("btn-info").addClass("btn-success");};
		/*$(".btn_saver").val("Sauvegarde temporaire");*/
		
		/*if(!$(".session_saver").hasClass("d-none")){$(".session_saver").toggleClass("d-none");};*/
		
		if($("#pbar").hasClass("bg-success")){$("#pbar").toggleClass("bg-success");$("#pbar").toggleClass("bg-warning");};
		if($("#pindic").hasClass("bg-success")){$("#pindic").toggleClass("bg-success");$("#pindic").toggleClass("bg-warning")};
		
		reorder();

	}

	
	$(".add_line").on('click', function () {
	
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var sessionmaster_id = idtemp[1];		
	var sessionmaster_cat_id = idtemp[2];
	
	/*alert(sessionmaster_id);
	alert(sessionmaster_cat_id);*/
	
	var valtemp = $(this).parent().parent().find(".sessionmaster_title").text();

	
	var session_duration = $("#session_duration").val();
	/*var session_type = $("#session_type").val();*/
	total_booked += parseInt(session_duration);
	
	if(total_booked == total_duration)
	{
		$(".session_adder").toggleClass("d-none");
		/*$(".session_saver").toggleClass("d-none");*/
		
		/*$(".btn_saver").val("Finaliser TP"); */
		
		
		$("#pbar").toggleClass("bg-warning");
		$("#pbar").toggleClass("bg-success");
		$("#pindic").toggleClass("bg-warning");
		$("#pindic").toggleClass("bg-success");
	}
	if(total_booked > total_duration)
	{
		alert("<cfoutput>#obj_translater.get_translate('js_book_credential')#</cfoutput>");
		total_booked -= parseInt(session_duration);
	}
	else{
		var test = document.getElementById("div_content").scrollHeight+500;
		
		$("#div_content").scrollTop(test);
		
		var total_booked_hour = parseFloat(total_booked/60);
		$("#tp_duration").val(total_booked_hour);
		
		counter ++;
		
		var pource = (+total_booked/+total_duration)*100;

		/******************* CONSTRUCT LINE TO ADD *************/
		var liner = '<tr id="tr_'+counter+'">';
		
		liner += '<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>';		
		liner += '<td><h5 class="d-inline"><span class="badge badge-pill badge-secondary">'+counter+'</span></h5></td>';
		
		<!----liner += '<td><select class="form-control"><cfoutput query="get_session_type"><option value="#tpsessiontype_id#">#tpsessiontype_name#</option></cfoutput></select></td>';--->
		
		<!---if(session_type == "1")
		{liner += '<td><select class="form-control"><option value="1" selected>Cours structur&eacute;</option><option value="2">Open lesson</option><option value="3">Workshop</option></select></td>';}
		else if(session_type == "2")
		{liner += '<td><select class="form-control"><option value="1">Cours structur&eacute;</option><option value="2" selected>Open lesson</option><option value="3">Workshop</option></select></td>';}
		else
		{liner += '<td><select class="form-control"><option value="1">Cours structur&eacute;</option><option value="2">Open lesson</option><option value="3" selected>Workshop</option></select></td>';}
		
		if(session_duration == "30")
		{liner += '<td><select id="d_'+counter+'_'+session_duration+'" class="form-control session_duration"><option value="30" selected>30 min</option><option value="45">45 min</option><option value="60">60 min</option></select></td>';}
		else if(session_duration == "45")
		{liner += '<td><select id="d_'+counter+'_'+session_duration+'" class="form-control session_duration"><option value="30">30 min</option><option value="45" selected>45 min</option><option value="60">60 min</option></select></td>';}
		else
		{liner += '<td><select id="d_'+counter+'_'+session_duration+'" class="form-control session_duration"><option value="30">30 min</option><option value="45">45 min</option><option value="60" selected>60 min</option></select></td>';}
		--->
		
		<!---if(session_type == "1")
		{
			liner += '<td>Cours structur&eacute;</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_0_'+session_duration+'_'+session_type+'_'+counter+'">';
		}
		else if(session_type == "2")
		{
			liner += '<td>Open lesson</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td><select id="sel_'+counter+'" class="form-control session_select"><option value="696" selected>Open lesson</option></select></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_696_'+session_duration+'_'+session_type+'_'+counter+'">';
		
		}
		else
		{
			liner += '<td>Workshop</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td><select id="sel_'+counter+'" class="form-control session_select"><option value="697" selected>Workshop</option></select></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_697_'+session_duration+'_'+session_type+'_'+counter+'">';
		}--->
	
		
		if(sessionmaster_cat_id == "1")
		{
			liner += '<td>Cours structur&eacute;</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td>'+valtemp+'</td>';
			liner += '<td></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_'+sessionmaster_id+'_'+session_duration+'_'+sessionmaster_cat_id+'_'+counter+'">';
		}
		else if(sessionmaster_cat_id == "2")
		/****** OPEN *******/
		{
			liner += '<td>Open lesson</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td>'+valtemp+'</td>';
			liner += '<td></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_'+sessionmaster_id+'_'+session_duration+'_'+sessionmaster_cat_id+'_'+counter+'">';
		}
		else if(sessionmaster_cat_id == "3")
		/****** WORKSHOP *******/
		{
			liner += '<td>Workshop</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td>'+valtemp+'</td>';
			liner += '<td></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_'+sessionmaster_id+'_'+session_duration+'_'+sessionmaster_cat_id+'_'+counter+'">';
		}
		
		else if(sessionmaster_cat_id == "4")
		/****** NA /PTA *******/
		{
			liner += '<td>Wefit lesson</td>';
			liner += '<td>'+session_duration+' min</td>';
			liner += '<td>'+valtemp+'</td>';
			liner += '<td></td>';
			liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
			liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_'+sessionmaster_id+'_'+session_duration+'_'+sessionmaster_cat_id+'_'+counter+'">';
		}
			
		
		liner += '</tr>';
				
		$(".last_tr").before(liner);
				
		$("#pbar").css('width', pource+'%');
		
		$("#s_"+counter+"_"+session_duration).bind("click",param_attach);
		$("#r_"+counter+"_"+session_duration).bind("click",remove_line);
		/*$("#d_"+counter+"_"+session_duration).bind("change",calculate);*/
		
		$("#sel_"+counter).bind("change",attach_sessionmaster_id);
	
		reorder();
			
	}
	});

	function attach_sessionmaster_id()
	{
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idgo = idtemp[1];
		
		var sessionmaster_id = $(this).val();
		
		
		
		/* RECONSTRUCT */
		var idtemp2 = $("#STC_"+idgo).val();
		var idtemp2 = idtemp2.split("_");
			
		var durtemp = idtemp2[2];
		var session_cat = idtemp2[3];
		var session_rank = idtemp2[4];
		/*var durtemp = idtemp[2];*/
		/*alert(idgo);
		alert(durtemp);*/
		/*alert(session_cat);*/
		
		$("#STC_"+idgo).val(idgo+"_"+sessionmaster_id+"_"+durtemp+"_"+session_cat+"_"+session_rank);
		
	}
	
	$("#tp_build").submit(function( event ) {
	
		$(".session_select").each(function( index ) {
			if($(this).val() == 0)
			{
				event.preventDefault();
				alert("Au moins un cours structur\u00e9 n'\est pas renseign\u00e9.");
				return false;
			}
		});

	});--->
	
})
</script>

</body>
</html>