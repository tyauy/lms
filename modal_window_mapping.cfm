<cfif isdefined("mp_id")>

<script>
tinymce.init({
  selector: '#mapping_explanation_long',
  branding: false,
  contextmenu: "link image imagetools table spellchecker",
  contextmenu_never_use_native: true,
  draggable_modal: false,
  menubar: 'insert',
  toolbar: 'undo redo | bold italic underline | h5 h6 | numlist bullist link image forecolor backcolor | table code',
  plugins: "lists,link,code,table,textcolor,image code,imagetools",
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
<cfset lang=url.lang>
<cfquery name="get_mapping_single" datasource="#SESSION.BDDSOURCE#">
SELECT mapping_id, mapping_name_#lang# as mapping_name, description_#lang# as description, mapping_explanation_long_#lang# as mapping_explanation_long 
FROM lms_mapping
WHERE mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mp_id#">
</cfquery>


<h6>Edit guidelines</h6>
<form id="form_task_updt" method="post">
 <cfoutput> <textarea name="mapping_explanation_long" id="mapping_explanation_long" class="form-control tinymce-editor">#get_mapping_single.mapping_explanation_long#</textarea></cfoutput>

<cfoutput><input type="hidden" name="mp_id" value="#mp_id#">
  <input type="hidden" name="lang" value="#lang#">
</cfoutput>

<div align="center"><button type="submit" id="submit_mapping_edit" class="btn btn-red">Save</button></div>
</form>

<script>
  $(document).ready(function() {

    $('#submit_mapping_edit').click(function(){
      event.preventDefault();
      tinymce.get('mapping_explanation_long').save();
      console.log($('#form_task_updt').serialize());

      // console.log($('#task_explanation_long').val());
      // console.log($('#form_task_updt').serialize());
      $.ajax({				  
          url: './api/mapping/mapping_post.cfc?method=updt_mapping_type',
          type: 'POST',
          data : $('#form_task_updt').serialize(),
          datatype : "html", 
          success : function(result, status){ 
              console.log(result);
              window.location.reload(true);
          }, 
          error : function(result, status, error){ 
              console.log(result);
          }	 
      });

    })

  })
<cfelse>





  <cfoutput>
<!--- Create Task Form --->
<div class="container py-4">
  <div id="alert-container-add-modal"></div>
  <form id="createMappingForm" >

<div class="mb-3">
  <label for="mapping_name" class="form-label">Mapping name</label>
  <input type="text" id="mapping_name" name="mapping_name" class="form-control">
</div>

<div class="mb-3">
  <label for="formation_id" class="form-label">Formation ID</label>
  <select id="formation_id" name="formation_id" class="form-control">
      <cfquery name="getFormationId" datasource="#SESSION.BDDSOURCE#">
          SELECT DISTINCT formation_id FROM lms_mapping
      </cfquery>
      <cfloop query="getFormationId">
          <option value="#getFormationId.formation_id#">#getFormationId.formation_id#</option>
      </cfloop>
  </select>
</div>

<div class="mb-3">
  <label for="level" class="form-label">Level</label>
  <select id="level" name="level" class="form-control">
      <cfquery name="getLevels" datasource="#SESSION.BDDSOURCE#">
          SELECT DISTINCT level FROM lms_mapping
      </cfquery>
      <cfloop query="getLevels">
          <option value="#getLevels.level#">#getLevels.level#</option>
      </cfloop>
  </select>
</div>

<div class="mb-3">
  <label for="mapping_category" class="form-label">Mapping Category</label>
  <select id="mapping_category" name="mapping_category" class="form-control">
      <cfquery name="getCategories" datasource="#SESSION.BDDSOURCE#">
          SELECT DISTINCT mapping_category FROM lms_mapping WHERE mapping_category != 'NA'
      </cfquery>
      <cfloop query="getCategories">
          <option value="#getCategories.mapping_category#">#getCategories.mapping_category#</option>
      </cfloop>
  </select>
</div>

<input type="submit" value="Create mapping" class="btn btn-primary">
</form>

</div> </cfoutput>

<script>
  $(document).ready(function() {
  // Click event listener for profileId checkboxes
 
  $("input[name='task_type_name']").change(function() {
    var taskTypeName = $(this).val();
    console.log("Task Type Name:", taskTypeName);
  });

 

  $("#createMappingForm").on('submit', function(e) {
  e.preventDefault();

  var mappingName = $("input[name='mapping_name']").val();
  var formationId = $("select[name='formation_id']").val();
  var level = $("select[name='level']").val();
  var mappingCategory = $("select[name='mapping_category']").val();
 
  var data = {
    mapping_name: mappingName,
    formation_id: formationId,
    level: level,
    mapping_category: mappingCategory
  };

  $.ajax({
    url: './api/mapping/mapping_post.cfc?method=new_mapping',
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