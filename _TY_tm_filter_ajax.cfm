<!DOCTYPE html>
    
<cfsilent>

<cfquery name="get_language_taught" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT t.user_id, t.formation_id, COUNT(t.formation_id) AS count, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation f
        INNER JOIN user_teaching t ON t.formation_id = f.formation_id
        LEFT JOIN user u ON u.user_id = t.user_id
        LEFT JOIN user_profile p ON p.profile_id = u.profile_id
        WHERE u.profile_id = 4 
        AND u.user_status_id = 4
        GROUP BY t.formation_id
        HAVING COUNT(*)>1

</cfquery>

<cfquery name="get_language_spoken" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT t.user_id, t.formation_id, COUNT(t.formation_id) AS count, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation f
        INNER JOIN user_speaking t ON t.formation_id = f.formation_id
        LEFT JOIN user u ON u.user_id = t.user_id
        LEFT JOIN user_profile p ON p.profile_id = u.profile_id
        WHERE u.profile_id = 4 
        AND u.user_status_id = 4
        GROUP BY t.formation_id
        HAVING COUNT(*)>1
</cfquery>

<cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
        SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index
</cfquery>

<cfquery name="get_lms_business_area" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 2
</cfquery>

<cfquery name="get_lms_level" datasource="#SESSION.BDDSOURCE#">
        SELECT level_id, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level
</cfquery>
<cfquery name="get_lms_skills" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 WHERE keyword_cat_id = 4
</cfquery>

<cfquery name="get_lms_badge" datasource="#SESSION.BDDSOURCE#">
        SELECT badge_id, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index
</cfquery>

<cfparam name="u_level" default="">
<cfparam name="TEACHING_CRITERIA_ID" default="">
<cfparam name="USER_NEEDS_NBTRAINER" default="">
<cfparam name="SPEAKING_CRITERIA_ID" default="">
<cfparam name="AVAIL_ID" default="">
<cfparam name="U_ID" default="">


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
                        <select name="get_language_taught_id" id="get_language_taught_id" placeholder="test" multiple="multiple">
                            <cfoutput query="get_language_taught">
                                <option value="#formation_id#">#formation_name# (#count#)</option>
                            </cfoutput>
                        </select>

                    </div>
                    <div class="col-sm">
                        <select name="get_language_spoken_id" id="get_language_spoken_id"  multiple="multiple">
                            <cfoutput query="get_language_spoken">
                                <option value="#formation_id#">#formation_name# (#count#)</option>
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
                    
                    <cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#")>

                        <table class="table table-borderless w-50">
                            <tr>
                                <th></th>
                                <cfoutput>
                                    <cfset day_avoid = 0> 
                                    <cfloop list="#listgo#" index="cor">
                                        <cfset day_avoid ++>
                                        <cfif day_avoid neq "7">
                                            <th align="center" class="text-center"><h5 class="m-0 d-inline"><span class="badge badge-info">#cor#</span></h5></th>
                                        </cfif>
                                    </cfloop>
                                </cfoutput>
                            </tr>
                            <tr>
                                <th class="font-weight-normal"><i class="fal fa-sunrise fa-lg text-info mr-2"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_morning')#</cfoutput></label></th>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="1" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="5" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="9" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="13" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="17" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="21" ></td>
                                <!--- <td class="text-center"><input type="checkbox" name="avail_id" value="25" <cfif listfind(avail_id,"25")>checked</cfif>></td> --->
                            </tr>
                            <tr>
                                <th class="font-weight-normal"><i class="fal fa-sun-cloud fa-lg text-info mr-1"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_lunch')#</cfoutput></label></th>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="2" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="6" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="10" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="14" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="18" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="22" ></td>
                                <!--- <td class="text-center"><input type="checkbox" name="avail_id" value="26" <cfif listfind(avail_id,"26")>checked</cfif>></td> --->
                            </tr>
                            <tr>
                                <th class="font-weight-normal"><i class="fal fa-sunset fa-lg text-info mr-2"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_afternoon')#</cfoutput></label></th>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="3" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="7" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="11" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="15" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="19" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="23" ></td>
                                <!--- <td class="text-center"><input type="checkbox" name="avail_id" value="27" <cfif listfind(avail_id,"27")>checked</cfif>></td> --->
                            </tr>
                            <tr>
                                <th class="font-weight-normal"><i class="fal fa-house-night fa-lg text-info mr-1"></i> <label><cfoutput>#obj_translater.get_translate('timing_course_evening')#</cfoutput></label></th>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="4" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="8" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="12" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="16" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="20" ></td>
                                <td class="text-center"><input type="checkbox" name="avail_id" value="24" ></td>
                                <!--- <td class="text-center"><input type="checkbox" name="avail_id" value="28" <cfif listfind(avail_id,"28")>checked</cfif>></td> --->
                            </tr>
                        </table>
                    <!---<div class="col-sm">
                        <input type="submit" class="btn btn-outline-info" value="filter">
                    </div>--->
                </div>
            </form>
            <div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border-top border-info">

                        <div id="t_count">
                        </div>
                        
                        <div class="spinner-border text-danger collapse" id="t_spin_load" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
						<div class="card-body" id="t_lists">
                        
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

    
    $("#t_spin_load").show()
    refresh($("#filter").serialize())

    $('#get_language_taught_id').multiselect({ nonSelectedText:'Language taught'});
    $('#get_language_spoken_id').multiselect({ nonSelectedText:'Language spoken'});
    $('#get_user_personality_id').multiselect({ nonSelectedText:'Personality'});
    $('#get_lms_business_area_id').multiselect({ nonSelectedText:'Business area'});
    $('#get_lms_level_id').multiselect({ nonSelectedText:'Level'});
    $('#get_lms_skills_id').multiselect({ nonSelectedText:'Skills'});
    $('#get_lms_badge_id').multiselect({ nonSelectedText:'Badges'});

    $('select, [name=avail_id]').on('change', function() {
        
        $("#t_spin_load").show()
        refresh($("#filter").serialize())
    })
    	
	// $('#filter').submit(function(event) {
    //     event.preventDefault();
    //     refresh($(event.target).serialize())
    // });	

    function refresh(data) {
        console.log(data)
        $.ajax({				 
            url: '_TY_tm_filter_api.cfc?method=filter',
            type: 'POST',
            data: data,
            success : function(result, status){
                var obj_result = jQuery.parseJSON(result);
                $("#t_count").empty()
                $("#t_lists").empty()
                if(obj_result.DATA.length > 0) {
                    let data = []
                    $.each(obj_result.DATA, function() {
                        data.push(this[0])
                    })
                    console.log(JSON.stringify(data).slice(1,-1))
                    $("#t_count").append('<h3>'+obj_result.DATA.length+' trainers found</h3>')
                    $("#t_lists").load("_TY_tm_cards_ajax.cfm?users="+JSON.stringify(data).slice(1,-1), function() {
                        $("#t_spin_load").hide()
                    })
                }
                else {
                    $("#t_lists").append('<span>No results</span>')
                    $("#t_spin_load").hide()
                }
                
            },
            error : function(result, status, erreur){
                console.log(erreur)
            },
            complete : function(result, status){
            }	
        });
    }
	
});
</script>
</body>
</html>
