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
          
            <cfset title_page = "*WEFIT LMS*">            
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row mt-3">
                    <div class="col-md-12">

                        <div class="nav nav-tabs">

                            
                            <button class="nav-link border-0" type="button" onclick="document.location.href='el_vocab.cfm'"><!---<i class="fa-light fa-spell-check"></i> --->
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-3 img_rounded" src="./assets/img/thumb_long_6.jpg" width="90">
                                    </div>
                                    <div align="left">
                                        <h5 style="font-size:18px" class="mb-0">
                                        <cfoutput>#obj_translater.get_translate('tab_vocab_list')#</cfoutput>
                                        </h5>
                                    </div>
                                </div>
                            </button>
                                
                            <button class="nav-link active border-0" type="button" onclick="document.location.href='el_vocab_perso.cfm'">
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-3 img_rounded" src="./assets/img/thumb_long_7.jpg" width="90">
                                    </div>
                                    <div align="left">
                                        <h5 style="font-size:18px" class="mb-0">
                                        <cfoutput>#obj_translater.get_translate('tab_vocab_favorite')#</cfoutput>
                                        </h5>
                                    </div>
                                </div>
                            </button>
                        </div>


                        <div class="card" style="margin-top:-1px !important">

                            <div class="card-body">

                                <!--- <div class="w-100 mb-3">
                                    <h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_vocabulary_perso_list')#</cfoutput></h5>
                                    <hr class="border-red mb-1 mt-2">
                                </div> --->

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