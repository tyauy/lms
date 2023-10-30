<cfif isdefined("tt_id")>

<script>
tinymce.init({
  selector: '#task_explanation_long',
  branding: false,
  contextmenu: "link image imagetools table spellchecker",
  contextmenu_never_use_native: true,
  draggable_modal: false,
  menubar: 'insert',
  toolbar: 'undo redo | bold italic underline | h5 h6 | numlist bullist image forecolor backcolor | table ',
  plugins: "lists,table,textcolor,link, image code, imagetools",
  images_upload_handler: function (blobInfo, success, failure) {
    var xhr = new XMLHttpRequest();
    var formData = new FormData();

    xhr.withCredentials = false;
    xhr.open('POST', 'proxy.cfm');

    xhr.onload = function() {
      var json;

      if (xhr.status !== 200) {
        failure('HTTP Error: ' + xhr.status);
        return;
      }

      json = JSON.parse(xhr.responseText);

      if (!json || typeof json.location != 'string') {
        failure('Invalid JSON: ' + xhr.responseText);
        return;
      }

      success(json.location);
    };

    formData.append('file', blobInfo.blob(), blobInfo.filename());

    xhr.send(formData);
  },
  file_picker_callback: function (callback, value, meta) {
    var input = document.createElement('input');
    input.setAttribute('type', 'file');
    input.setAttribute('accept', 'image/*');

    input.onchange = function () {
      var file = this.files[0];
      
      var reader = new FileReader();
      reader.onload = function () {
        var id = 'blobid' + (new Date()).getTime();
        var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
        var base64 = reader.result.split(',')[1];
        var blobInfo = blobCache.create(id, file, base64);
        blobCache.add(blobInfo);

        // call the callback and populate the Title field with the file name
        callback(blobInfo.blobUri(), { title: file.name });
      };
      reader.readAsDataURL(file);
    };
    
    input.click();
  },

   /* enable title field in the Image dialog*/
   image_title: true,
  /* enable automatic uploads of images represented by blob or data URIs*/
  automatic_uploads: true,
  image_advtab: true,
  file_picker_types: 'image',
  imagetools_toolbar: 'rotateleft rotateright | flipv fliph | editimage imageoptions',
  imagetools_proxy: 'proxy.cfm',
  browser_spellcheck: true,
  paste_data_images: true,

  height: 600,
  file_browser_callback_types: 'file image media'
});

</script>

<cfquery name="get_task_type" datasource="#SESSION.BDDSOURCE#">
SELECT tt.*
FROM task_type tt 
WHERE tt.task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tt_id#">
</cfquery>


<h6>Edit guidelines</h6>
<form id="form_task_updt" method="post">
  <textarea name="task_explanation_long" id="task_explanation_long" class="form-control tinymce-editor"><cfoutput>#get_task_type.task_explanation_long#</cfoutput></textarea>

<cfoutput><input type="hidden" name="tt_id" value="#tt_id#"></cfoutput>

<div align="center"><button type="submit" id="submit_task_edit" class="btn btn-red">Save</button></div>
</form>

<script>
  $(document).ready(function() {

    $('#submit_task_edit').click(function(){
      event.preventDefault();
      tinymce.get('task_explanation_long').save();
      // console.log($('#task_explanation_long').val());
      // console.log($('#form_task_updt').serialize());
      $.ajax({				  
          url: './api/task/task_post.cfc?method=updt_task_type',
          type: 'POST',
          data : $('#form_task_updt').serialize(),
          datatype : "html", 
          success : function(result, status){ 
              console.log(result);
              window.location.reload(true);
          }, 
          error : function(result, status, error){ 
              /*console.log(resultat);*/ 
          }	 
      });

    })

  })
</script>
<cfelse>

<cffunction name="getDistinctValues" output="false" returnType="string">
  <cfargument name="column" type="string" required="true">

  <cfquery name="getValues" datasource="#SESSION.BDDSOURCE#">
    <cfif column eq 'concatenated_columns'>
      SELECT DISTINCT 
          CONCAT(task_group_alias, ' . ', task_group_sub , ' . ', task_group, ' . ', task_color, ' . ', task_group_rank) as col
        FROM task_type
        ORDER BY task_group_alias ASC, task_group_sub ASC;

    <cfelseif column eq 'profile_id'>
      SELECT DISTINCT profile_id as col
      FROM task_type
    <cfelseif column eq 'task_online'>
      SELECT DISTINCT task_online as col
      FROM task_type
  <!---  <cfelseif column eq 'task_explanation_en'>
  SELECT DISTINCT task_explanation_en as col
  FROM task_type
<cfelseif column eq 'task_explanation_fr'>
  SELECT DISTINCT task_explanation_fr as col
  FROM task_type
<cfelseif column eq 'task_automation'>
  SELECT DISTINCT task_automation as col
  FROM task_type --->
    </cfif>
  </cfquery>

  <cfset var list = "">
  <cfloop query="getValues">
    <cfset list = list & getValues.col & ",">
  </cfloop>

  <!--- Trim the trailing comma --->
  <cfset list = left(list, len(list)-1)>

  <cfreturn list>
</cffunction>


<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
  SELECT * FROM user_profile WHERE profile_id IN (2,4,5,6,8,12) ORDER BY FIELD(profile_id,2,5,6,12,4,8)
</cfquery>

<cfset profileArray = []>
<cfloop query="get_profile">
  <cfset arrayAppend(profileArray, {id = profile_id, name = profile_name})>
</cfloop>

<cfset data = {
  taskGroupAliasColorSub: getDistinctValues('concatenated_columns'),
  profileId: getDistinctValues('profile_id'),
  taskOnline: getDistinctValues('task_online')

}>
  <cfoutput>
<!--- Create Task Form --->
<div class="container py-4">
  <div id="alert-container-add-modal"></div>
  <form id="createTaskForm" action="./api/task/task_post.cfc?method=create_task_type" method="post">
    <div class="mb-3">
      <label for="task_type_name" class="form-label">Task Type Name:</label>
      <input type="text" id="task_type_name" name="task_type_name" class="form-control" required>
    </div>
    <div class="mb-3">
      <label for="task_category" class="form-label">Task Category:</label>
      <select id="task_category" name="task_category" class="form-control">
          <option value="FEEDBACK">FEEDBACK</option>
          <option value="TO DO">TO DO</option>
      </select>
    </div>
    <div class="mb-3">
      <label for="task_explanation_fr" class="form-label">Task Explaination Fr:</label>
      <input type="text" id="task_explanation_fr" name="task_explanation_fr" class="form-control" >
    </div>
    <div class="mb-3">
      <label for="task_explanation_fr" class="form-label">Task Explaination EN:</label>
      <input type="text" id="task_explanation_en" name="task_explanation_en" class="form-control" >
    </div>
    <div class="mb-3">
      <label for="task_automation" class="form-label">Task Automation Description:</label>
      <input type="text" id="task_automation" name="task_automation" class="form-control" >
    </div>

  
      <cfloop collection="#data#" item="key">
        <div class="mb-3">
          <label class="form-label">#key#:</label>

          <cfif key eq "profileId">
            <div class="d-flex flex-row">
              <cfloop array="#profileArray#" index="i">
                <div class="custom-control custom-checkbox mr-2">
                  <input type="checkbox" class="custom-control-input" id="profileId#i.id#" value="#i.id#" name="PROFILE ID" checked>
                  <label class="custom-control-label" for="profileId#i.id#">#i.name#</label>
                </div>
              </cfloop>
            </div>
          </cfif>

          <cfif key eq "taskGroupAliasColorSub">
            <select id="taskGroupAliasColorSub" name="taskGroupAliasColorSub" class="form-control">
              <cfloop list="#data[key]#" index="i">
                <option value="#i#">#i#</option>
              </cfloop>
            </select>
          </cfif>

          <cfif key eq "taskOnline">
            <select id="taskOnline" name="taskOnline" class="form-control">
              <cfloop list="#data[key]#" index="i">
                <option class="taskOnlineOption" value="#i#">#i#</option>
              </cfloop>
            </select>

          </cfif>
       
        </div>
      </cfloop>
   
   

    <input type="submit" value="Create Task" class="btn btn-primary">
  </form>
</div> </cfoutput>

<script>
  $(document).ready(function() {
  // Click event listener for profileId checkboxes
  $("input[name='PROFILE ID']").click(function() {
    var selectedProfileIds = [];
    $("input[name='PROFILE ID']:checked").each(function() {
      selectedProfileIds.push($(this).val());
    });

    console.log("Selected Profile IDs: " + selectedProfileIds);
  });

  $("input[name='task_type_name']").change(function() {
    var taskTypeName = $(this).val();
    console.log("Task Type Name:", taskTypeName);
  });

  $("#taskGroupAliasColorSub").on("change", function() {
    var taskGroupAliasColorSub = $(this).val();
    console.log("Task Group Alias/Color/Sub:", taskGroupAliasColorSub);
    var parts = taskGroupAliasColorSub.split(".");
  
  var taskGroupAlias = parts[0].trim();
  var taskGroupSub = parts[1].trim();
  var taskGroup = parts[2].trim();
  var taskColor = parts[3].trim();
  var taskGroupRank = parts[4].trim();



  console.log("Task Group Alias:", taskGroupAlias);
  console.log("Task Group Sub:", taskGroupSub);
  console.log("Task Group :", taskGroup);
  console.log("Task Color:", taskColor);
  console.log("Task Group Rank:", taskGroupRank);
  
  });

  $(".taskOnlineOption").change(function() {
    var taskOnline = $(this).val();
    console.log("Task Online:", taskOnline);
  });

  $("#taskOnline").change(function() {
    var taskOnline = $(this).val();
    console.log("Task Online:", taskOnline);
  });

  $("#task_category").change(function() {
    var taskCategory = $(this).val();
    console.log("Task Category:", taskCategory);
  });


  $("#createTaskForm").on('submit', function(e) {
  e.preventDefault();

  var selectedProfileIds = [];
  $("input[name='PROFILE ID']:checked").each(function() {
    selectedProfileIds.push($(this).val());
  });
  var profile_ids_str = selectedProfileIds.join(",");
  var taskTypeName = $("input[name='task_type_name']").val();
  var taskCategory = $("#task_category").val();

  var taskAutomation = $("input[name='task_automation']").val();
  var taskExplanationFr = $("input[name='task_explanation_fr']").val();
  var taskExplanationEn = $("input[name='task_explanation_en']").val(); 
  var taskGroupAliasColorSub = $("#taskGroupAliasColorSub").val();
  var parts = taskGroupAliasColorSub.split(".");

  var taskGroupAlias = parts[0].trim();
  var taskGroupSub = parts[1].trim();
  var taskGroup = parts[2].trim();
  var taskColor = parts[3].trim();
  var taskGroupRank = parts[4].trim();

  var taskOnline = $(".taskOnlineOption").val();

  var data = {
    profile_id: profile_ids_str,
    task_explanation_fr: taskExplanationFr,
    task_explanation_en: taskExplanationEn,
    task_automation: taskAutomation,
    task_group: taskGroup,
    task_type_name: taskTypeName,
    task_group_alias: taskGroupAlias,
    task_color: taskColor,
    task_group_sub: taskGroupSub,
    task_online: taskOnline,
    task_group_rank: taskGroupRank,
    task_category: taskCategory
  };

  $.ajax({
    url: './api/task/task_post.cfc?method=create_task_type',
    type: 'post',
    data: data,
   

    success: function(response) {
  $('#alert-container-add-modal').html('<div class="alert alert-success">Task added</div>');
  setTimeout(function() {
    location.reload();
  }, 3000);  // delay of 3 seconds
},

    error: function(jqXHR, textStatus, errorThrown) {
      console.log(textStatus, errorThrown);
    }
  });
  });
});

</script>


</cfif>