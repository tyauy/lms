<cfif findnocase("learner_eval",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_pic_2.jpg">
<cfelse>
    <cfset back_src = "header_lms_pic_2.jpg">
</cfif>    

<!--- <cfif listFindNoCase("LEARNER,GUEST,TEST", SESSION.USER_PROFILE)> --->

<cfoutput>
<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/#back_src#'); height:230px; background-position:top right; background-size: cover;">
 
    <div style="width: 100%; height:auto; text-align: center; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="p-2 px-4">
            <div class="w-100 d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0">
                    <strong><cfoutput>#ucase(obj_translater.get_translate('title_page_tests'))#</cfoutput></strong>
                </h5>
                
                <div>
                    
                </div>

            </div>
        </div>
    </div>   

</div>
</cfoutput>