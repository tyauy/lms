<!DOCTYPE html>


<cfsilent>

<cfif NOT IsNull(url.get_language_taught_id)>
    <cfset get_language_taught_id = url.get_language_taught_id>
</cfif>
<cfif NOT IsNull(url.get_language_spoken_id)>
    <cfset get_language_spoken_id = url.get_language_spoken_id>
</cfif>
<cfif NOT IsNull(url.get_user_personality_id)>
    <cfset get_user_personality_id = url.get_user_personality_id>
</cfif>
<cfif NOT IsNull(url.get_lms_business_area_id)>
    <cfset get_lms_business_area_id = url.get_lms_business_area_id>
</cfif>
<cfif NOT IsNull(url.get_lms_level_id)>
    <cfset get_lms_level_id = url.get_lms_level_id>
</cfif>
<cfif NOT IsNull(url.get_lms_skills_id)>
    <cfset get_lms_skills_id = url.get_lms_skills_id>
</cfif>
<cfif NOT IsNull(url.get_lms_badge_id)>
    <cfset get_lms_badge_id = url.get_lms_badge_id>
</cfif>


<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation
        ORDER BY formation_id
</cfquery>

<cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
        SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index
        ORDER BY perso_id
</cfquery>

<cfquery name="get_lms_business_area" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 2
        ORDER BY keyword_id
</cfquery>

<cfquery name="get_lms_level" datasource="#SESSION.BDDSOURCE#">
        SELECT level_id, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level
        ORDER BY level_id
</cfquery>
<cfquery name="get_lms_skills" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 5
        ORDER BY keyword_id
</cfquery>

<cfquery name="get_lms_badge" datasource="#SESSION.BDDSOURCE#">
        SELECT badge_id, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index
        ORDER BY badge_id
</cfquery>

<!--- 
TODO : 
- refaire user_level = prendre user_teaching 
- ajouter les badges dans la card + autres infos
- retaper dans expertise business pour get skills
--->

<cfquery name="get_filtered_trainers" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
		c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
		s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
		FROM user u
		LEFT JOIN settings_country c ON c.country_id = u.country_id
		LEFT JOIN user_status s ON s.user_status_id = u.user_status_id

    <cfif NOT IsNull(url.get_language_taught_id) || NOT IsNull(url.get_lms_level_id)>
		INNER JOIN user_teaching t ON t.user_id = u.user_id
    </cfif>
    <cfif NOT IsNull(url.get_language_spoken_id)>
		INNER JOIN user_speaking sp ON sp.user_id = u.user_id
    </cfif>
    <cfif NOT IsNull(url.get_user_personality_id)>
		INNER JOIN user_personality p ON p.user_id = u.user_id
    </cfif>
    <cfif NOT IsNull(url.get_lms_business_area_id) || NOT IsNull(url.get_lms_skills_id)>
		INNER JOIN user_expertise_business eb ON eb.user_id = u.user_id
    </cfif>
    <cfif NOT IsNull(url.get_lms_badge_id)>
        INNER JOIN lms_badge_attribution lba ON lba.badge_trainer_id = u.user_id
    </cfif>

	<!---- PROFIL TRAINER, ACTIVE --->
	WHERE profile_id = 4 
	AND u.user_status_id = 4
    <cfif NOT IsNull(url.get_language_taught_id)>
        AND t.formation_id IN (#get_language_taught_id#)
    </cfif>
    <cfif NOT IsNull(url.get_language_spoken_id)>
        AND sp.formation_id IN (#get_language_spoken_id#)
    </cfif>
    <cfif NOT IsNull(url.get_user_personality_id)>
        AND p.personality_id IN (#get_user_personality_id#)
    </cfif>
    <cfif NOT IsNull(url.get_lms_business_area_id)>
        AND eb.keyword_id IN (#get_lms_business_area_id#)
    </cfif>
    <cfif NOT IsNull(url.get_lms_level_id)>
        AND t.level_id IN (#get_lms_level_id#)
    </cfif>
    <cfif NOT IsNull(url.get_lms_skills_id)>
        AND eb.keyword_id IN (#get_lms_skills_id#)
    </cfif>
    <cfif NOT IsNull(url.get_lms_badge_id)>
        AND lba.badge_id IN (#get_lms_badge_id#)
    </cfif> 

	<!---- VISIO --->
	AND FIND_IN_SET(1,method_id)

	<!---- REMOVE FAKE TRAINERS --->
	AND u.user_id <> 2656 AND u.user_id <> 4784 AND u.user_id <> 4785 AND u.user_id <> 201 

    GROUP BY u.user_id

</cfquery>
<!---         <cffunction name="test" returntype="any" returnFormat="JSON">
            <cfset result = SerializeJSON(get_account, "struct")>
            <cfdump var="#result#">
            <cfreturn result>
        </cffunction> --->

<cfparam name="u_level" default="">
<cfparam name="TEACHING_CRITERIA_ID" default="">
<cfparam name="USER_NEEDS_NBTRAINER" default="">
<cfparam name="SPEAKING_CRITERIA_ID" default="">
<cfparam name="AVAIL_ID" default="">
<cfparam name="U_ID" default="">


<cfset display = "video">
</cfsilent>
	
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

<head>
	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
		<!--- <cfset help_page = "help_index"> --->
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
            <form id="filter">	
                <div class="row">
                    <div class="col-sm">
                        <select name="get_language_taught_id" id="get_language_taught_id"  multiple="multiple">
                            <cfoutput query="get_formation">
                                <option value="#formation_id#">#formation_name#</option>
                            </cfoutput>
                        </select>

                    </div>
                    <div class="col-sm">
                        <select name="get_language_spoken_id" id="get_language_spoken_id"  multiple="multiple">
                            <cfoutput query="get_formation">
                                <option value="#formation_id#">#formation_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="col-sm">
                        <select name="get_user_personality_id" id="get_user_personality_id"  multiple="multiple">
                            <cfoutput query="get_user_personality">
                                <option value="#perso_id#">#perso_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="col-sm">
                        <select name="get_lms_business_area_id" id="get_lms_business_area_id"  multiple="multiple">
                            <cfoutput query="get_lms_business_area">
                                <option value="#keyword_id#">#keyword_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="col-sm">
                        <select name="get_lms_level_id" id="get_lms_level_id"  multiple="multiple">
                            <cfoutput query="get_lms_level">
                                <option value="#level_id#">#level_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="col-sm">
                        <select name="get_lms_skills_id" id="get_lms_skills_id"  multiple="multiple">
                            <cfoutput query="get_lms_skills">
                                <option value="#keyword_id#">#keyword_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="col-sm">
                        <select name="get_lms_badge_id" id="get_lms_badge_id"  multiple="multiple">
                            <cfoutput query="get_lms_badge">
                                <option value="#badge_id#">#badge_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    
                    <div class="col-sm">
                        <input type="submit" class="btn btn-outline-info" value="filter">
                    </div>
                </div>
            </form>
            <div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border-top border-info">
						
						<div class="card-body">
                            <cfoutput query="get_filtered_trainers">

						
						<!---- OBJ QUERIES--->
                                    <cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
                                    <cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
                                    <cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>
                                    
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
                                    
                                    <div class="row">
                                        <div class="col-12">
                                    
                                            <div class="card border">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-2 col-3 d-flex justify-content-center">
                                                            <div class="pt-3 pl-3" align="center">
                                    
                                                                <div>
                                                                #obj_lms.get_thumb(user_id="#user_id#",size="130")#
                                                                </div>
                                    
                                                                <div class="clearfix"></div>
                                    
                                                                <button class="btn btn-info btn-block btn_view_trainer" id="trainer_#user_id#" >
                                                                    <i class="fal fa-address-card"></i>
                                                                    #obj_translater.get_translate('btn_view_profile')#
                                                                </button>
                                                            
                                    
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5 col-9">
                                                            <div class="p-3">
                                                                <!---#user_id# - <img src="./assets/css/flags/blank.gif" class="flag_lg flag-#lcase(country_alpha)# mr-3" align="left">---> 
                                                                <!--- <cfif user_based neq ""><br>#obj_translater.get_translate('lives')#</cfif> --->
                                                                <!--- <div class="d-inline pull-right"><i class="fas fa-heart fa-lg grey"></i></div> --->
                                                                <!---<br>
                                                                    #obj_translater.get_translate('table_th_specialities')# : <cfloop list="#speciality_id#" index="cor"><span class="badge badge-outline" style="font-size:12px">#SESSION.SPECIALITY.speciality_name[cor]#</span> </cfloop>
                                                                    <br>
                                                                --->
                                                                <strong style="font-size:22px" class="text-dark">#user_firstname# <!---<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif>---></strong>
                                                                <br><br>
                                                                <small><strong>#obj_translater.get_translate('table_th_teaches')# :</strong></small>
                                                                <br>
                                                                    <cfloop query="get_teaching">
                                                                    
                                                                        <span class="lang-lg" lang="#get_teaching.formation_code#" style="top:4px"></span>
                                                                            <!---<td align="left">
                                                                            <cfloop list="#get_teaching.level_id#" index="cor">
                                                                            <span class="badge bg-white border">
                                                                            <cfif cor eq "0">A0
                                                                            <cfelseif cor eq "1">A1
                                                                            <cfelseif cor eq "2">A2
                                                                            <cfelseif cor eq "3">B1
                                                                            <cfelseif cor eq "4">B2
                                                                            <cfelseif cor eq "5">C1
                                                                            <cfelseif cor eq "6">C2
                                                                            </cfif>
                                                                            </span>
                                                                            </cfloop>--->
                                                                    </cfloop>
                                                                <div class="clearfix mt-3"></div>
                                    
                                                                <small><strong>#obj_translater.get_translate('table_th_speaks')# :</strong></small>
                                                                <br>
                                                                <cfloop query="get_speaking">
                                                                    <span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
                                                                    #get_speaking.formation_name# 
                                                                    <cfset level_id = get_speaking.level_id>
                                                                    <div class="clearfix"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                                                    </span>
                                                                </cfloop>
                                                                <br><br>
                                                                <table class="table table-sm table-borderless">
                                                                    <tr align="center">
                                                                        <td width="33%"><i class="fal fa-users fa-2x text-info"></i></td>
                                                                        <td width="33%"><i class="fal fa-chalkboard-teacher fa-2x text-info"></i></td>
                                                                        <!--- <td width="33%"><i class="fal fa-history fa-2x text-info"></i></td> --->
                                                                        <!--- <td width="25%"><i class="fal fa-star fa-lg text-info"></i></td> --->
                                                                    </tr>
                                                                    <tr align="center">
                                                                        <td>#get_learner.nb+user_add_learner#<br>#obj_translater.get_translate('table_th_learners')#</td>
                                                                        <td>#get_lesson.nb+user_add_course#<br>#obj_translater.get_translate('lessons')#</td>
                                                                        <!--- <td>#obj_translater.get_translate('table_th_since')#<br><cfif user_create neq "">#year(user_create)#<cfelse>NC</cfif></td> --->
                                                                        <!--- <td><cfif get_rating.sum_rating gte 1>#numberformat(get_rating.avg_rating,'_._')#<br>#get_rating.sum_rating# vote<cfif get_rating.sum_rating gt 1>(s)</cfif><cfelse>-</cfif></td> --->
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5 col-12">
                                                            <div class="p-3">
                                                                <ul class="nav nav-tabs" role="tablist">
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "video">active</cfif>" data-toggle="tab" href="##video_#user_id#" role="tab" aria-controls="video_#user_id#" aria-selected="true">#obj_translater.get_translate('btn_el_video')#</a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "aboutme">active</cfif>" data-toggle="tab" href="##about_#user_id#" role="tab" aria-controls="about_#user_id#" aria-selected="false">#obj_translater.get_translate('table_th_about_me')#</a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "agenda">active</cfif>" data-toggle="tab" href="##agenda_#user_id#" role="tab" aria-controls="agenda_#user_id#,  -" aria-selected="false">
                                                                    
                                                                            #obj_translater.get_translate('table_th_availabilities')#
                                                                        </a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "personality">active</cfif>" data-toggle="tab" href="##personality_#user_id#" role="tab" aria-controls="personality_#user_id#,  -" aria-selected="false">
                                                                            #obj_translater.get_translate('personality')#
                                                                        </a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "business_area">active</cfif>" data-toggle="tab" href="##business_area_#user_id#" role="tab" aria-controls="business_area_#user_id#,  -" aria-selected="false">
                                                                            #obj_translater.get_translate('business_area')#
                                                                        </a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "level">active</cfif>" data-toggle="tab" href="##level_#user_id#" role="tab" aria-controls="level_#user_id#,  -" aria-selected="false">
                                                                            #obj_translater.get_translate('levels')#
                                                                        </a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "skill">active</cfif>" data-toggle="tab" href="##skill_#user_id#" role="tab" aria-controls="skill_#user_id#,  -" aria-selected="false">
                                                                            #obj_translater.get_translate('skills')#
                                                                        </a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <cfif display eq "badge">active</cfif>" data-toggle="tab" href="##badge_#user_id#" role="tab" aria-controls="badge_#user_id#,  -" aria-selected="false">
                                                                            #obj_translater.get_translate('badges')#
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                                <div class="tab-content">
                                                                    <div class="tab-pane fade <cfif display eq "video"> show active</cfif>" id="video_#user_id#" role="tabpanel">
                                                                        <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>
                                                                            <video controls preload width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo_video.jpg")>poster="./assets/user/#user_id#/photo_video.jpg"</cfif>>
                                                                                <source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4">
                                                                                    <!--- <p> --->
                                                                                    <!--- <cfset user_id = get_trainer_go.user_id> --->
                                                                                    <!--- <cfset arr = ['SESSION.BO_ROOT_URL', 'user_id']> --->
                                                                                    <!--- <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->
                                                                                    <!--- #obj_translater.get_translate_complex(id_translate="download_trainer_video", argv="#argv#")#</p> --->
                                                                            </video>
                                                                        <cfelse>
                                                                            <div align="center" class="mt-4">
                                                                                <h2 class="text-muted"><i class="fal fa-stopwatch fa-3x"></i></h2>																							
                                                                                #obj_translater.get_translate('coming_soon')#
                                                                            </div>
                                                                        </cfif>
                                                                    </div>

                                                                    <cfsilent>
                                                                        <cfquery name="get_user_about" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT ua.*, uaq.about_question_#SESSION.LANG_CODE# as quest 
                                                                            FROM user_about ua 
                                                                            INNER JOIN user_about_question uaq ON uaq.user_about_question_id = ua.user_about_type 
                                                                            WHERE ua.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
                                                                            ORDER BY RAND()
                                                                            LIMIT 5
                                                                        </cfquery>
                                                                        <cfquery name="get_user_paragraph" datasource="#SESSION.BDDSOURCE#">
                                                                        SELECT *
                                                                        FROM user_about
                                                                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> and user_about_type = 0
                                                                        </cfquery>
                                                                        <cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index upi
		                                                                    INNER JOIN user_personality up ON up.personality_id = upi.perso_id
                                                                            WHERE up.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                                                            GROUP BY upi.perso_id
                                                                            ORDER BY upi.perso_id
                                                                        </cfquery>
                                                                        <cfquery name="get_user_business_area" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT lk.keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 lk
		                                                                    INNER JOIN user_expertise_business eb ON eb.keyword_id = lk.keyword_id
                                                                            WHERE eb.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                                                            AND lk.keyword_cat_id = 2
                                                                            GROUP BY lk.keyword_id
                                                                            ORDER BY lk.keyword_id
                                                                        </cfquery>
                                                                        <cfquery name="get_user_level" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT level_id, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level
                                                                            WHERE level_id IN (SELECT level_id FROM user_teaching WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">)
                                                                            GROUP BY level_id
                                                                            ORDER BY level_id
                                                                        </cfquery>
                                                                        <cfquery name="get_user_skill" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT lk.keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 lk
		                                                                    INNER JOIN user_expertise_business eb ON eb.keyword_id = lk.keyword_id
                                                                            WHERE eb.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                                                            AND lk.keyword_cat_id = 5
                                                                            GROUP BY lk.keyword_id
                                                                            ORDER BY lk.keyword_id
                                                                        </cfquery>
                                                                        <cfquery name="get_user_badge" datasource="#SESSION.BDDSOURCE#">
                                                                            SELECT lbi.badge_id, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index lbi
                                                                            INNER JOIN lms_badge_attribution lba ON lba.badge_id = lbi.badge_id
                                                                            WHERE lba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                                                            GROUP BY lbi.badge_id
                                                                            ORDER BY lbi.badge_id
                                                                        </cfquery>
                                                                    </cfsilent>
                                    
                                    
                                                                    <div class="tab-pane fade <cfif display eq "aboutus"> show active</cfif>" id="about_#user_id#" role="tabpanel">
                                                                        <cfif get_user_paragraph.recordcount neq "0">
                                                                            <br>#get_user_paragraph.user_about_desc#
                                                                        <cfelse>
                                                                            <cfloop query="get_user_about">
                                                                                <br><strong class="text-muted">#quest#</strong><br>#user_about_desc#
                                                                            </cfloop>
                                                                        </cfif>
                                                                        
                                                                    </div>
                                                                    
                                                                    <div class="tab-pane fade <cfif display eq "agenda"> show active</cfif>" id="agenda_#user_id#" role="tabpanel">
                                                                        <div class="my-4">
                                                                            <cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
                                                                                <cfinvokeargument name="u_id" value="#user_id#">
                                                                            </cfinvoke>
                                                                            <cfset planner_view = "view_toggle_vertical_read">
                                                                            <cfset remove_day = "6">
                                                                            <cfinclude template="./widget/wid_planner.cfm">
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="tab-pane fade <cfif display eq "personality"> show active</cfif>" id="personality_#user_id#" role="tabpanel">
                                                                            <cfloop query="get_user_personality">
                                                                                <br><strong class="text-muted">#perso_name#</strong><br>
                                                                            </cfloop>
                                                                    </div>
                                                                    
                                                                    <div class="tab-pane fade <cfif display eq "business_area"> show active</cfif>" id="business_area_#user_id#" role="tabpanel">
                                                                            <cfloop query="get_user_business_area">
                                                                                <br><strong class="text-muted">#keyword_name#</strong><br>
                                                                            </cfloop>
                                                                    </div>

                                                                    <div class="tab-pane fade <cfif display eq "level"> show active</cfif>" id="level_#user_id#" role="tabpanel">
                                                                            <cfloop query="get_user_level">
                                                                                <br><strong class="text-muted">#level_name#</strong><br>
                                                                            </cfloop>
                                                                    </div>
                                                                    
                                                                    <div class="tab-pane fade <cfif display eq "skill"> show active</cfif>" id="skill_#user_id#" role="tabpanel">
                                                                            <cfloop query="get_user_skill">
                                                                                <br><strong class="text-muted">#keyword_name#</strong><br>
                                                                            </cfloop>
                                                                    </div>

                                                                    <div class="tab-pane fade <cfif display eq "badge"> show active</cfif>" id="badge_#user_id#" role="tabpanel">
                                                                            <cfloop query="get_user_badge">
                                                                                <br><strong class="text-muted">#badge_name#</strong><br>
                                                                            </cfloop>
                                                                    </div>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>	
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                            </cfoutput>		

						
						</div>
					</div>
				
				</div>
			</div>

		</div>
    
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
   
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

	
<script>

$(document).ready(function() {

    $('select').multiselect()
	
});
</script>
</body>
</html>

