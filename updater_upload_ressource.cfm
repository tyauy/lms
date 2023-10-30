<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
	
	<cfif isdefined("core_material")>
	
		<cfif isdefined("act") AND act neq "delete" AND isdefined("n_doc") AND isdefined("f_doc") AND isdefined("sm_id") AND isdefined("sessionmaster_file") AND isdefined("sessionmaster_ressource")>
					
			<cfif isdefined("sessionmaster_file") AND sessionmaster_file neq "">
						
				<cffile action = "upload" 
				filefield = "sessionmaster_file" 
				destination = "#SESSION.BO_ROOT#/assets/materials/" 
				nameConflict = "Overwrite"
				mode="777">					
								
				<cfif cffile.FileWasSaved>	

					<cfif cffile.clientFileExt neq f_doc>
					
						<cffile action="DELETE" file="#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#">
						<cfoutput>
						Unsupported File Format...  Please <a href="db_syllabus_edit.cfm?sm_id=#sm_id#">go back</a> and try again !
						</cfoutput>
						<cfabort>		
					
					<cfelseif (CFFILE.FileSize GT (100000 * 1024))>
					
						<cffile action="DELETE" file="#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#">
						<cfoutput>
						File too big... Please <a href="db_syllabus_edit.cfm?sm_id=#sm_id#">go back</a> and try again !
						</cfoutput>
						<cfabort>	

					<cfelse>
						
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#n_doc#.#f_doc#" 
						attributes = "normal"
						mode="777">						
						
						<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
						UPDATE lms_tpsessionmaster2
						SET
						<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
						sessionmaster_audio_bool = 1,
						<cfelse>
						sessionmaster_audio_bool = 0,
						</cfif>	
						
						<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1">
						sessionmaster_video_bool = 1,
						<cfelse>
						sessionmaster_video_bool = 0,
						</cfif>	
						
						<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
						sessionmaster_support_bool = 1
						<cfelse>
						sessionmaster_support_bool = 0
						</cfif>	
						
						WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
						</cfquery>
					
					</cfif>
					
				</cfif>
				
			</cfif>
			
			<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
			
		<cfelseif isdefined("act") AND act eq "delete" AND isdefined("n_doc") AND isdefined("f_doc") AND isdefined("sm_id") AND isdefined("sessionmaster_ressource")>
		
			<cffile action="delete" file="#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#n_doc#.#f_doc#">
			
			<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_tpsessionmaster2
			SET
			<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
			sessionmaster_audio_bool = 1,
			<cfelse>
			sessionmaster_audio_bool = 0,
			</cfif>	
			
			<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1">
			sessionmaster_video_bool = 1,
			<cfelse>
			sessionmaster_video_bool = 0,
			</cfif>	
			
			<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
			sessionmaster_support_bool = 1
			<cfelse>
			sessionmaster_support_bool = 0
			</cfif>	
			
			WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
			</cfquery>
	
			<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
		
		</cfif>
	
	<cfelseif isdefined("thumb_material") OR isdefined("mini_thumb_material") OR isdefined("thumb_material_el") OR isdefined("mini_thumb_material_el")>
	
		<cfif isdefined("act") AND act eq "upload">
		
			<cfif isdefined("sessionmaster_thumb_file") AND sessionmaster_thumb_file neq "">
				
				<cfif isdefined("thumb_material")>

					<cffile action = "upload" 
					filefield = "sessionmaster_thumb_file" 
					destination = "#SESSION.BO_ROOT#/assets/img_material/" 
					nameConflict = "Overwrite"
					mode="777">		

					<cfif cffile.FileWasSaved>	
					
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/img_material/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/img_material/#sm_id#.#lcase(cffile.clientFileExt)#" 
						attributes = "normal"
						mode="777">
						
						<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
					
					</cfif>
					
				<cfelseif isdefined("mini_thumb_material")>
				
					<cffile action = "upload" 
					filefield = "sessionmaster_thumb_file" 
					destination = "#SESSION.BO_ROOT#/assets/img_material/thumbs/" 
					nameConflict = "Overwrite"
					mode="777">		

					<cfif cffile.FileWasSaved>	
					
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/img_material/thumbs/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/img_material/thumbs/#sm_id#.#lcase(cffile.clientFileExt)#" 
						attributes = "normal"
						mode="777">
						
						<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
					
					</cfif>

				<cfelseif isdefined("thumb_material_el")>
				
					<cffile action = "upload" 
					filefield = "sessionmaster_thumb_file" 
					destination = "#SESSION.BO_ROOT#/assets/img_material_el/" 
					nameConflict = "Overwrite"
					mode="777">		

					<cfif cffile.FileWasSaved>	
					
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/img_material_el/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/img_material_el/#sm_id#.#lcase(cffile.clientFileExt)#" 
						attributes = "normal"
						mode="777">
						
						<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
					
					</cfif>

				<cfelseif isdefined("mini_thumb_material_el")>
				
					<cffile action = "upload" 
					filefield = "sessionmaster_thumb_file" 
					destination = "#SESSION.BO_ROOT#/assets/img_material_el/thumbs/" 
					nameConflict = "Overwrite"
					mode="777">		

					<cfif cffile.FileWasSaved>	
					
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sm_id#.#lcase(cffile.clientFileExt)#" 
						attributes = "normal"
						mode="777">
						
						<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
					
					</cfif>
				
				
				</cfif>
					
			</cfif>
		
		<cfelseif isdefined("act") AND (act eq "thumb_delete" OR act eq "thumb_mini_delete") AND isdefined("sm_id") AND isdefined("sessionmaster_code")>
		
			<cfif act eq "thumb_delete">
				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sm_id#.jpg")>
					<cffile action="delete" file="#SESSION.BO_ROOT#/assets/img_material/#sm_id#.jpg">
				</cfif>			
			<cfelseif act eq "thumb_mini_delete">
				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sm_id#.jpg")>
					<cffile action="delete" file="#SESSION.BO_ROOT#/assets/img_material/thumbs/#sm_id#.jpg">
				</cfif>		
			</cfif>
			
			<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
		
		</cfif>
		
	<cfelseif isdefined("misc_material")>
	
		<cfif isdefined("act") AND act neq "delete">
		
			<cfif isdefined("sessionmaster_file") AND sessionmaster_file neq "">
							
					<cfquery name="get_session_solo" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO lms_material
					(
					material_name,
					material_description,
					material_url,
					sessionmaster_id
					)
					VALUES
					(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#material_name#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#material_description#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_ressource#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
					<!---<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,--->
					)
					</cfquery>
						
					<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
					SELECT max(material_id) as id FROM lms_material
					</cfquery>
					
					<cffile action = "upload" 
					filefield = "sessionmaster_file" 
					destination = "#SESSION.BO_ROOT#/assets/materials/" 
					nameConflict = "Overwrite"
					mode="777">					
									
					<cfif cffile.FileWasSaved>	
					
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#get_max.id#.#cffile.clientFileExt#" 
						attributes = "normal"
						mode="777">
						
						<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
					
					</cfif>
					
			</cfif>
		
		<cfelseif isdefined("act") AND act eq "delete" AND isdefined("sm_id") AND isdefined("material_id") AND isdefined("sessionmaster_ressource")>
		
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.pdf")>
				<cffile action="delete" file="#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.pdf">
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.jpg")>
				<cffile action="delete" file="#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.jpg">
			</cfif>
			
			<cfquery name="get_session_solo" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM lms_material WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#material_id#">
			</cfquery>
					
			<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#">
		
		</cfif>
		
	<cfelseif isdefined("new_file")>
	
		<cfif isdefined("act") AND act eq "upload">
		
			<cfif isdefined("material_file") AND material_file neq "">
							
				<cfquery name="ins_material" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_material
				(
				material_name,
				material_url
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="">
				)
				</cfquery>
					
				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				SELECT max(material_id) as id FROM lms_material
				</cfquery>
				
				<cffile action = "upload" 
				filefield = "material_file" 
				destination = "#SESSION.BO_ROOT#/assets/materials/" 
				nameConflict = "Overwrite"
				mode="777">	
					
				<cfif cffile.FileWasSaved>	
				
					<cfif cffile.clientFileExt neq "jpg" AND cffile.clientFileExt neq "mp3" AND cffile.clientFileExt neq "mp4" AND cffile.clientFileExt neq "pdf" AND cffile.clientFileExt neq "png">
					
						<cffile action="DELETE" file="#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#">
						<cfoutput>
						Unsupported File Format...  Please go back...
						</cfoutput>
						<cfabort>		
					
					<cfelseif (CFFILE.FileSize GT (10000 * 1024))>
					
						<cffile action="DELETE" file="#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#">
						<cfoutput>
						File tooooo big...  Please go back...
						</cfoutput>
						<cfabort>	

					<cfelse>
						
						<cffile action="rename" 
						source = "#SESSION.BO_ROOT#/assets/materials/#cffile.ClientFile#" 
						destination = "#SESSION.BO_ROOT#/assets/materials/material_#get_max.id#.#cffile.clientFileExt#" 
						attributes = "normal"
						mode="777">
						
						<cfquery name="del_material" datasource="#SESSION.BDDSOURCE#">
						UPDATE lms_material SET 
						material_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="material_#get_max.id#">,
						material_url = <cfqueryparam cfsqltype="cf_sql_varchar" value="material_#get_max.id#">,
						material_format = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cffile.clientFileExt#">
						WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
						</cfquery>
						
						<cfif isdefined("qu_id")>
							<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&mat_id=#get_max.id#">
						<cfelse>
							<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&mat_id=#get_max.id#">
						</cfif>
					
					</cfif>
					
				<cfelse>
					
					<cfquery name="del_material" datasource="#SESSION.BDDSOURCE#">
					DELETE FROM lms_material WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
					</cfquery>
					
				</cfif>	
				
			</cfif>
		</cfif>
			
	</cfif>
	
	
	
	
</cfif>