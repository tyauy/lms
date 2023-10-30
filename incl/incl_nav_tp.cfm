<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	<div class="row mb-3 mt-3">		
		
		<div class="col-md-5">
					
			<div class="d-flex">
			<cfoutput>
				<cfif isDefined("u_id") AND u_id neq "" AND u_id neq 0>
				<a class="btn btn-link <cfif findnocase("common_learner",SCRIPT_NAME)>text-red</cfif>" href="common_learner_account.cfm?u_id=#u_id#">
					<div align="center"><i class="fal fa-user fa-2x"></i> <br>#obj_translater.get_translate('table_th_learner')#</div>											
				</a>
				</cfif>

				<a class="btn btn-link <cfif findnocase("common_tp_detail",SCRIPT_NAME)>text-red</cfif>" href="common_tp_details.cfm?u_id=#u_id#<cfif isdefined("t_id")>&t_id=#t_id#</cfif>">
					<div align="center"><i class="fal fa-hiking fa-2x"></i> <br>#obj_translater.get_translate('table_th_tp')#</div>											
				</a>

				<cfif isdefined("t_id")>
				<a class="btn btn-link <cfif findnocase("common_tp_builder",SCRIPT_NAME)>text-red</cfif>" href="common_tp_builder.cfm?t_id=#t_id#&u_id=#u_id#">
					<div align="center"><i class="fal fa-tools fa-2x"></i> <br>Build</div>											
				</a>

				<a class="btn btn-link <cfif findnocase("common_tp_multi",SCRIPT_NAME)>text-red</cfif>" href="common_tp_multi2.cfm?t_id=#t_id#&u_id=#u_id#">
					<div align="center"><i class="fal fa-calendar-alt fa-2x"></i> <br>Speed Book</div>											
				</a>
				</cfif>

				<!--- <cfif u_id eq "11743"
				OR u_id eq "11744"
				OR u_id eq "25911"
				OR u_id eq "25913"
				OR u_id eq "11745"
				OR u_id eq "11746"
				OR u_id eq "11747"
				OR u_id eq "4348"
				OR u_id eq "4841"
				OR u_id eq "7767">

				<cfif isdefined("t_id")>
				<a class="nav-link <cfif findnocase("learner_skill",SCRIPT_NAME)>active text-info</cfif>" href="learner_skill.cfm?t_id=#t_id#&u_id=#u_id#">
					<div align="center"><i class="fal fa-analytics fa-2x"></i> <br><strong>Progression</strong></div>											
				</a>
				</cfif>

				</cfif> --->


				<!---<a class="nav-link disabled" href="learner_sign.cfm?t_id=#t_id#&u_id=#u_id#" role="tab" id="title_VIDEO" style="color:##CCCCCC !important">
					<div align="center"><i class="fal fa-paperclip fa-2x" style="color:##CCCCCC"></i> <br><strong>Administratif</strong></div>											
				</a>--->

				<!---<a class="nav-link btn_view_tuto" href="##" role="tab" id="title_VIDEO">
					<div align="center"><i class="fal fa-hands-helping fa-2x"></i> <br><strong>#obj_translater.get_translate('btn_help')#</strong></div>											
				</a>--->
			</cfoutput>
			</div>
			
		</div>

		<div class="col-md-4">

			<cfif isdefined("t_id")>
			<cfoutput><select class="form form-control" onchange="document.location.href='common_tp_details.cfm?t_id='+this.value+'&u_id=#u_id#'"></cfoutput>
				<cfoutput query="get_tps">
				<option value="#tp_id#" <cfif tp_id eq t_id>selected</cfif>>	
					#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")# [#status_name#]
				</option>
				</cfoutput>
			</select>
			</cfif>
			
		</div>

		<cfif SESSION.USER_PROFILE eq "trainer">
			<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
				<cfinvokeargument name="p_id" value="#SESSION.USER_ID#">
			</cfinvoke>


			<div class="col-md-3">
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
		</cfif>

	</div>
<cfelse>
	<div class="row mb-3 mt-3">	
		<div class="col-md-12">

			<cfif isdefined("t_id") AND get_tps.recordcount gt 1>
			<cfoutput><select class="form form-control" onchange="document.location.href='common_tp_details.cfm?t_id='+this.value+'&u_id=#u_id#'"></cfoutput>
				<cfoutput query="get_tps">
				<option value="#tp_id#" <cfif tp_id eq t_id>selected</cfif>>	
					#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",formation_code="#formation_name#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")# [#status_name#]
				</option>
				</cfoutput>
			</select>
			</cfif>
			
		</div>	
	</div>
	
</cfif>