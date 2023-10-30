<cfparam name="lvl_id" default="0">


<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_level
WHERE level_id NOT IN (0,6) 
</cfquery>

<cfset level_lock = 6>
<cfif StructKeyExists(SESSION.USER_LEVEL,'en')>
    <cfset level_lock = SESSION.USER_LEVEL['en'].level_id>
</cfif>

<cfset get_tp_vc = obj_tp_get.oget_tps(st_id="1,2",m_id="10",o_by="tp_level",no_users="1",f_id="2",lvl_max_id="#level_lock#")>
<!--- <cfdump var="#get_tp_virtual#"> --->
<div class="row mt-1 justify-content-md-center">

    <div class="col-md-12">

        <div class="card border">
            <div class="card-body">


                <div id="accordion_top">
                    <div class="row">
                        <div class="col-md-3">
                            <div align="center" class="mb-3">
                                <div class="btn-group-toggle" data-toggle="buttons">	

                                    <em><cfoutput>#obj_translater.get_translate('vc_explain_virtual_box_title3')#</cfoutput></em><br><br>
                                        
                                    <cfoutput query="get_level">
                                        <cfif isdefined("level_lock")>
                                            <label class="btn btn-outline-#level_alias# text-#level_alias# btn-lg w-100 p-2 px-3 <cfif level_lock lt level_id>disabled<cfelse><cfif lvl_id eq level_id>active</cfif></cfif>" data-toggle="collapse" data-target="##collapse_#level_id#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <!---required--->> 
                                                <h5>#level_alias#</h5>
                                            </label>
                                        <cfelse>
                                            <label class="btn btn-outline-#level_alias# text-#level_alias# btn-lg w-100 p-2 px-3 <cfif lvl_id eq level_id>active</cfif>" data-toggle="collapse" data-target="##collapse_#level_id#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <!---required--->> 
                                                <h5>#level_alias#</h5>
                                            </label>
                                        </cfif>
                                    </cfoutput>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-9">
                            <!--- <cfdump var="#get_tp_vc#"> --->
                            <cfoutput query="get_tp_vc" group="tplevel_id">
                                
                                <div id="collapse_#tplevel_id#" class="<cfif lvl_id eq tplevel_id>show<cfelse>collapse</cfif>" data-parent="##accordion_top">	
                                    <cfoutput>
                                        <div class="row">
                            
                                            <div class="col-md-12">
                                                <cfset view = "details,subscribe">
                                                <cfinclude template="./incl/incl_tp_header.cfm">
                                            </div>

                                        </div>
                                    </cfoutput>

                                </div>
                            </cfoutput>
                            
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
$(document).ready(function() {

    $('.btn_view_tp').click(function(event) {
        event.preventDefault();		
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var tp_id = idtemp[1];	
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
        $('#modal_body_xl').load("modal_window_tpview_virtual.cfm?tp_id="+tp_id, function() {});
    });

    $('.btn_subscribe_class').click(function(event) {
		event.preventDefault();		
		var tp_id = event.target.dataset.tid;
		// alert(tp_id);
        $.ajax({				 
			url: './api/virtualclass/virtualclass_post.cfc?method=subscribe_class',
			type: 'POST',
			data: {tp_id: event.target.dataset.tid },
			success : function(result, status){
                $('#modal_body_xl').empty();
				<cfif isdefined("referrer") AND referrer eq "hp">
					document.location.href="learner_virtual.cfm?k=1";
					// alert("coming from HP");
				<cfelseif isdefined("referrer") AND referrer eq "vc">
					if(result == "2")
					{
						$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&k=1&tp_id="+tp_id, function() {});
					}
					else
					{
						$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&k=2&tp_id="+tp_id, function() {});
					}
					// alert("coming from VC");
				<cfelse>
					// alert("coming from NC");
					document.location.href="learner_virtual.cfm?k=1";
				</cfif> 
				
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

});
</script>