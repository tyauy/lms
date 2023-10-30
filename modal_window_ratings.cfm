<cfparam name="l_id" type="numeric">
<cfparam name="u_id" default="#SESSION.USER_ID#">
<cfset get_lesson=obj_query.oget_lesson(l_id="#l_id#" ,u_id="#u_id#" )>
<cfset tr_id=get_lesson.planner_id>

<cfset learner_firstname = get_lesson.learner_firstname>
<cfset learner_lastname = get_lesson.learner_lastname>
<cfset arr = ['learner_firstname','learner_lastname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>


<cfif get_lesson.recordcount neq "0">
    <!--- <cfdump var="#l_id#"> --->
    <cfinvoke component="api/ratings/ratings_get" method="oget_lesson_rating" returnvariable="get_rating">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>	
    <cfinvoke component="api/ratings/ratings_get" method="oget_rating_detail" returnvariable="get_detail">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>	
    
   <!--- <cfinvoke component="api/ratings/ratings_get" method="oget_user_rating" returntype="any" returnvariable="get_rating">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke> --->

    <cfinvoke component="api/ratings/ratings_personality_post" method="ocheck_existingpersonality" returnvariable="existingpersonality">
        <cfinvokeargument name="u_id" value="#u_id#">
            <cfinvokeargument name="tr_id" value="#tr_id#">
    </cfinvoke>

    <cfinvoke component="api/ratings/badges_post" method="ocheck_existingBadge" returnvariable="existingBadge">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>

    <cfinvoke component="api/ratings/badges_get" method="oget_lessontype" returnvariable="get_lesson_type">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>

    <cfinvoke component="api/ratings/ratings_personality_get" method="oget_allpersonnalities" returnvariable="get_personality_all">
        <cfinvokeargument name="tr_id" value="#tr_id#">
    </cfinvoke>

   <cfif listLen(get_lesson_type.level) gt 1>
    <cfloop list="#get_lesson_type.level#" index="currentLevel">
        <cfif isNumeric(currentLevel)>
            <cfset level_id = 10>
           
        </cfif>
    </cfloop>
    <cfelseif isNumeric(get_lesson_type.level)>
        <cfset level_id = get_lesson_type.level>
   
    <cfelse>
        <cfset level_id = 10> <!-- all levels value -->
    </cfif>


    <cfif get_lesson_type.method eq "">
        <cfset method_id=1>
    <cfelse>
        <cfset method_id="#get_lesson_type.method#">
    </cfif>

    <cfinvoke component="api/ratings/badges_get" method="oget_badges_bylesson" returnvariable="badge_id">
        <cfinvokeargument name="level_id" value="#level_id#">
            <cfinvokeargument name="method_id" value="#method_id#">
    </cfinvoke>

    <div>
        <div class="alert bg-light text-dark border justify-content-center" role="alert">
            <div class="media">
                <i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
                <div class="media-body">
                    <cfoutput>#obj_translater.get_translate_complex(id_translate='info_box_ratings', argv="#argv#")#</cfoutput>
                </div>
            </div>
        </div>
    </div>

    <div id="accordion" class="accordion mt-4">

        <!-------------------------------------------------------------->
        <!-------------------EVALUATION GLOBAL-------------------------->
        <!-------------------------------------------------------------->
        <div class="card border border-info">

            <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                <h5 class="my-1 text-info" align="center">
                    <cfoutput>#obj_translater.get_translate('rating_tech_title')#</cfoutput>
                    <i class="fa-regular fa-check text-success collapse pull-right" id="alert_success_tech" role="alert" title="Tech rating sent, thanks!"></i>
                    <i class="fa-regular fa-circle-xmark text-danger collapse pull-right" id="alert_error_tech" role="alert" title="There was an error with your evaluation please get in touch"></i>
                </h5>
            </button>

            <div id="collapseOne" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                <div class="card-body">

                    <div class="row justify-content-center">

                        <div class="col-sm-12 col-md-9">

                            <div class="card border bg-light">
                                <div class="card-body">

                                    <!--- <cfset get_rating = obj_query.oget_rating(l_id)> --->
                                    <cfif get_rating.recordcount eq 0>
                                    <form id="form_global_rating" method="POST">

                                    <!--- <p class="text-center px-3">
                                        <cfoutput>#obj_translater.get_translate('rating_tech_description')#</cfoutput>
                                    </p> --->
                                    <!-- Rating categories -->
                                    <cfset ratingCats=["techno","support", "teaching" ]>
                                    <!-- Loop through the rating categories -->
                                    <cfloop index="i" from="1" to="#arrayLen(ratingCats)#">
                                        <cfoutput>
                                            <div class="text-center w-100 mt-3">
                                                <div class="row justify-content-center mt-2">
                                                    <div class="col-sm-12 col-md-12 col-lg-9">
                                                        <!-- Get the translation for the current rating category -->
                                                        #obj_translater.get_translate('table_th_rating_#ratingCats[i]#')#
                                                        <!-- Show a tooltip with more information -->
                                                        <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_#ratingCats[i]#_tooltip')#</cfoutput>">?</span>
                                                    </div>
                                                </div>
                                                  
                                                <!-- 'Support' Rating Section -->
                                                <cfif i eq 2> <!-- Index 2 corresponds to 'support' in the ratingCats array -->
                                                    <div class="text-center w-100 mt-3">
                                                        <!-- Checkbox to indicate absence of lesson material -->
                                                        <div class="form-check">
                                                            <input class="form-check-input special-checkbox" type="checkbox" value="" id="noSupportMaterial" onClick="toggleSupportRating(this)">

                                                            <label class="form-check-label" for="noSupportMaterial">
                                                             #obj_translater.get_translate('rating_no_lesson_material')# 
                                                           
                                                            </label>
                                                        </div>
                                                    </div>
                                                </cfif>
                                                <div class="row justify-content-center mt-2">
                                                    <div class="col-sm-12 col-md-12 col-lg-9 d-flex justify-content-center #ratingCats[i]# <cfif i eq 2>supportRatingSection</cfif>"  
                                                        >
                                                        <!-- Loop through the smiley images for the current rating category -->
                                                        <cfloop from="1" to="5" index="cor">
                                                            <cfoutput>
                                                                <div id="#ratingCats[i]##cor#" class="p-1 #ratingCats[i]#" name="#ratingCats[i]#" style="max-height: 50px;">
                                                                    <!---       <cffile action="read" file="https://lms.wefitgroup.com/assets/img_smile/#cor#.svg" variable="smiley_#cor#">
                                                                                <cfoutput>#Variables["smiley_#cor#"]#</cfoutput> --->
                                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/#cor#_nb.svg" class="smiley_img cursored" id="#ratingCats[i]#img_#cor#" width="50">
                                                                    <input type="radio" name="note_#ratingCats[i]#" class="form_#ratingCats[i]#" id="input_#ratingCats[i]##cor#" value="#cor#" style="visibility: hidden" required>
                                                                </div>
                                                            </cfoutput>
                                                        </cfloop>
                                                    </div>
                                                </div>
                                            </div>
                                        </cfoutput>
                                    </cfloop>

                                    <div class="mt-2 text-center p-1">
                                        <p>
                                            <cfoutput>#obj_translater.get_translate('table_th_rating_description')#</cfoutput>
                                        </p>
                                    
                                     
                                       
                                        <cfif isDefined("get_detail.rating_description") AND NOT IsNull(get_detail.rating_description)>
                                            <cfoutput>
                                                <textarea id="note_description" name="note_description" class="form-control" rows="3">#get_detail.rating_description#</textarea>
                                            </cfoutput>
                                        <cfelse>
                                            <cfoutput>
                                                <textarea id="note_description" name="note_description" class="form-control" rows="3"></textarea>
                                            </cfoutput>
                                        </cfif>
                                        

                                        <cfoutput>
                                            <input type="hidden" id="u_id_tech" name="u_id" value="#u_id#">
                                            <input type="hidden" id="tr_id_tech" name="tr_id" value="#tr_id#">
                                            <input type="hidden" id="l_id_tech" name="l_id" value="#l_id#">
                                            <input type="submit" id="tech_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                                        </cfoutput>
                                    </div>

                                    </form>
                                    <cfelse>
                                        <p class="text-center p-2">
                                            <cfoutput>#obj_translater.get_translate('rating_tech_already_evaluated')#</cfoutput>
                                        </p>
                                    </cfif>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-------------------------------------------------------------->
        <!-------------------BADGES FORMATEUR--------------------------->
        <!-------------------------------------------------------------->
        <cfif existingBadge.recordCount eq 0>
        <div class="card border border-info" id="div_badge">

            <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                <h5 class="my-1 text-info" align="center">
                <cfoutput>#obj_translater.get_translate('rating_badge_title')#</cfoutput>
                <i class="fa-regular fa-check text-success collapse pull-right" id="alert_success_badge" role="alert" title="Trainer badges sent, thanks!"></i>
                <i class="fa-regular fa-circle-xmark text-danger collapse pull-right" id="alert_error_badge" role="alert" title="There was an error with your evaluation please get in touch"></i>
            </button>

            <div id="collapseTwo" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">

                <div class="card-body justify-content-center m-auto">

                    <div class="row justify-content-center">

                        <div class="col-sm-12 col-md-12 col-lg-9">

                            <div class="card border bg-light">
                                <div class="card-body">

                                    <p class="text-center px-3">
                                        <cfoutput>#obj_translater.get_translate('rating_badge_description')#</cfoutput>
                                    </p>

                                    <form id="form_trainer_badges" method="POST">
                                        <div class="row justify-content-center p-1 mx-auto">
                                            <cfloop query="#badge_id#">
                                                <div class="col-sm-3 justify-content-center">
                                                    <cfoutput>
                                                        <div>
                                                            <!--- hidden checkbox --->
                                                            <input type="checkbox" name="badge_input" class="form-check-input" id="badge_check_badge_#badge_id#" value="#badge_id#" style="visibility: hidden">
                                                            <!--- badge image --->
                                                            <div class="badge_img cursored" id="badge_#badge_id#" title="#badge_name#">
                                                                <cffile action="read" file="https://lms.wefitgroup.com/assets/img_badge/#badge_id#_G.svg" variable="badge_#badge_id#">
                                                                <cfoutput>#Variables["badge_#badge_id#"]#</cfoutput>
                                                            </div>

                                                            <!--- badge title --->
                                                            <!---    <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_smile/EQUAL.svg"> --->
                                                            <div class="cursored text-center text-wrap">
                                                                <label class="form-check-label d-block" for="#badge_id#"> #badge_name#
                                                                    <!--- badge description
                                                                            <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip_#badge_id#')#</cfoutput>">?</span> --->
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </cfoutput>
                                                </div>
                                            </cfloop>
                                        </div>
                                        <div class="row justify-content-center">
                                            <cfoutput>
                                                <input type="hidden" id="u_id" name="u_id" value="#u_id#">
                                                <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                                                <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                                                <a role="button" class="btn btn-link text-danger m-0 mt-1" id="btn_skip_badge">
                                                    [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                                                </a>
                                                <input type="submit" id="badge_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#" disabled>
                                            </cfoutput>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    
                    </div>
                </div>

            </div>
        </div>
        </cfif>

        <!-------------------------------------------------------------->
        <!------------------EVALUATION PERSONALITE FORMATEUR------------>
        <!-------------------------------------------------------------->
        <cfif existingpersonality.recordCount eq 0 AND get_lesson.sessionmaster_id neq "695">
        <div class="card border border-info" id="div_perso" style="background-color:#FCFCFC">

            <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                <h5 class="my-1 text-info" align="center" id="One">
                    <cfoutput>#obj_translater.get_translate('rating_personality_title')#</cfoutput>
                    <i class="fa-regular fa-circle-xmark text-danger collapse pull-right" id="alert_error_perso" role="alert" title="You have already rated this lesson. Please get in touch to change your vote."></i>
                    <i class="fa-regular fa-check text-success collapse pull-right" id="alert_success_perso" role="alert" title="Trainer personality sent, thanks!"></i>
                </h5>
            </button>

            <div id="collapseThree" class="collapse pb-2 justify-content-center" aria-labelledby="headingOne" data-parent="#accordion">

                <div class="card-body justify-content-center m-auto">

                    <div class="row justify-content-center">

                        <div class="col-sm-12 col-md-12 col-lg-9">

                            <div class="card border bg-light">
                                <div class="card-body">

                                    <div class="alert alert-danger text-center collapse" id="alert_error_perso_global" role="alert" title="You have already rated this lesson. Please get in touch to change your vote.">
                                        <cfoutput>#obj_translater.get_translate('alert_notation_error')#</cfoutput>
                                    </div>

                                    <div class="alert alert-success text-center collapse" id="alert_success_perso_global" role="alert" title="Trainer personality sent, thanks!">
                                        <cfoutput>#obj_translater.get_translate('alert_thx_giving_opinion')#</cfoutput>
                                    </div>

                                    <div class="alert alert-danger text-center collapse" id="alert_error_perso_section" role="alert" title="You have already rated this lesson. Please get in touch to change your vote.">
                                        <cfoutput>#obj_translater.get_translate('alert_notation_error')#</cfoutput>
                                    </div>
                                
                                    <div class="alert alert-success text-center collapse" id="alert_success_perso_section" role="alert" title="Trainer personality sent, thanks!">
                                        <cfoutput>#obj_translater.get_translate('alert_note_success')#</cfoutput>
                                    </div>

                                    <!-------------------------------------------------------------->
                                    <!------------------Personality rating-------------------------->
                                    <!-------------------------------------------------------------->
                                    <div class="row d-flex justify-content-center text-center">

                                        <form name="form_trainer_personality" id="form_trainer_personality" method="POST">

                                        <p class="text-center px-3">
                                            <cfoutput>#obj_translater.get_translate('rating_personality_description')#</cfoutput>
                                        </p>

                                        <div class="row justify-content-center p-2 mx-auto">
                                            <cfloop query="get_personality_all">
                                                <div class="col-sm-3 justify-content-center">
                                                    <cfoutput>
                                                        <!--- hidden checkbox --->
                                                        <input type="checkbox" name="perso_input" class="form-check-input cursored" id="perso_check_#perso_id#" value="#perso_id#" style="visibility: hidden">
                                                        <!--- perso image --->
                                                        <div class="perso_img cursored" id="#perso_id#" title="#perso_name#">
                                                            <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_personality/#perso_id#_G.svg" variable="perso_#perso_id#">
                                                            <cfoutput>#Variables["perso_#perso_id#"]#</cfoutput>
                                                        </div>
                                                        <!--- perso  title --->
                                                        <div class="cursored text-center text-wrap mt-2">
                                                            <label class="form-check-label d-block" for="#perso_id#"> #perso_name#
                                                                <!--- perso description --->
                                                                <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge float-top" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#get_personality_all.perso_description#</cfoutput>">?
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
                                                <a role="button" class="btn btn-link text-danger mt-1" id="btn_skip_perso">
                                                    [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                                                </a>
                                                <input type="submit" id="btn_perso" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#" disabled>
                                            </cfoutput>
                                        </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        </cfif>

    </div>

    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_ratings.cfm">

</cfif>