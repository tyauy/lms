<cfif isdefined("reinit") AND not isdefined("SESSION.USER_ID")>

<cfif find("de",CGI.HTTP_ACCEPT_LANGUAGE)>
	<cfset SESSION.LANG = "3">
	<cfset SESSION.LANG_CODE = "de">
<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
	<cfset SESSION.LANG = "1">
	<cfset SESSION.LANG_CODE = "fr">
<cfelse>
	<cfset SESSION.LANG = "2">
	<cfset SESSION.LANG_CODE = "en">
</cfif>

<cfoutput>
<div class="row" style="margin-top:5px">
	<div class="col-md-12">
		<form action="_updater_mdp.cfm" id="form_pw" method="post">
		#obj_translater.get_translate('modal_txt_reinit_please')# 
		<input type="text" name="user_email" class="form-control" required="yes">
		<br><br>
		#obj_translater.get_translate('modal_txt_reinit_explain')#
		<br><br>
		<div align="center">
		<input type="hidden" name="reinit" value="1">
		<input type="submit" class="btn btn-danger" value="#obj_translater.get_translate('btn_go_send')#">
		</div>
		</form>
	</div>
</div>
</cfoutput>


<cfelseif isdefined("reinit") AND isdefined("SESSION.USER_ID") AND ((isdefined("SESSION.USER_PROFILE") AND SESSION.USER_PROFILE eq "learner") OR (isdefined("SESSION.USER_PROFILE") AND SESSION.USER_PROFILE eq "test"))>

<cfoutput>
<div class="row" style="margin-top:5px">
	<div class="col-md-12">
		<form action="_updater_mdp.cfm" id="form_pw" method="post">
		#obj_translater.get_translate('modal_txt_reinit_connected_please')# 
		<input type="text" name="user_email" class="form-control" required="yes" value="#SESSION.USER_EMAIL#" disabled>
		<br><br>
		#obj_translater.get_translate('modal_txt_reinit_connected_explain')#
		<br><br>
		<div align="center">
		<input type="hidden" name="reinit" value="1">
		<input type="submit" class="btn btn-danger" value="#obj_translater.get_translate('btn_go_send')#">
		</div>
		</form>
	</div>
</div>
</cfoutput>

</cfif>