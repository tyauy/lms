<style>
.badge  .st0 {
    fill: #80BB46; 
        }
.perso > .st0 {
    fill: #933088;
        }
</style>
<cfparam name="l_id">
<cfparam name="u_id" default="#SESSION.USER_ID#">

<cfif isdefined("l_id")>

	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#",u_id="#u_id#")>
    <cfset tr_id = get_lesson.planner_id>	

    <cfinvoke component="api/ratings/ratings_get" method="oget_user_rating" returntype="any" returnvariable="get_rating" >
        <cfinvokeargument name="l_id" value="#l_id#">    
    </cfinvoke>	

    <cfinvoke component="api/ratings/badges_post" method="ocheck_existingBadge" returnvariable="existingBadge">             
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>	

    <cfinvoke component="api/ratings/badges_get" method="oread_badges_bylesson" returnvariable="badge_id">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>	

    <cfinvoke component="api/ratings/ratings_personality_post" method="ocheck_existingpersonality" returnvariable="existingpersonality">
        <cfinvokeargument name="u_id" value="#u_id#">
        <cfinvokeargument name="tr_id" value="#tr_id#">
    </cfinvoke>

    <cfinvoke component="api/ratings/ratings_personality_get" method="oread_trainer_personality" returnvariable="get_personality_trainer">
        <cfinvokeargument name="u_id" value="#u_id#">
        <cfinvokeargument name="tr_id" value="#tr_id#">
    </cfinvoke>


		<cfif get_lesson.recordcount neq "0"> 

				<div id="accordion" class="accordion mt-4">
					
                    <!-------------------------------------------------------------->
                    <!-------------------EVALUATION GLOBAL-------------------------->
                    <!-------------------------------------------------------------->
                    <div class="card border border-info label_choice">

						<button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
							<h5 class="my-1 text-info" align="center">
								<cfoutput>#obj_translater.get_translate('rating_tech_title')#</cfoutput>
							</h5>	
						</button>
					
						<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
							<div class="card-body">
								
								<cfif get_rating.recordcount neq "0">
                                    <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_tech_already_evaluated')#</cfoutput></p>
<!--- 								<form id="form_tech_rating" method="POST">  --->
									<table class="table">
										<tr>
											<td width="50%"><cfoutput>#obj_translater.get_translate('table_th_rating_support')#</cfoutput> <!--- <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip')#</cfoutput>">?</span> --->
											</td>
											<td> <div id="rating_support"></div>
											</td>
                                            <td><cfoutput > #get_rating.rating_support#/5 </cfoutput></td>
											
										</tr>
										<tr>
											<td><cfoutput>#obj_translater.get_translate('table_th_rating_techno')#</cfoutput> <!--- <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_techno_tooltip')#</cfoutput>">?</span> --->
											</td>
											<td><div  id="rating_techno"></div>
                                            </td>
                                            <td><cfoutput > #get_rating.rating_techno#/5 </cfoutput></td>
											
										</tr>
										<tr >
											<td width="50%">
												<cfoutput>#obj_translater.get_translate('card_note_description')#</cfoutput>: 
										
											</td>
                                            <td class="text-justify">  <cfoutput >
                                                    #get_rating.rating_description#
                                            </cfoutput></td>
                                            <td></td>
                                          
										</tr>
									<!--- 	<tr>
											<td colspan="3" align="center">
												<cfoutput>
												<input type="hidden" id="u_id_tech" name="u_id" value="#u_id#">
												<input type="hidden" id="tr_id_tech" name="tr_id" value="#tr_id#">
												<input type="hidden" id="l_id_tech" name="l_id" value="#l_id#">
												<input type="hidden" id="note_support" name="note_support" value="">
												<input type="hidden" id="note_techno" name="note_techno" value="">
												<input type="submit" id="tech_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
												</cfoutput>
											</td>
										</tr> --->
									</table>
<!--- 								</form> --->
								<cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_tech_already_evaluated')#</cfoutput> </p>
					
								</cfif>
							</div>
						</div>
					</div>



                    <!-------------------------------------------------------------->
                    <!-------------------BADGES FORMATEUR--------------------------->
                    <!-------------------------------------------------------------->
	
   
                    <cfif existingBadge.recordCount neq 0>		
                    <div class="card border border-info label_choice">
                        <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            <h5 class="my-1 text-info" align="center">  <cfoutput>#obj_translater.get_translate('rating_badge_title')#</cfoutput>
                            </h5>	
                        </button>
                        
                        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                  
                            <div class="card-body justify-content-center m-auto">
                                <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_badge_already_evaluated')#</cfoutput></p>
<!---                                 <form id="form_trainer_badges" method="POST"> --->
                                    <div class="row justify-content-center p-1 mx-auto" >	
                                        <cfloop query="#badge_id#"> 
                                            <div class="col-sm-3 justify-content-center" style=" max-width:7rem"> 
                                                <cfoutput>
                                                    <div> 
                                                        <!--- hidden checkbox --->	
<!---                                                             <input type="checkbox" name="badge_input" class="form-check-input" id="badge_check_badge_#badge_id#" value="#badge_id#" style="visibility: hidden"> --->
                                                        <!--- badge image ---> 	
                                                            <div class="badge_img" id="badge_#badge_id#" <!---title="#badge_name#"--->> 
                                                                <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_badge/#badge_id#_G.svg" variable="badge_#badge_id#"><cfoutput>#Variables["badge_#badge_id#"]#</cfoutput>
                                                            </div>
                                                        <!--- badge title --->
                                                        <div class="text-center text-wrap">
<!---                                                             <label class="form-check-label d-block" for="#badge_id#">  --->
                                                                #badge_name# 
                                                                    <!--- badge description
                                                                <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip_#badge_id#')#</cfoutput>">?</span> --->	
<!---                                                             </label> --->
                                                        </div>
                                                    </div>
                                                </cfoutput>
                                            </div>	
                                        </cfloop>	
                                    </div> 
                                <!---    <div class="row justify-content-center">
                                        <cfoutput>
                                        <input type="hidden" id="u_id" name="u_id" value="#u_id#">
                                        <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                                        <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                                        <input type="submit" id="badge_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                                        </cfoutput>
                                    </div> --->
<!---                                 </form> --->
                            </div>
                                    <!--- <cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_badge_already_evaluated')#</cfoutput></p> --->
                                
                        </div>
                    </div>
                </cfif>
                    
            

                <!-------------------------------------------------------------->
                <!------------------EVALUATION PERSONALITE FORMATEUR------------>
                <!-------------------------------------------------------------->
                    
                
                <cfif existingpersonality.recordCount neq 0 >		
                        
                <div class="card border border-info" id="div_perso" style="background-color:#FCFCFC">
                
                    <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        <h5 class="my-1 text-info" align="center" id="One">  <cfoutput>#obj_translater.get_translate('rating_personality_title')#</cfoutput>
                                                        
                        </h5>	
                    </button>
                    <div id="collapseOne" class="collapse pb-2 justify-content-center" aria-labelledby="headingOne" data-parent="#accordion">
                        <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_personality_already_evaluated')#</cfoutput></p>
                            

                        <div class="card-body justify-content-center m-auto">
                            
                                
                                    
                            <!-------------------------------------------------------------->
                            <!------------------Smiley global rating section --------------->
                            <!-------------------------------------------------------------->
                            <div class="row d-flex justify-content-center text-center">
                                <div> 
                                    
                                    <cfif get_rating.rating_teaching neq "">


                                        <div> 
                                            <cfoutput>#obj_function.get_thumb_border(user_id="#tr_id#",size="60",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#</cfoutput>
                                        </div>
                                        <div> 
                                            <label> 
                                                <cfoutput>#obj_translater.get_translate('table_th_rating_teaching')#</cfoutput> 
                                                <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_teaching_tooltip')#</cfoutput>">?</span>
                                                    </label>
                                        </div>
                                        
                                        <!--- <form id="form_global_rating" method="POST"> --->
                                        
                                        <div id="globalRating"></div>

                                        <div><cfoutput>#get_rating.rating_teaching#/5</cfoutput></div>
                                            
                                    </cfif>





                                    <!--- 	<cfoutput>
                                        <input type="hidden" id="u_id_global" name="u_id" value="#u_id#">
                                        <input type="hidden" id="tr_id_global" name="tr_id" value="#tr_id#">
                                        <input type="hidden" id="l_id_global" name="l_id" value="#l_id#">
                                        
                                        <input class="btn btn-info" id="global_btn" type="submit" value="#obj_translater.get_translate('btn_note')#">
                                        </cfoutput> --->
                                <!--- 	</form> --->
                                
                                </div>
                            
                            </div>	
                            <!-------------------------------------------------------------->
                            <!------------------Personality rating-------------------------->
                            <!-------------------------------------------------------------->
                            <div class="row d-flex justify-content-center text-center">
                                <!--- <p class="text-center"><cfoutput query="get_badges">##</cfoutput></p> --->
<!---                                 <form id="form_trainer_personality" method="POST"> --->
                                
                                    <div class="row justify-content-center p-4" >	

                                            <cfloop query="get_personality_trainer"> 
                                            <div class="col-sm-3 justify-content-center text-center p-1" style=" max-width:5rem"> 
                                                <cfoutput>
                                                    <!--- hidden checkbox --->	
<!---                                                     <input type="checkbox" name="perso_input" class="form-check-input cursored" id="perso_check_#perso_id#" value="#perso_id#" style="visibility: hidden;"> --->
                                                    <!--- perso image ---> 	
                                                    <div class="perso_img purple" id="#perso_id#" title="#perso_name#" style="max-width:5rem;"> 
                                                        <cffile action="read" file="#SESSION.BO_ROOT#/assets/img_personality/#perso_id#_G.svg" variable="perso_#perso_id#" ><cfoutput>#Variables["perso_#perso_id#"]#</cfoutput>
                                                    </div>
                                                    <!--- perso  title --->	
                                                    <div class="cursored text-center text-wrap p-2" style=" max-width:4rem">
                                                        <label class="form-check-label d-block" for="#perso_id#"> #perso_name# 
                                                            <!--- perso description --->	
                                                            <span style="align-self: center; font-size: .8em;" class="badge badge-primary tooltip_badge float-top" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#get_personality_trainer.perso_description#</cfoutput>">?
                                                            </span>
                                                        </label> 
                                                    </div>
                                                </cfoutput>
                                            </div>	
                                        </cfloop>	
                                    </div> 
                                <!--- 	<div class="row justify-content-center">
                                        <cfoutput>
                                        <input type="hidden" id="u_id" name="tr_id" value="#u_id#">
                                        <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                                        <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                                        <input type="submit" id="btn_perso" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                                        <input type="button" id="btn_skip" class="btn btn-warning" value="#obj_translater.get_translate('btn_skip')#">
                                        </cfoutput>
                                    </div> --->
<!---                                 </form> --->
                            
                                
                                
                            
                        </div>	
                    </div>	
                
                </div>
			    </cfif>
	
		<cfinclude template="./incl/incl_scripts.cfm">


	 </cfif>

</cfif>
<script src="./node_modules/emotion-ratings/dist/emotion-ratings.js"></script> 
<script>

                                        <!-------------------------------------------------->
                                        <!------------ SUPPORT & TECH SIMLEY RATING--------->
                                        <!-------------------------------------------------->

    var emotionsArray = {
    angry: "&#x1F620;",
    disappointed: "&#x1F61E;",
    meh: "&#x1F610;", 
    happy: "&#x1F60A;",
    smile: "&#x1F603;",
    wink: "&#x1F609;",
    laughing: "&#x1F606;",
    good: "&#x1F929;", 
    heart: "&#x2764;",
    crying: "&#x1F622;",
    star: "&#x2B50;",
};
    
    var emotionsArray = ['crying','disappointed','meh','happy','laughing'];
    var rating_support= 0;
    var rating_techno= 0; 
    var note_description ="";

    $("#rating_support").emotionsRating({
        emotions: emotionsArray,
        // background emoji
        bgEmotion: "happy",
        // size of emoji
        emotionSize: 20,

        // number of emoji
        count: 5,

        color: "pink",

        // initial rating value
            initialRating: <cfoutput > #get_rating.rating_support# </cfoutput>,

               /*   console.log("this is the support rating:"+rating_support);
        } //set value changed event handler */
    });
    
    $("#rating_techno").emotionsRating({
        emotions: emotionsArray,
        // background emoji
        bgEmotion: "happy",
        // size of emoji
        emotionSize: 20,

        // number of emoji
        count: 5,

        color: "pink",

        // initial rating value
            initialRating: <cfoutput > #get_rating.rating_techno# </cfoutput>,
            
            /*      console.log("this is the techno rating:"+rating_techno);
        } //set value changed event handler */
    });
 
</script>