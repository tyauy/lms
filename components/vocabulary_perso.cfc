<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">


	<cffunction name="add_user_voc" access="remote" returntype="any">
		<cfargument name="uid" type="numeric" required="yes">
		<cfargument name="vid" type="numeric" required="yes">
		
		<cfquery name="add_uvoc" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_vocablist (user_id, voc_id) VALUES (#uid#, #vid#)
		</cfquery>

	</cffunction>


	<cffunction name="rm_user_voc" access="remote" returntype="any">
		<cfargument name="uid" type="numeric" required="yes">
		<cfargument name="vid" type="numeric" required="yes">
		
		<cfquery name="rm_uvoc" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM user_vocablist WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#uid#"> AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vid#">
		</cfquery>

	</cffunction>


	<cffunction name="order_by_cat" access="remote" returntype="any">
		<cfargument name="lang_select" type="string" required="yes">
		<cfargument name="order_cat" type="integer" required="no">
	
	
		<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
			SELECT v.*,
			vtfr.voc_type_name_fr as voc_type_name_fr,
			vten.voc_type_name_en as voc_type_name_en,
			vtde.voc_type_name_de as voc_type_name_de,
			vcat.voc_cat_name_#lang_select# as voc_cat
				
			FROM lms_vocabulary v
						
			LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
			LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
			LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
								
			LEFT JOIN lms_vocabulary_category vcat ON v.voc_cat_id = vcat.voc_cat_id
								
			INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_id
			
								
			WHERE uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				  
			ORDER BY <cfif isdefined('order_cat')>voc_cat, </cfif>voc_word_#lang_select#
		</cfquery>
		
	</cffunction>

		
	
</cfprocessingdirective>

</cfcomponent>