<style>
.card_menu {
    cursor:pointer
}
</style>
    
<div class="d-flex justify-content-center pt-3 rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/1000_F_181633090_BYItxn4t4d5hgbQNL5VKZqexfzLWJeRL.jpg'); height:150px; background-position:center right; background-size: cover;">
      <!--- <h2 class="text-white">Hello world</h2> --->
</div>

<div class="row justify-content-center">

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

</div>