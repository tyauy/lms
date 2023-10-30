<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,3,4,5,6,7,8,9,10,11,12">
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
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
		<!--- <cfset help_page = "help_index"> --->
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<div class="row">
	
				<div class="col-md-12">
				
				
					<cfoutput>
					<br>
					<ul class="nav nav-tabs" id="module_list" role="tablist">
						<li class="nav-item">		
							<a href="##f_charter" class="nav-link <cfif show_info eq "use">active</cfif>" role="tab" data-toggle="tab">
							<cfoutput>#obj_translater.get_translate('card_use')#</cfoutput>
							</a>
						</li>
						<li class="nav-item">		
							<a href="##f_policy" class="nav-link <cfif show_info eq "policy">active</cfif>" role="tab" data-toggle="tab">
							<cfoutput>#obj_translater.get_translate('card_policy')#</cfoutput>
							</a>
						</li>
						<!--- <li class="nav-item">		 --->
							<!--- <a href="##f_CGV" class="nav-link <cfif show_info eq "CGV">active</cfif>" role="tab" data-toggle="tab"> --->
							<!--- Mentions légales --->
							<!--- </a> --->
						<!--- </li>						 --->
					</ul>
					</cfoutput>
					
					<div class="tab-content">
		
						<div role="tabpanel" class="tab-pane <cfif show_info eq "use">active show</cfif>" <cfoutput>id="f_charter"</cfoutput> style="margin-top:15px;">
							
							<cfset view = "display_charter">
							<cfinclude template="./incl/incl_cgu.cfm">
							
						</div>
						
						<div role="tabpanel" class="tab-pane <cfif show_info eq "policy">active show</cfif>" <cfoutput>id="f_policy"</cfoutput> style="margin-top:15px;">
							<cfset view = "display_cgu">
							<cfinclude template="./incl/incl_cgu.cfm">
						</div>		
				
					</div>
				
				</div>		
				
			</div>		
			
		</div>	
<cfinclude template="./incl/incl_footer.cfm">
		
	</div>
</div>
  

  
<cfinclude template="./incl/incl_scripts.cfm">

	
<script>
$(document).ready(function() {





	
	
	
	
	
	
	
	
	
	
});
</script>
</body>
</html>