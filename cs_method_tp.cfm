<!DOCTYPE html>

<cfparam name="m_id" default="1">

<cfsilent>

<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
SELECT method_id, method_name_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method
</cfquery>

<cfquery name="get_method_solo" datasource="#SESSION.BDDSOURCE#">
SELECT method_name_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method WHERE method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#m_id#">
</cfquery>

<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
a.account_name, 
t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
tpd.*,
tpc.*,
tpe.*,
ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
MAX(l.lesson_start) as maxl,
SUM(s.session_duration) as session_duration,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
COUNT(lo.log_id) as nb_log

FROM lms_tp t 

INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
LEFT JOIN user u ON tpu.user_id = u.user_id
INNER JOIN user_status st ON st.user_status_id = u.user_status_id
LEFT JOIN account a ON a.account_id = u.account_id
INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
	
LEFT JOIN orders o ON o.order_id = t.order_id
LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
LEFT JOIN logs lo ON lo.order_id = o.order_id

LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1

LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id

<cfif m_id eq "1" OR m_id eq "2">
WHERE t.tp_status_id = 2
</cfif>


AND t.method_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#m_id#">



GROUP BY t.tp_id

ORDER BY t.tp_id

</cfquery>
	
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "TP ACTIF #get_method_solo.method_name#">
	
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">	
			
				<div class="col-md-12">
					
					<cfoutput query="get_method">
					<a href="cs_method_tp.cfm?m_id=#method_id#" class="btn <cfif m_id eq method_id>btn-info <cfelse>btn-outline-info</cfif>">TP #method_name#</a>
					</cfoutput>
					
					<div class="card">
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>ORDER ID</strong></td>
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<td><strong>COMPTE</strong></td>
								<td><strong>TP NAME</strong></td>
								<td><strong>TP STATUS</strong></td>
								<td><strong>REMAINING</strong></td>
								<td><strong>LAST LESSON</strong></td>
								<!---<td><strong></strong></td>--->
								<td><strong>DEADLINE</strong></td>
								<td><strong>COMMENTS</strong></td>
							</tr>
							<cfoutput query="get_tp">
							
							<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
							<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
							<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
							<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
							<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
							<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
							<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
							<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
							<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
							
							<!---<cfif 
							(view eq "noclosenoremain" AND isdefined("tp_remain_without_schedule_go") AND tp_remain_without_schedule_go eq "0") 
							OR (view neq "noclosenoremain" AND view neq "minusremain")
							OR (view eq "minusremain" AND tp_remain_go lt 0)							
							>--->
							
							<tr>
								<td>
									<span class="badge badge-pill text-white badge-#status_finance_css#">#order_ref# - #status_finance_name#</span>
								</td>
								<td>
									<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#get_tp.tp_id#")>
									<cfloop query="tp_trainer">
										<small>#planner#,</small>
									</cfloop>
								</td>
								<td>
									<span class="badge badge-#user_status_css#">#user_status_name#</span>
									<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a>
								</td>
								<td>
									#account_name#
								</td>
								<td>
									<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a>
								</td>
								<td>
									<span class="badge badge-info">#status_name#</span>
								</td>
								<!---<td>
									#dateformat(tp_date_end,'dd/mm/yyyy')#
								</td>
								<td>
									#tp_duration/60#
								</td>
								<td>
									#session_duration/60#
								</td>--->
								
								<td>
									#tp_remain_go/60#
								</td>
								
								<td>
									<cfif maxl lt dateadd("m",-3,now())>
									<strong style="color:##FFA100">#dateformat(maxl,'dd/mm/yyyy')#</strong>
									<cfelse>
									#dateformat(maxl,'dd/mm/yyyy')#<!--- - #timeformat(maxl,'HH:mm')#--->
									</cfif>
								</td>
								
								<!---<td>
									#dateformat(lesson_start,'dd/mm/yyyy')# - #timeformat(lesson_start,'HH:mm')# 
								</td>--->
								
								<td>
									<cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif>
								</td>
			
								<td>
									<cfif order_id neq "">
									<button type="button" class="btn <cfif nb_log eq "0">btn-outline-info<cfelse>btn-outline-warning</cfif> btn-sm btn_view_log" id="o_#order_id#">
									<i class="fas fa-sticky-note"></i> 
									</button>
									</cfif>
								</td>
							</tr>	
							<!---</cfif>	--->						
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$( document ).ready(function() {

})
</script>

</body>
</html>