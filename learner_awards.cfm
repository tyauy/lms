<!DOCTYPE html>

<cfsilent>

<!--- <cfset secure = "3,7,9">
<cfinclude template="./incl/incl_secure.cfm"> --->

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_signature')#">
		
		<cfinclude template="./incl/incl_nav.cfm">
			
		<div class="content">

			<cfinclude template="./incl/incl_nav_visio.cfm">

			<div class="row">
				<div class="col-md-12">
				
                    <div class="card">
                        <div class="card-body">

                            <div class="d-flex justify-content-center">

                            <cfoutput>
                            <cfloop from="5" to="12" index="cor">
                                <div>
                                <img src="https://lms.wefitgroup.com/assets/img_badge/#cor#_G.svg" width="120">
                                Jeune padawan
                                </div>
                            </cfloop>
                            </cfoutput>

                            </div>

                        </div>
                    </div>

				</div>			
			</div>
				
		</div>
		
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<script>
$(document).ready(function() {

	
})	
</script>


</body>
</html>