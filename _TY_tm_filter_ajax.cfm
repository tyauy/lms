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
                    
                    <!---<div class="col-sm">
                        <input type="submit" class="btn btn-outline-info" value="filter">
                    </div>--->
                </div>
            </form>
            <div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border-top border-info">
						
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

    
    refresh($("#filter").serialize())

    $('#get_language_taught_id').multiselect({ nonSelectedText:'Language taught'});
    $('#get_language_spoken_id').multiselect({ nonSelectedText:'Language spoken'});
    $('#get_user_personality_id').multiselect({ nonSelectedText:'Personality'});
    $('#get_lms_business_area_id').multiselect({ nonSelectedText:'Business area'});
    $('#get_lms_level_id').multiselect({ nonSelectedText:'Level'});
    $('#get_lms_skills_id').multiselect({ nonSelectedText:'Skills'});
    $('#get_lms_badge_id').multiselect({ nonSelectedText:'Badges'});

    $('select').on('change', function() {
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
                console.log(obj_result)
                $("#t_lists").empty()
                if(obj_result.DATA.length > 0) {
                    $.each(obj_result.DATA, function() {
                        $("#t_lists").append('<div id="tc_'+this[0]+'"></div>')
                        $("#tc_"+this[0]).load("_TY_tm_cards_ajax.cfm?user_id="+this[0])
                    })
                }
                else {
                    $("#t_lists").append('<span>No results</span>')
                }
                
            },
            error : function(result, status, erreur){
            },
            complete : function(result, status){
            }	
        });
    }
	
});
</script>
</body>
</html>
