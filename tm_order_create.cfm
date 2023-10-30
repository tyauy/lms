<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
<cfinclude template="./incl/incl_secure.cfm">	

<cfquery name="get_order_context" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_context
</cfquery>

<cfquery name="get_subrogation" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT account_name, account_id FROM account a WHERE type_id = 4 ORDER BY account_name
</cfquery>

<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>
<cfparam name="a_id" default="#listgetat(SESSION.USER_ACCOUNT_RIGHT_ID,1)#">

<!---
<cfquery name="get_learner_account" datasource="#SESSION.BDDSOURCE#">
SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_id FROM user u WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> AND profile_id = 3
</cfquery>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
SELECT account_id, account_name, account_address, account_postal, account_city, account_country, account_f_name, account_f_address, account_f_postal, account_f_city, account_f_country FROM account a WHERE account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> 
</cfquery>--->

<cfif SESSION.USER_ACCOUNT_RIGHT_ID neq "">
	<cfset get_learner_account = obj_query.oget_learner(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#",o_by="account_id")>
</cfif>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Cr&eacute;er dossier de formation">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			<div class="row" style="margin-top:10px">
				<div class="col-lg-6 offset-lg-3 col-md-12">
					<div class="card border-top border-info">						
						<div class="card-body">
							
							<div class="row">
								
								<div class="col-md-12">
								<h5 align="center">Cr&eacute;er un dossier de formation (1/2)</h5>
											
									<cfform>
									<div class="bg-light p-2 m-1 mt-3 border">
									<h6>Compte client</h6>
									
									<select class="form-control" name="a_id" onchange="document.location.href='tm_order_create.cfm?a_id='+$(this).val()">
											<cfoutput query="get_account_tm">
											<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
											</cfoutput>
											</select>
									
									</div>
									
									
									<div class="bg-light p-2 m-1 mt-3 border">
									<h6>Dossier de formation</h6>
									<table class="table table-sm">
										<tr>
											<td width="25%"><label>Financement<br><small>(plusieurs choix possibles)</small></label></td>
											<td>
											<label style="font-size:14px"><input type="checkbox" name="f_id"> Plan de formation</label><br>
											<label style="font-size:14px"><input type="checkbox" name="f_id"> Direct Client</label><br>
											<label style="font-size:14px"><input type="checkbox" name="f_id"> OPCO</label><br>
											<label style="font-size:14px"><input type="checkbox" name="f_id"> CPF</label>
											<!---
<cfselect class="form-control" name="context_id" query="get_order_context" display="context_name" value="context_id" <!---selected="#context_id#"--->></cfselect>
											--->
											</td>
										</tr>
										<!---<tr>
											<td><label>Date d'&eacute;dition</label></td>
											<td>
												<div class="controls">
													<div class="input-group">
														<input id="order_date" name="order_date" type="text" class="datepicker form-control" value="<!---<cfoutput>#order_date#</cfoutput>--->" />
														<label for="order_date" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
													</div>
												</div>					
											
											</td>
										</tr>--->
										<tr>
											<td><label>P&eacute;riode de formation :<br>entre le</label></td>
											<td>
												<div class="controls">
													<div class="input-group">
														<input id="order_start" name="order_start" type="text" class="datepicker form-control" value="<!---<cfoutput>#order_start#</cfoutput>--->" />
														<label for="order_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
													</div>
												</div>					
											
											</td>
										</tr>										
										<tr>
											<td><label>Et le</label></td>
											<td>
												<div class="controls">
													<div class="input-group">
														<input id="order_end" name="order_end" type="text" class="datepicker form-control" value="<!---<cfoutput>#order_end#</cfoutput>--->" />
														<label for="order_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
													</div>
												</div>							
											</td>
										</tr>									
										<!---<tr>
											<td width="25%"><label>R&eacute;f&eacute;rent</label></td>
											<td>
												<cfselect class="form-control" name="contact_id" query="get_contact" display="contact_name" value="contact_id" <!---selected="#contact_id#"--->>
												<option value="0" <cfif contact_id eq "0">selected="selected"</cfif>>NC</option>
												</cfselect>
											</td>
										</tr>--->
										<tr>
											<td><label>Adresse Si&egrave;ge</label></td>
											<td>
												<textarea class="form-control" name="order_address" placeholder="Adresse" required="yes" rows="2"><!---<cfoutput>#order_address#</cfoutput>---></textarea>
											</td>
										</tr>										
									</table>
									</div>
									
									<div class="bg-light p-2 m-1 mt-3 border">
									<h6>Apprenant</h6>
									<br>
									Coordonn&eacute;es nouvel apprenant
							
										<table class="table bck_grey">

											<tr>
												<th><label>Pr&eacute;nom</label></th>
												<th><label>Nom</label></th>
												<th><label>Email</label></th>
												<th><label>T&eacute;l&eacute;phone</label></th>
											</tr>
											
											<tr>
												<td><input type="text" name="cv_fname" id="cv_fname" class="form-control" placeholder="Prenom"></td>
												<td><input type="text" name="cv_lname" id="cv_lname" class="form-control" placeholder="Nom"></td>
												<td><input type="text" name="cv_email" id="cv_email" class="form-control" placeholder="Email"></td>
												<td><input type="text" name="cv_phone" id="cv_phone" class="form-control" placeholder="T&eacute;l&eacute;phone"></td>
			
											</tr>
											
											<!---<tr id="last_tr">
												<td><button type="button" class="btn btn-default btn-sm" id="add_line"><i class="fas fa-plus-circle"></i></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>	--->							
										</table>
										
										<cfif SESSION.USER_ACCOUNT_RIGHT_ID neq "">
										<br>
										
										<strong>OU</strong> apprenant d&eacute;j&agrave; existant</h6>
										<table class="table bck_grey">
											<tr>
												<td>
												<select id="learner_select" class="form-control" name="learner_id" value="user_id">
												<cfoutput query="get_learner_account" group="account_id">
													<optgroup label="#account_name#">
													<cfoutput>
														<option value="#user_id#">#ucase(user_name)# #user_firstname#</option>
													</cfoutput>
													</optgroup>
												</cfoutput>
												</select>
												</td>
											</tr>								
										</table>
										</cfif>
									</div>
								</div>
								</cfform>
										
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {


	$("#order_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#order_end").datepicker( "option", "minDate", selectedDate );
			order_start = $('#order_start').datepicker("getDate");
			order_start = moment(order_start).format('YYYY-MM-DD');
		}		
	})
	$("#order_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			order_end = $('#order_end').datepicker("getDate");
			order_end = moment(order_end).format('YYYY-MM-DD');
		}	
	})


});
</script>


</body>
</html>