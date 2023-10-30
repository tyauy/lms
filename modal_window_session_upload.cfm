
<!--- <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->

<table class="table m-0">
	<tr>
		<td class="bg-light" width="15%">
			<!--- PI&Egrave;CE JOINTE<br><small>pdf / doc / docx / jpg / jpeg / png</small><br><small>3 max</small> --->
			<cfoutput>#obj_translater.get_translate_complex(id_translate="pj_notice")#</cfoutput>
		</td>
		<td valign="top">
			<div class="row">

				<!--- ! BO_ROOT_URL --->
				<cfset dir_go = "#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#">	

				<div class="col-md-6">
					<table class="table table-sm table-bordered" id="file_holder">

						<!--- <tr>
							<th class="bg-light" colspan="2">
							<div align="center"><label>PI&Egrave;CE JOINTE</label></div>
							</th>
						</tr> --->
							
						<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
						
						<cfif dirQuery.recordcount eq "0">
							<tr id="file_none">
								<td colspan="2" align="center"><em>Aucun fichier</em></td>
							</tr>
						<cfelse>
						
							<cfoutput>
							<cfloop query="dirQuery">
							<tr id="file_#dirQuery.currentRow#">
								<!--- <th class="bg-light" width="30%">
								<label>Fichier</label>
								</th> --->
								<td colspan="2">
								<a href="./assets/lessons/#t_id#/#s_id#/#name#" target="_blank">
									<span style="display:inline-block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 40ch;">#name#</span>
								</a>
								
								<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
								<!---  --->
								<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="#name#" id="delete_doc_#dirQuery.currentRow#"><i class="fal fa-trash-alt"></i></i></a>
							</td>
							</tr>
							
							</cfloop>
							</cfoutput>
						
						</cfif>
				
					</table>
				</div>
				
				<div class="col-md-6">

					<form method="post" id="form_doc" name="form_doc" onsubmit="return submit_form_doc();">

					<table class="table table-sm table-bordered">
	
						<tr>
							<td>

								<input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc,.pptx" <cfif dirQuery.recordcount GTE "3">disabled</cfif> >

							</td>
							<td>
								<!--- <input type="hidden" name="t_id" value="<cfoutput>#t_id#</cfoutput>">
								<input type="hidden" name="s_id" value="<cfoutput>#s_id#</cfoutput>"> --->
								<input type="hidden" name="dir_go" value="<cfoutput>#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#</cfoutput>">
								<input type="submit" class="btn btn-info btn-sm" id="doc_upload_submit" value="upload" <cfif dirQuery.recordcount GTE "3">disabled</cfif>>
							</td>
							
						</tr>
						<tr>
							<td colspan="2">
								<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_doc" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</td>
						</tr>
					</table>

					</form>

				</div>
				
			</div>
			
		</td>
	</tr>
</table>
<!--- </cfif> --->

<script>

var handler_remove = function(event) {
            event.preventDefault();
            var idtemp = $(this).attr("id");
            idtemp = idtemp.split("delete_doc_");
		    var doc_pos = idtemp[1];
			var doc_name = $(this).attr("name");
            console.log("hello", doc_pos, doc_name);

			var fd = new FormData();
			fd.set("name", doc_name);
			fd.set("t_id", <cfoutput>#t_id#</cfoutput>);
			fd.set("s_id", <cfoutput>#s_id#</cfoutput>);

			$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=delete_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			success    : function ( data )
			{

				console.log("yeah", data)
				// console.log(obj.CLIENTFILE)
				$("#file_" + doc_pos ).remove();

			}
		});

    };
    $(".remove_doc").bind("click",handler_remove);

function submit_form_doc() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_doc"));

		$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=upload_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_doc").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_doc").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{

				var doc_length = $('#file_holder tr').length;
				const obj = JSON.parse(data);
				// console.log("yeah", data)
				console.log(doc_length)
				console.log(obj)

				setTimeout(function (){

					if (!obj.FILEWASOVERWRITTEN) {
						$("#file_none").empty();
						var new_doc = '<tr id="file_'+ (doc_length + 1) + '"><td colspan="2">';
						new_doc += '<a href="./assets/lessons/<cfoutput>#t_id#/#s_id#</cfoutput>/'+ obj.CLIENTFILE + '" target="_blank">'+ obj.CLIENTFILE + '</a>';
						<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
						new_doc += '<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="'+ obj.CLIENTFILE + '" id="delete_doc_'+ (doc_length + 1) + '">';
						new_doc += '<i class="fal fa-trash-alt"></i></i></a></td></tr>;';
						$("#file_holder").append(new_doc);

						$(".remove_doc").bind("click",handler_remove);
					}

					if ((doc_length + 1) > 3)  {
						$("#doc_upload_submit").prop("disabled",true);
						$("#doc_attach").prop("disabled",true);
					}
					

					$("#progress_doc").css("width","0%");	
				}, 1000);

			}
		});
			
					
	};


</script>

