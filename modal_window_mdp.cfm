<cfif isdefined("init")>



<div class="row" style="margin-top:5px">
	<div class="col-md-12">
		<cfoutput>
		<strong>#obj_translater.get_translate('modal_txt_welcome')# #SESSION.USER_NAME# !</strong>
		<br><br>
		#obj_translater.get_translate('modal_txt_mdp_info')#
		<br><br>
		<form action="updater_learner.cfm" id="form_pw" method="post">
		<table class="table table-sm">
			<tr>
				<td class="bg-light"><label>#obj_translater.get_translate('modal_txt_mdp')#</label></td>
				<td colspan="2">
				<input type="password" required="yes" minlength="6" name="user_pwd" id="user_pwd" class="form-control">
				</td>
			</tr>
			<tr>
				<td class="bg-light"><label>#obj_translater.get_translate('modal_txt_mdp_repeat')#</label></td>
				<td colspan="2">
				<input type="password" required="yes" minlength="6" name="user_pwd2" id="user_pwd2" class="form-control">
				</td>
			</tr>
		</table>	
		<input type="hidden" name="init" value="1">
		<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_mdp_reset')#"></div>
		</form>
		</cfoutput>
	</div>
</div>

<script>
$( document ).ready(function() {
	$("#form_pw").submit(function( event ) {
	if($("#user_pwd").val() != $("#user_pwd2").val())
	{
	alert("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_nomatch')#</cfoutput>" );
	event.preventDefault();
	
	}
	});
})
</script>

</cfif>
