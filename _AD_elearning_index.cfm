<!DOCTYPE html>

<cfsilent>

<!--- <cfset secure = "5,3,7,9">
<cfinclude template="./incl/incl_secure.cfm"> --->

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<cfset u_id = u_id>
	<cfset p_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
</cfif>

<!--- <cfquery name="get_test_lst" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz WHERE quiz_type LIKE '%lst_%' ORDER BY quiz_rank ASC
</cfquery> --->

<!--- <cfquery name="get_result_lst_sociability" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 1680 --->
<!--- </cfquery> --->

<!--- <cfquery name="get_result_lst_brain" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 1681 --->
<!--- </cfquery> --->

<!--- <cfquery name="get_result_lst_memory" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = 1682 --->
<!--- </cfquery> --->



<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>

<cfparam name="step" default="begin">

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
<style>
.card_module {
	-webkit-filter: grayscale(100%) !important;
	filter: grayscale(100%) !important;
}
</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Tests de profil d'apprentissage">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">


            <cfif step eq "begin">

            <h4>Choisir une orientation</h4>
            <hr class="bg-danger">
            
			<div class="row">

                <div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img/1000_F_250445080_om9OG46c9QYx0OE9DzLJWnZvHy8dpltT.jpg">
						<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
										
							<h5 class="text-center mt-2">Préparation Certification</h5>
							<p align="center">
							TOEIC, Linguaskill, Bright, LTE.. Parcours personnalisés pour optimiser votre socre
							</p>
							<div align="center" class="mt-auto">
								<a class="btn btn-warning" href="?step=certif">Choisir cette orientation</a>
							</div>
							
						</div>
					</div>
				</div>	

                <div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img/1000_F_250446775_3UokcZwfEXTM00cQMW39x7sLng2ouA4o.jpg">
						<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
										
							<h5 class="text-center mt-2">Anglais<br>General</h5>
							<p align="center">
							Situations de tous les jours
							</p>
							<div align="center" class="mt-auto">
								<a class="btn btn-info">Choisir cette orientation</a>
							</div>
							
						</div>
					</div>
				</div>

                <div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img/1000_F_250444074_kwNfCDEEddAreiLQBfusnzbuVxVY6Qqh.jpg">
						<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
										
							<h5 class="text-center mt-2">Anglais<br>Business</h5>
							<p align="center">
							Core skills, job skills
							</p>
							<div align="center" class="mt-auto">
								<a class="btn btn-secondary" href="_AD_elearning_dashboard.cfm?orientation=business">Choisir cette orientation</a>
							</div>
							
						</div>
					</div>
				</div>

                <div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img/240_F_250584232_11Ct3IEjQZ6IMdbwIoUYWh1dA0RRpRqg.jpg">
						<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px">
										
							<h5 class="text-center mt-2">Grammaire & Vocabulaire</h5>
							<p align="center">
							Vous souhaitez reprendre les bases de la langue, ou cibler des points précis...
							</p>
							<div align="center" class="mt-auto">
								<a class="btn btn-success">Choisir cette orientation</a>
							</div>
							
						</div>
					</div>
				</div>

            </div>

            <cfelseif step eq "certif">

                <h4>Choisir une certification</h4>
                <a class="float-right" href="?step=begin">[retour]</a>
                <hr class="bg-danger">
                
                <div class="row">
    
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card">
                            <img class="card-img-top" width="100%" src="https://formation.wefitgroup.com/assets/img_product/1.jpg">
                            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">     
                                <!--- <h5 class="text-center mt-2">Linguaskill</h5> --->
                                <p align="center">
                                    Cuncta disseminata nec parcens post plebeiis latera urbium modum onerosus nullum latera parcens bonis Caesar.
                                </p>
                                <div align="center" class="mt-auto">
                                    <a class="btn btn-info" href="_AD_elearning_dashboard.cfm">Je passe le Linguaskill</a>
                                </div>
                            </div>
                        </div>
                    </div>	

                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card">
                            <img class="card-img-top" width="100%" src="https://formation.wefitgroup.com/assets/img_product/3.jpg">
                            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">     
                                <!--- <h5 class="text-center mt-2">TOEIC</h5> --->
                                <p align="center">
                                    Igitur iudicare redeo Scipionem iudicare magna quaedam experiendum in quibus Scipionem et redeo et nec.
                                </p>
                                <div align="center" class="mt-auto">
                                    <a class="btn btn-info disabled" href="?step=certif">Je passe le TOEIC</a>
                                </div>
                            </div>
                        </div>
                    </div>	

                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card">
                            <img class="card-img-top" width="100%" src="https://formation.wefitgroup.com/assets/img_product/2.jpg">
                            <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">     
                                <!--- <h5 class="text-center mt-2">Bright</h5> --->
                                <p align="center">
                                    Qui poterat praedam citroque inveniri aut praedam non nec quicquid non nec nec discursantes nec.
                                </p>
                                <div align="center" class="mt-auto">
                                    <a class="btn btn-info disabled" href="?step=certif">Je passe le Bright</a>
                                </div>
                                
                            </div>
                        </div>
                    </div>	

                </div>	



            </cfif>



















			
			
			
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	$(document).ready(function() {
		


	});
</script>

</body>
</html>