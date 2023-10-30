<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset get_tasks = obj_query.oget_tasks(task_group="cs")>

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head.cfm">
	<style>
	#ui-datepicker-div
	{
	z-index:1255 !important;
	}
	
	</style>
</head>

<body>

<div class="wrapper">

	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
	  
		<cfset title_page = "Welcome to WEFIT CRM !">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				Vous n'avez pas acc&egrave;s &agrave; la page demand&eacute;e, vous avez &eacute;t&eacute; redirig&eacute;(e) vers votre page d'accueil
				</div>
			</cfif>
			
			<div class="row">
			
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="card card-stats">
						<div class="card-body">
							<div class="row">
								<div class="col-5 col-md-4">
									<div class="icon-big text-center">
									<i class="fas fa-tasks text-warning"></i>
									</div>
								</div>
								<div class="col-7 col-md-8">
									<div class="numbers">
									<p class="card-category">T&acirc;ches today</p>
									<p class="card-title">2</p>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right">

						</div>
					</div>
				</div>
				
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="card card-stats">
						<div class="card-body ">
							<div class="row">
								<div class="col-5 col-md-4">
									<div class="icon-big text-center">
									<i class="fas fa-comment-dollar text-success"></i>
									</div>
								</div>
								<div class="col-7 col-md-8">
									<div class="numbers">
										<p class="card-category">Opportunit&eacute;s</p>
										<p class="card-title">1</p>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right">
						</div>
					</div>
				</div>
				
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="card card-stats">
						<div class="card-body ">
							<div class="row">
								<div class="col-5 col-md-4">
									<div class="icon-big text-center icon-warning">
									<i class="fas fa-chart-bar text-danger"></i>
									</div>
								</div>
								<div class="col-7 col-md-8">
									<div class="numbers">
									<p class="card-category">Mon CA</p>
									<p class="card-title">12500 &euro;</p>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right">

						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="card card-stats">
						<div class="card-body ">
							<div class="row">
								<div class="col-5 col-md-4">
								   

									<div class="icon-big text-center icon-warning">
										<i class="fas fa-hourglass-half text-info"></i>
									</div>
								</div>
								<div class="col-7 col-md-8">
									<div class="numbers">
									<p class="card-category">Heures r&eacute;alis&eacute;es</p>
									<p class="card-title">21h</p>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer" style="text-align:right">

						</div>
					</div>
				</div>
		
			</div>
			
			<div class="row">

				<div class="col-md-5">
					
					<cfinclude template="./widget/wid_task_select.cfm">
					
					<cfinclude template="./widget/wid_opport_select.cfm">

				
				</div>
				
				<div class="col-md-7">
				
					<cfinclude template="./calendar/crm_calendar.cfm">
					
						<!---
						<cfoutput>#obj_paneler.get_panel('open','sale','Suivi commercial','show','info')#</cfoutput>
						<div class="row">				
							<div class="col-md-6">						
								<h3>CA</h3>
								<hr>
								<canvas id="histo" width="200" height="200"></canvas>
							</div>

							<div class="col-md-6">
								<h3><cfoutput>#listgetat(SESSION.LISTMONTHS,month(now()))# #year(now())#</cfoutput></h3>
								<hr>
								<cfoutput>#obj_charter.get_pie_opport()#</cfoutput>
								
							</div>
						</div>
						<cfoutput>#obj_paneler.get_panel('close')#</cfoutput>
						--->
						

	
						
						
				</div>
				
			</div>
		
		</div>
		
		<cfinclude template="./incl/incl_footer.cfm">
	
	</div>
	
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>

$('.btn_opport_plus').click(function (event) {
	event.preventDefault();
	$('#tabs_account a[href="#sales"]').tab('show');
})

</script>

<cfinclude template="./calendar/crm_calendar_param.cfm">

</body>
</html>