<!DOCTYPE html>
       <!-- Get the lang parameter from the URL -->
       <cfparam name="url.lang" default="en">

       <!-- Map lang codes to f_id values -->
       <cfset langToFId = { "en" = 2, "fr" = 1, "de" = 3, "es" = 4, "it" = 5 }>


       
       <!-- Set the f_id based on the lang parameter -->
       <cfif structKeyExists(langToFId, url.lang)>
           <cfset f_id = langToFId[url.lang]>
       <cfelse>
           <cfset f_id = 2>
       </cfif>




<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<style>
.sticky-header {
    position: sticky;
    top: 0;
    z-index: 100;
    background-color: #343a40; /* match the color of thead */
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Mapping edition">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
            <button class="btn btn-primary mt-3" id="add_mapping_button"><i class="fas fa-plus" ></i> Add New Mapping</button>

			<div class="row">
                <div class="col-md-12">

                    <!-- Define the list of languages -->
                    <cfset langList = "en,fr,de,es,it">

                    <!-- Create the tabs -->
                    <ul class="nav nav-tabs">
                        <cfloop list="#langList#" index="lang">
                          
                            <li class="nav-item">
                               <cfoutput> <a class="nav-link <cfif lang eq url.lang>active</cfif>" href="?lang=#lang#">#UCase(lang)#</a></cfoutput>
                            </li>
                        </cfloop>
                    </ul>

                  <!-- Create the tables for each language -->
                    <cfloop list="#langList#" index="lang">
                        <cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
                            SELECT mapping_id, mapping_name_#lang# as mapping_name, mapping_name_en, mapping_name_fr, mapping_name_de, mapping_name_es, mapping_name_it, description_#lang# as description, mapping_explanation_long_#lang# as mapping_explanation_long 
                            FROM lms_mapping 
                            WHERE  mapping_category != 'NA' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                        </cfquery>
                    <cfif lang eq url.lang>
                        
                        <div id="tabs-<cfoutput>#lang#</cfoutput> mt-2">
                            <div id="alert-container-add"></div>
                            <table class="table table-sm table-striped table-bordered bg-white">
                                <thead class="thead-dark sticky-header">

                                <tr>
                                    <th>ID</th>
                            
                                    <th>mapping name</th>
                                    <cfloop list="#langList#" index="otherLang">
                                        <cfif otherLang neq lang>
                                           <cfoutput> <th>Mapping Name (#UCase(otherLang)#)</th></cfoutput>
                                        </cfif>
                                    </cfloop>
                                    <th>mapping description</th>
                                
                                    <!--- <th>Use</th> --->
                                    <th>Edit mapping details</th>
                                    <th>See what it would look like</th>
                                 <!---    <th>Archive</th> --->
                                </tr> 
                                </thead>
                              
                                        <cfoutput query="get_mapping_grammar">
                                            <tr>
                                                <td>#MAPPING_ID#</td>
                                                <td class="editable_name" contenteditable="true" data-edit-task-name="#MAPPING_ID#">#mapping_name#</td>
                                                <cfloop list="#langList#" index="otherLang">
                                                    <cfif otherLang neq lang>
                                                        <td class="editable_trad" contenteditable="true" data-lang="#otherLang#" data-mapping-id="#MAPPING_ID#">#Evaluate('MAPPING_NAME_' & UCase(otherLang))#</td>
                                                    </cfif>
                                                </cfloop>
                                                <td class="editable_desc" contenteditable="true" data-lang="#lang#" data-edit-task-desc="#MAPPING_ID#">#description#</td> 
                                                <td><button class="btn btn-sm <cfif mapping_explanation_long neq "">btn-red<cfelse>btn-outline-red</cfif> btn_mapping_edit" data-mappingtypeid="#MAPPING_ID#"><i class="fa-light fa-edit"></i><br>Edit</button></td>
                                               <!---  <td><button class="btn btn-sm btn-outline-red archive-button" data-archive-task-id="#MAPPING_ID#"><i class="fa-light fa-archive"></i><br>Archive</button></td> --->
                                               <td>
                                                <button class="btn btn-sm btn-success btn_open_modal" data-toggle="modal" data-mappingtypeid="#MAPPING_ID#">See as learner</button>
                                            </td>
                                            </tr>
                                    
                                        </cfoutput>
                            </table>	  
                        
                        </div>
                    </cfif> 
                </cfloop>					
            </div>
				
		</div>
    </div>
		
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">
<cfinclude template="./incl/incl_scripts_param.cfm">
<cfinclude template="./incl/incl_scripts_modal.cfm">
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.1/js/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
    
    $('.btn_mapping_edit').click(function(event) {	
        event.preventDefault();		
        var mp_id = $(this).attr("data-mappingtypeid");
        // Extract lang from the URL
        var urlParams = new URLSearchParams(window.location.search);
        var lang = urlParams.get('lang');
        if (lang === null) {
            lang = 'en';
        }
        console.log('Lang:', lang);


        $('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("Editer un mapping");
        $('#modal_body_lg').load("modal_window_mapping.cfm?mp_id=" + mp_id + "&lang=" + lang, function() {});
    });

    $('#add_mapping_button').click(function(event) {	
		event.preventDefault();		
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter un mapping");
		$('#modal_body_lg').load("modal_window_mapping.cfm?new_mapping=1", function() {});
	});

    $('.btn_open_modal').click(function(event) {	
		event.preventDefault();		
         // Get the mapping_id from the data attribute
         var mp_id = $(this).attr("data-mappingtypeid");
        // Extract lang from the URL
        var urlParams = new URLSearchParams(window.location.search);
        var lang = urlParams.get('lang');
        if (lang === null) {
            lang = 'en';
        }
        console.log('Lang:', lang);
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("This is what the learner will see");
		$('#modal_body_lg').load("modal_window_mapping_see.cfm?mp_id=" + mp_id + "&lang=" + lang, function() {});
	});
      
        // Handle the Archive button click
        $('.archive-button').click(function() {
            var taskId = $(this).closest('tr').find('td:first').text();
            $.ajax({
                url: './api/task/task_post.cfc?method=archive_task', 
                type: 'POST',
                data: {
                    id: taskId  
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Task archived</div>');
                   location.reload();
                    console.log(response);
                }
            });
        });
    
        // Handle the Mapping Name edit
        $('.editable_name').blur(function() {
            var mappingId = $(this).closest('tr').find('td:first').text();
            var newName = $(this).text();
            $.ajax({
                url: './api/mapping/mapping_post.cfc?method=rename_mapping', 
                type: 'POST',
                data: {
                    mapping_id: mappingId,  
                    name: newName  
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Mapping name changed</div>');
                    console.log(response);
                }
            });
        });

          // Handle the Translation name
          $('.editable_trad').blur(function() {
            var mappingId = $(this).data('mapping-id')
            var newName = $(this).text();
            var lang = $(this).data('lang');
            $.ajax({
                url: './api/mapping/mapping_post.cfc?method=edit_trad', 
                type: 'POST',
                data: {
                    mapping_id: mappingId,  
                    name: newName,
                    lang: lang  
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Translation changed</div>');
                    console.log(response);
                }
            });
        });

          // Handle the Task description edit
          $('.editable_desc').blur(function() {
            var mappingId = $(this).closest('tr').find('td:first').text();
            var newDesc = $(this).text();
            var lang = $(this).data('lang');
            $.ajax({
                url: './api/mapping/mapping_post.cfc?method=change_desc', 
                type: 'POST',
                data: {
                    mapping_id: mappingId,  
                    desc: newDesc,
                    lang: lang
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Mapping description changed</div>');
                    console.log(response);
                }
            });
        });
});
</script>
    
</body>
</html>