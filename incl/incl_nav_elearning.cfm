<div class="row justify-content-md-center mb-5">
    
    <div class="col-md-auto">
        <a href="_AD_elearning_dashboard.cfm" class="<cfif findnocase("dashboard", SCRIPT_NAME)>font-weight-bold text-danger<cfelse>text-dark</cfif>">Mon eLearning</a> 
        | 
        <a href="learner_virtual.cfm" class="<cfif findnocase("virtual", SCRIPT_NAME)>font-weight-bold text-danger<cfelse>text-dark</cfif>">Virtual Classroom</a>
        | 
        <a href="_AD_elearning_skill.cfm" class="<cfif findnocase("skill", SCRIPT_NAME)>font-weight-bold text-danger<cfelse>text-dark</cfif>">Mes Skills</a>
        | 
        <a href="_AD_elearning_ressources.cfm" class="<cfif findnocase("ressource", SCRIPT_NAME)>font-weight-bold text-danger<cfelse>text-dark</cfif>">Toutes les ressources</a>
        | 
        Langue : <img src="./assets/img/training_en.png" width="20">
            
    </div>


</div>

<cfif findnocase('_AD_elearning_dashboard', CGI.SCRIPT_NAME) OR findnocase('_AD_el_dashboard', CGI.SCRIPT_NAME) OR findnocase('_AD_elearning_syllabus', CGI.SCRIPT_NAME)>
    <cfset bg_header= "bg-success">

    <cfset bg_menu1= "bg-white">
    <cfset txt_menu1= "text-success">

    <cfset bg_menu2= "bg-light">
    <cfset txt_menu2= "text-secondary">

    <cfset bg_menu3= "bg-light">
    <cfset txt_menu3= "text-secondary">
    
<cfelseif findnocase('learner_virtual', CGI.SCRIPT_NAME)>
    <cfset bg_header= "bg-light">

    <cfset bg_menu1= "bg-light">
    <cfset txt_menu1= "text-secondary">

    <cfset bg_menu2= "bg-white">
    <cfset txt_menu2= "text-danger">

    <cfset bg_menu3= "bg-light">
    <cfset txt_menu3= "text-secondary">

<cfelseif findnocase('_AD_elearning_ressources', CGI.SCRIPT_NAME)>
    <cfset bg_header= "bg-info">

    <cfset bg_menu1= "bg-light">
    <cfset txt_menu1= "text-secondary">

    <cfset bg_menu2= "bg-light">
    <cfset txt_menu2= "text-secondary">

    <cfset bg_menu3= "bg-white">
    <cfset txt_menu3= "text-info">

<cfelseif findnocase('_AD_elearning_skill', CGI.SCRIPT_NAME) OR findnocase('_AD_elearning_certif', CGI.SCRIPT_NAME)>
    <cfset bg_header= "bg-info">

    <cfset bg_menu1= "bg-light">
    <cfset txt_menu1= "text-secondary">

    <cfset bg_menu2= "bg-light">
    <cfset txt_menu2= "text-secondary">

    <cfset bg_menu3= "bg-white">
    <cfset txt_menu3= "text-info">

<cfelseif findnocase('learner_virtual', CGI.SCRIPT_NAME)>
    <cfset bg_header= "bg-danger">

    <cfset bg_menu1= "bg-light">
    <cfset txt_menu1= "text-secondary">

    <cfset bg_menu2= "bg-light">
    <cfset txt_menu2= "text-secondary">

    <cfset bg_menu3= "bg-white">
    <cfset txt_menu3= "text-danger">

</cfif>
    



<div class="d-flex justify-content-center <cfoutput>#bg_header#</cfoutput> pt-3" style="background-image: url('https://formation.wefitgroup.com/assets/img/back_header_blue_2.jpg')">
      
    <cfif findnocase('_AD_elearning_dashboard', CGI.SCRIPT_NAME)>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "home">border-top border-red</cfif> mb-3" onclick="document.location.href='_AD_elearning_dashboard.cfm?subm=home'">
                <div class="card-body">
                    <div align="center"><i class="fa-home fa-2x <cfif subm eq "home">fa-light text-red<cfelse>fa-thin</cfif>"></i> <br> <span class="<cfif subm eq "home">text-red font-weight-bold</cfif>">Mon eLearning</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "email">border-top border-success</cfif> mb-3" onclick="document.location.href='_AD_elearning_dashboard.cfm?subm=email'">
                <div class="card-body">
                    <div align="center"><i class="fa-envelopes fa-2x <cfif subm eq "email">fa-light text-success<cfelse>fa-thin</cfif>"></i> <br> <span class="<cfif subm eq "email">text-success font-weight-bold</cfif>">Email Templates</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
            <div class="card <cfif subm eq "vocabulary">border-top border-success</cfif> mb-3" onclick="document.location.href='_AD_elearning_dashboard.cfm?subm=vocabulary'">     
                <div class="card-body">
                    <div align="center"><i class="fa-book fa-2x <cfif subm eq "vocabulary">fa-light text-success<cfelse>fa-thin</cfif>"></i> <br><span class="<cfif subm eq "vocabulary">text-success font-weight-bold</cfif>">Vocabulary Lists</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
            <div class="card <cfif subm eq "be">border-top border-success</cfif> mb-3" onclick="document.location.href='_AD_elearning_dashboard.cfm?subm=be'">     
                <div class="card-body">
                    <div align="center"><img src="./assets/img/1000_F_250444074_kwNfCDEEddAreiLQBfusnzbuVxVY6Qqh.jpg" width="40">
                        <br><span class="<cfif subm eq "be">text-success font-weight-bold</cfif>">Business English</span></div>											
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
            <div class="card <cfif subm eq "lingua">border-top border-success</cfif> mb-3" onclick="document.location.href='_AD_elearning_dashboard.cfm?subm=lingua'">     
                <div class="card-body">
                    <div align="center"><img src="https://formation.wefitgroup.com/assets/img_product/1.jpg" width="40">
                        <br><span class="<cfif subm eq "lingua">text-success font-weight-bold</cfif>">Linguaskill</span></div>											
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card mb-3 bg-light btn_add_module">
                <div class="card-body">
                    <div align="center"><i class="fa-thin fa-plus fa-2x"></i><br><span>Ajouter Module</span></div>											
                </div>
            </div>

        </div>

    <cfelseif findnocase("skill", SCRIPT_NAME) OR findnocase('_AD_elearning_certif', CGI.SCRIPT_NAME)>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "home">border-top border-info</cfif> mb-3" onclick="document.location.href='_AD_elearning_skill.cfm?subm=home'">
                <div class="card-body">
                    <div align="center"><i class="fal fa-head-side-headphones fa-2x <cfif subm eq "home">text-info</cfif>"></i> <br> <span class="<cfif subm eq "home">text-info</cfif>">Compréhension orale</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "home">border-top border-info</cfif> mb-3" onclick="document.location.href='_AD_elearning_skill.cfm?subm=home'">
                <div class="card-body">
                    <div align="center"><i class="fal fa-books fa-2x <cfif subm eq "home">text-info</cfif>"></i> <br> <span class="<cfif subm eq "home">text-info</cfif>">Compréhension écrite</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "home">border-top border-info</cfif> mb-3" onclick="document.location.href='_AD_elearning_skill.cfm?subm=home'">
                <div class="card-body">
                    <div align="center"><i class="fal fa-comments fa-2x <cfif subm eq "home">text-info</cfif>"></i> <br> <span class="<cfif subm eq "home">text-info</cfif>">Expression<br>orale</span></div>											
                </div>
            </div>

        </div>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "home">border-top border-info</cfif> mb-3" onclick="document.location.href='_AD_elearning_skill.cfm?subm=home'">
                <div class="card-body">
                    <div align="center"><i class="fal fa-edit fa-2x <cfif subm eq "home">text-info</cfif>"></i> <br> <span class="<cfif subm eq "home">text-info</cfif>">Expression<br>écrite</span></div>											
                </div>
            </div>

        </div>

      
    <cfelseif findnocase("ressource", SCRIPT_NAME)>



    <cfelseif findnocase("virtual", SCRIPT_NAME)>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card <cfif subm eq "virtual_home">border-top border-danger</cfif> mb-3" onclick="document.location.href='learner_virtual.cfm?subm=virtual_home'">
                <div class="card-body">
                    <div align="center"><i class="fa-calendar fa-2x <cfif subm eq "virtual_home">fa-light text-danger<cfelse>fa-thin</cfif>"></i> <br> <span class="<cfif subm eq "virtual_home">text-danger font-weight-bold</cfif>"><cfoutput>#obj_translater.get_translate('btn_calendar')#</cfoutput></span></div>											
                </div>
            </div>

        </div>

        <cfif get_tp_user.recordcount neq "0">

            <cfoutput query="get_tp_user">
                <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                <div class="card mb-3">


                    <div class="card-body">
                        <div align="center">


                        <cfif fileexists("#SESSION.BO_ROOT_URL#/assets/img_tp/#tp_id#.jpg")>
                                <img width="40" src="#SESSION.BO_ROOT_URL#/assets/img_tp/#tp_id#.jpg">
                        </cfif>
                        <br>

                        <span class="badge badge-pill badge-#tplevel_css# mr-2">#tplevel_alias#</span> #tp_name#
                        


                        </div>											
                    </div>
                </div>
            </div>

            </cfoutput>

        </cfif>

        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card mb-3 bg-light btn_add_virtual cursored" id="lvl_1">
                <div class="card-body">
                    <div align="center"><i class="fa-thin fa-book fa-2x"></i><br><span><cfoutput>#obj_translater.get_translate('vc_btn_all_tp')#</cfoutput></span></div>											
                </div>
            </div>

        </div>

    </cfif>
</div>



<!--- <cfoutput>
<div class="d-flex justify-content-center #bg_header# pt-3" style="<!---background-image: url('./assets/img/header_email_reminder.jpg')--->">
    
    <div class="col-lg-3 col-md-3 col-sm-6" style="margin-top:-40px !important">
                
        
        <div class="card mb-3 #bg_menu1#" onclick="document.location.href='_AD_elearning_dashboard.cfm'">
            <div class="card-body">
                <h5 class="m-0 #txt_menu1#"><i class="fa-light fa-laptop fa-lg #txt_menu1#"></i> Mon <strong>e-Learning</strong></h5>
                <!--- <h4 class="text-info m-0"><i class="fa-light fa-screen-users fa-lg text-info text-center"></i> Open <strong>Training</strong></h4> --->
                <div class="w-100 border-top mt-3 p-2 #txt_menu1#">
                    <!--- <img src="./assets/img/1000_F_347544985_ImOfEvR7qSWmXgPxHdRd3jVXn5z4eKTm.jpg" class="mr-2 float-left" width="120"> --->
                    <div>
                        Vous ne suivez pas encore de parcours Open Training. 
                        <!--- <div align="right" class="clearfix"><a class="btn btn-secondary m-0 mt-2" href="./learner_virtual.cfm">ACTIVER</a></div> --->
                    </div>
                </div>

            </div>
        </div>

    </div>
    
    <!--- <div class="col-lg-3 col-md-3 col-sm-6" style="margin-top:-40px !important">
                
        <div class="card mb-3 #bg_menu2#" onclick="document.location.href='learner_virtual.cfm'">
            <div class="card-body">
                <h5 class="m-0 #txt_menu2#"><i class="fa-light fa-screen-users fa-lg #txt_menu2#"></i> Virtual <strong>Classroom</strong></h5>
                <div class="w-100 border-top mt-3 p-2 #txt_menu2#">
                    <div>
                        Vous ne suivez pas encore de parcours Open Training. 
                    </div>
                </div>

            </div>
        </div>

    </div> --->
    
    <div class="col-lg-3 col-md-3 col-sm-6" style="margin-top:-40px !important">
        
        <div class="card mb-3 #bg_menu3#" onclick="document.location.href='_AD_elearning_ressources.cfm'">
            <div class="card-body">
                <h5 class="m-0 #txt_menu3#"><i class="fa-light fa-photo-film fa-lg #txt_menu3#"></i> Les <strong>Ressources</strong></h5>
                
                <div class="w-100 border-top mt-3 p-2 #txt_menu3#">
                    <!--- <img src="./assets/img/1000_F_347544985_ImOfEvR7qSWmXgPxHdRd3jVXn5z4eKTm.jpg" class="mr-2 float-left" width="120"> --->
                    <div>
                        Vous ne suivez pas encore de parcours Open Training. 
                        <!--- <div align="right" class="clearfix"><a class="btn btn-secondary m-0 mt-2" href="./learner_virtual.cfm">ACTIVER</a></div> --->
                    </div>
                </div>

            </div>
        </div>

    </div>
    <div class="col-lg-3 col-md-3 col-sm-6" style="margin-top:-40px !important">
        
        <div class="card mb-3 #bg_menu3#" onclick="document.location.href='_AD_elearning_skill.cfm'">
            <div class="card-body">
                <h5 class="m-0 #txt_menu3#"><i class="fa-light fa-photo-film fa-lg #txt_menu3#"></i> Mes <strong>Skills</strong></h5>
                <!--- <h4 class="text-info m-0"><i class="fa-light fa-screen-users fa-lg text-info text-center"></i> Open <strong>Training</strong></h4> --->
                <div class="w-100 border-top mt-3 p-2 #txt_menu3#">
                    <!--- <img src="./assets/img/1000_F_347544985_ImOfEvR7qSWmXgPxHdRd3jVXn5z4eKTm.jpg" class="mr-2 float-left" width="120"> --->
                    <div>
                        Vous ne suivez pas encore de parcours Open Training. 
                        <!--- <div align="right" class="clearfix"><a class="btn btn-secondary m-0 mt-2" href="./learner_virtual.cfm">ACTIVER</a></div> --->
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
</cfoutput> --->

