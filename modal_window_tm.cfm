<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
SELECT 
a.account_name, a.account_id,
o.*, 
oc.*,
u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
oim.order_item_mode_name, 
ofi.status_finance_name, ofi.status_finance_css,
otm.status_tm_name, otm.status_tm_css, 
oi.*, 
a2.account_name as opca_name, 
u.user_firstname, u.user_name,
u2.user_firstname as manager_firstname, u2.user_color as manager_color,
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


FROM orders o

INNER JOIN account a ON a.account_id = o.account_id
INNER JOIN orders_users ou ON o.order_id = ou.order_id
INNER JOIN user u ON u.user_id = ou.user_id
INNER JOIN user_status st ON st.user_status_id = u.user_status_id

LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
LEFT JOIN order_context oc ON oc.context_id = o.context_id

INNER JOIN account a2 ON o.account_id = a2.account_id
INNER JOIN account_group ag ON ag.group_id = a2.group_id
LEFT JOIN user u2 ON u2.user_id = ag.manager_id
LEFT JOIN lms_formation f ON f.formation_id = o.formation_id


INNER JOIN lms_tp t ON t.order_id = o.order_id
INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id

LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1

LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
LEFT JOIN lms_formation fo ON fo.formation_id = t.formation_id
LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id

WHERE 1 = 1

<cfif SESSION.ACCOUNT_ID neq "0">
AND a.account_id = #SESSION.ACCOUNT_ID#
<cfelse>
AND a.group_id = #SESSION.GROUP_ID#
</cfif>

<cfif view eq "launch">
AND (t.method_id = 1 OR t.method_id = 2 OR t.method_id = 6)
AND (t.tp_status_id = 1 OR t.tp_status_id = 6)
</cfif>

<cfif view eq "nnl">
AND (t.method_id = 1 OR t.method_id = 2 OR t.method_id = 6)
AND (t.tp_status_id = 2)
</cfif>

<cfif view eq "missed">
AND (t.method_id = 1 OR t.method_id = 2 OR t.method_id = 6)
AND (t.tp_status_id = 2)
</cfif>

<cfif view eq "deadline">
AND (t.method_id = 1 OR t.method_id = 2 OR t.method_id = 6)
AND (t.tp_status_id = 2 OR t.tp_status_id = 3)
AND o.order_end <= #dateadd('m',+2,now())# 
AND o.order_status_id <> 10
AND o.order_status_id <> 11
AND o.order_status_id <> 6
</cfif>

GROUP BY t.tp_id, t.order_id

<cfif view eq "nnl">
HAVING max_lesson < now()
ORDER BY max_lesson ASC
</cfif>

<cfif view eq "missed">
HAVING tp_missed > 0
ORDER BY tp_missed DESC
</cfif>

<cfif view eq "deadline">
ORDER BY order_end ASC
</cfif>



</cfquery>


<cfif view eq "launch">
<table class="table table-bordered">
	<tr class="bg-light">
		<td width="50%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="20%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
		<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
	</tr>
	<cfoutput query="get_orders">
	<tr>
		<td>#user_firstname# #user_name#<br>#account_name#</td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
		<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
	</tr>
	</cfoutput>
</table>
</cfif>

<cfif view eq "nnl">
<table class="table table-bordered">
	<tr class="bg-light">
		<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="15%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
		<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
		<td><cfoutput>#obj_translater.get_translate('table_th_last_activity')#</cfoutput></td>
		<td><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></td>
	</tr>
	<cfoutput query="get_orders">
	<tr>
		<td>#user_firstname# #user_name#<br>#account_name#</td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
		<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
		<td><cfif max_lesson lt dateadd("m",-2,now())><div class="badge badge-pîll badge-danger" style="font-size:15px">#obj_dater.get_dateformat(max_lesson)#</div><cfelse><div class="badge badge-pîll badge-warning text-white" style="font-size:15px">#obj_dater.get_dateformat(max_lesson)#</div></cfif></td>
		<td>
		<cfif max_lesson gte dateadd("d",-7,now())>
		#obj_translater.get_translate('text_no_course_planned')#
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

<cfif view eq "missed">
<table class="table table-bordered">
	<tr class="bg-light">
		<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="15%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
		<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
		<td><cfoutput>#obj_translater.get_translate('table_th_missed_lesson')#</cfoutput></td>
		<td><cfoutput>#obj_translater.get_translate('table_th_missed_ratio')#</cfoutput></td>
	</tr>
	<cfoutput query="get_orders">
	<tr>
		<td>#user_firstname# #user_name#<br>#account_name#</td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
		<td>#tp_duration/60# h</td>
		<td>#obj_lms.get_formath(tp_missed)# h</td>
		<td><div class="badge badge-pîll badge-danger" style="font-size:15px">#round(tp_missed/tp_duration*100)# %</div></td>										
	</tr>
	</cfoutput>
</table>
</cfif>

<cfif view eq "deadline">
<table class="table table-bordered">
	<tr class="bg-light">
		<td width="30%"><cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput></td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td width="20%"><cfoutput>#obj_translater.get_translate('table_th_account')#</cfoutput></td></cfif> --->
		<td><cfoutput>#obj_translater.get_translate('table_th_tp')#</cfoutput></td>
		<td><cfoutput>#obj_translater.get_translate('table_th_deadline')#</cfoutput></td>
	</tr>
	<cfoutput query="get_orders">
	<tr>
		<td>#user_firstname# #user_name#<br>#account_name#</td>
		<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1><td><cfif len(account_name) gt 20>#mid(account_name,1,20)# [...]<cfelse>#account_name#</cfif></td></cfif> --->
		<td><a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a></td>
		<td><cfif order_end lt now()><div class="badge badge-pîll badge-danger" style="font-size:15px">#obj_dater.get_dateformat(order_end)#</div><cfelse><div class="badge badge-pîll badge-warning text-white" style="font-size:15px">#obj_dater.get_dateformat(order_end)#</div></cfif></td>
	</tr>
	</cfoutput>
</table>
</cfif>




