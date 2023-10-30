<cfparam name="lang_select_id" default="2">
<!--- <cfparam name="cat_id" default="1"> --->
<cfparam name="lang_select" default="en">
<cfparam name="lang_translate" default="fr">
<cfparam name="subm" default="vocabulary_perso">
<cfparam name="voc_group" default="47">
<cfif isDefined("URL.cat_id")>
    <cfset cat_id=URL.cat_id>
 <cfelse>
    <cfset cat_id=0>
 </cfif>

<cfif isDefined("URL.lang_select")>
    <cfset lang_select=URL.lang_select>
 <cfelse>
    <cfset lang_select= "en">
 </cfif>
 
 <cfif isDefined("URL.lang_translate")>
    <cfset lang_translate=URL.lang_translate>
 <cfelse>
    <cfset lang_translate=SESSION.LANG_CODE>
 </cfif>

 <cfif isDefined("URL.lang_select")>
    <cfset lang_select_code=URL.lang_select>
 <cfelse>
    <cfset lang_select_code= "en">
 </cfif>


<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
    SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
</cfquery>

<cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_accent_name_#lang_select# as formation_accent_name, formation_accent_id
    FROM lms_formation_accent
    WHERE formation_accent_vocab = 1
    AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lang_select_id#">
</cfquery>

<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
    SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category, v.formation_code, v.formation_id, v.voc_cat_id as voc_cat_id,
    vt.voc_type_name_#lang_select# as voc_type_name,
    vcat.voc_cat_name_#lang_select# as voc_cat_name 
    FROM lms_vocabulary_new v
    LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
    INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_group
    LEFT JOIN lms_vocabulary_category vcat ON v.voc_cat_id = vcat.voc_cat_id
    where uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        AND formation_code in ('#lang_select#', '#lang_translate#')
    ORDER BY CASE WHEN formation_code = '#lang_select#' THEN v.voc_word END ASC
</cfquery>

<cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
    SELECT v.voc_id, v.voc_word, v.voc_group, v.voc_desc, vc.voc_cat_name_#lang_select# as voc_cat_name, v.voc_cat_id
    FROM lms_vocabulary_new v
    INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
    WHERE voc_cat_online = 1
    AND formation_code in ('#lang_select#')
</cfquery>



<style>
.highlight{
    background-color: #F8A1A8 !important;
}
.sticky-header {
position: sticky;
top: 0;
background-color: inherit;
z-index: 100;
} 
table.dataTable thead th.sorting::before,
    table.dataTable thead th.sorting_asc::before,
    table.dataTable thead th.sorting_desc::before,
    table.dataTable thead th.sorting::after,
    table.dataTable thead th.sorting_asc::after,
    table.dataTable thead th.sorting_desc::after {
        margin-left: 10px; /* Adjust this value to increase or decrease the space */
    }

</style>


                      
<!--- <div class="card">
    <div class="card-body">                                        
        <div class="row p-3">
            <div class="col-md-12"> --->
                <cfoutput>
                    <div class="border bg-light p-2 w-100 d-inline-block mb-3">
                        <div id="alert-container"></div>
                        <div class="row m-2">
                            <div class="col-6">
                                <h6 class="card-title">
                                    <!--- <i class="fa-thin fa-gears red"></i> --->
                                    <cfoutput>#obj_translater.get_translate('card_settings')#</cfoutput>
                                </h6><br>
                                <!--- Display the form --->
                                <div class="d-inline-block p-2">
                                    <label for="lang_select" class="mr-sm-2">
                                        <cfoutput>#obj_translater.get_translate('table_th_lrn_language')#</cfoutput>
                                    </label>
                                    <select name="lang_select" id="lang_select" class="border-0 mr-sm-2 text-secondary p-2 lang_select">
                                        <option value="fr" <cfif lang_select eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput>
                                        </option>
                                        <option value="en" <cfif lang_select eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput>
                                        </option>
                                        <option value="de" <cfif lang_select eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput>
                                        </option>
                                    </select>
                                </div>
                            
                                <div class="d-inline-block p-2">
                                    <label for="translate" class="mr-sm-2 text-important">
                                        <cfoutput>#obj_translater.get_translate('table_th_translation')#</cfoutput>
                                    </label>
                                    <select name="translate" id="translate" class="border-0 mr-sm-2 text-secondary p-2 translate">
                                        <option value="" <cfif lang_translate eq "">selected</cfif>>N/A</option>
                                        <option value="fr" <cfif lang_translate eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput>
                                        </option>
                                        <option value="en" <cfif lang_translate eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput>
                                        </option>
                                        <option value="de" <cfif lang_translate eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput>
                                        </option>
                                    </select>
                                </div>
                            </div>  
                            <div class="col-6">
                                <cfoutput><a target="_blank" href="./tpl/el_vocablist_container.cfm?voc_cat_id=#cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#&<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-info float-right"><i class="fad fa-file-pdf btn_export_list" id="export_#cat_id#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
                            </div> 
                            
                            
                        </div>
                                   
                    </div>
                </cfoutput>
                                                                
                                <cfset selectedWords={}>
                                <cfset selectedDescs={}>
                                
                                 

                            <cfswitch expression="#lang_select_code#">
                                <cfcase value="en">
                                    <cfset lang_select_id=2>
                                </cfcase>
                                <cfcase value="fr">
                                    <cfset lang_select_id=1>
                                </cfcase>
                                <cfcase value="de">
                                    <cfset lang_select_id=3>
                                </cfcase>
                                <cfdefaultcase>
                                    <cfset lang_select_id=2>
                                </cfdefaultcase>
                            </cfswitch>

                            <!--- Query the database to get the vocabulary list based on the selected language and category --->

                <div class="table-responsive" style="max-height: 500px;">
                    <table class="table table-bordered text-center" id="table-pdf">
                        <cfoutput>
                            <thead>
                     
                                <tr class="bg-red text-light text-center sticky-header">

                                    <th class="p-1" style="min-width:150px">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select#")# </th>
                                    <th class="p-1" style="min-width:100px">#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select#")#</th>
                                    <cfif lang_translate NEQ "">
                                        <th class="p-1">#obj_translater.get_translate(id_translate="table_th_translation",lg_translate="#lang_select#")#</th>
                                    </cfif>
                                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select#")#</th>
                                    <th class="p-1"><i class="fa-light fa-volume"></i></th>
                                    <th>#obj_translater.get_translate(id_translate="table_th_vocab_category",lg_translate="#lang_select#")#</th>
                                    <th class="p-1"></th>
                                </tr>
                            </thead>
                       
                        </cfoutput>
                        <tbody>
                            <cfset vocabData = {}>

                        <cfoutput query="get_vocabulary">
                            <cfif formation_code eq lang_select>
                                <cfif NOT structKeyExists(vocabData, voc_group)>
                                    <cfset vocabData[voc_group] = {}>
                                </cfif>
                                <cfset vocabData[voc_group]["lang_select"] = {
                                    "voc_id" = voc_id,
                                    "voc_cat_name" = voc_cat_name,
                                    "voc_cat_id" = voc_cat_id,
                                    "voc_word" = voc_word,
                                    "voc_desc" = voc_desc,
                                    "voc_type_name"= voc_type_name,
                                    "voc_group" = voc_group
                                }>
                            </cfif>
                            
                            <cfif formation_code eq lang_translate AND lang_translate NEQ "">
                                <cfif NOT structKeyExists(vocabData, voc_group)>
                                    <cfset vocabData[voc_group] = {}>
                                </cfif>
                                <cfset vocabData[voc_group]["lang_translate"] = {
                                    "voc_id" = voc_id,
                                    "voc_word" = voc_word,
                                    "voc_cat_id" = voc_cat_id,
                                    "voc_cat_name" = voc_cat_name,
                                    "voc_desc" = voc_desc,
                                    "voc_group" = voc_group
                                }>
                            </cfif>
                        </cfoutput>
                        <cfset targetVocCatId = cat_id> 

                        <cfloop item="vocGroup" collection="#vocabData#">
                        
                                <cfoutput>
                                    <tr id="voc_row_#vocabData[vocGroup]["lang_select"]["voc_id"]#"<cfif isdefined("url.v_id") AND vocabData[vocGroup]["lang_select"]["voc_id"] eq v_id>class="highlight"</cfif>>
                                        <td><strong>#vocabData[vocGroup]["lang_select"]["voc_word"]#</strong> </td>
                                        <td class="p-1">#vocabData[vocGroup]["lang_select"]["voc_type_name"]#</td>
                                        <cfif isdefined("lang_translate") AND lang_translate neq ""><td id=#vocabData[vocGroup]["lang_translate"]["voc_id"]#>#vocabData[vocGroup]["lang_translate"]["voc_word"]#</td> 
                                        <cfelse>
                                            <td><strong>N/A</strong></td> 
                                        </cfif>
                                        <td>#vocabData[vocGroup]["lang_select"]["voc_desc"]#</td>
                                        <td> 
                                        <cfset comingSoon=false>
                                            <!-- Loop over the accents retrieved by the get_accent query -->
                                           
                                            <cfloop query="get_accent">
                                                                                                   
                                               
                                                
                                                <cfset fileUrl="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#vocabData[vocGroup]["lang_select"]["voc_cat_id"]#/word_#vocabData[vocGroup]["lang_select"]["voc_id"]#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                                <cfset fileUrl2="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#vocabData[vocGroup]["lang_select"]["voc_cat_id"]#/word_#vocabData[vocGroup]["lang_select"]["voc_group"]#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                                
                                               
                                                 <cfif fileExists(fileUrl2)>
                                                   
                                                        <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_id"]#">
                                                            <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_id"]#" onclick="play_audio">
                                                                <source src="#fileUrl2#" type="audio/mp3">
                                                            </audio>
                                                            <p class="red">#get_accent.formation_accent_name#</p>
                                                        </a>
                                                       
                                                    <cfelseif fileExists(fileUrl)>
                                                       
                                                            
                                                                <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_group"]#">
                                                                    <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_group"]#" onclick="play_audio">
                                                                        <source src="#fileUrl#" type="audio/mp3">
                                                                    </audio>
                                                                    <p class="red">#get_accent.formation_accent_name#</p>
                                                                
                                                                </a>
                                                            
                                                        <cfelse>
                                                            <cfset comingSoon=true>
                                                </cfif>
                                            </cfloop>
                                            <cfif comingSoon>
                                                <!--- Coming soon! --->
                                            </cfif>
                                       </td>
                                       <td class="p-1 sortable"> #vocabData[vocGroup]["lang_select"]["voc_cat_name"]#</td>
                                       <td class="text-center p-1">
                                        <cfsilent>
                                            <cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">
                                            SELECT * FROM user_vocablist 
                                            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> 
                                            AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#vocabData[vocGroup]["lang_select"]["voc_group"]#>
                                            </cfquery>
                                        </cfsilent>
                                        <cfif check_uvoc.recordcount neq 0>
                                            <i class="fal fa-trash-alt fa-lg btn_rm_uvoc cursored" id="#SESSION.USER_ID#_#vocabData[vocGroup]["lang_select"]["voc_id"]#"></i>
                                            <cfelse>
                                            <i class="fal fa-trash-alt fa-lg btn_rm_uvoc cursored" id="#SESSION.USER_ID#_#vocabData[vocGroup]["lang_select"]["voc_id"]#"></i>
                                        </cfif>
                                    </td>
                                  <!---  Keep this for maintenance
                                     Selected Language ID: #vocabData[vocGroup]["lang_select"]["voc_id"]#<br>
                                    Selected Language group: #vocabData[vocGroup]["lang_select"]["voc_group"]#<br>
                                    Selected Language desc: #vocabData[vocGroup]["lang_select"]["voc_desc"]#<br>
                                    Translated Language Word: #vocabData[vocGroup]["lang_translate"]["voc_word"]#<br>
                                    Translated Language ID: #vocabData[vocGroup]["lang_translate"]["voc_id"]#<br>
                                    Translated Language desc: #vocabData[vocGroup]["lang_translate"]["voc_desc"]#<br></tr> --->
                                </cfoutput>
                           
                        </cfloop>
                        

                    </tbody>
                    </table>
                </div>
            <!--- </div>
        </div> 
    </div>
</div> --->

