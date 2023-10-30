<!DOCTYPE html>
<!--- 
    This page is used for displaying a detailed lesson schedule and status, 
	to the TMs. This can be filtered based on various parameters, 
	including lesson status and specific months, using DataTables
	and the results can be exported for further analysis. 
    --->
<cfsilent>

<cfset secure = "8,2,5,12">
<cfinclude template="./incl/incl_secure.cfm">	
<!--- Check if the user is a manager and if the USER_ACCOUNT_RIGHT_ID session variable is not defined --->
<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.USER_ACCOUNT_RIGHT_ID')>
    <!--- Set USER_ACCOUNT_RIGHT_ID to the value of CUR_A_ID if defined, otherwise to ACCOUNT_ID --->
    <cfset SESSION.USER_ACCOUNT_RIGHT_ID = isDefined("SESSION.CUR_A_ID") ? SESSION.CUR_A_ID : SESSION.ACCOUNT_ID>
</cfif>

<!--- Check if the user is a manager and if the AL_ID session variable is not defined --->
<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.AL_ID')>
    <!--- Set AL_ID to the value of CUR_A_ID if defined, otherwise to ACCOUNT_ID --->
    <cfset SESSION.AL_ID = isDefined("SESSION.CUR_A_ID") ? SESSION.CUR_A_ID : SESSION.ACCOUNT_ID>
</cfif>

<!--- Execute the oget_account_tm function with the provided account list and store the result in get_account_tm --->
<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

<!--- Ensure al_id has a default value, which is taken from the session's AL_ID --->
<cfparam name="al_id" default="#SESSION.AL_ID#">
<!--- Initialize a flag to false, this is used to indicate whether all accounts are selected or not --->
<cfset display_all_selected = false>

<!--- Check if al_id is empty or zero, which indicates that all accounts are selected --->
<cfif al_id eq "" OR al_id eq 0>
    <!--- In this case, set al_id to the user's account right ID and set the display_all_selected flag to true --->
    <cfset al_id = SESSION.USER_ACCOUNT_RIGHT_ID>
    <cfset display_all_selected = true>
<cfelse>
    <!--- If specific accounts are selected, update the session's AL_ID with the selected al_id --->
    <cfset SESSION.AL_ID = al_id>
</cfif>

<!--- Set the session's ACCOUNT_ID to the first ID in the al_id list --->
<cfset SESSION.ACCOUNT_ID = listgetat(al_id, 1)>



<cfset emFunctions = createObject("component", "api/EM/_EM_functions")>

<!--- Setting tooltips and buttons translations --->
<cfset tooltips = ['tooltip_view_ln', 'tooltip_material', 
'tooltip_fill_pta', 'tooltip_fill_na', 'tooltip_fill_ln']>
<cfset buttons = ['btn_support_short', 'btn_notes_short', 
'btn_fill_notes', 'btn_cancel_short']>
<!--- Call the getButtons method of the EMFunctions object --->
<cfset buttonsStruct = emFunctions.getButtons(buttons)>
<!--- Call the getTooltips method of the EMFunctions object --->
<cfset tooltipsStruct = emFunctions.getTooltips(tooltips)>  



<cfloop collection="#tooltipsStruct#" item="key">
    <cfset "__#key#" = tooltipsStruct[key]>
</cfloop>

<cfloop collection="#buttonsStruct#" item="key">
    <cfset "__#key#" = buttonsStruct[key]>
</cfloop>

<cfset TM_reports = createObject("component", "api/EM/TM_reports")>


<!--- Call the get Employees method of the TM_reports object --->
<cfset jsonString = TM_reports.ogetEmployees(al_id)>
<cfif isDefined("jsonString") and len(trim(jsonString))> <!-- Check if the JSON string is defined and not empty -->
    <cfset employeesData = deserializeJSON(jsonString)>
<cfelse>
    <cflog text="jsonString is undefined or empty" file="errorLog"> <!-- Log an error message -->
    <cfset employeesData = {}> <!-- Set a default value or handle the empty response as needed -->
</cfif>









<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">


<cfif tselect eq "#year(now())#-#listgetat(SESSION.LISTMONTHS_CODE,month(now()))#">
<cfset list_month_scan="-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1">
<cfelse>
<cfset list_month_scan="-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1">
</cfif>
</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	
        width: 100% !important; 
   
	}

	  /* Add this to your existing styles */
	  .table-bordered th, .table-bordered td {
        border: 1px solid #dee2e6;
    }

    .table th {
        background-color: #f8f9fa;
        color: #495057;
    }
	</style>


</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfif isdefined("u_id")>
			<cfset title_page = "#obj_translater.get_translate('title_page_activity_report')# : #get_learner.user_contact#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_activity_report')# #obj_translater.get_translate('table_th_learners')#">
		</cfif>
		
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	
			
			<div class="container mt-4">
				<div class="row">
					<div class="card"> 
					<cfoutput>
						<table class="table table-sm table-bordered">
							<tr class="bg-light">
								<td width="12%"></td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<cfset ycor = year(dateadd('m',cor,now()))>
								<cfset ycor_short = dateformat(dateadd('m',cor,now()),'yy')>
																	
								<cfset "get_lessons_scheduled_#mcor#" = obj_query.oget_lessons_scheduled(tselect="#ycor#-#mcor#",list_account="#al_id#")>
								<cfset "get_lessons_missed_#mcor#" = obj_query.oget_lessons_missed(tselect="#ycor#-#mcor#",list_account="#al_id#")>
								<cfset "get_lessons_inprogress_#mcor#" = obj_query.oget_lessons_inprogress(tselect="#ycor#-#mcor#",list_account="#al_id#")>
								<cfset "get_lessons_completed_#mcor#" = obj_query.oget_lessons_completed(tselect="#ycor#-#mcor#",list_account="#al_id#")>
								<cfset "get_lessons_cancelled_#mcor#" = obj_query.oget_lessons_cancelled(tselect="#ycor#-#mcor#",list_account="#al_id#")>
									
								<cfif evaluate("get_lessons_scheduled_#mcor#").m neq ""><cfset "lesson_scheduled_#mcor#" = evaluate("get_lessons_scheduled_#mcor#").m><cfelse><cfset "lesson_scheduled_#mcor#" = 0></cfif>
								<cfif evaluate("get_lessons_inprogress_#mcor#").m neq ""><cfset "lesson_inprogress_#mcor#" = evaluate("get_lessons_inprogress_#mcor#").m><cfelse><cfset "lesson_inprogress_#mcor#" = 0></cfif>
								<cfif evaluate("get_lessons_missed_#mcor#").m neq ""><cfset "lesson_missed_#mcor#" = evaluate("get_lessons_missed_#mcor#").m><cfelse><cfset "lesson_missed_#mcor#" = 0></cfif>
								<cfif evaluate("get_lessons_completed_#mcor#").m neq ""><cfset "lesson_completed_#mcor#" = evaluate("get_lessons_completed_#mcor#").m><cfelse><cfset "lesson_completed_#mcor#" = 0></cfif>
								<cfif evaluate("get_lessons_cancelled_#mcor#").m neq ""><cfset "lesson_cancelled_#mcor#" = evaluate("get_lessons_cancelled_#mcor#").m><cfelse><cfset "lesson_cancelled_#mcor#" = 0></cfif>

								<cfset "lesson_completed_#mcor#" = evaluate("lesson_inprogress_#mcor#")+evaluate("lesson_completed_#mcor#")>

								<cfset short_month_list = #evaluate('SESSION.LISTMONTHS_SHORT_#SESSION.LANG_CODE#')#>
								<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>>
								<label <cfif cor eq "0">class="font-weight-bold"</cfif>>
									<p class="badge badge-info" style="font-size:11px">#listgetat("#short_month_list#",month(dateadd('m',cor,now())))# #ycor_short#</p>
								</label>
								</td>
								</cfloop>
							</tr>
							<tr>
								

								<td>#obj_translater.get_translate('table_th_active_learners')#</td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<cfset ycor = year(dateadd('m',cor,now()))>
								<cfset ycor_short = dateformat(dateadd('m',cor,now()),'yy')>
								<!--- 31 days doesnt work for all months, so changed this on line 193
									"AND l.lesson_start > '#ycor#-#mcor#-01' AND l.lesson_start < '#ycor#-#mcor#-31'" 
									to this  
								<cfset lastDayOfMonth = DaysInMonth(CreateDate(ycor, Val(mcor), 1))>--->


								<cfquery name="get_active_learner" datasource="#SESSION.BDDSOURCE#">
								SELECT COUNT(DISTINCT(u.user_id)) as nb FROM lms_lesson2 l
								INNER JOIN user u ON u.user_id = l.user_id
								WHERE u.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#al_id#" list="yes">)								
								AND l.lesson_start > '#ycor#-#mcor#-01' AND l.lesson_start < '#ycor#-#mcor#-31'
								AND l.status_id <> 3
								</cfquery>
								<td width="8%" align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>>#get_active_learner.nb#</td>
								</cfloop>
							</tr>
							<tr>
								<td><span class="badge badge-warning text-white"><i class="fad fa-calendar-alt text-white"></i> #obj_translater.get_translate('badge_planned_f_p')#</span></td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_scheduled_#mcor#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_scheduled_#mcor#")#",unit="min")#<cfelse>-</cfif></td>
								</cfloop>
							</tr>
							<tr>
								<td><span class="badge badge-success"><i class="fad fa-thumbs-up text-white"></i> #obj_translater.get_translate('badge_completed_f_p')#</span></td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_completed_#mcor#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_completed_#mcor#")#",unit="min")#<cfelse>-</cfif></td>
								</cfloop>
							</tr>
							<tr>
								<td><span class="badge badge-danger"><i class="fad fa-thumbs-down text-white"></i> #obj_translater.get_translate('badge_missed_f_p')#</span></td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_missed_#mcor#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_missed_#mcor#")#",unit="min")#<cfelse>-</cfif></td>
								</cfloop>
							</tr>
							<tr>
								<td><span class="badge badge-danger"><i class="fad fa-thumbs-down text-white"></i> #obj_translater.get_translate('badge_cancelled_f_p')#</span></td>
								<cfloop list="#list_month_scan#" index="cor">
								<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
								<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif evaluate("lesson_cancelled_#mcor#") neq "0">#obj_lms.get_format_hms(toformat="#evaluate("lesson_cancelled_#mcor#")#",unit="min")#<cfelse>-</cfif></td>
								</cfloop>
							</tr>
							
						</table>	
						</cfoutput>
					</div>
				</div>
				<div class="row">
					

						<cfif structKeyExists(form, "exportBtn")>
							<cfset exportService = createObject("component", "ExportService")>
							<cfset exportService.exportToExcel(
								form.startDate,
								form.endDate,
								form.employee,
								form.status
							)>
						</cfif>
						<!-- Filters -->
						<div class="card">
							<div class="card-header">Filters</div>
							
							
							<div class="card-body">
								<form id="filtersForm">
									<div class="row">
										<cfif ListLen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
											<div class="col-md-3">
												<label>	<cfoutput>
													#obj_translater.get_translate('table_th_account')#
												</cfoutput></label> 
												<button type="button" class="btn btn-sm btn-default form-control dropdown-toggle" style="text-align: left;overflow:hidden; white-space:nowrap; text-overflow:ellipsis;" data-toggle="dropdown">
													<span class="account-display" style="">
														
															<cfoutput query="get_account_tm">
																<cfif ListContains(al_id,account_id) GT 0> &nbsp;#account_name#,&nbsp;
																</cfif>
															</cfoutput>
														
													</span>
												</button>
												<ul id="tm_account_select" class="dropdown-menu form-control">
													
								
														<cfoutput query="get_account_tm">
															<li><a href="##" class="form-control" data-value="#account_id#" tabIndex="-1">
																<input type="checkbox" class="account-checkbox" data-account-id="#account_id#" <cfif ListContains(al_id,account_id) GT 0> checked </cfif>/>
																&nbsp;#account_name#
															</a></li>
														</cfoutput>
												</ul>
											</div>
										</cfif>
										<div class="col-md-3">
											<label for="monthYear">	<cfoutput>
												#obj_translater.get_translate('short_month')#
											</cfoutput></label>
											<select id="monthSelection" class="form-control">
												
												<cfloop list="#list_month_scan#" index="cor">
													<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE, month(dateadd('m', cor, now())))>
													<cfset ycor = year(dateadd('m', cor, now()))>
													<cfset ycor_short = dateformat(dateadd('m', cor, now()), 'yy')>
													<cfset short_month_list = #evaluate('SESSION.LISTMONTHS_SHORT_#SESSION.LANG_CODE#')#>
													<cfoutput>
														<option value="#ycor#-#mcor#">#listgetat("#short_month_list#", month(dateadd('m', cor, now())))# #ycor_short#</option>
													</cfoutput>
												</cfloop>
											</select>
										</div>
										<div class="col-md-3">
											<label for="employee">Employee</label>
											<select id="employee" name="employee" class="form-control">
												<option value="0">All Employees</option>
												<cfif isStruct(employeesData) AND structKeyExists(employeesData, "DATA") AND structKeyExists(employeesData, "COLUMNS")>
													<cfset employeeNameIndex = arrayFind(employeesData.COLUMNS, "EMPLOYEE_NAME")>
													<cfset userIdIndex = arrayFind(employeesData.COLUMNS, "USER_ID")>
													<cfloop array="#employeesData.DATA#" index="employee">
														<cfoutput>
															<option value="#employee[userIdIndex]#">#employee[employeeNameIndex]#</option>
														</cfoutput>
													</cfloop>
												<cfelse>
													<cfoutput><option disabled="disabled">No employees available</option></cfoutput>
												</cfif>
											</select>
										</div>
										
										<div class="col-md-3">
											<cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan(0, 1, 0, 0)#">
												SELECT status_id, status_name_#SESSION.LANG_CODE# as status_name, status_css, status_bootstrap FROM lms_lesson_status 
												UNION (SELECT 0 as status_id, "#obj_translater.get_translate('global_all')#" as status_name, "" as status_css, "" as status_bootstrap) 
												ORDER BY status_id
											</cfquery>
											<label for="status"><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label>
											<select id="status" name="status" class="form-control">
												<cfoutput query="get_lesson_status">
													<option value="#get_lesson_status.status_id#">#get_lesson_status.status_name#</option>
												</cfoutput>
											</select>
										</div>
										
									</div>
									<div class="row">
										<div class="col-md-6">
											<button type="submit" class="btn btn-primary mt-3">Apply Filters</button>
										</div>
										<div class="col-md-6 text-right">
											<button id="exportBtn" class="btn btn-success mt-3">Export to Excel</button>
										</div>
									</div>
								</form>
							</div>
						</div>

					
						
						<!-- Data Table -->
						<div class="card mt-4">
							<div class="card-header">Lessons</div>
							<div class="card-body">
								<table id="learningPlansTable" class="table table-striped table-bordered"> 
									<thead>
										<tr bgcolor="#F3F3F3">
											<cfoutput>
												<th class="th_sortable" width="7%"><label>#obj_translater.get_translate('table_th_status')#</label><label class="th_sortable_arrow"></label></th>
												<th class="th_sortable" width="13%"><label>#obj_translater.get_translate('table_th_trainer')#</label><label class="th_sortable_arrow"></label></th>
												<th class="th_sortable" width="13%"><label>#obj_translater.get_translate('table_th_learner')#</label><label class="th_sortable_arrow"></label></th>
												<th class="th_sortable" width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label><label class="th_sortable_arrow"></label></th>
												<th class="th_sortable" width="17%"><label>#obj_translater.get_translate('table_th_course')#</label><label class="th_sortable_arrow"></label></th>
												<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
												<th class="th_sortable" width="10%"><label>#obj_translater.get_translate('table_th_date')#</label><label class="th_sortable_arrow"></label></th>
												<th class="th_sortable" width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label><label class="th_sortable_arrow"></label></th>
											
												</cfoutput>
											
											
										
										</tr>
									</thead>
									<tbody>
									
									<!-- Rows are populated using jquery -->
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			
				
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
	
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/German.json"></script>
<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/French.json"></script>
<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/English.json"></script>


<script>
	$(document).ready(function() {
		
		// Function to update the employee dropdown based on selected account IDs
		function updateEmployeeDropdown(alID) {
			console.log('updateEmployeeDropdown called with AL_ID:', alID);
	
			$.ajax({
				url: 'api/EM/TM_reports.cfc?method=ogetEmployees',
				type: 'GET',
				dataType: 'json',
				data: {
					accountIds: alID
				},
				success: function(data) {
					console.log('AJAX success:', data);
	
					var employeeSelect = $('#employee');
					employeeSelect.empty();
					employeeSelect.append($('<option>', { value: "0", text: "All Employees" }));
	
					if (data && data.DATA && data.COLUMNS) {
						var columns = data.COLUMNS;
						data.DATA.forEach(function(rowData) {
							var employee = {};
							columns.forEach(function(column, index) {
								employee[column] = rowData[index];
							});
	
							employeeSelect.append($('<option>', {
								value: employee.USER_ID,
								text: employee.EMPLOYEE_NAME || 'N/A'
							}));
						});
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.error('AJAX error:', textStatus, errorThrown);
				}
			});
		}

	
		// Function to fetch data based on filters
		function fetchData() {
			var selectedAccountIds = getSelectedAccountIds();
			console.log('Selected Account IDs:', selectedAccountIds);
	
			var selectedMonthYear = $('#monthSelection').val().split('-');
			var year = selectedMonthYear[0];
			var month = selectedMonthYear[1];
	
			var startDate = new Date(year, month - 1, 1);
			var endDate = new Date(year, month, 0);
	
			startDate = startDate.toISOString().split('T')[0];
			endDate = endDate.toISOString().split('T')[0];
	
			var employee = $('#employee').val();
			var status = $('#status').val();
	
			$.ajax({
				url: 'api/EM/TM_reports.cfc?method=ogetDetailedLearningPlans',
				type: 'GET',
				dataType: 'json',
				data: {
					startDate: startDate,
					endDate: endDate,
					employee: employee,
					accountIds: selectedAccountIds,
					status: status
				},
				success: function(data) {
					console.log(data);
					clearAndPopulateTable(data);
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.error('Error:', textStatus, errorThrown);
					console.log('Response text:', jqXHR.responseText);
	
					if (textStatus === 'parsererror') {
						console.error('Error in parsing response. Please check the response format or the content.');
					}
				}
			});
		}
	
		// Function to clear the table and populate it with data
		function clearAndPopulateTable(data) {
			table.clear().draw();
	
			if (data && data.DATA && data.COLUMNS) {
				var columns = data.COLUMNS;
				data.DATA.forEach(function(rowData) {
					var row = {};
					columns.forEach(function(column, index) {
						row[column] = (rowData[index] !== undefined && rowData[index] !== null)
							? rowData[index]
							: 'N/A';
					});
	
					table.row.add([
						row.STATUS_NAME ? '<span class="badge badge-' + row.STATUS_CSS + '">' + row.STATUS_NAME + '</span>' : 'N/A',
						row.TRAINER_NAME || 'N/A',
						row.EMPLOYEE_NAME || 'N/A',
						row.FORMATION_NAME || 'N/A',
						row.SESSIONMASTER_NAME || 'N/A',
						row.METHOD_NAME ? '<img src="./assets/img/picto_methode_' + row.METHOD_ID + '.png" width="20" style="margin-right:2px">' : 'N/A',
						row.LESSON_START ? moment(row.LESSON_START).format('DD/MM/YYYY HH:mm') : 'N/A',
						row.LESSON_DURATION ? row.LESSON_DURATION + ' min' : 'N/A'
					]).draw();
				});
			}
		}
	
		// Function to get selected account IDs
		function getSelectedAccountIds() {
			return $('.account-checkbox:checked').map(function() {
				return $(this).data('account-id');
			}).get().join(',');
		}
	
	
		// Event handler for account checkbox changes
		$(document).on('change', '.account-checkbox', function() {
			var selectedAccountIds = getSelectedAccountIds();
			updateEmployeeDropdown(selectedAccountIds);
		});
	
		// Event handler for form submission
		$('#filtersForm').on('submit', function(e) {
			e.preventDefault();
			fetchData();
		});
	 var lang_code = <cfoutput>"#SESSION.LANG_CODE#"</cfoutput>
		var languageUrl;

		if (lang_code === 'fr') {
			languageUrl = 'https://cdn.datatables.net/plug-ins/1.10.25/i18n/French.json';
		} else if (lang_code === 'en') {
			languageUrl = 'https://cdn.datatables.net/plug-ins/1.10.25/i18n/English.json';
		} else if (lang_code === 'de') {
			languageUrl = 'https://cdn.datatables.net/plug-ins/1.10.25/i18n/German.json';
		} else {
			// Default to English if the language code is not recognized
			languageUrl = 'https://cdn.datatables.net/plug-ins/1.10.25/i18n/English.json';
		}

		var table = $('#learningPlansTable').DataTable({
			language: {
				url: languageUrl
			}
		});

	
		// Event handler for export button click
		$('#exportBtn').click(function() {
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			var employee = $('#employee').val();
			var status = $('#status').val();
	
			var form = $('<form></form>').attr('action', 'exportToExcel.cfm').attr('method', 'post');
			form.append($('<input>').attr('type', 'hidden').attr('name', 'startDate').attr('value', startDate));
			form.append($('<input>').attr('type', 'hidden').attr('name', 'endDate').attr('value', endDate));
			form.append($('<input>').attr('type', 'hidden').attr('name', 'employee').attr('value', employee));
			form.append($('<input>').attr('type', 'hidden').attr('name', 'status').attr('value', status));
			$('body').append(form);
			form.submit();
		});
	});
	</script>
	



</body>
</html>