<cfsilent>

    <cfparam name="f_id" default="2">
    
</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>

    </style>
</head>


<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "ELEARNING - VIRTUAL CLASS REPLAY">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el2.cfm">
                
                <div class="row">
                    <div class="col-md-12">

                        <div class="card border">

                        </div>

                    </div>

                </div>

            </div>
        
        <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
        
    </div>
      
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">

    <cfinclude template="./incl/incl_scripts_param.cfm">
        
<script>
$(document).ready(function() {


});

</script>

</body>
</html>