<cfparam name="t_id">
<cfparam name="u_id">
<cfparam name="m_id">
<cfparam name="s_id">
<cfparam name="s_dur">

<!----- GET SESSION DESC TO DISPLAY TITLE + OBJ --->
<cfset get_session_description = obj_query.oget_session_description(s_id="#s_id#")>

<!----- PLANNER LIST (SCAN TP AND GET SOLO OR SHARED TRAINER) --->
<cfset planner_list = "">	

<cfset get_trainer_tp = obj_query.oget_trainer_tp(t_id="#t_id#")>

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#u_id#",t_id="#t_id#")>
<cfelse>
	<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
</cfif>

<cfset tp_date_start = get_tp.tp_date_start>
<cfset tp_date_end = get_tp.tp_date_end>

<cfif tp_date_end eq "">
	<cfset tp_date_end = dateformat(dateadd("yyyy",1,now()),'yyyy-mm-dd')>
</cfif>

<!----- DATE TREATMENT --->
<cfif not isdefined("date_select")>
	<cfset date_select = now()>
</cfif>

<cfif DateCompare(tp_date_start, date_select) eq 1>
	<cfset date_select = tp_date_start>
</cfif>

<!----- SET MIN_DATE --->
<cfif tp_date_start gt now()>
	<cfset min_date = tp_date_start>
<cfelse>
	<cfset min_date = now()>
</cfif>

<cfset date_display = dateformat(date_select,'dd/mm/yyyy')>
<cfset date_link = dateformat(date_select,'yyyy-mm-dd')>

<cfoutput query="get_trainer_tp">
	<cfset planner_list = listappend(planner_list,user_id)>
</cfoutput>

<cfif planner_list eq "" AND m_id eq 7>
	<cfset planner_list = listappend(planner_list,"4784")>
</cfif>

<!----- GET AVAIL DAY FOR DATEPICKER --->	
<cfif listFindNoCase("CS,FINANCE,SALES,TRAINERMNG", SESSION.USER_PROFILE)>
	<cfquery name="get_avail_day" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT(DATE_FORMAT(slot_start,'%Y-%m-%d')) as avail_day FROM user_slots 
	WHERE planner_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#planner_list#" list="true">) 
	<cfif get_tp.tp_vip eq "0"> AND slot_start <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(tp_date_end,'yyyy-mm-dd')#" ></cfif>
	</cfquery>
<cfelse>
	<cfquery name="get_avail_day" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT(DATE_FORMAT(slot_start,'%Y-%m-%d')) as avail_day FROM user_slots 
	WHERE planner_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#planner_list#" list="true">) 
	<cfif get_tp.tp_vip eq "0"> AND slot_start >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#min_date#"></cfif>
	<cfif get_tp.tp_vip eq "0"> AND slot_start <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(tp_date_end,'yyyy-mm-dd')#" ></cfif>
	</cfquery>
</cfif>

<!---<cfquery name="get_avail_day" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(DATE_FORMAT(lesson_start,'%Y-%m-%d')) as avail_day FROM lms_lesson2 WHERE user_id IS NULL AND lesson_ghost IS NULL AND planner_id IN (#planner_list#)
</cfquery>--->

<!----- GET AVAIL DAY MAX FOR DATEPICKER --->	
<!--- <cfquery name="get_avail_day_max" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT MAX(DATE_FORMAT(slot_start,'%y-%m-%d')) as avail_day FROM user_slots WHERE planner_id IN (#planner_list#) --->
<!--- </cfquery> --->

<!---<cfquery name="get_avail_day_max" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(DATE_FORMAT(lesson_start,'%y-%m-%d')) as avail_day FROM lms_lesson2 WHERE user_id IS NULL AND lesson_ghost IS NULL AND planner_id IN (#planner_list#)
</cfquery>--->


<div class="media">
	<cfoutput>#obj_lms.get_thumb_session(sessionmaster_id="#get_session_description.sessionmaster_id#",sessionmaster_code="#get_session_description.sessionmaster_code#",size="150",align="left")#</cfoutput>
	<div class="media-body ml-3">
	<h6 class="mt-0"><cfoutput>#get_session_description.sessionmaster_name#</cfoutput></h6>
	<cfoutput>#get_session_description.sessionmaster_description#</cfoutput>
	</div>
</div>

<div class="row justify-content-center mt-3">
	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE) AND get_tp.method_id eq 12>
		<div class="col-md-4">

			<!--- <cfset get_learner_account = obj_query.oget_learner(pf_id="100",ust_id="1,2,3,4",list_account="#get_user.account_id#",o_by="name")> --->
			<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">	
				SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact,
				a.account_name, u.account_id,
				t.method_id
				FROM lms_tp t 
				INNER JOIN lms_tpuser tpu ON t.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
				INNER JOIN user u ON u.user_id = tpu.user_id
				INNER JOIN account a ON a.account_id = u.account_id
				WHERE tpu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>
		
			<select id="learner_select" class="form-control form-control-sm" name="u_id">
				<option value="0" >Sélectionner</option>
				<cfoutput query="get_user">
					<option value="#user_id#" <cfif user_id eq u_id>selected</cfif>>#ucase(user_name)# #user_firstname#</option>
				</cfoutput>
			</select>
		</div>
	</cfif>

	<div class="col-md-6">
		<form class="form-inline" align="center">
			<a href="#" class="prev_day form-inline btn btn-sm btn-outline-info" id="prev_day_select" role="button"><i class="fas fa-step-backward"></i></a>
			&nbsp;&nbsp;		
			<div class="input-group form-inline" style="width:200px;">			
			<input id="date_select" name="date_select" type="text" class="datepicker form-control" readonly="true" value=<cfoutput>#date_display#</cfoutput> />
			<label for="date_select" class="input-group-addon btn btn-info m-0"><i class="fas fa-calendar-alt"></i></label>
			</div>
			&nbsp;&nbsp;
			<a href="#" class="next_day form-inline btn btn-sm btn-outline-info" id="next_day_select" role="button"><i class="fas fa-step-forward"></i></a>
		</form>
	</div>
</div>



<br>

<div id="container_avail" style="min-height:200px">
	

</div>


<script>
$( document ).ready(function() {
	
	var array_avail = [<cfoutput>"#dateformat(tp_date_end,'d-m-yyyy')#"</cfoutput><cfoutput query="get_avail_day">,"#dateformat(avail_day,'d-m-yyyy')#"</cfoutput>]

	function enableAllTheseDays(date) {
		var sdate = $.datepicker.formatDate( 'd-m-yy', date)
		if($.inArray(sdate, array_avail) != -1) {
			return [true];
		}
		return [false];
	}

	function check_range() {
		var dateref = $('#date_select').datepicker("getDate");

		if(!dateref) {
			dateref = "<cfoutput>#min_date#</cfoutput>";
		}

		if (moment(dateref).format('YYYY-MM-DD') == "<cfoutput>#LSDateFormat(min_date,'yyyy-mm-dd', 'fr')#</cfoutput>") {
			$('#prev_day_select').attr('disabled', true);
		} else {
			$('#prev_day_select').removeAttr('disabled');
		}

		if (moment(dateref).format('YYYY-MM-DD') == "<cfoutput>#LSDateFormat(tp_date_end,'yyyy-mm-dd', 'fr')#</cfoutput>") {
			$('#next_day_select').attr('disabled', true);
		} else {
			$('#next_day_select').removeAttr('disabled');
		}
		
	}
	<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
		check_range();
	</cfif>

	<cfoutput>
	$('##container_avail').load("get_slot.cfm?m_id=#m_id#&t_id=#t_id#&u_id=#u_id#&date_select=#date_link#&s_dur=#s_dur#&s_id=#s_id#", function() {
		$('##container_avail').show("slow");
	});
	</cfoutput>
	
		
	$('#date_select').datepicker({	
		<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>
			minDate:0,
		</cfif>
		
			// minDate:<cfoutput>#lsDateFormat(min_date,'YYYY-MM-DD','fr')#</cfoutput>,
			// maxDate:<cfoutput>#lsDateFormat(tp_date_end,'YYYY-MM-DD','fr')#</cfoutput>,
		
		<!---<cfoutput>maxDate:new Date('#dateformat(get_avail_day_max.avail_day,"yyyy-m-dd")#'),</cfoutput>---->
		defaultDate: "+1w",
		changeMonth: true,
		numberOfMonths: 2,
		firstDay:1,
		dateFormat: 'dd/mm/yy',
		onClose: function(selectedDate) {
			var datego = $('#date_select').datepicker("getDate");
			var datego = moment(datego).format('YYYY-MM-DD');

			$('#container_avail').html("<div class='loader'></div>");
			
			/*$('#container_avail').hide("fast").empty();*/

			<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
				check_range();
			</cfif>
				
			<cfoutput>
			$('##container_avail').load("get_slot.cfm?m_id=#m_id#&t_id=#t_id#&u_id=#u_id#&date_select="+datego+"&s_dur=#s_dur#&s_id=#s_id#", function() {
				$('##container_avail').show("slow");
			});				
			</cfoutput>
		},
		beforeShowDay: enableAllTheseDays	
	})
			
	$('.next_day').click(function(e){
			
		var dateref = $('#date_select').datepicker("getDate");
									
		var datego = moment(dateref).add(1,'days').format('YYYY-MM-DD');
		var datepick = moment(dateref).add(1,'days').format('YYYY-MM-DD');
		var datepick = new Date(datepick);
		
		$('#date_select').datepicker({dateFormat:'yy-mm-dd'}).datepicker("setDate",datepick);
		
		$('#container_avail').html("<div class='loader'></div>");

		<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
			check_range();
		</cfif>

		<cfoutput>
		$('##container_avail').load("get_slot.cfm?m_id=#m_id#&t_id=#t_id#&u_id=#u_id#&date_select="+datego+"&s_dur=#s_dur#&s_id=#s_id#", function() {
			$('##container_avail').show("fast");
		});				
		</cfoutput>
	})	
	
	$('.prev_day').click(function(e){
		
		var dateref = $('#date_select').datepicker("getDate");
				
		var datego = moment(dateref).add(-1,'days').format('YYYY-MM-DD');
		var datepick = moment(dateref).add(-1,'days').format('YYYY-MM-DD');
		var datepick = new Date(datepick);
			
		$('#date_select').datepicker({dateFormat:'yy-mm-dd'}).datepicker("setDate",datepick);
		
		$('#container_avail').html("<div class='loader'></div>");

		<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
			check_range();
		</cfif>

		<cfoutput>
		$('##container_avail').load("get_slot.cfm?m_id=#m_id#&t_id=#t_id#&u_id=#u_id#&date_select="+datego+"&s_dur=#s_dur#&s_id=#s_id#", function() {
			$('##container_avail').show("fast");
		});		
		</cfoutput>		
	})

	$("#learner_select").change(function(event) {
	// console.log($(this).val());
	let sort_by = $(this).val();

	<cfoutput>
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_book')# - #s_dur# min");
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_body_lg').load("modal_window_calendar.cfm?m_id=#m_id#&t_id=#t_id#&u_id="+$(this).val()+"&s_dur=#s_dur#&s_id=#s_id#", function() {});
	</cfoutput>
	

	});
})
</script>

