<cfoutput>
    <div class="col-lg-2 col-md-3 col-sm-6">


        <div class="card border" style="border-top: 3px solid ##2ba9cd !important;">
            <!--- <div class="header_rounded_top border-bottom-2 border-red" style="background-color:##FFFFFF; background-image: url('./assets/img/logo_toeic.jpg'); height:60px; background-position:center center; <!---background-size: cover;--->">
                
            </div> --->

            <!--- style="border-top: 3px solid #CB2039;" --->


            <div class="card-body d-flex flex-column h-100 bg-light">
                <h6 class="my-0 font-weight-bold" align="center">EXERCICE #currentrow#</h6>
                
                <cfquery name="get_module_id" datasource="#SESSION.BDDSOURCE#">
                SELECT em.elearning_module_id, emu.elearning_completion, emu.elearning_score
                FROM lms_elearning_module em
                INNER JOIN lms_elearning_module_user emu ON emu.elearning_module_id = em.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                WHERE elearning_module_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_path#">
                </cfquery>
                    
                <cfif get_module_id.recordcount neq "0">

                    <div class="d-flex">

                        <div class="pt-1">
                            <small><strong>#__score#</strong></small>
                        </div>

                        <div class="progress mt-1 ml-2" style="height:18px; width:100%">
                            <div class="progress-bar progress-bar-striped progress-bar-animated <cfif get_module_id.elearning_score lt 40>bg-danger<cfelseif get_module_id.elearning_score gte 40 AND get_module_id.elearning_score lt 100>bg-warning<cfelse>bg-success</cfif>" role="progressbar" style="width: #get_module_id.elearning_score#%" aria-valuenow="#get_module_id.elearning_score#" aria-valuemin="0" aria-valuemax="100">
                            <!--- #get_module_id.elearning_score# / 100 --->
                            </div>
                        </div>

                    </div>

                
                <cfelse>

                    <div style="height:20px; width:100%"></div>
                    
                </cfif>

                <a class="btn btn-sm btn-block btn-outline-info m-0 mt-2" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank" data-mid="#elearning_module_id#">
                    #__btn_train#	
                </a>


            </div>
        </div>




    <!--- <div class="container_resource bg-light card border rounded shadow-sm" id="container_#elearning_module_id#">
                                                                
        <div class="card-body">
    
            <div class="d-flex">

                <div class="mr-2" style="flex: 0 0 80px;">
                    <img src="../assets/img/logo_toeic.jpg" width="40" class="mr-2">
                </div>
    
                <div>
                    <h6 class="m-0">Exercice</h6>
    
                    <p class="mt-2">

                        <!----------- MODULE PROGRESS ------------>
                        <div class="d-flex">
                            <div><small><strong>#obj_translater.get_translate('table_th_score')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></strong></small></div>
                        
                            

                        </div>
                        
                    </p>
    
    
                </div>
    
                <div class="d-flex ml-auto align-items-end flex-column justify-content-end h-100">

                    <div class="mt-4 d-flex">

                        
    
                    </div>    
    
                </div>
    
    
            </div>
            
        </div>  
    </div> --->
    </div>
</cfoutput>