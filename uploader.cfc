<cfcomponent>	
	
	<cffunction name="insert_voc_audio" access="remote" output="false" returntype="any" returnformat="plain">
	
		<cfargument name="voc_id" type="numeric" required="yes">
		<cfargument name="lang_code" type="any" required="yes">
		<cfargument name="data" required="yes">	
		
		<cfif fileexists("#SESSION.BO_ROOT#/assets/voc/word_#lang_code#_#voc_id#.mp3")>
		
			<cffile action ="delete" file="#SESSION.BO_ROOT#/assets/voc/word_#lang_code#_#voc_id#.mp3">
		</cfif>
		
		
		<cffile action ="readBinary" file="#data#" variable="binary_file">
		<cffile action ="write" file="#SESSION.BO_ROOT#/assets/voc/word_#lang_code#_#voc_id#.mp3" output="#toBinary(binary_file)#">

		<cfreturn "ok">
		
	</cffunction>
	
</cfcomponent>