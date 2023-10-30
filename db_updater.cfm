<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfif isdefined("sm_id") AND isdefined("form") AND isdefined("h") AND isdefined("tpmaster_id")>

		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(sessionmaster_rank) as maxid FROM lms_tpmastercor2 WHERE tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
		</cfquery>

		<cfif get_max.maxid eq "">
			<cfset newid = 1>
		<cfelse>
			<cfset newid = get_max.maxid+1>
		</cfif>

		<cfquery name="insert_tpcor" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpmastercor2
		(
			tpmaster_id, 
			sessionmaster_id, 
			sessionmaster_rank, 
			sessionmaster_schedule_duration
			)
		VALUES 
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#newid#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#h#">
			)
		</cfquery>

		<cflocation addtoken="no" url="db_tpprefilled_list.cfm?tpmaster_id=#tpmaster_id#&f_id=#f_id#">

	</cfif>
	
	
	

	<cfif isdefined("module_id") AND isdefined("form") AND isdefined("tpmaster_id")>

		<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
			SELECT sessionmaster_id FROM lms_tpsessionmaster2 WHERE module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">
		</cfquery>

		<cfoutput query="get_sm">

			<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				SELECT MAX(sessionmaster_rank) as maxid FROM lms_tpmastercor2 WHERE tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
			</cfquery>

			<cfif get_max.maxid eq "">
				<cfset newid = 1>
			<cfelse>
				<cfset newid = get_max.maxid+1>
			</cfif>

			<cfquery name="insert_tpcor" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpmastercor2
			(
				tpmaster_id, 
				sessionmaster_id, 
				sessionmaster_rank, 
				sessionmaster_schedule_duration
				)
			VALUES 
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_sm.sessionmaster_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#newid#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="60">
				)
			</cfquery>

		</cfoutput>


		<cflocation addtoken="no" url="db_tpprefilled_list.cfm?tpmaster_id=#tpmaster_id#&f_id=#f_id#">

	</cfif>





	<cfif isdefined("tpmastercor_id") AND isdefined("del") AND isdefined("tpmaster_id")>

		<cfquery name="del" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_tpmastercor2 WHERE tpmastercor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmastercor_id#">
		</cfquery>

		<cflocation addtoken="no" url="db_tpprefilled_list.cfm?tpmaster_id=#tpmaster_id#&f_id=#f_id#">

	</cfif>







	<cfif isdefined("user_id") AND isdefined("user_pref_task_group") AND user_pref_task_group neq "">

		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET user_pref_task_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_pref_task_group#">
			WHERE user_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>


		<cflocation addtoken="no" url="db_calendar_settings.cfm?k=1">

	</cfif>






	<cfif isdefined("create") AND isdefined("tpmaster_name") AND isdefined("formation_id")>

		<cfquery name="del" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpmaster2
		(
			tpmaster_name,
			formation_id,
			tpmaster_prebuilt
			)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#tpmaster_name#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
			1
			)
		</cfquery>

		<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(tpmaster_id) as maxid FROM lms_tpmaster2
		</cfquery>

		<cfquery name="insert_tpcor" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpmastercor2
		(
			tpmaster_id, 
			sessionmaster_id, 
			sessionmaster_rank, 
			sessionmaster_schedule_duration
			)
		VALUES 
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.maxid#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="695">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="30">
			)
		</cfquery>

		<cflocation addtoken="no" url="db_tpprefilled_list.cfm">

	</cfif>



	<cfif isdefined("updt_module")>	

		<cfdump var="#form#">		

		<cfquery name="updt_module" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tpmodulemaster2 
			SET module_name_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_name_fr#">,
			module_name_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_name_en#">,
			module_name_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_name_de#">,
			module_description_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_description_fr#">,
			module_description_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_description_en#">,
			module_description_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#update_description_de#">
			WHERE module_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_module#">
		</cfquery>


		<cfif add_picture neq "">

			<cffile action = "upload" 
			filefield = "add_picture" 
			destination = "#SESSION.BO_ROOT#/assets/img_module/" 
			nameConflict = "Overwrite"
			mode="777">

			<cfif cffile.FileWasSaved>
				<cfif FileExists("#SESSION.BO_ROOT#/assets/img_module/#updt_module#.jpg") OR FileExists("#SESSION.BO_ROOT#/assets/img_module/#updt_module#.JPG")>
					<cffile action = "delete" file = "#SESSION.BO_ROOT#/assets/img_module/#updt_module#.jpg">
				</cfif>
				<cffile action="rename" source = "#SESSION.BO_ROOT#/assets/img_module/#cffile.ClientFile#" destination = "#SESSION.BO_ROOT#/assets/img_module/#updt_module#.#lcase(cffile.clientFileExt)#" attributes = "normal" mode="777">
			</cfif>
		</cfif>		

		<cflocation addtoken="no" url="db_module_list.cfm?reload">
		
	</cfif>	




	<cfif isdefined("insert_module")>	

		<cfquery name="insert_module" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpmodulemaster2
		(
			module_level, module_name_fr, module_name_en, module_name_de, module_description_fr, module_description_en, module_description_de
		)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_level#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_fr#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_en#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_de#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_description_fr#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_description_en#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_description_de#">
		)
		</cfquery>

		<cflocation addtoken="no" url="db_module_list.cfm">

	</cfif>
	

	<cfif isdefined("insert_tpprefilled")>
	
		<cfif findNoCase("A", #insert_level#)>
			<cfset big_level = "A">
		<cfelseif findNoCase("B", #insert_level#)>
			<cfset big_level = "B">
		<cfelseif findNoCase("C", #insert_level#)>
			<cfset big_level = "C">
		</cfif>
		
	
		<cfquery name="insert_tpprefilled" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpmaster2
		(
		tpmaster_name, tpmaster_name_fr, tpmaster_name_en, tpmaster_name_de, tpmaster_name_es, tpmaster_prebuilt, tpmaster_level, tpmaster_biglevel, formation_id, tpmaster_hour, tpmaster_lesson_duration
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_fr#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_fr#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_en#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_de#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_name_es#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#insert_level#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#big_level#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_formation_lg#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_hour#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_lesson_duration#">
		)
		</cfquery>
		
		<cflocation addtoken="no" url="db_tpprefilled_list.cfm">
	</cfif>


	<cfif isdefined("updt_product")>

		<cfdump var="#form#">	

		
		<cfquery name="updt_module" datasource="#SESSION.BDDSOURCE#">
		UPDATE product
		SET category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_cat#">,

		<!--- product_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_name_fr#">, --->
		product_name_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_name_fr#">,
		product_name_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_name_en#">,
		product_name_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_name_de#">,

		<!--- product_subname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_subname_fr#">, --->
		product_subname_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_subname_fr#">,
		product_subname_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_subname_en#">,
		product_subname_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_subname_de#">,

		<!--- product_abstract = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_abstract_fr#">, --->
		product_abstract_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_abstract_fr#">,
		product_abstract_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_abstract_en#">,
		product_abstract_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_abstract_de#">,

		<!--- product_description = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#updt_description_fr#">, --->
		product_description_fr = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#updt_description_fr#">,
		product_description_en = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#updt_description_en#">,
		product_description_de = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#updt_description_de#">,

		<!--- product_description_long = '#updt_description_long_fr#', --->
		product_description_long_fr = '#updt_description_long_fr#',
		product_description_long_en = '#updt_description_long_en#',
		product_description_long_de = '#updt_description_long_de#',
		
		<!--- product_title_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_title_fr#">, --->
		product_title_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_title_fr#">,
		product_title_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_title_en#">,
		product_title_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_title_de#">,
		
		<!--- product_desc_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_desc_page_fr#">, --->
		product_desc_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_desc_page_fr#">,
		product_desc_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_desc_page_en#">,
		product_desc_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#updt_desc_page_de#">,
		
		product_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_type#">
		<cfif isdefined('unit_price') and unit_price neq ""> ,product_price_unit = <cfqueryparam cfsqltype="cf_sql_decimal" value="#unit_price#"></cfif>
		<cfif isdefined('insert_certif') and insert_certif neq 0>, certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_certif#"></cfif>
		WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_product#">
		</cfquery>
		
		<cflocation addtoken="no" url="shop_product_edit.cfm?p_id=#updt_product#">
		
		</cfif>
		
		<cfif isdefined("updt_product_var")>
		
		<cfif product_type eq "variable">
			<cfquery name="rm_attribute" datasource="#SESSION.BDDSOURCE#">
				UPDATE product_attribute SET product_id = 0 WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_product#">
			</cfquery>

			<cfset attr_number_list = "">
			<cfloop collection="#form#" item="form_elt" >
				<cfif findNoCase('insert_attribute', #form_elt#)>
					<cfset tmp_attr = listToArray(#form_elt#, '_')>
					<cfset attr_number_list = listappend(#attr_number_list#, "#tmp_attr[3]#")>
				</cfif>
			</cfloop>
			<cfdump var="#attr_number_list#">

			<cfloop list="#attr_number_list#" index="nbr_attr">
				
				<cfquery name="insert_attribute" datasource="#SESSION.BDDSOURCE#" result="new_attr">
					INSERT INTO product_attribute
					(
					attribute_name,
					product_id
					)
					VALUES(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form['insert_attribute_#nbr_attr#']#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#updt_product#">
					)
				</cfquery>
				
				<cfset attr_id = new_attr.generatedkey>
				
				
				<cfset var_list = "">
				<cfloop collection="#form#" item="form_elt" >
					<cfif findNoCase('insert_variation_#nbr_attr#', #form_elt#)>
						<cfset var_list = listappend(#var_list#, "#form['#form_elt#']#")>
					</cfif>
				</cfloop>
				<cfdump var="#var_list#">
				
				
				
				
				
				<cfloop list="#var_list#" index="name_var">
				
					<cfif form['insert_attribute_#nbr_attr#'] eq "Langue">
						<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
							SELECT * FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#name_var#">
						</cfquery>
						<cfset var_name_fr = #get_formation.formation_name_fr#>
						<cfset language_id = #name_var#>
					<cfelse>
						<cfset var_name_fr = #name_var#>
						<cfset language_id = 0>
					</cfif>
					<cfset var_certif = #form['insert_varcertif_#nbr_attr#_#var_name_fr#']#>
					
					
					<cfquery name="insert_variation" datasource="#SESSION.BDDSOURCE#">
						INSERT INTO product_variation
						(
						attribute_id,
						<cfif language_id neq 0>formation_id,</cfif>
						<cfif var_certif neq '0'>certif_id,</cfif>
						variation_name_fr,
						price_unit,
						group_unit
						)
						VALUES(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#attr_id#">,
						<cfif language_id neq 0><cfqueryparam cfsqltype="cf_sql_integer" value="#language_id#">,</cfif>
						<cfif var_certif neq '0'><cfqueryparam cfsqltype="cf_sql_integer" value="#var_certif#">,</cfif>
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#var_name_fr#">,
						<cfqueryparam scale="2" cfsqltype="cf_sql_decimal" value="#form['varprice_#nbr_attr#_#var_name_fr#']#">,
						<cfqueryparam cfsqltype="cf_sql_decimal" value="#form['vargroup_#nbr_attr#_#var_name_fr#']#">
						)
					</cfquery>
					
				</cfloop>
				
				
			</cfloop>
			
		</cfif>
		
		<cflocation addtoken="no" url="shop_product_edit.cfm?p_id=#updt_product#">

	</cfif>
	
	
	
	
	<cfif isdefined('add_cpn')>
		<cfdump var="#form#">
		
		<cfset product_list = "">
		<cfloop collection="#form#" item="key">
			<cfif findnocase("product_", #key#)>
				<cfset cur_product = #form[key]#>
				<cfif not listFind(#product_list#, #cur_product#)>
					<cfset product_list = listAppend(#product_list#, #cur_product#)>
				</cfif>
			</cfif>
		</cfloop>
		<cfif product_list eq ""><cfset product_list = "0"></cfif>
		<cfdump var="#product_list#">
		
		<cfquery name="updt_coupon" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO product_coupon
			(
			coupon_code,
			coupon_discount,
			coupon_type,
			coupon_use_limit,
			product_id,
			coupon_start,
			coupon_end,
			group_id,
			user_id,
			coupon_valid
			)
			VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_code#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_discount#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_type#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#use_limit#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#product_list#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#date_start#">,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#date_end#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#c_group eq "" ? 0 : c_group#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#c_user_id eq "" ? 0 : c_user_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#isdefined("c_valid") ? c_valid : 0 #">
			)
		</cfquery>
		
		<cflocation addtoken="no" url="shop_product_list.cfm?show=coupon">
	</cfif>
	
	<cfif isdefined("updt_cpn")>
	
		<cfdump var="#form#">
		
		<cfif nb_product eq 0>
			<cfset product_list = "0">
		<cfelse>
			<cfset product_list = "">
			<cfloop from="1" to="#nb_product#" step="1" index="pp">
				<cfif isdefined('product_#pp#')>
					<cfset cur_product = #evaluate('product_#pp#')#>
					<cfif not listFind(#product_list#, #cur_product#)>
						<cfset product_list = listAppend(#product_list#, #cur_product#)>
					</cfif>
				</cfif>
			</cfloop>
			<cfif product_list eq ""><cfset product_list = "0"></cfif>
		</cfif>
		<cfdump var="#product_list#">
		
		
		<cfquery name="updt_coupon" datasource="#SESSION.BDDSOURCE#">
			UPDATE product_coupon
			SET coupon_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_code#">,
			coupon_discount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_discount#">,
			coupon_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#coupon_type#">,
			<cfif use_limit neq "">coupon_use_limit = <cfqueryparam cfsqltype="cf_sql_integer" value="#use_limit#">,</cfif>
			product_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#product_list#">,
			coupon_start = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#date_start#">,
			coupon_end = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#date_end#">,
			group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_group#">,
			user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_user_id neq "" ? c_user_id : 0#">,
			coupon_valid = <cfqueryparam cfsqltype="cf_sql_integer" value="#isdefined("c_valid") ? c_valid : 0 #">
			WHERE coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#updt_cpn#">
		</cfquery>
		
		<cflocation addtoken="no" url="shop_product_list.cfm?show=coupon">
		
	</cfif>




	<cfif isdefined("translation_id") AND isdefined("t_cat") AND isdefined("t_type") AND isdefined("act") AND act eq "updt">
			
		<cfquery name="updt_translation" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_translation SET 
			<cfif isdefined("translation_string_fr")>translation_string_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_fr#">,</cfif>
			<cfif isdefined("translation_string_en")>translation_string_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_en#">,</cfif>
			<cfif isdefined("translation_string_de")>translation_string_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_de#">,</cfif>
			<cfif isdefined("translation_string_es")>translation_string_es = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_es#">,</cfif>
			<cfif isdefined("translation_string_it")>translation_string_it = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_it#">,</cfif>
			<cfif isdefined("translation_string_zh")>translation_string_zh = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_zh#">,</cfif>
			translation_cat = '#t_cat#'
			WHERE translation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#translation_id#">
		</cfquery>
		<cflocation addtoken="no" url="db_translate_list.cfm?t_cat=#t_cat#&t_type=#t_type#&list_lang=#list_lang###t_#translation_id#">
	</cfif>
	
	
	
	
	


	<cfif isdefined("token_id") AND isdefined("act") AND act eq "del">
		<cfquery name="" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_list_token SET 
			user_id = null,
			token_send = null
			WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
		</cfquery>
		<cflocation addtoken="no" url="db_certif_list.cfm">
	</cfif>
	
	
	
	
	
</cfif>