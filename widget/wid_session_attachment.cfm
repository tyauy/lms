<cfoutput query="get_session">
                        
<div class="row">
    <div class="col-md-12 mt-12 p-2 h-100">
        <cfset material_exists = 0>
        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
            <cfset material_exists = 1>
            <a href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
        </cfif>
        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
            <cfset material_exists = 1>
            <a href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-info"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_wsk')#</a><br>
        </cfif>	
        <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx")>
            <cfset material_exists = 1>
            <a href="./assets/materials/#sessionmaster_ressource#_WS.pptx" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
        </cfif>
        </cfif>
        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.ppt")>
            <cfset material_exists = 1>
            <a href="./assets/materials/#sessionmaster_ressource#_WS.ppt" target="_blank" class="text-info"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a><br>
        </cfif>

        <!--- CUSTOM PJ DISPLAY --->
        <cfif isDefined("t_id")>
            <cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	
            <cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
                
            <cfif dirQuery.recordcount GT 0>
                <table class="table table-sm table-bordered" id="file_holder">

                    <cfoutput>
                    <cfloop query="dirQuery">
                    <tr id="file_#dirQuery.currentRow#">
                        <td colspan="2">
                        <a href="./assets/lessons/#t_id#/#s_id#/#name#" target="_blank">
                            <span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 40ch;">#name#</span>
                        </a>
                    </td>
                    </tr>
                        
                    </cfloop>
                    </cfoutput>

                    <cfset material_exists = 1>
                </table>
            </cfif>

        </cfif>

        <cfif material_exists eq "0">
            <span class="text-info"><em><small>#obj_translater.get_translate('alert_no_support')#</small></em></span>
        </cfif>

    </div>
    <div class="col-md-12 mt-12 p-2 h-100">
        <cfloop from="1" to="5" index="cor">
            <cfif FileExists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
                <cfset video = "1">
                <a href="./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4" class="text-warning" target="_blank"><i class="fas fa-video"></i> #obj_translater.get_translate('modal_link_video')# #cor#</a><br>
            </cfif>
        </cfloop>
        <cfif not isdefined("video")>
        <span class="text-warning"><em><small>#obj_translater.get_translate('alert_no_video')#</small></em></span>
        </cfif>
    </div>
    <div class="col-md-12 mt-12 p-2 h-100">
        <cfloop from="1" to="5" index="cor">
            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
                <cfset audio = "1">
                <a href="./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" class="text-danger" target="_blank"><i class="fas fa-volume-up"></i> #obj_translater.get_translate('modal_link_audio')# #cor#</a><br>
            </cfif>
        </cfloop>
        <cfif not isdefined("audio")>
        <span class="text-danger"><em><small>#obj_translater.get_translate('alert_no_audio')#</small></em></span>
        </cfif>
    </div>
</div>

</cfoutput>