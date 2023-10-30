<cfswitch expression="#SESSION.USER_PROFILE#">
	<cfcase value="Administrateur">
		<cfinclude template="admin_index.cfm">
	</cfcase>
	<cfcase value="sales">
		<!--- 	seulement myriam et charlotte on le role sale ATM et elles ont besoin du calendar	 --->
		<!--- <cfinclude template="sales_index.cfm"> --->
		<cfinclude template="cs_index.cfm">
	</cfcase>
	<cfcase value="Learner">
		<cfinclude template="learner_index.cfm">
	</cfcase>
	<cfcase value="TRAINER">
		<cfinclude template="trainer_index.cfm">
	</cfcase>
	<cfcase value="CS">
		<cfinclude template="cs_index.cfm">
	</cfcase>
	<cfcase value="Finance">
		<cfinclude template="cs_index.cfm">
	</cfcase>
	<cfcase value="TM">
		<cfinclude template="tm_index.cfm">
	</cfcase>
	<cfcase value="GUEST">
		<cfinclude template="learner_index.cfm">
	</cfcase>
	<cfcase value="test">
		<cfinclude template="learner_index.cfm">
	</cfcase>
	<!--- <cfcase value="SchoolMNG">
		<cfinclude template="db_certif_school_2.cfm">
	</cfcase> --->
	<cfcase value="TRAINERMNG">
		<cfinclude template="tmg_index.cfm">
	</cfcase>
	<cfcase value="PARTNER">
		<cfinclude template="partner_index.cfm">
	</cfcase>
</cfswitch>
