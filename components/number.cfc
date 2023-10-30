<cfcomponent>

	<cffunction name="get_space_number" access="public" returntype="string">
		<cfargument name="num" type="string" required="yes">


		<cfif isdefined("SESSION.LANG_CODE") AND SESSION.LANG_CODE neq "de">
			<cfset deli = " ">
		<cfelse>
			<cfset deli = ".">
		</cfif>

		<cfset body = "">

		<cfif num neq "">

			<cfset a = num.ListToArray(".,")>

			<cfset a[1] = Reverse(a[1])>

			<cfloop index="i" from="#Len(a[1])#" to="1" step="-1">

				<cfset body = body & a[1][i]>

				<cfif i % 3 eq 1 AND i neq 1>
					<cfset body = body & deli>
				</cfif>

			</cfloop>
			
			<!--- <cfset toreturn = round(num)>

			<cfif len(toreturn) eq "4">
				<cfset toreturn = "#mid(toreturn,1,1)# #mid(toreturn,2,3)#">
			<cfelseif len(toreturn) eq "5">
				<cfset toreturn = "#mid(toreturn,1,2)# #mid(toreturn,3,3)#">
			<cfelseif len(toreturn) eq "6">
				<cfset toreturn = "#mid(toreturn,1,3)# #mid(toreturn,3,3)#">
			</cfif> --->

			<cfif arrayLen(a) GT 1>
				<cfif a[2] neq 0>
					<cfset body = body & "," & a[2]>
				</cfif>
			</cfif>

		</cfif>

		
						
        <cfreturn body>
        
     </cffunction>
	 
</cfcomponent>