
<cfinvoke  component="api/ratings/ratings_personality_post" method="ocheck_existingpersonality" returnvariable="existingpersonality" >
    <cfinvokeargument name="u_id" value="#u_id#"> 
    <cfinvokeargument name="tr_id" value="#tr_id#">
</cfinvoke>

<cfdump var="" >
            
    <!--- 	<cfdump var="#existingpersonality#" > --->
<div class="card border border-info" style="background-color:#FCFCFC">

    <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
        <h5 class="my-1 text-info" align="center" id="One">  <cfoutput>#obj_translater.get_translate('rating_personality_title')#</cfoutput>
        
        <i class="fa-regular fa-circle-xmark alert text-danger collapse pull-right" id="alert_error_perso" role="alert" title="You have already rated this lesson. Please get in touch to change your vote."></i>
        <i class="fa-regular fa-check alert text-success collapse pull-right" id="alert_success_perso" role="alert" title="Trainer personality sent, thanks!"></i> 
        </h5>	
    </button>
    <div id="collapseOne" class="collapse pb-2 justify-content-center" aria-labelledby="headingOne" data-parent="#accordion">
        <div class="card-body justify-content-center m-auto">
            <cfif existingpersonality.recordCount eq 0>		
                <p class="text-center"><cfoutput>#obj_translater.get_translate('rating_personality_description')#</cfoutput></p>
                <form id="form_trainer_personality" method="POST">
                    <div class="row justify-content-center p-4" >	
                        
                            <cfinvoke component="api/ratings/ratings_personality_get" method="oget_allpersonnalities" returnvariable="get_personality_all">
                                <cfinvokeargument name="tr_id" value="#tr_id#">
                                
                            </cfinvoke>	
                            
                            <cfloop query="get_personality_all"> 
                            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 justify-content-center text-center p-2"  style="height: auto; width: 550px;"> 
                                <cfoutput>
                                    <!--- hidden checkbox --->	
                                    <input type="checkbox" name="perso_input" class="form-check-input cursored" id="perso_check_#perso_id#" value="#perso_id#" style="visibility: hidden">
                                    <!--- perso image ---> 	
                                    <div class="perso_img" id="#perso_id#" title="#perso_name#"> 
                                        <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_personality/#perso_id#_G.svg" variable="perso_#perso_id#"><cfoutput>#Variables["perso_#perso_id#"]#</cfoutput>
                                    </div>
                                    <!--- perso  title --->	
                                    <div class="cursored text-center text-wrap">
                                        <label class="form-check-label d-block" for="#perso_id#"> #perso_name# 
                                            <!--- perso description --->	
                                            <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge float-top" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip_#perso_id#')#</cfoutput>">?
                                            </span>
                                        </label> 
                                    </div>
                                </cfoutput>
                            </div>	
                        </cfloop>	
                    </div> 
                    <div class="row justify-content-center">
                        <cfoutput>
                        <input type="hidden" id="u_id" name="tr_id" value="#u_id#">
                        <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                        <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                        <input type="submit" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                        <input type="button" id="skip_btn" class="btn btn-warning" value="#obj_translater.get_translate('btn_note')#">
                        </cfoutput>
                    </div>
                </form>
            
                
                <cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_personality_already_evaluated')#</cfoutput></p>
            </cfif>
        </div>	
    </div>	

=======
<cfinvoke  component="api/ratings/ratings_personality_post" method="ocheck_existingpersonality" returnvariable="existingpersonality" >
    <cfinvokeargument name="u_id" value="#u_id#"> 
    <cfinvokeargument name="tr_id" value="#tr_id#">
</cfinvoke>
            
    <!--- 	<cfdump var="#existingpersonality#" > --->
<div class="card border border-info" style="background-color:#FCFCFC">

    <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
        <h5 class="my-1 text-info" align="center" id="One">  <cfoutput>#obj_translater.get_translate('rating_personality_title')#</cfoutput>
        
        <i class="fa-regular fa-circle-xmark alert text-danger collapse pull-right" id="alert_error_perso" role="alert" title="You have already rated this lesson. Please get in touch to change your vote."></i>
        <i class="fa-regular fa-check alert text-success collapse pull-right" id="alert_success_perso" role="alert" title="Trainer personality sent, thanks!"></i> 
        </h5>	
    </button>
    <div id="collapseOne" class="collapse pb-2 justify-content-center" aria-labelledby="headingOne" data-parent="#accordion">
        <div class="card-body justify-content-center m-auto">
            <cfif existingpersonality.recordCount eq 0>		
                <p class="text-center"><cfoutput>#obj_translater.get_translate('rating_personality_description')#</cfoutput></p>
                <form id="form_trainer_personality" method="POST">
                    <div class="row justify-content-center p-4" >	
                        
                            <cfinvoke component="api/ratings/ratings_personality_get" method="oget_allpersonnalities" returnvariable="get_personality_all">
                                <cfinvokeargument name="tr_id" value="#tr_id#">
                                
                            </cfinvoke>	
                            
                            <cfloop query="get_personality_all"> 
                            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 justify-content-center text-center p-2"  style="height: auto; width: 550px;"> 
                                <cfoutput>
                                    <!--- hidden checkbox --->	
                                    <input type="checkbox" name="perso_input" class="form-check-input cursored" id="perso_check_#perso_id#" value="#perso_id#" style="visibility: hidden">
                                    <!--- perso image ---> 	
                                    <div class="perso_img" id="#perso_id#" title="#perso_name#"> 
                                        <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_personality/#perso_id#_G.svg" variable="perso_#perso_id#"><cfoutput>#Variables["perso_#perso_id#"]#</cfoutput>
                                    </div>
                                    <!--- perso  title --->	
                                    <div class="cursored text-center text-wrap">
                                        <label class="form-check-label d-block" for="#perso_id#"> #perso_name# 
                                            <!--- perso description --->	
                                            <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge float-top" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip_#perso_id#')#</cfoutput>">?
                                            </span>
                                        </label> 
                                    </div>
                                </cfoutput>
                            </div>	
                        </cfloop>	
                    </div> 
                    <div class="row justify-content-center">
                        <cfoutput>
                        <input type="hidden" id="u_id" name="tr_id" value="#u_id#">
                        <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                        <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                        <input type="submit" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                        <input type="button" id="skip_btn" class="btn btn-warning" value="#obj_translater.get_translate('btn_note')#">
                        </cfoutput>
                    </div>
                </form>
            
                
                <cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_personality_already_evaluated')#</cfoutput></p>
            </cfif>
        </div>	
    </div>	
</div>