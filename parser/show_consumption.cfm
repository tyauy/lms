<html>

<head>
	<base href="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/">
	<cfinclude template="../incl/incl_head.cfm">
</head>

<body>
<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT o.order_id, o.order_ref, o.order_start, o.order_end,
a.account_name,
u.user_id, u.user_firstname, u.user_name
FROM orders o
LEFT JOIN account a ON a.account_id = o.account_id
LEFT JOIN orders_users ou ON o.order_id = ou.order_id
LEFT JOIN user u ON u.user_id = ou.user_id
ORDER BY order_ref
</cfquery>

<cfparam name="date_start" default="2019-08-01">
<cfparam name="date_end" default="2020-07-31">
	
<div style="padding:15px">

	<div class="row">
									
		<div class="col-md-12">
			<h6>Affichage personnalis&eacute;</h6>
			<form action="./parser/show_consumption.cfm" method="post">
			<div class="row align-items-end">
				<cfoutput>
				<div class="col-md-8">										
					<div class="control-group">
						<label for="date_start" class="control-label">#obj_translater.get_translate('short_between')#</label>
						<div class="controls">
							<div class="input-group">
								<input id="date_start" name="date_start" type="text" class="datepicker form-control" autocomplete="off" value="#date_start#" />
								<label for="date_start" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
							</div>
						</div>
					</div>

					<div class="control-group">
						<label for="date_end" class="control-label">#obj_translater.get_translate('short_and')#</label>
						<div class="controls">
							<div class="input-group">
								<input id="date_end" name="date_end" type="text" class="datepicker form-control" autocomplete="off" value="#date_end#" />
								<label for="date_end" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">	
					<input type="submit" value="EXPORT" class="btn btn-info" style="display:inline">											
				</div>
				</cfoutput>
			</div>
			</form>
		</div>
	</div>
							
	<table border="1" width="100%">
	<tr bgcolor="#ECECEC">
		<td width="80">O_ID</td>
		<td>START</td>
		<td>END</td>
		<td>ACCOUNT</td>
		<td>LEARNER</td>
		<td width="250">TP</td>
		<td>TP STATUS</td>
		<td>TP H</td>
		<td width="200">CONSO < <cfoutput>#dateformat(date_start,'dd/mm/yyyy')#</cfoutput></td>
		<td width="200">CONSO PÉRIODE</td>
		<td>REMAINING <cfoutput>#dateformat(date_end,'dd/mm/yyyy')#</cfoutput></td>
	</tr>
	<cfoutput query="get_order">

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
	SUM(s.session_duration) as session_duration,
	s.sessionmaster_id,
	l.lesson_id,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_end#') as tp_scheduled,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_end#') as tp_inprogress,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_end#') as tp_cancelled,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_end#') as tp_missed,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_end#') as tp_completed,

	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_start#') as tp_scheduled_before,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_start#') as tp_inprogress_before,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_start#') as tp_cancelled_before,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_start#') as tp_missed_before,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5 AND DATE_FORMAT(lesson_start,"%Y-%m-%d") <= '#date_start#') as tp_completed_before,

	st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css

	FROM lms_tp t 

	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
	LEFT JOIN user u ON tpu.user_id = u.user_id
	INNER JOIN user_status st ON st.user_status_id = u.user_status_id
	LEFT JOIN account a ON a.account_id = u.account_id
	INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
	LEFT JOIN orders o ON o.order_id = t.order_id
	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id

	LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
	LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
	LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1

	LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
	LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
	LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
	LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
	LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id

	WHERE o.order_id = #order_id#
	GROUP BY t.tp_id
	</cfquery>

	<cfloop query="get_tp">
	<tr>
		<td valign="top" width="80">
		#order_ref#
		</td>
		<td valign="top" width="80">
		#dateformat(order_start,'dd/mm/yyyy')#
		</td>
		<td valign="top" width="80">
		#dateformat(order_end,'dd/mm/yyyy')#
		</td>
		<td valign="top" width="200">
		#mid(account_name,1,25)#
		</td>
		<td valign="top" width="200">
		<a href="#SESSION.BO_ROOT_URL#/common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a>
		</td>
		
		<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
		<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
		<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
		<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
		<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>

		<cfset tp_done_go = tp_completed_go+tp_inprogress_go+tp_missed_go>

		<cfif tp_scheduled_before eq ""><cfset tp_scheduled_before_go = "0"><cfelse><cfset tp_scheduled_before_go = tp_scheduled_before></cfif>
		<cfif tp_inprogress_before eq ""><cfset tp_inprogress_before_go = "0"><cfelse><cfset tp_inprogress_before_go = tp_inprogress_before></cfif>
		<cfif tp_cancelled_before eq ""><cfset tp_cancelled_before_go = "0"><cfelse><cfset tp_cancelled_before_go = tp_cancelled_before></cfif>
		<cfif tp_missed_before eq ""><cfset tp_missed_before_go = "0"><cfelse><cfset tp_missed_before_go = tp_missed_before></cfif>
		<cfif tp_completed_before eq ""><cfset tp_completed_before_go = "0"><cfelse><cfset tp_completed_before_go = tp_completed_before></cfif>
				
		<cfset tp_done_before_go = tp_completed_before_go+tp_inprogress_before_go+tp_missed_before_go>

		<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>

		<cfset tp_remain_go = tp_duration_go-tp_done_go-tp_done_before_go>	

		<td width="200">
		#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
		</td>
		<td width="100">
		#status_name#
		</td>
		<td><strong>#tp_duration/60#</strong></td>
		<td width="200">#tp_done_before_go/60#</td>
		<td width="200">#tp_done_go/60#</td>
		<td width="200">#tp_remain_go/60#</td>				
		
	</tr>
	</cfloop>
	</cfoutput>

	</table>

</div>

</body>

<cfinclude template="../incl/incl_scripts.cfm">

<script>
	$(function() {
		$("#date_start").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {
			$( "#date_end" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_end").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {
			$( "#date_start" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
	});
</script>

</html>