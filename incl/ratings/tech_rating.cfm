
<div class="card border border-info cursored label_choice">

    <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        <h5 class="my-1 text-info" align="center">
         <cfoutput>#obj_translater.get_translate('rating_tech_title')#</cfoutput>
        <i class="fa-regular fa-check alert text-success collapse pull-right" id="alert_success_tech" role="alert" title="Tech rating sent, thanks!"></i>
        <i class="fa-regular fa-circle-xmark alert text-danger collapse pull-right" id="alert_error_tech" role="alert"  title="There was an error with your evaluation please get in touch"></i>
        </h5>	
    </button>

    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
        <div class="card-body">
            
            <cfset get_rating = obj_query.oget_rating(l_id)>
            <cfif get_rating.recordcount eq "0">
                <p class="text-center px-3"><cfoutput>#obj_translater.get_translate('rating_tech_description')#</cfoutput></p>
            <form id="form_tech_rating" method="POST"> 
                <table class="table">
                    <tr>
                        <td width="50%"><cfoutput>#obj_translater.get_translate('table_th_rating_support')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip')#</cfoutput>">?</span>
                        </td>
                        <td> <div class="starrr" id="star_support"></div>
                        </td>
                        <td><span class="choice_support" style="display: none;">Note : <span class="choice"></span></span><!--- <input type="hidden" value="<cfoutput>#choice#</cfoutput>"> --->
                        </td>
                    </tr>
                    <tr>
                        <td><cfoutput>#obj_translater.get_translate('table_th_rating_techno')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_techno_tooltip')#</cfoutput>">?</span>
                        </td>
                        <td><div class="starrr" id="star_techno"></div>
                        </td>
                        <td><span class="choice_techno" style="display: none;">Note : <span class="choice"></span></span>
                        </td>
                    </tr>
                    <tr >
                        <td colspan="3">
                            <cfoutput>#obj_translater.get_translate('table_th_rating_description')#</cfoutput>
                            <textarea name="note_description" class="form-control" rows="3"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <cfoutput>
                            <input type="hidden" id="u_id" name="u_id" value="#u_id#">
                            <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                            <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                            <input type="hidden" id="note_support" name="note_support" value="">
                            <input type="hidden" id="note_techno" name="note_techno" value="">
                            <input type="hidden" id="note_description" name="note_description" value="">
                            <input type="submit" id="tech_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                            </cfoutput>
                        </td>
                    </tr>
                </table>
            </form>
            <cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_tech_already_evaluated')#</cfoutput> </p>

            </cfif>
        </div>
    </div>
=======
<div class="card border border-info cursored label_choice">

    <button class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        <h5 class="my-1 text-info" align="center">
         <cfoutput>#obj_translater.get_translate('rating_tech_title')#</cfoutput>
        <i class="fa-regular fa-check alert text-success collapse pull-right" id="alert_success_tech" role="alert" title="Tech rating sent, thanks!"></i>
        <i class="fa-regular fa-circle-xmark alert text-danger collapse pull-right" id="alert_error_tech" role="alert"  title="There was an error with your evaluation please get in touch"></i>
        </h5>	
    </button>

    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
        <div class="card-body">
            
            <cfset get_rating = obj_query.oget_rating(l_id)>
            <cfif get_rating.recordcount eq "0">
                <p class="text-center px-3"><cfoutput>#obj_translater.get_translate('rating_tech_description')#</cfoutput></p>
            <form id="form_tech_rating" method="POST"> 
                <table class="table">
                    <tr>
                        <td width="50%"><cfoutput>#obj_translater.get_translate('table_th_rating_support')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_support_tooltip')#</cfoutput>">?</span>
                        </td>
                        <td> <div class="starrr" id="star_support"></div>
                        </td>
                        <td><span class="choice_support" style="display: none;">Note : <span class="choice"></span></span><!--- <input type="hidden" value="<cfoutput>#choice#</cfoutput>"> --->
                        </td>
                    </tr>
                    <tr>
                        <td><cfoutput>#obj_translater.get_translate('table_th_rating_techno')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('rating_techno_tooltip')#</cfoutput>">?</span>
                        </td>
                        <td><div class="starrr" id="star_techno"></div>
                        </td>
                        <td><span class="choice_techno" style="display: none;">Note : <span class="choice"></span></span>
                        </td>
                    </tr>
                    <tr >
                        <td colspan="3">
                            <cfoutput>#obj_translater.get_translate('table_th_rating_description')#</cfoutput>
                            <textarea name="note_description" class="form-control" rows="3"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <cfoutput>
                            <input type="hidden" id="u_id" name="u_id" value="#u_id#">
                            <input type="hidden" id="tr_id" name="tr_id" value="#tr_id#">
                            <input type="hidden" id="l_id" name="l_id" value="#l_id#">
                            <input type="hidden" id="note_support" name="note_support" value="">
                            <input type="hidden" id="note_techno" name="note_techno" value="">
                            <input type="hidden" id="note_description" name="note_description" value="">
                            <input type="submit" id="tech_btn" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
                            </cfoutput>
                        </td>
                    </tr>
                </table>
            </form>
            <cfelse> <p class="text-center p-2"> <cfoutput>#obj_translater.get_translate('rating_tech_already_evaluated')#</cfoutput> </p>

            </cfif>
        </div>
    </div>

</div>