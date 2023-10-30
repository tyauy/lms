<!DOCTYPE html>

<cfsilent>


<cfparam name="url.lang" default="en">

<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user_profile WHERE profile_id IN (2,4,5,6,8,12) ORDER BY FIELD(profile_id,2,5,6,12,4,8)
</cfquery>

<cfquery name="get_task_type" datasource="#SESSION.BDDSOURCE#">
SELECT tt.*, tt.task_explanation_#url.lang# as task_explanation<!---, COUNT(li.log_id) as nb--->
FROM task_type tt 
<!--- LEFT JOIN logs_item li ON tt.task_type_id = li.task_type_id --->
WHERE tt.task_online =1
GROUP BY tt.task_type_id
ORDER BY task_group_sub, task_category DESC,  task_type_name
</cfquery>

</cfsilent>

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
      
		<cfset title_page = "Task edition">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
            <button class="btn btn-primary mt-3" id="add_task_button"><i class="fas fa-plus" ></i> Add New Task</button>

			<div class="row">
                <div class="col-md-12">

                    <!-- Define the list of languages -->
                    <cfset langList = "en,fr,de">

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
                
                    <cfif lang eq url.lang>
                        
                        <div id="tabs-<cfoutput>#lang#</cfoutput> mt-2">
                            <div id="alert-container-add"></div>
                            <table class="table table-sm table-striped table-bordered bg-white">
                                <thead class="thead-dark sticky-header">

                                <tr>
                                    <th>ID</th>
                                    <th>Task category</th>
                                    <th>Task group</th>
                                    <th>Task group sub</th>
                                    <th>Task name</th>
                                    <th>Task description</th>
                                    <cfoutput query="get_profile">
                                        <th width="60">#profile_name#</th>
                                    </cfoutput>
                                    <!--- <th>Use</th> --->
                                    <th>Edit Guidelines</th>
                                    <th>Archive</th>
                                </tr> 
                                </thead>
                                <cfoutput query="get_task_type">
                                    <tr>
                                        <td>#task_type_id#</td>
                                        <td><strong>#task_category#</strong></td>
                                        <td><span class="badge text-white" style="background-Color:###task_color#">#task_group_alias#</span></td>
                                        <td>#task_group_sub#</td>
                                        <td class="editable_name" contenteditable="true" data-edit-task-name="#task_type_id#">#task_type_name#</td>
                                        <td class="editable_desc" contenteditable="true" data-lang="#lang#" data-edit-task-desc="#task_type_id#">#evaluate('task_explanation_#lang#')#</td> 
                                        <cfloop list="2,5,6,12,4,8" index="cor">
                                            <td width="60" align="center">
                                                <cfif listfind(profile_id,cor)>
                                                    <i class="fa-solid fa-check text-success fa-lg toggle-icon" data-profile-id="#cor#"></i>
                                                <cfelse>
                                                    <i class="fa-solid fa-xmark text-danger fa-lg toggle-icon" data-profile-id="#cor#"></i>
                                                </cfif>
                                            </td>
                                        
                                        </cfloop>
                                        
                                        <td><button class="btn btn-sm <cfif task_explanation_long neq "">btn-red<cfelse>btn-outline-red</cfif> btn_task_edit" data-tasktypeid="#task_type_id#"><i class="fa-light fa-edit"></i><br>Edit</button></td>

                                        <td><button class="btn btn-sm btn-outline-red archive-button" data-archive-task-id="#task_type_id#"><i class="fa-light fa-archive"></i><br>Archive</button></td>

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

    // Toggle between check and x icons
    $('.toggle-icon').click(function() {
      
    var profileId = $(this).data('profile-id');
    var taskId = $(this).closest('tr').find('td:first').text();
    var isCheck = $(this).hasClass('fa-check');
    var profileIds = $(this).closest('tr').find('.toggle-icon').map(function() {
      return {
        id: $(this).data('profile-id'),
        isCheck: $(this).hasClass('fa-check')
      };
    }).get();

    profileIds.forEach(function(item) {
      if (item.id === profileId) {
        item.isCheck = !item.isCheck;
      }
    });

    $(this).toggleClass('fa-check text-success', !isCheck);
    $(this).toggleClass('fa-xmark text-danger', isCheck);

    // Send the updated list of profile IDs to the database
    var updatedProfileIds = profileIds.filter(function(item) {
      return item.isCheck;
    }).map(function(item) {
      return item.id;
    }).join(',');

    $.ajax({
      url: './api/task/task_post.cfc?method=update_profile',
      type: 'POST',
      data: {
        task_id: taskId,
        profile_ids: updatedProfileIds
      },
      success: function(response) {
        $('#alert-container-add').html('<div class="alert alert-success">Update successful</div>');
        alert ("Update successful. Give Em a hug");
        console.log(response);
      },
      error: function(jqXHR, textStatus, errorThrown) { '<div class="alert alert-danger">Update unsuccessful. Yell at Em</div>'
        alert ("Update unsuccessful. Yell at Em");
        console.log(textStatus, errorThrown);
      }
    });
  });
    
    $('.btn_task_edit').click(function(event) {	
        event.preventDefault();		
        var tt_id = $(this).attr("data-tasktypeid");

        $('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("Editer une task");
        $('#modal_body_lg').load("modal_window_task.cfm?tt_id="+tt_id, function() {});
    });

    $('#add_task_button').click(function(event) {	
		event.preventDefault();		
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter une task");
		$('#modal_body_lg').load("modal_window_task.cfm?new_task=1", function() {});
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
    
        // Handle the Task Name edit
        $('.editable_name').blur(function() {
            var taskId = $(this).closest('tr').find('td:first').text();
            var newName = $(this).text();
            $.ajax({
                url: './api/task/task_post.cfc?method=rename_task', 
                type: 'POST',
                data: {
                    id: taskId,  
                    name: newName  
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Task name changed</div>');
                    console.log(response);
                }
            });
        });

          // Handle the Task description edit
          $('.editable_desc').blur(function() {
            var taskId = $(this).closest('tr').find('td:first').text();
            var newDesc = $(this).text();
            var lang = $(this).data('lang');
            $.ajax({
                url: './api/task/task_post.cfc?method=change_desc', 
                type: 'POST',
                data: {
                    id: taskId,  
                    desc: newDesc,
                    lang: lang
                },
                success: function(response) {
                    $('#alert-container-add').html('<div class="alert alert-success">Task description changed</div>');
                    console.log(response);
                }
            });
        });
});
</script>
    
</body>
</html>