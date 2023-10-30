<!DOCTYPE html>

<cfsilent>

<cfparam name="pf_id" default="7">
<cfparam name="o_by" default="creation">

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
	<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
	<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

<cfif pf_id eq '-7'>
	<cfset get_learner = obj_query.oget_learner(pf_id="#pf_id#",o_by="#o_by#")>
<cfelse>
	<cfset get_learner = obj_query.oget_learner(pf_id="#pf_id#",tselect="#tselect#",o_by="#o_by#")>
</cfif>

<cfquery name="get_tp_status" datasource="#SESSION.BDDSOURCE#">
SELECT tp_status_id, tp_status_name_#SESSION.LANG_CODE# as status_name FROM lms_tpstatus
</cfquery>

<cfquery name="get_tp_method" datasource="#SESSION.BDDSOURCE#">
SELECT method_id, method_alias_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method
</cfquery>

<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
SELECT user_status_id, user_status_name_#SESSION.LANG_CODE# as user_status_name FROM user_status
</cfquery>

<cfquery name="get_user_profile" datasource="#SESSION.BDDSOURCE#">
SELECT profile_id, profile_name
FROM user_profile 
WHERE profile_id = 3 OR profile_id = 7 OR profile_id = 9 OR profile_id = 10
</cfquery>

<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
(
SELECT 0 as user_id, "--ALL--" as user_firstname, "" as user_name
)
UNION
(
SELECT u.user_id, u.user_firstname, u.user_name 
FROM user u 
INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id AND upc.profile_id = 4
INNER JOIN user_profile up ON up.profile_id = upc.profile_id
)
ORDER BY user_firstname
</cfquery>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

<style>
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
      
		<cfset title_page = "Learners list WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">
	  	
			<cfif isdefined("e")>
			<div class="alert alert-danger" role="alert">
				<div class="text-center"><em>Un utilisateur existe d&eacute;j&agrave; avec l'adresse email utilis&eacute;e.</em></div>
			</div>
			<cfelseif isdefined("k") AND k eq "1">
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em>L'email a correctement été envoyé.</em></div>
			</div>
			</cfif>
		
			<cfform action="cs_learners.cfm">
			<div class="row">
			
				<div class="col-md-3">
				
					<div class="row">
						<div class="col-md-12">
							<h6>Type User</h6>									
							<cfoutput query="get_user_profile">
							<a href="cs_learners.cfm?pf_id=#profile_id#" class="btn btn-sm <cfif pf_id eq profile_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;#profile_name#</a>
							</cfoutput>
							<a href="cs_learners.cfm?pf_id=-7" class="btn btn-sm <cfif pf_id eq '-7'>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;Removed</a>
						</div>
					</div>
					<!---<div class="row">
						<div class="col-md-2 col-sm-3">
							Statut Learner
						</div>
						<div class="col-md-10 col-sm-9">
							<cfoutput>
							<a href="cs_learners.cfm?ust_id=100&st_id=#st_id#&m_id=#m_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif ust_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-graduation-cap"></i>&nbsp;ALL</a>
							</cfoutput>
							
							<cfoutput query="get_user_status">
							<a href="cs_learners.cfm?ust_id=#user_status_id#&st_id=#st_id#&m_id=#m_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif ust_id eq user_status_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;#user_status_name#</a>
							</cfoutput>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 col-sm-3">
							M&eacute;thode
						</div>
						<div class="col-md-10 col-sm-9">
							<!---<cfoutput>
							<a href="cs_learners.cfm?ust_id=#ust_id#&st_id=#st_id#&m_id=100&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif m_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-graduation-cap"></i>&nbsp;ALL</a>
							</cfoutput>--->
							<cfoutput query="get_tp_method">
							<a href="cs_learners.cfm?ust_id=#ust_id#&st_id=#st_id#&m_id=#method_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif m_id eq method_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-graduation-cap"></i>&nbsp;#method_name#</a>
							</cfoutput>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 col-sm-3">
							Statut TP
						</div>
						<div class="col-md-10 col-sm-9">
							<!---<cfoutput>
							<a href="cs_learners.cfm?ust_id=#ust_id#&st_id=100&m_id=#m_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif st_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-bookmark"></i>&nbsp;ALL</a>
							<a href="cs_learners.cfm?ust_id=#ust_id#&st_id=0&m_id=#m_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif st_id eq "0">btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-bookmark"></i>&nbsp;NO TP</a>
							</cfoutput>--->
							<cfoutput query="get_tp_status">
							<a href="cs_learners.cfm?ust_id=#ust_id#&st_id=#tp_status_id#&m_id=#m_id#&pf_id=#pf_id#&p_id=#p_id#" class="btn btn-sm <cfif st_id eq tp_status_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-bookmark"></i>&nbsp;#status_name#</a>
							</cfoutput>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 col-sm-3">
							Trainers
						</div>
						<div class="col-md-2 col-sm-9">
							<select name="p_id" id="trainer_select" class="form-control form-control-sm">
							<cfoutput query="get_trainers">
							<option value="#user_id#" <cfif p_id eq user_id>selected</cfif>>#user_firstname#</option>
							</cfoutput>
							</select>
						</div>
					</div>--->
					<!---<div class="row">
						<div class="col-md-12 float-right">
							<input type="submit" class="btn btn-lg" value="Afficher">
						</div>
					</div>--->
				</div>
			
				<div class="col-md-4">
					<h6 class="card-title">Période : <cfoutput>#mlongsel# #ysel#</cfoutput></h6>
					<div class="form-row">
						<!--- <div class="col"> --->
							<!--- <cfselect class="form-control" name="p_id" query="get_trainers" value="user_id" display="user_firstname" selected="#p_id#"> --->
								<!--- <option value="0" <cfif p_id eq "0">selected</cfif>>---ALL TRAINERS----</option> --->
							<!--- </cfselect> --->
						<!--- </div> --->

						<div class="col">
							<select class="form-control" name="msel">

								<cfloop from="1" to="12" index="m">
									<cfoutput>
										<cfif SESSION.LANG_CODE neq "fr">
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
										<cfelse>
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
										</cfif>


									</cfoutput>
								</cfloop>
							</select>
						</div>

						<div class="col">

							<select class="form-control" name="ysel">
								<cfloop from="2019" to="#year(now())#" index="y">
									<cfoutput>
										<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
									</cfoutput>
								</cfloop>
							</select>
							
						</div>
						
						<div class="col">
							<cfoutput>
							<input type="hidden" name="o_by" value="#o_by#">
							<input type="hidden" name="pf_id" value="#pf_id#">
							</cfoutput>
							<input type="submit" value="GO" class="btn btn-sm btn-info">
							<cfoutput><a href="cs_learners.cfm?pf_id=#pf_id#" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput>
						</div>

					</div>
				
				</div>
				
					
				<div class="col-md-3">
				
				
				</div>
				
			</div>
			</cfform>
			
			<div class="row mt-4">
			
				<div class="col-md-12">
				
					<cfinclude template="./widget/wid_learner_list_sales.cfm">
						
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
	
	<!--- $('#trainer_select').change(function(event) {	 --->

		<!--- var idtemp = $(this).val(); --->
		
		<!--- <cfoutput> --->
		<!--- document.location.href="cs_learners.cfm?ust_id=#ust_id#&st_id=#st_id#&m_id=#m_id#&pf_id=#pf_id#&p_id="+idtemp; --->
		<!--- </cfoutput> --->
		
	<!--- });	 --->
		
	$(".btn_remove_users").click(function(event) {
		event.preventDefault();
		// var idtemp = $(this).attr("id");
		// console.log(event.target.dataset);
		$.ajax({
			url : './api/users/user_post.cfc?method=hide_user',
			type : 'POST',
			data : {
				u_id: event.target.dataset.id
			},				
			success : function(result, status) {
				event.currentTarget.parentNode.parentNode.parentNode.remove();
			}
		});
	
	});
	
	$('.btn_email_b2c_prospect').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];
		$('#modal_title_lg').text("Envoyer Email");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_email.cfm?send_email=b2c_prospect&u_id="+u_id, function() {});
	});	
		

})

</script>


</body>
</html>