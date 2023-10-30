<cfif isdefined("o_id")>
<cfset o_md = hash(o_id)>
</cfif>

<cfif isdefined("o_md")>

<!DOCTYPE html>

<cfinclude template="./incl/incl_lang.cfm">

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head_light.cfm">
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
      
		<cfset title_page = "WEFIT - Documents contractuels">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<div class="row justify-content-center">

				<div class="col-md-8">
				 
					<div class="card border-top border-info">
						<div class="card-header">
							<!--- <h5 class="card-title"><img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_wefit_100.jpg" width="30" align="left" style="margin-right:15px">WEFIT - CONVENTION</h5> --->
						
						</div>
						<div class="card-body">

						
							<!---<div class="alert alert-danger" role="alert">
								<cfoutput>#obj_translater_alert.get_translate('alert_inactive_learner')#</cfoutput>
							</div>--->
						
<cfoutput>
<iframe width="100%" height="500" src="./tpl/convention_container.cfm?o_md=#o_md#"></iframe>
</cfoutput>
									
						</div>
					</div>
					

				</div>
			</div>
	
		</div>
		
		<footer class="footer footer-black footer-white ">
			<div class="container-fluid">
				<div class="row">
					<nav class="footer-nav">
						<ul>
							<li>
							<a href="https://www.wefitgroup.com" target="_blank">SUPPORT WEFIT</a>
							</li>
						</ul>
					</nav>
					<div class="credits ml-auto">
						<span class="copyright">
						<!---<img src="./sources/<cfoutput>#SESSION.MASTER_ID#</cfoutput>/img/logo_wefit_1line.png" height="25" style="margin-top:2px">--->
						&copy;
						<script>
						<cfoutput>#year(now())#</cfoutput>
						</script> / WEFIT
						</span>
					</div>
				</div>
			</div>
		</footer>


	</div>
	
</div>



</body>
<!--   Core JS Files   -->
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>

</html>





</cfif>