<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/header_lms_vc.jpg'); height:230px; background-position:top right; background-size: cover;">
    
    <div style="width: 100%; height:auto; text-align: center; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="p-2 px-4">
            <div class="w-100 d-flex justify-content-between align-items-center">
            
                <h5 class="d-inline my-0">
                    <strong>VIRTUAL CLASS</strong>
                </h5>

                <div>
                    <cfoutput>#obj_translater.get_translate("table_th_my_level")#: </cfoutput>
                    
                    <cfif StructKeyExists(SESSION.USER_LEVEL,'#f_code#')>
                        <cfset lvl_verified = SESSION.USER_LEVEL['#f_code#'].level_verified>
                        <cfset lvl_sub_id = SESSION.USER_LEVEL['#f_code#'].level_sub_id>
                        <cfset lvl_id = SESSION.USER_LEVEL['#f_code#'].level_id>
                        <cfset lvl_code = SESSION.USER_LEVEL['#f_code#'].level_code>
                        <cfif lvl_verified eq "1">
                            <cfoutput><img src="./assets/img_sublevel/#lvl_sub_id#_plain.svg" width="30"></cfoutput>
                        <cfelse>
                            <cfif lvl_id neq "" AND lvl_id neq "0">
                                <cfoutput><img src="./assets/img_level/#lvl_code#.svg" width="30"> <small>(#obj_translater.get_translate("text_not_verified")#)</small></cfoutput>
                            <cfelse>
                                -
                            </cfif>
                        </cfif>
                    <cfelse>
                        -
                    </cfif>
                </div>

            </div>
        </div>
    </div>    
    
</div>