<!DOCTYPE html>

<cfsilent>

	<!--- <cfset SESSION.USER_ID = 2847> --->

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<!--------------- DEFAULT DATE & VIEW  ------------->
<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfset y = mid(ysel,3,2)>

<cfparam name="view" default="reg">
<!--------------- DEFAULT DATE & VIEW  ------------->

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "DASHBOARD FINANCE">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">

			<cfset urlgo = "finance_index.cfm">
			<cfinclude template="./incl/incl_nav_finance.cfm">

			<div class="row">

				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">

							<h6>TITLE 1</h6>


						</div>

					</div>

				</div>


				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">

                            <h6>TITLE 2</h6>

						</div>

					</div>

				</div>

				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">
							
                            <h6>TITLE 3</h6>

						</div>

					</div>

				</div>

				<div class="col-md-3">

					<div class="card border mb-3">

						<div class="card-body">

                            <h6>TITLE 4</h6>
							
						</div>

					</div>

				</div>

			</div>

			<div class="card border mb-3">

				<div class="card-body">
			
					<h6>LISTING</h6>

					<div class="d-flex justify-content-around">
						
						
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