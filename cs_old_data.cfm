<cfsetting requestTimeOut = "9000000" />

<!DOCTYPE html>

<cfsilent>

	<cfquery name="get_users_data" datasource="old_provissioning">	
	SELECT u.FirstName, u.LastName, u.Birthdate, u.Gender, u.MaritalStatus, u.CountryId, u.City, u.CompanyName, u.JobTitle, u.DateCreated, 
	a.Name as account_name
	FROM userprofile u 
	LEFT JOIN account a ON u.AccountId = a.AccountId
	</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "CANCELED">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">	
			
				<div class="col-md-12">

					<div class="card">
						<div class="card-body">
						<table class="table table-bordered">						
							<tr class="bg-light">
								<td><strong>Firstname</strong></td>
								<td><strong>name</strong></td>
								<td><strong>account</strong></td>
								<td><strong>DateCreated</strong></td>
								<td><strong>-</strong></td>
								<td><strong>-</strong></td>
								<td><strong>-</strong></td>
								<td><strong>-</strong></td>
								<td><strong>-</strong></td>
								<!--- <td><strong></strong></td> --->
							</tr>
							<cfoutput query="get_users_data">
							<tr>
								<td>
									#FirstName#
								</td>
								<td>
									#LastName#
								</td>
								<td>
									#account_name#
								</td>
								<td>
									#DateCreated#
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>						
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>
$( document ).ready(function() {

})
</script>

</body>
</html>