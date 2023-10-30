<cfif findnocase("common_tp_detail",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_visio.jpg">
<cfelseif findnocase("learner_lessons",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_report.jpg">
<cfelseif findnocase("learner_awards",CGI.SCRIPT_NAME)>
    <cfset back_src = "1000_F_499587977_74icudwrqPqxF26K5U7O9weC1AAnq93g.jpg">
<cfelseif findnocase("learner_sign",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_sign.jpg">
<cfelseif findnocase("common_tp_multi",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_speed.jpg">
<cfelseif findnocase("common_syllabus",CGI.SCRIPT_NAME)>
    <cfset back_src = "header_lms_syllabus.jpg">
</cfif>    

<!--- <cfif listFindNoCase("LEARNER,GUEST,TEST", SESSION.USER_PROFILE)> --->

<cfoutput>
<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/#back_src#'); height:230px; background-position:top right; background-size: cover;">
 
    <div style="width: 100%; height:auto; text-align: center; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="p-2 px-4">
            <div class="w-100 d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0">
                    <strong>E-TRAINING</strong>
                </h5>
                
                <div>
                    <cfif SESSION.USER_ID eq "202" OR SESSION.USER_ID eq "28538">
                    <a class="btn btn-sm my-0 px-1 <cfif findnocase("common_tp_detail",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="common_tp_details2.cfm">
                        <!---<i class="fa-light fa-laptop"></i> --->#obj_translater.get_translate('sidemenu_learner_visio_f2f_tp')#
                    </a>
                    <cfelse>
                    <a class="btn btn-sm my-0 px-1 <cfif findnocase("common_tp_detail",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="common_tp_details.cfm">
                        <!---<i class="fa-light fa-laptop"></i> --->#obj_translater.get_translate('sidemenu_learner_visio_f2f_tp')#
                    </a>
                    </cfif>
    
                    <a class="btn btn-sm my-0 px-1 <cfif findnocase("common_tp_multi",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="common_tp_multi2.cfm">
                        <!---<i class="fa-light fa-calendar"></i> --->#obj_translater.get_translate('card_title_vc_calendar')# / #obj_translater.get_translate('sidemenu_learner_reservation')#
                        <!--- Calendrier / Réservation --->
                    </a>

                    <a class="btn btn-sm my-0 px-1 <cfif findnocase("common_syllabus",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="common_syllabus.cfm">
                        #obj_translater.get_translate('sidemenu_learner_visio_library')#
                    </a>
    
                    <a class="btn btn-sm my-0 px-1 <cfif findnocase("learner_lessons",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="learner_lessons.cfm">
                        <!---<i class="fa-light fa-list "></i> --->#obj_translater.get_translate('sidemenu_learner_activity_report')#
                    </a>

                    <cfif SESSION.PROVIDER_ID eq "1" OR SESSION.PROVIDER_ID eq "3">
                        <cfquery name="get_lesson_not_signed" datasource="#SESSION.BDDSOURCE#">
                        SELECT COUNT(l2.lesson_id) as nb FROM lms_lesson2 l2
                        LEFT JOIN lms_lesson2_attendance lla ON lla.lesson_id = l2.lesson_id
                        WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                        AND (l2.status_id = 4 OR l2.status_id = 5) 
                        AND (l2.lesson_signed = 0 OR (lla.lesson_signed <> 1 OR lla.lesson_signed IS NULL)) 
                        AND (l2.method_id = 1 OR l2.method_id = 2)
                        </cfquery>
                        
                        <!--- <cfif get_lesson_not_signed.nb neq "0"> --->
                            <a class="btn btn-sm my-0 <cfif findnocase("learner_sign",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="learner_sign.cfm">
                                <!---<i class="fa-light fa-spell-check"></i> ---><cfoutput>#obj_translater.get_translate('sidemenu_learner_wait_signature')#</cfoutput> <span class="badge badge-pill badge-warning"><cfoutput>#get_lesson_not_signed.nb#</cfoutput></span>
                            </a>
                        <!--- </cfif> --->
                    </cfif>
    
                    
    
                    <cfif SESSION.USER_ID eq "202" OR SESSION.USER_ID eq "28538">
                    <a class="btn btn-sm my-0 <cfif findnocase("learner_awards",CGI.SCRIPT_NAME)>btn-link text-red border-bottom border-red<cfelse>btn-link text-dark</cfif>" href="learner_awards.cfm">
                         Mes awards
                    </a>
                    </cfif>
                </div>

            </div>
        </div>
    </div>   

</div>
</cfoutput>