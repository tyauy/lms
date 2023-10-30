<cfparam name="formation_id" default="2">

<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>
<cfset l_id = get_session.lesson_id>

<!--- <cfif get_session.status_id eq "5">  --->

<!--- <cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>

<cfset lesson_skill_id = "">

<cfif get_lessonnote.sm_skill_id neq "">
    <cfif get_lessonnote.sessionmaster_ln_grammar neq "">
    <cfset lesson_skill_id = listappend(lesson_skill_id,"5")>
    </cfif>
    <cfif get_lessonnote.sessionmaster_ln_vocabulary neq "">
    <cfset lesson_skill_id = listappend(lesson_skill_id,"6")>
    </cfif>
</cfif>

<cfif lesson_skill_id neq "" AND get_lessonnote.s_skill_id neq "">
    <cfset lesson_skill_id = lesson_skill_id & "," & get_lessonnote.s_skill_id>
<cfelseif get_lessonnote.s_skill_id neq "">
    <cfset lesson_skill_id = get_lessonnote.s_skill_id>
</cfif>

<cfoutput query="get_lessonnote">
    <cfset _skill_id = lesson_skill_id>
    <cfif _skill_id neq "">
        <cfset show_desc = 1>
        <cfinclude template="../widget/wid_level_list.cfm">
    </cfif>
</cfoutput> --->


<!--- </cfif> --->



<cfquery name="get_level_list" datasource="#SESSION.BDDSOURCE#">
	SELECT l.level_alias, ls.level_sub_name, ls.level_sub_id, ls.level_sub_css
	FROM lms_level_sub ls
	INNER JOIN lms_level l ON l.level_id = ls.level_id
	WHERE l.level_id NOT IN (6)
</cfquery>

<!--- <cfset _skill_id = 2> --->
<cfloop list="2,3" index="_skill_id">

<cfquery name="get_skill_list" datasource="#SESSION.BDDSOURCE#">
	SELECT subsk.skill_sub_id, subsk.skill_sub_name_#SESSION.LANG_CODE# as sub_name,
    l.level_alias, ls.level_sub_name, ls.level_sub_css, ls.level_sub_id, lf.feedback_text_#SESSION.LANG_CODE# as feedback_text,
	sk.skill_name_#SESSION.LANG_CODE# as skill_name, ts.*
	FROM lms_skill_sub2 subsk
    INNER JOIN lms_skill sk ON sk.skill_id = subsk.skill_id
    LEFT JOIN tracking_skill ts ON ts.sub_skill_id = subsk.skill_sub_id AND ts.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
    LEFT JOIN lms_feedback lf ON lf.level_sub_id = ts.level_sub_id AND lf.skill_sub_id = subsk.skill_sub_id
    LEFT JOIN lms_level_sub ls ON ts.level_sub_id = ls.level_sub_id
	LEFT JOIN lms_level l ON l.level_id = ls.level_id
    WHERE subsk.skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#_skill_id#">
    ORDER BY skill_sub_id ASC
    LIMIT 1
</cfquery>




<a class="btn btn-info">

    <h6 class="mb-0">
								
        <i class="fal fa-head-side-headphones fa-lg" aria-hidden="true"></i> <cfoutput>#get_skill_list.skill_name#</cfoutput>
        
    </h6>
</a>


<div id="div_1" class="collapse show" aria-labelledby="skill_1" data-parent="#skills_accordion" style="">
								
    <div class="card-body">
    
        <table class="table">

            <cfloop query="get_skill_list">
                <tr>
                    <td>
                        <cfoutput>#get_skill_list.sub_name#</cfoutput>
                    </td>
                    <td align="left">
                        <div class="btn-group-toggle" data-toggle="buttons">
            
                            <cfoutput query="get_level_list">
                                <cfset css = "#level_sub_css#">
            
                                <cfif level_sub_id eq get_skill_list.level_sub_id>
                                    <label class="btn btn-sm btn-#css# text-white active">
                                        <input type="radio" checked name="level_id" id="feedid_#_skill_id#_selected" value="#level_sub_name#" autocomplete="off" required> 
                                        #replace(level_sub_name,"_",".")#
                                    </label>
                                <cfelse>
                                    <label class="btn btn-sm btn-outline-#css# <cfif get_skill_list.level_sub_id neq "">disabled<cfelse>level_selector</cfif>" id="level_selector_#get_skill_list.skill_sub_id#_#level_sub_id#">
                                        <input type="radio" name="level_id" id="feedid_#_skill_id#_#get_skill_list.skill_sub_id#_#level_sub_id#" class="level_select" value="#level_sub_name#" autocomplete="off" required> 
                                        #replace(level_sub_name,"_",".")#
                                    </label>
                                </cfif>
                                
                            </cfoutput>
                        </div>
                    </td>	
                </tr>
                <cfif get_skill_list.feedback_text neq "">
                    <tr align="center">
		
                        <td class="bg-light text-muted" width="150">
                            <i class="fa-thin fa-chart-user fa-2x"></i><br>Aptitudes
                        </td>

                        <td align="left">	
                            <strong><cfoutput>#get_skill_list.sub_name#</cfoutput></strong>
                            <p>
                                <cfoutput>#replacenocase(get_skill_list.feedback_text,chr(10),"<br>")#</cfoutput>
                            </p>
                        </td>

                    </tr>
                <cfelse>
                    <cfquery name="get_feedback_list" datasource="#SESSION.BDDSOURCE#">
                        SELECT lf.feedback_text_#SESSION.LANG_CODE# as feedback_text, lf.level_id, lf.level_sub_id,
                        subsk.skill_sub_name_#SESSION.LANG_CODE# as sub_name, subsk.skill_sub_id
                        FROM lms_feedback lf
                        INNER JOIN lms_skill_sub2 subsk ON lf.skill_sub_id = subsk.skill_sub_id
                        WHERE subsk.skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_list.skill_sub_id#">
                    </cfquery>

                    <cfoutput query="get_feedback_list">
                        <tr align="center" class="level_presentation_#skill_sub_id#" id="level_presentation_#skill_sub_id#_#level_sub_id#" <cfif currentrow neq 1>style="display: none;"</cfif>>
		
                            <td class="bg-light text-muted" width="150">
                                <i class="fa-thin fa-chart-user fa-2x"></i><br>Aptitudes #level_id#
                            </td>
    
                            <td align="left">	
                                <strong>#sub_name#</strong>
                                <p>
                                    #replacenocase(feedback_text,chr(10),"<br>")#
                                </p>
                            </td>
    
                        </tr>
                    </cfoutput>
                    

                </cfif>
                
            </cfloop>

        </table>
       
        <br>

    </div>
</div>
</cfloop>


<script>
    $(document).ready(function () {

        $(".level_selector").on("mouseenter", function(event) {
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");

            $('.level_presentation_' + idtemp[2]).hide();
            $('#level_presentation_' + idtemp[2] + '_' + idtemp[3]).show();
        })

        $( ".level_select").change(function(event) {

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");

		$.ajax({
			url : './api/tracking/tracking_post.cfc?method=up_user_level_subskill',
			type : 'POST',
			data : {
				user_id: <cfoutput>#u_id#</cfoutput>,
				formation_id: <cfoutput>#formation_id#</cfoutput>,
                session_id:<cfoutput>#s_id#</cfoutput>, 
                trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
				skill_id: idtemp[1],
				sub_skill_id: idtemp[2],
				level_sub_id: idtemp[3]
			},				
			success : function(result, status) {
				console.log("yes")
			}
		});
	});
    })
</script>