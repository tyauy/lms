<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
    <div class="row mb-3">		
        
        <div class="col-md-9">
                    
            <div class="d-inline-flex">
            <cfoutput>
                <a class="nav-link <cfif findnocase("common_trainer_account",SCRIPT_NAME)>active text-info</cfif>" href="common_trainer_account.cfm?p_id=#p_id#">
                    <div align="center"><i class="fal fa-user fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_trainer')#</strong></div>											
                </a>
    
                <a class="nav-link <cfif findnocase("common_trainer_blocker",SCRIPT_NAME)>active text-info</cfif>" href="common_trainer_blocker.cfm?p_id=#p_id#<cfif isdefined("t_id")>&t_id=#t_id#</cfif>">
                    <div align="center"><i class="fal fa-calendar-alt fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_calendar')#</strong></div>											
                </a>
    
                <!--- <a class="nav-link <cfif findnocase("common_trainer_avail",SCRIPT_NAME)>active text-info</cfif>" href="common_trainer_avail.cfm?p_id=#p_id#<cfif isdefined("t_id")>&t_id=#t_id#</cfif>">
                    <div align="center"><i class="fal fa-business-time fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_business_hours')#</strong></div>											
                </a> --->
                <!-- weektypes for Krys, Admin, Nina, Douglas, Tom -->
                <cfif SESSION.USER_ISMANAGER eq "1">
                   <!---  <a class="nav-link <cfif findnocase('common_trainer_avail', SCRIPT_NAME)>active text-info</cfif>" href="_EM_weektype.cfm?p_id=#p_id#<cfif isdefined('t_id')>&t_id=#t_id#</cfif>">
                        <div align="center"><i class="fal fa-business-time fa-2x" style="color: red;"></i> <br><strong>#obj_translater.get_translate('btn_business_hours')#2</strong></div>											
                    </a> --->
                    <a class="nav-link <cfif findnocase('common_trainer_businesshours', SCRIPT_NAME) AND isdefined("business_hours_only")>active text-info</cfif>" href="common_trainer_businesshours.cfm?business_hours_only=1&p_id=#p_id#<cfif isdefined('t_id')>&t_id=#t_id#</cfif>">
                        <div align="center"><i class="fal fa-business-time fa-2x"></i> <br><strong>Set #obj_translater.get_translate('btn_business_hours')#</strong></div>											
                    </a>
                    <a class="nav-link <cfif findnocase('common_trainer_businesshours', SCRIPT_NAME) AND not isdefined("business_hours_only")>active text-info</cfif>" href="common_trainer_businesshours.cfm?p_id=#p_id#<cfif isdefined('t_id')>&t_id=#t_id#</cfif>">
                        <div align="center"><i class="fal fa-business-time fa-2x"></i> <br><strong>Create slots</strong></div>											
                    </a>
                    <a class="nav-link <cfif findnocase('common_trainer_vacations', SCRIPT_NAME)>active text-info</cfif>" href="common_trainer_vacations.cfm?p_id=#p_id#<cfif isdefined('t_id')>&t_id=#t_id#</cfif>">
                        <div align="center"><i class="fal fa-plane fa-2x"></i> <br><strong>Vacays</strong></div>											
                    </a>
                </cfif>
                <a class="nav-link <cfif findnocase("common_trainer_learners",SCRIPT_NAME) AND isdefined("view") AND view eq "active">active text-info</cfif>" href="common_trainer_learners.cfm?p_id=#p_id#<cfif isdefined("t_id")>&t_id=#t_id#</cfif>">
                    <div align="center"><i class="fal fa-users-class fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_learners')#</strong></div>											
                </a>

                <a class="nav-link <cfif findnocase("common_trainer_learners",SCRIPT_NAME) AND isdefined("view") AND view eq "inactive">active text-info</cfif>" href="common_trainer_learners.cfm?p_id=#p_id#&view=inactive<cfif isdefined("t_id")>&t_id=#t_id#</cfif>">
                    <div align="center"><i class="fal fa-users-class fa-2x"></i> <br><strong>Inactive</strong></div>											
                </a>
                <cfif listFindNoCase("FINANCE,CS,TRAINERMNG", SESSION.USER_PROFILE)>
                    <a class="nav-link" href="cs_alert_cancel_recap.cfm?p_id=#p_id#">
                        <div align="center"><i class="fal fa-file-text fa-2x"></i> <br><strong>Cancel</strong></div>											
                    </a>
                </cfif>
                <cfif listFindNoCase("FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("SESSION.USER_ISMANAGER") AND SESSION.USER_ISMANAGER eq "1">
                <a class="nav-link <cfif findnocase("common_trainer_invoicing",SCRIPT_NAME)>active text-info</cfif>" href="common_trainer_invoice.cfm?p_id=#p_id#">
                    <div align="center"><i class="fal fa-file-text fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_trainer_invoice')#</strong></div>											
                </a>
                </cfif>
            </cfoutput>
            </div>
            
        </div>
        
        <!--- <cfif SESSION.USER_PROFILE eq "trainer">
            <div class="col-md-4">
                <select id="change_learner" name="change_learner" value="user_id" class="form-control change_learner">
                <cfoutput query="get_learner_trainer" group="user_status_id">
                    <optgroup label="------#user_status_name#------">
                        <cfoutput>
                            <option value="#user_id#" <cfif user_id eq u_id>selected</cfif>>#user_contact#</option>
                        </cfoutput>
                    </optgroup>
                </cfoutput>
                </select>			
            </div>
        </cfif> --->
    
    </div>
        
</cfif>