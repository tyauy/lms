<nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
	<div class="container-fluid">
		<div class="navbar-wrapper">
			<div class="navbar-toggle">
				<button type="button" class="navbar-toggler">
				<span class="navbar-toggler-bar bar1"></span>
				<span class="navbar-toggler-bar bar2"></span>
				<span class="navbar-toggler-bar bar3"></span>
				</button>
			</div>
			<a class="navbar-brand" href="##"><cfoutput>#title_page#</cfoutput></a>
			
		</div>
		
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-bar navbar-kebab"></span>
			<span class="navbar-toggler-bar navbar-kebab"></span>
			<span class="navbar-toggler-bar navbar-kebab"></span>
		</button>
		
		<!------------------ IF USER CONNECTED ------------------->
		<cfif isdefined("SESSION.USER_ID") AND isdefined("SESSION.USER_PROFILE")>
		
			<div class="collapse navbar-collapse justify-content-end" id="navigation">

				<ul class="navbar-nav">
				
				<!--------------------- DISPLAY BTN HELP ON THIS PAGE IF VARIABLE DEFINED --------------->
				<cfif isdefined("help_page")>
					<li class="nav-item">
						<cfoutput><a href="##" class="nav-link"><span class="badge badge-pill badge-warning p-2 text-white btn_help" id="#help_page#"><i class='fas fa-question-circle'></i> #obj_translater.get_translate('btn_help_page')#</span></a></cfoutput>
					</li>
				</cfif>
				
				<!--------------------- DISPLAY PHONE NUMBER FOR USERS --------------->
				<cfif listFindNoCase("LEARNER,GUEST,TEST", SESSION.USER_PROFILE)>

					<li class="nav-item">
						<cfif isdefined("SESSION.LANG_CODE") AND SESSION.LANG_CODE neq "de">
							<a href="##" class="btn btn-sm btn-red btn_contact_wefit">
								<i class="fa-light fa-phone-alt"></i> / <i class="fa-light fa-envelope"></i> <cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput>
							</a>
						<cfelse>
							<a href="##" class="btn btn-sm btn-red btn_contact_wefit">
								<i class="fa-light fa-phone-alt"></i> / <i class="fa-light fa-envelope"></i> <cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput>
							</a>
						</cfif>
					</li>

				<!--------------------- DISPLAY CONTACT FOR SOME OTHER USERS --------------->
				<cfelseif listFindNoCase("TRAINER,TM", SESSION.USER_PROFILE)>

					<li class="nav-item">
						<cfoutput><a href="##" class="nav-link"><span class="badge badge-pill badge-info p-2 text-white btn_contact_wefit"><i class="fas fa-phone"></i>&nbsp; #obj_translater.get_translate('btn_contact_wefit')#</span></a></cfoutput>
					</li>

				</cfif>



				<!------------------ FLAG FOR SETTING LANGUAGE INTERFACE ------------------->		
				<li class="nav-item btn-rotate dropdown">
					<cfoutput>
					<a href="##" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="lang-sm" lang="#SESSION.LANG_CODE#"></span> </a>
					</cfoutput>
					<div class="dropdown-menu dropdown-menu-right">
						<cfloop list ="#SESSION.LIST_LANGUAGES_SHORT#" index="lang">
						<cfoutput>
						<cfif CGI.QUERY_STRING eq "">
							<a class="dropdown-item" href="#CGI.SCRIPT_NAME#?lg=#lang#"> <span class="lang-sm lang-lbl" lang="#lang#"></span> </a>
						<cfelse>
							<cfset vars = replacenocase(QUERY_STRING,"&lg=fr","")>
							<cfset vars = replacenocase(vars,"&lg=en","")>
							<cfset vars = replacenocase(vars,"&lg=it","")>
							<cfset vars = replacenocase(vars,"&lg=de","")>
							<cfset vars = replacenocase(vars,"&lg=es","")>
							<cfset vars = replacenocase(vars,"lg=fr","")>
							<cfset vars = replacenocase(vars,"lg=en","")>
							<cfset vars = replacenocase(vars,"lg=it","")>
							<cfset vars = replacenocase(vars,"lg=de","")>
							<cfset vars = replacenocase(vars,"lg=es","")>
							
							<a class="dropdown-item" href="#CGI.SCRIPT_NAME#?lg=#lang#<cfif vars neq "">&#vars#</cfif>"> <span class="lang-sm lang-lbl" lang="#lang#"></span> </a>
						</cfif>
						</cfoutput>
						</cfloop>
					</div>
				</li>
					
				
			
				<!------------------ DISLAY SEARCH BAR ------------------->	
				<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
			
					<form id="form-global_search" name="global_search">
						<div class="typeahead__container">
							<div class="typeahead__field">
								<div class="typeahead__query">
									<input class="js_typeahead_global" <!---name="country_v1[query]"---> type="search" placeholder="Search" autocomplete="off">
								</div>
								<div class="typeahead__button">
									<button type="submit">
										<i class="typeahead__search-icon"></i>
									</button>
								</div>
							</div>
						</div>
					</form>

				</cfif>



				<!------------------ DISLAY USER NAME + DISCONNECT ------------------->		
				<li class="nav-item btn-rotate dropdown">
					<cfoutput>
					<a href="##" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#SESSION.USER_NAME# </a>
					</cfoutput>
					<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
						<!------------------ DISLAY MY ACCOUNT ONLY FOR SOME USERS ------------------->		
						<cfif listFindNoCase("LEARNER,GUEST", SESSION.USER_PROFILE)>				
							<a href="common_learner_account.cfm" class="dropdown-item"> <cfoutput>#obj_translater.get_translate('sidemenu_learner_account')#</cfoutput></a>
						</cfif>
						<a href="connect_out.cfm" class="dropdown-item"> <cfoutput>#obj_translater.get_translate('btn_disconnect')#</cfoutput></a>
					</div>
				</li>


				
				<cfif isdefined("SESSION.PROFILE_LIST")>
				<cfoutput>
					<li class="nav-item btn-rotate dropdown">
						
						<a href="##" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#obj_translater.get_translate('profile')# </a>
						
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
			
							<cfloop query="#SESSION.PROFILE_LIST#">
								<cfif SESSION.PROFILE_LIST.profile_id neq 11>
									<a href="index.cfm?switch_profile=#SESSION.PROFILE_LIST.profile_id#" class="dropdown-item"> #SESSION.PROFILE_LIST.profile_name#</a>
								</cfif>
							</cfloop>

						</div>

					</li>
				</cfoutput>
				</cfif>
				
				</ul>
			</div>

		<!------------------ IF USER NOT CONNECTED ------------------->
		<cfelse>
			<div class="collapse navbar-collapse justify-content-end" id="navigation">
				<ul class="navbar-nav">
					<li class="nav-item">
						<cfif isdefined("SESSION.LANG_CODE") AND SESSION.LANG_CODE neq "de">
						<a href="##" class="nav-link btn btn-sm btn-red">
							<i class="far fa-phone-alt"></i> +33 (0)1 89 16 82 67
						</a>
						<cfelse>
						<a href="##" class="nav-link btn btn-sm btn-red">
							<i class="far fa-phone-alt"></i> +49 7151 2 59 40 54
						</a>
						</cfif>
					</li>
				</ul>
			</div>
		</cfif>
				
	</div>
</nav>