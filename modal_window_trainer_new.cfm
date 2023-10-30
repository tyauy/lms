<cfif isDefined("p_id")>

    <cfsilent>

        <cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>

        <cfset SESSION.show_new_trainer = "-1">
    </cfsilent>

    <div align="center">

        <h4 class="mt-0"><strong><cfoutput>#obj_translater.get_translate('alert_modif_trainer_ok')# #get_planner.user_firstname#</cfoutput></strong> <cfoutput>#obj_lms.get_thumb(user_id="#p_id#",size="50",responsive="yes")#</cfoutput></h4>	
        <img src="./assets/img/method_discover.jpg">
        <br><br>
        <p>
            <small>
                <cfoutput>#obj_translater.get_translate('alert_modif_trainer_warning')#</cfoutput>
            </small>
        </p>
        <button class="btn btn-info btn-sm close_modal">OK</button>
    </div>

    <script>
        $(document).ready(function() {
            $(".close_modal").click(function() {
                $('#window_item_xl').modal('hide');
            })
        })
    </script>
</cfif>