<cfif isdefined("view")>

    <cfif view eq "welcome">

        <cfset SESSION.ALERT_WELCOME = "1">

        <video controls width="100%" height="500">
            <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_discover_wefit_#SESSION.LANG_CODE#.mp4" type="video/mp4"></cfoutput>
        </video>

    <cfelseif view eq "welcome_vc">

        <cfset SESSION.ALERT_WELCOME = "1">

        <div class="p-3">

            <div align="center">

                <cfif SESSION.LANG_CODE eq "es" OR SESSION.LANG_CODE eq "it">
                    <video controls id="video_pres_vc_splash" width="80%" poster="./assets/img/method_virtualclass.jpg">
                    <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_en.mp4" type="video/mp4"></cfoutput>
                    </video>
                <cfelse>
                    <video controls id="video_pres_vc_splash" width="80%" poster="./assets/img/method_virtualclass.jpg">
                    <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_#SESSION.LANG_CODE#.mp4" type="video/mp4"></cfoutput>
                    </video>
                </cfif>

            </div>

            <h5 class="mt-3 mb-0"><cfoutput>#obj_translater.get_translate('vc_discover_virtual_title')#</cfoutput></h5>
            <hr class="border-red mb-2 mt-1">
        
            <cfif SESSION.LANG_CODE eq "es" OR SESSION.LANG_CODE eq "it">
                <cfoutput>#obj_translater.get_translate(id_translate='vc_discover_virtual_details',lg_translate="en")#</cfoutput>
            <cfelse>
                <cfoutput>#obj_translater.get_translate('vc_discover_virtual_details')#</cfoutput>
            </cfif>

            <div align="center" class="clearfix">

                <cfif not isdefined("from_connect")>

                <a role="button" class="btn btn-link text-red m-0 mt-3" data-dismiss="modal">
                    [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                </a>
                
                <cfif isdefined("SESSION.ACCESS_EL") AND SESSION.ACCESS_EL eq "1">
                    <a class="btn btn-red m-0 mt-3" href="./learner_virtual.cfm">
                        <cfoutput>#obj_translater.get_translate('vc_btn_explore_tp')#</cfoutput>
                    </a>
                <cfelse>
                    <a class="btn disabled btn-red m-0 mt-3">
                        <cfoutput>#obj_translater.get_translate('vc_btn_explore_tp')#</cfoutput>
                    </a>
                </cfif>

                <a href="##" class="btn btn-red m-0 mt-3 btn_contact_wefit">
                    <cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput>
                </a>

            <cfelse>

                <a role="button" class="btn btn-danger m-0 mt-3" data-dismiss="modal">
                    <cfoutput>#obj_translater.get_translate('btn_connect')#</cfoutput>
                </a>

            </cfif>


            </div>
        </div>

        <script>
            $(document).ready(function() {
            
                $('.btn_contact_wefit').click(function(event) {	
        
                $('#window_item_sm').modal('hide');
                $('#window_item_lg').modal('hide');
                $('#window_item_xl').modal('hide');
                $('#window_item_xl_unclosable').modal('hide');
        
                $('#window_item_ctc').modal({keyboard: true});
                $('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
                $('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});

                });
            
            });

        </script>




        


    </cfif>

</cfif>



