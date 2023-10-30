


    <cfform action="http://localhost:8500/dev/lms/api/trainerscal/vacation_post.cfc" method="post">    
        <div id="alert-container"></div> 

    <!-- Table for displaying form fields -->
    <table class="table">
        <cfoutput>#obj_translater.get_translate('modal_vacay_add')#</cfoutput> 
        <br>
        <br>
        <tr>
            <td class="bg-light">
                <label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label> 
            </td>
            <td colspan="2">
                
                <!-- Input field for entering the start time of availability -->
                <cfoutput>#dateformat(start,"dd/mm/yyyy")#</cfoutput>
              
            </td>
        </tr>        
        <tr>
            <td class="bg-light">
                <label><cfoutput>#obj_translater.get_translate('table_th_end')#</cfoutput></label> 
            </td>
            <td colspan="2">
               
                <!-- Input field for entering the end time of availability -->
                <cfoutput>#dateformat(end,"dd/mm/yyyy")#</cfoutput>
               
            </td>
        </tr>
    </table>
  
    <cfoutput>
    <!-- Hidden input fields for passing form data to the "updater_avail_em.cfm" file -->
    <input type="hidden" name="updt_avail" value="1">
    <input type="hidden" name="lesson_st" value="#start#">
	<input type="hidden" name="lesson_en" value="#end#">
    <input type="hidden" name="p_id" value="#p_id#">


    <!-- Submit button for saving changes -->
    <div class="modal-footer">
        <input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-outline-info">
        <button type="button" class="btn btn-default" data-dismiss="modal" >#obj_translater.get_translate('btn_cancel_short')#</button>
        
    </div>
    </cfoutput>
    </cfform>
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">
    <script>
        $(document).ready(function() {
          var p_id= parseInt($("input[name='p_id']").val());
             
               
            $("form").submit(function(event) {
                event.preventDefault();
                var formData = {
                updt_avail: parseInt($("input[name='updt_avail']").val()),
                start: $("input[name='lesson_st']").val(),
                end: $("input[name='lesson_en']").val(),
                p_id: parseInt($("input[name='p_id']").val())
                };

          

                $.ajax({
                type: "POST",
                url: "./api/trainerscal/vacation_post.cfc?method=addHolidays",
                data: {formDataJson: JSON.stringify(formData)},

                success: function(response) {
                $('#window_item_lg').modal('hide');
                $('#alert-container').html('<div class="alert alert-success">Vacations added</div>');

                setTimeout(() => {
                    // Retrieve the last month and year from session storage
                    var lastMonth = sessionStorage.getItem("lastMonth");
                    var lastYear = sessionStorage.getItem("lastYear");
                    // Set the calendar url to the last month visited
                    var fullcalendarUrl = "common_trainer_vacations.cfm?p_id="+p_id+"&lastMonth="+lastMonth+"&lastYear="+lastYear;
                    window.location.href = fullcalendarUrl;
              
                }, 2000);

            },

                error: function(xhr, status, error) {
                    alert("fail");
                }
                });

            });
        });
    </script>
    
    