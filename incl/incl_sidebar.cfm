<style>
	.li_row {
		list-style:none
	}
</style>

<div class="sidebar" data-color="white" data-active-color="danger">
	
	<div class="logo d-flex align-items-center justify-content-center" style="height:64px">
		<a href="index.cfm">
			<cfif isdefined("SESSION.GROUP_ID") AND SESSION.GROUP_ID neq "232">
				<cfoutput>
				<img src="#SESSION.BO_ROOT_URL#/assets/img/logo_wefit_solo_150.png" height="42" align="center" style="vertical-align:center">
				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_group/#SESSION.GROUP_ID#.jpg")>
					<img src="#SESSION.BO_ROOT_URL#/assets/img_group/#SESSION.GROUP_ID#.jpg"  align="center" style="max-width:120px; max-height:55px">
				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_group/#SESSION.GROUP_ID#.png")>
					<img src="#SESSION.BO_ROOT_URL#/assets/img_group/#SESSION.GROUP_ID#.png"  align="center" style="max-width:120px; max-height:55px">
				</cfif>
				</cfoutput>
			<cfelse>
				<img src="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/assets/img/logo_wefit_solo_150.png" height="42" align="center" style="margin:20px 0px 19px 0px !important">
				<cfif isdefined("SESSION.USER_PROFILE") AND listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
					<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#SESSION.USER_ID#/#SESSION.USER_ID#.png")>
						<cfoutput><img src="#SESSION.BO_ROOT_URL#/assets/user/#SESSION.USER_ID#/#SESSION.USER_ID#.png" height="38" align="center"></cfoutput>
					</cfif>
				</cfif>
			</cfif>
		</a>
	</div>
	
	
	

<cfif isdefined("SESSION.USER_ID") AND isdefined("SESSION.USER_PROFILE")>

	<cfoutput>

	<cfif listFindNoCase("LEARNER,GUEST", SESSION.USER_PROFILE)>
		
		<cfinclude template="./incl_sidebar_learner.cfm">

	<cfelseif listFindNoCase("TEST", SESSION.USER_PROFILE)>
		
		<cfinclude template="./incl_sidebar_test.cfm">

	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
		<cfinclude template="./incl_sidebar_team.cfm">

	<cfelseif SESSION.USER_PROFILE eq "TRAINER">

		<cfinclude template="./incl_sidebar_trainer.cfm">

	<!--- <cfelseif SESSION.USER_PROFILE eq "SCHOOLMNG">

		<cfinclude template="./incl_sidebar_schmng.cfm"> --->

	<cfelseif SESSION.USER_PROFILE eq "TM">

		<cfinclude template="./incl_sidebar_tm.cfm">

	<cfelseif SESSION.USER_PROFILE eq "PARTNER">
		
		<cfinclude template="./incl_sidebar_partner.cfm">
		
	</cfif>
		
	</cfoutput>
	
</cfif>
</div>