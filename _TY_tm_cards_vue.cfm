<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
<body>
<cfsilent>
    <cfquery name="get_trainer_info" datasource="#SESSION.BDDSOURCE#">

        SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
            c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
            s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
            FROM user u
            LEFT JOIN settings_country c ON c.country_id = u.country_id
            LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
            WHERE u.user_id = #user_id#
    </cfquery>
    <!---- HARD QUERIES--->
    <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
    </cfquery>

    <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
    SELECT COUNT(DISTINCT(t.user_id)) as nb FROM lms_tp t
    INNER JOIN lms_tpplanner p ON p.tp_id = t.tp_id
    WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
    </cfquery>

    <cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
        SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
    </cfquery>
</cfsilent>
<cfset display = "video">

    						<!---- OBJ QUERIES--->
<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
    

<div class="row">
</div>

<script>

    var app = new Vue({
        el: "#vue-app",
        vuetify: new Vuetify(),
        
      data() {
          return {
            data: [
                <cfoutput query="get_trainer_info">
                    { 
                        user_id: #user_id#, 
                        user_firstname: #user_firstname#, 
                        user_status_id: #user_status_id#, 
                        country_id: #country_id#, 
                        speciality_id: #speciality_id#, 
                        method_id: #method_id#, 
                        user_based: #user_based#, 
                        user_abstract: #user_abstract#, 
                        user_create: #user_create#, 
                        user_add_course: #user_add_course#, 
                        user_add_learner: #user_add_learner#,
                        country_name: #country_name#, 
                        country_alpha: #country_alpha#,
                        user_status_name: #user_status_name#,
                        user_status_css: #user_status_css#
                    }
                </cfoutput>]
          };
      },
    });

    // createApp(app).mount('#vue-app')


</script>


</body>
</html>