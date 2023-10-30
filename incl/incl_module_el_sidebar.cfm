<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(sm.sessionmaster_id) as nb,l.level_id, l.level_alias, l.level_name_#SESSION.LANG_CODE# as level_name 
FROM lms_level l
INNER JOIN lms_tpsessionmaster2 sm ON l.level_id = sm.level_id AND sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">
<!---<cfif obj_id eq "6" OR obj_id eq "1">
    <cfif kw_id neq "0">
    INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
    </cfif>
</cfif> --->
WHERE sm.sessionmaster_online_el = 1
GROUP BY l.level_id
ORDER BY level_alias
</cfquery>

<cfquery name="get_level_all" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(sm.sessionmaster_id) as nb 
FROM lms_tpsessionmaster2 sm 
<!---<cfif obj_id eq "6" OR obj_id eq "1">
    <cfif kw_id neq "0">
    INNER JOIN lms_sessionmaster_keywordid_cor smkw ON smkw.sessionmaster_id = sm.sessionmaster_id AND smkw.keyword_id IN (#kw_id#)
    </cfif>
</cfif> --->
WHERE sm.sessionmaster_online_el = 1 
AND sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">
</cfquery>

<cfif obj_id eq "6" <!---OR obj_id eq "1"--->>
    <cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(smkw.keyword_id) as nb, kw.keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name 

    FROM lms_sessionmaster_keywordid_cor smkw 
    INNER JOIN lms_keyword2 kw ON kw.keyword_id = smkw.keyword_id
    INNER JOIN lms_tpsessionmaster2 sm ON smkw.sessionmaster_id = sm.sessionmaster_id AND sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#obj_id#">
    <!---<cfif lvl_id neq "0">
    INNER JOIN lms_level l ON l.level_id = sm.level_id AND sm.tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lvl_id#">
    </cfif>--->
    INNER JOIN lms_elearning_module em ON sm.sessionmaster_id = em.sessionmaster_id
    WHERE keyword_cat_id = 3 
    AND is_active = 1
    AND parent_id = 0
    AND sm.sessionmaster_online_el = 1
    AND sm.level_id <> "3,4,5"

    AND elearning_module_path REGEXP '^-?[0-9]+$'
    GROUP BY kw.keyword_id
    ORDER BY keyword_name
    </cfquery>

    <!--- <cfif obj_id eq "6">
    <cfif not isdefined("kw_id") OR (isdefined("kw_id") AND kw_id eq "0")>
        <cfset kw_id = QueryGetRow(get_kw, randrange(1,get_kw.recordcount)).keyword_id>
    </cfif>
    </cfif> --->
</cfif>

<div class="d-flex align-items-center">
    <i class="fa-thin fa-photo-film-music fa-lg text-red mr-2"></i>
    <div>
        <cfoutput><strong>#obj_translater.get_translate('btn_el_resources')#</strong></cfoutput>
    </div>
</div>
<hr class="border-red mt-2 mb-2">

<a class="btn_obj text-link text-dark cursored <cfif obj_id eq "1">font-weight-bold text-red</cfif>" id="obj_1" data-objid="1">General English</a><br>
<a class="btn_obj text-link text-dark cursored <cfif obj_id eq "2">font-weight-bold text-red</cfif>" id="obj_2" data-objid="2">Business English</a><br>
<a class="btn_obj text-link text-dark cursored <cfif obj_id eq "6">font-weight-bold text-red</cfif>" id="obj_6" data-objid="6">Vidéos</a><br>

<br>  

<div class="d-flex align-items-center">
    <i class="fa-thin fa-chart-line-up fa-lg text-red mr-2"></i>
    <div>
        <cfoutput><strong>#obj_translater.get_translate('card_level')#</strong></cfoutput>
    </div>
</div>
<hr class="border-red mb-2 mt-2">

<a class="btn_level text-link text-dark cursored <cfif lvl_id eq "0">font-weight-bold text-red</cfif>" id="lvl_0" data-levelid="0" data-levelalias="0"><cfoutput>#obj_translater.get_translate('btn_all_level')#</cfoutput></a><br>


<cfoutput query="get_level">
    <a class="btn_level text-link text-dark cursored <cfif lvl_id eq level_id>font-weight-bold text-red</cfif>" id="lvl_#level_id#" data-levelid="#level_id#" data-levelalias="#level_alias#">#level_alias# #level_name# (#nb#)</a><br>
</cfoutput>

<br>

<cfif obj_id eq "6" <!---OR obj_id eq "1"--->>

<div class="d-flex align-items-center">
    <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
    <div>
        <cfoutput><strong>Topics</strong> </cfoutput>
    </div>
</div>
<hr class="border-red mb-2 mt-2">

<a class="btn_keyword text-link text-dark cursored <cfif kw_id eq "0">font-weight-bold text-red</cfif>" id="kw_0" data-kwid="0"><cfoutput>#obj_translater.get_translate('global_all')#</cfoutput></a><br>

<!---<cfdump var="#get_kw#">--->

<cfoutput query="get_kw">
    <a class="btn_keyword text-link text-dark cursored <cfif keyword_id eq kw_id>font-weight-bold text-red</cfif>" id="kw_#keyword_id#" data-kwid="#keyword_id#">#keyword_name# (#nb#)</a><br>
</cfoutput>

<cfelseif obj_id eq "2">
    <!---<div class="d-flex align-items-center">
        <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
        <div>
            <cfoutput><strong>Business functions</strong></cfoutput>
        </div>
    </div>
    <hr class="border-red mb-2 mt-2">--->

</cfif>