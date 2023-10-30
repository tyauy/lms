<cfif findnocase("common_practice",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_el.jpg">
<cfelseif findnocase("el_email",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_email_template.jpg">
<cfelseif findnocase("el_certif",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_certif.jpg">
<cfelseif findnocase("elearning_vocab",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_vocab_list.jpg">
<cfelseif findnocase("el_replay",CGI.SCRIPT_NAME)>
    <cfset back_src = "web_business.jpg">
<cfelseif findnocase("el_wechat",CGI.SCRIPT_NAME)>
    <cfset back_src = "web_business.jpg">
</cfif>

<cfoutput>
<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/#back_src#'); height:230px; background-position:top right; background-size: cover;">

    <div class="footer_rounded" style="width:100%; height:auto; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="<!---container --->p-2 px-4">
            <div class="w-100 d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0 text-black">
                    <!--- <i class="fa-light fa-laptop fa-lg mr-2 font-weight-bold"></i>     --->
                    <strong>ELEARNING</strong>
                </h5>

                <div>
                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("common_practice",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_dashboard.cfm">
                        <!---<i class="fa-light fa-laptop"></i> --->Mon Parcours
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("elearning_vocab",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_vocab.cfm">
                        <!---<i class="fa-light fa-spell-check"></i> --->Vocabulary lists
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_email",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_email.cfm">
                        <!---<i class="fa-light fa-envelopes "></i> ---><cfoutput>#obj_translater.get_translate('title_page_common_wemail')#</cfoutput>
                    </a>

                    <a class="btn btn-sm my-0 px-1 rounded-0 <cfif findnocase("el_certif",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="el_certif.cfm">
                        <!---<i class="fa-light fa-file-certificate"></i> --->Prépa Certif
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