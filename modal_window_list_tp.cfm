<cfsilent>
<cfif isdefined('ord')>
<cfquery name="get_list_tp" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_firstname, u.user_name, t.tp_date_start, t.tp_id, u.user_id
	FROM lms_tp t
	LEFT JOIN user u ON u.user_id = t.user_id
	LEFT JOIN orders o ON o.order_id = t.order_id
	WHERE t.method_id = #method_id# AND year(t.tp_date_start) = #y# AND o.order_status_id = #status#
</cfquery>
<cfelse>
<cfquery name="get_list_tp" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_firstname, u.user_name, t.tp_date_start, t.tp_id, u.user_id
	FROM lms_tp t
	LEFT JOIN user u ON u.user_id = t.user_id 
	WHERE t.method_id = #method_id# AND year(t.tp_date_start) = #y# AND t.tp_status_id = #status#
</cfquery>
</cfif>
</cfsilent>

<table class="table table-bordered">
<cfoutput query="get_list_tp">
<tr>
<td>#user_firstname# #ucase(user_name)#</td>
<td>#dateformat(tp_date_start, 'dd/mm/yyyy')#</td>
<td><a class="btn btn-link btn-dark" id="#user_id#" href="#SESSION.BO_ROOT_URL#/common_learner_account.cfm?u_id=#user_id#">see learner</a></td>
<td><a class="btn btn-link btn-dark" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">see TP</a></td>
</tr>
</cfoutput>
</table>