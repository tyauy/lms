<cfsilent>
<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type
</cfquery>
</cfsilent>

<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline"><cfoutput>#obj_translater.get_translate('contacts')#</cfoutput></h6>
		<a class="btn btn-sm btn-default btn_create_ctc" href="#"><i class="fas fa-plus-circle"></i></a>
	</div>
	<div class="card-body">
	
		<div class="row">
			
			<div class="col-md-12">
				
				<table id="table_contact" class="table table-bordered table-condensed table-hover table-striped" width="100%">
					<thead>
					<cfoutput>
						<th>#obj_translater.get_translate('table_th_lastname')#</th>
						<th>#obj_translater.get_translate('table_th_firstname')#</th>
						<th>#obj_translater.get_translate('table_th_account')#</th>
						<th>#obj_translater.get_translate('table_th_group')#</th>
						<th>#obj_translater.get_translate('table_th_type')#</th>
						<th>#obj_translater.get_translate('table_th_phone')#</th>
						<th>#obj_translater.get_translate('table_th_localisation')#</th>
						<th>#obj_translater.get_translate('table_th_assign')#</th>
						<th width="60">#obj_translater.get_translate('table_th_action')#</th>
					</cfoutput>
					</thead>
					<tbody>
					
					</tbody>
				</table>

			</div>

		</div>
		
	</div>
</div>
		
 