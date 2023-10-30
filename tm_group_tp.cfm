<!DOCTYPE html>

<cfsilent>
	<!--- <cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">	 --->

	<cfif not isDefined("SESSION.USER_ACCOUNT_RIGHT_ID")>
        <cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.ACCOUNT_ID>
    </cfif>
		
	<!--- <cfset get_tp_virtual = obj_tp_get.oget_tps(st_id=st_id,m_id="10",no_users="1")> --->

	<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
		SELECT tp_status_id , tp_status_name_#SESSION.USER_LANG# as status_name FROM lms_tpstatus
	</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
		.tp_row {
			display:none;
		}
	</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = obj_translater.get_translate('title_page_tm_group_lessons')>
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content" id="container_main">

			<ul class="nav nav-tabs" role="tablist">
				<cfoutput>
				<cfloop list="2,3" index="cor">
				<li class="nav-item">		
					<a href="##tpgroup_#cor#" class="nav-link <cfif cor eq 2>active</cfif>" role="tab" data-toggle="tab" <cfif cor eq 2>aria-selected="true"</cfif> align="center">
						<i class="fa-light fa-users"></i><br><cfif cor eq 2>#obj_translater.get_translate('table_th_program_actif')#<cfelse>#obj_translater.get_translate('table_th_program_finish')#</cfif>
					</a>
				</li>
				</cfloop>
				</cfoutput>
			</ul>

			<div class="tab-content">

				<cfloop list="2,3" index="cor">
					
				<cfset get_tp_group = obj_tp_get.oget_tps(st_id=#cor#,m_id="11",no_users="1",a_id=0)>

				<div role="tabpanel" class="tab-pane fade <cfif cor eq 2>active show</cfif>" id="<cfoutput>tpgroup_#cor#</cfoutput>" style="margin-top:15px">
				
					<table class="table table-bordered">						
						<tr class="bg-light">
						<cfoutput>
							<td><strong>#obj_translater.get_translate('table_th_program_short_plural')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_account')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_name')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_status')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_program_end')#</strong></td>
							<td><strong>#obj_translater.get_translate('short_hours')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_progress')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_deadline')#</strong></td>
							<td><strong>#obj_translater.get_translate('table_th_action')#</strong></td>
						</cfoutput>
						</tr>
						
						
						
						<cfoutput query="get_tp_group">
							<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
							<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
							<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
							<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
							<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
							<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
							<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
							<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
							<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
							
							<tr class="bg-white">
								<td>	
									<img src="./assets/img_formation/#formation_id#.png" width="30" class="border_thumb mr-1"> 
                        			<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
									<cfloop query="tp_trainer">
										#obj_lms.get_thumb(planner_id,30)#
									</cfloop>
								</td>
								<td>
									<small>#mid(account_name,1,20)#</small>
								</td>
								<td>
									<a href="##" class="btn_edit_tpgroup" id="group_#tp_id#_0">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a>
								</td>
								<td>
									<span class="badge badge-info bg-#tp_status_css#">#status_name#</span>
								</td>
								<td>
									#dateformat(tp_date_end,'dd/mm/yyyy')#
								</td>
								<td>
									#tp_duration/60#
								</td>
								<td>
									#obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_duration="#tp_duration#")#
								</td>								
								<td>
									<cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif>
								</td>
								<td>
									<!--- <cfif order_id neq "">
									<button type="button" class="btn <cfif nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="u_#user_id#">
									<i class="fas fa-sticky-note"></i> 
									</button>
									</cfif> --->
									<button type="button" class="btn btn-sm btn-outline-info btn_view_tp" style="padding:3px !important" id="tp_#tp_id#"><i class="fa-light fa-eye"></i></button>
									<a target="_blank" class="btn btn-sm btn-success" href="./tpl/as_group_container.cfm?t_id=#tp_id#"><i class="fa-light fa-ballot-check"></i></a>
									<button class="btn btn-sm btn-success btn_edit_tpgroup" id="group_#tp_id#_0"><i class="fal fa-users"></i></button>
								
								</td>
								<!--- <td>
									<a href="common_tp_multi2.cfm?t_id=#tp_id#" data-toggle="tooltip" data-placement="top" title="EDIT" class="btn btn-success btn-sm my-0">BOOK</i></a>
								</td> --->
								

							</tr>						
							</cfoutput>
						
						
					</table>
			
				</div>
				</cfloop>

			</div>
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>


<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
	$(document).ready(function() {

		$('#st_id').multiselect({	
			numberDisplayed: 1
		});

		$("#end_date").datepicker({	
			weekStart: 1,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {
				end_date = $('#end_date').datepicker("getDate");
				end_date = moment(end_date).format('YYYY-MM-DD');
			}		
		});
	
		/******************** VIEW LOG *****************************/	
		$('.btn_view_log').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var u_id = idtemp[1];
			// console.log(u_id);
			$('#modal_title_xl').text("Follow-Up Learner");
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_body_xl').load("modal_window_log.cfm?u_id="+u_id, function() {})
		});


		$('.show_tp_detail').click(function(event){
			// console.log($(this));
			$('#tp_head_' + event.target.dataset.tid).nextUntil('.tp_head').slideToggle('normal');
		});


		$('.btn_edit_tpgroup').click(function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var l_id = idtemp[2];
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("TP group");
			$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
		});

		$('.btn_edit_tpgroup_vc').click(function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];
			var l_id = idtemp[2];
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("TP group");
			$('#modal_body_xl').load("modal_window_tpgroup_attendance.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
		});

		$('.btn_view_tp').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var t_id = idtemp[1];	
			var u_id = idtemp[2];	
			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
			$('#modal_body_xl').load("modal_window_tpview_tm.cfm?t_id="+t_id, function() {});
		});
		
	 })
	</script>

</body>
</html>