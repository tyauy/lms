<cfoutput>
<div class="card card-user">
	<div class="image">
		<img src="./assets/img/header_email_wefit1.jpg">
	</div>
	<div class="card-body" style="min-height:100px">
		<div class="author">
			#obj_lms.get_avatar(user_id="#u_id#")#
			<h5 class="title">#user_name# </h5>
		</div>
		
		<table class="table table-sm">
			<tr>
				<th colspan="2" class="bg-light"><label>#obj_translater.get_translate('table_th_details')#</label><cfif listFindNoCase("LEARNER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)><div class="float-right"><button class="btn btn-info btn-sm btn_learner_edit_account my-0"><i class="fas fa-edit"></i></button></div></cfif></th>
			</tr>
			<tr>
				<td width="20%"><label>#obj_translater.get_translate('table_th_genre')#</label></td>
				<td>#user_gender#</td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_firstname')#</label></td>
				<td>#user_firstname#</td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_lastname')#</label></td>
				<td>#user_lastname#</td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_phone')#</label></td>
				<td>#user_phone#</td>
			</tr>
			<tr>
				<th colspan="2" class="bg-light"><label>#obj_translater.get_translate('table_th_login')#</label></th>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_email')#</label></td>
				<td>#user_email#</td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_password')#</label></td>
				<td><a href="##" class="btn_edit_mdp">[#obj_translater.get_translate('btn_reset')#</a></td>
			</tr>
			<tr>
				<th colspan="2" class="bg-light"><label>#obj_translater.get_translate('table_th_notifications')#</label></th>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_24h')#</label></td>
				<td><cfif user_remind_1d eq "1"><i class="fas fa-check"></i></cfif></td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_3h')#</label></td>
				<td><cfif user_remind_3h eq "1"><i class="fas fa-check"></i></cfif></td>
			</tr>
			<tr>
				<td><label>#obj_translater.get_translate('table_th_15m')#</label></td>
				<td><cfif user_remind_15m eq "1"><i class="fas fa-check"></i></cfif></td>
			</tr>
		</table>
		
	</div>
	
</div>
</cfoutput>