<cfoutput>
	<div class="sidebar-wrapper">
        <ul class="nav">
			<li <cfif find("cs_index",SCRIPT_NAME)>class="active"</cfif>>
				<a data-toggle="collapse" role="button" aria-expanded="<cfif find("cs_index",SCRIPT_NAME)>true<cfelse>false</cfif>" aria-controls="menu_cs_91" href="##menu_cs_91"><i class="fa-light fa-c"></i><p>CS</p></a>

				<div <cfif find("cs_index",SCRIPT_NAME) OR find("common_orders_vue",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_91">
				<ul>			

					<li style="list-style:none" <cfif find("cs_index",SCRIPT_NAME)>class="active"</cfif>>
						<a class="my-0 py-0" href="cs_index.cfm"><p>Dashboard</p></a>
					</li>

					<li style="list-style:none">
						<a class="my-0 py-0" href="common_orders_vue.cfm"><p>Order</p></a>
					</li>

					<li style="list-style:none">
						<a class="my-0 py-0" href="cs_certif.cfm"><p>Certif overview</p></a>
					</li>

					<cfif SESSION.USER_ISMANAGER eq 1>
					<li style="list-style:none" <cfif find("common_stats",SCRIPT_NAME)>class="active"</cfif>>
						<a href="common_stats.cfm" class="my-0 py-0"><p>Stats</p></a>
					</li>	
					</cfif>

				</ul>
				</div>

			</li>	

			<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
				<li <cfif find("cs_learners",SCRIPT_NAME) OR find("sales_report",SCRIPT_NAME) OR find("sales_account",SCRIPT_NAME) OR find("sales_tm",SCRIPT_NAME) OR find("sales_index",SCRIPT_NAME)>class="active"</cfif>>
				
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_3" href="##menu_cs_3"><i class="fa-light fa-s"></i><p>SALES</p></a>
	
					<div <cfif find("cs_learners",SCRIPT_NAME) OR find("sales_report",SCRIPT_NAME) OR find("sales_account",SCRIPT_NAME) OR find("sales_index",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_3">
						<ul>
							<li style="list-style:none" <cfif find("sales_index",SCRIPT_NAME)>class="active"</cfif>>
								<a href="sales_index.cfm" class="my-0 py-0"><p>Dashboard</p></a>
							</li>
							<li style="list-style:none">
								<a class="my-0 py-0" href="common_orders_vue.cfm"><p>Order</p></a>
							</li>
							<li style="list-style:none" <cfif find("sales_account",SCRIPT_NAME)>class="active"</cfif>>
								<a href="sales_account.cfm" class="my-0 py-0"><p>Group List</p></a>
							</li>
							<li style="list-style:none" <cfif find("cs_learners",SCRIPT_NAME)>class="active"</cfif>>
								<a href="cs_learners.cfm?pf_id=7&o_by=creation" class="my-0 py-0"><p>Leads List</p></a>
							</li>
							<li style="list-style:none" <cfif find("cs_tms",SCRIPT_NAME)>class="active"</cfif>>
								<a href="sales_tm.cfm" class="my-0 py-0"><p>TM List</p></a>
							</li>		
							<li style="list-style:none" <cfif find("sales_report",SCRIPT_NAME)>class="active"</cfif>>
								<a href="sales_report.cfm" class="my-0 py-0"><p>Reports</p></a>
							</li>	
							<cfif SESSION.USER_ISMANAGER eq 1>
							<li style="list-style:none" <cfif find("common_stats",SCRIPT_NAME)>class="active"</cfif>>
								<a href="common_stats.cfm" class="my-0 py-0"><p>Stats</p></a>
							</li>	
							</cfif>
						</ul>						
					</div>
				</li>
				</cfif>
			
			<li <cfif find("cs_alert_trainer_forgotten",SCRIPT_NAME) OR find("tmg_trainer_search",SCRIPT_NAME) OR find("cs_invoicing",SCRIPT_NAME) OR find("cs_trainer_techno",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_4" href="##menu_cs_4"><i class="fa-light fa-t"></i><p>T MANAGER</p></a>

				<div <cfif find("tmg_trainer_search",SCRIPT_NAME) OR find("cs_invoicing",SCRIPT_NAME) OR find("cs_trainer_techno",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_4">
					<ul>
						<li style="list-style:none" <cfif find("tmg_index",SCRIPT_NAME)>class="active"</cfif>>
							<a href="tmg_index.cfm" class="my-0 py-0"><p>Dashboard</p></a>
						</li>
						<li style="list-style:none">
							<a class="my-0 py-0" href="common_orders_vue.cfm"><p>Order</p></a>
						</li>
						
						<li style="list-style:none">
							<a href="##" class="my-0 py-0 btn_add_trainer"><p>Ajout Trainer</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("cs_trainer",SCRIPT_NAME) AND not isdefined("user_status_id")>class="active"</cfif>>
							<a href="tmg_trainer_search.cfm?view_select=list" class="my-0 py-0"><p>T - Active</p></a>
						</li>
						<li style="list-style:none" <cfif isdefined("user_status_id") AND user_status_id eq "6">class="active"</cfif>>
							<a href="tmg_trainer_search.cfm?user_status_id=6" class="my-0 py-0"><p>T - Training</p></a>
						</li>
						<cfif SESSION.USER_PROFILE_ID eq '12' or SESSION.USER_PROFILE_ID eq '1' or SESSION.USER_PROFILE_ID eq '6'>
							<li style="list-style:none" <cfif isdefined("user_status_id") AND user_status_id eq "3">class="active"</cfif>>
								<a href="tmg_trainer_search.cfm?user_status_id=3" class="my-0 py-0"><p>T - Finalize</p></a>
							</li>
							<li style="list-style:none" <cfif isdefined("user_status_id") AND user_status_id eq "2">class="active"</cfif>>
								<a href="tmg_trainer_search.cfm?user_status_id=2" class="my-0 py-0"><p>T - To check</p></a>
							</li>
							<li style="list-style:none" <cfif isdefined("user_status_id") AND user_status_id eq "1">class="active"</cfif>>
								<a href="tmg_trainer_search.cfm?user_status_id=1" class="my-0 py-0"><p>T - Not completed</p></a>
							</li>
							<li style="list-style:none" <cfif isdefined("user_status_id") AND user_status_id eq "5">class="active"</cfif>>
								<a href="tmg_trainer_search.cfm?user_status_id=5" class="my-0 py-0"><p>T - Inactive</p></a>
							</li>
							<li style="list-style:none" <cfif find("cs_invoicing.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="cs_invoicing.cfm" class="my-0 py-0"><p>Facturation</p></a>
							</li>
							
								<li style="list-style:none" <cfif find("cs_invoicing.cfm",SCRIPT_NAME)>class="active"</cfif>>
									<a href="cs_invoicing.cfm?mode=2" class="my-0 py-0"><p>Facturation Détail</p></a>
								</li>
								<li style="list-style:none" <cfif find("cs_invoicing_yearly",SCRIPT_NAME)>class="active"</cfif>>
									<a href="cs_invoicing_yearly.cfm" class="my-0 py-0"><p>Facturation Total</p></a>
								</li>
							
								
								<li style="list-style:none" <cfif find("cs_alert_trainer_forgotten",SCRIPT_NAME)>class="active"</cfif>>
									<a href="cs_alert_trainer_forgotten.cfm" class="my-0 py-0"><p>Check learners</p></a>
								</li>	
								<li style="list-style:none" <cfif find("cs_trainer_techno",SCRIPT_NAME)>class="active"</cfif>>
								<a href="cs_trainer_techno.cfm" class="my-0 py-0"><p>Trainer Techno</p></a>
							</li>		
								<cfif SESSION.USER_ISMANAGER eq 1>
								<li style="list-style:none" <cfif find("common_stats",SCRIPT_NAME)>class="active"</cfif>>
									<a href="common_stats.cfm" class="my-0 py-0"><p>Stats</p></a>
								</li>

								<li style="list-style:none" <cfif find("tmg_mapping_track.cfm",SCRIPT_NAME)>class="active"</cfif>>
									<a href="tmg_mapping_track.cfm" class="my-0 py-0"><p>Track Mapping </p></a>
								</li>	
								</cfif>
						</cfif>
											
					</ul>						
				</div>
			</li>

			<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
			<li <cfif find("finance_invoice",SCRIPT_NAME) OR find("finance_consumption",SCRIPT_NAME) OR find("finance_stats",SCRIPT_NAME) OR find("common_orders_vue",SCRIPT_NAME) OR find("finance_provider",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_7" href="##menu_cs_145"><i class="fa-light fa-f"></i><p>FINANCE</p></a>

				<div <cfif find("finance_invoice",SCRIPT_NAME) OR find("finance_consumption",SCRIPT_NAME) OR find("finance_stats",SCRIPT_NAME) OR find("common_orders_vue",SCRIPT_NAME) OR find("finance_provider",SCRIPT_NAME)>class="collapsed show"<cfelse>class="collapse"</cfif> id="menu_cs_145">
					<ul>	
						<li style="list-style:none" <cfif find("finance_index",SCRIPT_NAME)>class="active"</cfif>>
							<a href="finance_index.cfm" class="my-0 py-0"><p>Dashboard</p></a>
						</li>	
						<li style="list-style:none">
							<a class="my-0 py-0" href="common_orders_vue.cfm"><p>Order</p></a>
						</li>	
						<li style="list-style:none" <cfif find("finance_stats",SCRIPT_NAME)>class="active"</cfif>>
							<a href="finance_stats.cfm" class="my-0 py-0"><p>TP Stats</p></a>
						</li>	
						<li style="list-style:none" <cfif find("finance_invoice",SCRIPT_NAME)>class="active"</cfif>>
							<a href="finance_invoice.cfm" class="my-0 py-0"><p>Invoice List</p></a>
						</li>
						<li style="list-style:none" <cfif find("finance_consumption",SCRIPT_NAME)>class="active"</cfif>>
							<a href="finance_consumption.cfm" class="my-0 py-0"><p>Consommation</p></a>
						</li>
						<li style="list-style:none" <cfif find("common_orders_export",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_orders_export.cfm" class="my-0 py-0"><p>Order List Export</p></a>
						</li>
						<cfif SESSION.USER_ISMANAGER eq 1>
						<li style="list-style:none" <cfif find("common_stats",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_stats.cfm" class="my-0 py-0"><p>Stats</p></a>
						</li>	
						</cfif>
					</ul>						
				</div>
			</li>
			</cfif>

			<li>
				<a style="border-top:1px solid ##CCCCCC" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_72" href="##menu_cs_72"><i class="fa-light fa-square-plus"></i><p>CR&Eacute;ATION</p></a>

				<div class="collapse" id="menu_cs_72">
					<ul>			

						<li style="list-style:none">
							<a href="##" class="my-0 py-0 btn_add_learner"><p>Ajout User</p></a>
						</li>
						<li style="list-style:none">
							<a href="##" class="my-0 py-0 btn_create_account"><p>Ajout Account</p></a>
						</li>
						<li style="list-style:none">
							<a href="##" class="my-0 py-0 btn_create_group"><p>Ajout Group</p></a>
						</li>
						<li style="list-style:none">
							<a href="##" class="my-0 py-0 btn_new_order"><p>Ajout Order</p></a>
						</li>

					</ul>						
				</div>
			</li>

			<li <cfif find("cs_alert",SCRIPT_NAME) OR find("finance_check_order",SCRIPT_NAME)>class="active"</cfif>>
			
				<a style="border-top:1px solid ##CCCCCC" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_14" href="##menu_cs_14"><i class="fa-light fa-exclamation-triangle"></i><p>ALERTS</p></a>

				<div <cfif find("cs_alert",SCRIPT_NAME) OR find("finance_check_order",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_14">
					<ul>			
						<li style="list-style:none" <cfif find("cs_alert_tp",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_alert_tp.cfm" class="my-0 py-0"><p>TP Cleaner</p></a>
						</li>

						<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
						<li style="list-style:none" <cfif find("cs_alert_deadline",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_alert_deadline.cfm" class="my-0 py-0"><p>TP Deadline</p></a>
						</li>

						<li style="list-style:none" <cfif find("cs_alert_cancel_adv",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_alert_cancel_adv.cfm" class="my-0 py-0"><p>TP ADV Cancel</p></a>
						</li>

						<li style="list-style:none" <cfif find("cs_alert_cancel_recap",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_alert_cancel_recap.cfm" class="my-0 py-0"><p>TP Lesson Cancel</p></a>
						</li>


						<li style="list-style:none" <cfif find("cs_old_data",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_old_data.cfm" class="my-0 py-0"><p>old data</p></a>
						</li>

						<li style="list-style:none" <cfif find("cs_alert_order",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_alert_order.cfm" class="my-0 py-0"><p>ORDER Cleaner</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("finance_check_order",SCRIPT_NAME)>class="active"</cfif>>
							<a href="finance_check_order.cfm" class="my-0 py-0"><p>ORDER Check</p></a>
						</li>
						</cfif>
					</ul>						
				</div>
			</li>

			
			
			<li <cfif find("cs_calendar",SCRIPT_NAME) OR find("cs_list_tp.cfm",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("cs_notation.cfm",SCRIPT_NAME)>class="active"</cfif>>

				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_18" href="##menu_cs_18"><i class="fal fa-graduation-cap"></i><p>FORMATIONS</p></a>

				<div <cfif find("cs_calendar",SCRIPT_NAME) OR find("cs_list_tp.cfm",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("cs_notation.cfm",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_18">
					<ul>			

						<li style="list-style:none" <cfif find("cs_calendar",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_calendar.cfm" class="my-0 py-0"><p>Calendrier</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("cs_list_tp",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cs_list_tp.cfm" class="my-0 py-0"><p>TP Group & Virtual</p></a>
						</li>

						<li style="list-style:none" class="btn_open_syllabus">
							<a class="my-0 py-0"><p>Biblioth&egrave;que New</p></a>
						</li>

						<li style="list-style:none" <cfif find("common_syllabus",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_syllabus.cfm" class="my-0 py-0"><p>Biblioth&egrave;que Old</p></a>
						</li>

						<li style="list-style:none" <cfif find("cs_notation",SCRIPT_NAME) AND isdefined("type") AND type eq "learner">class="active"</cfif>>
							<a href="cs_notation.cfm?type=learner" class="my-0 py-0"><p>Feedback Learner</p></a>
						</li>
						
						<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
						<li style="list-style:none" <cfif find("cs_notation",SCRIPT_NAME) AND isdefined("type") AND type eq "tm">class="active"</cfif>>
							<a href="cs_notation.cfm?type=tm" class="my-0 py-0"><p>Feedback RH</p></a>
						</li>
						</cfif>
					</ul>						
				</div>
			</li>
			
			
			
			
			<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
			<li <cfif find("shop_",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_34" href="##menu_cs_34"><i class="fal fa-store"></i><p>SHOP</p></a>

				<div <cfif find("shop_",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_34">
					<ul>			
						<li style="list-style:none" <cfif find("shop_product_list",SCRIPT_NAME) AND isdefined("show") AND show eq "product">class="active"</cfif>>
							<a href="shop_product_list.cfm?show=product" class="my-0 py-0"><p>Products</p></a>
						</li>
						<li style="list-style:none" <cfif find("shop_product_list",SCRIPT_NAME) AND isdefined("show") AND show eq "coupon">class="active"</cfif>>
							<a href="shop_product_list.cfm?show=coupon" class="my-0 py-0"><p>Coupons</p></a>
						</li>
						<li style="list-style:none" <cfif find("shop_stats",SCRIPT_NAME)>class="active"</cfif>>
							<a href="shop_stats.cfm" class="my-0 py-0"><p>Activité</p></a>
						</li>
						<li style="list-style:none" <cfif find("shop_orders",SCRIPT_NAME)>class="active"</cfif>>
							<a href="shop_orders.cfm" class="my-0 py-0"><p>Commandes</p></a>
						</li>
					</ul>						
				</div>
			</li>
			</cfif>
			
			

			
			
			
			<!---
			202 - ADMIN
			2072 - Krystina
			69 - VG
			3471 - FINANCE
			7435 - SUMMER
			502 - NINA
			139 - PAUL
			151 - DOUGLAS
			7867 - CHARLOTTE
			7211 - ADIDJA
			14714 - MIRZA
			26365 - CARO
			8127 - CINDY
			2586 - TOM
			31313 - ELISA
			6333 - RAPH
			32222 - GREGOR
			10104 - CALIN
			8036 - CLAYTINA
			31260 - DAPHNE

			--->
			
			<cfif SESSION.USER_ID eq "202" 
			OR SESSION.USER_ID eq "2072" 
			OR SESSION.USER_ID eq "69" 
			OR SESSION.USER_ID eq "3471" 
			OR SESSION.USER_ID eq "7435" 
			OR SESSION.USER_ID eq "502" 
			OR SESSION.USER_ID eq "139"
			OR SESSION.USER_ID eq "151"
			OR SESSION.USER_ID eq "7867"
			OR SESSION.USER_ID eq "8127"
			OR SESSION.USER_ID eq "7211"
			OR SESSION.USER_ID eq "14714"
			OR SESSION.USER_ID eq "26365"
			OR SESSION.USER_ID eq "2847"
			OR SESSION.USER_ID eq "2586"  
			OR SESSION.USER_ID eq "29067"
			OR SESSION.USER_ID eq "31313"
			OR SESSION.USER_ID eq "6333"
			OR SESSION.USER_ID eq "32222"
			OR SESSION.USER_ID eq "10104"
			OR SESSION.USER_ID eq "31260"
			OR SESSION.USER_ID eq "27152"
			OR SESSION.USER_ID eq "8036"
			
			>

			<li <cfif find("db_certif",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_53" href="##menu_cs_53"><i class="fa-light fa-file-certificate"></i><p>CERTIF</p></a>

				<div <cfif find("db_certif_list",SCRIPT_NAME) OR find("db_certif_school",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_53">
					<ul>	
								
						<li style="list-style:none" <cfif find("db_certif_list",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_certif_list.cfm" class="my-0 py-0"><p>Edit Code Entry</p></a>
						</li>

						<li style="list-style:none" <cfif find("db_certif_school_2",SCRIPT_NAME) AND isdefined("view") AND view eq "list">class="active"</cfif>>
							<a href="db_certif_school_2.cfm?view=list&tss_id=SENT" class="my-0 py-0"><p>Sessions Mng</p></a>
						</li>

						<li style="list-style:none" <cfif find("db_certif_school.cfm",SCRIPT_NAME) AND isdefined("view") AND view eq "list">class="active"</cfif>>
							<a href="db_certif_school.cfm?view=list&tss_id=SENT" class="my-0 py-0"><p>Sessions list</p></a>
						</li>

						<li style="list-style:none" <cfif find("db_certif_school",SCRIPT_NAME) AND isdefined("view") AND view eq "calendar">class="active"</cfif>>
							<a href="db_certif_school.cfm?view=calendar" class="my-0 py-0"><p>Sessions Calendar</p></a>
						</li>

						<li  style="list-style:none"  <cfif find("cm_database",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cm_database.cfm" class="my-0 py-0">
								<p>
									<!--- #ucase(obj_translater.get_translate('sidemenu_trainer_account'))# --->
									Collaborateurs
								</p>
							</a>
						</li>
					</ul>
				</div>

			</li>


			<li <cfif find("db_",SCRIPT_NAME) AND not find("db_certif_school",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_5" href="##menu_cs_5"><i class="fal fa-database"></i><p>ADMIN</p></a>

				<div <cfif find("db_",SCRIPT_NAME) OR find("quiz_list",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_5">
					<ul>		
						<li style="list-style:none" <cfif find("db_mappingperquestion.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_mappingperquestion.cfm" class="my-0 py-0"><p>Quiz Question Map</p></a>
						</li>	
						<li style="list-style:none" <cfif find("db_tppack_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_tppack_list.cfm" class="my-0 py-0"><p>Edit Catalog</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_syllabus_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_syllabus_list.cfm" class="my-0 py-0"><p>Edit Resource</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_mapping_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_mapping_list.cfm" class="my-0 py-0"><p>See Mapping</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_mapping_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_mapping_list_edit.cfm" class="my-0 py-0"><p>Edit Mapping</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_module_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_module_list.cfm" class="my-0 py-0"><p>Edit Module</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_tpprefilled_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_tpprefilled_list.cfm" class="my-0 py-0"><p>Edit Pre-filled</p></a>
						</li>						
						<li style="list-style:none" <cfif find("db_quiz_list",SCRIPT_NAME) OR find("db_quiz_edit",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_quiz_list.cfm" class="my-0 py-0"><p>Edit Quiz</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_vocab_list",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_vocab_list.cfm" class="my-0 py-0"><p>Edit Vocab List</p></a>
						</li>
						<li style="list-style:none" <cfif find("db_updater_vocab",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_updater_vocab.cfm" class="my-0 py-0"><p>Import Vocab audio</p></a>
						</li>
						
						
						
						<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME)>class="active"</cfif>>
				
							<a data-toggle="collapse" role="button" <cfif find("db_translate_list",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_translation" href="##menu_learner_translation" class="my-0 py-0"><p>+ Edit Translation</p></a>

							<div <cfif find("db_translate_list",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_translation">
								<ul>
									<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME) AND (isdefined("t_cat") AND t_cat eq "short")>class="active"</cfif>>
										<a href="db_translate_list.cfm?view=short" class="my-0 py-0"><p>Short</p></a>
									</li>
									<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME) AND (isdefined("t_cat") AND t_cat eq "long")>class="active"</cfif>>
										<a href="db_translate_list.cfm?view=long" class="my-0 py-0"><p>Complex</p></a>
									</li>
								</ul>
							</div>
						
						</li>
						
						<li style="list-style:none" <cfif find("db_calendar_settings.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_calendar_settings.cfm" class="my-0 py-0"><p>Edit Calendar View</p></a>
						</li>

						<li style="list-style:none" <cfif find("db_task_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_task_list.cfm" class="my-0 py-0"><p>Edit Tasks</p></a>
						</li>

						<li style="list-style:none" <cfif find("common_order_check",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_order_check.cfm" class="my-0 py-0"><p>Order check</p></a>
						</li>					
					</ul>						
				</div>
			</li>

			<cfelse>

			<li <cfif find("db_",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_5" href="##menu_cs_5"><i class="fal fa-database"></i><p>ADMIN</p></a>

				<div <cfif find("db_",SCRIPT_NAME) OR find("quiz_list",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_5">
					<ul>			
						<li style="list-style:none" <cfif find("db_vocab_list",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_vocab_list.cfm" class="my-0 py-0"><p>Edit Vocab List</p></a>
						</li>
						<!--- <li style="list-style:none" <cfif find("db_updater_vocab",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_updater_vocab.cfm" class="my-0 py-0"><p>Import Vocab audio</p></a>
						</li> --->
						<cfif !(SESSION.USER_PROFILE_ID eq '12' AND SESSION.USER_ISMANAGER neq 1)>
						<li style="list-style:none" <cfif find("db_certif_list",SCRIPT_NAME)>class="active"</cfif>>
							<a href="db_certif_list.cfm" class="my-0 py-0"><p>Edit Token</p></a>
						</li>
						</cfif>
					</ul>
				</div>
			</li>

			</cfif>

			<!--- <li <cfif find("learner_virtual",SCRIPT_NAME) OR find("learner_index",SCRIPT_NAME)>class="active"</cfif>>
			
				<a style="border-top:1px solid ##CCCCCC" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_vc" href="##menu_cs_vc"><i class="fal fa-users-viewfinder"></i><p>VIRTUAL CLASS</p></a>

				<div <cfif find("learner_virtual",SCRIPT_NAME) OR find("learner_index",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_vc">
					<ul>		
						<li style="list-style:none" <cfif find("learner_index",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_index.cfm" class="my-0 py-0"><p>Homepage</p></a>
						</li>
						<li style="list-style:none" <cfif find("learner_virtual",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_virtual.cfm" class="my-0 py-0"><p>VC</p></a>
						</li>
						<li style="list-style:none" <cfif find("learner_virtual",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_virtual.cfm" class="my-0 py-0"><p>VC NEW</p></a>
						</li>
					</ul>						
				</div>
			</li> --->


			<li 
			<cfif find("learner_virtual",SCRIPT_NAME) 
			OR find("common_tp_details2",SCRIPT_NAME) 
			OR find("el_dashboard",SCRIPT_NAME)>
			class="active"</cfif>>
				
				<a data-toggle="collapse" role="button" 
				<cfif find("learner_virtual",SCRIPT_NAME) 
				OR find("common_tp_details2",SCRIPT_NAME) 
				OR find("el_dashboard",SCRIPT_NAME)>
				aria-expanded="true"
				<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_el" href="##menu_learner_el">
					<i class="fa-light fa-n"></i><p>NEW</p>
				</a>

				<div 
				<cfif find("learner_virtual",SCRIPT_NAME) 
				OR find("common_tp_details2",SCRIPT_NAME) 
				OR find("el_dashboard",SCRIPT_NAME)>
				class="collapse show"
			<cfelse>class="collapse"</cfif> id="menu_learner_el">
					<ul>	
						
						<li style="list-style:none" <cfif find("el_dashboard2",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/el_dashboard.cfm" class="my-0 py-0"><p>NEW EL</p></a>
						</li>

						<li style="list-style:none" <cfif find("learner_virtual",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/learner_virtual.cfm" class="my-0 py-0"><p>VC</p></a>
						</li>

						<li style="list-style:none" <cfif find("common_tp_details2",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/common_tp_details2.cfm" class="my-0 py-0"><p>NEW VISIO</p></a>
						</li>


						
						<!--- <li style="list-style:none" <cfif find("learner_index3",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/learner_index3.cfm" class="my-0 py-0"><p>HP 3</p></a>
						</li>

						<li style="list-style:none" <cfif find("learner_index4",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/learner_index4.cfm" class="my-0 py-0"><p>HP 4</p></a>
						</li>

						<li style="list-style:none" <cfif find("learner_index5",SCRIPT_NAME)>class="active"</cfif>>
							<a href="https://lms.wefitgroup.com/learner_index5.cfm" class="my-0 py-0"><p>HP 5</p></a>
						</li> --->

					</ul>
				</div>
			</li>


			<!--- <li <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="active"</cfif>>
				
				<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_el" href="##menu_learner_el"><i class="fal fa-phone-laptop"></i><p>E-LEARNING</p></a>

				<div <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_el">
					<ul>	
						
						<li style="list-style:none">
							<a href="https://lms.wefitgroup.com/el_dashboard2.cfm" class="my-0 py-0"><p>NEW EL</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_practice.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_myeprogram')#</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "email")>class="active"</cfif>>
							<a href="common_tools.cfm?subm=email" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_email_template')#</p></a>
						</li>

						<!--- <li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>> --->
							<!--- <a href="common_tools.cfm?subm=vocabulary" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list')#</p></a> --->
						<!--- </li> --->
						
						<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="active"</cfif>>
			
							<a data-toggle="collapse" role="button" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_vocabulary" href="##menu_learner_vocabulary" class="my-0 py-0"><p>+ #obj_translater.get_translate('sidemenu_learner_vocab')#</p></a>

							<div <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_vocabulary">
								<ul>
									<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>>
										<a href="elearning_vocab.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_theme')#</p></a>
									</li>
									<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary_perso")>class="active"</cfif>>
										<a href="elearning_vocab_perso.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list_perso')#</p></a>
									</li>
								</ul>
							</div>
						
						</li>
						
						
					</ul>						
				</div>
				
			</li> --->

			<cfif SESSION.USER_ISMANAGER eq 1>

				<li <cfif find("tm_lessons.cfm",SCRIPT_NAME) OR find("tm_learners",SCRIPT_NAME) OR find("tm_alert",SCRIPT_NAME)>class="active"</cfif>>
					<a style="border-top:1px solid ##CCCCCC" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_tm_activity" href="##menu_tm_activity"><i class="fal fa-clipboard-list"></i><p>TM</p></a>
	
					<div <cfif find("tm_lessons",SCRIPT_NAME) OR find("tm_learners",SCRIPT_NAME) OR find("tm_alert",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_tm_activity">
						<ul>	
							<!--- <li style="list-style:none" <cfif find("tm_admin.cfm",SCRIPT_NAME)>class="active"</cfif>> --->
								<!--- <a href="tm_admin.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_orders')#</p></a> --->
							<!--- </li> --->
							<li style="list-style:none" <cfif find("tm_learners.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="tm_learners.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_learners')#</p></a>
							</li>
							<li style="list-style:none" <cfif find("tm_lessons.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="tm_lessons.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_reports')#</p></a>
							</li>
							<li style="list-style:none" <cfif find("tm_admin.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="tm_admin.cfm" class="my-0 py-0"><p>#(obj_translater.get_translate('table_th_training_records'))#</p></a>
							</li>
							<li style="list-style:none" <cfif find("tm_admin_learners",SCRIPT_NAME)>class="active"</cfif>>
								<a href="tm_admin_learners.cfm" class="my-0 py-0"><p>#(obj_translater.get_translate('sidemenu_tm_gestion'))#</p></a>
							</li>
						</ul>
					</div>
				</li>
	
			</cfif>
			

         </ul>
	</div>
</cfoutput>