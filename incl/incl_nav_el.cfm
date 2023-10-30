<style>
.card_menu {
    cursor:pointer
}
</style>

<!--- <div class="row justify-content-md-center mb-5">
    
    <div class="col-md-auto">
        <a href="comon_tp_details.cfm" class="<cfif findnocase("learner_index", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Visio</a> 
        | 
        <a href="el_dashboard2.cfm" class="<cfif findnocase("el_dashboard2", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">eLearning</a> 
        | 
        <a href="_AD_learner_virtual.cfm" class="<cfif findnocase("_AD_learner_virtual", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Virtual Classroom</a>
        <!--- | 
        <a href="_AD_elearning_skill.cfm" class="<cfif findnocase("skill", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Mes Skills</a>
        | 
        <a href="_AD_elearning_ressources.cfm" class="<cfif findnocase("ressource", SCRIPT_NAME)>font-weight-bold text-red<cfelse>text-dark</cfif>">Toutes les ressources</a>
        | 
        Langue : <img src="./assets/img/training_en.png" width="20"> --->
            
    </div>


</div> --->

<cfif findnocase("el_dashboard",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_el.jpg">
<cfelseif findnocase("el_email",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_email_template.jpg">
<cfelseif findnocase("el_certif",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_certif.jpg">
<cfelseif findnocase("el_vocab",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_vocab_list.jpg">
<cfelseif findnocase("el_wechat",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_pic_6.jpg">
</cfif>

<cfoutput>
<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/#back_src#'); height:230px; background-position:top right; background-size: cover;">

    <div class="footer_rounded" style="width:100%; height:auto; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="<!---container --->p-2 px-4">
            <div class="w-100 d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0 text-black">
                    <!--- <i class="fa-light fa-laptop fa-lg mr-2 font-weight-bold"></i>     --->
                    <strong>E-LEARNING</strong>
                </h5>

                <div>
                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_dashboard",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_dashboard.cfm">
                        #obj_translater.get_translate('sidemenu_learner_myeprogram')#
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_vocab",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_vocab.cfm">
                        #obj_translater.get_translate('sidemenu_learner_vocab')#
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_email",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_email.cfm">
                        #obj_translater.get_translate('sidemenu_learner_email_template')#
                    </a>

                    <!--- <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_wecha",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_wechat.cfm">
                        We*Chat
                    </a> --->

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_certif",CGI.SCRIPT_NAME) AND isdefined("subm") AND subm eq "toeic">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_certif.cfm?subm=toeic">
                        TOEIC
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_certif",CGI.SCRIPT_NAME) AND isdefined("subm") AND subm eq "linguaskill">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_certif.cfm?subm=linguaskill">
                        LINGUASKILL
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_certif",CGI.SCRIPT_NAME) AND isdefined("subm") AND subm eq "bright">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_certif.cfm?subm=bright">
                        BRIGHT
                    </a>

                    <!--- <a class="btn btn-sm my-0 <cfif findnocase("el_replay",CGI.SCRIPT_NAME)>btn-red<cfelse>btn-link text-red</cfif>" href="el_replay2.cfm">
                        <!---<i class="fa-light fa-play"></i> --->Replay
                    </a> --->
                </div>

    
                <!--- <div align="center">
                    <i class="fa-thin fa-2x fa-list m-2 text-info" id="btn_collapse_list" aria-hidden="true"></i>
                    <i class="fa-thin fa-2x fa-calendar-week m-2 text-dark" id="btn_collapse_grid" aria-hidden="true"></i>
                </div> --->

            </div>
        </div>
    </div>

</div>
</cfoutput>

    <!--- <div class="card border bg-light">
                    
        <div class="p-3">
                            
            

        </div>
    </div> --->


    
    <!--- <div class="row justify-content-center">
    
        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
        
            <div class="card card_menu <cfif findnocase("el_dashboard",CGI.PATH_TRANSLATED)>border-top border-red</cfif> mb-3" onclick="document.location.href='el_dashboard.cfm'">
                <div class="card-body">
                    <div align="center"><i class="fa-laptop fa-2x <cfif findnocase("el_dashboard",CGI.PATH_TRANSLATED)>fa-light text-red<cfelse>fa-thin</cfif>"></i> 
                    <br> <span class="<cfif findnocase("el_dashboard",CGI.PATH_TRANSLATED)>text-red font-weight-bold</cfif>">Parcours eLearning</span>
                    </div>											
                </div>
            </div>
    
        </div>
    
        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card card_menu <cfif findnocase("el_email",CGI.PATH_TRANSLATED)>border-top border-red</cfif> mb-3" onclick="document.location.href='el_email.cfm'">
                <div class="card-body">
                    <div align="center"><i class="fa-envelopes fa-2x <cfif findnocase("el_email",CGI.PATH_TRANSLATED)>fa-light text-red<cfelse>fa-thin</cfif>"></i> 
                    <br> <span class="<cfif findnocase("el_email",CGI.PATH_TRANSLATED)>text-red font-weight-bold</cfif>">Email Templates</span>
                    </div>											
                </div>
            </div>
    
        </div>
    
        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
            <div class="card card_menu <cfif findnocase("el_vocab",CGI.PATH_TRANSLATED)>border-top border-red</cfif> mb-3" onclick="document.location.href='el_vocab.cfm'">     
                <div class="card-body">
                    <div align="center"><i class="fa-spell-check fa-2x <cfif findnocase("el_vocab",CGI.PATH_TRANSLATED)>fa-light text-red<cfelse>fa-thin</cfif>"></i> 
                    <br><span class="<cfif findnocase("el_vocab",CGI.PATH_TRANSLATED)>text-red font-weight-bold</cfif>">Vocabulary Lists</span>
                    </div>											
                </div>
            </div>
    
        </div>
    
        <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
            <div class="card card_menu <cfif findnocase("el_certif",CGI.PATH_TRANSLATED)>border-top border-red</cfif> mb-3" onclick="document.location.href='el_certif.cfm'">     
                <div class="card-body">
                    <div align="center"><i class="fa-file-certificate fa-2x <cfif findnocase("el_certif",CGI.PATH_TRANSLATED)>fa-light text-red<cfelse>fa-thin</cfif>"></i>
                    <br><span class="<cfif findnocase("el_certif",CGI.PATH_TRANSLATED)>text-red font-weight-bold</cfif>">Prépa Certification</span>
                    </div>											
                </div>
            </div>
        </div>
    
        
    
        <!--- <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                    
            <div class="card mb-3 bg-light btn_add_module">
                <div class="card-body">
                    <div align="center"><i class="fa-thin fa-plus fa-2x"></i><br><span>Ajouter Module</span></div>											
                </div>
            </div>
    
        </div> --->
    
    </div> --->