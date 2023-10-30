<cfoutput>
	<div class="sidebar-wrapper">
		<ul class="nav">
			<li <cfif find("index.cfm",SCRIPT_NAME)>class="active"</cfif>>
				<a href="partner_index.cfm<cfif isdefined("a_id")>?a_id=#a_id#</cfif>"><i class="fal fa-home"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
			</li>
	
			<li>
				<a class="btn_add_user"><i class="fa-light fa-square-plus"></i><p>DÉPLOYER APPRENANT</p></a>
			</li>
			
			<li <cfif find("partner_lessons",SCRIPT_NAME) OR find("partner_learners",SCRIPT_NAME)>class="active"</cfif>>
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_tm_activity" href="##menu_tm_activity"><i class="fal fa-clipboard-list"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_activity'))#</p></a>
	
				<div <cfif find("partner_lessons",SCRIPT_NAME) OR find("partner_learners",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_tm_activity">
					<ul>	
						<li style="list-style:none" <cfif find("tm_learners.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="tm_learners.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_learners')#</p></a>
						</li>
						<li style="list-style:none" <cfif find("tm_lessons.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="partner_lessons.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_reports')#</p></a>
						</li>
					</ul>
				</div>
			</li>
			
			<!--- <li <cfif find("partner_admin",SCRIPT_NAME)>class="active"</cfif>>
				<a href="partner_admin.cfm"><i class="fal fa-cabinet-filing"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_admin'))#</p></a>
			</li> --->
			
			<li <cfif find("partner_account",SCRIPT_NAME)>class="active"</cfif>>
				<a href="partner_account.cfm"><i class="fal fa-cogs"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_settings'))#</p></a>
			</li>
	
		 </ul>
	</div>
</cfoutput>