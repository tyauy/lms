<cfcomponent displayname="user_trainer_post" hint="ColdFusion Component page for inserting or updating data for trainer users">

	<cffunction name="post_user_techno" access="public" returntype="any" output="false" description="insert or update techno link for user">
        <cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="user_skype" type="string" required="no" default="">
        <cfargument name="user_room" type="string" required="no" default="">
		<cfargument name="user_ggmeet" type="string" required="no" default="">
        <cfargument name="user_teams" type="string" required="no" default="">
        <cfargument name="user_zoom" type="string" required="no" default="">
		<cfargument name="user_zoom_access" type="string" required="no" default="">
        <cfargument name="user_whereby" type="string" required="no" default="">
		<cfargument name="user_webex" type="string" required="no" default="">
		<cfargument name="user_techno_preferred" type="string" required="no" default="">

        <cftry>
            <!--- TODO loop on lms_list_techno would be better long term --->
            <!--- looping trough the visio tool list to insert by concatenating looped string with argument variable name --->
            <cfset myArray = ["room", "ggmeet", "zoom", "teams", "webex"] >
            <cfloop array="#myArray#" index="idx">
                
                    
                
                <cfset concat_techno_name = idx>
                <cfif idx eq "room">
                    <cfset concat_techno_name = "Wefit Visio Tool">
                <cfelseif idx eq "ggmeet">
                    <cfset concat_techno_name = "Google Meet">
                </cfif>
                
                <!---  looking to see if link is already in base + we need techno_id --->
                <cfquery name="select_tech" datasource="#SESSION.BDDSOURCE#">
                    SELECT `lms_list_techno`.`techno_id`, `lms_list_techno`.`techno_active`,
                    `user_techno`.`user_techno_id`, `user_techno`.`user_techno_link`, `user_techno`.`user_techno_key` 
                    FROM `lms_list_techno` LEFT JOIN `user_techno` ON `lms_list_techno`.`techno_id` = `user_techno`.`techno_id` 
                    AND `user_techno`.`user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                    WHERE LOWER(`lms_list_techno`.`techno_alias`) LIKE LOWER("%#concat_techno_name#%")
                </cfquery>

                <cfoutput query="select_tech">

                    <!--- insert -  if our link is not empty and no row on bdd --->
                    <cfif user_techno_id eq ""  and arguments["user_" & idx] neq "">
                        <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
                            INSERT INTO `user_techno` (
                                `techno_id`,
                                `user_id`, 
                                <cfif user_techno_preferred eq arguments["user_" & idx]>`user_techno_preferred`,</cfif>
                                <cfif idx eq "zoom">`user_techno_key`,</cfif>
                                `user_techno_link`
                                ) 
                            VALUES (
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#techno_id#">, 
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">, 
                                <cfif user_techno_preferred eq arguments["user_" & idx]>1,</cfif>
                                <cfif idx eq "zoom"><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_zoom_access#">,</cfif>
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments["user_" & idx]#">
                                );
                        </cfquery>

                    <!--- delete - if our link is empty and there is a match on bdd --->
                    <cfelseif user_techno_id neq "" and arguments["user_" & idx] eq "">
                        <cfquery name="delete" datasource="#SESSION.BDDSOURCE#">
                            DELETE FROM `user_techno`
                            WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                            AND `techno_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#techno_id#">
                        </cfquery>

                    <!--- update --->
                    <cfelseif user_techno_id neq "">

                        <cfquery name="update" datasource="#SESSION.BDDSOURCE#">
                            UPDATE `user_techno` SET
                            <cfif user_techno_preferred neq "">
                                `user_techno_preferred` = <cfif user_techno_preferred eq arguments["user_" & idx]> 1 <cfelse> NULL </cfif>,
                            </cfif>
                            <cfif idx eq "zoom">`user_techno_key` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_zoom_access#">,</cfif>
                            `user_techno_link` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments["user_" & idx]#">
                            WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                            AND `techno_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#techno_id#">
                        </cfquery>
                        
                    </cfif>

                </cfoutput>

            </cfloop>

           
        
            <!--- TODO remove return or put a meaningfull return message --->
            <cfreturn 1>
            <cfcatch type="any">
                Error: <cfoutput>#cfcatch.message#</cfoutput>
                <cfreturn 0>
            </cfcatch>
        </cftry>
	</cffunction>



    
    <cffunction name="post_user_ready" access="public" returntype="any" output="false" description="insert or update ready flag for trainer">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="user_ready_france" type="numeric" required="no" default="">
    <cfargument name="user_ready_germany" type="numeric" required="no" default="">
    <cfargument name="user_ready_test" type="numeric" required="no" default="">
    <cfargument name="user_ready_group" type="numeric" required="no" default="">
    <cfargument name="user_ready_classic" type="numeric" required="no" default="">
    <cfargument name="user_ready_tm" type="numeric" required="no" default="">
    <cfargument name="user_ready_vip" type="numeric" required="no" default="">
    <cfargument name="user_ready_partner" type="numeric" required="no" default="">
    <cfargument name="user_ready_assessment" type="numeric" required="no" default="">
    <cfargument name="formation_id" type="numeric" required="yes" default="">

    <cftry>

        <cfquery name="select_rdy" datasource="#SESSION.BDDSOURCE#">
            SELECT `ready_id` FROM `user_ready` 
            WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            AND `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
        </cfquery>
    
        <cfif select_rdy.recordcount eq 0>

            <cfquery datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `user_ready`(
                    `user_id`, 
                    <cfif user_ready_france neq "">`user_ready_france`,</cfif>
                    <cfif user_ready_germany neq "">`user_ready_germany`,</cfif>
                    <cfif user_ready_test neq "">`user_ready_test`,</cfif>
                    <cfif user_ready_group neq "">`user_ready_group`,</cfif>
                    <cfif user_ready_classic neq "">`user_ready_classic`,</cfif>
                    <cfif user_ready_tm neq "">`user_ready_tm`,</cfif>
                    <cfif user_ready_vip neq "">`user_ready_vip`,</cfif>
                    <cfif user_ready_children neq "">`user_ready_children`,</cfif>
                    <cfif user_ready_partner neq "">`user_ready_partner`,</cfif>
                    <cfif user_ready_assessment neq "">`user_ready_assessment`,</cfif>
                    `formation_id`
                    ) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    <cfif user_ready_france neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_france#">,</cfif>
                    <cfif user_ready_germany neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_germany#">,</cfif>
                    <cfif user_ready_test neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_test#">,</cfif>
                    <cfif user_ready_group neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_group#">,</cfif>
                    <cfif user_ready_classic neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_classic#">,</cfif>
                    <cfif user_ready_tm neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_tm#">,</cfif>
                    <cfif user_ready_vip neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_vip#">,</cfif>
                    <cfif user_ready_children neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_children#">,</cfif>
                    <cfif user_ready_partner neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_partner#">,</cfif>
                    <cfif user_ready_assessment neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_assessment#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                    )
            </cfquery>

        <cfelse>

            <cfquery datasource="#SESSION.BDDSOURCE#">
                UPDATE `user_ready` SET
                    <cfif user_ready_france neq "">`user_ready_france` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_france#">,</cfif>
                    <cfif user_ready_germany neq "">`user_ready_germany` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_germany#">,</cfif>
                    <cfif user_ready_test neq "">`user_ready_test` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_test#">,</cfif>
                    <cfif user_ready_group neq "">`user_ready_group` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_group#">,</cfif>
                    <cfif user_ready_classic neq "">`user_ready_classic` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_classic#">,</cfif>
                    <cfif user_ready_tm neq "">`user_ready_tm` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_tm#">,</cfif>
                    <cfif user_ready_vip neq "">`user_ready_vip` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_vip#">,</cfif>
                    <cfif user_ready_children neq "">`user_ready_children` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_children#">,</cfif>
                    <cfif user_ready_partner neq "">`user_ready_partner` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_partner#">,</cfif>
                    <cfif user_ready_assessment neq "">`user_ready_assessment` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_ready_assessment#">,</cfif>
                    `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
            </cfquery>

        </cfif>


    <cfreturn 1>
    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
        <cfreturn 0>
    </cfcatch>
    </cftry>
    </cffunction>


    <cffunction name="upload_doc" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">
        <cfargument name="dir_go" type="any" required="yes">
		<cfargument name="u_id" type="any" required="no">
		<cfargument name="attach_type_id" type="any" required="no">

        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">
								
			<cfif not directoryExists(dir_go)>
			
				<cfdirectory directory="#dir_go#" action="create" mode="777">
			
			</cfif>
				
			<cffile action = "upload" 
            allowedExtensions = ".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc,.pptx"
			filefield = "doc_attach" 
			destination = "#dir_go#" 
			nameConflict = "Overwrite"
			mode="777"
			result="uploaded_file"
			>			
			<cfif uploaded_file.FileWasSaved>		
				<!--- <cfif fileexists("#dir_go#/photo.jpg")>
					<cffile action="delete" file="#dir_go#/photo.jpg">
				</cfif> --->
				<!--- <cffile action="rename" 
				source = "#dir_go#/#uploaded_file.ClientFile#" 
				destination = "#dir_go#/photo.jpg" 
				attributes="normal">  --->
				<cfif (uploaded_file.FileSize GT (5000 * 1024))>
				
					<cffile action="DELETE" file="#dir_go#/#uploaded_file.ClientFile#">
				
					File too big... Please <a href="common_orders.cfm">go back</a> and try again !
					
					<cfabort>	
				</cfif>
			</cfif>
			
			<cfreturn uploaded_file>

		
			
		</cfif>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>




    <cffunction name="delete_doc" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="name" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">
		<cfargument name="s_id" type="any" required="yes">

        <cftry>

			<cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	

            <cffile action="DELETE" file="#dir_go#/#name#">

		
			<cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>

    <cffunction name="delete_learner_doc" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="name" type="any" required="yes">
		<cfargument name="u_id" type="any" required="yes">

        <cftry>

			<cfset dir_go = "#SESSION.BO_ROOT#/assets/user/#u_id#/#hash(u_id)#">	

            <cffile action="DELETE" file="#dir_go#/#name#">

		
			<cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>


    <cffunction name="add_avail_slot" access="public" returntype="any" output="false" description="insert or update avail slot for user">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="lesson_st" type="any" required="yes">
		<cfargument name="lesson_en" type="any" required="yes">

        <cfset start = lsDateTimeFormat(lesson_st,'yyyy-mm-dd HH:nn:ss', 'fr')>
        <cfset end = lsDateTimeFormat(lesson_en,'yyyy-mm-dd HH:nn:ss', 'fr')>

        <cftry>

			<cfquery name="get_init_slot" datasource="#SESSION.BDDSOURCE#">
                SELECT `slot_id`, `slot_start`, `slot_end` FROM `user_slots` 
                WHERE `planner_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                AND (
                    `slot_start` <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#"> 
                    AND `slot_end` >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">
                )
            </cfquery>

            <cfdump var="#get_init_slot#">
        
            <cfif get_init_slot.recordCount eq 0>
        
            <cfquery name="get_slot" datasource="#SESSION.BDDSOURCE#">
                SELECT `slot_id`, `slot_start`, `slot_end` FROM `user_slots` 
                WHERE `planner_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                AND (
                    (`slot_start` <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#"> 
                    AND `slot_end` >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#">
                    AND `slot_end` <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">
                    )
                    OR (`slot_end` >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#"> 
                    AND `slot_start` <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">
                    AND `slot_start` >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#">
                    )
                    OR (`slot_start` >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#"> 
                    AND `slot_end` <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">
                    )
                )
                ORDER BY `user_slots`.`slot_start` ASC
            </cfquery>
            <cfdump var="#get_slot#">
            <cfif get_slot.recordCount eq 0>
                <cfquery name="insert_slots" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_slots
                    (
                    slot_start,
                    slot_end,
                    planner_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                    )
                </cfquery>
            <cfelseif get_slot.recordCount GTE 2>
                <!--- <cfdump var="#get_slot['slot_id'][1]#">
                <cfdump var="#get_slot['slot_id'][get_slot.recordCount]#"> --->
                
                <cfquery name="insert_slots" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_slots
                    (
                    slot_start,
                    slot_end,
                    planner_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#get_slot['slot_start'][1] LT start ? get_slot['slot_start'][1] : start#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#get_slot['slot_end'][get_slot.recordCount] GT end ? get_slot['slot_end'][get_slot.recordCount] : end#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                    )
                </cfquery>
        
                <cfloop query="get_slot">
                    <cfquery name="del_slot" datasource="#SESSION.BDDSOURCE#">
                        DELETE FROM `user_slots` 
                        WHERE `slot_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#slot_id#">
                    </cfquery>
                </cfloop>
                
        
            <cfelseif get_slot.recordCount eq 1>
                <cfquery name="up_slots" datasource="#SESSION.BDDSOURCE#">
                    UPDATE `user_slots` SET 
                    <cfif get_slot.slot_start GTE start>
                        `slot_start` = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start#">
                    </cfif>
                    <cfif get_slot.slot_end LTE end>
                        <cfif get_slot.slot_start GTE start>,</cfif>
                        `slot_end`= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end#">
                    </cfif>
                    WHERE `slot_id`= #get_slot.slot_id#
                </cfquery>
            </cfif>
        
            </cfif>

			<cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>

    <cffunction name="updt_pricing" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="p_id" type="any" required="yes">
        <cfargument name="lang" type="any" required="yes">
        <!--- <p>hello</p> --->

        <cftry>

            <cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
                SELECT cat_id, cat_name_#SESSION.LANG_CODE# as cat_name
                FROM lms_tpsession_category 
                ORDER BY `cat_id` ASC
            </cfquery>
        
            <cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
                SELECT method_id, method_name_#SESSION.LANG_CODE# as method_name
                FROM lms_lesson_method 
                WHERE method_id in (1,2,10,11,12)
                ORDER BY `method_id` ASC
            </cfquery>

            <cfloop query="get_method">
                <cfloop query="get_category">
                    
                    <cfif arguments['insert_#lang#_#get_method.method_id#_#get_category.cat_id#'] GTE 0>
                        
                        <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                            INSERT INTO`user_pricing`(
                                `user_id`,
                                `formation_id`,
                                `pricing_amount`,
                                `pricing_cat`,
                                `pricing_method`,
                                `pricing_currency`) 
                            VALUES
                            (
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#lang#">,
                                <cfqueryparam cfsqltype="cf_sql_float" value="#arguments['insert_#lang#_#get_method.method_id#_#get_category.cat_id#']#">,
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_category.cat_id#">,
                                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_method.method_id#">,
                                "EUR"
                            )
                        </cfquery>

                    <cfelseif arguments['update_#lang#_#get_method.method_id#_#get_category.cat_id#'] GTE 0>

                        <cfquery datasource="#SESSION.BDDSOURCE#">
                            UPDATE `user_pricing` SET
                            pricing_amount = <cfqueryparam cfsqltype="cf_sql_float" value="#arguments['update_#lang#_#get_method.method_id#_#get_category.cat_id#']#">
                            WHERE pricing_method = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_method.method_id#">
                            AND pricing_cat = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_category.cat_id#">
                            AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lang#">
                            AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                        </cfquery>
                    </cfif>

                </cfloop>
            </cfloop>


        <cfreturn 1>
        <cfcatch type="any">
            Error updt_pricing: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>

    <cffunction name="updt_payement" access="remote" returntype="any" output="false" returnFormat="JSON">
        <cfargument name="p_id" type="any" required="yes">
		<cfargument name="payment_name" type="any" required="no">
		<cfargument name="payment_address" type="any" required="no">
		<cfargument name="payment_city" type="any" required="no">
		<cfargument name="payment_postal" type="any" required="no">
		<cfargument name="payment_country" type="any" required="no">
		<cfargument name="payment_iban" type="any" required="no">
		<cfargument name="payment_siret" type="any" required="no">
		<cfargument name="payment_type" type="any" required="no">
		<cfargument name="payment_vat" type="any" required="no">
		<cfargument name="payment_id" type="any" required="no" default="0">
        
        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT payment_id, payment_name, payment_address, payment_city, payment_postal, payment_country,
                payment_iban, payment_siret, payment_type, payment_vat
                FROM `user_payment` 
                WHERE `user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            </cfquery>


            <cfif select.recordCount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO`user_payment`(
                        <cfif isDefined("payment_name")>`payment_name`, </cfif>
                        <cfif isDefined("payment_address")>`payment_address`, </cfif>
                        <cfif isDefined("payment_city")>`payment_city`, </cfif>
                        <cfif isDefined("payment_postal")>`payment_postal`, </cfif>
                        <cfif isDefined("payment_country")>`payment_country`, </cfif>
                        <cfif isDefined("payment_iban")>`payment_iban`, </cfif>
                        <cfif isDefined("payment_siret")>`payment_siret`, </cfif>
                        <cfif isDefined("payment_type")>`payment_type`, </cfif>
                        <cfif isDefined("payment_vat")>`payment_vat`, </cfif>
                        `user_id`) 
                    VALUES
                    (
                    <cfif isDefined("payment_name")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_name#">,</cfif>
                    <cfif isDefined("payment_address")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_address#">,</cfif>
                    <cfif isDefined("payment_city")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_city#">,</cfif>
                    <cfif isDefined("payment_postal")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_postal#">,</cfif>
                    <cfif isDefined("payment_country")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_country#">,</cfif>
                    <cfif isDefined("payment_iban")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_iban#">,</cfif>
                    <cfif isDefined("payment_siret")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_siret#">,</cfif>
                    <cfif isDefined("payment_type")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_type#">,</cfif>
                    <cfif isDefined("payment_vat")><cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_vat#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.payment_id>

                <cfquery datasource="#SESSION.BDDSOURCE#" result="updateResult">
                    UPDATE `user_payment` SET
                    <cfif isDefined("payment_name")> payment_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_name#">,</cfif>
                    <cfif isDefined("payment_address")> payment_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_address#">,</cfif>
                    <cfif isDefined("payment_city")> payment_city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_city#">,</cfif>
                    <cfif isDefined("payment_postal")> payment_postal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_postal#">,</cfif>
                    <cfif isDefined("payment_country")> payment_country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_country#">,</cfif>
                    <cfif isDefined("payment_iban")> payment_iban = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_iban#">,</cfif>
                    <cfif isDefined("payment_siret")> payment_siret = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_siret#">,</cfif>
                    <cfif isDefined("payment_type")> payment_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_type#">,</cfif>
                    <cfif isDefined("payment_vat")> payment_vat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#payment_vat#">,</cfif>
                    user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                    WHERE `payment_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                    AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
                </cfquery>


            </cfif>

            <cfset update_list = []>

            <cfset _list = "payment_name,payment_address,payment_city,payment_postal,payment_country,payment_iban,payment_siret,payment_type,payment_vat">

            <cfloop list="#_list#"  index="cor">
                <cfif isDefined("#cor#") AND evaluate("#cor#") neq evaluate("select.#cor#")>
                    <cfset ArrayAppend(update_list, {
                        "old" = evaluate("select.#cor#"),
                        "new" =  evaluate("#cor#")
                    })>
                </cfif>
            </cfloop>

            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
                SELECT user_id, user_firstname, user_name FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            </cfquery>

            <cfmail from="WEFIT <service@wefitgroup.com>" to="finance@wefitgroup.com" subject="New Trainer Info - #get_user.user_firstname#" type="html" server="localhost">
                Information de facturation modifié pour le trainer : <a href="https://lms.wefitgroup.com/common_trainer_invoice.cfm?p_id=#p_id#">#get_user.user_firstname# #get_user.user_name#</a>
                <br>
                <table>
                    <tr>
                        <th>
                            Old
                        </th>
                        <th>
                        </th>
                        <th>
                            New
                        </th>
                    </tr>
                    <cfloop array="#update_list#" index="temp">
                        <tr  align="center">
                            <td>
                                #temp.old#   
                            </td>
                            <td>
                                -
                            </td>
                            <td>
                                #temp.new#   
                            </td>
                        </tr>
                    </cfloop>
                </table>
            </cfmail>

        <cfreturn return_id>
        <cfcatch type="any">
            Error updt_payement: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
		
	</cffunction>


    <cffunction name="create_ops_tp" access="remote" returntype="numeric">
        <cfargument name="_p_id" type="any" required="yes">

        <cfquery name="get_ops" dataSource="#SESSION.BDDSOURCE#"> 
            SELECT t.tp_id FROM lms_tpplanner p
            INNER JOIN  lms_tp t  ON t.tp_id = p.tp_id
            WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#_p_id#">
            AND t.method_id = 12 LIMIT 1
        </cfquery>

        <cfif get_ops.recordCount eq 0>

            <cftry>

                <cfquery name="get_lang" dataSource="#SESSION.BDDSOURCE#"> 
                    SELECT formation_id FROM user_teaching WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#_p_id#"> ORDER BY formation_id LIMIT 1
                </cfquery>

                <cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="new_tp">
                    INSERT INTO lms_tp
                    (
                    user_id,
                    order_id,
                    tp_status_id,
                    tp_date_start,
                    tp_date_end,
                    tp_duration,
                    formation_id,
                    method_id,
                    
                    techno_id,
                    elearning_id,
                    elearning_duration,
                    elearning_url,
                    elearning_login,
                    elearning_password,
                    
                    tp_rank,
                    tp_vip,
                    
                    certif_id,
                    certif_url,
                    certif_login,
                    token_id,
                    
                    destination_id,
                    
                    creator_id
                    )
                    VALUES
                    (
                    null, 
                    1,
                    1,
                    "2022-01-01 00:00:00",
                    "2222-12-30 00:00:00",
                    "12000",
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lang.formation_id#">,
                    12,
                    
                    3,
                    null,
                    30,
                    null,
                    null,
                    null,
                    
                    1,
                    0,
                    
                    36,
                    null,
                    null,
                    0,
                    
                    
                    1,
                    
                    202
                    )
                </cfquery>
        
        
                <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_tpplanner
                    (
                        planner_id,
                        tp_id,
                        active
                    )
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#_p_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                        1
                    )
                </cfquery>
        <!--- 161 dianne
        69 VG
        2586 Tom
        5373 Krys
        151 Douglas --->
        
                <cfloop list="161,69,2586,5373,151" index="userl_id">
        
        
                    <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO lms_tpuser
                        (
                            user_id,
                            tp_id
                        )
                        VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#userl_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
                        )
                    </cfquery>
        
        
                </cfloop>
        
                <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_tpsession
                    (
                    tp_id,
                    sessionmaster_id,
                    session_duration,
                    session_rank,
                    session_close,
                    method_id,
                    cat_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                    1197,
                    30,
                    1,
                    0,
                    1,
                    1
                    );
                    </cfquery>
    
                <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_tpsession
                    (
                    tp_id,
                    sessionmaster_id,
                    session_duration,
                    session_rank,
                    session_close,
                    method_id,
                    cat_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                    1198,
                    30,
                    2,
                    0,
                    1,
                    1
                    );
                </cfquery>
        
        
        
                <cfcatch type="any">
                    Error create_ops_tp: <cfoutput>#cfcatch.message#</cfoutput>
                    <!--- <cfreturn 0> --->
                </cfcatch>
            </cftry>

            <cfreturn new_tp.generatedkey>

        </cfif>

        <cfreturn 0>
    </cffunction>


    <cffunction name="switch_user_paid" access="remote" method="POST" returntype="numeric">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE `user` SET user_paid_global = (IF(user_paid_global = 1, 1, -1) * -1)
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>


    <cffunction name="switch_user_paid_missed" access="remote" method="POST" returntype="numeric">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE `user` SET user_paid_missed = (IF(user_paid_missed = 1, 1, -1) * -1)
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>

    <cffunction name="switch_user_paid_tva" access="remote" method="POST" returntype="numeric">
        <cfargument name="u_id" type="numeric" required="yes">
        <cfargument name="tva_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE `user` SET user_paid_tva = <cfqueryparam cfsqltype="cf_sql_integer" value="#tva_id#">
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>


    <cffunction name="update_completed_ops" access="remote" method="POST" returntype="numeric">
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="date" type="any" required="yes">

        <cftry>
    
            <cfdump var="#lsDateTimeFormat(date, 'dd/mm/yyyy HH:nn', 'fr')#">
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE `lms_lesson2` SET completed_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#lsDateTimeFormat(date, 'dd/mm/yyyy HH:nn', 'fr')#">
            WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>



    <cffunction name="insert_item_invoice_trainer" access="public" returntype="numeric">
        <cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="selector" type="string" required="yes">

        <cfargument name="mail_sent" type="numeric" required="no">
        <cfargument name="path" type="string" required="no">
        <cfargument name="amount" type="numeric" required="no">
        <cfargument name="payed" type="numeric" required="no">
        <cfargument name="hours" type="numeric" required="no">

        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `user_invoice_info_id` FROM `user_invoice_info` 
                WHERE `user_invoice_info_user` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND `user_invoice_info_selector` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selector#">
            </cfquery>

            <cfif select.recordcount eq 0>
            
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `invoice_trainer`(
                        user_invoice_info_user, 
                        user_invoice_info_selector,
                        user_invoice_info_mail_sent, 
                        user_invoice_info_path,
                        user_invoice_info_amount,
                        user_invoice_info_duration
                        ) 
                    VALUES
                    (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#selector#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#mail_sent#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#selector#">,
                        <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#amount#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#hours#">
                    )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.user_invoice_info_id>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `invoice_trainer` SET
                    <cfif isDefined("mail_sent")> user_invoice_info_mail_sent = <cfqueryparam cfsqltype="cf_sql_integer" value="#mail_sent#">,</cfif>
                    <cfif isDefined("amount")> user_invoice_info_amount = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#amount#">,</cfif>
                    <cfif isDefined("payed")> user_invoice_info_payed = <cfqueryparam cfsqltype="CF_SQL_FLOAT" value="#payed#">,</cfif>
                    <cfif isDefined("hours")> user_invoice_info_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#hours#">,</cfif>
                    user_invoice_info_modified = NOW()
                    WHERE `user_invoice_info_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

            </cfif>

        <cfreturn return_id>
        <cfcatch type="any">
            insert_item_invoice_trainer: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>







    <cffunction name="ins_link" access="remote" method="POST" returntype="numeric">
        <cfargument name="link_name" type="any" required="yes">
        <cfargument name="link_url" type="any" required="yes">

        <cftry>

        <cfquery name="ins_link" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO user_link(
                link_name,
                link_url

            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#link_name#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#link_url#">
            )
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>



</cfcomponent>