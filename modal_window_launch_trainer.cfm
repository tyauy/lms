<cfif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND isdefined("p_id") AND isdefined("mdp_launch")>


	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_email
	FROM user u
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND profile_id = 4
	</cfquery>
		
		
	<p>
	Le mot de passe du trainer va &ecirc;tre r&eacute;initialis&eacute;.
	Un email est envoy&eacute; &agrave; l'utilisateur l'invitant &agrave; se connecter &agrave; l'aide du mot de passe temporaire pour le changer par la suite.
	</p>
	
	<cfform action="updater_trainer.cfm">
	<table class="table table-sm">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Identifiants de connexion</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="30%">
			<label>Email (connexion)*</label>
			</td>
			<td colspan="2">
			<cfoutput>#get_user.user_email#</cfoutput>
			</td>
		</tr>
		<!---<tr>
			<td class="bg-light" width="30%">
			<label>Mot de passe <em>(temporaire)</em></label>
			</td>
			<td colspan="2">
			<cfset temp = RandRange(100000, 999999)>
			<input type="text" class="form-control" name="user_pwd" required="yes" value="<cfoutput>#temp#</cfoutput>">
			</td>
		</tr>--->
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Notification</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="30%">
			<label>Envoyer email</label>
			</td>
			<td colspan="2">
			<input type="checkbox" name="send_email" value="1" checked="yes" disabled>
			<!---<input type="checkbox" name="send_email" value="1">--->
			</td>
		</tr>
	</table>
	
	
	<cfoutput>
	<input type="hidden" name="p_id" value="#p_id#">
	</cfoutput>
	<input type="hidden" name="updt_mdp" value="1">
	<input type="hidden" name="updt_trainer" value="1">	
	<div align="center"><input type="submit" class="btn btn-success" value="Modifier"></div>		
	</cfform>

</cfif>