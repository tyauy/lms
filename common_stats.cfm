<!DOCTYPE html>
<cfif SESSION.USER_ISMANAGER eq "1">
<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

<cfparam name="select_end" default="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="select_start" default="#LSDateFormat(DateAdd('d', -30, now()),'yyyy-mm-dd', 'fr')#">

<cfquery name="get_log_date" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, tt.task_type_name, from_id, l.log_date, l.log_id
	FROM logs l
	INNER JOIN logs_item li ON li.log_id = l.log_id
	INNER JOIN user u ON u.user_id = l.from_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON upc.profile_id = up.profile_id
	LEFT JOIN task_type tt ON tt.task_type_id = li.task_type_id
	WHERE (l.log_date BETWEEN '#select_start# 00:00:00' AND '#select_end# 23:59:00') 
	AND tt.task_category = "FEEDBACK"
	AND upc.profile_id IN (2,5,6,12)
	AND from_id <> 202
	ORDER BY user_firstname, log_date DESC
</cfquery>

<cfquery name="get_log_date_group" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, tt.task_type_name, from_id, l.log_date, COUNT(l.log_id) as nb
	FROM logs l
	INNER JOIN logs_item li ON li.log_id = l.log_id
	INNER JOIN user u ON u.user_id = l.from_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	INNER JOIN user_profile up ON upc.profile_id = up.profile_id
	LEFT JOIN task_type tt ON tt.task_type_id = li.task_type_id
	WHERE (l.log_date BETWEEN '#select_start# 00:00:00' AND '#select_end# 23:59:00') 
	AND tt.task_category = "FEEDBACK"
	AND upc.profile_id IN (2,5,6,12)
	AND from_id <> 202
	GROUP BY from_id
	ORDER BY user_firstname, log_date DESC
</cfquery>

<cfquery name="get_duration" datasource="#SESSION.BDDSOURCE#">
SELECT lesson_duration, COUNT(lesson_id) as nb
FROM lms_lesson2
WHERE blocker_id IS NULL AND lesson_duration <= 120 AND lesson_start > '2020-01-01'
GROUP BY lesson_duration 
</cfquery>

<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
SELECT sessionmaster_name, COUNT(s.sessionmaster_id) as nb
FROM lms_lesson2 l
INNER JOIN lms_tpsession s ON s.session_id = l.session_id
INNER JOIN lms_tpsessionmaster2 sm ON s.sessionmaster_id = sm.sessionmaster_id
WHERE blocker_id IS NULL AND lesson_duration <= 120 AND lesson_start > '2020-01-01'
GROUP BY s.sessionmaster_id ORDER BY nb DESC LIMIT 30
</cfquery>


<cfset get_lessons_scheduled = obj_query.oget_lessons_scheduled(select_start="#select_start#", select_end="#select_end#")>
<cfset get_lessons_missed = obj_query.oget_lessons_missed(select_start="#select_start#", select_end="#select_end#")>
<cfset get_lessons_inprogress = obj_query.oget_lessons_inprogress(select_start="#select_start#", select_end="#select_end#")>
<cfset get_lessons_completed = obj_query.oget_lessons_completed(select_start="#select_start#", select_end="#select_end#")>

<cfif get_lessons_scheduled.h neq ""><cfset lesson_scheduled_h = numberformat(get_lessons_scheduled.h,'____.__')><cfelse><cfset lesson_scheduled_h = 0></cfif>
<cfif get_lessons_inprogress.h neq ""><cfset lesson_inprogress_h = numberformat(get_lessons_inprogress.h,'____.__')><cfelse><cfset lesson_inprogress_h = 0></cfif>
<cfif get_lessons_missed.h neq ""><cfset lesson_missed_h = numberformat(get_lessons_missed.h,'____.__')><cfelse><cfset lesson_missed_h = 0></cfif>
<cfif get_lessons_completed.h neq ""><cfset lesson_completed_h = numberformat(get_lessons_completed.h,'____.__')><cfelse><cfset lesson_completed_h = 0></cfif>

<cfif get_lessons_scheduled.nb neq ""><cfset lesson_scheduled_nb = get_lessons_scheduled.nb><cfelse><cfset lesson_scheduled_nb = 0></cfif>
<cfif get_lessons_inprogress.nb neq ""><cfset lesson_inprogress_nb = get_lessons_inprogress.nb><cfelse><cfset lesson_inprogress_nb = 0></cfif>
<cfif get_lessons_missed.nb neq ""><cfset lesson_missed_nb = get_lessons_missed.nb><cfelse><cfset lesson_missed_nb = 0></cfif>
<cfif get_lessons_completed.nb neq ""><cfset lesson_completed_nb = get_lessons_completed.nb><cfelse><cfset lesson_completed_nb = 0></cfif>

</cfsilent> 
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_activity_report')#">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row" style="margin-top:10px">
			
				<div class="col-md-6 mb-3">
					
					<div class="card border-top border-info h-100">
						<div class="card-body">
							<h4 class="card-title"><cfoutput>#obj_translater.get_translate('card_trainer_period')#</cfoutput> 
								<!--- : <cfoutput>#mlongsel# #ysel#</cfoutput> --->
							</h4>
							<div class="row">
								<div class="col-md-12 mt-4">
								<cfform action="common_stats.cfm">
									<div class="form-row">
										<div class="controls col-5">
											<div class="input-group">
												<input id="select_start" name="select_start" type="text" class="datepicker form-control" value="<cfoutput>#select_start#</cfoutput>" />
												<label for="select_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
											</div>
										</div>	
										<div class="controls col-5">
											<div class="input-group">
												<input id="select_end" name="select_end" type="text" class="datepicker form-control" value="<cfoutput>#select_end#</cfoutput>" />
												<label for="select_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
											</div>
										</div>	

									
									<!--- <div class="col">
										
									
									
										<select class="form-control" name="msel">

										<cfloop from="1" to="12" index="m">
										<cfoutput>
											<cfif SESSION.LANG_CODE neq "fr">
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
											<cfelse>
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
											</cfif>
											
											
										</cfoutput>
										</cfloop>
										</select>
									</div>
									
									<div class="col">
									
										<select class="form-control" name="ysel">
										<cfloop from="2019" to="#year(now())+1#" index="y">
										<cfoutput>
											<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
										</cfoutput>
										</cfloop>
										</select>
									</div> --->
									
									<div class="col-2">
										<input type="submit" value="GO" class="btn btn-sm btn-info">
										<!--- <a href="cs_stats.cfm" class="btn btn-sm btn-warning"><cfoutput>#obj_translater.get_translate('btn_trainer_thismonth')#</cfoutput></a> --->
									</div>
								</div>
								</cfform>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
			
			<div id="accordion">
			<div class="row">
			
				<div class="col-md-12">
					<a class="btn btn-primary btn-lg" data-toggle="collapse" href="#collapse_cs" role="button" aria-expanded="false" aria-controls="collapse_cs">
						<i class="fad fa-chart-line fa-2x"></i><br>Activit&eacute; CS
					</a>
					<a class="btn btn-warning btn-lg" data-toggle="collapse" href="#collapse_lesson" role="button" aria-expanded="false" aria-controls="collapse_cs">
						<i class="fad fa-book fa-2x"></i><br>Analyse Lesson
					</a>
					<a class="btn btn-success btn-lg" data-toggle="collapse" href="#collapse_trainer" role="button" aria-expanded="false" aria-controls="collapse_cs">
						<i class="fad fa-chalkboard-teacher fa-2x"></i><br>Co&ucirc;t Trainer
					</a>
				</div>
				
			</div>
			
			<div class="collapse" id="collapse_cs" data-parent="#accordion">
				<div class="row">			
					<div class="col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">
							<h6>Activit&eacute; CS</h6>
								<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
								<cfoutput query="get_log_date" group="from_id">
									<li class="nav-item" role="presentation">
										<button class="nav-link <cfif from_id eq "7211">active</cfif>" id="pills-home-tab" data-toggle="pill" data-target="##div_#from_id#" type="button" role="tab" aria-controls="div_#from_id#" aria-selected="true">#user_firstname#</button>
									</li>
								</cfoutput>
								</ul>

								<div class="row">

									<div class="col-md-4">

										<div>
											<canvas id="chart_all" style="width:200px" width="200"></canvas>
										</div>

									</div>
								</div>


								<div class="tab-content" id="pills-tabContent">
									
								<cfset bg_date = now()>
								<cfoutput query="get_log_date" group="from_id">
								
									
									<div class="tab-pane fade <cfif from_id eq "7211">show active</cfif>" id="div_#from_id#" role="tabpanel">

										<!--- <div>
											<canvas id="chart_#from_id#"></canvas>
										</div> --->


										<table class="table">
											#from_id#
											<cfoutput group="log_id">
												<tr <cfif bg_date neq dateformat(log_date,'dd/mm/yyyy')>class="bg-info"</cfif>>
													<td>#user_firstname#</td>
													<td>#task_type_name#</td>	
													<td>#log_date#</td>						
												</tr>
												<cfif bg_date neq dateformat(log_date,'dd/mm/yyyy')>
													<cfset bg_date = dateformat(log_date,'dd/mm/yyyy')>
												</cfif>
											
											</cfoutput>

										</table>

									</div>
									


								</cfoutput>
								</div>

							</div>								
						</div>
					</div>
				</div>
			</div>
			
			<div class="collapse" id="collapse_lesson" data-parent="#accordion">
				<div class="row">			
					<div class="col-md-4">
						<div class="card border-top border-success">
							<div class="card-body">
							<h6>Analyse lessons</h6>
								<table class="table table-bordered">
									<tr>
										<th class="bg-light">Type</th>
										<th class="bg-light">Nb</th>
										<th class="bg-light">Heures</th>
									</tr>
									<cfoutput>
									<tr>
										<td>Scheduled</td>
										<td>#lesson_scheduled_nb#</td>
										<td>#lesson_scheduled_h#</td>
									</tr>
									<tr>
										<td>In Progress</td>
										<td>#lesson_inprogress_nb#</td>
										<td>#lesson_inprogress_h#</td>
									</tr>
									<tr>
										<td>Completed</td>
										<td>#lesson_completed_nb#</td>
										<td>#lesson_completed_h#</td>
									</tr>
									<tr>
										<td>Missed</td>
										<td>#lesson_missed_nb#</td>
										<td>#lesson_missed_h#</td>
									</tr>
									
									<cfset total_nb = lesson_scheduled_nb+lesson_inprogress_nb+lesson_completed_nb+lesson_missed_nb>
									<cfset total_h = lesson_scheduled_h+lesson_inprogress_h+lesson_completed_h+lesson_missed_h>
									<tr>
										<td><strong>Total</td>
										<td><strong>#total_nb#</strong></td>
										<td><strong>#total_h#</strong></td>
									</tr>
									</cfoutput>
								</table>
							</div>
						</div>
					</div>
					
					<div class="col-md-4">
						<div class="card border-top border-success">
							<div class="card-body">
							<h6>Average lesson duration (since 2020)</h6>
								<table class="table table-bordered">
									<tr>
										<th class="bg-light">Lesson Duration</th>
										<th class="bg-light">Nb</th>
									</tr>
									<cfoutput query="get_duration">
									<tr>
										<td>#lesson_duration# min</td>
										<td>#nb#</td>
									</tr>									
									</cfoutput>
								</table>
							</div>
						</div>
					</div>
					
					<div class="col-md-4">
						<div class="card border-top border-success">
							<div class="card-body">
							<h6>Most used materials (since 2020)</h6>
								<table class="table table-bordered">
									<tr>
										<th class="bg-light">Course</th>
										<th class="bg-light">Nb</th>
									</tr>
									<cfoutput query="get_session">
									<tr>
										<td>#sessionmaster_name#</td>
										<td>#nb#</td>
									</tr>									
									</cfoutput>
								</table>
							</div>
						</div>
					</div>
					
				</div>			
			</div>
			
			<div class="collapse" id="collapse_trainer" data-parent="#accordion">
				<div class="row">			
					<div class="col-md-6">
						<div class="card border-top border-success">
							<div class="card-body">
							<h6>Co&ucirc;t Trainer</h6>
								<table class="table table-bordered">
									<tr>
										<th class="bg-light">Trainer</th>
										<th class="bg-light">Scheduled</th>
										<!--- <th class="bg-light">Progress</th> --->
										<th class="bg-light">Completed</th>
										<th class="bg-light">Missed</th>
										<!--- <th class="bg-light">Cancelled</th> --->
										<th class="bg-light">Type</th>
										<th class="bg-light">Estim Cost</th>
									</tr>
									
									<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
									SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate, l.planner_id
									FROM lms_lesson2 l
									INNER JOIN user u ON u.user_id = l.planner_id
									WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' 
									AND l.user_id IS NOT NULL AND l.status_id <> 3
									GROUP BY l.planner_id, l.method_id
									ORDER BY nb desc
									</cfquery>
									
									
									<cfset total = 0>
									<cfset total_hour_completed = 0>
									<cfset total_hour_scheduled = 0>
									<cfset total_hour_missed = 0>
									<cfset total_hour = 0>
									
									<cfoutput query="get_trainer">
									
									<cfquery name="get_trainer_scheduled" datasource="#SESSION.BDDSOURCE#">
									SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate 
									FROM lms_lesson2 l
									INNER JOIN user u ON u.user_id = l.planner_id
									WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' AND (l.method_id = 1 OR l.method_id = 2) AND (l.status_id = 1 OR l.status_id = 2) AND l.planner_id = #planner_id#
									ORDER BY nb desc
									</cfquery>
									<!--- <cfquery name="get_trainer_progress" datasource="#SESSION.BDDSOURCE#"> --->
									<!--- SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate  --->
									<!--- FROM lms_lesson2 l --->
									<!--- INNER JOIN user u ON u.user_id = l.planner_id --->
									<!--- WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' AND (l.method_id = 1 OR l.method_id = 2) AND l.status_id = 2 AND l.planner_id = #planner_id# --->
									<!--- ORDER BY nb desc --->
									<!--- </cfquery> --->
									<cfquery name="get_trainer_completed" datasource="#SESSION.BDDSOURCE#">
									SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate 
									FROM lms_lesson2 l
									INNER JOIN user u ON u.user_id = l.planner_id
									WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' AND (l.method_id = 1 OR l.method_id = 2) AND l.status_id = 5 AND l.planner_id = #planner_id#
									ORDER BY nb desc
									</cfquery>
									<cfquery name="get_trainer_missed" datasource="#SESSION.BDDSOURCE#">
									SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate 
									FROM lms_lesson2 l
									INNER JOIN user u ON u.user_id = l.planner_id
									WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' AND (l.method_id = 1 OR l.method_id = 2) AND l.status_id = 4 AND l.planner_id = #planner_id#
									ORDER BY nb desc
									</cfquery>
									<!--- <cfquery name="get_trainer_cancelled" datasource="#SESSION.BDDSOURCE#"> --->
									<!--- SELECT COUNT(lesson_id) as nb, l.method_id, u.user_firstname, u.user_visio_rate, u.user_f2f_rate  --->
									<!--- FROM lms_lesson2 l --->
									<!--- INNER JOIN user u ON u.user_id = l.planner_id --->
									<!--- WHERE DATE_FORMAT(l.lesson_start, "%Y-%m") = '#tselect#' AND (l.method_id = 1 OR l.method_id = 2) AND l.status_id = 3 AND l.planner_id = #planner_id# --->
									<!--- ORDER BY nb desc --->
									<!--- </cfquery> --->
									
									<cfset total_hour_scheduled = total_hour_scheduled+get_trainer_completed.nb>
									<cfset total_hour_completed = total_hour_completed+get_trainer_scheduled.nb>
									<cfset total_hour_missed = total_hour_missed+get_trainer_missed.nb>
									<cfset total_hour = total_hour+get_trainer_scheduled.nb+get_trainer_completed.nb+get_trainer_missed.nb>
									
									<tr>
										<td>#user_firstname#</td>
										<td>#get_trainer_scheduled.nb#</td>
										<!--- <td>#get_trainer_progress.nb#</td> --->
										<td>#get_trainer_completed.nb#</td>
										<td>#get_trainer_missed.nb#</td>
										<!--- <td>#get_trainer_cancelled.nb#</td> --->
										<td>#method_id#</td>
										
										<td>
										<cfif method_id eq "1" AND user_visio_rate neq "">#nb*user_visio_rate#
											<cfset total = total+(nb*user_visio_rate)>
										<cfelseif method_id eq "2" AND user_f2f_rate neq "">#nb*user_f2f_rate#
											<cfset total = total+(nb*user_f2f_rate)>
										</cfif> &euro;</td>
									</tr>								
									</cfoutput>
									
									<tr>
										<td>Total</td>
										<td><strong><cfoutput>#total_hour_scheduled#</cfoutput> h</strong></td>
										<td><strong><cfoutput>#total_hour_completed#</cfoutput> h</strong></td>
										<td><strong><cfoutput>#total_hour_missed#</cfoutput> h</strong></td>
										<td><strong><cfoutput>#total_hour#</cfoutput> h</strong></td>	
										<td><strong><cfoutput>#total#</cfoutput> &euro;</strong></td>
									</tr>
									
								</table>
								<!--- <canvas id="myChart" width="400" height="400"></canvas> --->
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
			


			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>

<cfinclude template="./incl/incl_scripts.cfm">


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
$(document).ready(function() {


const ctx_all = document.getElementById('chart_all');

new Chart(ctx_all, {
  type: 'bar',
  data: {
	labels: [<cfoutput query="get_log_date_group">"#user_firstname#",</cfoutput>],
	datasets: [{
	  label: 'NB Feedback',
	  data: [<cfoutput query="get_log_date_group">"#nb#",</cfoutput>],
	  borderWidth: 1
	}]
  },
  options: {
	scales: {
	  y: {
		beginAtZero: true
	  }
	}
  }
});


<!--- <cfoutput query="get_log_date_group" group="from_id">
const ctx_#from_id# = document.getElementById('chart_#from_id#');

new Chart(ctx_#from_id#, {
  type: 'bar',
  data: {
	labels: [<cfoutput>#user_firstname#,</cfoutput>],
	datasets: [{
	  label: 'wdv of Votes',
	  data: [12, 19, 3, 5, 2, 3],
	  borderWidth: 1
	}]
  },
  options: {
	scales: {
	  y: {
		beginAtZero: true
	  }
	}
  }
});
</cfoutput> --->


// var ctx = document.getElementById('myChart').getContext('2d');
// var myChart = new Chart(ctx, {
//     type: 'bar',
//     data: {
//         labels: [<cfloop list="#SESSION.LISTMONTHS_JS#" index="cor"><cfoutput>'#cor#',</cfoutput></cfloop>],
//         datasets: [{
//             label: '# of Votes',
//             data: [12, 19, 3, 5, 2, 3],
//             backgroundColor: [
//                 'rgba(255, 99, 132, 0.2)',
//                 'rgba(54, 162, 235, 0.2)',
//                 'rgba(255, 206, 86, 0.2)',
//                 'rgba(75, 192, 192, 0.2)',
//                 'rgba(153, 102, 255, 0.2)',
//                 'rgba(255, 159, 64, 0.2)'
//             ],
//             borderColor: [
//                 'rgba(255, 99, 132, 1)',
//                 'rgba(54, 162, 235, 1)',
//                 'rgba(255, 206, 86, 1)',
//                 'rgba(75, 192, 192, 1)',
//                 'rgba(153, 102, 255, 1)',
//                 'rgba(255, 159, 64, 1)'
//             ],
//             borderWidth: 1
//         }]
//     },
//     options: {
//         scales: {
//             y: {
//                 beginAtZero: true
//             }
//         }
//     }
// });



		$("#select_end").datepicker({
		weekStart: 1,
		dateFormat: 'yy-mm-dd',
		onClose: function( selectedDate ) {
			select_end = $('#select_end').datepicker("getDate");
			select_end = moment(select_end).format('YYYY-MM-DD');
		}		
        });

        $("#select_start").datepicker({
            weekStart: 1,
            dateFormat: 'yy-mm-dd',
            onClose: function( selectedDate ) {
				$("#select_end").datepicker( "option", "minDate", selectedDate );
                select_start = $('#select_start').datepicker("getDate");
                select_start = moment(select_start).format('YYYY-MM-DD');
            }	
        });
});
        
</script>

 <!--- <script> --->
 <!--- const config = { --->
  <!--- type: 'bar', --->
  <!--- data: data, --->
  <!--- options: { --->
    <!--- responsive: true, --->
    <!--- plugins: { --->
      <!--- legend: { --->
        <!--- position: 'top', --->
      <!--- }, --->
      <!--- title: { --->
        <!--- display: true, --->
        <!--- text: 'Chart.js Bar Chart' --->
      <!--- } --->
    <!--- } --->
  <!--- }, --->
<!--- }; --->

 <!--- const DATA_COUNT = 7; --->
<!--- const NUMBER_CFG = {count: DATA_COUNT, min: -100, max: 100}; --->

<!--- const labels = Utils.months({count: 7}); --->
<!--- const data = { --->
  <!--- labels: labels, --->
  <!--- datasets: [ --->
    <!--- { --->
      <!--- label: 'Dataset 1', --->
      <!--- data: Utils.numbers(NUMBER_CFG), --->
      <!--- borderColor: Utils.CHART_COLORS.red, --->
      <!--- backgroundColor: Utils.transparentize(Utils.CHART_COLORS.red, 0.5), --->
    <!--- }, --->
    <!--- { --->
      <!--- label: 'Dataset 2', --->
      <!--- data: Utils.numbers(NUMBER_CFG), --->
      <!--- borderColor: Utils.CHART_COLORS.blue, --->
      <!--- backgroundColor: Utils.transparentize(Utils.CHART_COLORS.blue, 0.5), --->
    <!--- } --->
  <!--- ] --->
<!--- }; --->
 <!--- </script> --->
 
<cfinclude template="./incl/incl_scripts.cfm">


</body>
</html>
</cfif>