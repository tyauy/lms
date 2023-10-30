<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8,2,5,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.USER_ACCOUNT_RIGHT_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>
<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.AL_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.AL_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.AL_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>

<cfparam name="al_id" default="#SESSION.AL_ID#">
<cfset display_all_selected = false>
<cfif al_id eq "" OR al_id eq 0>
	<cfset al_id = SESSION.USER_ACCOUNT_RIGHT_ID>
	<cfset display_all_selected = true>
<cfelse>
	<cfset SESSION.AL_ID = al_id>
</cfif>
<cfset SESSION.ACCOUNT_ID = listgetat(al_id,1)>

<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_fill_pta = obj_translater.get_translate('tooltip_fill_pta')>
<cfset __tooltip_fill_na = obj_translater.get_translate('tooltip_fill_na')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __btn_support_short = obj_translater.get_translate('btn_support_short')>
<cfset __btn_notes_short = obj_translater.get_translate('btn_notes_short')>
<cfset __btn_fill_notes = obj_translater.get_translate('btn_fill_notes')>
<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>

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
			<div class="row justify-content-md-center">
				<div class="col-md-6">
					<cfif ListLen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						<!--- <select class="form-control" name="a_id" id="a_id" onchange="document.location.href='tm_lessons.cfm?a_id='+$(this).val()">
						<cfoutput query="get_account_tm">
						<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
						</cfoutput>
						<cfif ListLen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						<cfoutput>
						<option value="0" <cfif a_id eq 0>selected</cfif>>#Ucase('#obj_translater.get_translate("table_th_all_accounts")#')#</option>
						</cfoutput>
						</cfif>
						</select> --->

						<div class="row">
							<div class="col-lg-12">
							<button type="button" class="btn btn-sm btn-default form-control dropdown-toggle" style="text-align: left;overflow:hidden; white-space:nowrap; text-overflow:ellipsis;" data-toggle="dropdown">
								<span class="account-display" style="">
									<cfif al_id eq 0 OR display_all_selected eq true>
										<cfoutput>
											#obj_translater.get_translate('table_th_all_accounts')#
										</cfoutput>
									<cfelse>
										<cfoutput query="get_account_tm">
											<cfif ListContains(al_id,account_id) GT 0> &nbsp;#account_name#,&nbsp;
											</cfif>
										</cfoutput>
									</cfif>
								</span>
							</button>
								<ul id="tm_account_select" class="dropdown-menu form-control">
									<cfoutput>
									<li><a href="##" class="form-control" data-value="0" tabIndex="-1">
										-&nbsp;#obj_translater.get_translate('table_th_all_accounts')#
									</a></li>
									</cfoutput>

									<cfoutput query="get_account_tm">
										<li><a href="##" class="form-control" data-value="#account_id#" tabIndex="-1">
											<input type="checkbox" <cfif ListContains(al_id,account_id) GT 0> checked </cfif>/>
											&nbsp;#account_name#
										</a></li>
									</cfoutput>
								</ul>
							</div>
					   </div>
						
					</cfif>
				</div>
			</div>
			
			<div class="row mt-3">
				<div class="col-md-12">
					<div class="card border-top border-info h-100">						
						<div class="card-body">
							<!---<h6>RAPPORT D'ACTIVITÉ</h6>--->
						
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
									<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><label <cfif cor eq "0">class="font-weight-bold"</cfif>><a class="badge badge-info" href="tm_lessons.cfm?msel=#mcor#&ysel=#ycor#" style="font-size:11px"><i class="fad fa-eye"></i> #listgetat("#short_month_list#",month(dateadd('m',cor,now())))# #ycor_short#</a></label></td>
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
								<tr>
									<td></td>
									<cfloop list="#list_month_scan#" index="cor">
									<cfset mcor = listgetat(SESSION.LISTMONTHS_CODE,month(dateadd('m',cor,now())))>
									<cfset ycor = year(dateadd('m',cor,now()))>
									<td align="center" <cfif mcor eq msel>bgcolor="##b9e4f0" class="font-weight-bold"</cfif>><cfif cor lte "0"><a href="exporter/export_reporting_tm.cfm?a_id=#al_id#&msel=#mcor#&ysel=#ycor#" class="badge badge-info" style="font-size:11px"><i class="fad fa-download"></i> #obj_translater.get_translate("btn_export")#</a></cfif></td>
									</cfloop>
								</tr>
							</table>	
							</cfoutput>
				
				
						
						
							<!---<div class="row">
								<div class="col-md-8">
									<cfoutput>
									<h6>LISTE DES COURS</h6>
									</cfoutput>
								</div>
								<div class="col-md-4">
								<cfform action="tm_lessons.cfm">
								<div class="form-row">
									<div class="col-md-12">
										<select class="form-control" name="msel" style="display:inline; width:150px">
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
									
										<select class="form-control" name="ysel" style="display:inline; width:150px">
										<cfloop from="2019" to="#year(now())+1#" index="y">
										<cfoutput>
											<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
										</cfoutput>
										</cfloop>
										</select>
										
										<input type="submit" value="AFFICHER" class="btn btn-info" style="display:inline">
										
									</div>
									
								</div>
								</cfform>
								</div>
								
							</div>--->	
							<div class="row">
								<div class="col-md-12">
									<br>
									<cfset show_tab = "0">
									<cfset period_month = "#tselect#">
									
									<cfinclude template="./widget/wid_lesson_list_tm.cfm">
								</div>
							</div>
						
						
						
						</div>
					</div>
				</div>
			</div>
						
			
			
			
			
			
			<div class="row mt-3">
				
				<div class="col-md-12">
					<div class="card border-top border-info h-100">						
						<div class="card-body">
								
							<div class="row">
								
								<div class="col-md-12">
									<h6><cfoutput>#obj_translater.get_translate('tm_personalized_export')#</cfoutput></h6>
									<form action="exporter/export_reporting_tm.cfm" method="post">
									<div class="row align-items-end">
										<cfoutput>
										<div class="col-md-8">										
											<div class="control-group">
												<label for="date_schedule_from" class="control-label">#obj_translater.get_translate('short_between2')#</label>
												<div class="controls">
													<div class="input-group">
														<cfset from_dateformat = "#dateformat(now(),'01/mm/yyyy')#">
														<cfset to_dateformat = "#dateformat(now(),'dd/mm/yyyy')#">
														<cfif #mcor# eq "de">
															<cfset from_date_format = "#dateformat(now(),'01.mm.yyyy')#">
															<cfset to_dateformat = "#dateformat(now(),'dd.mm.yyyy')#">
														</cfif>
														<input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" value="#from_dateformat#"/>
														<label for="date_schedule_from" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
													</div>
												</div>
											</div>

											<div class="control-group">
												<label for="date_schedule_to" class="control-label">#obj_translater.get_translate('short_and2')#</label>
												<div class="controls">
													<div class="input-group">
														<input id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" autocomplete="off" value="#to_dateformat#" />
														<label for="date_schedule_to" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-4">	
											<input type="hidden" name="a_id" value="#al_id#">
											<input type="submit" value="#obj_translater.get_translate('btn_export')#" class="btn btn-info" style="display:inline">											
										</div>
										</cfoutput>
										
									</div>
									</form>
									
								</div>
							</div>
						</div>
					</div>				
				</div>
				
				<!---<div class="col-md-4">
					<div class="card border-top border-info h-100">						
						<div class="card-body">
						<h6>Activité Mois</h6>
						<cfoutput>	
						<button type="button" class="btn btn btn-warning p-2" onclick="location.href='tm_lessons.cfm?st_id=1'"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_scheduled neq "0">#obj_lms.get_format_hms(toformat="#lesson_scheduled#",unit="min")#<cfelse>-</cfif></h3></button>
						<button type="button" class="btn btn btn-success p-2" onclick="location.href='tm_lessons.cfm?st_id=5'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-lowercase"><cfif learner_lesson_done neq "0">#obj_lms.get_format_hms(toformat="#learner_lesson_done#",unit="min")#<cfelse>-</cfif></h3></button>
						<button type="button" class="btn btn btn-danger p-2" onclick="location.href='tm_lessons.cfm?st_id=4'"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_missed neq "0">#obj_lms.get_format_hms(toformat="#lesson_missed#",unit="min")#<cfelse>-</cfif></h3></button>
						</cfoutput>
						</div>
					</div>
				</div>--->
				
			</div>
			
					
		</div>
				
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
	
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">



<script>
$(document).ready(function() {

	<cfif isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "0">
		$('#window_item_pw').modal({keyboard: false,backdrop:'static'});
		$('#modal_title_pw').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");		
		$('#modal_body_pw').load("modal_window_mdp.cfm?init=1", function() {});
	</cfif>

	var options = [<cfoutput>#al_id#</cfoutput>];

	$( '#tm_account_select a' ).on( 'click', function( event ) {

	var target = $( event.currentTarget );
	var val = target.attr( 'data-value' ) * 1;
	var inp = target.find( 'input' );

	if (val == 0) {
		options = [];
		document.location.href="tm_lessons.cfm?al_id=0";
		return false;
	}

	if ( ( idxall = options.indexOf( 0 ) ) > -1 ) {
		options.splice( idxall, 1 );
	}

	if ( ( idx = options.indexOf( val ) ) > -1 ) {
		options.splice( idx, 1 );
		setTimeout( function() { inp.prop( 'checked', false ) }, 0);
	} else {
		options.push( val );
		setTimeout( function() { inp.prop( 'checked', true ) }, 0);
	}
		
	document.location.href="tm_lessons.cfm?al_id="+(options == [] ? ['0'] : options);
	return false;
	});

	$('.th_sortable').click(function(){
		// console.log($(this));

		// console.log($(this)[0].children[0]);
		var table = $(this).parents('table').eq(0);
		var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
		this.asc = !this.asc;
		if (!this.asc){	
			rows = rows.reverse()
		}
		for (var i = 0; i < rows.length; i++){table.append(rows[i])}
		// $(this)[0].textContent = "op"
		$(".th_sortable_arrow" ).empty();
		$(this)[0].children[1].innerHTML = this.asc ? " &#8593;" : " &#8595;"
	})

	function comparer(index) {
		return function(a, b) {

			let _a = $(a).children('td').eq(index).text();
			let _b = $(b).children('td').eq(index).text();

			return $.isNumeric(_a) && $.isNumeric(_b) ? _a - _b : _a.toString().localeCompare(_b)
		}
	}

	$('.btn_add_user').click(function(event) {		
		event.preventDefault();
		$('#modal_title_lg').text("Créer Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_partner.cfm?create_user=1", function() {});
	});



});

	$(function() {
		$("#date_schedule_from").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_schedule_to").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
	});
</script>

<!---<cfif isdefined("u_id")>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	
<script>
var barChartData = {
	labels: [
		<cfloop list="#SESSION.LISTMONTHS_JS#" index="cor">
		<cfoutput>
		"#cor#",
		</cfoutput>
		</cfloop>

	],
	datasets: [{
		label: 'Completed',
		backgroundColor: '#709A9C',
		//stack: 'Stack 0',
		data: [
			1,2,5,6,4,7,8,0,0,0,4
		]
	}, {
		label: 'Missed',
		backgroundColor: '#F27F5B',
		//stack: 'Stack 0',
		data: [
			2,0,0,0,1,1,0,0,0
		]
	}]
};
var go_bar = new Chart(bar_lesson, {
	type: 'bar',
	data: barChartData,
	options: {
		/*title: {
			display: true,
			text: 'R\351partition par comp\351tence'
		},*/
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
	
	
	

<script>
var config = {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [
                   78,22
                ],
                backgroundColor: [
                   "#66CF9C","#F27F5B"
                ],
                label: 'Dataset 1'
            }],
            labels: [
                "Completed",
                "Missed"
            ]
        },
        options: {
			legend: {
				display: true,
			}

            //responsive: true,
            /*legend: false {
                position: 'top',
            }*/,
            /*title: {
                display: true,
                text: 'Chart.js Doughnut Chart'
            },*/
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }
    };
	
	
var myPieChart = new Chart(ratio_participation,config);
</script>

</cfif>--->


</body>
</html>