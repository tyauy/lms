<cfloop list="fr,en,de,es,it" index="cor">
    <cfquery name="get_translation_#cor#" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(translation_id) as nb 
    FROM lms_translation
    WHERE translation_string_#cor# IS NULL or translation_string_#cor# = ""
    </cfquery>
</cfloop>

<div class="row">
    <div class="col-md-2">
        <div class="card">
            <div class="card-body">
            <img src="./assets/img_formation/1.png" width="30" align="left" class="mr-2">
            <a href="https://lms.wefitgroup.com/db_translate_list.cfm?t_cat=short&list_lang=en,fr&display_tls=missing">
            <cfoutput>#get_translation_fr.nb#</cfoutput> missing tls
            </a>
        </div>
        </div>
    </div>

    <div class="col-md-2">
        <div class="card">
            <div class="card-body">
            <img src="./assets/img_formation/2.png" width="30" align="left" class="mr-2">
            <a href="https://lms.wefitgroup.com/db_translate_list.cfm?t_cat=short&list_lang=en,fr&display_tls=missing">
            <cfoutput>#get_translation_en.nb#</cfoutput> missing tls
            </a>
            </div>
        </div>
    </div>

    <div class="col-md-2">
        <div class="card">
            <div class="card-body">
            <img src="./assets/img_formation/3.png" width="30" align="left" class="mr-2">
            <a href="https://lms.wefitgroup.com/db_translate_list.cfm?t_cat=short&list_lang=fr,de&display_tls=missing">
            <cfoutput>#get_translation_de.nb#</cfoutput> missing tls
            </a>
            </div>
        </div>
    </div>

    <div class="col-md-2">
        <div class="card">
            <div class="card-body">
            <img src="./assets/img_formation/4.png" width="30" align="left" class="mr-2">
            <a href="https://lms.wefitgroup.com/db_translate_list.cfm?t_cat=short&list_lang=fr,es&display_tls=missing">
            <cfoutput>#get_translation_es.nb#</cfoutput> missing tls
            </a>
            </div>
        </div>
    </div>

    <div class="col-md-2">
        <div class="card">
            <div class="card-body">
            <img src="./assets/img_formation/5.png" width="30" align="left" class="mr-2">
            <a href="https://lms.wefitgroup.com/db_translate_list.cfm?t_cat=short&list_lang=fr,it&display_tls=missing">
                <cfoutput>#get_translation_it.nb#</cfoutput> missing tls
            </a>
            </div>
        </div>
    </div>

</div>