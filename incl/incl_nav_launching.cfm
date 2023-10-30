<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/header_lms_launching.jpg'); height:230px; background-position:center right; background-size: cover;">
    
    <div class="footer_rounded" style="width:100%; height:auto; text-align: center; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="p-2 px-4">
            <div class="w-100 footer_rounded d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0">
                    <cfoutput>#obj_translater.get_translate('card_title_welcome_board')#</cfoutput>
                </h5>

                <cfif listFindNoCase("LEARNER,GUEST", SESSION.USER_PROFILE)>				
                <div>
                    <a class="btn btn-sm my-0 <cfif isdefined("step") AND step eq "1">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>">
                        <i class="fa-solid fa-circle-1"></i>
                        <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput>
                    </a>
                    <a class="btn btn-sm my-0 <cfif isdefined("step") AND step eq "2">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>">
                        <i class="fa-solid fa-circle-2"></i>
                        <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput>
                    </a>
                    <a class="btn btn-sm my-0 <cfif isdefined("step") AND step eq "3">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>">
                        <i class="fa-solid fa-circle-3"></i>
                        <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput>
                    </a>
                </div>
                <cfelseif listFindNoCase("TEST", SESSION.USER_PROFILE)>	
                    <div>
                        <a class="btn btn-sm my-0 <cfif isdefined("step") AND step eq "1">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>">
                            <i class="fa-solid fa-circle-1"></i>
                            <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput>
                        </a>
                        <a class="btn btn-sm my-0 <cfif isdefined("step") AND step eq "2">btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>">
                            <i class="fa-solid fa-circle-3"></i>
                            <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput>
                        </a>
                    </div>
                </cfif>

            </div>
        </div>
    </div>    
    
</div>