<!DOCTYPE html>
<cfif isDefined("URL.lang_select")>
    <cfset lang_select=URL.lang_select>
 <cfelse>
    <cfset lang_select= "en">
 </cfif>
 
 <cfif isDefined("URL.lang_translate")>
    <cfif URL.lang_translate eq "">
        <cfset lang_translate=SESSION.LANG_CODE>
    <cfelse>
        <cfset lang_translate=URL.lang_translate>
    </cfif>
<cfelse>
    <cfset lang_translate=SESSION.LANG_CODE>
</cfif>


 <cfif isDefined("URL.lang_select")>
    <cfset lang_select_code=URL.lang_select>
 <cfelse>
    <cfset lang_select_code= "en">
 </cfif>

 <cfquery name="get_voc" dataSource="#SESSION.BDDSOURCE#">
    SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category, v.formation_code, v.formation_id, v.voc_cat_id, lvc.voc_cat_name_#lang_select# as voc_cat_name,
        vt.voc_type_name_#lang_select# as voc_type_name
    FROM lms_vocabulary_new v
    left join lms_vocabulary_category lvc on v.voc_cat_id=lvc.voc_cat_id
    LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id                 
    <cfif voc_cat_id lt 1>
        INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_group
        WHERE uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        <cfelse>
        Where v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">
    </cfif>
            AND v.formation_code in ('#lang_translate#', '#lang_select#')
</cfquery>


<html lang="fr">
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
</style>
<body>
 
 <table style="font-family:Arial, Helvetica, sans-serif; font-size:10px; margin-top:20px; border-collapse: separate; border-spacing: 0 10px;" width="100%" cellpadding="1">    
        <cfoutput>
            <thead>
                <tr class="bg-danger text-light text-center">
                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select#")#</th>
                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select#")#</th>
                    <cfif lang_translate NEQ "">
                        <th class="p-1">#obj_translater.get_translate(id_translate="table_th_translation",lg_translate="#lang_select#")#</th>
                    </cfif>
                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select#")#</th>
                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_category",lg_translate="#lang_select#")#</th>
                </tr>
            </thead>
           
        </cfoutput>

        <tbody>
            <cfset vocabData = {}>

        <cfoutput query="get_voc">
          
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
            <cfif trim(formation_code) eq "" or trim(lang_translate) eq "">
                <cfset formation_code = SESSION.LANG_CODE>
                <cfset lang_translate = SESSION.LANG_CODE>
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
        <cfset targetVocCatId = voc_cat_id> 

        <cfloop item="vocGroup" collection="#vocabData#">
        
                <cfoutput>
                    <tr id="voc_row_#vocabData[vocGroup]["lang_select"]["voc_id"]#"<cfif isdefined("url.v_id") AND vocabData[vocGroup]["lang_select"]["voc_id"] eq v_id>class="highlight"</cfif>>
                        <td><strong>#vocabData[vocGroup]["lang_select"]["voc_word"]#</strong> </td>
                        <td class="p-1">#vocabData[vocGroup]["lang_select"]["voc_type_name"]#</td>
                        <cfif StructKeyExists(vocabData[vocGroup], 'lang_translate') AND vocabData[vocGroup]["lang_translate"]["voc_word"] neq "">
                            <td id=#vocabData[vocGroup]["lang_translate"]["voc_id"]#>#vocabData[vocGroup]["lang_translate"]["voc_word"]#</td>
                        <cfelse>
                            <td><strong>N/A</strong></td> 
                        </cfif>
                        
                        <td>#vocabData[vocGroup]["lang_select"]["voc_desc"]#</td>
                     
               <td class="p-1 sortable"> #vocabData[vocGroup]["lang_select"]["voc_cat_name"]#</td>
               
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
  
</body>
</html>