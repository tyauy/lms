<cfif isdefined("sm_id") AND isdefined("core_material")>

<cfquery name="get_ressource" datasource="#SESSION.BDDSOURCE#">
SELECT sessionmaster_ressource FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfset sessionmaster_ressource = get_ressource.sessionmaster_ressource>

	<table class="table table-sm table-bordered">
		<tr class="bg-light">
			<th>Ressource</th>
			<th>Fichier</th>
			<th>Format</th>
			<th>Upload</th>
			<th>Remove</th>
		</tr>
		<cfoutput>
		<tr>
			<td><small>WORKSHEET - PDF</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
			<a href="/assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank">#sessionmaster_ressource#_WS.pdf</a>
			</cfif>
			</td>
			<td>pdf</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_ws_pdf">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="WS">
					<input type="hidden" name="f_doc" value="pdf">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pdf">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=WS&f_doc=pdf&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td><small>WORKSHEET+KEYS - PDF</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
			<a href="/assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank">#sessionmaster_ressource#_WSK.pdf</a>
			</cfif>
			</td>
			<td>pdf</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_wsk_pdf">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="WSK">
					<input type="hidden" name="f_doc" value="pdf">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pdf">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=WSK&f_doc=pdf&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td><small>KEYS SOLO - PDF</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pdf")>
			<a href="/assets/materials/#sessionmaster_ressource#_K.pdf" target="_blank">#sessionmaster_ressource#_K.pdf</a>
			</cfif>
			</td>
			<td>pdf</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_k_pdf">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="K">
					<input type="hidden" name="f_doc" value="pdf">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pdf">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=K&f_doc=pdf&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td><small>WORKSHEET - PPTX</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx")>
			<a href="/assets/materials/#sessionmaster_ressource#_WS.pptx" target="_blank">#sessionmaster_ressource#_WS.pptx</a>
			</cfif>
			</td>
			<td>pptx</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_ws_pptx">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="WS">
					<input type="hidden" name="f_doc" value="pptx">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pptx">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=WS&f_doc=pptx&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td><small>WORKSHEET+KEYS - PPTX</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pptx")>
			<a href="/assets/materials/#sessionmaster_ressource#_WSK.pptx" target="_blank">#sessionmaster_ressource#_WSK.pptx</a>
			</cfif>
			</td>
			<td>pptx</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_wsk_pptx">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="WSK">
					<input type="hidden" name="f_doc" value="pptx">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pptx">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=WSK&f_doc=pptx&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td><small>KEYS SOLO - PPTX</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_K.pptx")>
			<a href="/assets/materials/#sessionmaster_ressource#_K.pptx" target="_blank">#sessionmaster_ressource#_K.pptx</a>
			</cfif>
			</td>
			<td>pptx</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_k_pptx">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="K">
					<input type="hidden" name="f_doc" value="pptx">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".pptx">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=K&f_doc=pptx&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		
		
		
		<cfloop from="1" to="5" index="cor">
		<tr>
			<td><small>AUDIO ###cor#</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
			<a href="/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" target="_blank">#sessionmaster_ressource#_AUDIO#cor#.mp3</a>
			</cfif>
			</td>
			<td>mp3</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_audio_mp3">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="AUDIO#cor#">
					<input type="hidden" name="f_doc" value="mp3">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".mp3">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=AUDIO#cor#&f_doc=mp3&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		</cfloop>
		
		<cfloop from="1" to="5" index="cor">
		<tr>
			<td><small>VIDEO ###cor#</small></td>
			<td>
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
			<a href="/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp4" target="_blank">#sessionmaster_ressource#_AUDIO#cor#.mp4</a>
			</cfif>
			</td>
			<td>mp4</td>
			<td>
				<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_mp4">
					<input type="hidden" name="act" value="upload">
					<input type="hidden" name="core_material" value="1">
					<input type="hidden" name="n_doc" value="VIDEO#cor#">
					<input type="hidden" name="f_doc" value="mp3">
					<input type="hidden" name="sm_id" value="#sm_id#">
					<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">
					<input type="file" name="sessionmaster_file" accept=".mp4">
					<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
				</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?core_material=1&act=delete&sm_id=#sm_id#&n_doc=VIDEO#cor#&f_doc=mp4&sessionmaster_ressource=#sessionmaster_ressource#&core_material=1" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		</cfloop>	
			
		</cfoutput>
	</table>

<cfelseif isdefined("sm_id") AND isdefined("misc_material")>

	<cfquery name="get_ressource" datasource="#SESSION.BDDSOURCE#">
	SELECT sessionmaster_ressource FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>

	<cfset sessionmaster_ressource = get_ressource.sessionmaster_ressource>

	<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_material WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>

	<cfif get_material.recordcount neq "0">
	<table class="table table-sm table-bordered">
		<tr class="bg-light">
			<th>Ressource</th>
			<th>Nom fichier</th>
			<th>Description</th>
			<th>Format</th>
			<th>Remove</th>
		</tr>
		<cfoutput query="get_material">
		<tr>
			<td>FILE ###material_id#</td>		
			<cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.pdf")>
			<td><a href="/assets/materials/#sessionmaster_ressource#_#material_id#.pdf" target="_blank">#material_name#</a></td>
			<td>#material_description#</td>
			<td>pdf</td>
			<cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_#material_id#.jpg")>
			<td><a href="/assets/materials/#sessionmaster_ressource#_#material_id#.jpg" target="_blank">#material_name#</a></td>
			<td>#material_description#</td>
			<td>jpg</td>
			</cfif>		
			<td><a href="updater_upload_ressource.cfm?misc_material=1&act=delete&sm_id=#sm_id#&material_id=#material_id#&sessionmaster_ressource=#sessionmaster_ressource#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>	
		</cfoutput>
	</table>
	</cfif>

	<br>

	<form action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_misc">
	<cfoutput>
	<table class="table table-sm table-bordered">
		<tr class="bg-light">
			<th>Nom fichier</th>
			<th>Description</th>
			<th>Format</th>
			<th colspan="2">Upload</th>
		</tr>
		<tr>
			<td width="25%"><input type="text" class="form-control" name="material_name" value=""></td>
			<td width="40%"><textarea class="form-control" name="material_description"></textarea></td>
			<td>pdf,jpg</td>
			<td>
				<input type="file" name="sessionmaster_file" accept=".jpg,.pdf">
				
				<input type="hidden" name="act" value="upload">
				<input type="hidden" name="misc_material" value="1">
				<input type="hidden" name="sm_id" value="#sm_id#">
				<input type="hidden" name="sessionmaster_ressource" value="#sessionmaster_ressource#">			
			</td>	
			<td>
				<input type="submit" class="btn btn-sm btn-outline-info" value="Upload">
			</td>
		</tr>
	</table>
	</cfoutput>
	</form>	

<cfelseif isdefined("new_file")>

	<form action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_file">
	<cfoutput>
	<table class="table table-sm table-bordered">
		<tr class="bg-light">
			<!---<th>Nom fichier</th>--->
			<th>Format</th>
			<th colspan="2">Upload</th>
		</tr>
		<tr>
			<!---<td width="25%"><input type="text" class="form-control" name="material_name" disabled value="#get_material_id.id#_material"></td>--->
			<td>pdf,jpg,mp3,mp4</td>
			<td>
				<input type="file" name="material_file" accept=".jpg,.pdf,.mp4,.mp3,.png">
				<input type="hidden" name="new_file" value="1">
				<cfoutput>
				<input type="hidden" name="quiz_id" value="#quiz_id#">
				<cfif isdefined("qu_id")><input type="hidden" name="qu_id" value="#qu_id#"></cfif>
				</cfoutput>
				<input type="hidden" name="new_file" value="1">
				<input type="hidden" name="act" value="upload">
				
			</td>	
			<td>
				<input type="submit" class="btn btn-sm btn-outline-info" value="Upload">
			</td>
		</tr>
	</table>
	</cfoutput>
	</form>	
	
	
<cfelseif isdefined("sm_id") AND isdefined("thumb_material")>

	<cfquery name="get_ressource" datasource="#SESSION.BDDSOURCE#">
	SELECT sessionmaster_ressource, sessionmaster_code FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>

	<cfset sessionmaster_ressource = get_ressource.sessionmaster_ressource>
	<cfset sessionmaster_code = get_ressource.sessionmaster_code>
	
	<table class="table table-sm table-bordered">
		<tr class="bg-light">
			<th>Type</th>
			<th>Img</th>
			<th>Format</th>
			<th>Resolution</th>
			<th>Action</th>
			<th>Remove</th>
		</tr>
		<cfoutput>
		<tr>
			<td>Cover <strong>VISIO</strong><br>(about 160 Ko)</td>
			<td>#obj_lms.get_thumb_session(sessionmaster_id="#sm_id#",sessionmaster_code="#sessionmaster_code#",size="250")#</td>	
			<td>jpg</td>
			<td>800px/450px<br>800px/533px</td>
			<td>
			<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_mp4">
				<input type="hidden" name="act" value="upload">
				<input type="hidden" name="thumb_material" value="1">
				<input type="hidden" name="sm_id" value="#sm_id#">
				<input type="file" name="sessionmaster_thumb_file" accept=".jpg">
				<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
			</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?thumb_material=1&act=thumb_delete&sm_id=#sm_id#&sessionmaster_code=#sessionmaster_code#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td>Thumb <strong>VISIO</strong><br>(about 10 Ko)</td>
			<td>#obj_lms.get_thumb_mini_session(sessionmaster_id="#sm_id#",sessionmaster_code="#sessionmaster_code#",size="150")#</td>	
			<td>jpg</td>
			<td>150px/84px<br>150px/100px</td>
			<td>
			<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_mp4">
				<input type="hidden" name="act" value="upload">
				<input type="hidden" name="mini_thumb_material" value="1">
				<input type="hidden" name="sm_id" value="#sm_id#">
				<input type="file" name="sessionmaster_thumb_file" accept=".jpg">
				<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
			</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?thumb_material=1&act=thumb_mini_delete&sm_id=#sm_id#&sessionmaster_code=#sessionmaster_code#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>	



		<tr>
			<td>Cover <strong>ELEARNING</strong><br>(about 160 Ko)</td>
			<td>

				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
					<img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="250" class="mr-2">
				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sm_id#.jpg")>			
					<img src="../assets/img_material_el/thumbs/#sm_id#.jpg" width="250" class="mr-2">
				<cfelse>
					<img src="../assets/img/wefit_lesson.jpg" width="250" class="mr-2">
				</cfif>

			</td>	
			<td>jpg</td>
			<td>800px/450px<br>800px/533px</td>
			<td>
			<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_mp4">
				<input type="hidden" name="act" value="upload">
				<input type="hidden" name="thumb_material_el" value="1">
				<input type="hidden" name="sm_id" value="#sm_id#">
				<input type="file" name="sessionmaster_thumb_file" accept=".jpg">
				<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
			</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?thumb_material=1&act=thumb_delete&sm_id=#sm_id#&sessionmaster_code=#sessionmaster_code#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>
		<tr>
			<td>Thumb <strong>ELEARNING</strong><br>(about 10 Ko)</td>
			<td>
				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
					<img src="../assets/img_material_el/#sessionmaster_code#.jpg" width="150" class="mr-2">
				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sm_id#.jpg")>			
					<img src="../assets/img_material_el/#sm_id#.jpg" width="150" class="mr-2">
				<cfelse>
					<img src="../assets/img/wefit_lesson.jpg" width="150" class="mr-2">
				</cfif>

			</td>	
			<td>jpg</td>
			<td>150px/84px<br>150px/100px</td>
			<td>
			<cfform action="updater_upload_ressource.cfm" enctype="multipart/form-data" method="POST" id="form_video_mp4">
				<input type="hidden" name="act" value="upload">
				<input type="hidden" name="mini_thumb_material_el" value="1">
				<input type="hidden" name="sm_id" value="#sm_id#">
				<input type="file" name="sessionmaster_thumb_file" accept=".jpg">
				<input type="submit" class="btn btn-sm btn-outline-info" value="#obj_translater.get_translate('btn_update')#">
			</cfform>
			</td>
			<td><a href="updater_upload_ressource.cfm?thumb_material=1&act=thumb_mini_delete&sm_id=#sm_id#&sessionmaster_code=#sessionmaster_code#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a></td>
		</tr>	


		</cfoutput>
	</table>
	
</cfif>