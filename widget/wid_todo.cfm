
		
		

<label class="btn btn-outline-warning" for="todo">
<input type="checkbox" class="btn-check activatetodo" id="todo" autocomplete="off" data-toggle="collapse" data-target="#table_create_todo">
&nbsp; ADD TO DO</label>

<table class="table table-sm table-bordered collapse bg-white" id="table_create_todo">
		
	<tr>
		<td class="bg-light" width="120"><strong>Visibilit&eacute;</strong></td>
		<td colspan="2">
		<label><h5 class="m-0"><input type="checkbox" name="profile_id" checked="checked" value="5"> <span class="badge badge-danger">CS</span></h5></label>&nbsp;&nbsp;&nbsp;
		<label><h5 class="m-0"><input type="checkbox" name="profile_id" value="8"> <span class="badge badge-info">TM</span></h5></label>&nbsp;&nbsp;&nbsp;
		<label><h5 class="m-0"><input type="checkbox" name="profile_id" value="4"> <span class="badge badge-success">T</span></h5></label>
		<!---<label><h5 class="m-0"><input type="checkbox" name="profile_id" value="3"> <span class="badge badge-warning">L</span></h5></label>--->
		</td>
	</tr>
	<tr>
		<td class="bg-light" width="120"><strong>Destinataire</strong></td>
		<td colspan="2">
			<select class="form-control form-control-sm" name="to_id">
			<option value="0">Tous</option>
			<cfoutput query="get_to">
			<option value="#user_id#" <cfif user_id eq SESSION.USER_ID>selected</cfif>>#user_firstname#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
	SELECT o.order_id, o.order_ref, os.status_finance_name
	FROM user u
	LEFT JOIN orders o ON o.user_id = u.user_id
	LEFT JOIN order_status_finance os ON os.status_finance_id = o.order_status_id
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	<tr>
		<td class="bg-light" width="120"><strong>Order</strong></td>
		<td colspan="2">
		<select name="order_id" class="form-control form-control-sm">
		<option value = "0">--- ATTACHER ORDER ---</option>
		<cfoutput query="get_order">
		<option value = "#order_id#"> #order_ref# (#status_finance_name#)</option>
		</cfoutput>
		</select>
		</td>
	</tr>
	<tr>
		<td class="bg-light"><strong>Catégorie</strong></td>
		<td colspan="2">
		<select class="form-control form-control-sm task_type_id" name="task_type_id">
		<cfoutput query="get_task_list_todo" group="task_group">
		<optgroup label="#task_group_alias#">
		<cfoutput>
		<option value="#task_type_id#" <cfif task_type_id eq 43>selected</cfif>>TO DO : #task_type_name#</option>
		</cfoutput>
		</optgroup>
		</cfoutput>		
		</select>
		</td>
	</tr>
	<tr>
		<td class="bg-light"><strong>Description</strong></td>
		<cfoutput>
		<td colspan="2"><textarea name="log_text" id="log_text_todo" class="form-control"></textarea></td>
		</cfoutput>
	</tr>	
	
	<tr>
		<td class="bg-light"><strong>&Eacute;cheance</strong></td>
		<td width="150">
		<label><input type="checkbox" name="log_remind_ok" id="log_remind_ok" value="1" checked="checked"> Activer pour le</label>
		</td>
		<td>
		<div class="controls">
			<div class="input-group">
				<cfoutput>
				<input id="log_remind_create" name="log_remind" type="text" class="datepicker form-control" value="#dateformat(dateadd('d',7,now()),'dd/mm/yyyy')# 08:00" />
				<label for="log_remind_create" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
				</cfoutput>
			</div>
		</div>
		</td>
	</tr>

	
</table>

<script>
$(function() {		
		
// Disable a list of dates 
	var disabledDays = ["07-14-2020","08-15-2020","01-11-2020","11-11-2020","12-25-2020","01-01-2021"]; 
	function disableAllTheseDays(date) {
		var m = date.getMonth(), d = date.getDate(), y = date.getFullYear(); 
		for (i = 0; i < disabledDays.length; i++) {
			if($.inArray((m+1) + '-' + d + '-' + y,disabledDays) != -1) { 
				return [false]; 
			} 
		} 
			return [true]; 
	} 
	
	$("#log_remind_create").datetimepicker({
			defaultDate: "+1w",
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			timeFormat: "HH:mm",
			hourGrid:1,
			stepMinute:15,
			hourMin:6,
			hourMax:23,
			numberOfMonths: 3,
			firstDay: 1, 
			beforeShowDay: disableAllTheseDays 
		});
		
	$(".task_type_id").change(function() {
	
		<cfoutput query="get_task_list_todo">
		if($(this).val() == #task_type_id#)
		{
			$("##log_text_todo").val("#JSStringFormat(task_explanation)#");

			
		};
		</cfoutput>
		
		if($(this).val() == "0")
		{
			$("#log_text").val("");
			$("#log_auto").empty();
		};
	});
	
})
</script>