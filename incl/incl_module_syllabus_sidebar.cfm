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

<cfif obj_id eq "6" OR obj_id eq "1">
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

    <div id="accordion_syllabus">

        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_type" aria-expanded="true" aria-controls="collapse_type">
            <i class="fa-thin fa-photo-film-music fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>#obj_translater.get_translate('btn_el_resources')#</strong></cfoutput>
            </div>
        </div>
        
        <hr class="border-red mt-2 mb-2">

        <div id="collapse_type" class="collapse show" data-parent="#accordion_syllabus">

            <a class="btn_obj text-link text-dark cursored <cfif obj_id eq "1">font-weight-bold text-red</cfif>" id="obj_1" data-objid="1">General English</a><br>
            <a class="btn_obj text-link text-dark cursored <cfif obj_id eq "2">font-weight-bold text-red</cfif>" id="obj_2" data-objid="2">Business English</a><br>
            <a class="btn_obj text-link text-dark cursored <cfif obj_id eq "6">font-weight-bold text-red</cfif>" id="obj_6" data-objid="6">Vidéos</a><br>
            
        </div>
        
        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_level" aria-expanded="true" aria-controls="collapse_level">
            <i class="fa-thin fa-chart-line-up fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>#obj_translater.get_translate('card_level')#</strong></cfoutput>
            </div>
        </div>
        
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_level" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_level text-link text-dark cursored <cfif lvl_id eq "0">font-weight-bold text-red</cfif>" id="lvl_0" data-levelid="0" data-levelalias="0"><cfoutput>#obj_translater.get_translate('btn_all_level')#</cfoutput></a><br>
            
            <cfoutput query="get_level">
                <a class="btn_level text-link text-dark cursored <cfif lvl_id eq level_id>font-weight-bold text-red</cfif>" id="lvl_#level_id#" data-levelid="#level_id#" data-levelalias="#level_alias#">#level_alias# #level_name# (#nb#)</a><br>
            </cfoutput>

        </div>
        
        <cfif obj_id eq "6" OR obj_id eq "1">
        
        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_topic" aria-expanded="true" aria-controls="collapse_topic">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Topics</strong></cfoutput>
            </div>

        </div>
    
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_topic" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_keyword text-link text-dark cursored <cfif kw_id eq "0">font-weight-bold text-red</cfif>" id="kw_0" data-kwid="0"><cfoutput>#obj_translater.get_translate('global_all')#</cfoutput></a><br>
            
            <!---<cfdump var="#get_kw#">--->
            
            <cfoutput query="get_kw">
                <a class="btn_keyword text-link text-dark cursored <cfif keyword_id eq kw_id>font-weight-bold text-red</cfif>" id="kw_#keyword_id#" data-kwid="#keyword_id#">#keyword_name# (#nb#)</a><br>
            </cfoutput>

        </div>
        
        <!--- <cfelseif obj_id eq "2"> --->
            
        
        </cfif>

        
        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_job" aria-expanded="true" aria-controls="collapse_job">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Job</strong></cfoutput>
            </div>
        </div>
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_job" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_keyword text-link text-dark cursored <!---<cfif kw_id eq "0">font-weight-bold text-red</cfif>--->" id="kw_0" data-kwid="0">Accounting / Finance</a><br>
            <a class="btn_keyword text-link text-dark cursored">Administrative Roles </a><br>
            <a class="btn_keyword text-link text-dark cursored">Customer Service</a><br>
            <a class="btn_keyword text-link text-dark cursored">Education and Training Roles</a><br>
            <a class="btn_keyword text-link text-dark cursored">Healthcare and Social Assistance</a><br>
            <a class="btn_keyword text-link text-dark cursored">Human Ressources</a><br>
            <a class="btn_keyword text-link text-dark cursored">IT / Hardware / Programing</a><br>
            <a class="btn_keyword text-link text-dark cursored">Legal Roles </a><br>
            <a class="btn_keyword text-link text-dark cursored">Management Roles </a><br>
            <a class="btn_keyword text-link text-dark cursored">Marketing / Communication</a><br>
            <a class="btn_keyword text-link text-dark cursored">Purchasing</a><br>
            <a class="btn_keyword text-link text-dark cursored">R&D</a><br>
            <a class="btn_keyword text-link text-dark cursored">Sales</a><br>
            
        </div>


       



        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_industry" aria-expanded="false" aria-controls="collapse_industry">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Business sectors</strong></cfoutput>
            </div>
        </div>
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_industry" class="collapse" data-parent="#accordion_syllabus">

        <a class="btn_keyword text-link text-dark cursored">Agriculture – Elevage - Paysage</a><br>
        <a class="btn_keyword text-link text-dark cursored">Alimentation - Agroalimentaire</a><br>
        <a class="btn_keyword text-link text-dark cursored">Animaux</a><br>
        <a class="btn_keyword text-link text-dark cursored">Architecture – Etude - Décoration</a><br>
        <a class="btn_keyword text-link text-dark cursored">Armée – Sécurité - Secours</a><br>
        <a class="btn_keyword text-link text-dark cursored">Artisanat d’art – Design - Mode</a><br>
        <a class="btn_keyword text-link text-dark cursored">Automobile  - Mécanique</a><br>
        <a class="btn_keyword text-link text-dark cursored">Banque - Finance - Assurance</a><br>
        <a class="btn_keyword text-link text-dark cursored">Biologie – Chimie - Pharmaceutique</a><br>
        <a class="btn_keyword text-link text-dark cursored">BTP- Urbanisme</a><br>
        <a class="btn_keyword text-link text-dark cursored">Cinéma – Audiovisuel - Jeux vidéo</a><br>
        <a class="btn_keyword text-link text-dark cursored">Commerce – Distribution</a><br>
        <a class="btn_keyword text-link text-dark cursored">Immobilier</a><br>

        </div>




        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_business_skills" aria-expanded="true" aria-controls="collapse_business_skills">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Skills relationnelles</strong></cfoutput>
            </div>
        </div>
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_business_skills" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_keyword text-link text-dark cursored <!---<cfif kw_id eq "0">font-weight-bold text-red</cfif>--->" id="kw_0" data-kwid="0">Collaboration/Soft skills</a><br>
            <a class="btn_keyword text-link text-dark cursored">Leadership & Management</a><br>
            <a class="btn_keyword text-link text-dark cursored">Project and time management</a><br>
            <a class="btn_keyword text-link text-dark cursored">Technical proficiency</a><br>
            <a class="btn_keyword text-link text-dark cursored">Negotiation</a><br>
            <a class="btn_keyword text-link text-dark cursored">Continuous Learning</a><br>
            <a class="btn_keyword text-link text-dark cursored">Resolving Problems</a><br>
            <a class="btn_keyword text-link text-dark cursored">Interview techniques</a><br>
            <a class="btn_keyword text-link text-dark cursored">Meetings</a><br>
            <a class="btn_keyword text-link text-dark cursored">Presentations</a><br>
            <a class="btn_keyword text-link text-dark cursored">Reporting</a><br>
            <a class="btn_keyword text-link text-dark cursored">Telephoning</a><br>
            <a class="btn_keyword text-link text-dark cursored">Written communication</a><br>
            <a class="btn_keyword text-link text-dark cursored">Corporate social responsibility</a><br>


        </div>




        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_general_skills" aria-expanded="true" aria-controls="collapse_general_skills">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Skills comportementales</strong></cfoutput>
            </div>
        </div>
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_general_skills" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_keyword text-link text-dark cursored <!---<cfif kw_id eq "0">font-weight-bold text-red</cfif>--->" id="kw_0" data-kwid="0">Debating</a><br>
            <a class="btn_keyword text-link text-dark cursored">Describing</a><br>
            <a class="btn_keyword text-link text-dark cursored">Expressing Ideas</a><br>
            <a class="btn_keyword text-link text-dark cursored">Wellbeing & Mindfulness</a><br>
            <a class="btn_keyword text-link text-dark cursored">...</a><br>
            <a class="btn_keyword text-link text-dark cursored">...</a><br>
            <a class="btn_keyword text-link text-dark cursored">...</a><br>
            
            
        </div>

        <div class="d-flex align-items-center" type="button" data-toggle="collapse" data-target="#collapse_soft" aria-expanded="false" aria-controls="collapse_soft">
        
            <i class="fa-thin fa-comments fa-lg text-red mr-2"></i>
            <div>
                <cfoutput><strong>Skills cognitives</strong></cfoutput>
            </div>
        </div>
        <hr class="border-red mb-2 mt-2">
        
        <div id="collapse_soft" class="collapse" data-parent="#accordion_syllabus">

            <a class="btn_keyword text-link text-dark cursored">Curiosité</a><br>
            <a class="btn_keyword text-link text-dark cursored">Autonomie</a><br>
            <a class="btn_keyword text-link text-dark cursored">Écoute active</a><br>
            <a class="btn_keyword text-link text-dark cursored">Communication orale</a><br>
            <a class="btn_keyword text-link text-dark cursored">Respect</a><br>
            <a class="btn_keyword text-link text-dark cursored">Flexibilité et adaptabilité</a><br>
            <a class="btn_keyword text-link text-dark cursored">Attitude positive</a><br>
            <a class="btn_keyword text-link text-dark cursored">Faire confiance</a><br>
            <a class="btn_keyword text-link text-dark cursored">Responsabilité</a><br>
            <a class="btn_keyword text-link text-dark cursored">Intégrité</a><br>
            <a class="btn_keyword text-link text-dark cursored">Résolution de problèmes</a><br>

        </div>




    </div>