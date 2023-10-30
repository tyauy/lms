<ul class="nav nav-tabs" role="tablist" id="tabs_account">
	<li class="nav-item" id="title_account"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "account">active</cfif>" href="#account" aria-controls="account" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('resume')#</cfoutput></a></li>
	<li class="nav-item" id="title_contact"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "contact">active</cfif>" href="#contact" aria-controls="contact" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('contacts')#</cfoutput></a></li>
	<li class="nav-item" id="title_learners"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "learner">active</cfif>" href="#learner" aria-controls="learner" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('table_th_learners')#</cfoutput></a></li>
	<li class="nav-item" id="title_order"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "order">active</cfif>" href="#order" aria-controls="order" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('sidemenu_tm_orders')#</cfoutput></a></li>
	<li class="nav-item" id="title_coordonnee"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "coordonnee">active</cfif>" href="#coordonnee" aria-controls="coordonnee" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('table_th_coordinates')#</cfoutput></a></li>
	<!--- <li class="nav-item" id="title_activite"><a class="nav-link <cfif isdefined("view_tab") AND view_tab eq "sales">active</cfif>" href="#sales" aria-controls="sales" role="tab" data-toggle="tab"><cfoutput>#obj_translater.get_translate('sidemenu_tm_activity')#</cfoutput></a></li> --->
</ul>

<div class="tab-content" style="margin-top:20px">

	<div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "account">show active</cfif>" id="account">
		
		<div class="row" style="margin-top:10px">
			<cfoutput query="get_account">
			<div class="col-md-2">
				<div class="row">
					<div class="col-md-12">	
						
						
						<div class="card">
							<!--- <div class="card-header">
								<h6 class="card-title d-inline">Account</h6>
								
							</div> --->
							<div class="card-body">
								<table class="table table-sm">									
									<tr>
										<td colspan="2">
											<h6 class="d-inline">#account_name#</h6>

											<div class="float-right">
											<a class="btn-link btn_edit_account text-dark" href="##" id="a_#account_id#"><i class="fal fa-edit"></i></a>
											<!--- <a class="btn-link btn_del_account text-dark" href="##" id="a_#account_id#"><i class="far fa-trash-alt"></i></a> --->
											<cfif vtiger_id neq "">
											<a href="http://wefitcrm.redstratus.com/index.php?module=Accounts&view=Detail&record=#vtiger_id#" target="_blank" class="btn btn-sm btn-info pull-right"><img src="./assets/img/logo_vtiger.png" width="80"></a>
											</cfif>
											</div>
											
										</td>
									</tr>
									<tr>
										<td><label>Manager</label><br><span class="badge text-white" style="background-color:###account_manager_color#; font-size:14px">#account_manager#</span></td>
										<td><label>Owner</label><br><span class="badge text-white" style="background-color:###account_owner_color#; font-size:14px">#account_owner#</span></td>
									</tr>
									<tr>
										<td colspan="2"><label>Type</label><br><span class="badge text-white bg-#type_css#" style="font-size:14px">#type_name#</span></td>
									</tr>
									<tr>
										<td colspan="2"><label>Provider</label><br><img src="./assets/img/training_#provider_code#.png" width="22"> #provider_name#</td>
									</tr>

									


									<!--- <tr> --->
										<!--- <td><label>Taille</label></td> --->
										<!--- <td>#size_name#</td> --->
									<!--- </tr> --->
									<!--- <tr> --->
										<!--- <td><label>Secteur</label></td> --->
										<!--- <td>#sector_name#</td> --->
									<!--- </tr> --->
									<!--- <tr> --->
										<!--- <td><label>T&eacute;l standard</label></td> --->
										<!--- <td>#account_phone#</td> --->
									<!--- </tr> --->
									<!--- <tr> --->
										<!--- <td><label>Provenance</label></td> --->
										<!--- <td>#account_provenance#</td> --->
									<!--- </tr> --->
									<!--- <tr> --->
										<!--- <td><label>Site web</label></td> --->
										<!--- <td>#account_site#</td> --->
									<!--- </tr> --->
									<!--- <tr> --->
										<!--- <td><label>#obj_translater.get_translate('table_th_course_description')#</label></td> --->
										<!--- <td>#account_details_1#</td> --->
									<!--- </tr> --->
								</table>
							</div>
						</div>
						
						<div class="card">
							<div class="card-header">
								<h6 class="card-title d-inline">Activité eLearning</h6>
								<br><br>
								<a class="btn btn-info" href="cs_elearning.cfm?g_id=#group_id#"><i class="fal fa-laptop"></i> RAPPORT EL</a>
								
							</div>
						</div>

						
						
						
						<div class="card">
							<div class="card-header">
								<h6 class="card-title d-inline">Grille tarifaire Groupe</h6>
								<cfif get_price_unit.recordcount neq "0"><a class="btn btn-sm btn-default btn_edit_price" href="##" id="a_#account_id#"><i class="fal fa-table"></i></a></cfif>
								<!--- <a class="btn btn-sm btn-default btn_del_account" href="##" id="a_#account_id#"><i class="far fa-trash-alt"></i></a> --->
							</div>
							
							<div class="card-body">
							
								<cfif get_price_unit.recordcount neq "0">
								<table class="table bg-white">
									<tr>
										<th class="bg-light" width="30%">Partner</th>
										<td class="bg-white"><cfoutput>#group_hash# <cfif provider_id eq "2"><a href="https://formation.wefitgroup.com/partner-de/#group_hash#">[link]</a><cfelse><a href="https://cpf.wefitgroup.com/partner/#group_hash#">[link]</a></cfif></cfoutput></td>
									</tr>
									<cfif get_price_unit.price_reduction neq "0">
									<tr>
										<th class="bg-light" width="30%">Catalogue</th>
										<td class="bg-white">-<cfoutput>#get_price_unit.price_reduction#</cfoutput> % sur prix public</td>
									</tr>
									</cfif>		
									
										<cfoutput>
											<cfloop list="#list_formation#" index="cor">
											<cfquery name="get_formation_solo" datasource="#SESSION.BDDSOURCE#">
											SELECT formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
											</cfquery>
												<cfset col = evaluate("get_price_unit.price_#cor#")>
												<tr>
													<th class="bg-light"><span class="lang-sm" lang="#get_formation_solo.formation_code#"></span> <!---#get_formation_solo.formation_name#---></th>
													<td class="bg-white">#numberformat(col,'____')# &euro;</td>
												</tr>	
											</cfloop>
										</cfoutput>
									
								</table>
								<cfelse>
									<a href="crm_account_edit.cfm?a_id=#a_id#&create_price=1" class="btn btn-info">CREER GRILLE</a>
								</cfif>
							</div>	
							
						</div>
					</div>
					
				</div>
					
				<!--- <div class="row"> --->
					<!--- <div class="col-md-12">	 --->
						<!--- <cfinclude template="../calendar/crm_calendar.cfm">		 --->
					<!--- </div> --->
					
				<!--- </div>		 --->
			</div>		
			</cfoutput>
			
			
			<div class="col-md-10">
				
				
				<div class="card">
					<div class="card-header"></div>
						<div class="card-body">
								
							<div id="accordion">
							
								<div>
									<cfoutput>
									<div class="media">
										<cfif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.jpg")>
											<img src="./assets/img_group/#group_id#.jpg" class="align-self-center mr-3" height="100">
											
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.jpeg")>
											<img src="./assets/img_group/#group_id#.jpeg" class="align-self-center mr-3" height="100">
											
										<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_group/#group_id#.png")>
											<img src="./assets/img_group/#group_id#.png" class="align-self-center mr-3" height="100">
											
										</cfif>
										<div class="media-body">
											<button class="btn btn-secondary btn_edit_group btn-lg btn-block" id="g_#group_id#_#a_id#">
											#group_name# <span class="badge badge-light" style="font-size:14px"> #get_account_group.recordcount# <span>
											<!--- <a class="btn btn-sm float-right m-0 btn-secondary" href="#"><i class="fal fa-plus-circle"></i></a> --->
											</button>
										</div>
									  </div>
									</cfoutput>
									
								</div>
								
								<div id="accounts" class="mt-2">
								<cfinclude template="wid_group_select.cfm">
								</div>
								
								<div>
									<button class="btn btn-outline-primary btn-block text-left" data-toggle="collapse" data-target="#contacts">
									<span style="font-size:14px"><i class="fa-light fa-address-book fa-lg mr-2"></i> Contacts CRM (Conv / Factu) <span class="badge badge-primary" style="font-size:14px"><cfoutput> #get_contact.recordcount# </cfoutput></span></span>
									<a class="btn btn-sm float-right m-0 btn-primary btn_create_ctc" href="#"><i class="fal fa-plus-circle"></i></a>
									</button>
								</div>
								
								<div id="contacts" class="collapse" data-parent="#accordion">
									<cfoutput>
										<a class="btn btn-sm btn_create_ctc float-right mb-3 btn-primary" href="##" id="ctc_#account_id#"><i class="fal fa-plus-circle"></i> Créer contact CRM </a>
									</cfoutput>
									<cfinclude template="wid_contact_select.cfm">
								
								</div>

								
								
								
								
								<!--- <div>
									<button class="btn btn-warning btn-block text-left" data-toggle="collapse" data-target="#todo">
									<span style="font-size:14px"><i class="fal fa-tasks fa-lg mr-2"></i> TO DO & FEEDBACK <span class="badge badge-light" style="font-size:14px">xxx</span></span>
									<a class="btn btn-sm btn-warning btn_create_task float-right m-0" href="#"><i class="fal fa-plus-circle"></i></a>
									</button>
								</div>
								
								<div id="todo" class="collapse" data-parent="#accordion">
								<cfoutput>
								#account_id# // #g_id#
								</cfoutput>
								<!--- <cfinclude template="../modal_window_log.cfm"> --->
								<br>
								</div> --->
								
								<!--- <div> --->
									<!--- <button class="btn btn-warning btn-block text-left" data-toggle="collapse" data-target="#tasks"> --->
									<!--- <span style="font-size:14px"><i class="fal fa-tasks fa-lg mr-2"></i> Tasks <span class="badge badge-light" style="font-size:14px"><cfoutput> #get_tasks.recordcount# </cfoutput></span></span> --->
									<!--- <a class="btn btn-sm btn-warning btn_create_task float-right m-0" href="#"><i class="fal fa-plus-circle"></i></a> --->
									<!--- </button> --->
								<!--- </div> --->
								
								<!--- <div id="tasks" class="collapse" data-parent="#accordion"> --->
								<!--- <cfinclude template="wid_task_select.cfm"> --->
								<!--- </div> --->
								
								<!--- <div> --->
									<!--- <button class="btn btn-success btn-block text-left" data-toggle="collapse" data-target="#opports"> --->
									<!--- <span style="font-size:14px"><i class="fal fa-comment-dollar fa-lg mr-2"></i> Opports <span class="badge badge-light" style="font-size:14px"><cfoutput> #get_opport.recordcount# </cfoutput></span></span> --->
									<!--- <a class="btn btn-sm btn-success btn_create_opport float-right m-0" href="#"><i class="fal fa-plus-circle"></i></a> --->
									<!--- </button> --->
								<!--- </div> --->
								
								<!--- <div id="opports" class="collapse" data-parent="#accordion"> --->
								<!--- <cfinclude template="wid_opport_select.cfm"> --->
								<!--- </div> --->
								
								<div>
									<button class="btn btn-outline-danger btn-block text-left" data-toggle="collapse" data-target="#orders">
									<span style="font-size:14px"><i class="fa-light fa-cart-plus fa-lg mr-2"></i> Orders <span class="badge badge-danger" style="font-size:14px"><cfoutput> <cfif get_orders.recordcount eq "10">> 10<cfelse>#get_orders.recordcount#</cfif></cfoutput></span></span>
									<a class="btn btn-sm btn-danger btn_new_order  float-right m-0" href="#"><i class="fal fa-plus-circle"></i></a>
									</button>
								</div>
								
								<div id="orders" class="collapse" data-parent="#accordion">
								<cfset view_order = "compact">
								<cfoutput>
									<a class="btn btn-sm btn_new_order float-right mb-3 btn-danger" href="##" id="ctc_#account_id#"><i class="fal fa-plus-circle"></i> Créer Order </a>
								</cfoutput>							
								<cfinclude template="wid_order_list.cfm">								
								</div>

								<div>
									<button class="btn btn-outline-info btn-block  text-left" data-toggle="collapse" data-target="#tm">
									<span style="font-size:14px"><i class="fa-light fa-address-book fa-lg mr-2"></i> TMS / SCHOOL MANAGER <span class="badge badge-info" style="font-size:14px"><cfoutput> #get_user_account_tm.recordcount# </cfoutput></span></span>
									<a class="btn btn-sm float-right m-0 btn-info btn_add_tm" href="#"><i class="fal fa-plus-circle"></i></a>
									</button>
								</div>

								<div id="tm" class="collapse" data-parent="#accordion">
									<cfoutput>
										<a class="btn btn-sm btn_add_tm float-right mb-3 btn-info" href="##" id="ctc_#account_id#"><i class="fal fa-plus-circle"></i> Créer TM </a>
									</cfoutput>
									<cfinclude template="wid_user_select.cfm">
								
								</div>
								
								<div>
									<button class="btn btn-outline-warning btn-block text-left" data-toggle="collapse" data-target="#learners">
									<span style="font-size:14px"><i class="fa-light fa-users-class fa-lg mr-2" aria-hidden="true"></i> LEARNERS / TESTS / GUESTS <span class="badge badge-warning text-white" style="font-size:14px"><cfoutput> <cfif get_learner.recordcount eq "50">> 50<cfelse>#get_learner.recordcount#</cfif></cfoutput></span></span>
									<a class="btn btn-sm btn-warning float-right btn_add_learner m-0" href="#"><i class="fal fa-plus-circle"></i></a>
									</button>
								</div>
								
								<div id="learners" class="collapse" data-parent="#accordion">
									<cfoutput>
										<a class="btn btn-sm btn_add_learner float-right mb-3 btn-warning" href="##" id="ctc_#account_id#"><i class="fal fa-plus-circle"></i> Créer Learner </a>
									</cfoutput>
								<cfinclude template="wid_learner_select.cfm">
								</div>
									
							</div>
						</div>
					</div>
					
					
				<!---	<div class="clear h20"></div>	
					
				
					<cfinclude template="wid_task_select.cfm">
					<div class="clear h20"></div>
					
					<cfinclude template="wid_opport_select.cfm">
					<div class="clear h20"></div>

					<cfinclude template="wid_order_select.cfm">
					<div class="clear h20"></div>
		
--->

			</div>
		</div>
	</div>
	
	<div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "learner">show active</cfif>" id="learner">
		<div class="row" style="margin-top:10px">
	
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<cfset view_full_learner = "1">
						<cfset st_id = "100">
						<cfinclude template="../widget/wid_learner_list_cs.cfm">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "order">show active</cfif>" id="order">
		<div class="row" style="margin-top:10px">
	
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">

						
						
						
						
<ul class="nav nav-tabs" id="year_list" role="tablist">
<cfloop from="2018" to="#year(now())#" index="y">
<cfoutput>
<cfif isdefined("o_ref")>
<li class="nav-item">
<a href="##y_#y#" class="nav-link <cfif mid(o_ref,1,2) eq mid(y,3,2)>active</cfif>" role="tab" data-toggle="tab">#y# </a>
</li>
<cfelse>	
<li class="nav-item">	
<a href="##y_#y#" class="nav-link <cfif y eq year(now())>active</cfif>" role="tab" data-toggle="tab">#y#</a>
</li>
</cfif>
</cfoutput>
</cfloop> 
</ul>

<div class="tab-content">
	<cfloop from="2018" to="#year(now())#" index="y">
	<cfoutput>
	<cfif isdefined("o_ref")>
	<div role="tabpanel" class="tab-pane <cfif mid(o_ref,1,2) eq mid(y,3,2)>active show</cfif>" id="y_#y#" style="margin-top:15px;">
	<cfelse>
	<div role="tabpanel" class="tab-pane <cfif y eq year(now())>active show</cfif>" id="y_#y#" style="margin-top:15px;">
	</cfif>
		<!--- <cfset get_orders = obj_order_get.oget_orders(y_id="#mid(y,3,2)#")>		
		<cfset view_order = "full"> --->
		<!--- <cfinclude template="../widget/wid_order_list.cfm">				 --->
	</div>
	</cfoutput>
	</cfloop> 
</div>	

						
						
						
						
						
						
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "contact">show active</cfif>" id="contact">
		<div class="row" style="margin-top:10px">
	
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<cfset view_full_contact = "1">
						<cfinclude template="wid_contact_select.cfm">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "coordonnee">show active</cfif>" id="coordonnee">
	<cfoutput query="get_account">
		<div class="row" style="margin-top:10px">
			
			<div class="col-md-6">

				<div class="card">
					<div class="card-header">
						<h6 class="card-title d-inline">Adresse Si&egrave;ge</h6>
						<a class="btn btn-sm btn-default btn_edit_account" id="a_#account_id#" href="##"><i class="fal fa-edit"></i></a>
					</div>
					<div class="card-body">
					
						<table class="table table-sm">
							<tr>
								<td width="15%"><label>Adresse</label></td>
								<td>#account_address#</td>
							</tr>												
							<tr>
								<td><label>CP - Ville</label></td>
								<td>
								#account_postal# #account_city#
								</td>
							</tr>												
							<tr>
								<td><label>Pays</label></td>
								<td>#account_country_name#</td>
							</tr>
									
						</table>
						
						<div class="card-footer"></div>
						
					</div>
				</div>
				
			</div>
			
			<div class="col-md-6">
			
				<div class="card">
					<div class="card-header">
						<h6 class="card-title d-inline">Adresse Facturation</h6>
						<a class="btn btn-sm btn-default btn_edit_account" id="a_#account_id#" href="##"><i class="fal fa-edit"></i></a>
					</div>
					<div class="card-body">
					
						<table class="table table-sm">
							<tr>
								<td width="15%"><label>Account invoice</label></td>
								<td>#account_f_name#</td>
							</tr>	
							<tr>
								<td width="15%"><label>Adresse</label></td>
								<td>#account_f_address#</td>
							</tr>												
							<tr>
								<td><label>CP - Ville</label></td>
								<td>
								#account_f_postal# #account_f_city#
								</td>
							</tr>												
							<tr>
								<td><label>Pays</label></td>
								<td>#account_f_country_name#</td>
							</tr>
									
						</table>
						
						<div class="card-footer"></div>
						
					</div>
				</div>
			
			</div>
		
		</div>
	</cfoutput>
	</div>
</div>

<!--- <div role="tabpanel" class="tab-pane <cfif isdefined("view_tab") AND view_tab eq "sales">show active</cfif>" id="sales">

<cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
SELECT t.*, tt.*, ac.contact_firstname, ac.contact_name, a.account_name FROM task t 
INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
LEFT JOIN account_contact ac ON ac.contact_id = t.contact_id
LEFT JOIN account a ON a.account_id = t.account_id
WHERE 1 = 1
<cfif isdefined("a_id")>
AND t.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfif>
ORDER BY t.task_date_creation ASC
</cfquery>

		<div class="row" style="margin-top:10px">								
		
			<div class="col-md-12">	
			<cfoutput query="get_activity">			
				<button class="btn <cfif task_date_close neq "">bck_gray<cfelse><cfif task_group eq "task">btn-warning<cfelse>btn-success</cfif></cfif> btn-xs btn_edit_task" id="t_#task_id#">#dateformat(task_date_creation,'dd/mm/yyyy')#<br>#task_type_name#</button>
			</cfoutput>
			</div>
		</div>
		
		<div class="row">								
			<div class="col-md-12">	
				<cfset view_full_task = "1">
				<cfinclude template="wid_task_select.cfm">
				<cfset view_full_opport = "1">
				<cfinclude template="wid_opport_select.cfm">
			</div>
		</div>
	</div>
	
</div>	 --->
