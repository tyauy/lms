<cfcomponent name="badges">
   
	<!---returns the badges of the trainner ---->
    <cffunction name="oread_trainer_badges" access="public"  returntype="query">
        <cfargument name="tr_id" type="numeric" required="yes">

        <cfquery name="get_badges" datasource="#SESSION.BDDSOURCE#">
            SELECT ba.badge_id as badge_id, bi.badge_name_#SESSION.LANG_CODE# as badge_name, from lms_badge_attribution as ba
            left join lms_badge_index as bi on ba.badge_id=bi.badge_id

            WHERE ba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">
           
        </cfquery>

    <cfreturn get_badges >

    </cffunction>
    <!---makes the badges appear to the learner based on the lesson they just had ---->

    <cffunction name="oget_lessontype" access="remote" returntype="query" >
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="u_id" type="numeric" required="no">
		

        <cfquery name="get_lesson_type" datasource="#SESSION.BDDSOURCE#">
        SELECT l2.lesson_id as lesson_id, l2.method_id as method,
        l2.user_id, l2.planner_id, tpsm2.sessionmaster_id, tpsm2.level_id as level
        FROM `lms_lesson2` as l2
        inner JOIN `lms_tp` as tp ON l2.tp_id = tp.tp_id
        INNER JOIN lms_tpuser as tpu ON tp.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
        left JOIN lms_tpsession as tps ON l2.session_id = tps.session_id 
        LEFT JOIN lms_tpsessionmaster2 tpsm2 ON tpsm2.sessionmaster_id = tps.sessionmaster_id
        INNER JOIN user ut ON ut.user_id = l2.planner_id
        WHERE l2.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
        <cfif isdefined("u_id")>AND tpu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"></cfif>
       
        </cfquery>
     
            <cfreturn get_lesson_type> 
          
        </cffunction>

        <cffunction name="oget_badges_bylesson" access="remote" returntype="any" >
            
            <cfargument name="level_id" type="numeric" required="no">
            <cfargument name="method_id" type="numeric" required="no">

            <cfquery name="badge_id" datasource="#SESSION.BDDSOURCE#" >
            select lbi.badge_id as badge_id, badge_name_#SESSION.LANG_CODE# as badge_name
            FROM lms_badge_perlesson as lbp 
            left join lms_badge_index as lbi on lbi.badge_id=lbp.badge_id
            WHERE lbp.badge_isgeneral = 1 
            <cfif isdefined("level_id")>or lbp.level_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#"></cfif>
            <cfif isdefined("method_id")>or lbp.method_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#method_id#"></cfif>
            
            
            </cfquery>

            <cfreturn badge_id>
        </cffunction>

        <cffunction name="oget_trainerbadges" access="public" returntype="query" >
           
            <cfargument name="tr_id" type="numeric" required="no">
    
            <cfquery name="get_badge_trainer" datasource="#SESSION.BDDSOURCE#">
               SELECT ba.badge_trainer_id, bi.badge_name_#SESSION.LANG_CODE# as badge_name, ba.badge_id, 
               COUNT(*) as count 
                from lms_badge_attribution as ba
                left join lms_badge_index as bi on ba.badge_id = bi.badge_id
                WHERE ba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#"> 
                group by ba.badge_id

            </cfquery>
                <cfreturn get_badge_trainer> 
            </cffunction>

            
            <cffunction name="oread_badges_bylesson" access="public" returntype="query" >
           
                <cfargument name="l_id" type="numeric" required="yes">
        
                <cfquery name="get_badge_lesson" datasource="#SESSION.BDDSOURCE#">
                   SELECT ba.badge_trainer_id, bi.badge_name_#SESSION.LANG_CODE# as badge_name, ba.badge_id, ba.lesson_id
                    from lms_badge_attribution as ba
                    left join lms_badge_index as bi on ba.badge_id = bi.badge_id
                    WHERE ba.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
    
                </cfquery>
                    <cfreturn get_badge_lesson> 
                </cffunction>
    

            
</cfcomponent>