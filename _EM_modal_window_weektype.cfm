<cfoutput>#startDay#</cfoutput>

<cfif isdefined("start")>
	<cfset lesson_st = "#listgetat(start,1,'_')# #replace(listgetat(start,2,'_'),'-',':','ALL')#">
<cfelse>
	<cfset lesson_st = dateformat(now(), 'dd-mm-yyyy 08:00:00')>
</cfif>

<cfif isdefined("end")>
	<cfset lesson_en = "#listgetat(end,1,'_')# #replace(listgetat(end,2,'_'),'-',':','ALL')#">
<cfelse>
	<cfset lesson_en = dateformat(now(), 'dd-mm-yyyy 09:00:00')>
</cfif>	

    <cfform action="http://localhost:8500/dev/lms/api/trainerscal/_EM_weektypePost.cfc" method="post">    
        <div id="alert-container"></div> 

    <!-- Table for displaying form fields -->
    <table class="table">
        <tr>
            <td class="bg-light" width="20%">
                <label>Jour/Day</strong> 
            </td>
            <td colspan="2">
               
                <!-- Input field for entering the date of availability -->
                <cfoutput>#dayName#</cfoutput>
            </td>
        </tr>
       
        <tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_st,"HH:mm")#</cfoutput>
            <cfset startTime =timeformat(lesson_st,"HH:mm") >
			</td>
		</tr>	        
        
        <tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_en,"HH:mm")#</cfoutput>
            <cfset endTime =timeformat(lesson_en,"HH:mm") >
			</td>
		</tr>	
    </table>

    <cfoutput>
    <!-- Hidden input fields for passing form data to the "updater_avail_em.cfm" file -->
    <input type="hidden" name="updt_avail" value="1">
    <input type="hidden" name="startTime" value="#startTime#">
	<input type="hidden" name="endTime" value="#endTime#">
    <input type="hidden" name="p_id" value="#p_id#">
    <input type="hidden" name="weekday" value="#startDay#">


    <!-- Submit button for saving changes -->
    <div align="center"><input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-outline-info">
    </div>
    </cfoutput>
    </cfform>
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">
    <script>
        $(document).ready(function() {
          var p_id= parseInt($("input[name='p_id']").val());
          var weekday = parseInt($("input[name='weekday']").val());
             
               
            $("form").submit(function(event) {
                event.preventDefault();
                var formData = {
                updt_avail: parseInt($("input[name='updt_avail']").val()),
                startTime: $("input[name='startTime']").val(),
                endTime: $("input[name='endTime']").val(),
                weekday: parseInt($("input[name='weekday']").val()),
                p_id: parseInt($("input[name='p_id']").val())
                };


                $.ajax({
                type: "POST",
                url: "http://localhost:8500/dev/lms/api/trainerscal/_EM_weektypePost.cfc?method=insertWorkingHours",
                data: {formDataJson: JSON.stringify(formData)},

                success: function(response) {
                $('#window_item_lg').modal('hide');
                $('#alert-container').html('<div class="alert alert-success">Vacations added</div>');

                setTimeout(() => {
                    
                    // Set the calendar url to the last month visited
                    var fullcalendarUrl = "_EM_weektype.cfm?p_id="+p_id;
                    window.location.href = fullcalendarUrl;
              
                }, 1000);

            },

                error: function(xhr, status, error) {
                    alert("fail");
                }
                });

            });
        });
    </script>
    
    