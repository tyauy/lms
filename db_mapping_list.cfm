<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,4,5,12">
	<cfinclude template="./incl/incl_secure.cfm">		
    <cfif not isDefined("f_id")>
        <cfset f_id = 2>
    </cfif>

    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation
    </cfquery>	
        
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Mapping list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div id="accordion_grammar_top">
                <div align="center" class="mb-3">
                    <div class="pull-right">			
                        <select class="form-control" onChange="document.location.href='db_mapping_list.cfm?f_id='+$(this).val()">
                        <cfoutput query="get_formation">
                        <option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
                        </cfoutput>
                        <select>
                    </div>
                    <div class="btn-group-toggle" data-toggle="buttons">	
                        <cfloop list="A1,A2,B1,B2,C1" index="cor">
                            <cfif findnocase("A1",cor)>
                                <cfset css = "success">
                            <cfelseif findnocase("A2",cor)>
                                <cfset css = "primary">
                            <cfelseif findnocase("B1",cor)>
                                <cfset css = "info">
                            <cfelseif findnocase("B2",cor)>
                                <cfset css = "warning">
                            <cfelseif findnocase("C1",cor)>
                                <cfset css = "danger">
                            </cfif>
                            
                            <cfoutput><label class="btn btn-lg btn-outline-#css# <cfif cor eq "A1">active</cfif>" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <!---required--->> #cor#</label></cfoutput>
                        
                        </cfloop>
                    </div>
                </div>

                <cfloop list="A1,A2,B1,B2,C1" index="cor">
                    <cfoutput>
                    <div id="collapse_grammar_sub_#cor#" class="collapse <cfif cor eq "A1">show</cfif> p-2" data-parent="##accordion_grammar_top">	
                        
                        <cfif cor eq "A1">	
                            <cfset list_level = "A1_1,A1_2,A1_3">
                        <cfelseif cor eq "A2">	
                            <cfset list_level = "A2_1,A2_2,A2_3">
                        <cfelseif cor eq "B1">
                            <cfset list_level = "B1_1,B1_2,B1_3">
                        <cfelseif cor eq "B2">
                            <cfset list_level = "B2_1,B2_2,B2_3">
                        <cfelseif cor eq "C1">
                            <cfset list_level = "C1_1,C1_2,C1_3">
                        </cfif>
                        
                        <div class="row">
                        
                            
                        <cfloop list="#list_level#" index="cor2">
                     
                        <cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
                        SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' and mapping_category != 'NA' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                        </cfquery>

                            <cfif findnocase("A1_",cor2)>
                                <cfset css = "success">
                            <cfelseif findnocase("A2_",cor2)>
                                <cfset css = "primary">
                            <cfelseif findnocase("B1_",cor2)>
                                <cfset css = "info">
                            <cfelseif findnocase("B2_",cor2)>
                                <cfset css = "warning">
                            <cfelseif findnocase("C1_",cor2)>
                                <cfset css = "danger">
                            </cfif>			
                            <div class="col-md-4">
                                <div class="card border h-100">
                                    <h3 align="center" class="text-#css# m-0 font-weight-bold">#replace(cor2,"_",".")#</h3>
                                
                                    <div class="card-body">
                                    
                                    <table class="table table-sm">
                                        <tr class="bg-#css#">
                                            <td>GRAMMAR #replace(cor2,"_",".")#</td>
                                            <td>Resources</td>
                                            <td>Quiz attached</td>
                                            <td>Email template</td>
                                            <td>Vocab list</td>
                                        </tr>
                                       
                                    <cfloop query="get_mapping_grammar">
                                        <cfquery name="get_mapping_sm" datasource="#SESSION.BDDSOURCE#">
                                        SELECT sm.sessionmaster_id
                                        FROM lms_sessionmaster_grammarid_cor sg 
                                        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = sg.sessionmaster_id
                                        JOIN lms_grammar_mapping_cor gm ON sg.grammar_id = gm.lms_grammar_id
                                        JOIN lms_mapping m ON gm.lms_mapping_id = m.mapping_id
                                        JOIN lms_grammar g ON gm.lms_grammar_id = g.grammar_id
                                        INNER JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
                                        INNER JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id
                                        WHERE m.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                                        AND tm.tpmaster_id IN (11,12,13,14)
                                        </cfquery>
                                        
                                        
                                        <tr class="table-#css#">
                                            <td>
                                                #get_mapping_grammar.mapping_id# #get_mapping_grammar.mapping_name#
                                            </td>
                                            <td>
                                                #get_mapping_sm.recordcount#
                                                <!--- <a href="javascript:void(0)" class="nb-link text-dark" data-mapping-id="#get_mapping_grammar.mapping_id#">#result#</a> --->
                                            </td>
                                            <td>  
                                            
                                                <cfquery name="get_quiz_mapping" datasource="#SESSION.BDDSOURCE#">
                                                    SELECT COUNT(*) as total_count
                                                    FROM (
                                                        (
                                                            SELECT lq.quiz_id
                                                            FROM lms_quiz lq
                                                            INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = lq.sessionmaster_id
                                                            JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
                                                            JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id
                                                            INNER JOIN lms_grammar_mapping_cor cor ON cor.lms_grammar_id = sm.grammar_id
                                                            WHERE cor.lms_mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                                                            AND tm.tpmaster_id IN (11, 12, 13, 14)
                                                        )
                                                        UNION ALL
                                                        (
                                                            SELECT lq.quiz_id
                                                            FROM lms_quiz lq
                                                            JOIN lms_quiz_mapping_cor cor ON cor.quiz_id = lq.quiz_id
                                                            WHERE cor.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                                                        )
                                                    ) AS combined_results
                                                </cfquery>
                                                <cfif get_quiz_mapping.RecordCount>
                                                    <a href="javascript:void(0)" class="quiz-link text-dark" data-mapping-id="#mapping_id#">#get_quiz_mapping.total_count#</a>
                                                <cfelse>
                                                    -
                                                </cfif>
                                                
                                            </td>
                                            
                                            
                                            <td>
                                               
                                            </td>
                                            <td>
                                          

                                            </td>
                                        </tr>
                                        
                                    </cfloop>
                                    </table>
                                    
                                    </div>
                                </div>													
                            </div>
                        </cfloop>
                        
                        </div>
                        
                    </div>
                    </cfoutput>
                    
                </cfloop>
            </div>
			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
  $(".nb-link").on("click", function() {
    var mappingId = $(this).data("mapping-id");

    // Retrieve the associated resource names using an AJAX call and populate the modal content
    $.ajax({
      url: "_EM_get_resource_names.cfm",
      type: "GET",
      data: { mapping_id: mappingId,
        type: 'resource' // Specify the type as 'resource'
        },
      success: function (data) {
        $("#resourcesModalBody").html(data);
        $("#resourcesModal").modal("show");
      },
      error: function() {
        alert("An error occurred while retrieving the resource names.");
      }
    });
  });

    // AJAX request for quiz names
    $(".quiz-link").on("click", function() {
    
    var mappingId = $(this).data("mapping-id");
    $.ajax({
      url: "_EM_get_resource_names.cfm",
      type: "GET",
      data: { 
        mapping_id: mappingId,
        type: 'quiz' // Specify the type as 'quiz'
      },
      success: function (data) {
        $("#quizModalBody").html(data);
        $("#quizModal").modal("show");
      },
      error: function() {
        alert("An error occurred while retrieving the quiz names.");
      }
    });
  });
});

</script>

<!-- Resource Names Modal -->
<div class="modal" tabindex="-1" id="resourcesModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Resource Names</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body" id="resourcesModalBody">
          <!-- The resource list will be populated here -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Quiz Names Modal -->
  <div class="modal fade" id="quizModal" tabindex="-1" role="dialog" aria-labelledby="quizModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="quizModalLabel">Quizzes</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="quizModalBody">
                <!-- Quiz names will be displayed here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

  
  
  
</body>
</html>