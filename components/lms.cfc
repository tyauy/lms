<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">
	<cffunction name="get_session" access="public" returntype="any">
		<cfargument name="tp_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">

		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		SELECT 
		t.tp_id, t.tp_name, 
		s.session_id, s.session_duration, s.session_rank, s.session_close
		sm.sessionmaster_name, sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_ressource, sm.sessionmaster_description,
		lm.method_name_#SESSION.LANG_CODE# as method_name,
		u2.user_alias as trainer_alias, u2.user_id as planner_id, u2.user_firstname,
		l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, l.method_id, l.status_id,
		ls.status_css, ls.status_bootstrap, ls.status_name_#SESSION.LANG_CODE# as status_name,
		ln.note_id,
		c.cat_name_#SESSION.LANG_CODE# as cat_name
		FROM lms_tp t
		INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		INNER JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		LEFT JOIN lms_lesson_method lm ON lm.method_id = l.method_id
		LEFT JOIN lms_lesson_note ln ON ln.lesson_id = l.lesson_id
		LEFT JOIN user u ON u.user_id = l.user_id
		LEFT JOIN user u2 ON u2.user_id = l.planner_id
		WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> 

		<cfif SESSION.USER_PROFILE eq "LEARNER">
			AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
		<cfelseif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			AND u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfif>

		ORDER BY s.session_rank ASC, s.session_id, l.lesson_start
		</cfquery>
		
		<cfreturn get_session>
		
    </cffunction>
	
	<cffunction name="get_thumb" access="public" returntype="any">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="yes">
		<cfargument name="responsive" type="any" required="no">
		<cfargument name="display_title" type="any" required="no">
		<cfargument name="style" type="any" required="no">
		<cfargument name="css" type="any" required="no">
		<cfargument name="align" type="any" required="no">

		<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
		SELECT user_gender, user_firstname FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
				
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
				<img src="./assets/user/#user_id#/photo.jpg" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>>
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
				<img src="./assets/user/#user_id#/photo.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>>
			<cfelse>
				
				<cfif get_gender.user_gender eq "M." OR get_gender.user_gender eq "Mr." OR get_gender.user_gender eq "M.">
					<img src="./assets/img/unknown_male.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>>
				<cfelse>
					<img src="./assets/img/unknown_female.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>>
				</cfif>
			</cfif>
        </cfoutput>
		
    </cffunction>

	<cffunction name="get_thumb_border" access="public" returntype="any">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="yes">
		<cfargument name="responsive" type="any" required="no">
		<cfargument name="display_title" type="any" required="no">
		<cfargument name="style" type="any" required="no">
		<cfargument name="css" type="any" required="no">
		<cfargument name="align" type="any" required="no">

		<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
		SELECT user_gender, user_firstname FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>
				
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
				<img src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/photo.jpg" width="#size#" title="" style="#style#" <cfif isdefined("align")>align="#align#"</cfif>>
				<!--- <img src="./assets/user/#user_id#/photo.jpg" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>> --->
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
				<!--- <img src="./assets/user/#user_id#/photo.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>> --->
			<cfelse>
				
				<cfif get_gender.user_gender eq "M." OR get_gender.user_gender eq "Mr." OR get_gender.user_gender eq "M.">
					<!--- <img src="./assets/img/unknown_male.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>> --->
				<cfelse>
					<!--- <img src="./assets/img/unknown_female.png" class="<cfif isdefined("css")>#css#</cfif> rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#" <cfif isdefined("display_title")>title="#display_title#"<cfelse>title="#get_gender.user_firstname#"</cfif> <cfif isdefined("style")>style="#style#"</cfif>> --->
				</cfif>
			</cfif>
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_thumb_square" access="public" returntype="any">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="yes">
		<cfargument name="responsive" type="any" required="no">

		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
				<img src="./assets/user/#user_id#/photo.jpg" class="<cfif isdefined("responsive")>img-responsive</cfif>" width="#size#">
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
				<img src="./assets/user/#user_id#/photo.png" class="<cfif isdefined("responsive")>img-responsive</cfif>" width="#size#">
			<cfelse>
				<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
				SELECT user_gender FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				</cfquery>
				<cfif get_gender.user_gender eq "M.">
					<img src="./assets/img/unknown_male.png" class="<cfif isdefined("responsive")>img-responsive</cfif>" width="#size#">
				<cfelse>
					<img src="./assets/img/unknown_female.png" class="<cfif isdefined("responsive")>img-responsive</cfif>" width="#size#">
				</cfif>
			</cfif>
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_avatar" access="public" returntype="any">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="no">
		
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.jpg")>
				<img class="avatar border-gray" src="../assets/user/#user_id#/photo.jpg" <cfif isdefined("size")>width="#size#"</cfif>>
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo.png")>
				<img class="avatar border-gray" src="../assets/#user_id#/photo.png" <cfif isdefined("size")>width="#size#"</cfif>>
			<cfelse>
				<cfquery name="get_gender" datasource="#SESSION.BDDSOURCE#">
				SELECT user_gender FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				</cfquery>
				<cfif get_gender.user_gender eq "M.">
					<img class="avatar border-gray" src="../assets/img/unknown_male.png" <cfif isdefined("size")>width="#size#"</cfif>>
				<cfelse>
					<img class="avatar border-gray" src="../assets/img/unknown_female.png" <cfif isdefined("size")>width="#size#"</cfif>>
				</cfif>
			</cfif>
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_thumb_module" access="public" returntype="any">
		<cfargument name="module_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="yes">
		<cfargument name="responsive" type="any" required="no">
		
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_module/#module_id#.jpg")>
				<img src="./assets/img_module/#module_id#.jpg" class="rounded-circle <cfif isdefined("responsive")>img-responsive</cfif>" width="#size#">
			</cfif>
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_thumb_session" access="public" returntype="any">
		<cfargument name="sessionmaster_id" type="any" required="yes">
		<cfargument name="sessionmaster_code" type="any" required="yes">
		<cfargument name="size" type="numeric" required="no">
		<cfargument name="align" type="any" required="no">
		
		<!---- THUMBS : Width - 150 // FULL : Width - 800 ---->
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
			
				<img src="../assets/img_material/#sessionmaster_code#.jpg" <cfif isdefined("size")>width="#size#"</cfif> <cfif isdefined("align")>align="left"</cfif> class="img-responsive">
				
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
			
				<img src="../assets/img_material/#sessionmaster_id#.jpg" <cfif isdefined("size")>width="#size#"</cfif> <cfif isdefined("align")>align="left"</cfif> class="img-responsive">
			
			<cfelse>
				<img src="../assets/img/wefit_lesson.jpg" <cfif isdefined("size")>width="#size#"<cfelse> class="img-responsive"</cfif>>
			</cfif>
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_thumb_mini_session" access="public" returntype="any">
		<cfargument name="sessionmaster_id" type="any" required="yes">
		<cfargument name="sessionmaster_code" type="any" required="yes">
		<cfargument name="size" type="numeric" required="no">
		<cfargument name="align" type="any" required="no">
		
		<!---- THUMBS : Width - 150 // FULL : Width - 800 ---->
		<cfoutput>
		
			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
				<img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" <cfif isdefined("size")>width="#size#"</cfif> <cfif isdefined("align")>align="left"</cfif> class="img-responsive">
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
				<img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" <cfif isdefined("size")>width="#size#"</cfif> <cfif isdefined("align")>align="left"</cfif> class="img-responsive">
			<cfelse>
				<img src="../assets/img/wefit_lesson.jpg" <cfif isdefined("size")>width="#size#"</cfif> <cfif isdefined("align")>align="left"</cfif> class="img-responsive">
			</cfif>
		
        </cfoutput>
		
    </cffunction>
	
	<cffunction name="get_trainer_signature" access="public" returntype="any">
		<cfargument name="p_id" type="numeric" required="yes">
		<cfargument name="size" type="numeric" required="no">

		<cfoutput>
		<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/signature.png")>		
			<img src="../assets/user/#p_id#/signature.png" align="center" <cfif isdefined("size")>width="#size#"</cfif>>	
		</cfif>
		</cfoutput>
		
	</cffunction>
	
	<cffunction name="get_learner_signature" access="public" returntype="any">
		<cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="no">
		<cfargument name="size" type="numeric" required="no">

		<cfquery name="select_attendance" datasource="#SESSION.BDDSOURCE#">
			SELECT la.signature_base64, l.lesson_ghost
			FROM lms_lesson2_attendance la
			LEFT JOIN lms_lesson2 l ON la.lesson_id = l.lesson_id
			WHERE la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			AND la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>


		<cfif select_attendance.lesson_ghost eq 1>

			<cfquery name="select_attendance_signed" datasource="#SESSION.BDDSOURCE#">
				SELECT la.signature_base64, l.lesson_id
				FROM lms_lesson2_attendance la
				LEFT JOIN lms_lesson2 l ON la.lesson_id = l.lesson_id
				WHERE la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
				AND la.lesson_signed = 1
				AND (l.lesson_ghost IS NULL OR  l.lesson_ghost != 1)
			</cfquery>

			<cfif select_attendance_signed.recordCount GT 0>
				<cfset rdm_sign = QueryGetRow(select_attendance_signed, RandRange(1, select_attendance_signed.recordCount))>

				<cfset sign64 = rdm_sign.signature_base64 >
				<cfset l_id = rdm_sign.lesson_id >	
			<cfelse>
				<cfset sign64 = "" >
			</cfif>
		
		<cfelse>
			<cfset sign64 = select_attendance.signature_base64 >
		</cfif>


		<cfoutput>
		<cfif fileexists("#SESSION.BO_ROOT#/assets/signature/#l_id#.png")>		
			<img src="../assets/signature/#l_id#.png" align="center" <cfif isdefined("size")>width="#size#"</cfif>>	
		<cfelseif sign64 neq "">
			<!--- <img src="#select_attendance.signature_base64#" align="center" <cfif isdefined("size")>width="#size#"</cfif>>	 --->

			<cfif isdefined("size")>
				<cfimage 
				required 
				action = "writeToBrowser" 
				width = #size#
				source = #sign64#
				format = "png" 
				isBase64= "yes">
			<cfelse>
				<cfimage 
				required 
				action = "writeToBrowser" 
				source = #sign64#
				format = "png" 
				isBase64= "yes">
			</cfif>

		<cfelse>
			-
		</cfif>
		</cfoutput>
		
	</cffunction>
		

	<cffunction name="get_formatn" access="public" returntype="any" output="false">
		<cfargument name="nb" type="any" required="yes">

		<cfif nb neq "">
		<cfif listgetat(nb,2,".") eq "0">
			<cfset formatn = round(nb)>
		<cfelse>
			<cfset formatn = nb>
		</cfif>
		<cfelse>
			<cfset formatn = "-">
		</cfif>
		
		<cfreturn formatn>
		
    </cffunction>
	
	<cffunction name="get_formath" access="public" returntype="any" output="false">
		<cfargument name="nb" type="numeric" required="yes">

		<cfif (nb/60) eq round(nb/60)>
			<cfset formath = (nb/60)>
		<cfelse>
			<cfset formath = numberformat((nb/60),"____.__")>
		</cfif>
		
		<cfreturn trim(formath)>
		
    </cffunction>

	
	<cffunction name="get_icon_file" access="public" returntype="any" output="false">
		<cfargument name="material_url" type="any" required="yes">
		
		<cfset temp = mid(material_url,find(".",material_url)+1,3)>
		<cfif temp eq "ppt">
			<cfset icon = '<a target="_blank" href="./assets/materials/#material_url#"><h3><i class="far fa-file-powerpoint"></i></h3></a>'>
		<cfelseif temp eq "pdf">
			<cfset icon = '<a target="_blank" href="./assets/materials/#material_url#"><h3><i class="far fa-file-pdf"></i></h3></a>'>
		<cfelseif temp eq "mp3">
			<cfset icon = '<a target="_blank" href="./assets/materials/#material_url#"><h3><i class="far fa-file-audio"></i></h3></a>'>
		<cfelse>
			<cfset icon = "">
		</cfif>		
		
		<cfreturn icon>
		
	</cffunction>
	
	<cffunction name="get_ressource_exists" access="public" returntype="any" output="false">
		<cfargument name="sessionmaster_ressource" type="any" required="yes">
		<cfargument name="ressource_type" type="any" required="yes">
		<cfset ressource_exist = ""> 
		
		<cfif ressource_type eq "AUDIO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
				<cfset ressource_exist = "1">
			</cfif>
		</cfloop>
		</cfif>
		<cfif ressource_type eq "VIDEO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
				<cfset ressource_exist = "1">
			</cfif>
		</cfloop>
		</cfif>
		<cfif ressource_type eq "WS">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.ppt")>
				<cfset ressource_exist = "1">
			</cfif>
		</cfif>
		<cfif ressource_type eq "WSK">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pptx") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.ppt")>
				<cfset ressource_exist = "1">
			</cfif>
		</cfif>
		<cfif ressource_type eq "K">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pptx") OR fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.ppt")>
				<cfset ressource_exist = "1">
			</cfif>
		</cfif>
		
		<cfreturn ressource_exist>
		
	</cffunction>
	
	<cffunction name="get_ressource" access="public" returntype="any" output="false">
		<cfargument name="sessionmaster_ressource" type="any" required="yes">
		<cfargument name="ressource_type" type="any" required="yes">
		<cfargument name="ressource_short" type="any" required="no">
		
		<!---
		ressource_type
		WS = worksheet
		WSK = worksheet + key
		AUDIO = AUDIO
		VIDEO = VIDEO		
		--->
		<cfset buttons = "">
		
		<cfif ressource_type eq "AUDIO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
				<cfif not isdefined("ressource_short")>
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-volume-up'></i> AUDIO #cor#</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "1">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-volume-up'></i> AUDIO #cor#</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "2">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-volume-up'></i> #cor#</a>">
				</cfif>
			</cfif>
		</cfloop>
		</cfif>
		
		<cfif ressource_type eq "VIDEO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
				<cfif not isdefined("ressource_short")>
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-video'></i> VIDEO #cor#</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "1">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-video'></i> VIDEO #cor#</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "2">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-video'></i> #cor#</a>">
				</cfif>
			</cfif>
		</cfloop>
		</cfif>
		
		<cfif ressource_type eq "WS">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
				<cfif not isdefined("ressource_short")>
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WS.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "1">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WS.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "2">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WS.pdf' class='btn btn-sm btn-outline-info' target='_blank' role='button' data-toggle='tooltip' data-placement='top' title='Support de cours'><i class='fas fa-file-pdf'></i> </a>">
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ressource_type eq "WSK">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
				<cfif not isdefined("ressource_short")>
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WSK.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT+KEYS</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "1">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WSK.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT+KEYS</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "2">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_WSK.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> </a>">
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ressource_type eq "K">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
				<cfif not isdefined("ressource_short")>
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_K.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> KEYS</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "1">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_K.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> KEYS</a>">
				<cfelseif isdefined("ressource_short") AND ressource_short eq "2">
					<cfset buttons = buttons&"<a href='./assets/materials/#sessionmaster_ressource#_K.pdf' class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-file-pdf'></i> </a>">
				</cfif>
			</cfif>
		</cfif>
		
		<cfreturn buttons>
		
	
	</cffunction>

		
	<cffunction name="get_ressource_exist" access="public" returntype="any" output="false">
		<cfargument name="sessionmaster_ressource" type="any" required="yes">
		<cfargument name="ressource_type" type="any" required="yes">
		
		<!---
		ressource_type
		WS = worksheet
		WSK = worksheet + key
		AUDIO = AUDIO
		VIDEO = VIDEO		
		--->
		<cfset buttons = "">
		
		<cfif ressource_type eq "AUDIO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
				<cfset audio_display = "1">
			</cfif>
		</cfloop>
		<cfif isdefined("audio_display")>
			<cfset buttons = buttons&"<button class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-volume-up'></i> AUDIO</button>">
		</cfif>
		</cfif>
		
		<cfif ressource_type eq "VIDEO">
		<cfloop from="1" to="3" index="cor">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
				<cfset video_display = "1">
			</cfif>
		</cfloop>
		<cfif isdefined("video_display")>
			<cfset buttons = buttons&"<button class='btn btn-sm btn-outline-info' target='_blank'><i class='fas fa-video'></i> VIDEO</button>">
		</cfif>
		</cfif>
		
		<cfif ressource_type eq "WS">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
				<cfset ws_display = "1">
			</cfif>
			<cfif isdefined("ws_display")>
				<cfset buttons = buttons&"<button class='btn btn-sm btn-outline-danger' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT</button>">
			</cfif>
		</cfif>
		
		<cfif ressource_type eq "WSK">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
				<cfset wsk_display = "1">
			</cfif>
			<cfif isdefined("wsk_display")>
				<cfset buttons = buttons&"<button class='btn btn-sm btn-outline-danger' target='_blank'><i class='fas fa-file-pdf'></i> SUPPORT+KEYS</button>">
			</cfif>
		</cfif>
		
		<cfif ressource_type eq "K">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
				<cfset w_display = "1">
			</cfif>
			<cfif isdefined("w_display")>
				<cfset buttons = buttons&"<button class='btn btn-sm btn-outline-danger' target='_blank'><i class='fas fa-file-pdf'></i> KEYS</button>">
			</cfif>
		</cfif>
		
		<cfreturn buttons>
		
	
	</cffunction>
	
	
	
	
	<cffunction name="get_status_color" access="public" returntype="any" output="false">
		<cfargument name="status_name" type="any" required="yes">
		
		<cfif status_name eq "scheduled">
			<cfset class="c_white label-success">
		<cfelseif status_name eq "completed">
			<cfset class="c_white label-default">
		<cfelseif status_name eq "in progress">
			<cfset class="c_white label-warning">
		<cfelseif status_name eq "missed">
			<cfset class="c_white label-danger">
		<cfelseif status_name eq "signed">
			<cfset class="c_white label-default">
		</cfif>
		

		<cfreturn class>
		
	
	</cffunction>
	
	
	
	
	<cffunction name="get_format_hms" access="public" returntype="any" output="false">
		<cfargument name="toformat" type="any" required="yes">
		<cfargument name="unit" type="any" required="no">
		
		<cfif isdefined("unit") AND unit eq "min">
			<cfif toformat neq "0" AND toformat neq "">
				<cfset full_h = toformat/60>
				
				<cfif full_h gte "1"> 
					<cfset h = fix(toformat/60)>
					<cfif fix(toformat/60) eq toformat/60>
						<cfif SESSION.LANG_CODE eq "de">
							<cfset toreturn = "#h# Std">
						<cfelse>
							<cfset toreturn = "#h#h">
						</cfif>
					<cfelse>
						<cfset min_remain = (full_h-h)*60>
						<cfif SESSION.LANG_CODE eq "de">
							<cfset toreturn = "#h# Std #min_remain#">
						<cfelse>
							<cfset toreturn = "#h#h#min_remain#">							
						</cfif>						
					</cfif>					
				<cfelse>
					<cfif SESSION.LANG_CODE eq "de">
						<cfset toreturn = "#toformat# Min">
					<cfelse>
						<cfset toreturn = "#toformat#min">		
					</cfif>
				</cfif>
								
				<cfreturn toreturn>
			</cfif>
		<cfelseif isdefined("unit") AND unit eq "h">
			<cfif toformat neq "0" AND toformat neq "">
				<cfset full_h = toformat/60>
				
				<cfif full_h gte "1"> 
					<cfset h = fix(toformat/60)>
					<cfif fix(toformat/60) eq toformat/60>
						<cfif SESSION.LANG_CODE eq "de">
							<cfset toreturn = "#h# Std">
						<cfelse>
							<cfset toreturn = "#h#h">
						</cfif>
					<cfelse>
						<cfset min_remain = (full_h-h)*60>
						<cfif SESSION.LANG_CODE eq "de">
							<cfset toreturn = "#h# Std #min_remain#">
						<cfelse>
							<cfset toreturn = "#h#h#min_remain#">
						</cfif>						
					</cfif>
					
				<cfelse>
					<cfif SESSION.LANG_CODE eq "de">
						<cfset toreturn = "#toformat# Min">
					<cfelse>
						<cfset toreturn = "#toformat#min">
					</cfif>
					
				</cfif>
								
				<cfreturn toreturn>
			</cfif>
		<cfelse>
			<cfif toformat neq "0" AND toformat neq "">
				<cfset full_h = toformat/3600>
				
				<cfif full_h gte "1"> 
					<cfset h = fix(toformat/3600)>
					<cfset min_remain = (full_h-h)*3600>

					<cfif SESSION.LANG_CODE eq "de">
						<cfset toreturn = "#h# Std #fix(min_remain/60)# Min #min_remain mod 60# Sek">
					<cfelse>
						<cfset toreturn = "#h#H #fix(min_remain/60)#m #min_remain mod 60#s">	
					</cfif>					
				<cfelse>
					<cfif SESSION.LANG_CODE eq "de">
						<cfset toreturn = "#fix(toformat/60)# Min #toformat mod 60# Sek">
					<cfelse>
						<cfset toreturn = "#fix(toformat/60)# min #toformat mod 60# sec">
					</cfif>					
				</cfif>
								
				<cfreturn toreturn>
			</cfif>
		</cfif>
		
	
	</cffunction>
	
	
	<cffunction name="updt_step" access="public" returntype="any" output="false">
		<cfargument name="s_id" type="numeric" required="yes">
	
			<cfset new_steps = "">
			<cfloop list="#SESSION.STEPS#" index="cor">

			<cfif cor neq s_id>
				<cfset new_steps = listappend(new_steps,cor)>
			</cfif>

			</cfloop>
					
			<!--- IF LAST STEP COMPLETED - SEND EMAIL --->
			<!--- <cfif listlen(SESSION.STEPS) neq "0" AND listlen(new_steps) eq "0">
			<cfset subject = "[LMS] Tests complétés - TP à lancer - #SESSION.USER_NAME#">
			<cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
			<cfinclude template="../email/email_stepout.cfm">
			</cfmail>
			</cfif> --->
					
			<cfset SESSION.STEPS = new_steps>
				
			<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
			UPDATE user 
			SET user_steps = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.STEPS#">
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			</cfquery>
	
	</cffunction>
	
	
	
	
	<cffunction name="get_tp_icon" access="public" returntype="any" output="false">
	
		<cfargument name="tp_id" type="any" required="yes">
		<cfargument name="tp_rank" type="any" required="yes">
		<cfargument name="formation_code" type="any" required="yes">
		<cfargument name="method_id" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="tab" type="any" required="no">
		<cfargument name="short" type="any" required="no">
		<cfargument name="order_id" type="any" required="no" default="0">
		<cfargument name="elearning_name" type="any" required="no">
		<cfargument name="elearning_duration" type="any" required="no">
		<cfargument name="certif_name" type="any" required="no">
		<cfargument name="certif_alias" type="any" required="no">
		<cfargument name="collapse" type="any" required="no">
		<cfargument name="lg_translate" type="any" required="no">
		<cfargument name="tp_name" type="any" required="no" default="">
		
		<cfif not isdefined("lg_translate")>
			<cfset lg_translate = SESSION.LANG_CODE>
		</cfif>

		<cfif tp_name eq "">

			<cfif get_formath(evaluate('tp_duration')) eq "0">
				<cfset tp_duration = "">
			<cfelse>
				<cfset tp_duration = "#get_formath(evaluate('tp_duration'))#h">
			</cfif>
			
			<cfif method_id eq "3" AND isdefined("elearning_duration") AND elearning_duration neq "">
				<cfset tp_duration = "">
			</cfif>
			
			<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
				SELECT method_name_#lg_translate# as method_name, method_alias_#lg_translate# as method_name_short
				FROM lms_lesson_method
				WHERE method_id = #method_id#
			</cfquery>

			<cfset method_name = get_method.method_name_short>
			<cfset method_name_short = get_method.method_name_short>

			<cfif method_id eq "3" AND isdefined("elearning_name") AND elearning_name neq "">
				<cfset method_name = method_name&" #elearning_name#"><cfset method_name_short = method_name_short&" #elearning_name#">
			</cfif>
			
			<cfif method_id eq "3" AND isdefined("elearning_duration") AND elearning_duration neq "">
				<cfif elearning_duration lt 30>
				<cfset method_name = method_name&" #elearning_duration# j"><cfset method_name_short = method_name_short&" #elearning_duration# j">
				<cfelse>
				<cfset method_name = method_name&" #elearning_duration/30# M"><cfset method_name_short = method_name_short&" #elearning_duration/30# M">
				</cfif>
			</cfif>
			
			<cfif method_id eq "7" AND isdefined("certif_name") AND certif_name neq "">
				<cfset method_name = method_name&" #certif_name#"><cfset method_name_short = method_name_short&" #certif_name#">
				<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span> <span style='line-height:24px'>#method_name_short#</span>">
			<cfelse>
			
			
			<cfset method_name = method_name&"&nbsp;#tp_duration#"><cfset method_name_short = method_name_short&"&nbsp;#tp_duration#">

			<cfif order_id eq 3>
				<cfset method_name = method_name&"&nbsp;-&nbsp;Extra"><cfset method_name_short = method_name_short&"&nbsp;-&nbsp;Extra">
			</cfif>

			<cfif isdefined("collapse")>
			
				<cfif not isdefined("short")>
					<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span><br><span style='line-height:24px'>#method_name#</span>">
				<cfelse>
					<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span><br><span style='line-height:24px'>#method_name_short#</span>">
				</cfif>
				
			<cfelse>
			
				<cfif not isdefined("short")>
					<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span> <span style='line-height:24px'>#method_name#</span>">
				<cfelse>
					<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span> <span style='line-height:24px'>#method_name_short#</span>">
				</cfif>
				
			</cfif>
			
			</cfif>
			
		<cfelse>
			
			<cfset format_tp = "<span class='lang-sm' lang='#lcase(formation_code)#'></span> <span style='line-height:24px'>#tp_name#</span>">

		</cfif>
		
		
		<!---<cfif isdefined("tab")>
			<cfset format_tp = format_tp & "<h4 class='m-0' align='center'><span class='badge'>TP #tp_rank#</span></h4> <img src='./assets/css/flags/blank.gif' class='flag_xs flag-#lcase(formation_code)#'> ">
		<cfelse>
			<cfset format_tp = format_tp & "<strong>TP #tp_rank#</strong> <img src='./assets/css/flags/blank.gif' class='flag_xs flag-#lcase(formation_code)#'> ">
		</cfif>
	
		<cfset format_tp = format_tp&" <img src='./assets/img/picto_methode_#method_id#.png' style='margin-right:1px' width='20'><strong>#get_formath(evaluate("tp_duration"))#h</strong>">
		--->
		<!---<cfloop from="1" to="6" index="cor">
		
		<cfif evaluate("tp_duration_#cor#") neq "">
		<cfset format_tp = format_tp&" <img src='./assets/img/picto_methode_#cor#.png' style='margin-right:1px' width='20'><strong>#get_formath(evaluate("tp_duration_#cor#"))#h</strong>&nbsp;">
		</cfif>
		
		</cfloop>--->
	
	
		<cfreturn format_tp>
	
	</cffunction>
	
	
	
	
	<cffunction name="get_tp_icon_ll" access="public" returntype="any" output="false">
	
		<cfargument name="tp_id" type="any" required="yes">
		<cfargument name="tp_rank" type="any" required="yes">
		<cfargument name="formation_code" type="any" required="yes">
		<cfargument name="method_id" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="tab" type="any" required="no">
		<cfargument name="short" type="any" required="no">

		
		<cfif get_formath(evaluate('tp_duration')) eq "0">
			<cfset tp_duration = "">
		<cfelse>
			<cfset tp_duration = "#get_formath(evaluate('tp_duration'))#h">
		</cfif>
		
					
		<cfif method_id eq "1"><cfset method_name = "Visio">
		<cfelseif method_id eq "2"><cfset method_name = "F2F">
		<cfelseif method_id eq "3"><cfset method_name = "EL">
		<cfelseif method_id eq "4"><cfset method_name = "Tel">
		<cfelseif method_id eq "5"><cfset method_name = "WEMAIL">
		<cfelseif method_id eq "6"><cfset method_name = "IMMERSION">
		<cfelseif method_id eq "7"><cfset method_name = "CERTIFICATION">
		<cfelseif method_id eq "8"><cfset method_name = "AUDIT">
		<cfelseif method_id eq "9"><cfset method_name = "EVALUATION">
		<cfelseif method_id eq "10"><cfset method_name = "OPEN TRAINING">
		<cfelseif method_id eq "11"><cfset method_name = "GROUP CLASS">
		<cfelseif method_id eq "12"><cfset method_name = "OPS TP">
		</cfif>

		<cfset format_tp = "#method_name# - #tp_duration#">
	
		<cfreturn format_tp>
	
	</cffunction>
	
	
	<cffunction name="get_tp_text" access="public" returntype="any" output="false">
	
		<cfargument name="tp_id" type="any" required="yes">
		<cfargument name="formation_code" type="any" required="yes">
		<cfargument name="method_id" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="order_id" type="any" required="no" default="0">
		<cfargument name="tab" type="any" required="no">
		<cfargument name="lg_translate" type="any" required="no">
		<cfargument name="tp_name" type="any" required="no" default="">
		
		<cfif tp_name eq "">
			<cfif not isdefined("lg_translate")>
				<cfset lg_translate = SESSION.LANG_CODE>
			</cfif>

			<cfquery name="get_method" datasource="#SESSION.BDDSOURCE#">
				SELECT method_name_#lg_translate# as method_name, method_alias_#lg_translate# as method_name_short
				FROM lms_lesson_method
				WHERE method_id = #method_id#
			</cfquery>

			<cfset _name = "#ucase(formation_code)# #get_method.method_name_short# #get_formath(evaluate('tp_duration'))#h">
			
			<cfif order_id eq 3>
				<cfset _name = _name&" - Extra">
			</cfif>

			<cfreturn _name>
		<cfelse>
			<cfreturn "#tp_name#">
		</cfif>
	
	</cffunction>
	
	
	
	<cffunction name="get_formation_icon" access="public" returntype="any" output="false">

		<cfargument name="formation_code" type="any" required="yes">
		<cfargument name="formation_name" type="any" required="yes">

		
			<cfset format_formation = "<span class='lang-sm' lang='#lcase(formation_code)#'></span> <strong style='line-height:24px'>#formation_name#</strong>">
		
	
		<cfreturn format_formation>
	
	</cffunction>
	
	
	<cffunction name="get_tp_progress_bar" access="public" returntype="any" output="true">
	
		<cfargument name="met_id" type="numeric" required="yes">
		<cfargument name="tp_status" type="any" required="yes">
		<cfargument name="tp_done" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="tp_scheduled" type="any" required="no">
	
		<!-----------------F2F + VISIO -------------->
		<cfif met_id eq "1" OR met_id eq "2">
			<cfif tp_done neq "" AND tp_duration neq "" AND tp_duration neq 0>
				<cfset pource = ceiling((tp_done/tp_duration)*100)>
				<cfset progressbar_tp='<div class="progress" style="margin:0px">
					<div class="progress-bar progress-bar-striped bg-success progress-bar-animated text-dark" style="width:#pource#%">
					#get_formath(tp_done)# h
					</div>
				</div>'>
			<cfelse>
				<cfif isdefined("tp_scheduled") AND tp_scheduled neq "">
					<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
							<div class="progress-bar bg-warning" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Planifi&eacute;</div>
						</div>'>
				<cfelse>
					<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
							<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Non commenc&eacute;</div>
						</div>'>
				</cfif>
			</cfif>	
		<!-----------------E LEARNING -------------->
		<cfelseif met_id eq "3">
			<cfif tp_status eq "1">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
						<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>
					</div>'>
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>
				</div>'>
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Licence active</div>
				</div>'>		
			<cfelseif tp_status eq "5">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>
				</div>'>		
			</cfif>
		<!----------------- IMMERSION -------------->
		<cfelseif met_id eq "6">
			<cfif tp_status eq "1">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
						<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
					</div>'>
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
				</div>'>
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En cours</div>
				</div>'>		
			<cfelseif tp_status eq "5">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>
				</div>'>		
			</cfif>
		<!----------------- CERTIF -------------->
		<cfelseif met_id eq "7">
			<cfif tp_status eq "1">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
						<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
					</div>'>
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-danger" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
				</div>'>
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Planifi&eacute;e</div>
				</div>'>		
			<cfelseif tp_status eq "5">
				<cfset progressbar_tp = '<div class="progress" style="margin:0px">	
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>
				</div>'>		
			</cfif>
		</cfif>
	
		<cfreturn progressbar_tp>
	
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	<cffunction name="get_progress_bar" access="public" returntype="any" output="true">
	
		<cfargument name="met_id" type="numeric" required="yes">
		<cfargument name="tp_status" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="tp_scheduled" type="any" required="yes">
		<cfargument name="tp_inprogress" type="any" required="yes">
		<cfargument name="tp_cancelled" type="any" required="yes">
		<cfargument name="tp_missed" type="any" required="yes">
		<cfargument name="tp_completed" type="any" required="yes">
		
	
		<cfset progressbar_tp = "">
		
		<!-----------------F2F + VISIO -------------->
		<cfif listFindNoCase("1,2,10,11", met_id)>
			
			<cfset progressbar_tp = '<div class="progress" style="margin:0px; min-width:90px">'>
			
			<cfif tp_duration neq "" AND isnumeric(tp_duration)>
				
				<cfset total = 0>
				<cfif tp_inprogress neq "0" AND isnumeric(tp_inprogress)>
					<cfset total = total+tp_inprogress>
				</cfif>
				<cfif tp_missed neq "0" AND isnumeric(tp_missed)>
					<cfset total = total+tp_missed>
				</cfif>
				<cfif tp_completed neq "0" AND isnumeric(tp_completed)>
					<cfset total = total+tp_completed>
				</cfif>
				
				<cfif tp_duration neq 0 AND tp_duration neq "">
					<cfset pource1 = ceiling((total/tp_duration)*100)>
				<cfelse>
					<cfset pource1 = 0>
				</cfif>
				<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-striped bg-success text-dark" style="width:#pource1#%"></div>'>
				
				
				<cfif tp_scheduled neq "0" AND isnumeric(tp_scheduled)>
					<cfif tp_duration neq 0 AND tp_duration neq "">
						<cfset pource2 = ceiling((tp_scheduled/tp_duration)*100)>
					<cfelse>
						<cfset pource2 = 0>
					</cfif>
					<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-striped bg-warning text-dark" style="width:#pource2#%"></div>'>
				</cfif>
				
				
				
					
			<!---	<cfif tp_done neq "" AND isnumeric(tp_done)>
					<cfset pource = ceiling((tp_done/tp_duration)*100)>
					<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-striped bg-info text-dark" style="width:#pource#%"></div>'>
				</cfif>
				
				<cfif tp_planned neq "" AND isnumeric(tp_planned)>
					<cfset pource = ceiling((tp_planned/tp_duration)*100)>
					<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-striped bg-warning text-dark" style="width:#pource#%"></div>'>
				</cfif>
				
				<cfif tp_missed neq "" AND isnumeric(tp_missed)>
					<cfset pource = ceiling((tp_missed/tp_duration)*100)>
					<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-striped bg-danger text-dark" style="width:#pource#%"></div>'>
				</cfif>--->
				
				<!---#get_formath(tp_missed)# --->
				
			<cfelse>
				<cfif isdefined("tp_scheduled") AND tp_scheduled neq "">
					<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%">Planifi&eacute;</div>'>
				<cfelse>
					<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-danger" role="progressbar" style="width:100%">Non commenc&eacute;</div>'>
				</cfif>
			</cfif>	
			
			<cfset progressbar_tp = progressbar_tp&'</div>'>
			
		<!-----------------E LEARNING -------------->
		<cfelseif met_id eq "3">
			<cfset progressbar_tp = "">
			<!---<cfif tp_status eq "1">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>					
			
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-success" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Licence active</div>'>				
			
			<cfelseif tp_status eq "3">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>'>						
			
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Annulé</div>'>						
			
			<cfelseif tp_status eq "6">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>						
			
			<cfelseif tp_status eq "7">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Transf&eacute;r&eacute;</div>'>						
			
			</cfif>--->
			
		<!----------------- IMMERSION -------------->
		<cfelseif met_id eq "6">
			<cfset progressbar_tp = "">
			<!---<cfif tp_status eq "1">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>
					
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-success" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En cours</div>'>
			
			<cfelseif tp_status eq "3">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>'>
						
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Annul&eacute;</div>'>
						
			<cfelseif tp_status eq "6">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>
			
			<cfelseif tp_status eq "7">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Transf&eacute;r&eacute;</div>'>
			
			</cfif>--->
			
		<!----------------- CERTIF -------------->
		<cfelseif met_id eq "7">
			<cfset progressbar_tp = "">
			<!---<cfif tp_status eq "1">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>					
			
			<cfelseif tp_status eq "2">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-success" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En cours</div>'>				
			
			<cfelseif tp_status eq "3">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Termin&eacute;</div>'>						
			
			<cfelseif tp_status eq "4">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Annul&eacute;</div>'>						
			
			<cfelseif tp_status eq "6">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-warning" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">En attente</div>'>						
			
			<cfelseif tp_status eq "7">
				<cfset progressbar_tp = progressbar_tp&'<div class="progress-bar bg-secondary" role="progressbar" style="width:100%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">Transf&eacute;r&eacute;</div>'>						
			</cfif>--->
			
		</cfif>
		
		
	
		<cfreturn progressbar_tp>
	
	</cffunction>

	<cffunction name="get_progress_bar_virtual" access="public" returntype="any" output="true">
	
		<cfargument name="css" type="any" required="yes">
		<cfargument name="tp_duration" type="any" required="yes">
		<cfargument name="tp_completed" type="any" required="yes">
							
			<cfset progressbar_tp = '<div class="progress" style="margin:0px; min-width:90px">'>
			
			<cfif tp_duration neq "" AND isnumeric(tp_duration)>
				
				<cfif tp_duration neq 0 AND tp_duration neq "">
					<cfset pource1 = ceiling((tp_completed/tp_duration)*100)>
				<cfelse>
					<cfset pource1 = 0>
				</cfif>

				<cfset progressbar_tp=progressbar_tp&'<div class="progress-bar progress-bar-animated progress-bar-striped bg-#css# text-dark" style="width:#pource1#%"></div>'>
				
			</cfif>	
			
			<cfset progressbar_tp = progressbar_tp&'</div>'>
		
	
		<cfreturn progressbar_tp>
	
	</cffunction>
	
	
	<cffunction name="get_method_from_list" access="public" returntype="any">
	
		<cfargument name="m_id" type="string" required="yes">
		<cfargument name="short" type="string" required="no">
		
		<cfset toreturn = "">
		<cfif isdefined("short")>
			<cfif listfind(m_id,1)><cfset toreturn = listappend(toreturn,"VISIO","+")></cfif>
			<cfif listfind(m_id,2)><cfset toreturn = listappend(toreturn,"F2F","+")></cfif>
			<cfif listfind(m_id,3)><cfset toreturn = listappend(toreturn,"EL","+")></cfif>
			<cfif listfind(m_id,6)><cfset toreturn = listappend(toreturn,"IMM","+")></cfif>
			<cfif listfind(m_id,7)><cfset toreturn = listappend(toreturn,"CERT.","+")></cfif>
			<cfif listfind(m_id,8)><cfset toreturn = listappend(toreturn,"AUDIT","+")></cfif>
			<cfif listfind(m_id,9)><cfset toreturn = listappend(toreturn,"EVAL.","+")></cfif>
			<cfif listfind(m_id,10)><cfset toreturn = listappend(toreturn,"OPEN TRAINING","+")></cfif>
			<cfif listfind(m_id,11)><cfset toreturn = listappend(toreturn,"GP CLASS","+")></cfif>
			<cfif listfind(m_id,12)><cfset toreturn = listappend(toreturn,"OPS TP","+")></cfif>
		<cfelse>
			<cfif listfind(m_id,1)><cfset toreturn = listappend(toreturn,"VISIO","+")></cfif>
			<cfif listfind(m_id,2)><cfset toreturn = listappend(toreturn,"F2F","+")></cfif>
			<cfif listfind(m_id,3)><cfset toreturn = listappend(toreturn,"ELEARNING","+")></cfif>
			<cfif listfind(m_id,6)><cfset toreturn = listappend(toreturn,"IMMERSION","+")></cfif>
			<cfif listfind(m_id,7)><cfset toreturn = listappend(toreturn,"CERTIF","+")></cfif>
			<cfif listfind(m_id,8)><cfset toreturn = listappend(toreturn,"AUDIY","+")></cfif>
			<cfif listfind(m_id,9)><cfset toreturn = listappend(toreturn,"EVALUATION","+")></cfif>
			<cfif listfind(m_id,10)><cfset toreturn = listappend(toreturn,"OPEN TRAINING","+")></cfif>
			<cfif listfind(m_id,11)><cfset toreturn = listappend(toreturn,"GROUP CLASS","+")></cfif>
			<cfif listfind(m_id,12)><cfset toreturn = listappend(toreturn,"OPS TP","+")></cfif>
		</cfif>
		<cfreturn toreturn>
		
	</cffunction>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	<cffunction name="get_tp_json" access="public" returntype="any">
	
		<cfargument name="tp_id" type="string" required="yes">
	
		<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
		SELECT tm.module_name, tm.module_id, t.tp_id, t.tp_name, s.session_id, s.session_duration, s.session_rank, s.session_close, sm.sessionmaster_name, l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, ls.status_css
		FROM lms_tp t
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpmodulemaster tm ON tm.module_id = sm.module_id
		LEFT JOIN lms_lesson l ON l.session_id = s.session_id
		LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
		WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> 
		ORDER BY s.session_rank ASC, tm.module_id, s.session_id, l.lesson_start
		</cfquery>
		
		<cfset table_session = arraynew(1)>
		<cfset counter_module = 0>
		
		<cfset counter = 0>
		

			<!---<cfquery name="get_module_close" datasource="#SESSION.BDDSOURCE#">
			SELECT COUNT(session_id) as session_nb, SUM(session_close) as session_close FROM lms_tpsession s
			INNER JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = s.sessionmaster_id
			WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> AND module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#"> 
			</cfquery>---->

			<!--------MAIN INFOS ---------->
			<cfset temp = arrayAppend(table_session, structNew())>
			<cfset table_session[0].id = "">
			<cfset table_session[0].total = "22.5">
			
			
			<!--------SESSIONS DETAILS ---------->
			<cfoutput query="get_session">
			
			<cfif module_id neq counter_module>
				<cfset temp = arrayAppend(table_session, structNew())>
				<cfset table_session[currentrow+1].id = "m_#module_id#">
				<cfset table_session[currentrow+1].text = module_name>
				<cfset table_session[currentrow+1].icon = "glyphicon glyphicon-folder-open">
				<cfset table_session[currentrow+1].parent = "##">		
				<cfset counter_module = module_id>
			<cfelse>
				<cfset temp = arrayAppend(table_session, structNew())>
				<cfset table_session[currentrow+1].id = "s_#session_id#">
				<cfset table_session[currentrow+1].text = sessionmaster_name>
				<cfset table_session[currentrow+1].icon = "glyphicon glyphicon-folder-open">
				<cfset table_session[currentrow+1].parent = "m_#module_id#">
			</cfif>
			
		
			<!---<li id="m_#currentrow#" <cfif get_module_close.session_close eq "0">data-jstree='{"type":"module-without"}'<cfelseif get_module_close.session_nb neq get_module_close.session_close>data-jstree='{"type":"module-close"}'<cfelse>data-jstree='{"type":"module-open"}'</cfif>>#module_name#
				<ul>
					<cfoutput group="session_id">
					<li <cfif session_close eq "1">data-jstree='{"type":"session-open"}'<cfelse>data-jstree='{"type":"session-close"}'</cfif> id="child_node_#session_id#_#session_rank#">[#session_duration#] #sessionmaster_name#
					<cfif lesson_id neq "">					
					<ul>
						<cfoutput>
						<li id="l_#lesson_id#" data-jstree='{"type":"lesson-#status_css#"}'>#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#-#timeformat(lesson_end,'HH:mm')#</li>					
						</cfoutput>
					</ul>					
					</cfif>
					</li>
					</cfoutput>
				</ul>
			</li>
			--->
			
		
		</cfoutput>
	
		<cfset table_js = SerializeJSON(table_session)>
		<cfset table_js = replacenocase(table_js,"TEXT","text","ALL")>
		<cfset table_js = replacenocase(table_js,"PARENT","parent","ALL")>
		<cfset table_js = replacenocase(table_js,"ID","id","ALL")>
		<cfset table_js = replacenocase(table_js,"ICON","icon","ALL")>
		
		<cfreturn table_js>
	
	</cffunction>
	
	
	
	
	
	
	
	<cffunction name="get_material" access="public" returntype="any">
		<cfargument name="session_id" type="numeric" required="no">
		<cfargument name="sessionmaster_id" type="numeric" required="no">

		<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
		SELECT material_url FROM lms_material
		<cfif isdefined("sessionmaster_id")>
		WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND material_type = "rl"
		</cfif>		
		</cfquery>
		
		<cfoutput query="get_material">
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#material_url#")>
				<a href="./assets/materials/#material_url#" target="_blank" class="btn btn-sm btn-info"><i class="fas fa-download"></i><span class="d-none d-lg-block">Support</span></a>
			</cfif>
        </cfoutput>
		
		
		
    </cffunction>
	
	
	
	
	
	<!--- <cffunction name="get_tp" access="public" returntype="any"> --->
	
		<!--- <cfargument name="tp_id" type="string" required="yes"> --->
	
		<!--- <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT tm.module_name, tm.module_id, t.tp_id, t.tp_name, s.session_id, s.session_duration, sm.sessionmaster_name, l.lesson_start, l.lesson_end, l.lesson_id --->
		<!--- FROM lms_tp t --->
		<!--- LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id --->
		<!--- LEFT JOIN lms_tpsessionmaster sm ON sm.sessionmaster_id = s.sessionmaster_id --->
		<!--- LEFT JOIN lms_tpmodulemaster tm ON tm.module_id = sm.module_id --->
		<!--- LEFT JOIN lms_lesson l ON l.session_id = s.session_id --->
		<!--- WHERE t.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">  --->
		<!--- ORDER BY s.session_rank ASC --->
		<!--- </cfquery> --->
		
		<!--- <cfquery name="get_info_tp" datasource="#SESSION.BDDSOURCE#"> --->
		<!--- SELECT SUM(session_duration) as nb_plan FROM lms_tpsession WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">  --->
		<!--- </cfquery> --->
		
		<!--- <cfset table_session = arraynew(1)> --->
		
		<!--- <cfset counter_module = 0> --->
		<!--- <cfset counter_rows = 1> --->
		<!--- <cfset rank_module = 0> --->
		
		<!--- <cfset temp = arrayAppend(table_session, structNew())> --->
		<!--- <cfset table_session[1].tp_id = "#tp_id#"> --->
		<!--- <cfset table_session[1].total_hour = "#get_info_tp.nb_plan/60#"> --->
			
		<!--- <cfoutput query="get_session"> --->
		<!--- <cfset counter_rows++> --->
		
		<!--- <cfif module_id neq counter_module> --->
			<!--- <cfset rank_module++> --->
			<!--- <cfset temp = arrayAppend(table_session, structNew())> --->
			<!--- <cfset table_session[counter_rows].session_id = ""> --->
			<!--- <cfset table_session[counter_rows].sessionmaster_name = ucase(module_name)> --->
			<!--- <cfset table_session[counter_rows].session_duration = session_duration> --->
			<!--- <cfset table_session[counter_rows].module_id = module_id> --->
			<!--- <cfset table_session[counter_rows].parent_id = "">	 --->
			<!--- <cfset table_session[counter_rows].rank = rank_module> --->
			<!--- <cfset counter_rows++> --->
		<!--- </cfif> --->
		
			<!--- <cfset temp = arrayAppend(table_session, structNew())> --->
			<!--- <cfset table_session[counter_rows].session_id = session_id> --->
			<!--- <cfset table_session[counter_rows].sessionmaster_name = sessionmaster_name> --->
			<!--- <cfset table_session[counter_rows].session_duration = session_duration> --->
			<!--- <cfset table_session[counter_rows].module_id = module_id> --->
			<!--- <cfset table_session[counter_rows].parent_id = module_id> --->
			<!--- <cfset table_session[counter_rows].rank = rank_module> --->
		
		<!--- <cfset counter_module = module_id> --->
			
		<!--- </cfoutput> --->
	
		<!--- <cfset table_js = SerializeJSON(table_session)> --->
		
		<!--- <cfreturn table_js> --->
	
	<!--- </cffunction> --->
	
	
	
	
	
	
	<cffunction name="get_tpdestination_icon" access="public" returntype="any" output="false">
	
		<cfargument name="destination_id" type="any" required="yes">
		<cfargument name="size" type="any" required="yes">
		<cfargument name="responsive" type="any" required="no">
		
		<!---<cfif isdefined("responsive")>img-responsive</cfif>--->
		<cfoutput>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/img_destination/#destination_id#.jpg")>
				<cfset icon_destination = '<img src="./assets/img_destination/#destination_id#.jpg" class="rounded-circle" width="#size#">'>
			<cfelse>
				<cfset icon_destination = ''>
			</cfif>
        </cfoutput>
		
		<cfreturn icon_destination>
		
	</cffunction>
	
	
	
	
	
	
	<cffunction name="remove_quiz_results" access="public" returntype="any">
		<cfargument name="quiz_id" type="any" required="yes">
		<cfargument name="u_id" type="any" required="yes">
		
		<cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_user_id FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>
		
		<cfif get_quiz_id.recordcount neq "0">
		
		<cfquery name="remove_quiz" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_user WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_user_id#"> AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		</cfquery>
		
		<cfquery name="remove_quiz_result" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_result WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_user_id#">
		</cfquery>
		
		</cfif>
		
	</cffunction>
	
	
	
	
	
	<cffunction name="remove_quiz_global" access="public" returntype="any">
		<cfargument name="quiz_id" type="any" required="yes">
		
		<cfquery name="get_qu_cor" datasource="#SESSION.BDDSOURCE#">
		SELECT qu_id FROM lms_quiz_cor WHERE quiz_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>
		
		<cfoutput query="get_qu_cor">
		
			<cfquery name="del_question" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_question WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
			</cfquery>
			
			<cfquery name="del_answer" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_answer WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
			</cfquery>
			
			<cfquery name="del_answer" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_cor WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
			</cfquery>
			
		</cfoutput>
		
		<cfquery name="remove_quiz" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>
		
		
	</cffunction>
	

	
	
</cfprocessingdirective>
</cfcomponent>