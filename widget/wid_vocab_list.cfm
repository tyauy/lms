<cfparam name="lang_select_id" default="2">
<cfparam name="cat_id" default="1">
<cfparam name="lang_select" default="en">
<cfparam name="lang_translate" default="fr">
<cfparam name="subm" default="vocabulary">
<cfparam name="voc_group" default="47">
<cfparam name="show_header" default="0">

<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
    SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
</cfquery>

<cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_accent_name_#lang_select# as formation_accent_name, formation_accent_id
    FROM lms_formation_accent
    WHERE formation_accent_vocab = 1
    AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lang_select_id#">
</cfquery>

<cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM user_vocablist
    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>

<cfset favorite_list = "">
<cfoutput query="check_uvoc">
    <cfset favorite_list = listappend(favorite_list,voc_id)>
</cfoutput>

<cfif isdefined("show_favorite")>

    <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
        SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category, v.formation_code, v.formation_id, v.voc_cat_id,
        vt.voc_type_name_#lang_select# as voc_type_name
        FROM lms_vocabulary_new v
        LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
        WHERE v.voc_group IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#favorite_list#">)
    </cfquery>

<cfelse>

    <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
        SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category, v.formation_code, v.formation_id, voc_cat_id,
        vt.voc_type_name_#lang_select# as voc_type_name
        FROM lms_vocabulary_new v
        LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
        WHERE v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cat_id#">
            AND formation_code in ('#lang_select#', '#lang_translate#')
            ORDER BY CASE WHEN formation_code = '#lang_select#' THEN v.voc_word END ASC
    </cfquery>
    
</cfif>


<style>
.red {
    color: #D5253C !important;
}
.btn-outline-danger {
    color: #D5253C !important;
    border: solid #D5253C !important;
}
.bg-danger {
    background-color: #D5253C !important;
}
.highlight{
    background-color: #F8A1A8 !important;
}
.sticky-header {
    position: sticky;
    top: 0;
    background-color: inherit;
    z-index: 100;
}
</style>
                      
<cfoutput>
    <div class="<!---border-top border-danger---> bg-light p-2 w-100 d-inline-block mb-3">

        <div class="row m-2 justify-content-between">
            <div class="<cfif show_header eq "1">col-md-4<cfelse>col-md-8</cfif>">
                <h6 class="card-title"><i class="fa-thin fa-gears red"></i>
                    <cfoutput>#obj_translater.get_translate('card_settings')#</cfoutput>
                </h6><br>
                <!--- Display the form --->
                <div class="d-inline-block p-2">
                    <!--- <label for="lang_select" class="mr-sm-2">
                        <cfoutput>#obj_translater.get_translate('table_th_lrn_language')#</cfoutput>
                    </label> --->
                    From :
                    <select name="lang_select" id="lang_select" class="lang_select border-0 mr-sm-2 text-secondary p-2">
                        <option value="fr" <cfif lang_select eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput>
                        </option>
                        <option value="en" <cfif lang_select eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput>
                        </option>
                        <option value="de" <cfif lang_select eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput>
                        </option>
                    </select>
                    To :

                    <select name="translate" id="translate" class="translate border-0 mr-sm-2 text-secondary p-2">
                        <option value="" <cfif lang_translate eq "">selected</cfif>>N/A</option>
                        <option value="fr" <cfif lang_translate eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput>
                        </option>
                        <option value="en" <cfif lang_translate eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput>
                        </option>
                        <option value="de" <cfif lang_translate eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput>
                        </option>
                    </select>


                </div>
                <!--- <div class="d-inline-block p-2"> --->
                    <!--- <label for="translate" class="mr-sm-2 text-important">
                        <cfoutput>#obj_translater.get_translate('table_th_translation')#</cfoutput>
                    </label> --->
                    
                <!--- </div> --->
            </div>
            <cfif show_header eq "1">
                <div class="col-md-4">
                    <h6 class="card-title"><i class="fa-thin fa-photo-film-music red"></i>
                        <cfoutput>#obj_translater.get_translate('card_thematic_list')#</cfoutput>
                    </h6><br>
                    <div class="d-inline-block p-2">
                        <select name="category" id="category" class="border-0 mr-sm-2 text-secondary p-2" disabled>
                            <!--- Get the list of categories from the database --->
                            <cfloop query="get_category">
                                <option value="#get_category.voc_cat_id#" <cfif isdefined("cat_id") AND cat_id eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
                            </cfloop>
                        </select>
                    </div>
                </div> 
            </cfif>
                
            <div class="col-md-4">
                <cfoutput>
                    <a target="_blank" href="./tpl/el_vocablist_container.cfm?voc_cat_id=#cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#&<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-outline-red float-right"><i class="fa-light fa-file-pdf btn_export_list" id="export_#cat_id#"></i> 
                    #obj_translater.get_translate('btn_export')#
                    </a>
                </cfoutput>
            </div>          
        </div>
                    
    </div>
</cfoutput>
                                                


<!--- Query the database to get the vocabulary list based on the selected language and category --->
<div class="table-responsive" style="max-height: 800px;" id="container_table_<cfoutput>#cat_id#</cfoutput>">
    <cfinclude template="./wid_vocab_table.cfm">
</div>