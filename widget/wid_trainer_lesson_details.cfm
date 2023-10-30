<!--- <cfsilent> --->

	<!--- //todo put a switch in cs_invoicing to see all/paid miss only --->
<cfif not isDefined("pmissed")><cfset pmissed = 0></cfif>


<!--- <cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT status_id, status_name_#SESSION.LANG_CODE# as status_name, status_css, status_bootstrap FROM lms_lesson_status WHERE status_id <> 3 UNION (SELECT 0 as status_id, "#obj_translater.get_translate('global_all')#" as status_name, "" as status_css, "" as status_bootstrap) ORDER BY status_id
</cfquery>

<cfdump var="#get_lesson_status#">

<cfoutput query="get_lesson_status">

	<cfset "get_lesson_#status_id#" = obj_query.oget_lessons(st_id="#status_id#",period_month="#period_month#",pmissed="#pmissed#")>

</cfoutput> --->

<!--- <cfset get_lessons = obj_query.oget_lessons(st_id="5",period_month="#tselect#",orderby="trainer",pmissed="1",invoicing="1")> --->
<cfif use_date eq 0>
	<cfset get_lessons = obj_query.oget_lessons(p_id="#p_id#",st_id="5",period_month="#tselect#",orderby="trainer_firstname",pmissed="1",invoicing="1")>
<cfelse>
	<cfset get_lessons = obj_query.oget_lessons(p_id="#p_id#",st_id="5",start_range="#start_date#",end_range="#end_date#",orderby="trainer_firstname",pmissed="1",invoicing="1")>
</cfif>


<!--- </cfsilent> --->


<div class="tab-content" id="myTabContent">

		<cfif get_lessons.recordCount neq "0">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">		
				<div class="table table-responsive-sm">
					
					<cfset SESSION.TRAINER_EXPORT_LIST = "">

					<cfoutput query="get_lessons" group="planner_id">

						<cfset SESSION.TRAINER_EXPORT_LIST = listAppend(SESSION.TRAINER_EXPORT_LIST, get_lessons.planner_id)>

						<div class="row">
							
							<div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title trainer_title" data-id="#planner_id#">#planner_firstname#</h4>

										<cfif use_date eq 0>
											<!--- <a type="button" target="_blank" href="tpl/invoice_trainer_container.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a> --->
										<a type="button" target="_blank" href="./finance_trainer_invoice_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a>
										<a type="button" target="_blank" href="./tpl/invoice_trainer_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-eye"></i></a>
										<cfelse>
											<a type="button" target="_blank" href="./finance_trainer_invoice_view.cfm?use_date=#use_date#&start_date=#start_date#&end_date=#end_date#&p_id=#planner_id#"><i class="far fa-download"></i></a>
											<a type="button" target="_blank" href="./tpl/invoice_trainer_view.cfm?use_date=#use_date#&start_date=#start_date#&end_date=#end_date#&p_id=#planner_id#"><i class="far fa-eye"></i></a>
										</cfif>
										
                                    </div>
                                </div>
                            </div>

						</div>
						<div class="row">

							<table class="table table-hover">
							
								<tr bgcolor="##F3F3F3">
									<th width="5%"><label>#obj_translater.get_translate('table_th_status')#</label></th>
									<th width="6%"><label>#obj_translater.get_translate('table_th_trainer')#</label></th>
									<th width="12%"><label>#obj_translater.get_translate('table_th_learner')#</label></th>
									<th width="8%"><label>#obj_translater.get_translate('table_th_tp')#</label></th>
									<th width="5%"><label>order_id</label></th>
									<th width="16%"><label>#obj_translater.get_translate('table_th_course')#</label></th>
									<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
									<th width="10%"><label>#obj_translater.get_translate('table_th_provider')#</label></th>
									<th width="8%"><label>Lesson</label></th>
									<th width="8%"><label>Completed</label></th>
									<th width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
									<th width="5%"><label>PRICE/H</label></th>
									<th width="5%"><label>AMOUNT</label></th>
								</tr>

								<cfset total_dur = 0>
								<cfset total_amount = 0>
								<cfoutput>
									<tr>
										<td>
											<span class="badge badge-#status_css#">#status_name#</span>
										</td>
										<td>
											#planner_firstname#
										</td>
										<td>
											<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a>
										</td>
										<td>
											<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#<cfelse>-</cfif></a>
										</td>
										<td>
											#order_ref#
										</td>
										<td>
											<!---<span class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#" style="cursor:pointer">?</span>--->	
											<cfif len(sessionmaster_name) gt "25">
											#mid(sessionmaster_name,1,25)# [...]
											<cfelse>
											#sessionmaster_name#
											</cfif>
										</td>
										<td>
											<img src="./assets/img/picto_methode_#method_id#.png" width="20" style="margin-right:2px">
										</td>
										<td>
											#provider_name#
										</td>
										<td>
											#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#
										</td>
										<td>
											#dateformat(completed_date,'dd/mm/yyyy')# #timeformat(completed_date,'HH:mm')#
										</td>
										<td>
											#lesson_duration# min

											<cfset total_dur = total_dur + lesson_duration>

										</td>
										<td>
											#numberformat(pricing_amount,"____.__")# &euro;
										</td>
										<td>
											<cfset tmp_amount = pricing_amount neq "" ? pricing_amount : 0>
											<cfset total_amount = total_amount + (tmp_amount * (lesson_duration / 60))>

											#numberformat(tmp_amount * (lesson_duration / 60),"____.__")# &euro;


										</td>
									</tr>
								</cfoutput>
								<tr bgcolor="##ECECEC">
									<td colspan="8"></td>
									<td>Duration :</td>
									<td>#numberformat(total_dur / 60,"____.__")#H</td>
									<td>Total :</td>
									<td>#numberformat(total_amount,"____.__")# &euro;</td>
								</tr>

								<cfset total = total+total_amount>

								<!--- <tbody>
								<cfset table_display = "header">
								<cfinclude template="./tab_lesson_cs_list.cfm">
						
								
								<cfoutput query="get_lesson_#status_id#">
								
								<cfset table_display = "body">
								<cfinclude template="./tab_lesson_cs_list.cfm">
								
								</cfoutput>
								</tbody> --->
								
							</table>
						</div>
						
					</cfoutput>
				</div>
			</div>
		</div>
		<cfelse>
		<div class="row justify-content-md-center" style="margin-top:15px">

			<div class="col-md-6">
				<div class="alert alert-secondary" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput></em></div>
				</div>
			</div>

		</div>
		</cfif>

</div>
