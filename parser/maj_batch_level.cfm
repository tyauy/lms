<html>
    
<head>
    <base href="https://lms.wefitgroup.com/">
	<cfinclude template="../incl/incl_head.cfm">

</head>

<body>
<cfset f_id = 2>

<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
    SELECT tc.*, sm.*, tp.*, tm.module_name, tpo.tp_orientation_name_fr, ll.level_alias, ll.level_css, em.elearning_module_id
    FROM lms_tpmaster2 tp
    INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
    LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
    LEFT JOIN lms_tporientation tpo ON tpo.tp_orientation_id = sm.tp_orientation_id	
    LEFT JOIN lms_level ll ON ll.level_id = sm.level_id	
    
    LEFT JOIN lms_elearning_module em ON em.sessionmaster_id = sm.sessionmaster_id	
    
    
    
    WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    AND tp.tpmaster_prebuilt = 0
    AND tp.tpmaster_id < 200
    GROUP BY sm.sessionmaster_id
    ORDER BY tpmaster_rank ASC, sm.module_id, sm.sessionmaster_level, sm.sessionmaster_id 
    </cfquery>


    <ul class="nav nav-tabs" id="tp_list" role="tablist">
        <cfoutput query="get_session_access" group="tpmaster_id">
            <li class="nav-item">
                <a class="nav-link <cfif tpmaster_id eq "1">active</cfif>" data-toggle="tab" data-target="##go_#tpmaster_id#" type="button" role="tab"
                    aria-controls="go_#tpmaster_id#" aria-selected="<cfif tpmaster_id eq "1">true<cfelse>false</cfif>"
                    >[#tpmaster_id#] #tpmaster_name# #tpmaster_level#</a>
            </li>
        </cfoutput>
    </ul>

<div class="tab-content">
<cfoutput query="get_session_access" group="tpmaster_id">
<cfif tpmaster_id neq "">
    <div class="tab-pane fade <cfif tpmaster_id eq "1">show active</cfif>" id="go_#tpmaster_id#" role="tabpanel">
       
       <table class="table">
        <cfoutput group="module_id">
            <cfif module_id neq "">
            <tr>	
                <td colspan="4" class="bg-light font-weight-bold">#ucase(module_name)#</td>
            </tr>
            </cfif>

            <cfoutput>
                <tr>
                    <td>
                    #sessionmaster_name#
                    </td>
                    <td>
                        Category level = #tpmaster_level#
                    </td>
                    <td>
                        Lesson level = #obj_function.get_level_thumb(level_id=level_id,size=40)#
                    </td>
                </tr>
            </cfoutput>
        </cfoutput>
        </table>
    </div></cfif>
</cfoutput>
</div>


</body>
</html>
<cfinclude template="../incl/incl_scripts.cfm">
