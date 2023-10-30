<cfparam name="tg_id" default="1">
<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM task_type WHERE task_group = "task"
</cfquery>

<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Tasks</h6>
		<a class="btn btn-sm btn-default btn_create_task" href="#"><i class="fas fa-plus-circle"></i></a>
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
						<th>Type</th>
						<th>Compte</th>
						<th>Contact</th>
						<th>Assign&eacute;</th>
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

<script>
<cfoutput query="get_type">
$("##table_opport_#task_type_id#").DataTable({
	"paging":   true,
	"ordering": true,
	"info":     true,
	"order": [[ 7, "asc" ]],
	"ajax": "get_datatable.cfm?get_opport=1&task_type_id=#task_type_id#",
	"pageLength": 50,
	"columns": [			
            { "data": "task_name" },
            { "data": "task_type_name" },
			{ "data": "account_name" },
			{ "data": "contact_name" },
			{ "data": "user_alias" },
			{ "data": "task_date_deadline" },
			{ "data": "task_date_close" },			
			{ "data": "action", "orderable":false}
			/*{ "data": "trainer_name" },			
            { "data": "id" },
            { "data": "title" },t", },
            { "data": "duration" },
			{ "data": "status" },
			{ "data": "action" }*/
        ],
	"buttons": [
        'copy', 'excel', 'pdf'
    ],
	
	"language": {
	"emptyTable":     "Aucun r&eacute;sultat",
    "info":           "Affiche _START_-_END_ / _TOTAL_ enregistrements",
    "infoEmpty":      "",
    "infoFiltered":   "(_MAX_ au total)",
    "infoPostFix":    "",
    "thousands":      ",",
    "lengthMenu":     "Afficher _MENU_ r&eacute;sultats",
    "loadingRecords": "Chargement...",
    "processing":     "Ex&eacute;cution...",
    "search":         "Recherche :",
    "zeroRecords":    "No matching records found",
    "paginate": ({
        "first":      "D&eacute;but",
        "last":       "Fin",
        "next":       "Suivant",
        "previous":   "Pr&eacute;c."
    })
	}
	
	
 });
 </cfoutput>
 </script>
