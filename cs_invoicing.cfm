<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">

	<cfparam name="msel" default="#month(now())#">

	<!--- 1 eq listing / 2 eq detail with pdf --->
	<cfparam name="mode" default="1">
	
	<cfif mode eq 2 AND SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1>
		<cflocation addtoken="no" url="index.cfm?pconnect=1">
	</cfif>

	<cfif SESSION.LANG_CODE neq "fr">
		<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
	<cfelse>
		<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
	</cfif>
	<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
	<cfparam name="ysel" default="#year(now())#">
	<cfparam name="tselect" default="#ysel#-#msel#">
	<cfparam name="p_id" default="0">

	<cfparam name="start_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
	<cfparam name="end_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
	<cfparam name="use_date" default="0">

	<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id, user_firstname, user_name FROM user u
		WHERE profile_id = 4
		AND user_paid_global = 1
		ORDER BY user_firstname
	</cfquery>

	<cfquery name="get_lesson_total_cat" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m, 
		ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css,
		sc.cat_name_#SESSION.LANG_CODE# as cat_name, s.cat_id

		FROM lms_lesson2 l

		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id
		LEFT JOIN lms_tpsession_category sc ON s.cat_id = sc.cat_id

		WHERE (l.lesson_ghost != 1 OR l.lesson_ghost IS NULL)
		AND l.status_id <> 3
		<cfif use_date eq 0>
			AND DATE_FORMAT(l.completed_date, "%Y-%m") =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
		<cfelse>
			AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start_date#"> 
			AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end_date#">
		</cfif>

		GROUP by l.status_id, s.cat_id

		ORDER BY  s.cat_id, l.status_id
	</cfquery>

	<cfquery name="get_lesson_total" datasource="#SESSION.BDDSOURCE#">
		SELECT COUNT(l.lesson_id) as nb, SUM(lesson_duration/60) as h, SUM(lesson_duration) as m, 
		ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css

		FROM lms_lesson2 l

		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		INNER JOIN lms_tpsession s ON s.session_id = l.session_id

		WHERE (l.lesson_ghost != 1 OR l.lesson_ghost IS NULL)
		AND l.status_id <> 3
		
		<cfif use_date eq 0>
			AND DATE_FORMAT(l.completed_date, "%Y-%m") =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
		<cfelse>
			AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#start_date#"> 
			AND DATE_FORMAT(l.completed_date, "%Y-%m-%d") <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#end_date#">
		</cfif>

		GROUP by l.status_id

		ORDER BY l.status_id
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

					<div class="col-md-6">
						<div class="card border-top border-info" style="min-height:140px">						
							<div class="card-body">
								<cfif use_date eq 0>
									<h4 class="card-title">S&eacute;lection : <cfoutput>#mlongsel# #ysel#</cfoutput></h4>
								<cfelse>
									<h4 class="card-title">S&eacute;lection : <cfoutput>#start_date# - #end_date#</cfoutput></h4>
								</cfif>
								<div class="row">
									<div class="col-md-12 mt-4">
										<!--- Pour l'export de mi-décembre --->
										<cfform action="cs_invoicing.cfm">
											<cfif mode eq 2>
											<div class="form-row">
												<div class="col-md-4">
													<div class="controls">
														<!--- <div class="input-group"> --->
															<label><input type="checkbox" name="use_date" <cfif use_date eq 1>checked</cfif> value="1"> Use Date :</label>
														<!--- </div> --->
													</div>	
												</div>
												<div class="col-md-4">
													<div class="controls">
														<div class="input-group">
															<input id="start_date" name="start_date" type="text" class="datepicker form-control" value="<cfoutput>#start_date#</cfoutput>" />
															<label for="start_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
														</div>
													</div>	
												</div>
												<div class="col-md-4">
													<div class="controls">
														<div class="input-group">
															<input id="end_date" name="end_date" type="text" class="datepicker form-control" value="<cfoutput>#end_date#</cfoutput>" />
															<label for="end_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
														</div>
													</div>	
												</div>
											</div>
											</cfif>

											<div class="form-row">
												<div class="col">
													<cfselect class="form-control" name="p_id" query="get_trainers" value="user_id" display="user_firstname" selected="#p_id#">
														<option value="0" <cfif p_id eq "0">selected</cfif>>---ALL TRAINERS----</option>
													</cfselect>
												</div>

												<div class="col">
													<select class="form-control" id="msel" name="msel">

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
														<cfloop from="2019" to="#year(now())#" index="y">
															<cfoutput>
																<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
															</cfoutput>
														</cfloop>
													</select>

													<cfoutput><a href="cs_invoicing.cfm" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput>
												</div>

												<div class="col">
													<cfoutput>
														<input type="hidden" id="mode" name="mode" value="<cfoutput>#mode#</cfoutput>">
														<input type="submit" value="GO" class="btn btn-info">
														<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
															<a href="exporter/export_lessons.cfm?tselect=#tselect#" class="btn btn-success">Export</a>
														</cfif>

													</cfoutput>
												</div>
											</div>
										</cfform>

										<div class="col">
											<cfoutput>
												<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
													<a href="cs_invoicing.cfm?mode=#mode eq 1 ? 2 : 1#" class="btn btn-success">#mode eq 1 ? "SWITCH TO DETAIL" : "SWITCH TO LISTING"#</a>
												</cfif>
												
												<cfif mode eq 2>
													<cfif use_date eq 0>
														<a href="tpl/invoice_trainer_container.cfm?export_all=1&msel=#msel#&ysel=#ysel#" target="_blank" class="btn btn-success">EXPORT ALL</a>
														<a href="tpl/invoice_trainer_container.cfm?mail=1&export_all=1&msel=#msel#&ysel=#ysel#" target="_blank" class="btn btn-success">EXPORT ALL & MAIL ALL</a>
														<a href="tpl/invoice_trainer_view.cfm?export_all=1&msel=#msel#&ysel=#ysel#" target="_blank" class="btn btn-success">EXPORT EXISTING ONLY</a>
													<cfelse>
														<a href="tpl/invoice_trainer_container.cfm?export_all=1&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#" target="_blank" class="btn btn-success">EXPORT ALL</a>
														<!--- <a href="tpl/invoice_trainer_container.cfm?mail=1&export_all=1&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#" target="_blank" class="btn btn-success">EXPORT ALL & MAIL ALL</a> --->
														<a href="tpl/invoice_trainer_view.cfm?export_all=1&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#" target="_blank" class="btn btn-success">EXPORT EXISTING ONLY</a>
													</cfif>
													
												</cfif>
												<!--- <button type="button" class="btn btn-sm" id="export_all" >EXPORT ALL</button> --->
											</cfoutput>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-6">
						<div class="card border-top border-info" style="min-height:140px">				
							<div class="card-body">
								<!--- <cfif mode eq 1> --->
									<table class="table">
										


										<cfoutput query="get_lesson_total_cat" group="cat_id">	
											<tr>
												<td colspan="4" class="bg-light"><h6>Activit&eacute; (h) #cat_name#</h6></td>
											</tr>
											<tr>
												<cfoutput>
												<td>
													<strong class="text-#status_css#"> #status_name#</strong>
													<br>
													<cfif h neq "">#numberformat(h,'____.__')# h<cfelse>-</cfif>
												</td>
												</cfoutput>
											</tr>
										</cfoutput>

										<tr>
											<td colspan="4" class="bg-light"><h6>Activit&eacute; (h) TOTAL</h6></td>
										</tr>
										<tr>
											<cfoutput query="get_lesson_total">	
											<td>
												<strong class="text-#status_css#"> #status_name#</strong>
												<br>
												<cfif h neq "">#numberformat(h,'____.__')# h<cfelse>-</cfif>
											</td>
											</cfoutput>
										</tr>

									</table>

							</div>
						</div>
					</div>

				</div>



				<div class="row">

					<div class="col-md-12">
						<div class="card border-top border-info">
							<div class="card-body">
								<cfset show_tab = "0">
								<cfset period_month = "#ysel#-#msel#">
								<cfset total = 0>

								<cfif mode eq 1>
									<cfinclude template="./widget/wid_lesson_list_cs.cfm">
								<cfelse>
									<cfinclude template="./widget/wid_trainer_lesson_details.cfm">

									<div align="center">total = <cfoutput>#total#</cfoutput></div>
								</cfif>

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
		
		$("#start_date").datepicker({	
        weekStart: 1,
        dateFormat: 'yy-mm-dd',
        onClose: function( selectedDate ) {}	
		});

		$("#end_date").datepicker({	
			weekStart: 1,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {}	
		});


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
		
	})
	</script>

</body>
</html>