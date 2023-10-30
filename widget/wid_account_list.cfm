<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Comptes</h6> 
		<a class="btn btn-sm btn-default btn_create_account" href="#"><i class="fas fa-plus-circle"></i></a>
	</div>
	<div class="card-body">

		<!----- TABS TITLE ---->
		<ul class="nav nav-tabs" role="tablist">
			<cfoutput query="get_type">
			<li class="nav-item"><a href="##tab_#type_id#" class="nav-link <cfif isdefined("t_id") AND t_id eq type_id>active</cfif>" role="tab" data-toggle="tab">#type_name#</a></li>
			</cfoutput>
		</ul>
			
		<!----- TABS CONTENT ---->
		<div class="tab-content">
			<cfoutput query="get_type">
			<div role="tabpanel" class="tab-pane fade <cfif isdefined("t_id") AND t_id eq type_id>show active</cfif>" id="tab_#type_id#">

				<br><br>					
				<table id="table_account_#type_id#" class="table table-bordered table-hover table-condensed table-striped" width="100%">
					<thead>
						<th>ID</th>
						<th>Statut</th>
						<th>Nom</th>
						<th>Groupe</th>
						<th>Contact principal</th>
						<th>Localisation</th>
						<th>Pays</th>
						<th>T&eacute;l</th>
						<th>Assign&eacute;</th>
						<th width="60">Action</th>
					</thead>
					<tbody>
					
					</tbody>
				</table>
				
			</div>
			</cfoutput>
			


		</div>
	

	</div>

</div>
 