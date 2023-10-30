<cfsilent>

	<cfparam name="u_id" default="0">
	<cfparam name="group" default="0">
	<cfparam name="vc" default="0">
	<cfparam name="o_id" default="">

	<cfquery name="get_list_certification_token" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT(certif_id) as certif_id FROM lms_list_token
	</cfquery>
	<cfset list_certif = "">
	<cfoutput query="get_list_certification_token">
	<cfset list_certif = listappend(list_certif,certif_id)>
	</cfoutput>
	
	<cfquery name="get_tpskill" datasource="#SESSION.BDDSOURCE#">
	SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_objectives_#SESSION.LANG_CODE# as skill_objectives, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
	</cfquery>
		
	<cfquery name="get_tptype" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_type_id, tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tp_type_css, tp_type_img FROM lms_tptype 
	</cfquery>

	<cfquery name="get_tpformula" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_formula_id, tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tp_formula_desc_#SESSION.LANG_CODE# as tp_formula_desc, tp_formula_css, tp_formula_img, tp_formula_nbcourse FROM lms_tpformula
	</cfquery>
	
	<cfquery name="get_tpsupport" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_support_id, tp_support_name_#SESSION.LANG_CODE# as tp_support_name, tp_support_desc_#SESSION.LANG_CODE# as tp_support_desc, tp_support_css, tp_support_img FROM lms_tpsupport
	</cfquery>
	
	<cfquery name="get_tpstatus" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_status_id, tp_status_name_#SESSION.LANG_CODE# as status_name FROM lms_tpstatus
	</cfquery>



	<cfquery name="get_elearning" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_elearning
	</cfquery>
	
	<cfquery name="get_certification" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_certification WHERE certif_id NOT IN (1,21,24,25,28,29) ORDER BY certif_name
	</cfquery>
	
<!---- TOKEN MANAGAMENT - GET LIST OF UNUSED TOKEN AND NOT ATTRIBUTED TO OTHER TP ---->
	<cfif isdefined("t_id") AND u_id neq 0>
		<cfloop list="#list_certif#" index="cor">
		<cfquery name="get_certification_token_#cor#" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_list_token WHERE user_id IS NULL AND group_id IS NULL AND token_status_id = 0 AND certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> AND token_id NOT IN (SELECT token_id FROM lms_tp WHERE token_id <> 0 AND tp_id <> <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">)
		</cfquery>
		</cfloop>
	<cfelse>
		<cfloop list="#list_certif#" index="cor">
		<cfquery name="get_certification_token_#cor#" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_list_token WHERE user_id IS NULL AND group_id IS NULL AND token_status_id = 0 AND certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> AND token_id NOT IN (SELECT token_id FROM lms_tp WHERE token_id <> 0)
		</cfquery>
		</cfloop>
	</cfif> 

	<cfquery name="get_destination" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_destination
	</cfquery>	
	
	<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM user_profile WHERE profile_id = 3 OR profile_id = 7
	</cfquery>

	<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
	SELECT method_id, method_name_#SESSION.LANG_CODE# as method_alias FROM lms_lesson_method
	</cfquery>
	
	<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT formation_id, formation_code, formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation ORDER BY formation_name
	</cfquery>

	<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM user u
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = 4
	WHERE u.user_status_id = 4 OR u.user_status_id = 6 
	ORDER BY user_firstname ASC
	</cfquery>
		
	<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
	SELECT o.order_id, o.order_ref, u.user_firstname, u.user_name
	FROM orders o
	LEFT JOIN orders_users ou ON o.order_id = ou.order_id
	LEFT JOIN user u ON u.user_id = ou.user_id
	<cfif u_id neq 0>
		WHERE ou.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfif>
	ORDER BY o.order_ref ASC
	</cfquery>
	
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	<!--- added webex for BdF and Krys learner demo --->
	<cfif get_user.account_id EQ 1003 or get_user.user_id EQ 11743>
		<cfquery name="get_techno" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM lms_list_techno WHERE techno_id NOT IN (2, 9, 11)
		</cfquery>
	<cfelse>
		<cfquery name="get_techno" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM lms_list_techno WHERE techno_id NOT IN (2, 10, 9, 11)
		</cfquery>
	</cfif>
</cfsilent>

<cfif isdefined("create_tp")>

	<cfform action="updater_learner_tp.cfm" id="form_create_tp">

	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Parcours</strong></td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%"><label>Parcours</label> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="Le parcours NO LIMIT ne bloque pas la réservation après la date de fin de parcours">?</span></td>
			<td colspan="2">
			<div class="btn-group-toggle" data-toggle="buttons">
			<label class="btn btn-sm btn-outline-info active">
			<input type="radio" name="tp_vip" autocomplete="off" value="0" checked> <i class="fas fa-thumbs-up"></i> Normal
			</label>
			&nbsp;
			<label class="btn btn-sm btn-outline-warning">
			<input type="radio" name="tp_vip" autocomplete="off" value="1"> <i class="fas fa-star"></i> NO LIMIT
			</label>
			</div>
			</td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%"><label>Order</label></td>
			<td colspan="2">
			<select class="form-control" id="order_id" name="order_id">
				<cfif u_id neq 0>
					<cfoutput query="get_orders">
						<option value="#order_id#" <cfif order_id eq o_id>selected</cfif>>#replace(order_ref,'-','')# - #user_firstname# #user_name#</option>
					</cfoutput>	
				</cfif>
					
			<option value="3" <cfif o_id eq "">selected</cfif>>FREE REMAIN</option>
			<option value="2" <cfif o_id eq "">selected</cfif>>OLD</option>
			<option value="1" <cfif o_id eq "">selected</cfif>>OFFERT</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%"><label>Status TP</label></td>
			<td colspan="2">
			<select class="form-control" id="tp_status_id" name="tp_status_id">
				<cfoutput query="get_tpstatus">
					<option value="#tp_status_id#" <cfif tp_status_id neq "1" AND tp_status_id neq "6">disabled</cfif>>#status_name#</option>
				</cfoutput>
			</select>
			</td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%"><label>M&eacute;thode</label></td>
			<td colspan="2">
				<cfif group eq 1>
					<cfset method_id = 10>
				<cfelse>
					<cfset method_id = 1>
				</cfif>
			<cfselect class="form-control" id="method_id" name="method_id" query="get_method" display="method_alias" value="method_id" selected="#method_id#"></cfselect>
			</td>
		</tr>
		
		<!--- <tr class="aff_group">
			<td class="bg-light" width="25%"><label>Parcours</label></td>
			<td colspan="2">
				<label><input type="radio" name="tp_group" class="tp_group" value="0" checked> Solo &nbsp;&nbsp;&nbsp;</label>
				<label><input type="radio" name="tp_group" class="tp_group" value="1"> Group &nbsp;&nbsp;&nbsp;</label>
			</td>
		</tr> --->

		<tr>
			<td class="bg-light" width="25%"><label>Langue</label></td>
			<td colspan="2">
			<select name="formation_id" class="form-control">
			<cfoutput query="get_formation">
			<option value="#formation_id#" <cfif formation_id eq "2">selected</cfif>>#formation_name#</option>
			</cfoutput>
			</select>
			</td>
		</tr>	
		<cfif group eq 1>
			<tr>
				<td class="bg-light" width="25%"><label>Name</label></td>
				<td colspan="2">
				<input class="form-control" type="text" name="tp_name" required="no" validate="string">
				</td>
			</tr>
		</cfif>
		<tr>
			<td class="bg-light" width="25%"><label>Durée H</label></td>
			<td colspan="2">
			<input class="form-control" type="text" name="tp_duration" required="yes" validate="integer" <cfif get_user.profile_name eq "TEST">value="0.75" disabled</cfif>>
			</td>
		</tr>
		
		
		
		<tr class="aff_techno">
			<td class="bg-light" width="25%"><label>Techno</label></td>
			<td colspan="2">
			<cfoutput query="get_techno"><label><input type="radio" name="techno_id" class="techno_id" value="#techno_id#" <cfif techno_active>checked</cfif>> #techno_alias# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td> 
		</tr>
		<tr class="aff_el d-none">
			<td class="bg-light" width="25%"><label>Elearning</label></td>
			<td colspan="2">
			<cfoutput query="get_elearning"><label><input type="radio" name="elearning_id" class="elearning_id" value="#elearning_id#"> #elearning_name# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>
		<tr class="aff_el_dur d-none">
			<td class="bg-light" width="25%"><label>Elearning dur&eacute;e</label><br><small style="color:#FF0000"><strong>Uniquement pour l'affichage --> Attention, adapter date de fin du TP ci-dessous!!</strong></small></td>
			<td colspan="2">
			<select name="elearning_duration" class="form-control">
			<option value="1">1 jour</option>
			<option value="7">1 semaine</option>
			<cfoutput>
			<cfloop from="30" to="450" step="30" index="cor">
			<option value="#cor#" <cfif cor eq 30>selected</cfif>>#cor/30# mois</option>
			</cfloop>
			</cfoutput>
			</td>
		</tr>
		
		<tr class="aff_el_url d-none">
			<td class="bg-light" width="25%"><label>Elearning - URL</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_url" value="">
			</td>			
		</tr>
		
		<tr class="aff_el_login d-none">
			<td class="bg-light" width="25%"><label>Elearning - Identifiant</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_login" value="">
			</td>			
		</tr>
		
		<tr class="aff_el_password d-none">
			<td class="bg-light" width="25%"><label>Elearning - Password</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_password" value="">
			</td>			
		</tr>
		
		<tr class="aff_destination d-none">
			<td class="bg-light" width="25%"><label>Destination</label></td>
			<td>
			<cfselect class="form-control" name="destination_id" query="get_destination" display="destination_name" value="destination_id"></cfselect>
			</td>
			
		</tr>
		
		<tr class="aff_certification d-none">
			<td class="bg-light" width="25%"><label>Certification</label></td>
			<td>
			<cfselect class="form-control" name="certif_id" query="get_certification" display="certif_name" value="certif_id"></cfselect>
			</td>			
		</tr>
		<tr class="aff_certification_token d-none">
			<td class="bg-light" width="25%"><label>Certif - Token (Lingua or LTE)</label></td>
			<td>
			<cfloop list="#list_certif#" index="cor">
			<cfoutput>
			<div class="aff_certification_token_#cor# d-none">
				<cfselect class="form-control select_certification_token_#cor#" disabled name="token_id" query="get_certification_token_#cor#" display="token_code" value="token_id">
				<option value="0" selected>N/A</option>
				</cfselect>
			</div>
			</cfoutput>
			</cfloop>
			</td>			
		</tr>
		
		<tr class="aff_certification_url d-none">
			<td class="bg-light" width="25%"><label>Certif - URL</label></td>
			<td>
			<input type="text" class="form-control" name="certif_url" value="">
			</td>			
		</tr>
		
		<tr class="aff_certification_id d-none">
			<td class="bg-light" width="25%"><label>Certif - Identifiant</label></td>
			<td>
			<input type="text" class="form-control" name="certif_login" value="">
			</td>			
		</tr>
		
		
		<tr class="aff_tp">
			<td class="bg-light" width="25%"><label>Cr&eacute;ation TP</label></td>
			<td>
			<!---- TEST LEARNER, DONT AUTHHORIZE CLASSIC TP ---->
			<cfif get_user.profile_name eq "TEST">
			<label><input type="radio" name="tp_create" value="2" checked> [TP TEST]</label><br>
			<cfelse>
			<label><input type="radio" name="tp_create" value="1" checked> [TP 1st LESSON+PTA]</label><br>
			<label><input type="radio" name="tp_create" value="0"> [TP VIDE]</label><br>
			</cfif>
			
			
			<!----<label><input type="radio" name="tp_create" value="2"> [TP1 VIDE] + [TP2 CERTIF]</label><br>
			<label><input type="radio" name="tp_create" value="3"> [TP1 NA+PTA] + [TP2 CERTIF]</label>--->
			</td>			
		</tr>
	</table>

	
	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Dur&eacute;e</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>D&eacute;but</label></td>
			<td>
				<div class="controls">
					<div class="input-group">
						<cfoutput>
						<input id="tp_date_start" name="tp_date_start" type="text" class="datepicker form-control" value="#dateformat(now(),'dd/mm/yyyy')#" />
						<label for="tp_date_start" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
						</cfoutput>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Fin</label></td>
			<td>
				<div class="controls">
					<div class="input-group">
						<cfoutput>
						<input id="tp_date_end" name="tp_date_end" type="text" class="datepicker form-control" value="#dateformat(dateadd("YYYY","+1",now()),'dd/mm/yyyy')#" />
						<label for="tp_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
						</cfoutput>
					</div>
				</div>
			</td>
		</tr>
		
		<!---<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Notification</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="25%">
			<label>Envoyer email invitation</label>
			</td>
			<td colspan="2">
			<input type="checkbox" name="send_email" value="1">
			</td>
		</tr>--->
	</table>

	<cfoutput>
	<input type="hidden" name="u_id" value="#u_id#">
	<input type="hidden" name="ins_tp" value="1">
	<input type="hidden" name="ins_tp_group" value="#group#">
	<input type="hidden" name="ins_tp_vc" value="#vc#">
	<div align="center"><input type="submit" class="btn btn-success" value="Enregistrer"></div>		
	</cfoutput>
	</cfform>

	<script>
	$(document).ready(function() {

		$("#tp_date_start").datepicker({
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			numberOfMonths: 1,
			onClose: function( selectedDate ) {
				/*$( "#tp_date_end" ).datepicker( "option", "minDate", selectedDate );	*/

				var datego = moment(selectedDate, "DD-MM-YYYY").add(1,'years');
				datego = datego.format("DD/MM/YYYY");

				$( "#tp_date_end" ).datepicker("setDate", datego );

				
			}
		});
		var date_plus = moment();
		date_plus = moment(date_plus, "DD-MM-YYYY").add(1,'years');
		date_plus = date_plus.format("DD/MM/YYYY");
				
		$("#tp_date_end").datepicker({
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			numberOfMonths: 1,
			/*onClose: function( selectedDate ) {
				$( "#tp_date_start" ).datepicker( "option", "maxDate", selectedDate );
			}*/
		});
		
		$("#method_id").on("change", function(){
		
			if($("#method_id").val() == 1 || $("#method_id").val() == 8)
			{
				if($(".aff_tp").hasClass("d-none")){					$(".aff_tp").removeClass("d-none");}
				if($(".aff_techno").hasClass("d-none")){				$(".aff_techno").removeClass("d-none");}
				if($(".aff_group").hasClass("d-none")){					$(".aff_group").removeClass("d-none");}
				<!--- if($(".aff_formula").hasClass("d-none")){				$(".aff_formula").removeClass("d-none");} --->
				<!--- if($(".aff_skill").hasClass("d-none")){					$(".aff_skill").removeClass("d-none");} --->
				<!--- if($(".aff_support").hasClass("d-none")){				$(".aff_support").removeClass("d-none");} --->
				<!--- if($(".aff_type").hasClass("d-none")){					$(".aff_type").removeClass("d-none");} --->
				if($(".aff_p").hasClass("d-none")){						$(".aff_p").removeClass("d-none");}
				if($(".aff_p1").hasClass("d-none")){					$(".aff_p1").removeClass("d-none");}
				if($(".aff_p2").hasClass("d-none")){					$(".aff_p2").removeClass("d-none");}
				if($(".aff_p3").hasClass("d-none")){					$(".aff_p3").removeClass("d-none");}
				
				if(!$(".aff_destination").hasClass("d-none")){			$(".aff_destination").addClass("d-none");}
				
				if(!$(".aff_certification").hasClass("d-none")){		$(".aff_certification").addClass("d-none");}
				if(!$(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").addClass("d-none");}
				<cfloop list="#list_certif#" index="cor">
				<cfoutput>
				if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
				</cfoutput>
				</cfloop>
				if(!$(".aff_certification_url").hasClass("d-none")){	$(".aff_certification_url").addClass("d-none");}
				if(!$(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").addClass("d-none");}
				
				if(!$(".aff_el").hasClass("d-none")){					$(".aff_el").addClass("d-none");}
				if(!$(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").addClass("d-none");}
				if(!$(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").addClass("d-none");}
				if(!$(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").addClass("d-none");}
				if(!$(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").addClass("d-none");}
				

			}
			else if($("#method_id").val() == 2)
			{
				if($(".aff_tp").hasClass("d-none")){					$(".aff_tp").removeClass("d-none");}
				if($(".aff_group").hasClass("d-none")){					$(".aff_group").removeClass("d-none");}
				if($(".aff_p").hasClass("d-none")){						$(".aff_p").removeClass("d-none");}
				if($(".aff_p1").hasClass("d-none")){					$(".aff_p1").removeClass("d-none");}
				if($(".aff_p2").hasClass("d-none")){					$(".aff_p2").removeClass("d-none");}
				if($(".aff_p3").hasClass("d-none")){					$(".aff_p3").removeClass("d-none");}
				
				if(!$(".aff_destination").hasClass("d-none")){			$(".aff_destination").addClass("d-none");}
				if(!$(".aff_certification").hasClass("d-none")){		$(".aff_certification").addClass("d-none");}
				if(!$(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").addClass("d-none");}
				<cfloop list="#list_certif#" index="cor">
				<cfoutput>
				if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
				</cfoutput>
				</cfloop>
				if(!$(".aff_certification_url").hasClass("d-none")){	$(".aff_certification_url").addClass("d-none");}
				if(!$(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").addClass("d-none");}
				if(!$(".aff_el").hasClass("d-none")){					$(".aff_el").addClass("d-none");}
				if(!$(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").addClass("d-none");}
				if(!$(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").addClass("d-none");}
				if(!$(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").addClass("d-none");}
				if(!$(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").addClass("d-none");}
				if(!$(".aff_techno").hasClass("d-none")){				$(".aff_techno").addClass("d-none");}
				<!--- if(!$(".aff_formula").hasClass("d-none")){				$(".aff_formula").addClass("d-none");} --->
				<!--- if(!$(".aff_skill").hasClass("d-none")){				$(".aff_skill").addClass("d-none");} --->
				<!--- if(!$(".aff_support").hasClass("d-none")){				$(".aff_support").addClass("d-none");} --->
				<!--- if(!$(".aff_type").hasClass("d-none")){					$(".aff_type").addClass("d-none");} --->
			}	
			else if($("#method_id").val() == 3)
			{
				if($(".aff_el").hasClass("d-none")){					$(".aff_el").removeClass("d-none");}
				if($(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").removeClass("d-none");}
				if($(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").removeClass("d-none");}
				if($(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").removeClass("d-none");}
				if($(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").removeClass("d-none");}
				
				if(!$(".aff_tp").hasClass("d-none")){					$(".aff_tp").addClass("d-none");}
				if(!$(".aff_p").hasClass("d-none")){					$(".aff_p").addClass("d-none");}
				if(!$(".aff_p1").hasClass("d-none")){					$(".aff_p1").addClass("d-none");}
				if(!$(".aff_p2").hasClass("d-none")){					$(".aff_p2").addClass("d-none");}
				if(!$(".aff_p3").hasClass("d-none")){					$(".aff_p3").addClass("d-none");}				
				if(!$(".aff_destination").hasClass("d-none")){			$(".aff_destination").addClass("d-none");}
				if(!$(".aff_certification").hasClass("d-none")){		$(".aff_certification").addClass("d-none");}
				if(!$(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").addClass("d-none");}
				<cfloop list="#list_certif#" index="cor">
				<cfoutput>
				if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
				</cfoutput>
				</cfloop>
				if(!$(".aff_certification_url").hasClass("d-none")){	$(".aff_certification_url").addClass("d-none");}
				if(!$(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").addClass("d-none");}
				if(!$(".aff_techno").hasClass("d-none")){				$(".aff_techno").addClass("d-none");}
				if(!$(".aff_group").hasClass("d-none")){				$(".aff_group").addClass("d-none");}
				<!--- if(!$(".aff_formula").hasClass("d-none")){				$(".aff_formula").addClass("d-none");} --->
				<!--- if(!$(".aff_skill").hasClass("d-none")){				$(".aff_skill").addClass("d-none");} --->
				<!--- if(!$(".aff_support").hasClass("d-none")){				$(".aff_support").addClass("d-none");} --->
				<!--- if(!$(".aff_type").hasClass("d-none")){					$(".aff_type").addClass("d-none");} --->
			}
			else if($("#method_id").val() == 6)
			{	
				if($(".aff_destination").hasClass("d-none")){			$(".aff_destination").removeClass("d-none");}
				
				if(!$(".aff_tp").hasClass("d-none")){					$(".aff_tp").addClass("d-none");}
				if(!$(".aff_p").hasClass("d-none")){					$(".aff_p").addClass("d-none");}
				if(!$(".aff_p1").hasClass("d-none")){					$(".aff_p1").addClass("d-none");}
				if(!$(".aff_p2").hasClass("d-none")){					$(".aff_p2").addClass("d-none");}
				if(!$(".aff_p3").hasClass("d-none")){					$(".aff_p3").addClass("d-none");}
				if(!$(".aff_certification").hasClass("d-none")){		$(".aff_certification").addClass("d-none");}
				if(!$(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").addClass("d-none");}
				<cfloop list="#list_certif#" index="cor">
				<cfoutput>
				if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
				</cfoutput>
				</cfloop>
				if(!$(".aff_certification_url").hasClass("d-none")){	$(".aff_certification_url").addClass("d-none");}
				if(!$(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").addClass("d-none");}
				if(!$(".aff_el").hasClass("d-none")){					$(".aff_el").addClass("d-none");}
				if(!$(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").addClass("d-none");}
				if(!$(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").addClass("d-none");}
				if(!$(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").addClass("d-none");}
				if(!$(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").addClass("d-none");}
				if(!$(".aff_techno").hasClass("d-none")){				$(".aff_techno").addClass("d-none");}	
				if(!$(".aff_group").hasClass("d-none")){				$(".aff_group").addClass("d-none");}
				<!--- if(!$(".aff_formula").hasClass("d-none")){				$(".aff_formula").addClass("d-none");} --->
				<!--- if(!$(".aff_skill").hasClass("d-none")){				$(".aff_skill").addClass("d-none");} --->
				<!--- if(!$(".aff_support").hasClass("d-none")){				$(".aff_support").addClass("d-none");} --->
				<!--- if(!$(".aff_type").hasClass("d-none")){					$(".aff_type").addClass("d-none");}				 --->
				
				
			}
			else if($("#method_id").val() == 7)
			{	
				if($(".aff_certification").hasClass("d-none")){			$(".aff_certification").removeClass("d-none");}
				if($(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").removeClass("d-none");}

				var temp = $("#certif_id").val();
				$(".aff_certification_token_"+temp).removeClass("d-none");
				if($(".aff_certification_url").hasClass("d-none")){		$(".aff_certification_url").removeClass("d-none");}
				if($(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").removeClass("d-none");}
				
				if(!$(".aff_tp").hasClass("d-none")){					$(".aff_tp").addClass("d-none");}
				if(!$(".aff_p").hasClass("d-none")){					$(".aff_p").addClass("d-none");}
				if(!$(".aff_p1").hasClass("d-none")){					$(".aff_p1").addClass("d-none");}
				if(!$(".aff_p2").hasClass("d-none")){					$(".aff_p2").addClass("d-none");}
				if(!$(".aff_p3").hasClass("d-none")){					$(".aff_p3").addClass("d-none");}				
				if(!$(".aff_destination").hasClass("d-none")){			$(".aff_destination").addClass("d-none");}
				if(!$(".aff_el").hasClass("d-none")){					$(".aff_el").addClass("d-none");}
				if(!$(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").addClass("d-none");}
				if(!$(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").addClass("d-none");}
				if(!$(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").addClass("d-none");}
				if(!$(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").addClass("d-none");}
				if(!$(".aff_techno").hasClass("d-none")){				$(".aff_techno").addClass("d-none");}
				if(!$(".aff_group").hasClass("d-none")){				$(".aff_group").addClass("d-none");}
				<!--- if(!$(".aff_skill").hasClass("d-none")){				$(".aff_skill").addClass("d-none");} --->
				<!--- if(!$(".aff_support").hasClass("d-none")){				$(".aff_support").addClass("d-none");} --->
				<!--- if(!$(".aff_type").hasClass("d-none")){					$(".aff_type").addClass("d-none");} --->
				
				
			}
			else
			{
				if(!$(".aff_tp").hasClass("d-none")){					$(".aff_tp").addClass("d-none");}
				if(!$(".aff_techno").hasClass("d-none")){				$(".aff_techno").addClass("d-none");}
				if(!$(".aff_group").hasClass("d-none")){				$(".aff_group").addClass("d-none");}

				<!--- if(!$(".aff_formula").hasClass("d-none")){				$(".aff_formula").addClass("d-none");} --->
				<!--- if(!$(".aff_skill").hasClass("d-none")){				$(".aff_skill").addClass("d-none");} --->
				<!--- if(!$(".aff_support").hasClass("d-none")){				$(".aff_support").addClass("d-none");} --->
				<!--- if(!$(".aff_type").hasClass("d-none")){					$(".aff_type").addClass("d-none");} --->
				if(!$(".aff_p").hasClass("d-none")){					$(".aff_p").addClass("d-none");}
				if(!$(".aff_p1").hasClass("d-none")){					$(".aff_p1").addClass("d-none");}
				if(!$(".aff_p2").hasClass("d-none")){					$(".aff_p2").addClass("d-none");}
				if(!$(".aff_p3").hasClass("d-none")){					$(".aff_p3").addClass("d-none");}				
				if(!$(".aff_destination").hasClass("d-none")){			$(".aff_destination").addClass("d-none");}
				if(!$(".aff_certification").hasClass("d-none")){		$(".aff_certification").addClass("d-none");}
				if(!$(".aff_certification_token").hasClass("d-none")){	$(".aff_certification_token").addClass("d-none");}
				<cfloop list="#list_certif#" index="cor">
				<cfoutput>
				if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
				</cfoutput>
				</cfloop>
				if(!$(".aff_certification_url").hasClass("d-none")){	$(".aff_certification_url").addClass("d-none");}
				if(!$(".aff_certification_id").hasClass("d-none")){		$(".aff_certification_id").addClass("d-none");}
				if(!$(".aff_el").hasClass("d-none")){					$(".aff_el").addClass("d-none");}				
				if(!$(".aff_el_dur").hasClass("d-none")){				$(".aff_el_dur").addClass("d-none");}
				if(!$(".aff_el_url").hasClass("d-none")){				$(".aff_el_url").addClass("d-none");}
				if(!$(".aff_el_login").hasClass("d-none")){				$(".aff_el_login").addClass("d-none");}
				if(!$(".aff_el_password").hasClass("d-none")){			$(".aff_el_password").addClass("d-none");}				
			}
		
		})
		
		$("#certif_id").on("change", function(){
			<cfloop list="#list_certif#" index="cor">
			<cfoutput>
			if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
			</cfoutput>
			</cfloop>
			var temp = $("#certif_id").val();
			$(".aff_certification_token_"+temp).removeClass("d-none");
			$(".select_certification_token_"+temp).attr("disabled",false);
		
		})
		
		$("#form_create_tp").on("submit", function(){

		    if($("#method_id").val() == 1 || $("#method_id").val() == 8)
			{			
				 if($(".techno_id").is(":checked") == false){
					alert("Renseigner au moins une techno SVP.");
					return false;
				 };
			}
			else  if($("#method_id").val() == 3)
		    {			
				 if($(".elearning_id").is(":checked") == false){
					alert("Renseigner au moins une methode eLearning SVP.");
					return false;
				 };
			}
		  
		 })
		
		
		
	});
	</script>

<cfelseif isdefined("t_id")>

	<cfform action="updater_learner_tp.cfm">



    <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>


	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Parcours</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Parcours VIP</label> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="Le parcours NO LIMIT ne bloque pas la réservation après la date de fin de parcours">?</span></td>
			<td colspan="2">
			<div class="btn-group-toggle" data-toggle="buttons">
			<label class="btn btn-sm btn-outline-info <cfif get_tp.tp_vip eq "0">active</cfif>">
			<input type="radio" name="tp_vip" autocomplete="off" <cfif get_tp.tp_vip eq "0">checked</cfif> value="0"> <i class="fas fa-thumbs-up"></i> Normal
			</label>
			&nbsp;
			<label class="btn btn-sm btn-outline-warning <cfif get_tp.tp_vip eq "1">active</cfif>">
			<input type="radio" name="tp_vip" autocomplete="off" <cfif get_tp.tp_vip eq "1">checked</cfif> value="1"> <i class="fas fa-star"></i> NO LIMIT
			</label>
			</div>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Order</label></td>
			<td colspan="2">
				
			<select class="form-control" id="order_id" name="order_id">
				<cfif u_id neq 0>
					<cfoutput query="get_orders">
						<option value="#order_id#" <cfif order_id eq o_id>selected</cfif>>#replace(order_ref,'-','')# - #user_firstname# #user_name#</option>
					</cfoutput>
				</cfif>
			<option value="3" <cfif o_id eq 3>selected</cfif>>FREE REMAIN</option>
			<option value="2" <cfif o_id eq 2>selected</cfif>>OLD</option>
			<option value="1" <cfif o_id eq 1>selected</cfif>>OFFERT</option>
			</select>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Status TP</label></td>
			<td colspan="2">
			<cfselect class="form-control" id="tp_status_id" name="tp_status_id" query="get_tpstatus" display="status_name" value="tp_status_id" selected="#get_tp.tp_status_id#"></cfselect>
			</td>
		</tr>	
		<tr>
			<td class="bg-light" width="25%"><label>M&eacute;thode</label></td>
			<td colspan="2">
			<cfselect class="form-control" name="method_id" query="get_method" display="method_alias" value="method_id" selected="#get_tp.method_id#" disabled></cfselect>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Langue</label></td>
			<td colspan="2">
			<select name="formation_id" class="form-control">
			<cfoutput query="get_formation">
			<option value="#formation_id#" <cfif get_formation.formation_id eq get_tp.formation_id>selected</cfif>>#formation_name#</option>
			</cfoutput>
			</select>
			</td>
		</tr>
		<cfif group eq 1>
			<tr>
				<td class="bg-light" width="25%"><label>Name</label></td>
				<td colspan="2">
				<input class="form-control" type="text" name="tp_name" required="no" validate="string" value="<cfoutput>#get_tp.tp_name#</cfoutput>">
				</td>
			</tr>
		</cfif>
		<tr>
			<td class="bg-light" width="25%"><label>Durée H</label></td>
			<td colspan="2">
			<input class="form-control" type="text" name="tp_duration" required="yes" validate="integer" value="<cfoutput>#get_tp.tp_duration neq "" ? get_tp.tp_duration/60 : 0#</cfoutput>">
			</td>
		</tr>
		
		<tr>
			<td class="bg-light" width="25%"><label>Techno</td>
			<td colspan="2">
			<cfoutput query="get_techno"><label><input type="radio" name="techno_id" class="techno_id" value="#techno_id#" <cfif listfind(get_tp.tp_techno_id,techno_id)>checked</cfif>> #techno_alias# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>
		<cfif get_tp.method_id eq "1" OR get_tp.method_id eq "8"> 
		<tr>
			<td class="bg-light" width="25%"><label>Preferred duration</label></td>
			<td colspan="2">
			<select class="form-control" name="tp_session_duration" class="tp_session_duration">
				<cfoutput>
				<cfloop list="15,30,45,60,75,90" index="cor">
					<option <cfif cor eq get_tp.tp_session_duration>selected</cfif> value="#cor#">#cor##obj_translater.get_translate('short_minute')#</option>
				</cfloop>
				</cfoutput>
			</select>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Rythme</td>
			<td colspan="2">
			<cfoutput query="get_tpformula"><label><input type="radio" name="tp_formula_id" class="tp_formula_id" value="#tp_formula_id#" <cfif listfind(get_tp.tp_formula_id,get_tpformula.tp_formula_id)>checked</cfif>> #tp_formula_name# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>
		<!---<tr>
			<td class="bg-light" width="25%"><label>Skills</td>
			<td class="bg-light" colspan="2">
			<cfoutput query="get_tpskill"><label><input type="checkbox" name="tp_skill_id" class="tp_skill_id" value="#skill_id#" <cfif listfind(get_tp.tp_skill_id,get_tpskill.skill_id)>checked</cfif>> #skill_name# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>--->
		<tr>
			<td class="bg-light" width="25%"><label>Type</td>
			<td colspan="2">
			<cfoutput query="get_tptype"><label><input type="radio" name="tp_type_id" class="tp_type_id" value="#tp_type_id#" <cfif listfind(get_tp.tp_type_id,get_tptype.tp_type_id)>checked</cfif>> #tp_type_name# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>
		<!--- <tr> --->
			<!--- <td class="bg-light" width="25%"><label>Contenus préférés (ignorer)</td> --->
			<!--- <td class="bg-light" colspan="2"> --->
			<!--- <cfoutput query="get_tpsupport"><label><input type="checkbox" name="tp_support_id" class="tp_support_id" value="#tp_support_id#" <cfif listfind(get_tp.tp_support_id,tp_support_id)>checked</cfif>> #tp_support_name# &nbsp;&nbsp;&nbsp;</label></cfoutput> --->
			<!--- </td> --->
		<!--- </tr> --->
		
		</cfif>
		<cfif get_tp.method_id eq "3"> 
		<tr>
			<td class="bg-light" width="25%"><label>Elearning</td>
			<td colspan="2">
			<cfoutput query="get_elearning"><label><input type="radio" name="elearning_id" class="elearning_id" value="#elearning_id#" <cfif get_tp.tp_elearning_id eq elearning_id>checked</cfif>> #elearning_name# &nbsp;&nbsp;&nbsp;</label></cfoutput>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Elearning dur&eacute;e<br><small style="color:#FF0000"><strong>Uniquement pour l'affichage --> Attention, adapter date de fin du TP ci-dessous!!</strong></small></td>
			<td colspan="2">
			<select name="elearning_duration" class="form-control">
			<option value="1" <cfif get_tp.elearning_duration eq "1">selected</cfif>>1 jour</option>
			<option value="7" <cfif get_tp.elearning_duration eq "7">selected</cfif>>1 semaine</option>
			<cfoutput>
			<cfloop from="30" to="450" step="30" index="cor">
			<option value="#cor#" <cfif get_tp.elearning_duration eq cor>selected</cfif>>#cor/30# mois</option>
			</cfloop>
			</cfoutput>
			</select>
			</td>
		</tr>
		
		<tr class="aff_el_url">
			<td class="bg-light" width="25%"><label>Elearning - URL</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_url" value="<cfoutput>#get_tp.elearning_url#</cfoutput>">
			</td>			
		</tr>
		
		<tr class="aff_el_login">
			<td class="bg-light" width="25%"><label>Elearning - Identifiant</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_login" value="<cfoutput>#get_tp.elearning_login#</cfoutput>">
			</td>			
		</tr>
		
		<tr class="aff_el_password">
			<td class="bg-light" width="25%"><label>Elearning - Password</label></td>
			<td>
			<input type="text" class="form-control" name="elearning_password" value="<cfoutput>#get_tp.elearning_password#</cfoutput>">
			</td>			
		</tr>
		
		</cfif>
		<cfif get_tp.method_id eq "6"> 
		<tr class="aff_destination">
			<td class="bg-light" width="25%"><label>Destination</label></td>
			<td>
			<cfselect class="form-control" name="destination_id" query="get_destination" display="destination_name" value="destination_id" selected="#get_tp.destination_id#"></cfselect>
			</td>			
		</tr>
		</cfif>
		<cfif get_tp.method_id eq "7"> 
		<tr class="aff_certification">
			<td class="bg-light" width="25%"><label>Certification</label></td>
			<td>
			<cfselect class="form-control" name="certif_id" query="get_certification" display="certif_name" value="certif_id" selected="#get_tp.certif_id#"></cfselect>
			</td>				
		</tr>
		<tr class="aff_certification_token">
			<td class="bg-light" width="25%"><label>Certif - Token (Lingua or LTE)</label></td>
			<td>
			<cfloop list="#list_certif#" index="cor">
			<cfoutput>
			<div class="aff_certification_token_#cor# <cfif cor neq get_tp.certif_id>d-none</cfif>">
			<cfif cor neq get_tp.certif_id>
				<cfselect class="form-control select_certification_token_#cor#" disabled name="token_id" query="get_certification_token_#cor#" display="token_code" value="token_id">
				<option value="0" selected>N/A</option>
				</cfselect>
			<cfelse>
				<cfif get_tp.token_id neq "0" AND get_tp.token_id neq "">
				<cfselect class="form-control select_certification_token_#cor#" name="token_id" query="get_certification_token_#cor#" display="token_code" value="token_id" selected="#get_tp.token_id#">
				<option value="0">N/A</option>
				</cfselect>
				<cfelse>
				<cfselect class="form-control select_certification_token_#cor#" name="token_id" query="get_certification_token_#cor#" display="token_code" value="token_id">
				<option value="0" selected>N/A</option>
				</cfselect>
				</cfif>
			</cfif>
			</div>
			</cfoutput>
			</cfloop>
			</td>			
		</tr>
		
		<tr class="aff_certification_url">
			<td class="bg-light" width="25%"><label>Certif - URL</label></td>
			<td>
			<input type="text" class="form-control" name="certif_url" value="<cfoutput>#get_tp.certif_url#</cfoutput>">
			</td>			
		</tr>
		
		<tr class="aff_certification_id">
			<td class="bg-light" width="25%"><label>Certif - Identifiant</label></td>
			<td>
			<input type="text" class="form-control" name="certif_login" value="<cfoutput>#get_tp.certif_login#</cfoutput>">
			</td>			
		</tr>
		</cfif>
		
	</table>
	
	<cfif listFindNoCase("1,2,8,10,11", get_tp.method_id)> 

	<!--- Getting tp trainers --->
	<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#get_tp.tp_id#")>
	<!--- <cfif tp_trainer.recordCount GTE 1>
		<cfset trainer1 = QueryGetRow(tp_trainer, 1) >
	</cfif>
	<cfif tp_trainer.recordCount GTE 2>
		<cfset trainer2 = QueryGetRow(tp_trainer, 2) >
	</cfif>
	<cfif tp_trainer.recordCount GTE 3>
		<cfset trainer3 = QueryGetRow(tp_trainer, 3) >
	</cfif> --->

	<!--- <cfdump var="#tp_trainer#"> --->
<!--- Krys wants only trainer managers to be able to edit a learner's trainers --->
	<cfif listFindNoCase("TRAINERMNG", SESSION.USER_PROFILE) OR listFindNoCase("7867,2847", SESSION.USER_ID)>
		<cfif SESSION.USER_ISMANAGER eq "1">
		<table class="table table-sm table-bordered">
			<tr>
				<td colspan="4" bgcolor="#ECECEC"><strong>Trainers</strong></td>
			</tr>
			<tr>
				<!--- <td class="bg-light" width="25%"><label>Trainer principal</label></td> --->
				<td colspan="3">
				<select id="new_planner_id" class="form-control">
				<option value="0" selected>--Selectionner--</option>
				<cfoutput query="get_trainer">
				<option value="#user_id#">#user_firstname# #user_name#</option>
				</cfoutput>
				</select>
				</td>
				<td>
					<!--- <i class="fal fa-trash-alt"></i> --->
					<button type="button" class="btn btn-sm btn-outline-info btn_add_tp_trainer">add</button>
					<!--- <button>add</button> --->
				</td>
			</tr>
			<cfloop query="tp_trainer">
				<tr>
					<td class="bg-light" width="25%"><label>Trainer <cfoutput>#currentrow#</cfoutput></label></td>
					<td colspan="2">
					<p><cfoutput>#planner#</cfoutput></p>
					</td>
					<td>
						<button type="button" class="btn btn-sm btn-outline-info btn_remove_tp_trainer" id="del_trainer_<cfoutput>#planner_id#</cfoutput>"><i class="fal fa-trash-alt"></i></button>
						<!--- <button>remove</button> --->
					</td>
				</tr>
			</cfloop>
		</table>
		</cfif>
	</cfif>
	</cfif>
	
	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Dur&eacute;e</strong></td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>D&eacute;but</label></td>
			<td>
				<div class="controls">
					<div class="input-group">
						<cfoutput>
						<input id="tp_date_start" name="tp_date_start" type="text" class="datepicker form-control" value="#dateformat(get_tp.tp_date_start,'dd/mm/yyyy')#" />
						<label for="tp_date_start" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
						</cfoutput>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="bg-light" width="25%"><label>Fin</label></td>
			<td>
				<div class="controls">
					<div class="input-group">
						<cfoutput>
						<input id="tp_date_end" name="tp_date_end" type="text" class="datepicker form-control" value="#dateformat(get_tp.tp_date_end,'dd/mm/yyyy')#" />
						<label for="tp_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
						</cfoutput>
					</div>
				</div>
			</td>
		</tr>
				
				
	</table>

	<cfoutput>
	<input type="hidden" name="t_id" value="#t_id#">
	<input type="hidden" name="u_id" value="#u_id#">
	<input type="hidden" name="method_id" value="#get_tp.method_id#">
	<input type="hidden" name="ins_tp_vc" value="#vc#">

	</cfoutput>
	<input type="hidden" name="updt_tp" value="1">
	<div align="center"><input type="submit" class="btn btn-success" value="Mettre &agrave; jour"></div>		
	</cfform>

	<script>
	$(document).ready(function() {

		handler_add_tp_trainer = function add_tp_trainer(){
		event.preventDefault();

		var p_id = $('#new_planner_id').val();
		console.log(p_id)
		
		$.ajax({
			url : 'api/tp/tp_post.cfc?method=updt_tptrainer_add',
			type : 'POST',
			data : {
				t_id:<cfoutput>#t_id#</cfoutput>, 
				u_id:<cfoutput>#u_id#</cfoutput>,
				p_id:p_id,
				interne:"yes"
			},				
			success : function(result, status) {
				$('#modal_title_xl').text("Editer parcours");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load(<cfoutput>"modal_window_tp.cfm?vc=#vc#&group=#group#&t_id=#t_id#&u_id=#u_id#&o_id=#o_id#"</cfoutput>, function() {});
			}
		});
	
	};
	$(".btn_add_tp_trainer").bind("click",handler_add_tp_trainer);	


	handler_del_tp_trainer = function del_tp_trainer(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		p_id = idtemp[2];

		console.log(p_id)
		
		$.ajax({
			url : 'api/tp/tp_post.cfc?method=updt_tptrainer_delete',
			type : 'POST',
			data : {
				t_id:<cfoutput>#t_id#</cfoutput>, 
				u_id:<cfoutput>#u_id#</cfoutput>,
				p_id:p_id,
				interne:"yes"
			},				
			success : function(result, status) {
				$('#modal_title_xl').text("Editer parcours");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load(<cfoutput>"modal_window_tp.cfm?vc=#vc#&group=#group#&t_id=#t_id#&u_id=#u_id#&o_id=#o_id#"</cfoutput>, function() {});
			}
		});
	
	};
	$(".btn_remove_tp_trainer").bind("click",handler_del_tp_trainer);	

	
$('[data-toggle="tooltip"]').tooltip({html: true});
		$("#certif_id").on("change", function(){
			<cfloop list="#list_certif#" index="cor">
			<cfoutput>
			if(!$(".aff_certification_token_#cor#").hasClass("d-none")){	$(".aff_certification_token_#cor#").addClass("d-none"); $(".select_certification_token_#cor#").attr("disabled",true);}
			</cfoutput>
			</cfloop>
			var temp = $("#certif_id").val();
			$(".aff_certification_token_"+temp).removeClass("d-none");
			$(".select_certification_token_"+temp).attr("disabled",false);
		
		})
		
		$("#tp_date_start").datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			numberOfMonths: 1,
			onClose: function( selectedDate ) {
			$( "#tp_date_start" ).datepicker( "option", "minDate", selectedDate );		
			}
		});
		$("#tp_date_end").datepicker({
			defaultDate: "+1y",
			changeMonth: true,
			dateFormat:"dd/mm/yy",
			numberOfMonths: 1,
			onClose: function( selectedDate ) {
			$( "#tp_date_start" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
	});
	</script>
	
</cfif>
