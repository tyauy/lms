<cfquery name="get_mapping_level" datasource="#SESSION.BDDSOURCE#">
    SELECT l.level_id, l.level_alias, 
    ls.level_sub_id, ls.level_sub_name, ls.level_sub_css, 
    lm.mapping_name, lm.mapping_id, lm.mapping_category
    FROM lms_level l
    INNER JOIN lms_level_sub ls ON ls.level_id = l.level_id
    INNER JOIN lms_mapping lm ON lm.level_sub_id = ls.level_sub_id AND lm.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    WHERE l.level_id NOT IN (6) AND mapping_category <> 'NA'
    ORDER BY ls.level_id ASC,  ls.level_sub_id ASC, lm.mapping_category, lm.mapping_name ASC 
</cfquery>


<div id="accordion_mapping">
    <div class="btn-group-toggle" data-toggle="buttons">
        <cfoutput query="get_mapping_level" group="level_id">
            <label class="btn btn-lg btn-outline-#level_alias# <cfif level_id eq "1">active</cfif>" data-toggle="collapse" data-target="##collapse_#level_id#" <cfif level_id eq "1">aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                <input type="radio" name="level_go_id" id="level_go_id" value="1" autocomplete="off">
                <img src="./assets/img_level/#level_alias#.svg" width="30">
            </label>
        </cfoutput>	
    </div>

    <cfoutput query="get_mapping_level" group="level_id">
        <div id="collapse_#level_id#" class="<cfif level_id neq "1">collapse<cfelse>collapse show</cfif> pt-2" data-parent="##accordion_mapping">
            <div class="row">
            <cfoutput group="level_sub_id">
                <div class="col-md-4">
                    <div class="card border h-100 bg-white">
                        <div class="card-title bg-#level_alias#">
                            <h5 align="center" class="text-white m-0 font-weight-bold">#level_sub_name#</h5>
                        </div>
                        <table class="table table-sm">
                        <cfoutput group="mapping_category">
                            <tr>
                                <td>
                                    <label class="text-dark">
                                        <strong>#ucase(mapping_category)#</strong>
                                    </label>
                                </td>
                            </tr>
                            <cfoutput>
                                <tr>
                                    <td>
                                        <label class="text-dark">
                                            <input type="checkbox" class="mapping-checkbox" name="mapping_id" value="#mapping_id#" <cfif listfind(m_id,mapping_id)>checked="checked"</cfif>> #mapping_name#
                                            
                                            <!-- Toggle switch. It's initially hidden and disabled. -->
                                            <div class="custom-control custom-switch ml-2 d-none">
                                                <input type="checkbox" class="custom-control-input toggle-main-switch" id="mainToggle_#mapping_id#" disabled>
                                                <label class="custom-control-label" for="mainToggle_#mapping_id#">Main grammar point</label>
                                            </div>
                                        </label>
                                    </td>
                                </tr>
                                
                                
                            </cfoutput>
                        </cfoutput>
                        </table>
                    </div>
                </div>
            </cfoutput>
            </div>
        </div>
    </cfoutput>	
</div>