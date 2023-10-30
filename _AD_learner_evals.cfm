<!DOCTYPE html>

<cfsilent>

<cfset secure = "5,3,7,9">
<cfinclude template="./incl/incl_secure.cfm">

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
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


			<a href="https://visio4.wefitgroup.com/b/ann-4vx-5dm-lq8">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/vio-ctb-1tb-kuf">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/dou-qre-ej7-hzx">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/dia-mnu-wgs-z7s">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/fri-amv-xqc-6pg">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/rem-gij-jzu-kwt">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/izu-ro0-jk0-top">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/jam-qpz-cjw-b6p">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/dan-lmv-pho-tjq">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/tho-d4m-sqo-dux">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mel-7ml-bil-hec">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/cra-xb1-cst-lad">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/kry-xxh-q2u-w2q">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/iva-iye-wlr-paf">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/ann-q9h-pw7-th4">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/cla-gkl-xed-ygv">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/siw-bkt-369-bux">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mar-txd-pe9-2my">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/rob-z2r-igr-ebe">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/fra-c7o-z0t-njo">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/kar-trf-efj-ytz">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mat-xhc-vry-0ug">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mat-i4u-6iz-wz0">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/pet-vq1-l71-nuy">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/jer-giy-hoa-o9n">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/phi-eov-r2c-hqk">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mat-bdk-nm7-qwx">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/mig-qny-b0k-via">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/olg-tr3-8vu-0xo">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/val-xeb-7i5-2du">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/alb-khb-nmd-uy8">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/kla-yad-rro-i4f">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/lau-aj0-mia-prg">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/san-fir-nkl-c66">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/joa-o2d-jj7-srt">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/oli-yss-zxq-awl">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/der-q6d-7je-acu">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/rob-8er-dfj-rjc">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/luk-vol-wnh-ljk">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/kri-mhf-wom-ty1">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/rob-9q5-koh-inh">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/lau-7yp-wtn-yxc">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/dan-fon-vhl-cxr">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/zaf-vqj-f4w-hfs">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/lia-tkz-6ai-c1c">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/ros-sks-u1l-t2w">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/rah-jp8-xmu-pqm">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/nou-t5u-acx-8i1">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/tri-al1-eji-auy">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/ame-v8w-dav-88b">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/ede-oid-7ie-onc">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/kul-atr-jak-1of">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/oum-o6j-cy4-lwt">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/iwo-dzz-d0l-bag">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/car-vfi-jsn-xhd">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/sof-5ig-xxl-odh">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/pau-l4w-vms-9vp">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/dam-2dj-k1p-wjs">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/jus-zcm-peh-xty">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/bob-xx4-rvo-gkx">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/she-sym-bog-8fd">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/pat-2te-rbk-qrk">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/jan-cay-mee-uws">TEST</a><br>
<a href="https://visio4.wefitgroup.com/b/shu-kps-0rx-kas">TEST</a><br>


			<div class="row">
			
				<cfoutput query="get_test_lst">
				
				<cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
				SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
				</cfquery>

				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top <cfif quiz_active eq "0">card_module</cfif>" src="./assets/img/#quiz_type#.jpg">
						<div class="card-body d-flex flex-column h-100 <cfif quiz_active eq "0">bg-light</cfif>" style="min-height:250px">
										
							<h5 class="text-center mt-2">#quiz_name#</h5>
							<p align="center">
							#quiz_description#
							</p>
							<div align="center" class="mt-auto">
								<cfif quiz_active eq "0">
									<a class="btn btn-info disabled">Démarrer mon test</a>
								<cfelse>
									<cfif get_result.recordcount neq "0">
										<a href="##" class="btn btn-success btn_view_lst" id="quiz_#get_result.quiz_user_id#"><i class="fal fa-list"></i> Résultats</a>
										<a id="q_#quiz_id#" href="##" class="btn btn-info btn_restart_quiz"><i class="fal fa-sync-alt"></i> #__btn_start_again#</a>
									<cfelse>
										<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#" class="btn btn-info"><i class="fal fa-play"></i> Démarrer mon test</a>										
									</cfif>
								</cfif>
							</div>
							
						</div>
					</div>
				</div>	
				</cfoutput>
				
				
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top" src="./assets/img/lst_sociability.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100" style="min-height:250px"> --->
							<!--- <h5 class="text-center mt-2">Sociabilité</h5> --->
							<!--- <p align="center"> --->
							<!--- Vous venez de terminer votre parcours de formation avec WEFIT, prenez un instant pour remplir ce questionnaire. --->
							<!--- </p> --->
							<!--- <div align="center" class="mt-auto"> --->
								<!--- <cfoutput> --->
								<!--- <cfif get_result_lst_sociability.recordcount neq "0"> --->
								<!--- <a href="##" class="btn btn-success btn_view_lst_sociability" id="quiz_#get_result_lst_sociability.quiz_user_id#">Résultats</a> --->
								<!--- <cfelse> --->
								<!--- <a href="./quiz.cfm?new_quiz=1&quiz_id=1680" class="btn btn-info">Démarrer mon test</a>										 --->
								<!--- </cfif> --->
								<!--- </cfoutput> --->
							<!--- </div> --->
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div> --->
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top" src="./assets/img/lst_brain.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100" style="min-height:250px"> --->
										
							<!--- <h5 class="text-center mt-2">Dominance du cerveau</h5> --->
							<!--- <p align="center"> --->
							<!--- Il y a quelques temps, vous avez suivi un parcours de formation avec WEFIT.<br> --->
							<!--- </p> --->
							<!--- <div align="center" class="mt-auto"> --->
								<!--- <cfoutput> --->
								<!--- <cfif get_result_lst_brain.recordcount neq "0"> --->
								<!--- <a href="##" class="btn btn-success btn_view_lst_brain" id="quiz_#get_result_lst_brain.quiz_user_id#">Résultats</a> --->
								<!--- <cfelse> --->
								<!--- <a href="./quiz.cfm?new_quiz=1&quiz_id=1681" class="btn btn-info">Démarrer mon test</a>										 --->
								<!--- </cfif> --->
								<!--- </cfoutput> --->
							<!--- </div> --->
							
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div> --->
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top card_module" src="./assets/img/lst_memory.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px"> --->
	
							<!--- <h5 class="text-center mt-2">Chronotype</h5> --->
							<!--- <p align="center"> --->
							<!--- Vous êtes plutôt du matin ? plutôt du soir ? --->
							<!--- </p> --->
								
							<!--- <div align="center" class="mt-auto"> --->
							<!--- <a class="btn btn-info disabled">Démarrer mon test</a> --->
							<!--- </div> --->
								
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div>		 --->
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top card_module" src="./assets/img/lst_memory.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px"> --->
	
							<!--- <h5 class="text-center mt-2">Test 5</h5> --->
							<!--- <p align="center"> --->
							<!--- Vous êtes plutôt du matin ? plutôt du soir ? --->
							<!--- </p> --->
								
							<!--- <div align="center" class="mt-auto"> --->
							<!--- <a class="btn btn-info disabled">Démarrer mon test</a> --->
							<!--- </div> --->
								
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div>		 --->
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top card_module" src="./assets/img/lst_memory.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px"> --->
	
							<!--- <h5 class="text-center mt-2">Test 6</h5> --->
							<!--- <p align="center"> --->
							<!--- Pandente itaque viam fatorum sorte tristissima, qua praestitutum erat eum vita et imperio spoliari, itineribus interiectis permutatione iumentorum emensis venit Petobionem  --->
							<!--- </p> --->
								
							<!--- <div align="center" class="mt-auto"> --->
							<!--- <a class="btn btn-info disabled">Démarrer mon test</a> --->
							<!--- </div> --->
								
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div>	 --->
				<!--- <div class="col-lg-3 col-md-4 col-sm-6"> --->
					<!--- <div class="card"> --->
						<!--- <img class="card-img-top card_module" src="./assets/img/lst_memory.jpg"> --->
						<!--- <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:250px"> --->
	
							<!--- <h5 class="text-center mt-2">Test 7</h5> --->
							<!--- <p align="center"> --->
							<!--- Pandente itaque viam fatorum sorte tristissima, qua praestitutum erat eum vita et imperio spoliari, itineribus interiectis permutatione iumentorum emensis venit Petobionem  --->
							<!--- </p> --->
								
							<!--- <div align="center" class="mt-auto"> --->
							<!--- <a class="btn btn-info disabled">Démarrer mon test</a> --->
							<!--- </div> --->
								
						<!--- </div> --->
					<!--- </div> --->
				<!--- </div>	 --->
				
			</div>
			
			
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	$(document).ready(function() {
		
		<cfoutput>
		
		$('.btn_view_lst').click(function(event) {	
			event.preventDefault();		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var quiz_user_id = idtemp[1];
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('title_page_learner_eval_lst'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("./incl/incl_lst_light_container.cfm?quiz_user_id="+quiz_user_id, function() {});
		})
		
		$('.btn_restart_quiz').click(function(event) {		
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var q_id = idtemp[1];	

			if(confirm("#obj_translater.get_translate('js_restart_quiz_confirm')#")){
				document.location.href = "quiz.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1";
			}
			
		})

		<cfif isdefined("show_result")>
			$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('title_page_learner_eval_lst'))#");
			$('##window_item_xl').modal({keyboard: true});
			$('##modal_body_xl').load("./incl/incl_lst_light_container.cfm?quiz_user_id=#show_result#", function() {});
		</cfif>
		
		</cfoutput>


	});
</script>

</body>
</html>