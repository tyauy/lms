<cfparam name="showfilter" default="0">

<cfif showfilter eq "1">
    <div class="mt-3">
                                
        <!--- <div class="card shadow-sm mb-2 bg-light shadow-sm"> --->
    
            <!--- <div class="card-body pt-0 pb-0" align="center"> --->
        
                
                <div class="d-flex justify-content-left align-items-center">
                    <cfoutput>
                    <div class="p-2">
                        <cfoutput>#obj_translater.get_translate('card_title_display_only_days')#</cfoutput>
                    </div>
                    <div class="p-1 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],1)#
                            <input class="day_interval" name="day_interval" type="checkbox" checked value="2"> 
                        </label>
                    </div>
                    <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],2)#
                            <input class="day_interval" name="day_interval" type="checkbox" checked value="3"> 
                        </label>
                    </div>
                    <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],3)#
                            <input class="day_interval" name="day_interval" type="checkbox" checked value="4"> 
                        </label>
                    </div>
                    <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],4)#
                            <input class="day_interval" name="day_interval" type="checkbox" checked value="5"> 
                        </label>
                    </div>
                    <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],5)#
                            <input class="day_interval" name="day_interval" type="checkbox" checked value="6"> 
                        </label>
                    </div>
                    <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],6)#
                            <input class="day_interval" name="day_interval" type="checkbox" value="7"> 
                        </label>
                    </div>
                    <!--- <div class="p-1 ml-2 px-2 border bg-white">
                        <label class="m-0">#listGetAt(SESSION["DAYWEEK_#SESSION.LANG_CODE#"],7)#
                            <input class="day_interval" name="day_interval" type="checkbox" value="1"> 
                        </label>
                    </div> --->
                    <div class="p-1 ml-2">
                        <input type="submit" class="btn btn-sm btn-outline-red" id="btn_update_day_interval" value="<cfoutput>#obj_translater.get_translate('btn_apply')#</cfoutput>">
                    </div>
                    </cfoutput>
                </div>
            <!--- </div>
        </div> --->
    
    </div>
</cfif>