<cfparam name="tg_id" default="4">
<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM task_type WHERE task_group = "opport"
</cfquery>

<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Opportunit&eacute;s</h6>
		<a class="btn btn-sm btn-default btn_create_opport" href="#"><i class="fas fa-plus-circle"></i></a>
	</div>
	<div class="card-body">
	
		<!----- TABS TITLE ---->
		<ul class="nav nav-tabs" role="tablist">
			<cfoutput query="get_type">
			<li class="nav-item">
				<a href="##tab_#task_type_id#" class="nav-link <cfif isdefined("tg_id") AND tg_id eq task_type_id>active</cfif>" role="tab" data-toggle="tab">#task_type_name#</a>
			</li>
			</cfoutput>
		</ul>
			
		<!----- TABS CONTENT ---->
		<div class="tab-content">
			<cfoutput query="get_type">
			<div role="tabpanel" class="tab-pane fade <cfif isdefined("tg_id") AND tg_id eq task_type_id>show active</cfif>" id="tab_#task_type_id#">

				<br><br>					
				<table id="table_opport_#task_type_id#" class="table table-bordered table-condensed table-hover table-striped" width="100%">
					<thead>
						<th>Nom</th>
						<th>&Eacute;tape</th>
						<th>Compte</th>
						<th>Contact</th>
						<th>Assign&eacute;</th>
						<th>Montant</th>
						<th>Proba</th>
						<th>&Eacute;ch&eacute;ance</th>
						<th>Date closing</th>
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