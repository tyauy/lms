<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

	<cfparam name="t_id" default="1">
	
	<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM account_type ORDER BY type_name
	</cfquery>
	
</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<body>

<div class="wrapper">

	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
	  
		<cfset title_page = "Mes comptes">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">

				<div class="col-md-12">	
				
					<cfinclude template="./widget/wid_account_list.cfm">				
					
				</div>
		
			</div>
	
		</div>
		  			  
		<cfinclude template="./incl/incl_footer.cfm">
	
	</div>
	
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
<cfoutput query="get_type">
$("##table_account_#type_id#").DataTable({
	"paging":   true,
	"ordering": true,
	"info":     true,
	"order": [[ 2, "asc" ]],
	"ajax": "get_datatable.cfm?get_account=1&type_id=#type_id#",
	"pageLength": 100,
	"columns": [		
			{ "data": "account_id" },
			{ "data": "status_name" },
            { "data": "account_name" },
            { "data": "group_name" },
			{ "data": "account_contact" },
			{ "data": "account_city" },
			{ "data": "account_country" },
			{ "data": "account_phone" },
			{ "data": "user_alias" },
			{ "data": "colright", "orderable":false}
			/*{ "data": "trainer_name" },			
            { "data": "id" },
            { "data": "title" },t", },
            { "data": "duration" },
			{ "data": "status" },
			{ "data": "action" }*/
    ],
	"columnDefs": [
        { "type": "phoneNumber", "targets": 8 }
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
 
</body>
</html>