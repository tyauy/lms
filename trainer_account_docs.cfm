<!DOCTYPE html>

<cfsilent>
	
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
			<cfset case = "account">
			<cfinclude template="./incl/incl_nav_trainer.cfm">
			
			<div class="row">
			
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h5 class="card-title">Ma formation</h5>
							<p class="card-category">Aper&ccedil;u de votre parcours de formation</p>
						</div>
						<div class="card-body ">

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