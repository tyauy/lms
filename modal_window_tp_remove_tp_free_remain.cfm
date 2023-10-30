<cfparam name="t_id">
<cfparam name="u_id">

<!--- if we want only lesson that are booked after the end of the tp --->
<!--- AND ((l.lesson_start > t.tp_date_end AND l.status_id = 1) OR l.lesson_id IS NULL) --->


<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT sm.sessionmaster_name, s.session_id, s.session_name, s.session_rank, s.session_close, s.session_duration, 
	l.lesson_id, l.lesson_start, t.tp_date_end, l.status_id 
	FROM lms_tpsession s 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_tp t ON s.tp_id = t.tp_id
	LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id AND l.status_id != 3
	WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
	AND ( l.status_id = 1 OR l.lesson_id IS NULL)
	ORDER BY s.session_rank ASC
</cfquery>

<cfquery name="get_lesson_booked" datasource="#SESSION.BDDSOURCE#">
	SELECT sm.sessionmaster_name, s.session_id, s.session_name, s.session_rank, s.session_close, s.session_duration, 
	l.lesson_id, l.lesson_start, t.tp_date_end, l.status_id 
	FROM lms_tpsession s 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_tp t ON s.tp_id = t.tp_id
	LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id AND l.status_id != 3
	WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
	AND l.status_id != 1
	ORDER BY s.session_rank ASC
</cfquery>

<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>

<cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = get_tp.tp_scheduled></cfif>
<cfif get_tp.tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = get_tp.tp_inprogress></cfif>
<cfif get_tp.tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = get_tp.tp_cancelled></cfif>
<cfif get_tp.tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = get_tp.tp_missed></cfif>
<cfif get_tp.tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = get_tp.tp_completed></cfif>

<cfif get_tp.tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = get_tp.tp_duration></cfif>
<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>

<cfset new_total_duration = 0>

<cfif get_lesson.recordcount neq "0">

	<div class="card border">
		<div class="card-body">
			<!--- <h6>#obj_translater.get_translate('card_activity')#</h6> --->
			<table class="table table-borderless bg-white m-0">
				<cfoutput>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('badge_planned_f_p')#</td>
					<td>
						<h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-warning" id="nb_toschedule"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></span></h6>
					</td>
				</tr>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('badge_completed_f_p')#</td>
					<td>
						<h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-success" id="nb_completed"><cfif tp_completed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_completed_go#",unit="min")#<cfelse>-</cfif></span></h6>
					</td>
				</tr>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('badge_missed_f_p')#</td>
					<td>
						<h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_missed"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></span></h6>
					</td>
				</tr>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('badge_cancelled_f_p')#</td>
					<td>
						<h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_cancelled"><cfif tp_cancelled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_cancelled_go#",unit="min")#<cfelse>-</cfif></span></h6>
					</td>
				</tr>
				<tr>
					<td class="bg-light">#obj_translater.get_translate('badge_remaining_f_p')#</td>
					<td>
						<h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-primary" id="nb_remain"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></span></h6>
					</td>
				</tr>
				<tr>
					<td class="bg-light">Date limite</td>
					<td>
						<cfif get_tp.tp_date_end lte now() AND get_tp.tp_vip eq "0">
							<h6 class="m-0 text-danger"><i class="fas fa-exclamation-triangle text-danger"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
						<cfelse>
							<cfif get_tp.tp_date_end lte dateadd("m",2,now())>
								<h6 class="m-0 text-warning"><i class="fas fa-exclamation-triangle text-warning"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
							<cfelse>
								<h6 class="m-0">#obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
							</cfif>
						</cfif>
					</td>
				</tr>
			</cfoutput>
			</table>
			
		</div>
	</div>

	<cfquery name="get_last_lesson" datasource="#SESSION.BDDSOURCE#">
		SELECT `lesson_id`, `lesson_start` FROM `lms_lesson2` WHERE `tp_id` = 22094 ORDER BY lesson_start DESC LIMIT 1
	</cfquery>

	<cfif get_last_lesson.recordCount eq 1>
		<div class="card border">
			<div class="card-body" align="center">
	
				
				<h6>Last Lesson : <cfoutput>#get_last_lesson.lesson_start#</cfoutput></h6>
				
			</div>
		</div>
	</cfif>

	<!--- <cfdump var="#get_lesson_booked#"> --->

	<cfif SESSION.USER_PROFILE_ID eq 2>


	<div class="row" align="center">
		<div class="col-md-12">
		<div class="card border">
			<div class="card-body" align="center">
	
				
				<input type="submit" id="go_migration" class="btn btn-info" value="MIGRATION">
				
			</div>
		</div>
		</div>
	</div>
	</cfif>

	<div class="row">
		<div class="col-md-8">

	<form id="form_remain">
	<table class="table">
		<tr>
			<td width="30%">
				<label for="planner_id">Trainer</label>
			</td>
			<td>
				<select class="form-control" id="planner_id" name="planner_id">
					<option value="5373">KRYSTINA</option>
					<option value="151">DOUGLAS</option>
					<!--- <option value="2586">TOM</option> --->
					<option value="2582">SUMMER</option>
				</select>    
			</td>
		</tr>
		<tr>
			<td width="30%">
				<label>
					Free Remain New End Date
				</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="tp_end_date" name="tp_end_date" type="text" class="datepicker form-control" value="<cfoutput>#lsDateFormat(dateadd('m',3,now()),'yyyy-mm-dd', 'fr')#</cfoutput>" />
						<label for="tp_end_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
					</div>
				</div>		
			</td>
		</tr>
		<cfoutput query="get_lesson">
			<cfset new_total_duration = new_total_duration + session_duration>
		<tr>
			<td width="30%">
				<label>
					#session_rank# : 
					<cfif session_name neq "">
						#session_name#
					<cfelse>
						#sessionmaster_name#
					</cfif>
					 - #session_duration# min

					 <cfif status_id eq 1>
						<br>
						<span class="badge badge-pill badge-warning" id="nb_remain">#lesson_start#</span>
					 </cfif>
				</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="time_#currentrow#" name="time_#currentrow#" type="text" class="datepicker form-control" value="#dateformat(now(),'yyyy-mm-dd')# 08:00" />
						<label for="time_#currentrow#" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
					</div>
				</div>
			</td>
			<input type="hidden" id="session_#currentrow#" name="session_#currentrow#" value="#session_id#">	
			<input type="hidden" id="dur_#currentrow#" name="dur_#currentrow#" value="#session_duration#">	
			<input type="hidden" id="lesson_#currentrow#" name="lesson_#currentrow#" value="#lesson_id#">	
		</tr>
		</cfoutput>

		<tr>
			<td colspan="3" align="center">
				<cfoutput>
					<input type="hidden" id="u_id" name="u_id" value="#u_id#">
					<input type="hidden" id="t_id" name="t_id" value="#t_id#">
					<input type="hidden" id="l_nb" name="l_nb" value="#get_lesson.recordCount#">
					<input type="hidden" id="new_total_duration" name="new_total_duration" value="#new_total_duration#">
				<input type="submit" id="submit_form" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
				</cfoutput>
			</td>
		</tr>
		
	</table>
	</form>
	</div>
	<div class="col-md-4">
		<table class="table">
			<cfoutput query="get_lesson_booked">
				<tr>
					<td>
						<label>
							#session_rank# : 
							<cfif session_name neq "">
								#session_name#
							<cfelse>
								#sessionmaster_name#
							</cfif>
							 - #session_duration# min
		
								<br>
								<span class="badge badge-pill badge-success" id="nb_remain">#lesson_start#</span>
						</label>
					</td>
				</tr>
			</cfoutput>
		</table>
	</div>
</div>	

<cfelse>
	No lesson to export into a "Free Remain" tp
</cfif>


<script>
$(document).ready(function() {

	$("#tp_end_date").datepicker({	
		weekStart: 1,
		dateFormat: 'yy-mm-dd'
	})

	<cfoutput query="get_lesson">

	$("##time_#currentrow#").datetimepicker({	
		defaultDate: "+1w",
		changeMonth: true,
		dateFormat:"yy-mm-dd",
		timeFormat: "HH:mm",
		hourGrid:1,
		stepMinute:15,
		hourMin:6,
		hourMax:23,
		numberOfMonths: 3,
		firstDay: 1,
		maxDate: "#get_lesson.tp_date_end#"
	})
	</cfoutput>

	$('#submit_form').click(function(){
		event.preventDefault();

		console.log($('#form_remain').serialize())
		$.ajax({
			url: 'api/tp/tp_post.cfc?method=updt_free_remain',
			type: 'POST',
			data : $('#form_remain').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

		

	})
		

	$('#go_migration').click(function(){
		event.preventDefault();

		console.log($('#form_remain').serialize())
		$.ajax({
			url: 'api/tp/tp_post.cfc?method=updt_free_remain_migrate',
			type: 'POST',
			data : $('#form_remain').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

		

	})

});

</script>
		


