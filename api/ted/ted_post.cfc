<cfcomponent>

    <cffunction name="insert_tpsessionmaster" access="remote" httpMethod="post" returntype="any" returnformat="json" >
	
        <cfargument name="thumb_url" type="any" required="yes">
        <cfargument name="video_author" type="any" required="yes">
        <cfargument name="video_duration" type="any" required="yes">
        <cfargument name="video_href" type="any" required="yes">
        <cfargument name="video_name" type="any" required="yes">
        <cfargument name="video_posted" type="any" required="yes">
        <cfargument name="tpmaster_name" type="any" required="yes">
        
        <cfquery name="check_lesson" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM lms_tpsessionmaster2 WHERE sessionmaster_name like '%#video_name#%'
        </cfquery>

        <cfif check_lesson.recordcount eq "0">

            <cfquery name="check_keyword" datasource="#SESSION.BDDSOURCE#">
            SELECT * FROM lms_keyword2 WHERE keyword_name_en = '#tpmaster_name#'
            </cfquery>

            <cfif check_keyword.recordcount eq "0">
                <cfquery name="insert_kw" datasource="#SESSION.BDDSOURCE#" result="insert_kw">
                    INSERT INTO lms_keyword2
                    (
                        keyword_name_en,
                        keyword_cat_id,
                        is_active
                    )
                    VALUES
                    (
                        '#tpmaster_name#',
                        3,
                        0
                    )
                </cfquery>

                <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
                SELECT max(keyword_id) as kw_id FROM lms_keyword2
                </cfquery>

                <cfset keyword_id = get_max.kw_id>
    
            <cfelse>
                
                <cfset keyword_id = check_keyword.keyword_id>
    
            </cfif>
    
            <cfquery name="check_tpmaster" datasource="#SESSION.BDDSOURCE#">
            SELECT * FROM lms_tpmaster2 WHERE tpmaster_name = 'Videos / TED Talks #tpmaster_name#'
            </cfquery>
    
            <cfif check_tpmaster.recordcount eq "0">
                <cfquery name="insert_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp">
                    INSERT INTO lms_tpmaster2
                    (
                        tpmaster_name,
                        formation_id,
                        tpmaster_level,
                        tpmaster_biglevel
                    )
                    VALUES
                    (
                        'Videos / TED Talks #tpmaster_name#',
                        2,
                        'C1/C2',
                        'C'
                    )
                </cfquery>

                <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
                SELECT max(tpmaster_id) as tpmaster_id FROM lms_tpmaster2
                </cfquery>
    
                <cfset tpmaster_id = get_max.tpmaster_id>
                le tp existe pas = new tpmaster_id = <cfoutput>#tpmaster_id#</cfoutput><br>
            <cfelse>
                <cfset tpmaster_id = check_tpmaster.tpmaster_id>
            </cfif>


            <cfquery name="insert_session" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpsessionmaster2
            (
                sessionmaster_name,
                sessionmaster_cat_id,

                sessionmaster_video_bool,
                sessionmaster_video_duration,

                sessionmaster_description,
                sessionmaster_objectives,
                sessionmaster_grammar,
                sessionmaster_url

            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#video_name#">,
                1,

                
                1,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#video_duration#">,  

                <cfqueryparam cfsqltype="cf_sql_varchar" value="#thumb_url#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#video_author#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#video_posted#">,      
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#video_href#">
            )
            </cfquery>

            <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
            SELECT MAX(sessionmaster_id) as id FROM lms_tpsessionmaster2
            </cfquery>

            <cfquery name="insert_session_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_sessionmaster_keywordid_cor 
            (
                sessionmaster_id,
                keyword_id
            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#keyword_id#">
            )
            </cfquery>

            <cfquery name="insert_session_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpmastercor2 
            (
                tpmaster_id,
                sessionmaster_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">

            )
            </cfquery>

            <cfreturn "ok">

        <cfelse>

            <cfreturn "doublon">

        </cfif>

    </cffunction>




    <cffunction name="create_img" access="remote" httpMethod="post" returntype="any" returnformat="json" >

        <cfargument name="sessionmaster_name" type="any" required="yes">
        <cfargument name="sessionmaster_level" type="any" required="yes">
        <cfargument name="sessionmaster_link" type="any" required="yes">
        <cfargument name="sessionmaster_time" type="any" required="yes">
        <cfargument name="sessionmaster_description" type="any" required="yes">
        <cfargument name="sessionmaster_img" type="any" required="yes">

        <cfset sessionmaster_code = mid(sessionmaster_img,find("md5/",sessionmaster_img)+4,5000)>
        <cfset sessionmaster_code = mid(sessionmaster_code,1,find("/",sessionmaster_code)-1)>
        
        <cfimage 
        action = "write" overwrite = "true"
        destination = "/home/www/wnotedev1/www/manager/lms/assets/img_material/#sessionmaster_code#.jpg" 
        source = "#sessionmaster_img#">
        
        <cfset obj_cleaner = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.cleaner")> 
        
        <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO lms_tpsessionmaster2
        (
        sessionmaster_cat_id,
        sessionmaster_duration,
        sessionmaster_name,
        sessionmaster_code,
        sessionmaster_level,
        sessionmaster_url,
        sessionmaster_ressource,
        sessionmaster_description
        )
        VALUES
        (
        1,
        '#replace(sessionmaster_time," min","","ALL")#',
        '#sessionmaster_name#',
        '#sessionmaster_code#',
        '#sessionmaster_level#',
        '#sessionmaster_link#',
        '#obj_cleaner.renamego(sessionmaster_name)#',
        '#sessionmaster_description#'
        )
        </cfquery>

        <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
        SELECT max(sessionmaster_id) as id FROM lms_tpsessionmaster2
        </cfquery>

        <cfif findnocase("A1-A2",sessionmaster_level)>
            <cfset tpmaster_id = "1405">
        <cfelseif findnocase("A2-B1",sessionmaster_level)>
            <cfset tpmaster_id = "1406">
        <cfelseif findnocase("B1-B2",sessionmaster_level)>
            <cfset tpmaster_id = "1407">
        <cfelseif findnocase("B2-C1",sessionmaster_level)>
            <cfset tpmaster_id = "1408">
        </cfif>

        <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO lms_tpmastercor2
        (
        sessionmaster_id,
        tpmaster_id
        )
        VALUES
        (
        #get_max.id#,
        #tpmaster_id#
        )
        </cfquery>

        <cfreturn sessionmaster_code>
        
    </cffunction>

</cfcomponent>