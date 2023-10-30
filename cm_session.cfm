
<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,8,11,12">
	<cfinclude template="./incl/incl_secure.cfm">

    <cfparam name="st_id" default="0">
    
</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Gestion Session">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
            <cfinclude template="./widget/wid_token_session_form.cfm">      
        </div>


        <cfinclude template="./incl/incl_footer.cfm">

	</div>
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>
    $(document).ready(function() {
    
        $("#token_session_start").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}
        });
        
        $("#token_session_end").datepicker({	
            weekStart: 1,
            dateFormat: 'dd/mm/yy',
            onClose: function( selectedDate ) {}	
        });
    
        $('#submit_session_edit').click(function(){
            event.preventDefault();
    
            console.log($('#form_session_edit').serialize()); 
            $.ajax({				  
                url: 'api/school/school_post.cfc?method=update_school_session',
                type: 'POST',
                data : $('#form_session_edit').serialize(),
                datatype : "html", 
                success : function(result, status){ 
                    console.log(result); 
                    // window.location.reload(true);
                }, 
                error : function(result, status, error){ 
                    /*console.log(resultat);*/ 
                }	 
            });
    
        })
    
    });
    
    </script>
</body>
</html>