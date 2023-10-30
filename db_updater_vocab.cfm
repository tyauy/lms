<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,4,5,7,8,9,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfparam name="vocab_id" default="0">
<cfparam name="vcl_id" default="1">
<cfparam name="path" default="">

<cfset internal_path = "#SESSION.BO_ROOT#/parser/temp_vocab/#path#">
<cfset ext_path = "#SESSION.BO_ROOT_URL#/parser/temp_vocab/#path#">

<cfdirectory directory="#internal_path#" name="dirQuery" action="LIST" sort="name ASC">

<cfset show_word_list = 0>
<cfset el_count = dirQuery.recordcount>

<cfif vocab_id neq "">
    <cfquery name="get_vocab_list" datasource="#SESSION.BDDSOURCE#">
        SELECT voc_id, voc_word, voc_desc, voc_category
        FROM lms_vocabulary_new 
        WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
        AND voc_id >= <cfqueryparam cfsqltype="cf_sql_integer" value="#vocab_id#">
        and formation_id = 2
        ORDER BY voc_id ASC
        LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#el_count#">
    </cfquery>
</cfif>

<cfquery name="get_language" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name FROM lms_formation WHERE formation_language = 1 ORDER BY language_name
</cfquery>

<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
	SELECT voc_cat_id, voc_cat_name FROM lms_vocabulary_category ORDER BY voc_cat_name
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
      
		<cfset title_page = "Vocab">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

            <div class="row">
                <div class="col-md-6">
                    <form action="db_updater_vocab.cfm">
                        
                        <h6 class="card-title">Starting point :</h6>
                        <div class="form-row">

    
                            <div class="col">
                                <select name="vcl_id" class="select_voc_cat form-control">								
                                    <cfoutput query="get_category">
                                    <option value="#get_category.voc_cat_id#" <cfif isdefined("vcl_id") AND vcl_id eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
                                    </cfoutput>							
                                </select>
                            </div>

                            <div class="col">
                                <input type="hidden" id="vocab_id" name="vocab_id" class="form-control form-control-sm" value="<cfoutput>#vocab_id#</cfoutput>">
                            
                            </div>
                            
                            <div class="col">
                                <input type="hidden" name="path" value="<cfoutput>#path#</cfoutput>">
                                <input type="submit" value="GO" class="btn btn-sm btn-info">
                            </div>
    
                        </div>
                            
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col">
                            <select class="form-control" id="formation_teaching_id" name="formation_teaching_id">
                                <option value="0">--Select--</option>
                                <cfoutput query="get_language">
                                <option value="#formation_id#">#language_name#</option>
                                </cfoutput>
                            </select>
                        </div>
                        <div class="col">
                            <select class="form-control" id="formation_accent_id" name="formation_accent_id">
                                <option value="0">--Select--</option>
                            </select>
                        </div>

                        <div class="col">
                            <input type="hidden" name="path" value="<cfoutput>#path#</cfoutput>">
                            <input type="submit" id="save_vocab" value="Save" class="btn btn-success">
                        </div>

                    </div>
                    
                </div>
            </div>

            <div class="row">
                
                <div class="col-md-6">
                    <table class="table table-sm table-bordered" id="file_holder">

                        <!--- <tr>
                            <th class="bg-light" colspan="2">
                            <div align="center"><label>PI&Egrave;CE JOINTE</label></div>
                            </th>
                        </tr> --->

                            
                        
                        <cfif dirQuery.recordcount eq "0">
                            <tr id="file_none">
                                <td colspan="2" align="center"><em>Aucun fichier</em></td>
                            </tr>
                        <cfelse>
                        
                            <cfoutput>
                                <!--- <cfdump var="#path#"> --->

                            <cfloop query="dirQuery">
                                <!--- <cfdump var="#dirQuery#"> --->

                                <cfif dirQuery.type eq "dir">

                                    <tr id="file_#dirQuery.currentRow#" style="height: 88px">

                                        <td>
                                            #dirQuery.currentRow#
                                        </td>
                                        <td>
                                            <form action="db_updater_vocab.cfm">

                                                <input type="hidden" name="vcl_id" value="#vcl_id#">
                                                <input type="hidden" name="path" value="#path#/#name#">
                                                <input type="submit" value="#name#" class="btn btn-sm btn-info">
                                                    
                                            </form>
                                            
                                        </td>
                                    </tr>

                                <cfelse>
                                    <cfset show_word_list = 1>
                                    <tr id="file_#dirQuery.currentRow#" style="height: 67px">
                                        <!--- <th class="bg-light" width="30%">
                                        <label>Fichier</label>
                                        </th> --->
                                        <td>
                                            #dirQuery.currentRow#
                                        </td>
                                        <td>
                                            <audio controls="controls">
                                                <source src="#ext_path#/#name#" type="audio/mp3" />
                                                #obj_translater.get_translate('alert_not_compatible')#
                                            </audio>
                                        </br>
                                            <a href="#ext_path#/#name#" target="_blank">#mid(name,1,25)#...</a>
                                       
                                        <!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
                                        <!---  --->
                                        <!--- <a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="#name#" id="delete_doc_#dirQuery.currentRow#"><i class="fal fa-trash-alt"></i></i></a> --->
                                        <!--- </td>
                                        <td> --->
                                            
                                        </td>
                                    </tr>
                                </cfif>

                            </cfloop>
                            </cfoutput>
                        
                        </cfif>
                
                    </table>
                </div>

                <div class="col-md-6">
                    <table id="table_vocab" class="table table-sm table-bordered" id="file_holder">
                        <tbody id="tbody_sortable"> 
                        <cfif isDefined("get_vocab_list")>
                            <cfif show_word_list eq 0 OR get_vocab_list.recordcount eq "0">
                                <tr id="file_none">
                                    <td colspan="2" align="center"><em>-</em></td>
                                </tr>
                            <cfelse>
                                <cfoutput query="get_vocab_list">
                                    <tr id="file_#voc_id#" style="height: 91px">

                                        <td>
                                            #voc_id#
                                        </td>
                                        <td>
                                            #voc_word#
                                        </td>
                                        <!--- <td>
                                            #voc_category#
                                        </td>
                                        <td>
                                            #voc_desc_en#
                                        </td> --->
                                    </tr>
                                    
                                </cfoutput>
                                
                            </cfif>
                        </cfif>
                            
                    </tbody> 
                    </table>
                </div>


            </div>
				
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	
	</div>
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	$("#save_vocab").click(function(event) {
		event.preventDefault();

        var formation_id = $('#formation_teaching_id').val();
        var accent_id = $("#formation_accent_id").val();

        if(formation_id == "0")
        {
            alert("Veuillez entrer une langue SVP.");
        }
        else
        {
            var list = "";

            $("#table_vocab tr").each(function( index ) {
                var idtemp = this.getAttribute("id").split("_");

                if (list != "") list += ",";
                list += idtemp[1];
            });
            console.log(list);

            console.log("!", $("#vocab_id").val());
            $.ajax({
                url : './api/vocab/vocab_post.cfc?method=vocab_rename_audio',
                type : 'POST',
                data : {
                    start_id:  $("#vocab_id").val(),
                    vcl_id: <cfoutput>#vcl_id#</cfoutput>,
                    path: "<cfoutput>#path#</cfoutput>",
                    el_count: <cfoutput>#el_count#</cfoutput>,
                    formation_id: formation_id,
                    accent_id: accent_id,
                    list: list
                },
                success : function(result, status) {
                    console.log(result);
                    alert("success");
                },error : function(result, statut, erreur){
					console.log(result);
                    alert("eorror");
				},
            });
        }
	
	});

    $("#formation_teaching_id").change(function(event) {
        // console.log($(this).val());
        $.ajax({
            url : './api/users/user_trainer_get.cfc?method=get_accent',
            type : 'POST',
            data : {
                formation_accent_vocab:1,
                formation_teaching_id:$(this).val()
            },				
            success : function(result, status) {
                // $(".tr_teaching_"+teaching_id+"").remove();
                var obj_result = jQuery.parseJSON(result);
                $('#formation_accent_id').empty()
                $('#formation_accent_id').append($('<option>', { 
                        value: "0",
                        text : "--Select--"
                    }));


                $.each(obj_result, function (i, item) {
                    $('#formation_accent_id').append($('<option>', { 
                        value: item["FORMATION_ACCENT_ID"],
                        text : item["<cfoutput>FORMATION_ACCENT_NAME</cfoutput>".toUpperCase()]
                    }));
                });
            }
        });
    });


    $('#tbody_sortable').sortable({
        items: "tr:not(.unsortable)",
        update: function(e, ui) {
            
            // list = "";
           

            // console.log(list);
        }
    });


})
</script>

</body>
</html>
