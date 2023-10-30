<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id") AND (isdefined("learner_launch") OR isdefined("test_launch") OR isdefined("migration_launch"))>
	
	<cfif isdefined("migration_launch")>

		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",st_id="2")>

	<cfelse>
		
		<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1")>

	</cfif>
			
	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT user_access_tp
	FROM user u
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
			
	<cfif listlen(get_user.user_access_tp) neq "0">
	<cfquery name="get_tpmaster_access" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_tpmaster2 WHERE tpmaster_id IN (#get_user.user_access_tp#) ORDER BY tpmaster_rank ASC
	</cfquery>
	</cfif>
	
	<cfform action="updater_learner.cfm">
	<!--- <table class="table table-sm table-bordered"> --->
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong>Lancement (en dev // IGNORER)</strong></td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"><label>Option Setup</label> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="L'option Setup s'affiche lors de la première connexion de l'utilisateur (client B2B)">?</span></td> --->
			<!--- <td colspan="2"> --->
			<!--- <div class="btn-group-toggle" data-toggle="buttons"> --->
			<!--- <label class="btn btn-sm btn-outline-warning"> --->
			<!--- <input type="radio" name="user_setup" autocomplete="off" value="1"> <i class="fas fa-star"></i> Avec Setup --->
			<!--- </label>			 --->
			<!--- &nbsp; --->
			<!--- <label class="btn btn-sm btn-outline-info active"> --->
			<!--- <input type="radio" name="user_setup" autocomplete="off" value="0" checked> <i class="fas fa-thumbs-up"></i> Sans setup --->
			<!--- </label> --->
			<!--- </div> --->
			<!--- </td> --->
		<!--- </tr> --->
	<!--- </table> --->
		
	<!--- <table class="table table-sm table-bordered"> --->
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong>&Eacute;tapes de lancement  (si non renseign&eacute;es, pas de pop-up d'invitation set-up)</strong></td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"> --->
			<!--- <label>Test d'&eacute;valuation EN</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_en" value="1" checked> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_en" value="0" > Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"> --->
			<!--- <label>Test d'&eacute;valuation DE</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_de" value="1"> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_de" value="0" checked> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"> --->
			<!--- <label>Test d'&eacute;valuation FR</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_fr" value="1"> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_fr" value="0" checked> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"> --->
			<!--- <label>Profil d'apprentissage</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="lst_step" value="1"> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="lst_step" value="0" checked> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"> --->
			<!--- <label>Recueil de besoin</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="need_step" value="1" checked>  Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="need_step" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
	<!--- </table> --->
	
	
	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Lancement</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="25%">
			<label>Parcours</label>
			</td>
			<td colspan="2">
				<cfif get_tps.recordcount neq "0">
				<table>
				<cfoutput query="get_tps">
				
				<!------- CHECK IF AT LEAST ONE VISIO TP ----->
				<cfif method_id eq "1">
					<cfset access_visio = "1">
					<cfset formation_id = formation_id>
				</cfif>
				
					<tr>
						<td>
						#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
						</td>
						<td>
						<span class="badge badge-pill badge-secondary">#status_name#</span>
						</td>
						<td>
						D&eacute;but : #dateformat(tp_date_start,'dd/mm/yyyy')#
						</td>						
						<td>
						Fin : #dateformat(tp_date_end,'dd/mm/yyyy')#
						</td>
					</tr>
				</cfoutput>
				</table>
				<cfelse>
					<div class="alert alert-danger"><strong>Attention !</strong> Lancement impossible, aucun parcours...</div>
				</cfif>
			</td>
		</tr>
		<!---<tr>
			<td class="bg-light" width="25%">
			<label>Acc&egrave;s</label>
			</td>
			<td colspan="2">
			<cfif listlen(get_user.user_access_tp) neq "0" AND get_tpmaster_access.recordcount neq "0">			
			<cfoutput query="get_tpmaster_access">					
			<span class="badge badge-success badge-pill">[#tpmaster_level#] #tpmaster_name#</span>
			</cfoutput>
			<cfelse>
			<div class="alert alert-danger"><strong>Attention !</strong> Lancement impossible, aucun acc&egrave;s aux ressources...</div>
			</cfif>
			</td>
		</tr>--->
	</table>
	
	<table class="table table-sm table-bordered">
		
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Notification</strong></td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%">
			<label>Cr&eacute;er mot de passe <br><em>(new learner)</label>
			</td>
			<td colspan="2">
			<input type="checkbox" checked="yes" name="send_reset" value="1">
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%">
			<label>Envoyer email invitation</label>
			</td>
			<td colspan="2">
			<input type="checkbox" checked="yes" name="send_email" value="1">
			</td>
		</tr>
	</table>
	
	<cfoutput>
	
	<cfif isdefined("access_visio")>
	<input type="hidden" name="access_visio" value="1">
	</cfif>
	<cfif isdefined("formation_id")>	
	<input type="hidden" name="formation_id" value="#formation_id#">	
	</cfif>
	
	<input type="hidden" name="u_id" value="#u_id#">
	
	<cfif isdefined("learner_launch")>
		<input type="hidden" name="updt_learner" value="1">	
		<input type="hidden" name="updt_steps" value="1">
	<cfelseif isdefined("test_launch")>
		<input type="hidden" name="updt_test" value="1">
		<input type="hidden" name="updt_steps" value="1">
	<cfelseif isdefined("migration_launch")>
		<input type="hidden" name="updt_migration" value="1">	
	</cfif>
	
	<div align="center"><input type="submit" class="btn btn-success <cfif get_tps.recordcount eq "0" AND !(isdefined("test_launch"))>disabled</cfif>" value="Lancer Learner"></div>	
	</cfoutput>	
	</cfform>
	

<!--- <cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id") AND isdefined("migrate_launch")> --->
			
	<!--- <cfform action="updater_learner.cfm"> --->
	<!--- <table class="table table-sm"> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Envoyer email invitation</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <input type="checkbox" name="send_email" value="1"> --->
			<!--- </td> --->
		<!--- </tr> --->
	<!--- </table> --->
	
	
	<!--- <cfoutput> --->
	<!--- <input type="hidden" name="u_id" value="#u_id#"> --->
	<!--- </cfoutput> --->
	<!--- <input type="hidden" name="updt_migrate" value="1"> --->
	<!--- <input type="hidden" name="updt_learner" value="1">	 --->
	<!--- <div align="center"><input type="submit" class="btn btn-success" value="Migrer Learner"></div>		 --->
	<!--- </cfform> --->
	

<!--- <cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id") AND isdefined("test_launch")> --->

	<!--- <cfquery name="get_tpmaster_access" datasource="#SESSION.BDDSOURCE#"> --->
	<!--- SELECT * FROM lms_tpmaster2 WHERE tpmaster_id <> 15 ORDER BY tpmaster_rank ASC --->
	<!--- </cfquery> --->

	<!--- <cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#"> --->
	<!--- SELECT * FROM user WHERE profile_id = 4 ORDER BY user_firstname ASC --->
	<!--- </cfquery> --->
			
	
	<!--- <p> --->
	<!--- Un email de bienvenue est envoy&eacute; &agrave; l'utilisateur. Il a la possibilit&eacute; de : --->
	<!--- </p> --->
	
	<!--- <cfform action="updater_learner.cfm"> --->
	<!--- <table class="table table-sm"> --->
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong>&Eacute;tapes de lancement</strong></td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Test d'&eacute;valuation EN</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_en" value="1" checked> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_en" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Test d'&eacute;valuation DE</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_de" value="1" checked> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_de" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Test d'&eacute;valuation FR</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="qpt_step_fr" value="1" checked> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="qpt_step_fr" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Profil d'apprentissage</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="lst_step" value="1" checked> Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="lst_step" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Recueil de besoin</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <label><input type="radio" name="need_step" value="1" checked>  Oui</label> &nbsp;&nbsp;&nbsp; <label><input type="radio" name="need_step" value="0"> Non</label> --->
			<!--- </td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong>Gestion acc&egrave;s</strong></td> --->
		<!--- </tr> --->
		<!--- <tr> --->
			<!--- <td><label>Acc&egrave;s</label></td> --->
			<!--- <td> --->
			<!--- <cfoutput query="get_tpmaster_access" startrow="1" maxrows="8">					 --->
				<!--- <label style="font-size:10px"><input type="checkbox" name="user_access_tp" value="#tpmaster_id#"> [#tpmaster_level#] #tpmaster_name#</label><br> --->
			<!--- </cfoutput> --->
			<!--- </td> --->
			<!--- <td> --->
			<!--- <cfoutput query="get_tpmaster_access" startrow="8" maxrows="#get_tpmaster_access.recordcount#">					 --->
				<!--- <label style="font-size:10px"><input type="checkbox" name="user_access_tp" value="#tpmaster_id#"> [#tpmaster_level#] #tpmaster_name#</label><br> --->
			<!--- </cfoutput> --->
			<!--- </td> --->
		<!--- </tr> --->
				
		<!--- <tr> --->
			<!--- <td colspan="3" bgcolor="#ECECEC"><strong>Notification</strong></td> --->
		<!--- </tr> --->
		
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Cr&eacute;er mot de passe <br><em>(new learner)</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <input type="checkbox" checked="yes" name="send_reset" value="1"> --->
			<!--- </td> --->
		<!--- </tr> --->
		
		<!--- <tr> --->
			<!--- <td class="bg-light" width="30%"> --->
			<!--- <label>Envoyer email invitation</label> --->
			<!--- </td> --->
			<!--- <td colspan="2"> --->
			<!--- <input type="checkbox" name="send_email" value="1"> --->
			<!--- </td> --->
		<!--- </tr> --->
	<!--- </table> --->
	
	
	<!--- <cfoutput> --->
	<!--- <input type="hidden" name="u_id" value="#u_id#"> --->
	<!--- </cfoutput> --->
	<!--- <input type="hidden" name="updt_test" value="1"> --->
	<!--- <input type="hidden" name="updt_learner" value="1">	 --->
	<!--- <div align="center"><input type="submit" class="btn btn-success" value="Lancer Test"></div>		 --->
	<!--- </cfform> --->

	
	
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id") AND isdefined("mdp_launch")>


	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_email
	FROM user u
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND (profile_id = 3 OR profile_id = 7 OR profile_id = 9)
	</cfquery>
		
		
	<p>
	Le mot de passe de l'apprenant va &ecirc;tre r&eacute;initialis&eacute;.
	Un email est envoy&eacute; &agrave; l'utilisateur l'invitant &agrave; se connecter &agrave; l'aide du mot de passe temporaire pour le changer par la suite.
	</p>
	
	<cfform action="updater_learner.cfm">
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
	<input type="hidden" name="u_id" value="#u_id#">
	</cfoutput>
	<input type="hidden" name="updt_mdp" value="1">
	<input type="hidden" name="updt_learner" value="1">	
	<div align="center"><input type="submit" class="btn btn-success" value="Modifier"></div>		
	</cfform>


	
	
	
	
	
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id") AND isdefined("newmail_launch")>


	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_email
	FROM user u
	WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND (profile_id = 3 OR profile_id = 7 OR profile_id = 9)
	</cfquery>
		
	<p>
	L'email principal (connexion) va &ecirc;tre chang&eacute;, ainsi que le mot de passe.
	Un email est envoy&eacute; &agrave; l'utilisateur l'invitant &agrave; se connecter &agrave; l'aide du mot de passe temporaire pour le changer par la suite.
	</p>
	
	<cfform action="updater_learner.cfm">
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
		<tr>
			<td class="bg-light" width="30%">
			<label>New email (connexion)*</label>
			</td>
			<td colspan="2">
			<input type="text" class="form-control" name="user_email" required="yes" placeholder="Email principal">
			</td>
		</tr>
		<!----<tr>
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
			<input type="checkbox" name="send_email" value="1" checked="yes">
			</td>
		</tr>
	</table>
	
	
	<cfoutput>
	<input type="hidden" name="u_id" value="#u_id#">
	</cfoutput>
	<input type="hidden" name="updt_newmail" value="1">
	<input type="hidden" name="updt_learner" value="1">	
	<div align="center"><input type="submit" class="btn btn-success" value="Modifier"></div>		
	</cfform>

</cfif>