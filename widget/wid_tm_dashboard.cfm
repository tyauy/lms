<cfsilent>
	<cfif not isDefined("widget_name")>
		<cfquery name="get_widget_name" datasource="#SESSION.BDDSOURCE#">
			SELECT widget_id, widget_name_#SESSION.LANG_CODE# as widget_name FROM user_widget
			WHERE widget_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#view#"> 
		</cfquery>
		<cfset widget_name = get_widget_name.widget_name>
	</cfif>
	
</cfsilent>

<cfif view eq "learner_activity">

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-line fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<cfoutput>
				<table class="table table-bordered">
					<tr class="bg-light">
						<td width="30%"></td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<cfset ysel = year(dateadd('m',cor,now()))>
						<cfset ysel_short = dateformat(dateadd('m',cor,now()),'yy')>
								
						<cfset "get_lessons_scheduled_#msel#" = obj_query.oget_lessons_scheduled(tselect="#ysel#-#msel#",list_account="#al_id#")>
						<cfset "get_lessons_missed_#msel#" = obj_query.oget_lessons_missed(tselect="#ysel#-#msel#",list_account="#al_id#")>
						<cfset "get_lessons_inprogress_#msel#" = obj_query.oget_lessons_inprogress(tselect="#ysel#-#msel#",list_account="#al_id#")>
						<cfset "get_lessons_completed_#msel#" = obj_query.oget_lessons_completed(tselect="#ysel#-#msel#",list_account="#al_id#")>
						<cfset "get_lessons_cancelled_#msel#" = obj_query.oget_lessons_cancelled(tselect="#ysel#-#msel#",list_account="#al_id#")>
							
						<cfif evaluate("get_lessons_scheduled_#msel#").m neq ""><cfset "lesson_scheduled_#msel#" = evaluate("get_lessons_scheduled_#msel#").m><cfelse><cfset "lesson_scheduled_#msel#" = 0></cfif>
						<cfif evaluate("get_lessons_inprogress_#msel#").m neq ""><cfset "lesson_inprogress_#msel#" = evaluate("get_lessons_inprogress_#msel#").m><cfelse><cfset "lesson_inprogress_#msel#" = 0></cfif>
						<cfif evaluate("get_lessons_missed_#msel#").m neq ""><cfset "lesson_missed_#msel#" = evaluate("get_lessons_missed_#msel#").m><cfelse><cfset "lesson_missed_#msel#" = 0></cfif>
						<cfif evaluate("get_lessons_completed_#msel#").m neq ""><cfset "lesson_completed_#msel#" = evaluate("get_lessons_completed_#msel#").m><cfelse><cfset "lesson_completed_#msel#" = 0></cfif>
						<cfif evaluate("get_lessons_cancelled_#msel#").m neq ""><cfset "lesson_cancelled_#msel#" = evaluate("get_lessons_cancelled_#msel#").m><cfelse><cfset "lesson_cancelled_#msel#" = 0></cfif>

						<cfset "lesson_completed_#msel#" = evaluate("lesson_inprogress_#msel#")+evaluate("lesson_completed_#msel#")>

						<cfset short_month_list = #evaluate('SESSION.LISTMONTHS_SHORT_#SESSION.LANG_CODE#')#>

						<td align="center" <cfif cor eq "0">bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><label <cfif cor eq "0">class="font-weight-bold"</cfif>><a class="badge badge-info" href="<cfif isdefined("partner")>partner_lessons.cfm<cfelse>tm_lessons.cfm</cfif>?msel=#msel#&ysel=#ysel#" style="font-size:11px"><i class="fal fa-eye"></i> #listgetat("#short_month_list#",month(dateadd('m',cor,now())))# #ysel_short#</a></label></td>
						</cfloop>
					</tr>
					<tr>
						<td>#obj_translater.get_translate('table_th_active_learners')#</td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<cfset ycor = year(dateadd('m',cor,now()))>
						<cfset ycor_short = dateformat(dateadd('m',cor,now()),'yy')>
						<cfquery name="get_active_learner" datasource="#SESSION.BDDSOURCE#">
						SELECT COUNT(DISTINCT(u.user_id)) as nb FROM lms_lesson2 l
						INNER JOIN user u ON u.user_id = l.user_id
						WHERE 
						<cfif listLen(al_id) GT 1>
							u.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true">)	
							<cfelse>
							u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
						</cfif>
						AND l.lesson_start > '#ycor#-#mcor#-01' AND l.lesson_start < '#ycor#-#mcor#-31'
						AND l.status_id <> 3
						</cfquery>
						<td width="17%" align="center" <cfif cor eq "0">bgcolor="##b9e4f0" class="font-weight-bold"</cfif>>#get_active_learner.nb#</td>
						</cfloop>
					</tr>
					<tr>
						<td><span class="badge badge-warning text-white"><i class="fal fa-calendar-alt text-white"></i> #obj_translater.get_translate('badge_planned_f_p')#</span></td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<td width="17%" align="center" <cfif cor eq "0">bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_scheduled_#msel#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_scheduled_#msel#")#",unit="min")#<cfelse>-</cfif></td>
						</cfloop>
					</tr>
					<tr>
						<td><span class="badge badge-success"><i class="fal fa-thumbs-up text-white"></i> #obj_translater.get_translate('badge_completed_f_p')#</span></td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<td width="17%" align="center" <cfif cor eq "0">bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_completed_#msel#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_completed_#msel#")#",unit="min")#<cfelse>-</cfif></td>
						</cfloop>
					</tr>
					<tr>
						<td><span class="badge badge-danger"><i class="fal fa-thumbs-down text-white"></i> #obj_translater.get_translate('badge_missed_f_p')#</span></td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<td width="17%" align="center" <cfif cor eq "0">bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_missed_#msel#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_missed_#msel#")#",unit="min")#<cfelse>-</cfif></td>
						</cfloop>
					</tr>
					<tr>
						<td width=""><span class="badge badge-danger"><i class="fal fa-thumbs-down text-white"></i> #obj_translater.get_translate('badge_cancelled_f_p')#</span></td>
						<cfloop list="-2,-1,0,1" index="cor">
						<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
						<td width="17%" align="center" <cfif cor eq "0">bgcolor="##b9e4f0"class="font-weight-bold"</cfif>><cfif evaluate("lesson_cancelled_#msel#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_cancelled_#msel#")#",unit="min")#<cfelse>-</cfif></td>
						</cfloop>
					</tr>
					
				</table>	
				</cfoutput>
				
				
			</div>
		</div>
		
		
				
				
	</div>
	<div class="card-footer">
		<hr>
		<div class="pull-right">
		<a class="btn btn-sm btn-outline-info pull-right" href="<cfif isdefined("partner")>partner_lessons.cfm<cfelse>tm_lessons.cfm</cfif>"><i class="fal fa-file-excel fa-lg"></i> <cfoutput>#obj_translater.get_translate('sidemenu_tm_reports')#</cfoutput></a>
		</div>
	</div>
</div>












<cfelseif view eq "learner_rate">

	<cfset years = [#year(now())#-1, #year(now())#]>

	<cfoutput>

	<div class="card card-stats border-top border-info h-100" >
		<div class="card-body">
			<div class="row">
			
				<div class="col-8 col-md-9">
					<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")# <!---#year#---></cfoutput></h6>
				</div>
				
				<div class="col-4 col-md-3">
					<div align="center"><i class="fal fa-check-double fa-3x text-info text-center"></i></div>
				</div>

			</div>
			

			<nav>
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<cfloop array="#years#" index="year">
					<button class="nav-link <cfif year eq year(now())>active</cfif>" id="nav-home-tab" data-toggle="tab" data-target="##div_#year#" type="button" role="tab" aria-controls="nav-home" aria-selected="true">#year#</button>
					</cfloop>
				</div>
			</nav>

			<div class="tab-content" id="nav-tabContent">

				<cfloop array="#years#" index="year">

					<div class="tab-pane fade <cfif year eq year(now())>show active</cfif>" id="div_#year#" role="tabpanel" aria-labelledby="nav-home-tab">
						
						<cfset get_lessons_scheduled_year = obj_query.oget_lessons_scheduled(yselect="#year#",list_account="#al_id#")>
						<cfset get_lessons_missed_year = obj_query.oget_lessons_missed(yselect="#year#",list_account="#al_id#")>
						<cfset get_lessons_inprogress_year = obj_query.oget_lessons_inprogress(yselect="#year#",list_account="#al_id#")>
						<cfset get_lessons_completed_year = obj_query.oget_lessons_completed(yselect="#year#",list_account="#al_id#")>
						<cfset get_lessons_cancelled_year = obj_query.oget_lessons_cancelled(yselect="#year#",list_account="#al_id#")>
						<cfset get_lessons_all_year = obj_query.oget_lessons_all(yselect="#year#",list_account="#al_id#")>
					
						<cfif get_lessons_scheduled_year.nb neq ""><cfset lesson_scheduled_year = get_lessons_scheduled_year.nb><cfelse><cfset lesson_scheduled_year = 0></cfif>
						<cfif get_lessons_inprogress_year.nb neq ""><cfset lesson_inprogress_year = get_lessons_inprogress_year.nb><cfelse><cfset lesson_inprogress_year = 0></cfif>
						<cfif get_lessons_missed_year.nb neq ""><cfset lesson_missed_year = get_lessons_missed_year.nb><cfelse><cfset lesson_missed_year = 0></cfif>
						<cfif get_lessons_completed_year.nb neq ""><cfset lesson_completed_year = get_lessons_completed_year.nb><cfelse><cfset lesson_completed_year = 0></cfif>
						<cfif get_lessons_cancelled_year.nb neq ""><cfset lesson_cancelled_year = get_lessons_cancelled_year.nb><cfelse><cfset lesson_cancelled_year = 0></cfif>
						<cfif get_lessons_all_year.nb neq ""><cfset lesson_all_year = get_lessons_all_year.nb><cfelse><cfset lesson_all_year = 0></cfif>
					
						<cfset lesson_completed_year = lesson_completed_year + lesson_inprogress_year>


						<div class="row mt-4">
							<div class="col-md-12">
								<div class="chart-container" style="position: relative; min-width:300px">
									<canvas id="chart_activity_#year#"></canvas>
								</div>
								<br>
								<div align="center"><h6 class="text-muted"><small><cfoutput>#obj_translater.get_translate('table_th_cancelled_lesson_pl')# : #lesson_cancelled_year#</cfoutput></small></h6></div>
							</div>
						</div>

					</div>

					<script>
					
						<cfif lesson_all_year neq "0">
						var chart_activity_#year# = document.getElementById('chart_activity_#year#');
						var chart_activity_#year# = new Chart(chart_activity_#year#, {
							
							type: 'doughnut',	
							data: {
								labels: ['#obj_translater.get_translate('badge_completed_m_p')# : #lesson_completed_year# (#round((lesson_completed_year/lesson_all_year)*100)#%)', '#obj_translater.get_translate('badge_planned_m_p')# : #lesson_scheduled_year# (#round((lesson_scheduled_year/lesson_all_year)*100)#%)', '#obj_translater.get_translate('badge_missed_m_p')# : #lesson_missed_year# (#round((lesson_missed_year/lesson_all_year)*100)#%)'],
								datasets: [{
									
									data: [#round((lesson_completed_year/lesson_all_year)*100)#,#round((lesson_scheduled_year/lesson_all_year)*100)#,#round((lesson_missed_year/lesson_all_year)*100)#],
									backgroundColor: [
										'rgba(107, 208, 152, 0.2)',
										'rgba(251, 198, 88, 0.2)',
										'rgba(239, 129, 87, 0.2)'
									],
									borderColor: [
										'rgba(107, 208, 152, 1)',
										'rgba(251, 198, 88, 1)',				
										'rgba(239, 129, 87, 1)'
									],
									borderWidth: 1
								}]
							},
							options: {
								
								responsive:'false'
							}
							}); 
						</cfif>
					</script>
				
				</cfloop>

			</div>
		</div>
	</div>

	</cfoutput>















<cfelseif view eq "learner_distribution">



<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT f.formation_id, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_code, COUNT(o.order_id) as nb 
FROM orders o
INNER JOIN lms_formation f ON f.formation_id = o.formation_id
INNER JOIN orders_users ou ON o.order_id = ou.order_id
INNER JOIN user u ON u.user_id = ou.user_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = 3
INNER JOIN user_profile up ON up.profile_id = upc.profile_id

WHERE o.order_status_id <> 6
AND 
<cfif listLen(al_id) GT 1>
o.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>
o.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>
o.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>

AND o.order_status_id <> 6
GROUP BY formation_id
ORDER BY nb desc
</cfquery>

<cfquery name="get_count_formation" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(o.order_id) as nb 
FROM orders o
INNER JOIN lms_formation f ON f.formation_id = o.formation_id
INNER JOIN orders_users ou ON o.order_id = ou.order_id
INNER JOIN user u ON u.user_id = ou.user_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = 3
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
WHERE 
<cfif listLen(al_id) GT 1>
o.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>
o.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>
o.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>
-- AND (o.order_status_id = 3 OR o.order_status_id = 4 OR o.order_status_id = 5 OR o.order_status_id = 7 OR o.order_status_id = 10 OR o.order_status_id = 11)
AND o.order_status_id <> 6
</cfquery>

<cfquery name="get_tp_method" datasource="#SESSION.BDDSOURCE#">
SELECT m.method_id, m.method_name_#SESSION.LANG_CODE# as method_name, COUNT(t.tp_id) as nb 
FROM lms_tp t
INNER JOIN lms_lesson_method m ON m.method_id = t.method_id
INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
INNER JOIN user u ON u.user_id = tpu.user_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = 3
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
WHERE <cfif listLen(al_id) GT 1>u.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>u.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>
AND t.method_id <> 7
GROUP BY method_id
ORDER BY nb desc
</cfquery>

<cfquery name="get_count_tp_method" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(t.tp_id) as nb 
FROM lms_tp t
INNER JOIN lms_lesson_method m ON m.method_id = t.method_id
INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
INNER JOIN user u ON tpu.user_id = u.user_id
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = 3
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
WHERE <cfif listLen(al_id) GT 1>u.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>u.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>
AND t.method_id <> 7
</cfquery>

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-pie fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				
				<table class="table bg-white">
					
					<tr class="bg-light">
						<td colspan="2">
						<label><cfoutput>#obj_translater.get_translate('table_th_language')# (#get_count_formation.nb# #obj_translater.get_translate('table_th_records')#</cfoutput>)</label>
						</td>
					</tr>
					<cfoutput query="get_formation">
					<tr>
						<td width="40%">
						<span class="lang-sm" lang="#formation_code#"></span> #formation_name# (#nb#)
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:#round((nb/get_count_formation.nb)*100)#%" aria-valuenow="#round((nb/get_count_formation.nb)*100)#" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					</cfoutput>
				</table>
				
				<table class="table bg-white">
					
					<tr class="bg-light">
						<td colspan="3">
						<label><cfoutput>#obj_translater.get_translate('table_th_formation_method')# (#get_count_tp_method.nb# <cfif get_count_tp_method.nb gt 1>#obj_translater.get_translate('table_th_program_short_plural')#<cfelse>#obj_translater.get_translate('table_th_program_short')#</cfif></cfoutput>)</label>
						</td>
					</tr>
					<cfoutput query="get_tp_method">
					<tr>
						<td width="7%" align="center">
						<cfif method_id eq "1">
						<i class="fal fa-webcam fa-lg text-info"></i> 
						<cfelseif method_id eq "2">
						<i class="fal fa-user-friends fa-lg text-info"></i> 
						<cfelseif method_id eq "3">
						<i class="fal fa-laptop fa-lg text-info"></i> 
						<cfelseif method_id eq "6">
						<i class="fal fa-rocket fa-lg text-info"></i> 
						<cfelseif method_id eq "10">
							<i class="fal fa-screen-users fa-lg text-info"></i> 
						<cfelseif method_id eq "11">
							<i class="fal fa-screen-users fa-lg text-info"></i> 
						</cfif>
						</td>
						<td width="33%">
						#method_name# (#nb#)
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:#round((nb/get_count_tp_method.nb)*100)#%" aria-valuenow="#round((nb/get_count_tp_method.nb)*100)#" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					</cfoutput>
					<!---
					<tr>
						<td width="7%">
						<i class="fal fa-webcam fa-lg text-danger"></i> 
						</td>
						<td width="28%">
						Visio
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<i class="fal fa-laptop fa-lg text-danger"></i>
						</td>		
						<td>
						e-Learning
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<i class="fal fa-user-friends fa-lg text-danger"></i> 
						</td>
						<td>
						Face to Face
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<i class="fal fa-rocket fa-lg text-danger"></i> 
						</td>
						<td>
						Immersion
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-info" role="progressbar" style="width:10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
						</td>
					</tr>
					--->
					
				</table>
				
				
			</div>
		</div>
	</div>
</div>















<cfelseif view eq "order_distribution">






<div class="card card-stats border-top border-warning h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-warning m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-clipboard-list fa-3x text-warning text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
			
			<canvas id="chart_admin" height="150"></canvas>
					
					
				<!---<cfoutput>	


					<div class="tab-content" id="pills-tabContent">
					<cfloop from="2018" to="#year(now())#" index="y">
					<div class="tab-pane fade <cfif y eq year(now())>active show</cfif>" id="pills-#y#" role="tabpanel" aria-labelledby="pills-home-tab">
						<cfif y eq "2020">	
						</cfif>
					</div>
					</cfloop>
					</div>


					<ul class="nav nav-pills mb-3 pull-right" id="pills-tab" role="tablist">
					<cfloop from="2018" to="#year(now())#" index="y">
					<li class="nav-item" role="presentation">
					<a class="nav-link py-1 px-2 <cfif y eq year(now())>active</cfif>" id="pills-home-tab" data-toggle="pill" href="##pills-#y#" role="tab" aria-controls="pills-#y#" aria-selected="true">#y#</a>
					</li>
					</cfloop>
					</ul>
				</cfoutput>	---->
				
			</div>
		</div>
	</div>
</div>


<cfquery name="get_list_context" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(o.context_id) as context_id, oc.context_alias, oc.context_color FROM orders o
INNER JOIN order_context oc ON oc.context_id = o.context_id

WHERE 
<cfif listLen(al_id) GT 1>
account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>
account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>
account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>
</cfquery>

<cfset list_context = "">
<cfoutput query="get_list_context">
<cfset list_context = listappend(list_context,"#context_id#|#context_alias#|#context_color#")>
</cfoutput>

<cfquery name="get_list_date" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(DATE_FORMAT(order_date,"%Y")) as date_id FROM orders WHERE
<cfif listLen(al_id) GT 1>
account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>
account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>
account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>
ORDER BY order_date ASC
</cfquery>

<cfset list_date = "">
<cfoutput query="get_list_date">
<cfset list_date = listappend(list_date,date_id)>
</cfoutput>




<!--- <cfquery name="get_order_count" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(o.order_id) as nb, oc.context_alias, oc.context_id, oc.context_color, DATE_FORMAT(order_date,"%Y") as date_id
FROM orders o
INNER JOIN order_context oc ON oc.context_id = o.context_id

<cfif listLen(al_id) GT 1>
WHERE account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
<cfelseif SESSION.ACCOUNT_ID eq 0>
WHERE account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
<cfelse>
WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
</cfif>

GROUP BY date_id, o.context_id
ORDER BY date_id
</cfquery> --->

<script>


var chart_admin = document.getElementById('chart_admin');
var chart_admin = new Chart(chart_admin, {
    type: 'bar',
    data: {
		labels: [<cfloop list="#list_date#" index="cor_y"><cfoutput>#cor_y#,</cfoutput></cfloop>],
        datasets: [
		
		<cfloop list="#list_context#" index="cor_1">		
		<cfoutput>
		
		
		{
			label: [
               '#listgetat(cor_1,2,"|")#',
            ],

			backgroundColor:'#replacenocase(listgetat(cor_1,3,"|"),"-",",","ALL")#',
            data: [
			<cfloop list="#list_date#" index="cor_2">
				<cfinvoke component="api/orders/orders_get" method="oget_orders" returnvariable="get_orders">
					<cfinvokeargument name="list_account" value="#al_id#">
					<cfinvokeargument name="y_id" value="#MID(cor_2, 3, 2)#">
					<cfinvokeargument name="context_id" value="#listgetat(cor_1,1,"|")#">
				</cfinvoke>

			#get_orders.recordcount#,
			</cfloop>
			]
        },
		
		</cfoutput>		
		</cfloop>


		<!---<cfoutput query="get_order_count">
		// {
		// 	label: [
        //        '#context_alias#',
        //     ],

		// 	backgroundColor:'#context_color#',
        //     data: [
		// 		<cfoutput group="date_id">#nb#,</cfoutput>

		// 	]
        // },
		// </cfoutput>	---->
		
												
												
       
       /*{
            label: "Red",
            fillColor: "red",
            data: [4,3,5]
        },
        {
            label: "Green",
            fillColor: "green",
            data: [7,2,6]
        },
        {
            label: "Green",
            fillColor: "green",
            data: [7,2,6]
        }*/
    ]
	/*datasets: [{
            label: 'Nb de dossiers',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1
        }]*/
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});



</script>















<cfelseif view eq "order_list">


<cfif NOT isDefined("list_date")>

	<cfquery name="get_list_date" datasource="#SESSION.BDDSOURCE#">
		SELECT DISTINCT(DATE_FORMAT(order_date,"%Y")) as date_id FROM orders WHERE
		<cfif listLen(al_id) GT 1>account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true" >)
		<cfelseif SESSION.ACCOUNT_ID eq 0>account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ACCOUNT_RIGHT_ID#" list="true" >)
		<cfelse>account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
		</cfif>
		ORDER BY order_date ASC
	</cfquery>
			
	<cfset list_date = "">
	<cfoutput query="get_list_date">
	<cfset list_date = listappend(list_date,date_id)>
	</cfoutput>
</cfif>






<div class="card card-stats border-top border-warning h-100">
	<div class="card-body">
		<div class="row">
			
			<div class="col-8 col-md-9">
				<h6 class="text-warning m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-users-cog fa-3x text-warning text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				
				<table class="table bg-white">
					

					<!---<div>
						<h6 class="text-warning d-inline"></h6>
						<a class="btn btn-sm btn-warning pull-right p-0 m-1" data-toggle="collapse" href="#collapse_pricing" role="button" aria-expanded="false" aria-controls="collapse_pricing">+</a>
					</div>
					<div class="collapse clearfix mt-2" id="collapse_pricing">
						<table class="table">
						
						
					</table>
					</div>--->
						<tr class="bg-light">
							<td colspan="<cfoutput>#listlen(list_date)#</cfoutput>">
							<label><cfoutput>#obj_translater.get_translate('table_th_training_records')#</cfoutput></label>
							</td>
						</tr>
						<tr align="center">
							<cfloop list="#list_date#" index="cor">
							<td><strong><cfoutput>#cor#</cfoutput></strong></td>
							</cfloop>
						</tr>
						
						<tr align="center">
							<cfloop list="#list_date#" index="cor">
								<cfinvoke component="api/orders/orders_get" method="oget_orders" returnvariable="get_orders">
									<cfinvokeargument name="list_account" value="#al_id#">
									<cfinvokeargument name="y_id" value="#MID(cor, 3, 2)#">
								</cfinvoke>
								<td><cfoutput>#get_orders.recordcount#</cfoutput></td>
							</cfloop>
						</tr>
						
						<!--- <tr class="bg-light"> --->
							<!--- <td colspan="3"> --->
							<!--- <label><cfoutput>#obj_translater.get_translate('table_th_pricing_table')#</cfoutput></label> --->
							<!--- </td> --->
						<!--- </tr> --->
						<!--- <cfif SESSION.GROUP_PRICE_REDUCTION neq "0"> --->
						<!--- <tr> --->
							<!--- <th class="bg-light" width="50%">Prix catalogue</th> --->
							<!--- <td class="bg-white">-<cfoutput>#SESSION.GROUP_PRICE_REDUCTION#</cfoutput> % sur prix public</td> --->
						<!--- </tr> --->
						<!--- </cfif>		 --->
						<!--- <cfif get_price_unit.recordcount neq "0"> --->
							<!--- <cfoutput> --->
								<!--- <cfloop list="#list_formation#" index="cor"> --->
								<!--- <cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#"> --->
								<!--- SELECT formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> --->
								<!--- </cfquery> --->
									<!--- <cfset col = evaluate("get_price_unit.price_#cor#")> --->
									<!--- <tr> --->
										<!--- <th class="bg-light"><span class="lang-sm" lang="#get_formation_solo.formation_code#"></span> #get_formation_solo.formation_name#</th> --->
										<!--- <td class="bg-white">#numberformat(col,'____')# &euro;</td> --->
									<!--- </tr>	 --->
								<!--- </cfloop> --->
							<!--- </cfoutput> --->
						<!--- <cfelse> --->
							<!--- <tr> --->
							<!--- <td colspan="3"> --->
							<!--- <small><em>Donn&eacute;es non applicables pour le moment</em></small> --->
							<!--- </td> --->
							<!--- </tr> --->
						<!--- </cfif> --->
						
					</table>
				</div>
			</div>
		</div>
		
	<!--- <div class="card-footer"> --->
		<!--- <hr> --->
		<!--- <div class="pull-right"> --->
		<!--- <a disabled class="btn btn-sm btn-outline-warning" href="tm_estimate_create.cfm"><i class="fal fa-file-invoice-dollar fa-lg"></i> <cfoutput>#obj_translater.get_translate('btn_generate_estimate')#</cfoutput></a> --->
		<!--- <a disabled class="btn btn-sm btn-outline-warning" href="tm_order_create.cfm?a_id=#a_id#"><i class="fal fa-user-plus fa-lg"></i> <cfoutput>#obj_translater.get_translate('btn_generate_convention')#</cfoutput></a> --->
		<!--- </div> --->
	<!--- </div> --->
</div>
					
	
	
	
	
	
	
	
	
	
	
	
	
	
<cfelseif view eq "learner_rating">	
	
	
	
	
<div class="card card-stats border-top border-success h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-success m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-star fa-3x text-success text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
				SELECT ROUND(AVG(rating_support),'2') as rating_support, ROUND(AVG(rating_teaching),'2') as rating_teaching FROM lms_rating
				</cfquery>
				<cfquery name="get_sum_t" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(rating_id) as rating_t_count FROM lms_rating WHERE rating_teaching IS NOT NULL
				</cfquery>
				<cfquery name="get_sum_s" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(rating_id) as rating_s_count FROM lms_rating WHERE rating_support IS NOT NULL
				</cfquery>
				<cfloop from="1" to="5" index="cor">
					<cfquery name="get_notation_t_#cor#" datasource="#SESSION.BDDSOURCE#">
					SELECT ROUND((COUNT(rating_id)/#get_sum_t.rating_t_count#)*100) as rating_t_count FROM lms_rating WHERE rating_teaching = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
					</cfquery>
					<cfquery name="get_notation_s_#cor#" datasource="#SESSION.BDDSOURCE#">
					SELECT ROUND((COUNT(rating_id)/#get_sum_s.rating_s_count#)*100) as rating_s_count FROM lms_rating WHERE rating_support = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
					</cfquery>
				</cfloop>
				<cfoutput>
				<table class="table">
					<tr class="bg-light">
						<td></td>
						<td width="35%"><label>#obj_translater.get_translate('table_th_trainers')#</label></td>
						<td width="35%"><label>#obj_translater.get_translate('table_th_material')#</label></td>
					</tr>
					<tr>
						<td></td>
						<td><h3 class="m-0">#get_notation.rating_teaching#/5</h3></td>
						<td><h3 class="m-0">#get_notation.rating_support#/5</h3></td>
					</tr>
					<tr>
						<td>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_t_5.rating_t_count#%" aria-valuenow="#get_notation_t_5.rating_t_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_t_5.rating_t_count neq "0">#get_notation_t_5.rating_t_count#%</cfif></div>
						</div>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_s_5.rating_s_count#%" aria-valuenow="#get_notation_s_5.rating_s_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_s_5.rating_s_count neq "0">#get_notation_s_5.rating_s_count#%</cfif></div>
						</div>
						</td>
					</tr>	
					<tr>
						<td>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_t_4.rating_t_count#%" aria-valuenow="#get_notation_t_4.rating_t_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_t_4.rating_t_count neq "0">#get_notation_t_4.rating_t_count#%</cfif></div>
						</div>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_s_4.rating_s_count#%" aria-valuenow="#get_notation_s_4.rating_s_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_s_4.rating_s_count neq "0">#get_notation_s_4.rating_s_count#%</cfif></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_t_3.rating_t_count#%" aria-valuenow="#get_notation_t_3.rating_t_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_t_3.rating_t_count neq "0">#get_notation_t_3.rating_t_count#%</cfif></div>
						</div>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_s_3.rating_s_count#%" aria-valuenow="#get_notation_s_3.rating_s_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_s_3.rating_s_count neq "0">#get_notation_s_3.rating_s_count#%</cfif></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_t_2.rating_t_count#%" aria-valuenow="#get_notation_t_2.rating_t_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_t_2.rating_t_count neq "0">#get_notation_t_2.rating_t_count#%</cfif></div>
						</div>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_s_2.rating_s_count#%" aria-valuenow="#get_notation_s_2.rating_s_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_s_2.rating_s_count neq "0">#get_notation_s_2.rating_s_count#%</cfif></div>
						</div>
						</td>
					</tr>
					<tr>
						<td>
							<span class="float-left"><i class="text-success fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
							<span class="float-left"><i class="text-secondary fa fa-star"></i></span>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_t_1.rating_t_count#%" aria-valuenow="#get_notation_t_1.rating_t_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_t_1.rating_t_count neq "0">#get_notation_t_1.rating_t_count#%</cfif></div>
						</div>
						</td>
						<td>
						<div class="progress">
						<div class="progress-bar bg-success" role="progressbar" style="width:#get_notation_s_1.rating_s_count#%" aria-valuenow="#get_notation_s_1.rating_s_count#" aria-valuemin="0" aria-valuemax="100"><cfif get_notation_s_1.rating_s_count neq "0">#get_notation_s_1.rating_s_count#%</cfif></div>
						</div>
						</td>
					</tr>
				</table>
				</cfoutput>
			</div>
		</div>
	</div>
</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<cfelseif view eq "learner_launch" OR view eq "learner_deadline" OR view eq "learner_missed" OR view eq "learner_nnl">	
	
<cfloop list="launch,deadline,missed,nnl" index="cor">

<cfquery name="get_orders_#cor#" datasource="#SESSION.BDDSOURCE#">
SELECT 
a.account_name, a.account_id,
o.order_end, 
u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
oim.order_item_mode_name, 
ofi.status_finance_name, ofi.status_finance_css,
<!--- otm.status_tm_name, otm.status_tm_css, --->

a2.account_name as opca_name, 
u.user_firstname, u.user_name,
f.formation_id, f.formation_code,
t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
tpd.*,
tpc.*,
tpe.*,
ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
s.sessionmaster_id, l.status_id, l.lesson_start,
st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
SUM(s.session_duration) as session_duration,
MAX(l.lesson_start) as max_lesson,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed


FROM lms_tp t

INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
INNER JOIN lms_lesson_method lm ON lm.method_id = t.method_id
INNER JOIN lms_formation fo ON fo.formation_id = t.formation_id

LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id


INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
INNER JOIN user u ON u.user_id = tpu.user_id
INNER JOIN user_status st ON st.user_status_id = u.user_status_id

LEFT JOIN orders_users ou ON ou.user_id = u.user_id
LEFT JOIN orders o ON ou.order_id = o.order_id
LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
LEFT JOIN order_context oc ON oc.context_id = o.context_id

INNER JOIN account a ON a.account_id = u.account_id

INNER JOIN account a2 ON o.account_id = a2.account_id
INNER JOIN account_group ag ON ag.group_id = a2.group_id
LEFT JOIN lms_formation f ON f.formation_id = o.formation_id







WHERE u.user_status_id <> 5

<cfif listLen(al_id) GT 1>
	AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#al_id#" list="true">)	
<cfelseif SESSION.ACCOUNT_ID neq "0">
	AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.ACCOUNT_ID#">
<cfelse>
	AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#">
</cfif>

<cfif cor eq "launch">
AND t.method_id IN (1,2,6)
AND (t.tp_status_id = 1 OR t.tp_status_id = 6)
</cfif>

<cfif cor eq "nnl">
AND t.method_id IN (1,2,6)
AND (t.tp_status_id = 2)
</cfif>

<cfif cor eq "missed">
AND t.method_id IN (1,2,6)
AND (t.tp_status_id = 2)
</cfif>

<cfif cor eq "deadline">
AND t.method_id IN (1,2,6)
AND (t.tp_status_id = 2 OR t.tp_status_id = 3)
AND o.order_end <= #dateadd('m',+2,now())# 
AND o.order_status_id <> 10
AND o.order_status_id <> 11
AND o.order_status_id <> 6
</cfif>

GROUP BY t.tp_id

<cfif cor eq "nnl">
HAVING max_lesson < now()
ORDER BY max_lesson ASC
</cfif>

<cfif cor eq "missed">
HAVING tp_missed > 0
ORDER BY tp_missed DESC
</cfif>

<cfif cor eq "deadline">
ORDER BY order_end ASC
</cfif>



</cfquery>


</cfloop>
	
	
	
<cfif view eq "learner_launch">

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-line fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<cfif get_orders_launch.recordcount eq "0">
				<div class="alert bg-light text-dark border">
				<cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput>
				</div>
				<cfelse>
				<table class="table table-sm table-bordered">
					<tr class="bg-light">
						<td width="50%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="20%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
						<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
					</tr>
					<cfoutput query="get_orders_launch" startrow="1" maxrows="5">
					<tr>
						<td><small>#user_firstname# #user_name#</small><br>#account_name#</td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
						<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
					</tr>
					</cfoutput>
				</table>
				</cfif>
			</div>
		</div>
			
	</div>
	<cfif get_orders_launch.recordcount gt 5>
	<div class="card-footer">
		<hr>
		<div class="pull-right">
		<button type="button" class="btn btn-sm btn-info btn_view_list" id="view_launch"><cfoutput>#obj_translater.get_translate('btn_view_total_list')#</cfoutput></button>
		</div>
	</div>
	</cfif>
</div>

<cfelseif view eq "learner_deadline">

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-line fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<cfif get_orders_deadline.recordcount eq "0">
				<div class="alert bg-light text-dark border">
				<cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput>
				</div>
				<cfelse>
				<table class="table table-sm table-bordered">
					<tr class="bg-light">
						<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="20%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
						<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
						<td><cfoutput>#obj_translater.get_translate('table_th_deadline')#</cfoutput></td>
					</tr>
					<cfoutput query="get_orders_deadline" startrow="1" maxrows="5">
					<tr>
						<td><small><small>#user_firstname# #user_name#</small><br>#account_name#</td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
						<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
						<td><cfif order_end lt now()><div class="badge badge-pîll badge-danger" style="font-size:15px">#obj_dater.get_dateformat(order_end)#</div><cfelse><div class="badge badge-pîll badge-warning text-white" style="font-size:15px">#obj_dater.get_dateformat(order_end)#</div></cfif></td>
					</tr>
					</cfoutput>
				</table>
				</cfif>
			</div>
		</div>
			
	</div>
	<cfif get_orders_deadline.recordcount gt 5>
	<div class="card-footer">
		<hr>
		<div class="pull-right">
		<button type="button" class="btn btn-sm btn-info btn_view_list" id="view_deadline"><cfoutput>#obj_translater.get_translate('btn_view_total_list')#</cfoutput></button>
		</div>
	</div>
	</cfif>
</div>

<cfelseif view eq "learner_missed">	

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-line fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<cfif get_orders_missed.recordcount eq "0">
				<div class="alert bg-light text-dark border">
				<cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput>
				</div>
				<cfelse>
				<table class="table table-sm table-bordered">
				<tr class="bg-light">
					<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
					<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="15%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
					<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
					<td><cfoutput>#obj_translater.get_translate('table_th_missed_lesson')#</cfoutput></td>
					<td><cfoutput>#obj_translater.get_translate('table_th_missed_ratio')#</cfoutput></td>
				</tr>
				<cfoutput query="get_orders_missed" startrow="1" maxrows="5">
				<tr>
					<td><small>#user_firstname# #user_name#</small><br>#account_name#</td>
					<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
					<td>#tp_duration/60# h</td>
					<td>#obj_lms.get_format_hms(toformat="#tp_missed#",unit="min")#</td>
					<!--- <td>#obj_lms.get_formath(tp_missed)# h</td> --->
					<td><div class="badge badge-pîll badge-danger" style="font-size:15px">#round(tp_missed/tp_duration*100)# %</div></td>										
				</tr>
				</cfoutput>
			</table>
				</cfif>
			</div>
		</div>
			
	</div>
	<cfif get_orders_missed.recordcount gt 5>
	<div class="card-footer">
		<hr>
		<div class="pull-right">
		<button type="button" class="btn btn-sm btn-info btn_view_list" id="view_missed"><cfoutput>#obj_translater.get_translate('btn_view_total_list')#</cfoutput></button>
		</div>
	</div>
	</cfif>
</div>

<cfelseif view eq "learner_nnl">

<div class="card card-stats border-top border-info h-100">
	<div class="card-body">
		<div class="row">
		
			<div class="col-8 col-md-9">
				<h6 class="text-info m-2 text-center"><cfoutput>#REReplace(widget_name,"['\n']","","all")#</cfoutput></h6>
			</div>
			
			<div class="col-4 col-md-3">
				<div align="center"><i class="fal fa-chart-line fa-3x text-info text-center"></i></div>
			</div>
			
		</div>
		
		<div class="row mt-4">
			<div class="col-md-12">
				<!--- <cfdump var="#get_orders_nnl#"> --->
				<cfif get_orders_nnl.recordcount eq "0">
				<div class="alert bg-light text-dark border">
				<cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput>
				</div>
				<cfelse>
				<table class="table table-sm table-bordered">
					<tr class="bg-light">
						<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="15%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
						<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
						<td><cfoutput>#obj_translater.get_translate('table_th_last_activity')#</cfoutput></td>
						<td><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></td>
					</tr>
					<cfoutput query="get_orders_nnl" startrow="1" maxrows="5">
					<tr>
						<td><small>#user_firstname# #user_name#</small><br>#account_name#</td>
						<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
						<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
						<td><cfif max_lesson lt dateadd("m",-2,now())><div class="badge badge-pîll badge-danger" style="font-size:15px">#obj_dater.get_dateformat(max_lesson)#</div><cfelse><div class="badge badge-pîll badge-warning text-white" style="font-size:15px">#obj_dater.get_dateformat(max_lesson)#</div></cfif></td>
						<td>
						<cfif max_lesson gte dateadd("d",-7,now())>
						<small>#obj_translater.get_translate('text_no_course_planned')#</small>
						<cfelse>						
						<cfset day_duration = datediff("d",max_lesson,now())>
						<cfset arr = ['day_duration']>
						<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
						<small>#obj_translater.get_translate_complex(id_translate="text_no_activity", argv="#argv#")#</small>
						
						</cfif>
						</td>								
					</tr>
					</cfoutput>
				</table>
				</cfif>
			</div>
		</div>
			
	</div>
	<cfif get_orders_nnl.recordcount gt 5>
	<div class="card-footer">
		<hr>
		<div class="pull-right">
		<button type="button" class="btn btn-sm btn-info btn_view_list" id="view_nnl"><cfoutput>#obj_translater.get_translate('btn_view_total_list')#</cfoutput></button>
		</div>
	</div>
	</cfif>
</div>

</cfif>
	
<script>
$(document).ready(function() {

	$('.btn_view_list').click(function(event) {	
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var view = idtemp[1];	
		
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		if(view == "launch"){$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_list_launching'))#</cfoutput>");}
		else if(view == "deadline"){$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_list_deadline'))#</cfoutput>");}
		else if(view == "missed"){$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_list_missed'))#</cfoutput>");}
		else if(view == "nnl"){$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_list_nnl'))#</cfoutput>");}
		
		$('#modal_body_xl').load("modal_window_tm.cfm?view="+view, function() {});
	});
	
});
</script>
	
	
</cfif>