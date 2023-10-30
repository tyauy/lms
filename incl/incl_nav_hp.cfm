<div class="d-flex align-items-end header_rounded" style="background-image: url('https://lms.wefitgroup.com/assets/img/back_connect_3.jpg'); height:230px; background-position:center right; background-size: cover;">
    
    <div class="footer_rounded" style="width:100%; height:auto; text-align: center; background: linear-gradient(to right, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 1))">
        <div class="p-2 px-4">
            <div class="w-100 footer_rounded align-items-center">
            
                <h5 class="d-inline my-0" align="center">
                    <cfset user_firstname = SESSION.USER_FIRSTNAME>
                    <cfset arr = ['user_firstname']>
                    <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
    
                    <cfif not isdefined("SESSION.WELCOME_MESSAGE")>
                        <cfoutput>#obj_translater.get_translate_complex(id_translate="alert_welcome_message", argv="#argv#")#</cfoutput>
                        <cfset SESSION.WELCOME_MESSAGE = "1">
                    <cfelse>	
                        <cfoutput>#obj_translater.get_translate_complex(id_translate="alert_dashboard_message", argv="#argv#")#</cfoutput>
                    </cfif>
                </h5>

            </div>
        </div>
    </div>    
    
</div>