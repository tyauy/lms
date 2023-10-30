<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<body>

<div class="wrapper">

	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
	  
		<cfset title_page = "Mes contacts">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

								
			<div class="row">

				<div class="col-md-12">

					<cfinclude template="./widget/wid_contact_list.cfm">
					
				</div>
				
			</div>
			
		</div>
  
		<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$("#table_contact").DataTable({
	"paging":   true,
	"ordering": true,
	"info":     true,
	"order": [[ 0, "asc" ]],
	"ajax": "get_datatable.cfm?get_contact=1",
	"pageLength": 50,
	"columns": [			
            { "data": "contact_name" },
            { "data": "contact_firstname" },
			{ "data": "account_name" },
			{ "data": "group_name" },
			{ "data": "type_name" },
			{ "data": "contact_tel1" },
			{ "data": "account_city" },			
			{ "data": "user_alias" },
			{ "data": "colright", "orderable":false}
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
 </script>
 
</body>
</html>