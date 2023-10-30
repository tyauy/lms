<cfsilent>

<cfquery name="get_lesson_method" datasource="#SESSION.BDDSOURCE#">
SELECT method_id, method_name_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method
</cfquery>


<cfquery name="get_lesson_type" datasource="#SESSION.BDDSOURCE#">
SELECT type_id, type_name_#SESSION.LANG_CODE# as type_name FROM lms_lesson_type <!---WHERE FIND_IN_SET("#SESSION.USER_PROFILE_ID#",profile_id)--->
</cfquery>


<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_name FROM user WHERE profile_id = 3
<cfif isdefined("lesson_id")>AND user_id NOT IN (
	SELECT u.user_id FROM lms_lesson s
	INNER JOIN lms_lesson_participant sp ON sp.lesson_id = s.lesson_id
	INNER JOIN user u ON u.user_id = sp.user_id
	WHERE s.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
)
</cfif>
</cfquery>

<cfquery name="get_planner" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_name FROM user WHERE profile_id = 4
</cfquery>

<cfif isdefined("lesson_id")>

	<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT pl.user_firstname as planner_contact, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, l.planner_id, l.status_id, sm.sessionmaster_name, tm.module_name, sm.sessionmaster_vocabulary, sm.sessionmaster_grammar, sm.sessionmaster_objectives, s.session_id, l.lesson_id, l.type_id, l.method_id, l.lesson_start, l.lesson_end, m.method_name_#SESSION.LANG_CODE# as method_name, st.status_name_#SESSION.LANG_CODE# as status_name, st.status_css, t.type_name_#SESSION.LANG_CODE# as type_name 
	FROM lms_lesson l
	
	INNER JOIN lms_lesson_type t ON t.type_id = l.type_id
	INNER JOIN lms_lesson_method m ON m.method_id = l.method_id
	INNER JOIN lms_lesson_status st ON st.status_id = l.status_id
	INNER JOIN lms_tpsession s ON l.session_id = s.session_id
	LEFT JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_tpmodulemaster tm ON tm.module_id = sm.module_id
	
	INNER JOIN user u ON l.user_id = u.user_id
	INNER JOIN user pl ON l.planner_id = pl.user_id
	
	WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
	</cfquery>
	
	<!---<cfdump var="#get_lesson#">
	
	<cfabort>--->
	
	<cfquery name="get_material_session" datasource="#SESSION.BDDSOURCE#">
	SELECT m.material_url, m.material_type, sm.sessionmaster_objectives, sm.sessionmaster_id, sm.sessionmaster_name
	FROM lms_tpsessionmaster sm
	INNER JOIN lms_tpsession s ON s.sessionmaster_id = sm.sessionmaster_id
	LEFT JOIN lms_material m ON m.sessionmaster_id = s.sessionmaster_id
	WHERE s.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.session_id#">
	</cfquery>
	
	<cfquery name="get_material_custom" datasource="#SESSION.BDDSOURCE#">
	SELECT m.material_url, m.material_type
	FROM lms_material m WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.session_id#">
	</cfquery>

	<cfoutput query="get_lesson" group="lesson_id">
		<cfset status_id = status_id>
		<cfset planner_id = planner_id>
		<cfset module_name = module_name>
		<cfset method_name = method_name>
		
		<cfset planner_contact = planner_contact>		
		<cfset user_contact = user_contact>
		
		<cfset status_name = status_name>
		<cfset status_css = status_css>
		<cfset type_name = type_name>
		<cfset type_select = type_id>
		<cfset method_select = method_id>
		<cfset lesson_start = lesson_start>
		<cfset lesson_end = lesson_end>	
		<cfset sessionmaster_name = sessionmaster_name>	
		<cfset sessionmaster_vocabulary = sessionmaster_vocabulary>	
		<cfset sessionmaster_grammar = sessionmaster_grammar>	
		<cfset sessionmaster_objectives = sessionmaster_objectives>	
	</cfoutput>
	
<cfelse>

	<cfparam name="type_select" default="1">
	<cfparam name="method_select" default="1">
	<cfparam name="lesson_status" default="scheduled">

	<cfif isdefined("start")>
		<cfset lesson_start = "#listgetat(start,1,'_')# #replace(listgetat(start,2,'_'),'-',':','ALL')#">
	<cfelse>
		<cfset lesson_start = dateformat(now(), 'dd-mm-yyyy 08:00:00')>
	</cfif>
	
	<cfif isdefined("end")>
		<cfset lesson_end = "#listgetat(end,1,'_')# #replace(listgetat(end,2,'_'),'-',':','ALL')#">
	<cfelse>
		<cfset lesson_end = dateformat(now(), 'dd-mm-yyyy 09:00:00')>
	</cfif>	
	
</cfif>	
</cfsilent>
<cfform action="updater_lesson.cfm">

<ul class="nav nav-tabs" id="tabs_lesson" role="tablist">
	<cfif isdefined("lesson_id")><li role="presentation" id="title_resume" class="active"><a href="#resume" class="nav-link <cfif not isdefined("lesson_id")>active</cfif>" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('tab_title_summary')#</cfoutput></a></li></cfif>
	<li class="nav-item" id="title_lesson"><a class="nav-link" href="#param" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('tab_title_edit')#</cfoutput></a></li>
	<li class="nav-item" id="title_material" <cfif not isdefined("lesson_id")>class="disabled"</cfif>><a class="nav-link" href="#material" role="tab" <cfif isdefined("lesson_id")>data-toggle="tab"</cfif>><cfoutput>#obj_translater.get_translate('tab_title_content')#</cfoutput></a></li>
	<li class="nav-item" id="title_notes" <cfif not isdefined("lesson_id")>class="disabled"</cfif>><a class="nav-link" href="#notes" role="tab" <cfif isdefined("lesson_id")>data-toggle="tab"</cfif>><cfoutput>#obj_translater.get_translate('tab_title_notes')#</cfoutput></a></li>
	<li class="nav-item" id="title_location"><a class="nav-link" href="#location" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('tab_title_location')#</cfoutput></a></li>
	<li class="nav-item" id="title_alert" <cfif not isdefined("lesson_id")>class="disabled"</cfif>><a class="nav-link" href="#alert" aria-controls="alert" role="tab" <cfif isdefined("lesson_id")>data-toggle="tab"</cfif>><cfoutput>#obj_translater.get_translate('tab_title_warning')#</cfoutput></a></li>
	<li class="nav-item" id="title_signature" <cfif not isdefined("lesson_id") OR status_id neq "5">class="disabled"</cfif>><a class="nav-link" href="#sign" class="btn_signature" aria-controls="alert" role="tab" <cfif isdefined("lesson_id")>data-toggle="tab"</cfif>>Signature</a></li>

		
	<!---<li role="presentation" id="title_relation"><a href="#relation" aria-controls="relation" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('tab_title_participant')#</cfoutput></a></li>--->
	
	
</ul>

<div class="tab-content">

	<cfif isdefined("lesson_id")>
	<cfoutput>
	<div role="tabpanel" class="tab-pane in active" id="resume">	
		<div class="row">
			<div class="col-md-6" style="margin-top:25px">
				<table class="table table-sm">					
					
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_th_status')#</strong> 
						</td>
						<td>
							<span class="badge badge-#status_css#">#status_name#</span>
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_th_trainer')#</strong>
						</td>
						<td>
							#obj_lms.get_thumb(user_id="#planner_id#",size="20")# #planner_contact#
						</td>
					</tr>
					<tr>
						<td>
							<strong>Session</strong>
						</td>
						<td>
							#sessionmaster_name#
						</td>
					</tr>
					<tr>
						<td>
							<strong>Module</strong>
						</td>
						<td>
							#module_name#
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_th_method')#</strong>
						</td>
						<td>
							#method_name#
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_th_type')#</strong>
						</td>
						<td>
							#type_name#
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_header_participant')#</strong>
						</td>
						<td>
							#user_contact#
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_th_date')#</strong>
						</td>
						<td>
							#dateformat(lesson_start,'dd/mm/yyyy')#
						</td>
					</tr>
					<tr>
						<td>
							<strong>#obj_translater.get_translate('table_header_length')#</strong>
						</td>
						<td>
							#timeformat(lesson_start,'HH:mm')# - #timeformat(lesson_end,'HH:mm')#
						</td>
					</tr>
				</table>

			</div>
			
			<div class="col-md-6" style="margin-top:25px">
				<table class="table">
					<tr>
						<td>
							<strong>Mail sent :</strong> 
						</td>
						<td>
							<span class="label label-success">ok</span>
						</td>
					</tr>
					<tr>
						<td>
							<strong>SMS sent :</strong> 
						</td>
						<td>
							<span class="label label-danger">not ok</span>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Lesson notes :</strong> 
						</td>
						<td>
							<span class="label label-success">ok</span>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Presence confirmed :</strong> 
						</td>
						<td>
							<span class="label label-success">ok</span>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Material attached :</strong> 
						</td>
						<td>
							<span class="label label-danger">not ok</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</cfoutput>
	</cfif>
	
	<div role="tabpanel" class="tab-pane <cfif not isdefined("lesson_id")> in active</cfif>" id="param">		
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
			
				<table class="table" align="center">
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_th_method')#</cfoutput></strong></td> 
						<td colspan="2">						
						<cfloop query="get_lesson_method">
						<cfoutput><input id="m_#get_lesson_method.method_id#" type="radio" name="method_id" value="#get_lesson_method.method_id#" <cfif get_lesson_method.method_id eq method_select> checked="checked"</cfif>> <label for="m_#get_lesson_method.method_id#">#get_lesson_method.method_name#</label></cfoutput>
						</cfloop>
						</td>
					</tr> 
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_th_session_type')#</cfoutput></strong></td> 
						<td colspan="2">						
						<cfselect name="type_id" query="get_lesson_type" display="type_name" value="type_id" selected="#type_select#" class="form-control"></cfselect>
						</td>
					</tr> 
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></strong></td> 
						<td>
							<div class="controls">
								<div class="input-group">
									<cfoutput>
									<input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" value="#dateformat(lesson_start,'dd/mm/yyyy')#" />
									<label for="date_schedule_from" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
									</cfoutput>
								</div>
							</div>
						</td>
						<td>
							<select name="hour_schedule_from" id="hour_schedule_from" class="form-control">
							<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
							<cfoutput>
							<option value="#hour#" <cfif hour eq timeformat(lesson_start,'H:mm')>selected="selected"</cfif>>#hour#</option>
							</cfoutput>
							</cfloop>
							</select>
						</td>
					</tr> 
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_th_end')#</cfoutput></strong></td> 
						<td>
							<div class="controls">
								<div class="input-group">
									<cfoutput>
									<input id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" value="#dateformat(lesson_end,'dd/mm/yyyy')#" />
									<label for="date_schedule_to" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
									</cfoutput>
								</div>
							</div>
						</td>
						<td>
							<select name="hour_schedule_to" id="hour_schedule_to" class="form-control">--->#lesson_end#
							<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
							<cfoutput>
							<option value="#hour#" <cfif hour eq timeformat(lesson_end,'H:mm')>selected="selected"</cfif>>#hour#</option>
							</cfoutput>
							</cfloop>
							</select>
						</td>
					</tr> 
				</table>			
			</div>		
		</div>
	</div>
	
	<cfif isdefined("lesson_id")>
	<div role="tabpanel" class="tab-pane" id="material">		
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
				<table class="table">
					<tbody>		
						<tr bgcolor="#F3F3F3">
							<th colspan="2">Description</th>
						</tr>
						<cfoutput>
						<tr>
							<td width="20%">Intitul&eacute;</td>
							<td>#sessionmaster_name#</td>
						</tr>
						<tr>
							<td>Module</td>
							<td>#module_name#</td>
						</tr>
						<tr>
							<td>Objectif p&eacute;dagogiques</td>
							<td>#sessionmaster_objectives#</td>
						</tr>
						<tr>
							<td>Grammaire</td>
							<td>#sessionmaster_grammar#</td>
						</tr>
						<tr>
							<td>Vocabulaire</td>
							<td>#sessionmaster_vocabulary#</td>
						</tr>
						</cfoutput>						
						<tr bgcolor="#F3F3F3">
							<th>Type</th>
							<th>Ressource Session</th>
						</tr>
						<cfoutput query="get_material_session">
						<tr>
							<td align="center">#obj_lms.get_icon_file(material_url)#</td>
							<td>#material_url#</td>
						</tr>						
						</cfoutput>
						<tr bgcolor="#F3F3F3">
							<th>Type</th>
							<th>Ressource Personnalis&eacute;es</th>
						</tr>
						<cfoutput query="get_material_custom">
						<tr>
							<td>#obj_lms.get_icon_file(material_url)#</td>
							<td>#material_url#</td>
						</tr>						
						</cfoutput>
					</tbody>
				</table>
			
			</div>
		</div>
	</div>
	</cfif>
	
	<div role="tabpanel" class="tab-pane" id="notes">		
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
			
				<table class="table" align="center">
					<tr> 
						<td><strong>Grammar Notes</strong></td> 
						<td>					
<textarea class="form-control">

</textarea>
						</td>
					</tr> 
					<tr> 
						<td><strong>Vocabulary Notes</strong></td> 
						<td>				
<textarea class="form-control">

</textarea>
						</td>
					</tr> 
					<tr> 
						<td><strong>Instructor's feedback</strong></td> 
						<td>
<textarea class="form-control">

</textarea>
						</td>
					</tr> 
			
				</table>
			
			
			
			</div>
		</div>
	</div>
	
	<div role="tabpanel" class="tab-pane" id="location">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
				<table class="table table-condensed" align="center">
					<tr>
						<td><strong><cfoutput>#obj_translater.get_translate('table_header_location')#</cfoutput></strong></td> 
						<td>
						<select class="form-control">
						<option>Location 1</option>
						</select>
						</td>
					</tr> 
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_header_address')#</cfoutput></strong></td> 
						<td>
						<input type="text" name="end" class="form-control" placeholder="<cfoutput>#obj_translater.get_translate('placeholder_address')#</cfoutput>">
						</td>
					</tr> 
					<tr> 
						<td><strong><cfoutput>#obj_translater.get_translate('table_header_info')#</cfoutput></strong></td> 
						<td>
						<input type="text" name="end" class="form-control" placeholder="<cfoutput>#obj_translater.get_translate('placeholder_complement_info')#</cfoutput>">		
						</td>
					</tr> 
				</table>
			</div>
		</div>
	</div>
	
	<div role="tabpanel" class="tab-pane" id="alert">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
				<table class="table">
					<tr>
						<td>
							<strong>Send Reminder</strong> 
						</td>
						<td>
							<button class="btn btn-default">Send Email</button>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Send SMS</strong> 
						</td>
						<td>
							<button class="btn btn-default">Send SMS</button>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Confirm presence</strong> 
						</td>
						<td>
							<button class="btn btn-default">Send Email</button>
						</td>
					</tr>
					<tr>
						<td>
							<strong>Send Attendance sheet</strong> 
						</td>
						<td>
							<button class="btn btn-default">Send Email</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<cfif isdefined("lesson_id") AND status_id eq "5">
	<div role="tabpanel" class="tab-pane" id="sign">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">
				<table>
					<tr>
						<td colspan="2">
						<h6><cfoutput>#obj_translater.get_translate_complex('sign_after_course')#</cfoutput></h6>
						<br>
						<div id="content" style="border:1px solid #000000"><div id="signatureparent"><div id="signature"></div></div><div id="tools"></div></div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</cfif>

	<!---<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<a href="lesson_update.cfm?del=1&lesson_id=#lesson_id#" class="btn btn-default">Annuler</a>
	<button class="btn btn-default">Valider r&eacute;servation</button>
	<button class="btn btn-default">Supprimer</button>
	<button class="btn btn-default">Envoyer notification</button>--->
	
	<cfif isdefined("lesson_id")>
	<input type="hidden" name="lesson_updt" value="1">
	<cfoutput><input type="hidden" name="lesson_id" value="#lesson_id#"></cfoutput>
	<input type="hidden" name="signature_base64" id="signature_base64" value="">
	<cfelse>
	<input type="hidden" name="lesson_ins" value="1">
	
	</cfif>
	<input type="submit" class="btn btn-success" value="Enregistrer">
	</button>
	
</div>
</cfform>
<style>
	/* Drawing the 'gripper' for touch-enabled devices */ 
	html.touch #content {
		float:left;
		width:92%;
	}
	html.touch #scrollgrabber {
		float:right;
		width:4%;
		margin-right:2%;
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAFCAAAAACh79lDAAAAAXNSR0IArs4c6QAAABJJREFUCB1jmMmQxjCT4T/DfwAPLgOXlrt3IwAAAABJRU5ErkJggg==)
	}
	html.borderradius #scrollgrabber {
		border-radius: 1em;
	}
</style>

<script>
$(function() {



	$( "#date_schedule_from" ).datepicker({
	  defaultDate: "+1w",
	  changeMonth: true,
	  dateFormat:"dd/mm/yy",
	  numberOfMonths: 3,
	  onClose: function( selectedDate ) {
		$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
	  }
	});
	$( "#date_schedule_to" ).datepicker({
	  defaultDate: "+1w",
	  changeMonth: true,
	  dateFormat:"dd/mm/yy",
	  numberOfMonths: 3,
	  onClose: function( selectedDate ) {
		$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
	  }
	});	
	

	function go_line(id,label) {		
		/******************* CONSTRUCT LINE TO ADD *************/
		var liner = '<button class="btn btn-default btn-sm"><img src="../img/unknown.jpg" class="img-circle" width="30"> ';
		liner += label;
		liner += '</button>';
		liner += '<input type="hidden" name="participant_id" value="'+id+'">';		
		$('#participant_pool').append(liner);
		/*$(".btn_number_"+counter).on("click", {event}, go_increment);
		$(".input-number_"+counter).on("focusin", {event}, go_focus);
		$(".input-number_"+counter).on("change", {event}, go_change);*/	
	}
	
	function sup_line(id) {		
		$(".tr_"+id).remove();
	}
	
	$('.btn_remove_line').on('click', function(evt, item) {
		sup_line($(this).attr("id"));
	})
   
   
	function go_line_participant(id,label) {		
		/******************* CONSTRUCT LINE TO ADD *************/
		
		$.ajax({		
			data : "user_id="+id,
			url : 'get_datainfo.cfm',
			type : 'POST',
			dataType : 'html',		
			success : function(html_return, statut){	
				var json_obj = $.parseJSON(html_return);
				var liner = '<tr class="tr_'+json_obj[0].USER_ID+'"><td width="20">';
				liner += '</td><td>';
				liner += json_obj[0].USER_NAME;
				liner += '</td><td>';
				
				/***********GESTION DES ABO*************/
				liner += '<select name="sub_'+json_obj[0].USER_ID+'" class="input-sm form-control">';				
				$.each(json_obj[0].USER_ABO, function( index, value ) {
					liner += '<option value="'+value[0]+'">'+value[1]+'</option>';
				});
				liner += '</select>';
				/*********FIN ABO ********************/
				
				liner += '</td><td>';
				
				/***********GESTION DES TP*************/
				liner += '<select name="tp_'+json_obj[0].USER_ID+'" class="input-sm form-control">';				
				$.each(json_obj[0].USER_TP, function( index, value ) {
					liner += '<option value="'+value[0]+'">'+value[1]+'</option>';
				});
				liner += '</select>';
				/*********FIN TP ********************/
				
				liner += '</td><td>';
				liner += '<a class="btn btn-xs btn-default btn_remove_line" id="'+json_obj[0].USER_ID+'"><span class="glyphicon glyphicon-remove"></span></a><input type="hidden" name="participant_id" value="'+json_obj[0].USER_ID+'">';
				liner += '</td></tr>';
				
				$('#participant_pool tr:last').after(liner);
				
				/************ RETTRIBUTE ACTION *************/
				$('.btn_remove_line').on('click', function(evt, item) {
					sup_line($(this).attr("id"));
				})
				
				$.ajax({
					<cfoutput>
					url:'#SESSION.BO_ROOT_URL#/sources/#SESSION.MASTER_ID#/'+json_obj[0].USER_ID+'/photo.jpg',
					type:'HEAD',
					error: function()
					{
						thumb = '<img src="../img/unknown.jpg" class="img-circle" width="30">';
						$('.tr_'+json_obj[0].USER_ID+' td:first').append(thumb);
					},
					success: function()
					{
						thumb = '<img src="./sources/1/'+json_obj[0].USER_ID+'/photo.jpg" class="img-circle" width="30">';	
						$('.tr_'+json_obj[0].USER_ID+' td:first').append(thumb);						
					}
					</cfoutput>
				});

				
				
			}
		});	
		
		
		
		/*$(".btn_number_"+counter).on("click", {event}, go_increment);
		$(".input-number_"+counter).on("focusin", {event}, go_focus);
		$(".input-number_"+counter).on("change", {event}, go_change);*/	
	}
	
	/*$("#add_line").on('click', go_line);	*/
		

/*var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substringRegex;

    // an array that will be populated with substring matches
    matches = [];

    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');

    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
      if (substrRegex.test(str)) {
        matches.push(str);
      }
    });

    cb(matches);
  };
};*/


var participant = [
	<cfoutput query="get_learner">
	{"id":#user_id#,"label":"#user_firstname# #user_name#"}<cfif currentrow neq recordcount>,</cfif>
	</cfoutput>
	]
;
var planner = [
	<cfoutput query="get_planner">
	{"id":#user_id#,"label":"#user_firstname# #user_name#"}<cfif currentrow neq recordcount>,</cfif>
	</cfoutput>
	]
;

		
/*$('.search_participant_container .typeahead').typeahead({
		hint: true,
		highlight: true,
		minLength: 1
	},
	{
		source: function(query, process) {
		objects = [];
		map = {};
		var data = participant;
		$.each(data, function(i, object) {
			map[object.label] = object;
			objects.push(object.label);
		});
	process(objects);
	},
	updater: function(item) {
		$('hiddenInputElement').val(map[item].id);
		return item;
	}}
);*/

/*$('.typeahead').on('typeahead:selected', function(evt, item) {
	go_line_participant(map[item].id,map[item].label);   
	$('.search_participant_container .typeahead').typeahead('val','');   
   
})*/


	$('.btn_signature').click(function(event) {		
		event.preventDefault();
		$("#signature").jSignature({'UndoButton':true});
		$("#signature").resize();
		$(this).unbind( "click" );
	});
	
	$("#sigform").submit(function( event ) {
		var data = $sigdiv.jSignature('getData', 'default');
		$('#signature_base64').val(data);
	});	
	
});
</script>