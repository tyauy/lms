<!--- <cfif SESSION.USER_ID eq "11746" OR SESSION.USER_ID eq "25913">
	<cfoutput>
	<div class="row">
				
		<div class="col-3 border-bottom" align="center">
	
			<cfif step eq "1">
				<button href="" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-red"></i>
					<h6 class="mt-1 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button href="" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			</cfif>
	
		</div>
		
	
		<div class="col-3 border-bottom" align="center">
	
			<cfif step eq "2">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-road fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-road fa-2x text-red"></i>
					<h6 class="mt-1 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h6>
				</button>
			<cfelse>	
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-road fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-road fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h6>
				</button>
			</cfif>
	
		</div>
	
		<div class="col-3 border-bottom" align="center">
	
			<cfif step eq "3">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-red"></i>
					<h6 class="mt-1 text-red">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			</cfif>
	
		</div>

		<div class="col-3 border-bottom" align="center">
	
			<cfif step eq "4">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-calendar-circle-plus fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">4 - <cfoutput>Book & Go</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-calendar-circle-plus fa-2x text-red"></i>
					<h6 class="mt-1 text-red">4 - <cfoutput>Book & Go</cfoutput></h6>
				</button>
			<cfelse>
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-calendar-circle-plus fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">4 - <cfoutput>Book & Go</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-calendar-circle-plus fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">4 - <cfoutput>Book & Go</cfoutput></h6>
				</button>
			</cfif>
	
		</div>
	
	</div>
	</cfoutput>

<cfelse> --->
<cfif SESSION.USER_PROFILE eq "TEST">

	<div class="row justify-content-center pl-5">

		<div class="col-3 border-bottom" align="center">

			<cfif step eq "1">
				<button href="learner_launch_1.cfm" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="learner_launch_1.cfm" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-red"></i>
					<h6 class="mt-1 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button href="learner_launch_1.cfm" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="learner_launch_1.cfm" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			</cfif>

		</div>
		
		<div class="col-4 border-bottom" align="center">

			<cfif step eq "2">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-red"></i>
					<h6 class="mt-1 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			</cfif>

		</div>

	</div>


<cfelse>

	<cfoutput>
	<div class="row justify-content-center pl-5">

		<div class="col-3 border-bottom" align="center">

			<cfif step eq "1">
				<button href="" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-red"></i>
					<h6 class="mt-1 text-red">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button href="" class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-bullseye-pointer fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h4>
				</button>
				<button href="" class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-bullseye-pointer fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">1 - <cfoutput>#ucase(obj_translater.get_translate('table_th_step_1'))#</cfoutput></h6>
				</button>
			</cfif>

		</div>
		
		<!--- <div class="col-4 border-bottom" align="center"> --->

			<!--- <cfif step eq "1"> --->
				<!--- <button class="btn btn-link d-none d-lg-block"> --->
					<!--- <i class="fa-thin fa-user fa-3x text-red"></i> --->
					<!--- <h4 class="mt-1 mb-0 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('profile'))#</cfoutput></h4> --->
				<!--- </button> --->
				<!--- <button class="btn btn-link p-0 m-0 d-lg-none"> --->
					<!--- <i class="fa-thin fa-user fa-2x text-red"></i> --->
					<!--- <h6 class="mt-1 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('profile'))#</cfoutput></h6> --->
				<!--- </button> --->
			<!--- <cfelse> --->
				<!--- <button class="btn btn-link d-none d-lg-block"> --->
					<!--- <i class="fa-thin fa-user fa-3x text-muted"></i> --->
					<!--- <h4 class="mt-1 mb-0 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('profile'))#</cfoutput></h4> --->
				<!--- </button> --->
				<!--- <button class="btn btn-link p-0 m-0 d-lg-none"> --->
					<!--- <i class="fa-thin fa-user fa-2x text-muted"></i> --->
					<!--- <h6 class="mt-1 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('profile'))#</cfoutput></h6> --->
				<!--- </button> --->
			<!--- </cfif> --->

		<!--- </div> --->

		<div class="col-4 border-bottom" align="center">

			<cfif step eq "2">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-road fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-road fa-2x text-red"></i>
					<h6 class="mt-1 text-red">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h6>
				</button>
			<cfelse>	
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-road fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-road fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">2 - <cfoutput>#ucase(obj_translater.get_translate('table_th_program_short'))#</cfoutput></h6>
				</button>
			</cfif>

		</div>

		<div class="col-4 border-bottom" align="center">

			<cfif step eq "3">
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-red"></i>
					<h4 class="mt-1 mb-0 text-red">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-red"></i>
					<h6 class="mt-1 text-red">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			<cfelse>
				<button class="btn btn-link d-none d-lg-block">
					<i class="fa-thin fa-chalkboard-teacher fa-3x text-muted"></i>
					<h4 class="mt-1 mb-0 text-muted">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h4>
				</button>
				<button class="btn btn-link p-0 m-0 d-lg-none">
					<i class="fa-thin fa-chalkboard-teacher fa-2x text-muted"></i>
					<h6 class="mt-1 text-muted">3 - <cfoutput>#ucase(obj_translater.get_translate('table_th_trainer'))#</cfoutput></h6>
				</button>
			</cfif>

		</div>

	</div>
	</cfoutput>
</cfif>
<!--- </cfif> --->