<div class="row">

	<div class="col-3 border-bottom" align="center">
	
        <cfif step eq "1">
            <button class="btn btn-link d-none d-lg-block">
                <i class="fa-thin fa-chalkboard-teacher fa-3x text-red"></i>
                <h4 class="mt-1 mb-0 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
            </button>
            <button class="btn btn-link p-0 m-0 d-lg-none">
                <i class="fa-thin fa-chalkboard-teacher fa-2x text-red"></i>
                <h6 class="mt-1 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
            </button>
        <cfelse>
            <button class="btn btn-link d-none d-lg-block">
                <i class="fa-thin fa-chalkboard-teacher fa-3x text-muted"></i>
                <h4 class="mt-1 mb-0 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
            </button>
            <button class="btn btn-link p-0 m-0 d-lg-none">
                <i class="fa-thin fa-chalkboard-teacher fa-2x text-muted"></i>
                <h6 class="mt-1 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
            </button>
        </cfif>

    </div>

    <div class="col-3 border-bottom" align="center">

        <cfif step eq "2">
            <button class="btn btn-link d-none d-lg-block">
                <i class="fa-thin fa-calendar-circle-plus fa-3x text-red"></i>
                <h4 class="mt-1 mb-0 text-red">2 - <cfoutput>Book & Go</cfoutput></h4>
            </button>
            <button class="btn btn-link p-0 m-0 d-lg-none">
                <i class="fa-thin fa-calendar-circle-plus fa-2x text-red"></i>
                <h6 class="mt-1 text-red">2 - <cfoutput>Book & Go</cfoutput></h6>
            </button>
        <cfelse>
            <button class="btn btn-link d-none d-lg-block">
                <i class="fa-thin fa-calendar-circle-plus fa-3x text-muted"></i>
                <h4 class="mt-1 mb-0 text-muted">2 - <cfoutput>Book & Go</cfoutput></h4>
            </button>
            <button class="btn btn-link p-0 m-0 d-lg-none">
                <i class="fa-thin fa-calendar-circle-plus fa-2x text-muted"></i>
                <h6 class="mt-1 text-muted">2 - <cfoutput>Book & Go</cfoutput></h6>
            </button>
        </cfif>

    </div>

</div>