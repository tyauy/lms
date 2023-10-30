<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">

	<cfif SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1>
		<cflocation addtoken="no" url="index.cfm?pconnect=1">
	</cfif>

	<cfparam name="from_msel" default="01">

	<cfif SESSION.LANG_CODE neq "fr">
		<cfset from_mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),from_msel)>
	<cfelse>
		<cfset from_mlongsel = listgetat(SESSION.LISTMONTHS,from_msel)>
	</cfif>
	<cfset from_msel = listgetat(SESSION.LISTMONTHS_CODE,from_msel)>

	<cfparam name="to_msel" default="#month(now())#">

	<cfif SESSION.LANG_CODE neq "fr">
		<cfset to_mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),to_msel)>
	<cfelse>
		<cfset to_mlongsel = listgetat(SESSION.LISTMONTHS,to_msel)>
	</cfif>
	<cfset to_msel = listgetat(SESSION.LISTMONTHS_CODE,to_msel)>

	<cfparam name="from_ysel" default="#year(now())#">
	<cfparam name="from_tselect" default="#from_ysel#-#from_msel#">
	<cfparam name="to_ysel" default="#year(now())#">
	<cfparam name="to_tselect" default="#to_ysel#-#to_msel#">
	<cfparam name="p_id" default="0">
	<cfparam name="pmissed" default="0">

	<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id, user_firstname, user_name FROM user u
		WHERE profile_id = 4
		AND user_paid_global = 1
		ORDER BY user_firstname
	</cfquery>

	<!--- GET TABLE INFO --->
	<cfquery name="get_invoice_total" datasource="#SESSION.BDDSOURCE#">
		SELECT ii.user_invoice_info_id, ii.user_invoice_info_selector, ii.user_invoice_info_amount, ii.user_invoice_info_duration,
		ii.user_invoice_info_payed, ii.user_invoice_info_mail_sent, ii.user_invoice_info_path, ii.user_invoice_info_date, ii.user_invoice_info_modified,
		u.user_id as planner_id, u.user_firstname as planner_firstname, u.user_name, u.user_email, u.user_lang
		FROM user_invoice_info ii
		INNER JOIN user u ON u.user_id = ii.user_invoice_info_user


		WHERE user_invoice_info_selector BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#from_tselect#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#to_tselect#">

		<!--- IF TRAINER IS GIVEN WE CHECK FOR TRAINER OR ALL --->
		<cfif p_id neq 0>
		AND ii.user_invoice_info_user = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		</cfif>

		ORDER BY u.user_firstname, ii.user_invoice_info_selector ASC
	</cfquery>


	<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
	<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
	<cfset __tooltip_fill_pta = obj_translater.get_translate('tooltip_fill_pta')>
	<cfset __tooltip_fill_na = obj_translater.get_translate('tooltip_fill_na')>
	<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>
	<cfset __tooltip_cancel_lesson = obj_translater.get_translate('tooltip_cancel_lesson')>

	<cfset __btn_support_short = obj_translater.get_translate('btn_support_short')>
	<cfset __btn_notes_short = obj_translater.get_translate('btn_notes_short')>
	<cfset __btn_fill_notes = obj_translater.get_translate('btn_fill_notes')>
	<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
</style>

<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "Lesson list">
			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">
				<div class="row" style="margin-top:10px">

					<div class="col-md-12">
						<div class="card border-top border-info" style="min-height:140px">						
							<div class="card-body">
								<h4 class="card-title">S&eacute;lection : <cfoutput>#from_mlongsel# #from_ysel# to #to_mlongsel# #to_ysel#</cfoutput></h4>
								<div class="row">
									<div class="col-md-12 mt-4">
										<cfform action="cs_invoicing_yearly.cfm">
											<div class="form-row">
												<div class="col">
													<cfselect class="form-control" name="p_id" query="get_trainers" value="user_id" display="user_firstname" selected="#p_id#">
														<option value="0" <cfif p_id eq "0">selected</cfif>>---ALL TRAINERS----</option>
													</cfselect>
												</div>

												<div class="col">
													<select class="form-control" name="from_msel">

														<cfloop from="1" to="12" index="m">
															<cfoutput>
																<cfif SESSION.LANG_CODE neq "fr">
																	<option value="#m#" <cfif from_msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
																<cfelse>
																	<option value="#m#" <cfif from_msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
																</cfif>


															</cfoutput>
														</cfloop>
													</select>
												</div>

												<div class="col">

													<select class="form-control" name="from_ysel">
														<cfloop from="2019" to="#year(now())#" index="y">
															<cfoutput>
																<option value="#y#" <cfif from_ysel eq y>selected="selected"</cfif>>#y#</option>
															</cfoutput>
														</cfloop>
													</select>

												</div>

												<div class="col">
													<cfoutput>
														<input type="submit" value="GO" class="btn btn-info">
														<a href="exporter/export_invoicing_yearly.cfm?p_id=#p_id#&from_tselect=#from_tselect#&to_tselect=#to_tselect#" class="btn btn-success">Export</a>

													</cfoutput>
												</div>
											</div>
											<div class="form-row">
												<div class="col">
													
												</div>

												<div class="col">
													<select class="form-control" id="to_msel" name="to_msel">

														<cfloop from="1" to="12" index="m">
															<cfoutput>
																<cfif SESSION.LANG_CODE neq "fr">
																	<option value="#m#" <cfif to_msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
																<cfelse>
																	<option value="#m#" <cfif to_msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
																</cfif>


															</cfoutput>
														</cfloop>
													</select>
												</div>

												<div class="col">

													<select class="form-control" name="to_ysel">
														<cfloop from="2019" to="#year(now())#" index="y">
															<cfoutput>
																<option value="#y#" <cfif to_ysel eq y>selected="selected"</cfif>>#y#</option>
															</cfoutput>
														</cfloop>
													</select>

													<!--- <cfoutput><a href="cs_invoicing.cfm" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput> --->
												</div>

												<div class="col">
													<cfoutput>
														<a href="exporter/export_invoicing_yearly_all.cfm?from_tselect=#from_tselect#&to_tselect=#to_tselect#" class="btn btn-success">Export ALL</a>
													</cfoutput>
												</div>
											</div>
										</cfform>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



				<div class="row">

					<div class="col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">

								<!--- REMOVE THE IF TO ALLOW ALL TRAINER QUERY --->
								<!--- <cfif p_id neq 0>

								<cfquery name="get_total" datasource="#SESSION.BDDSOURCE#">
									SELECT SUM(l.lesson_duration) as total_dur, SUM( (pricing_amount * (l.lesson_duration / 60) )) as amount_total, 
									pricing_amount, cat.cat_name_#SESSION.LANG_CODE# as cat_name, f.formation_code,
									lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias,
									DATE_FORMAT(l.completed_date, "%Y-%m") as _date,
									u.user_id as planner_id, u.user_firstname as planner_firstname, u.user_name, u.user_email, u.user_lang
									FROM lms_lesson2 l
									INNER JOIN lms_tpsession s ON s.session_id = l.session_id
									INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
									INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
									INNER JOIN lms_lesson_method lm ON lm.method_id = tp.method_id
									INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
									INNER JOIN user u ON u.user_id = l.planner_id
									INNER JOIN user_pricing uprice ON uprice.user_id = u.user_id 
									INNER JOIN lms_tpsession_category cat ON cat.cat_id = sm.sessionmaster_cat_id AND cat.cat_public = 1
									AND uprice.formation_id = tp.formation_id
									AND uprice.pricing_cat = sm.sessionmaster_cat_id
									AND uprice.pricing_method = l.method_id

									WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL

									AND (lesson_ghost != 1 OR lesson_ghost IS NULL)

									AND ( l.status_id = 5 OR (l.status_id = 4 AND u.user_paid_missed = 1))

									<!--- IF TRAINER IS GIVEN WE CHECK FOR TRAINER OR ALL --->
									<cfif p_id neq 0>
									AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
									</cfif>
									AND DATE_FORMAT(l.completed_date, "%Y-%m") BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#from_tselect#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#to_tselect#">

									GROUP BY l.planner_id, _date, cat.cat_id, tp.formation_id, tp.method_id
									ORDER BY `_date` ASC
								</cfquery>


								<div class="tab-content" id="myTabContent">

									<!--- <cfif get_lessons.recordCount neq "0"> --->
										<div class="row">
											<div class="col-md-12" style="margin-top:25px">		
												<div class="table table-responsive-sm">
													
													<!--- query="get_lessons" group="planner_id" --->
													<cfoutput>

														<div class="row">
															
															<div class="col-md-4">
																<div class="card">
																	<div class="card-body">
																		<h4 class="card-title trainer_title" data-id="#get_total.planner_id#">#get_total.planner_firstname#</h4>

																		<!--- <a type="button" target="_blank" href="tpl/invoice_trainer_container.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a> --->
																		<!--- <a type="button" target="_blank" href="./finance_trainer_invoice_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a>
																		<a type="button" target="_blank" href="./tpl/invoice_trainer_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-eye"></i></a> --->

																	</div>
																</div>
															</div>

														</div>
													</cfoutput>
														<div class="row">

															<table class="table table-hover">
															
																<tr bgcolor="#F3F3F3">
																	<td><strong>DATE</strong></td>
																	<td colspan="2"><strong>SUMMARY</strong></td>
																	<td><strong>DURATION</strong></td>
																	<td><strong>PRICE/H</strong></td>
																	<td><strong>TOTAL</strong></td>
																</tr>

																<cfset _total_dur = 0>
																<cfset _total_amount = 0>
																<cfset sub_total_dur = 0>
																<cfset sub_total_amount = 0>
																<cfset sub_month = "">
																<cfoutput query="get_total">

																	<cfif sub_month eq "">
																		<cfset sub_month = _date>
																	</cfif>
							
																	<cfif sub_month neq _date>
																		<tr bgcolor="##ECECEC">
																			<td align="center">#sub_month#</td>
																			<td colspan="2"></td>
																			<td align="center">#numberformat(sub_total_dur / 60,"____.__")#H</td>
																			<td align="center">-</td>
																			<td align="center">#numberformat(sub_total_amount,"____.__")# &euro;</td>
																		</tr>

																		<cfset sub_total_dur = 0>
																		<cfset sub_total_amount = 0>
																		<cfset sub_month = _date>
																	</cfif>

																	<cfset sub_total_dur = sub_total_dur + total_dur>
																	<cfset sub_total_amount = sub_total_amount +  amount_total>

																	<cfset _total_dur = _total_dur + total_dur>
																	<cfset _total_amount = _total_amount + amount_total>

																	<tr bgcolor="##FFFFFF">
																		<td align="center">#_date#</td>

																		<td colspan="2">#cat_name# #formation_code# #method_name#</td>
											
																		<td align="center">#numberformat(total_dur / 60,"____.__")#</td>
											
																		<td align="center">#pricing_amount# &euro;</td>
											
																		<td align="center">#numberformat(amount_total,"____.__")# &euro;</td>
																	</tr>

																</cfoutput>
																<cfoutput>
																	<tr bgcolor="##ECECEC">
																		<td align="center">#sub_month#</td>
																		<td colspan="2"></td>
																		<td align="center">#numberformat(sub_total_dur / 60,"____.__")#H</td>
																		<td align="center">-</td>
																		<td align="center">#numberformat(sub_total_amount,"____.__")# &euro;</td>
																	</tr>


																	<tr bgcolor="##ECECEC">
																		<td colspan="2"></td>
																		<td>Duration :</td>
																		<td align="center">#numberformat(_total_dur / 60,"____.__")#H</td>
																		<td>Total :</td>
																		<td align="center">#numberformat(_total_amount,"____.__")# &euro;</td>
																	</tr>
																</cfoutput>
															</table>
														</div>
														
													
												</div>
											</div>
										</div>
										</div>
										<!--- <cfelse>
										<div class="row justify-content-md-center" style="margin-top:15px">

											<div class="col-md-6">
												<div class="alert alert-secondary" role="alert">
													<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput></em></div>
												</div>
											</div>

										</div>
										</cfif> --->
									</cfif> --->

									<div class="tab-content" id="myTabContent">

										<!--- <cfif get_lessons.recordCount neq "0"> --->
										<div class="row">
											<div class="col-md-12" style="margin-top:25px">		
												<div class="table table-responsive-sm">

													<cfset SESSION.TRAINER_EXPORT_LIST = "">

													<cfoutput query="get_invoice_total" group="planner_id">

														<cfset SESSION.TRAINER_EXPORT_LIST = listAppend(SESSION.TRAINER_EXPORT_LIST, planner_id)>

														<div class="row">
															
															<div class="col-md-4">
																<div class="card">
																	<div class="card-body">
																		<h4 class="card-title trainer_title" data-id="#planner_id#">#planner_firstname#</h4>

																		<!--- <a type="button" target="_blank" href="tpl/invoice_trainer_container.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a> --->
																		<!--- <a type="button" target="_blank" href="./finance_trainer_invoice_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-download"></i></a>
																		<a type="button" target="_blank" href="./tpl/invoice_trainer_view.cfm?msel=#msel#&ysel=#ysel#&p_id=#planner_id#"><i class="far fa-eye"></i></a> --->

																	</div>
																</div>
															</div>

														</div>


														<div class="row">

															<table class="table table-hover">

																<tr bgcolor="##F3F3F3">
																	<td align="center"><strong>DATE</strong></td>
																	<td align="center"><strong>DURATION</strong></td>
																	<td align="center"><strong>TOTAL</strong></td>
																	<td align="center"><strong>CUSTOM</strong></td>
																	<td></td>
																	<td align="center"><strong>+</strong></td>
																</tr>
	
																<cfset _total_dur = 0>
																<cfset _total_amount = 0>
																<cfset _total_payed = 0>
																<cfoutput>
	
																	<cfset _total_dur = _total_dur + user_invoice_info_duration>
																	<cfset _total_amount = _total_amount + user_invoice_info_amount>
																	<cfset _total_payed = _total_payed + user_invoice_info_payed>
	
																	<tr bgcolor="##FFFFFF">
																		<td align="center">#user_invoice_info_selector#</td>
												
																		<td align="center">#numberformat(user_invoice_info_duration / 60,"____.__")#</td>
											
											
																		<td align="center">#numberformat(user_invoice_info_amount,"____.__")# &euro;</td>

																		<td>
																			<input type="number" step="any" name="input_payed_#user_invoice_info_id#" id="input_payed_#user_invoice_info_id#" value="#user_invoice_info_payed#" class="form-control form-control-sm">
																		</td>
																		<td>
																			<button type="submit" class="btn btn-sm btn-info mb-0 btn_update_invoice_payed" id="btn_payed_#user_invoice_info_id#"><i class="fa-light fa-arrows-rotate"></i></button>
																		</td>
																		<td align="center">
																			<cfif user_invoice_info_path neq "">
																				<a type="button" target="_blank" href="./tpl/invoice_trainer_view.cfm?pdf_id=#user_invoice_info_id#&p_id=#planner_id#"><i class="far fa-eye"></i></a>
																			</cfif>
																			<a type="button" target="_blank" href="./finance_trainer_invoice_view.cfm?msel=#mid(user_invoice_info_selector, 6,2)#&ysel=#mid(user_invoice_info_selector,1 ,4)#&p_id=#planner_id#"><i class="far fa-download"></i></a>
																		</td>
																	</tr>
	
																</cfoutput>

																<tr bgcolor="##ECECEC">
																	<td>Total :</td>
																	<td align="center">#numberformat(_total_dur / 60,"____.__")#H</td>
																	<td align="center">#numberformat(_total_amount,"____.__")# &euro;</td>
																	<td align="center">#numberformat(_total_payed,"____.__")# &euro;</td>
																	<td></td>
																	<td></td>
																</tr>
															</table>
														</div>

													</cfoutput>
													
												
												</div>
											</div>
										</div>
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


	<script>
	$(document).ready(function() {
		$('.btn_view_log').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			alert(idtemp)
			$('##window_item_lg').modal({keyboard: true});
			$('##modal_title_lg').text("Comments");
			$('##modal_body_lg').load("modal_window_log.cfm?u_id="+idtemp, function() {


			});
		});
		
		$('.btn_update_invoice_payed').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");

			console.log(idtemp[2]);
			console.log($('#input_payed_'+ idtemp[2]).val());

			$.ajax({
				url : './api/orders/orders_post.cfc?method=update_invoice_info_payed',
				type : 'POST',
				data : {
					pi_id: idtemp[2],
					value: $('#input_payed_'+ idtemp[2]).val()
				},				
				success : function(result, status) {
					console.log("yes")
				}
			});
		});

	})
	</script>

</body>
</html>