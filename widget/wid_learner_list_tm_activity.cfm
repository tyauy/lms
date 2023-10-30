<cfoutput>

	<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT u.*
		FROM user u
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	</cfquery>
	

	<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",group=1)>
	<cfset _lg_rep = "">

	<cfloop query="get_pt">

		<cfif get_pt.quiz_global_score eq "">

			<!--- <p>Hello ##</p> --->
			<cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
				<cfinvokeargument name="u_id" value="#u_id#">
				<cfinvokeargument name="quiz_user_group_id" value="#get_pt.quiz_user_group_id#">
			</cfinvoke>

			<cfset reload_pt = true>
		</cfif>

	</cfloop>

	<cfif isDefined("reload_pt")>
		<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",group=1)>
	</cfif>

	<div class="row">
		<div class="col-md-12">
			<div class="card border">
				<cfloop query="get_pt">
					<cfif quiz_user_group_id neq "">
					<div class="d-flex align-items-center">
						<div class="m-2">
							<img src="./assets/img/training_#lCase(get_pt.formation_code)#.png" width="50"></span>
						</div>
						<div class="m-2">
							#obj_dater.get_dateformat(get_pt.quiz_user_start)#
						</div>
						<div class="m-2">
							<cfif pt_speed eq "fpt">
								<!--- FULL PLACEMENT TEST --->
								<span style="text-transform:uppercase">#obj_translater.get_translate('text_full_placement_test')#</span>
								<cfif get_pt.type eq "start">
									<br>
									#obj_translater.get_translate('text_start_level')#
									<!--- (Start level) --->
								<cfelseif get_pt.type eq "end">
									<br>
									#obj_translater.get_translate('text_end_level')#
									<!--- (End level) --->
								</cfif>
							<cfelseif get_pt.pt_speed eq "qpt">
								<!--- QUICK PLACEMENT TEST --->
								<span style="text-transform:uppercase">#obj_translater.get_translate('text_quick_placement_test')#</span>
							</cfif>
						</div>
						<div class="m-2">
							<cfset _lg_rep = listAppend(_lg_rep, formation_code)>
							<cfinclude template="../incl/incl_pt_result.cfm">
						</div>																	
					</div>
					</cfif>
				</cfloop>
			</div>
		</div>
	</div>
	<cfloop list="#SESSION.LIST_PT#" index="lang_select">
		<cfif not listFindNoCase(_lg_rep, lang_select)>
			<cfif evaluate("get_user.user_qpt_#lang_select#") neq "" AND (evaluate("get_user.user_qpt_lock_#lang_select#") eq "0" OR evaluate("get_user.user_qpt_lock_#lang_select#") eq "")>
				<div class="row">
					<div class="col-md-12">
						<div class="card border">
								<cfif findnocase("A0",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "success">
								<cfelseif findnocase("A1",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "success">
								<cfelseif findnocase("A2",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "primary">
								<cfelseif findnocase("B1",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "info">
								<cfelseif findnocase("B2",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "warning">
								<cfelseif findnocase("C1",evaluate("get_user.user_qpt_#lang_select#"))>
									<cfset css = "danger">
								</cfif>
								<div class="d-flex align-items-center">
									<div class="m-2">
										<img src="./assets/img_formation/#lang_select#.png" width="50"></span>
									</div>
									<div class="m-2">
										#obj_translater.get_translate('text_not_verified')#
									</div>
									<div class="m-2">
										<a class="badge badge-#css# badge-pill p-3 mt-2 font-weight-normal text-white" style="font-size:14px">
											#obj_translater.get_translate('table_th_global_level')#
										<br>
										<h6 class="mt-1 mb-0">#evaluate("get_user.user_qpt_#lang_select#")#</h6>
										</a>
									</div>																			
								</div>
						</div>
					</div>
				</div>
			</cfif>
		</cfif>
	</cfloop>
	
	</cfoutput>