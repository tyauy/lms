<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				Vous n'avez pas acc&egrave;s &agrave; la page demand&eacute;e, vous avez &eacute;t&eacute; redirig&eacute;(e) vers votre page d'accueil
				</div>
			</cfif>
			
			<div class="row">
			
				<div class="col-md-5">
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">Action</h6>
							<br>
							<div class="table table-responsive-sm">
							<table class="table table-sm mt-2">
								<tr bgcolor="#ECECEC">
									<td><strong>Date</strong></td>
									<td><strong>Type</strong></td>
									<td><strong>To</strong></td>
									<td><strong>Message</strong></td>
									<td><strong>Etat</strong></td>
									<td><strong>By</strong></td>
								</tr>
								<cfset get_task = obj_query.oget_task()>
								<cfoutput query="get_task">
								<tr>
									<td class="bg-light">
									<label>#dateformat(task_date_creation,'dd/mm/yyyy')#</label>
									</td>
									<td><span class="badge">#task_type_name#</span></td>
									<td>#recipient#</td>
									<td>#task_description#</td>
									<td>
									<cfif task_done eq "1"><i class="fas fa-check-circle text-success"></i><cfelse><i class="fas fa-times-circle text-danger"></i></cfif>
									</td>
									<td>#sender#</td>
								</tr>
								</cfoutput>
							</table>
							</div>
						</div>
					</div>	
				
				</div>
				
				<div class="col-md-7">				
					
					<div class="row">
						<div class="col-md-4">
							<div class="card">
								<div class="card-body">
									<h6 class="card-title">Facturation Mois</h6>
									<br>
									<table class="table table-sm mt-2">

									</table>
								</div>
							</div>					
						</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-body">
									<h6 class="card-title">Facturation Ann&eacute;e</h6>
									<br>
									<table class="table table-sm mt-2">
										<tr>
											<td class="bg-light" width="80%">
											xx
											</td>
											<td>
											<a class="btn btn-success btn-sm" href="">0</a>
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="80%">
											xx
											</td>
											<td>
											<a class="btn btn-danger btn-sm" href="">0</a>
											</td>
										</tr>
									</table>
								</div>
							</div>					
						</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-body">
									<h6 class="card-title">Activit&eacute;</h6>
									<br>
									<table class="table table-sm mt-2">
										<tr>
											<td class="bg-light" width="80%">
											yy
											</td>
											<td>
											<a class="btn btn-success btn-sm" href="">0</a>
											</td>
										</tr>		
										<tr>
											<td class="bg-light" width="80%">
											yy
											</td>
											<td>
											<a class="btn btn-success btn-sm" href="">0</a>
											</td>
										</tr>	
									</table>
								</div>
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

</body>
</html>