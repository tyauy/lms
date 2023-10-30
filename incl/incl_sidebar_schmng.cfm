<cfoutput>
	<div class="sidebar-wrapper">
		<ul class="nav">
		
			<li <cfif find("index",SCRIPT_NAME)>class="active"</cfif>>
				<a href="index.cfm"><i class="fal fa-home"></i><p>TABLEAU DE BORD</p></a>
			</li>

			<li <cfif find("cm_",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cm_1" href="##menu_cm_1"><i class="fal fa-book-reader"></i><p>DONNÉES</p></a>

				<div <cfif find("cm_",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cm_1">
					<ul>			
						<li style="list-style:none" <cfif find("cm_database",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cm_database.cfm" class="my-0 py-0"><p>Gestionnaires</p></a>
						</li>
						<li style="list-style:none" <cfif find("cm_session",SCRIPT_NAME)>class="active"</cfif>>
							<a href="cm_session.cfm" class="my-0 py-0"><p>Sessions</p></a>
						</li>						
					</ul>						
				</div>
			</li>
			
		</ul>

	</div>
</cfoutput>