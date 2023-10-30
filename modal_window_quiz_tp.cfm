<cfquery name="get_tp_quiz" datasource="#SESSION.BDDSOURCE#">
	SELECT lqu.quiz_user_end, l.tp_id, l.tp_date_end, lqut.type,
	l.tp_rank, f.formation_code, l.method_id, l.tp_duration, tpe.elearning_name, l.elearning_duration, l.tp_name, tpc.certif_name
	FROM  lms_quiz_user lqu
	INNER JOIN lms_quiz_user_tp lqut ON lqut.quiz_user_group_id = lqu.quiz_user_group_id 
	INNER JOIN lms_tp l on l.tp_id = lqut.tp_id
	LEFT JOIN lms_formation f ON f.formation_id = l.formation_id
	LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = l.elearning_id
	LEFT JOIN lms_list_certification tpc ON tpc.certif_id = l.certif_id
	WHERE lqu.quiz_user_group_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	AND lqu.user_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	GROUP BY lqu.quiz_user_group_id, lqut.type
</cfquery>
<!--- 53308 - 11975 --->
<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",o_by="id",m_id="1,2,9")>

<div>
					
	<div class="row">
	
		<div class="col-md-12">
			<form method="post" id="form_tp_quiz" name="form_tp_quiz" onsubmit="return submit_form_tp_quiz();">
			<table class="table table_tp_quiz border bg-white">
				<tr style="background-color:#ECECEC">
					<td colspan="2">
						<cfoutput>#obj_translater.get_translate('table_th_assignement')#</cfoutput>
					</td>
					<td> </td>
					<td>
						<cfoutput>DEST</cfoutput>
					</td>
					<td>
						<cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput>							
					</td>
				</tr>
				<cfoutput>
					<!--- ! --->
				<cfloop query="get_tp_quiz">
					<tr class="tp_quiz_#tp_id#">
						<td width="70%" colspan="2">
							#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
							- DEADLINE #lsDateFormat(tp_date_end,'yyyy-mm-dd', 'fr')#
						</td>
						<td> </td>
						<td width="20%">
							<span style="text-transform:uppercase">#type#</span>
						</td>
						<td width="10%" align="center">
							<button type="button" class="btn btn-sm btn-outline-info btn_remove_tp_quiz" id="del_tp_#tp_id#_#type#"><i class="fal fa-trash-alt"></i></button>
						</td>
					</tr>
				
				</cfloop>	
				</cfoutput>
				<tr class="table-info last_tr_tp_quiz">
				
					<td colspan="2">
						<select class="form-control" name="tp_quiz_id">
						<option value="">--Select--</option>
						<cfoutput query="get_tps">
						<option value="#tp_id#">
							#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
							- DEADLINE #lsDateFormat(tp_date_end,'yyyy-mm-dd', 'fr')#
						</option>
						</cfoutput>
						</select>
					</td>
					<td colspan="2">
						<select class="form-control" name="type">
							<option value="start">Start</option>
							<option value="end">End</option>
						</select>
					</td>
					<td>
						<input type="hidden" name="q_id" value="<cfoutput>#quiz_id#</cfoutput>">
						<input type="submit" class="btn btn-sm btn-info btn_add_tp_quiz" value="Assigner PT">				
					</td>
				</tr>
				
			</table>
			</form>

		</div>						
		
	</div>

	<!--- <form method="post" id="form_specials" name="form_specials" onsubmit="return submit_form_specials();">
				
		<cfoutput>
		<input type="hidden" name="u_id" value="#u_id#">
		<input type="hidden" name="updt_specials" value="1">
		<input type="hidden" name="updt_trainer" value="1">
		<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
		</cfoutput>

	</form> --->
	
</div>

<script>
	
	handler_del_tp_quiz = function del_tp_quiz(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		tp_id = idtemp[2];
		type = idtemp[3];
		
		$.ajax({
			url : './api/tp/tp_post.cfc?method=updt_quiz_delete',
			type : 'POST',
			data : {
				t_id:tp_id, 
				type:type
			},				
			success : function(result, status) {
				$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#</cfoutput>");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_quiz_tp.cfm?quiz_id="+<cfoutput>#quiz_id#</cfoutput>+"&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
			}
		});
	
	};
	$(".btn_remove_tp_quiz").bind("click",handler_del_tp_quiz);	
		
	
	// ! TRAD
	// ! end does not work

	function submit_form_tp_quiz() {
		event.preventDefault();
	
		var fd = new FormData(document.getElementById("form_tp_quiz"));
	
		var tp_id = $('#tp_quiz_id').val();
		var type = $("#type").val();
		
		$.ajax({
			url : './api/tp/tp_post.cfc?method=updt_quiz_ins',
			type : 'POST',
			data : fd,
			contentType: false,
			cache      : false,
			processData: false,
	
			success : function(result, status) {
					
				// var obj_result = jQuery.parseJSON(result);


				$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#</cfoutput>");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_quiz_tp.cfm?quiz_id="+<cfoutput>#quiz_id#</cfoutput>+"&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
				}
			});
	
		}
	
	
	
	
	</script>