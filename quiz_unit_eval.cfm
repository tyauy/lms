<!DOCTYPE html>

<cfsilent>
	
	<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "test">
		<cfset u_id = SESSION.USER_ID>
	<cfelse>
		<cfset u_id = u_id>
	</cfif>
	
	<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_type, q.quiz_name, q.quiz_rank, qu.quiz_success, qu.user_id
	FROM lms_quiz_user qu
	INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	
	<cfif get_quiz_id.recordcount eq "0" OR get_quiz_id.quiz_type neq "unit">
		<cflocation addtoken="no" url="index.cfm">
	</cfif>

	<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
	SELECT qq.qu_id, qq.qu_text, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id
	FROM lms_quiz_question qq
	INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
	INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
	INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
	WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	ORDER BY qc.qu_ranking ASC
	</cfquery>

	<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(ans_gain) as score
	FROM lms_quiz_result
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	</cfquery>
	
	<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(ans_gain) as quiz_score
	FROM lms_quiz_answer a 
	INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
	INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
	WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
	</cfquery>
		
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_eou_quiz')#">

		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			
				<div class="row">	
			
					<div class="col-lg-10 offset-lg-1 col-md-12">

						<div class="card">
							<div class="card-body">
								<h4 class="card-title d-inline">Unit Quiz</h4>
								
								<div class="row">

									<div class="col-md-4">
										<canvas id="qpt2_result" height="200"></canvas>
									</div>

									<div class="col-md-8">
										<table class="table table-sm">
											<tr>
												<th width="200"><cfoutput>#obj_translater_table.get_translate('table_th_score')#</cfoutput></th>
												<td>												
												<cfif get_result_score.score neq "">
													<cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*10)>
												<cfelse>
													<cfset global_note = "0">
												</cfif>

												<cfif global_note gte 8>
													<cfset cssgo = "success">
												<cfelseif global_note gt 2 AND global_note lt 8>
													<cfset cssgo = "warning">
												<cfelseif global_note lte 2>
													<cfset cssgo = "danger">
												</cfif>
												
												<cfoutput>
												<h5 class="m-0"><span class="badge badge-pill badge-#cssgo# text-white">#global_note# / #get_quiz_score.quiz_score#</span></h5>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 2>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 4>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 6>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 8>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 10>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
												</cfoutput>
												
												</td>
											</tr>
											<tr>
												<th width="200">Analyse</th>
												
												<td><a href="common_practice.cfm" class="btn btn-outline-success"><cfoutput>#obj_translater_button.get_translate('btn_return_quiz')#</cfoutput></a></td>
											</table>
										</table>
										
									</div>
									
								</div>
								
							</div>
						</div>
					</div>
					
				</div>
							
				
				<div class="row">
					
					<div class="col-lg-10 offset-lg-1 col-md-12">
						
						<div class="card">
						
							<div class="card-body">
						
								<h4 class="card-title"><cfoutput>#get_quiz_id.quiz_name#</cfoutput> : D&eacute;tails de vos r&eacute;ponses</h4>
								<br><br>	
								<div class="table table-responsive-sm">
								<table class="table table-sm">
									<tr bgcolor="#F3F3F3">
										<!---<th>
										ID
										</th>--->
										<th>
										N&deg;
										</th>
										<th>
										Comp&eacute;tence
										</th>
										<th>
										Question
										</th>
										<th width="40%">
										Analyse r&eacute;ponse
										</th>
									</tr>
									<cfset counter = 0>
									<cfloop query="get_question">
									<cfset counter ++>
									<cfif counter/2 eq round(counter/2)><cfset color_tr = "F2F2F2"><cfelse><cfset color_tr = "FFFFFF"></cfif>
									<tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
										<!---<td><cfoutput>#get_question.qu_id#</cfoutput></td>--->
										<td><cfoutput>#get_question.qu_ranking#</cfoutput></td>
										<td>
											<cfif get_question.qu_category eq "grammar">
												<i class="fas fa-marker"></i>
											<cfelseif get_question.qu_category eq "reading">
												<i class="fas fa-book-open"></i>
											<cfelseif get_question.qu_category eq "listening">
												<i class="fas fa-volume-up"></i>
											<cfelseif get_question.qu_category eq "vocabulary">
												<i class="fas fa-book"></i>
											<cfelseif get_question.qu_category eq "comprehension">
												<i class="fas fa-book-open"></i>
											</cfif>
										</td>
										<td><cfoutput>#get_question.qu_text#</cfoutput></td>
										<td>

										<cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
										SELECT COUNT(DISTINCT(sub_id)) as nbsub
										FROM lms_quiz_answer
										WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
										</cfquery>
										
											<table class="table table-bordered table-sm">
											<cfloop from="1" to="#get_sub.nbsub#" index="sub_id">	
												<tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
												
													<cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
													SELECT ans_text, sub_id
													FROM lms_quiz_answer
													WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND ans_iscorrect = "1" AND sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
													</cfquery>
													
													<cfif not isdefined("display_result_lst")>
													<td width="50%">
													<!---<span class="label label-success">R&eacute;ponse(s) possibles</span><br>--->
													<cfset list_ok = "">
													<cfoutput query="get_answer">
													<cfset list_ok = listappend(list_ok," #ans_text# ","/")>
													</cfoutput>
													<cfoutput><i class="fas fa-check"></i> #list_ok#</cfoutput>
													</td>
													</cfif>
													
													<cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
													SELECT lqr.ans_text, lqr.iscorrect, lqa.ans_text as ans_given, lqr.ans_gain, lqa.ans_flag
													FROM lms_quiz_result lqr
													LEFT JOIN lms_quiz_answer lqa ON lqa.ans_id = lqr.ans_id
													WHERE lqr.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND lqr.sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#"> ORDER BY result_id
													</cfquery>
													
													<td width="40%">
														<cfoutput query="get_result">
														<cfif iscorrect eq "1"><i class="fas fa-check-circle" style="color:##1ca823"></i><cfelse><i class="fas fa-minus-circle" style="color:##FF0000"></i></cfif> #ans_text# #ans_given#
														<br></cfoutput>
													</td>
													

												</tr>
											
											</cfloop>	
											</table>
										
										</td>

									</tr>
									</cfloop>
								</table>
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


<cfquery name="get_max_score" datasource="#SESSION.BDDSOURCE#">
SELECT qq.qu_category, SUM(ans_gain) as total_max_score FROM lms_quiz_answer qa
INNER JOIN lms_quiz_question qq ON qq.qu_id = qa.qu_id
INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
GROUP BY qu_category
ORDER BY qu_category
</cfquery>

<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
SELECT qq.qu_category, SUM(ans_gain) as total_quiz_score FROM lms_quiz_result qr
INNER JOIN lms_quiz_question qq ON qq.qu_id = qr.qu_id
INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#"> AND qr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
GROUP BY qu_category
ORDER BY qu_category
</cfquery>

<cfset list_max_score = "">
<cfset list_quiz_score = "">
<cfset list_quiz_maxfinal = "">

<cfoutput query="get_max_score">

	<cfset list_max_score = listappend(list_max_score,total_max_score)>
	
</cfoutput>

<cfoutput query="get_quiz_score">

	<cfset valgo = listgetat(list_max_score,currentrow)>
	<!---<cfset temp = valgo-total_quiz_score>--->
	<cfif total_quiz_score neq "">
	<cfset temp2 = round((total_quiz_score/valgo)*100)>
	<cfset temp3 = 100-temp2>
	<cfelse>
	<cfset temp2 = 0>
	<cfset temp3 = 100>
	</cfif>
	
	
	<!---<cfset list_quiz_score = listappend(list_quiz_score,total_quiz_score)>
	<cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp)>--->
	<cfset list_quiz_score = listappend(list_quiz_score,temp2)>
	<cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp3)>
	
</cfoutput>

<script>

var barChartData = {
	labels: [
	<cfoutput query="get_max_score">
	<cfif qu_category eq 'grammar'>
		'#obj_translater.get_translate('js_grammar')# (#listgetat(list_quiz_score,currentrow)#%)',
	<cfelseif qu_category eq 'listening'>
		'#obj_translater.get_translate('js_writing')# (#listgetat(list_quiz_score,currentrow)#%)',
	<cfelseif qu_category eq 'reading'>
		'#obj_translater.get_translate('js_oral')# (#listgetat(list_quiz_score,currentrow)#%)',
	<cfelseif qu_category eq 'vocabulary'>
		'#obj_translater.get_translate('js_vocabulary')# (#listgetat(list_quiz_score,currentrow)#%)',
	<cfelseif qu_category eq 'comprehension'>
		'#obj_translater.get_translate('js_comprehension')# (#listgetat(list_quiz_score,currentrow)#%)',
	</cfif>
	</cfoutput>],
	datasets: [{
		label: 'Dataset 1',
		backgroundColor: '#6BD097',
		stack: 'Stack 0',
		data: [
			<cfoutput>#list_quiz_score#</cfoutput>
		]
	}, {
		label: 'Dataset 2',
		backgroundColor: '#EF8158',
		stack: 'Stack 0',
		data: [
			<cfoutput>#list_quiz_maxfinal#</cfoutput>
		]
	}]
};
var go_bar = new Chart(qpt2_result, {
	type: 'horizontalBar',
	data: barChartData,
	options: {
		title: {
			/*display: true,
			text: 'R\351partition par comp\351tence'*/
		},
		tooltips: {
			mode: 'index',
			intersect: false
		},
		responsive: true,
		scales: {
			xAxes: [{
				stacked: true,
			}],
			yAxes: [{
				stacked: true
			}]
		},
		legend: {
			display:false
		}
		}
	});
	</script>
</body>
</html>



