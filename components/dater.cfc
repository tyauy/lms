<cfcomponent>

	<cffunction name="switch_date" access="public" returntype="string">
		<cfargument name="date_to_switch" type="string" required="yes">
        <cfargument name="date_format" type="string" required="yes">

		<cfif date_format eq "bdd">
        	<cfset d = listgetat(date_to_switch,1,"/")>  
            <cfset m = listgetat(date_to_switch,2,"/")>
            <cfset y = listgetat(date_to_switch,3,"/")>            
            <cfset toreturn = "#y#-#m#-#d#">            
        <cfelseif date_format eq "fr">
			<cfset toreturn = dateformat(date_to_switch,'dd/mm/yyyy')>    
		<cfelse>
        	<cfset toreturn = dateformat(date_to_switch,'mm/dd/yyyy')>    
        </cfif>

        <cfreturn toreturn>
        
     </cffunction>
	 
	 
	 
	 
<cffunction name="getdayofweek" access="public" returntype="numeric" output="false" hint="Returns our proxy day of week value.">

    <!--- Define arguments. --->
    <cfargument name="Date" type="date" required="true" hint="The date that we are using to get the day of week." />

    <cfargument name="FirstDayOfWeek" type="numeric" required="false" default="2" hint="This is the day (1 = Sunday) that we are treating as the first day of the week." />

    <cfreturn
        (
            (
                (
                    DayOfWeek( ARGUMENTS.Date ) +
                    (7 - ARGUMENTS.FirstDayOfWeek)
                ) MOD 7
            ) +
            1
        ) />
</cffunction>


<cffunction name="get_full_date_fr" access="public" returntype="string">

    <cfargument name="date_link" type="date" required="true" hint="The date that we are using to get the day of week." />


    <cfreturn "#listgetat(SESSION.DAYWEEK_ORDERED_FR,dayofweek(date_link))# #dateformat(date_link,'dd')# #listgetat(SESSION.LISTMONTHS_JS,month(date_link))# #dateformat(date_link,'YYYY')#">

</cffunction>

<cffunction name="get_dateformat" access="public" returntype="string">
	
	<cfargument name="datego" type="date">
	<cfargument name="user_lang" required="no">

    <cfif isdefined("user_lang")>

	<cfif user_lang eq "fr">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelseif user_lang eq "en">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelseif user_lang eq "de">
		<cfset datego = dateformat(datego,'dd.mm.yyyy')>
	<cfelseif user_lang eq "es">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelse>
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	</cfif>

    <cfelse>

	<cfif SESSION.LANG_CODE eq "fr">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelseif SESSION.LANG_CODE eq "en">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelseif SESSION.LANG_CODE eq "de">
		<cfset datego = dateformat(datego,'dd.mm.yyyy')>
	<cfelseif SESSION.LANG_CODE eq "es">
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	<cfelse>
		<cfset datego = dateformat(datego,'dd/mm/yyyy')>
	</cfif>
    
    </cfif>
	
    <cfreturn datego>

</cffunction>

     
</cfcomponent>