<cfsilent>
    <cfparam name="subm" default="vocabulary_perso">
</cfsilent>   

<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>

    <cfinclude template="incl/incl_head.cfm">
</head>


<body>
    <div class="wrapper">
    
	    <cfinclude template="./incl/incl_sidebar.cfm">
	
        <div class="main-panel">
          
            <cfset title_page="<cfoutput>#obj_translater.get_translate('card_#subm#_list')#</cfoutput>">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row">
                    <div class="col-md-12">

                        <div class="nav nav-tabs">
                            <button class="nav-link" type="button" onclick="document.location.href='el_vocab.cfm'">Listes de<br><strong>Vocabulaire</button>
                            <button class="nav-link active" type="button" onclick="document.location.href='el_vocab_perso.cfm'">Vocabulaire<br><strong>"Favoris"</strong></button>
                        </div>

                        <div class="card border mt-3">

                            <div class="card-body">

                                <div class="w-100 mb-3">
                                    <h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_vocabulary_perso_list')#</cfoutput></h5>
                                    <hr class="border-red mb-1 mt-2">
                                </div>

                                <cfinclude template="./widget/wid_vocab_list_perso.cfm">  

                            </div>

                        </div>
                    </div>
                </div>
       

        <cfinclude template="./incl/incl_footer.cfm">  

        </div>
        
    </div>  
   
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_vocab.cfm">

</body>
</html>