
<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,8,11,12">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfparam name="view" default="list">
	<cfparam name="a_id" default="0">
	<cfparam name="g_id" default="0">
	<cfparam name="token_code" default="0">
	<cfparam name="token_list_show" default="0">
	<cfparam name="token_list" default="">
	<cfparam name="ts_id" default="0">
	<cfparam name="tss_id" default="SENT">
	<cfparam name="doc_success" default="0">
	

	<cfif isDefined("SESSION.TOKEN_LIST") AND token_list_show eq 1>
		<cfset token_list = SESSION.TOKEN_LIST>
	</cfif>

	<cfset _account_right = "">
	<cfset _session_right = "">


    <cfif isDefined("SESSION.USER_ACCOUNT_RIGHT_ID") AND SESSION.USER_ACCOUNT_RIGHT_ID neq "">
        <cfset _account_right = SESSION.USER_ACCOUNT_RIGHT_ID>
	</cfif>
	
	<cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">

		<cfset _session_right = SESSION.USER_SESSION_RIGHT_ID>

        <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
            SELECT account_id
            FROM lms_list_token_session
            WHERE token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_session_right#" list="true">)
        </cfquery>

        <cfloop query="get_session">
			<cfif !listFindNoCase(_account_right,account_id)>
				<cfset _account_right = listAppend(_account_right,account_id) >
			</cfif>
        </cfloop>
    </cfif>

	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
		SELECT ag.group_name, a.account_name, a.account_id
		FROM account a 
		INNER JOIN account_group ag ON ag.group_id = a.group_id 
		WHERE a.type_id = 9
		<cfif g_id neq 0>
			AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		<cfif _account_right neq "">
			AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
		</cfif>
		<cfif g_id eq 0 AND _account_right eq "">
			AND 1 = 2
		</cfif>
		GROUP BY a.account_id
	</cfquery>

	<cfif g_id neq 0 AND _account_right eq "">
		<cfloop query="get_account">
			<cfset _account_right = listAppend(_account_right,account_id) >
        </cfloop>
	</cfif>

	<cfset _token_code = token_code>

	<cfif _token_code neq "0">
		<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
			SELECT token_id, token_session_id FROM lms_list_token WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_token_code#">
		</cfquery>
		<cfset ts_id = get_token.token_session_id>
	</cfif>

	<cfquery name="get_certif_session" datasource="#SESSION.BDDSOURCE#">
		SELECT lts.token_session_id, token_session_name, token_session_start, token_session_end, 
		token_session_last_update, token_session_method, token_session_certif_type, token_session_status,
		a.account_name, a.account_id,
		COUNT(lt.user_id) AS nb,
		SUM(CASE WHEN lt.token_status_id = '1' THEN 1 ELSE 0 END) AS nb_wait,
		SUM(CASE WHEN lt.token_status_id = '2' THEN 1 ELSE 0 END) AS nb_code_sent,
		SUM(CASE WHEN lt.token_status_id = '3' THEN 1 ELSE 0 END) AS nb_certif_sent,
		SUM(CASE WHEN lt.token_status_id = '4' THEN 1 ELSE 0 END) AS nb_nr

		FROM lms_list_token_session lts
		INNER JOIN account a ON a.account_id = lts.account_id
		LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
		<!--- WHERE lts.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">--->
		WHERE 1 = 1
		<cfif tss_id neq "ALL">
		AND lts.token_session_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tss_id#">
		</cfif>
		<cfif ts_id neq "0">
		AND	lts.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
		</cfif>
		<cfif a_id neq "0">
			AND	lts.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>
		<cfif _account_right neq "">
			AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
		</cfif>
		<cfif _session_right neq "">
            AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_session_right#" list="true">)
        </cfif>
		GROUP BY lts.token_session_id
		ORDER BY a.account_name, lts.token_session_name ASC
	</cfquery>

	<cfif ts_id neq "0" OR token_list neq "">
		
		<cfif _account_right eq "">
			<cfoutput query="get_certif_session" group="account_id">
				<cfset _account_right = listAppend(_account_right,account_id) >
			</cfoutput>
		</cfif>

		
		<cfquery name="get_token_attributed" datasource="#SESSION.BDDSOURCE#">
			SELECT 
			lt.token_id, lt.user_id, lt.certif_id, lt.token_creation, lt.token_send, lt.token_code, 
			lt.token_login, lt.token_end, lt.token_status_id, lt.token_use, lt.token_level, lt.token_start,
			ltss.token_session_name,
			lts.token_status_name, lts.token_status_css,
			u.user_id as id, u.user_firstname, u.user_name, u.user_email
			FROM user u
			LEFT JOIN lms_list_token lt ON lt.user_id = u.user_id
			LEFT JOIN lms_list_token_session ltss ON ltss.token_session_id = lt.token_session_id
			LEFT JOIN lms_list_token_status lts ON lts.token_status_id = lt.token_status_id
			WHERE 
			<cfif ts_id neq "0">
				lt.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
			<cfelseif token_list neq "">
				lt.token_code IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#token_list#" list="Yes">)
			</cfif>
			ORDER BY 
			<cfif _token_code neq "0">
				lt.token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_token_code#"> DESC,
			</cfif>
			lts.token_status_id ASC, lt.token_id ASC			
		</cfquery>
	</cfif>

	<cfquery name="get_nb_all" datasource="#SESSION.BDDSOURCE#">
        SELECT COUNT(lt.user_id) AS nb_code,
        COUNT(DISTINCT(lt.user_id)) AS nb_candidat,
		SUM(CASE WHEN lt.token_status_id = '1' THEN 1 ELSE 0 END) AS nb_wait,
		SUM(CASE WHEN lt.token_status_id = '2' THEN 1 ELSE 0 END) AS nb_code_sent,
		SUM(CASE WHEN lt.token_status_id = '3' THEN 1 ELSE 0 END) AS nb_certif_sent,
		SUM(CASE WHEN lt.token_status_id = '4' THEN 1 ELSE 0 END) AS nb_nr,
        SUM(CASE WHEN lt.token_status_id = '5' THEN 1 ELSE 0 END) AS nb_nu
        FROM lms_list_token_session lts
        INNER JOIN account a ON a.account_id = lts.account_id
        LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
        WHERE 1 = 1
		<cfif _account_right neq "">
			AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
		</cfif>
        <cfif _session_right neq "">
            AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_session_right#" list="true">)
        </cfif>
        <cfif isdefined("a_id") AND a_id neq "0">
            AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
        </cfif>
		<cfif g_id neq 0>
			AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
		</cfif>
		<!---AND lts.token_session_status <> "CLOSE" --->
    </cfquery>

	<cfif view eq "calendar">
		<cfquery name="get_certif_all" datasource="#SESSION.BDDSOURCE#">
			SELECT lts.token_session_id, token_session_name, token_session_start, token_session_end, 
			token_session_last_update, token_session_method, token_session_certif_type, token_session_status,
			a.account_name, a.account_id
			FROM lms_list_token_session lts
			INNER JOIN account a ON a.account_id = lts.account_id
			LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
			WHERE 1 = 1 
			<cfif _account_right neq "">
				AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
			</cfif>
			<cfif _session_right neq "">
				AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_session_right#" list="true">)
			</cfif>
			GROUP BY lts.token_session_id
			ORDER BY lts.token_session_id ASC
		</cfquery>
	</cfif>

	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
			SELECT ag.group_name, ag.group_id, a.account_name, a.account_id, COUNT(u.user_id) AS nb
			FROM account a 
			INNER JOIN account_group ag ON ag.group_id = a.group_id 
			INNER JOIN user u ON u.account_id = a.account_id 
			WHERE a.type_id = 9 
			GROUP BY a.group_id
		</cfquery>

		<cfquery name="get_token_search" datasource="#SESSION.BDDSOURCE#">
			SELECT lt.token_code, u.user_id, u.account_id, 
			CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, 
			Replace(Replace(u.user_phone,CHAR(13),' '),CHAR(10), ' ') as user_phone,
			us.user_status_name_#SESSION.LANG_CODE# as status_name
			FROM lms_list_token lt 
			INNER JOIN user u ON u.user_id = lt.user_id
			LEFT JOIN account a ON a.account_id = u.account_id
			LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
			WHERE lt.token_session_id IS NOT NULL
			ORDER BY u.user_id
		</cfquery>

	</cfif>

	<cfif a_id eq 0 AND _account_right neq "">
		<cfset a_id = listGetAt(_account_right, 1)>
	</cfif>

	<cfquery name="get_token_business_left" datasource="#SESSION.BDDSOURCE#">
	SELECT llt.token_id, COUNT(*) as nb
	FROM lms_list_token llt
	INNER JOIN account a ON llt.group_id = a.group_id 
	WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> AND llt.certif_id = 22
	AND llt.user_id IS NULL
</cfquery>

	<cfquery name="get_token_general_left" datasource="#SESSION.BDDSOURCE#">
	SELECT llt.token_id, COUNT(*) as nb
	FROM lms_list_token llt
	INNER JOIN account a ON llt.group_id = a.group_id 
	WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"> AND llt.certif_id = 23
	AND llt.user_id IS NULL
	</cfquery>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "School Management">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content" id="container_main">
			
			<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

				<div class="alert alert-success <cfif doc_success neq 1>collapse</cfif>" id="message_ok">
					Le fichier a correctement été traité.
				</div>	

				<div class="row">
					<div class="col-md-4">
						<cfoutput><select class="form-control" onchange="document.location.href='db_certif_school_2.cfm?tss_id=#tss_id#&g_id='+$(this).val()"></cfoutput>
							<option value="0" <cfif g_id eq "0">selected</cfif>>ALL</option>
							<cfoutput query="get_group">
								<option value="#group_id#" <cfif g_id eq group_id>selected</cfif>>
									#group_name# 
									(#nb#)
								</option>
							</cfoutput>
						</select>
						<form id="form-global_search" name="global_search">
							<div class="typeahead__container">
								<div class="typeahead__field">
									<div class="typeahead__query">
										<input class="js_typeahead_token" name="token[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
									</div>
								</div>
							</div>
						</form>
					</div>
					<!--- <div class="col-md"> --->
					<!--- <cfoutput>
					<a class="btn <cfif tss_id eq "UPLOAD">btn-secondary active<cfelse>btn-outline-secondary</cfif>" href="db_certif_school.cfm?tss_id=UPLOAD&g_id=#g_id#&a_id=#a_id#">
						<i class="fa-light fa-file-arrow-up fa-2x"></i><br> UPDLOAD
					</a>
					</cfoutput> --->
	
						<!--- <div class="row"> --->
					<div class="col-md-4">
						<form class="form_upload_token_batch" name="form_upload_token_batch">
								
							<label for="doc_attach_batch" class="btn btn-lg btn-block btn-primary" style="cursor: pointer;">
								<i class="fa-light fa-file-excel fa-2x"></i> <i id="loading_xlsx" class="fas fa-spinner fa-spin fa-2x text-white collapse"></i>
								<br>
								1/ Import Detailed Gp Report
							</label>
							<input type="file" id="doc_attach_batch" class="token_attach" name="doc_attach" accept=".xlsx" style="display:none">

							<!--- <input type="hidden" name="a_id" value="<cfoutput>#a_id#</cfoutput>">
							<input type="hidden" name="s_id" value="<cfoutput>#ts_id#</cfoutput>">	 --->
						</form>
					</div>
					<div class="col-md-4">
						<form class="form_upload_certif_batch" name="form_upload_certif_batch">
									
							<label for="doc_attach_certif_batch" class="btn btn-lg btn-block btn-primary <cfif isdefined("SESSION.BATCH_CAMBRIDGE_UPLOAD") AND SESSION.BATCH_CAMBRIDGE_UPLOAD eq 1 >disabled</cfif>" style="cursor: pointer;">
								<i class="fa-light fa-file-pdf fa-2x"></i> <i id="loading_pdf" class="fas fa-spinner fa-spin fa-2x text-white collapse"></i>
								<br>
								2/ Import Global Certificates 
							</label>
							<input type="file" id="doc_attach_certif_batch" class="certif_batch" name="doc_attach" accept=".pdf" style="display:none">

						</form>
						<cfif isdefined("SESSION.BATCH_CAMBRIDGE_UPLOAD") AND SESSION.BATCH_CAMBRIDGE_UPLOAD eq 1 >
							<p>Excel en cours de traitement, actualiser la page dans quelques instants</p>
						</cfif>
						
					</div>
				</div>
			</cfif>
			
			<cfif ts_id eq "0">
			<div class="row">
                <div class="col-md-12">
                    <div class="card border">
						<div class="card-body">
							<h6 class="text-red">Aperçu crédits</h6>
							<cfoutput>
							<div class="d-flex justify-content-center">
								<span class="badge btn-outline-primary p-2 mx-2">
									CANDIDATS<br> / CODES <br><h4 class="m-0">#get_nb_all.nb_candidat# / #get_nb_all.nb_code#</h4>
								</span>
								<span class="badge btn-outline-primary p-2 mx-2">
									CERT.<br>ATTENTE ENVOI<br><h4 class="m-0">#get_nb_all.nb_wait#</h4>
								</span>
								<span class="badge btn-outline-primary p-2 mx-2">
									CERT.<br>ATTENTE PASSAGE<br><h4 class="m-0">#get_nb_all.nb_code_sent#</h4>
								</span>
								<span class="badge btn-outline-primary p-2 mx-2">
									CERT.<br>R&Eacute;ALIS&Eacute;ES<br><h4 class="m-0">#get_nb_all.nb_certif_sent#</h4>
								</span>
								<span class="badge btn-outline-primary p-2 mx-2">
									CERT.<br>NON VALIDES<br><h4 class="m-0">#get_nb_all.nb_nr#</h4>
								</span>
								<a class="badge btn-outline-primary p-2 mx-2">
									CERT.<br>NON PASS&Eacute;ES<br><h4 class="m-0">#get_nb_all.nb_nu#</h4>
								</a>
								<a class="badge btn-outline-primary p-2 mx-2">
									CERT. BUSINESS<br>NON ATTRIBU&Eacute;ES<br><h4 class="m-0">#get_token_business_left.nb#</h4>
								</a>
								<a class="badge btn-outline-primary p-2 mx-2">
									CERT. GENERAL<br>NON ATTRIBU&Eacute;ES<br><h4 class="m-0">#get_token_general_left.nb#</h4>
								</a>
							</div>
							</cfoutput>
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-md-6">
                    <div class="card border">
						<div class="card-body">
							<h6 class="text-red">Actions globales</h6>
                    
							<cfoutput>
								<a type="button" class="new_session btn btn-sm btn-info p-2 m-0">
									<i class="far fa-plus-circle fa-lg"></i> Créer Session
								</a>
								
								<cfif isdefined("a_id") AND a_id neq "" AND a_id neq 0>
									<a href="exporter/export_session_school.cfm?a_id=#a_id#" class="btn btn-sm btn-info p-2 m-0">
										<i class="fal fa-download fa-lg"></i> Exporter Résultats
									</a>
								</cfif>
									
							</cfoutput>
						</div>
					</div>
                                
                </div>

				<div class="col-md-6">
                    <div class="card border">
						<div class="card-body">
							<h6 class="text-red">Déployer une certification</h6>
                    
							<cfoutput>
								
								<cfif isdefined("a_id") AND a_id neq "" AND a_id neq 0>
									
									<a href="exporter/export_session_template.cfm?a_id=#a_id#" class="btn btn-sm btn-info p-2 m-0">
										<i class="fal fa-file-excel fa-lg"></i> Télécharger Modèle création
									</a>

									<form class="form_upload_user d-inline m-0" name="form_upload_user">
										<label for="doc_upload_user" class="btn btn-sm btn-info p-2 m-0" style="cursor: pointer; color:white !important;">
											<i class="fal fa-upload fa-lg"></i> Importer Modèle création
											<i id="loading_user" class="fas fa-spinner fa-spin fa-2x text-white collapse"></i>
										</label>
										<input type="hidden" name="a_id" value="<cfoutput>#a_id#</cfoutput>">
										<input type="file" id="doc_upload_user" class="upload_user" name="doc_attach" accept=".xlsx,.xls" style="display:none">
									</form>
								</cfif>
							</cfoutput>
						</div>
					</div>
                                
                </div>
                
            </div>


			<div class="row">
				<cfif get_account.recordCount GT 0>
				<div class="col-md-12">
					<div class="card border">
						<div class="card-body">
							<div class="row">
								<div class="col-md-6">
									<h6 class="text-red">Composantes</h6>
									<cfoutput>
									<select class="form-control" onchange="document.location.href='?&tss_id=#tss_id#&g_id=#g_id#&a_id='+$(this).val()">
										<cfloop query="get_account">
											<option value="#account_id#" <cfif a_id eq account_id>selected="true"</cfif>>#account_name#</option>
										</cfloop>
									</select>
									</cfoutput>
								</div>

								<div class="col-md-6">
									<h6 class="text-red">Sessions</h6>
					
									<cfoutput>
									<a class="btn btn-sm btn-outline-primary my-0 <cfif tss_id eq "ALL">btn-primary active</cfif>" href="?a_id=#a_id#&tss_id=ALL&g_id=#g_id#">
										TOUTES<br><i class="fa-thin fa-users fa-lg"></i>
									</a>
									<a class="btn btn-sm btn-outline-primary my-0 <cfif tss_id eq "WAITING">btn-primary active</cfif>" href="?a_id=#a_id#&tss_id=WAITING&g_id=#g_id#">
										EN ATTENTE<br><i class="fa-thin fa-hourglass fa-lg"></i>
									</a>
									<a class="btn btn-sm btn-outline-success my-0 <cfif tss_id eq "SENT">active</cfif>" href="?a_id=#a_id#&tss_id=SENT&g_id=#g_id#">
										EN COURS<br><i class="fa-light fa-paper-plane fa-lg"></i>
									</a>
									<a class="btn btn-sm btn-outline-danger my-0 <cfif tss_id eq "CLOSE">active</cfif>" href="?a_id=#a_id#&tss_id=CLOSE&g_id=#g_id#">
										FINALIS&Eacute;ES<br><i class="fa-light fa-flag-checkered fa-lg"></i>
									</a>
									</cfoutput>
								</div>


							</div>
						</div>
					</div>
				</div>
				
				</cfif>
			</div>

			</cfif>
			
			
			<div class="alert alert-success collapse" id="message_email_ok">
				Les emails ont correctement été envoyés.
			</div>	


			<cfif view eq "calendar" AND token_list eq "">
				<div class="card">
					<div class="card-body">
						<h6 class="text-red">Calendrier</h6><br>
						<div id="calendar"></div> 
					</div> 
				</div>
			</cfif>
	
			<cfif ts_id neq "0" OR token_list neq "">
				<div align="center"><a class="btn btn-info" href="<cfoutput>#CGI.HTTP_REFERER#</cfoutput>">retour</a></div>
			</cfif>

			<div class="row mt-2">
				<div class="col-md-12">
					<div class="card border">
						<div class="card-body">

						<cfif token_list eq "" AND ts_id eq "0" AND (tss_id neq "0" OR a_id neq "0")>
								
							<h6 class="text-red">Liste sessions</h6>
							<table class="table table-sm bg-white mt-3">
								<tr class="bg-light">
									<th>
										ID	
									</th>
									<th>
										Status	
									</th>
									<th>
										Method	
									</th>
									<th>
										Type	
									</th>
									<th>
										<!--- Account	 --->
										Composante
									</th>
									<th>
										Session	
									</th>
									<th>
										<!--- Candidats	 --->
										Cert.
									</th>
									<th>
										Répartition	
									</th>
									<th>
										Début	
									</th>
									<th>
										Fin	
									</th>
									<th>
										Action
									</th>
								</tr>
								<cfoutput query="get_certif_session">
								<tr>
									<td>
										#token_session_id#
									</td>
									<td>
										<span class="badge <cfif token_session_status eq "WAITING">badge-info<cfelseif token_session_status eq "SENT">badge-success<cfelseif token_session_status eq "CLOSE">badge-danger</cfif>">#token_session_status#</span>
									</td>
									<td>
										<span class="badge <cfif token_session_method eq "DISTANCIEL">badge-warning<cfelse>badge-secondary</cfif>">#token_session_method#</span>
									</td>
									<td>
										<span class="badge <cfif token_session_certif_type eq "GENERAL">badge-info<cfelse>badge-danger</cfif>">#token_session_certif_type#</span>
									</td>
									<td>
										<small><strong>#account_name#</strong></small>
									</td>
									<td>
										<small><strong><a href="?ts_id=#token_session_id#&tss_id=#tss_id#" title="#token_session_name#">#mid(token_session_name,1,35)#</a></strong></small>
									</td>
									<td>
										#nb#
									</td>
									<td>
										<span class="badge badge-pill <cfif nb_wait neq "0">badge-info<cfelse>border border-info</cfif> p-1" style="width:40px"><i class="fas fa-hourglass-half"></i> #nb_wait# </span>
										<span class="badge badge-pill <cfif nb_code_sent neq "0">badge-warning text-white<cfelse>border border-warning</cfif> p-1" style="width:40px"><i class="far fa-paper-plane"></i> #nb_code_sent# </span>
										<span class="badge badge-pill <cfif nb_certif_sent neq "0">badge-success<cfelse>border border-success</cfif> p-1" style="width:40px"><i class="far fa-thumbs-up"></i> #nb_certif_sent#  </span>
										<span class="badge badge-pill <cfif nb_nr neq "0">badge-danger<cfelse>border border-danger</cfif> p-1" style="width:40px"><i class="far fa-thumbs-down"></i> #nb_nr# </span>
									</td>
									<td>
										<cfif isdate(token_session_start)>
											<cfif token_session_start lte dateadd('d','7',now()) AND token_session_start gte now()>
												<i class="fa-solid fa-diamond-exclamation text-danger"></i>
											</cfif>
											#dateformat(token_session_start,"dd/mm/yyyy")#
										</cfif>
									</td>
									<td>
										<cfif isdate(token_session_end)>
											<cfif token_session_end lte now()>
												<i class="fa-solid fa-diamond-exclamation text-danger"></i>
											</cfif>
											#dateformat(token_session_end,"dd/mm/yyyy")#
										</cfif>
									</td>
									<td align="center">
										<a type="button" id="up_session_#token_session_id#" class="up_session btn btn-sm btn-info"><i class="far fa-edit"></i></a>
										<a href="?ts_id=#token_session_id#&tss_id=#tss_id#" class="btn btn-info btn-sm"><i class="fa-light fa-eye"></i></a>
									</td>
								</tr>

								</cfoutput>
							</table>

						<cfelseif ts_id neq "0" OR token_list neq "">

							<h6 class="text-red"><cfoutput>#get_certif_session.token_session_name#</cfoutput></h6>
							<hr>
							<div class="row">
								<div class="col-md-9">
									<input type="button" class="btn btn-sm btn-info" id="new_token_user" value="Nouveau candidat">
									<input type="button" class="btn btn-sm btn-info" id="send_mail" value="Envoyer Email CODE ENTRY">
									<!--- <input type="button" class="btn btn-sm btn-info" id="send_technic_reminder" value="Send TECHNIC">
									<input type="button" class="btn btn-sm btn-info" id="send_deadline_approach" value="Send DEADLINE APPROACH">
									<input type="button" class="btn btn-sm btn-info" id="send_deadline_outdated_delay" value="Send DEADLINE OUTDATED + DELAY">
									<input type="button" class="btn btn-sm btn-info" id="send_regenerate_token" value="Send REGENERATE TOKEN"> --->
									<!--- <input type="button" class="btn btn-sm btn-warning" id="regenerate_token" value="Regenerate Token"> --->
									<cfoutput>
										<a href="exporter/export_session_school.cfm?ts_id=#ts_id#" class="btn btn-sm btn-warning">
											<i class="fad fa-download"></i> #obj_translater.get_translate("btn_export")#
										</a>
									</cfoutput>
								</div>
								<div class="col-md-3">
									<input id="myInput" type="text" class="form-control" placeholder="Search..">
								</div>
							</div>
							
							<table id="table_token" class="table table-sm bg-white">
								<tr class="bg-light">
									<th>
										<input type="checkbox" id="check_all">
									</th>
									<th class="th_sortable">
										Code_id
									</th>
									<th>
										Session
									</th>
									<th class="th_sortable">
										Nom	
									</th>
									<th class="th_sortable">
										Prénom	
									</th>
									<th class="th_sortable">
										Login	
									</th>
									<th class="th_sortable">
										Statut
									</th>
									<th class="th_sortable">
										Code entry	
									</th>
									<th class="th_sortable">
										Envoyé
									</th>
									<th class="th_sortable">
										Début
									</th>
									<th class="th_sortable">
										Fin
									</th>
									<th>
										Passage
									</th>
									<th class="th_sortable">
										Niveau
									</th>
									<th>
										Voir
									</th>
								</tr>
								<cfoutput query="get_token_attributed">
								<tr <cfif _token_code eq token_code>style="background: ##93ff86;"</cfif>>
									<td class="user_line" data-uid='#token_id#'>
										<input type="checkbox"  data-uid='#token_id#' id="check_#token_id#" class="user_checkbox" style="pointer-events: none;">
									</td>
									<td class="user_line" data-uid='#token_id#' data-name='#token_id#'>
										#token_id#
									</td>
									<td>
										<small>#token_session_name#</small>
									</td>
									<td>
										<a href="common_learner_account.cfm?u_id=#user_id#">#ucase(user_name)#</a>
									</td>
									<td>
										<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname#</a>						
									</td>
									<td>
										#token_login#						
									</td>
									<td>
										<span class="badge badge-pill badge-#token_status_css# p-1">#token_status_name# </span>
									</td>
									<td>
										<small>#token_code#</small>
									</td>
									<td>
										<small>
										<cfif token_send neq "">
										#dateformat(token_send,'dd/mm/yyyy')#
										<cfelse>
										-
										</cfif>
										</small>
									</td>
									<td>
										<small>
										<cfif token_start neq "">
										#dateformat(token_start,'dd/mm/yyyy')#
										<cfelse>
										-
										</cfif>
										</small>
									</td>
									<td>
										<small>
										<cfif token_end neq "">
										#dateformat(token_end,'dd/mm/yyyy')#
										<cfelse>
										-
										</cfif>
										</small>
									</td>

									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

										<td>
											<small>
											<cfif token_status_id eq "3">
												#dateformat(token_use,'dd/mm/yyyy')#
											<cfelse>
												
												<div class="controls">
													<div class="input-group">
														<input class="token_used" id="token_used_#token_id#" name="token_used" type="text" class="datepicker form-control" value="#LSdateformat(token_use,'yyyy-mm-dd', 'fr')#" />
														<label for="token_used_#token_id#" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
													</div>
												</div>
											</cfif>
											</small>
										</td>
										<td>
											
											<cfif token_status_id eq "3">
													<span class="badge badge-pill badge-secondary p-2">#token_level# </span>
											<cfelse>
												<select name="" onchange="changeLevel(event, #token_id#)" class="form-control form-control-sm" style="width:120px">
													<option value="">-</option>
													<option value="NR" <cfif token_level eq "NR">selected</cfif>>NR</option>
													<option value="Below A1" <cfif token_level eq "Below A1">selected</cfif>>Below A1</option>
													<option value="A1" <cfif token_level eq "A1">selected</cfif>>A1</option>
													<option value="A2" <cfif token_level eq "A2">selected</cfif>>A2</option>
													<option value="B1" <cfif token_level eq "B1">selected</cfif>>B1</option>
													<option value="B2" <cfif token_level eq "B2">selected</cfif>>B2</option>
													<option value="C1 or above" <cfif token_level eq "C1 or above">selected</cfif>>C1 or above</option>
												</select>
											</cfif>
											
										</td>
										<td>
											<cfif listFindNoCase("2,4", token_status_id)>

											<i id="loading_#token_id#" class="fas fa-spinner fa-spin fa-2x text-success float-left collapse"></i>

											<form class="form_upload_certif" name="form_upload_certif">
													
												<label for="doc_attach_#user_id#" class="form-control form-control-sm m-0" style="cursor: pointer;">
													+ certif
												</label>
												<input type="file" id="doc_attach_#user_id#" class="certif_attach" name="doc_attach" accept=".pdf"
												<!--- data-session='#token_session_id#' --->
												class="form-control" style="display:none">
												<!--- onchange="form.submit()" --->
						
												<input type="hidden" name="a_id" value="#a_id#">
												<input type="hidden" name="u_id" value="#user_id#">
												<input type="hidden" name="t_id" value="#token_id#">

												<!--- <input type="submit" class="btn btn-info btn-sm" value="upload"> --->
							
											</form>
											<cfelseif token_status_id eq "3">
												<cfif fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#token_id#.pdf")>
													<a href="#SESSION.BO_ROOT_URL#/admin/cert/#user_id#/#token_id#.pdf" target="_blank" class="btn btn-sm btn-success"><i class="fa-light fa-file-pdf"></i></a>
												<cfelseif fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#token_code#.pdf")>
													<a href="#SESSION.BO_ROOT_URL#/admin/cert/#user_id#/#token_code#.pdf" target="_blank" class="btn btn-sm btn-success"><i class="fa-light fa-file-pdf"></i></a>
												</cfif>
											</cfif>
										</td>
									<cfelse>
										<td>
											<small><strong>
											<cfif token_status_id eq "3">
												#dateformat(token_use,'dd/mm/yyyy')#
											</cfif>
											</strong></small>
										</td>
										<td>
											
											<cfif token_status_id eq "3">
												<span class="badge badge-pill badge-secondary p-2">#token_level# </span>
											</cfif>
											
										</td>
										<td>
											<cfif token_status_id eq "3">
												<cfif fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#token_id#.pdf")>
													<a href="#SESSION.BO_ROOT_URL#/admin/cert/#user_id#/#token_id#.pdf" target="_blank" class="btn btn-sm btn-success"><i class="fa-light fa-file-pdf"></i></a>
												<cfelseif fileexists("#SESSION.BO_ROOT#/admin/cert/#user_id#/#token_code#.pdf")>
													<a href="#SESSION.BO_ROOT_URL#/admin/cert/#user_id#/#token_code#.pdf" target="_blank" class="btn btn-sm btn-success"><i class="fa-light fa-file-pdf"></i></a>
												</cfif>
											</cfif>
										</td>
									</cfif>
								</tr>

								</cfoutput>
							</table>
							</cfif>	
						</div>
					</div>
				</div>
			</div>


		
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>

function changeLevel(event, id) {
	console.log(event, event.target.value, id)

	$.ajax({				 
		url: './api/token/token_post.cfc?method=update_token_level',
		type: 'POST',
		data: {
				level: event.target.value,
				t_id: id
			},
		success : function(result, status){
			console.log(result);
			// window.location.href = "db_certif_school.cfm?a_id=<cfoutput>#a_id#</cfoutput>&s_id=" + result
		},
		error : function(result, status, erreur){
		},
		complete : function(result, status){
		}	
	});
}

$( document ).ready(function() {

	$('.user_line').click(function(event) {	
		// console.log(event)
		// console.log(event.target.dataset.uid)
		let id = event.target.dataset.uid;

		$('#check_' + id).prop( "checked", !$('#check_' + id).prop('checked') );

	});

	$('#check_all').click(function(event) {	
		// console.log(event)
		// console.log(event.target.dataset.uid)

		$('input:checkbox').not(this).prop('checked', this.checked);
	});

	$("#token_session_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			token_session_start = $('#token_session_start').datepicker("getDate");
			token_session_start = moment(token_session_start).format('YYYY-MM-DD');
		}	
	})

	$("#token_session_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			token_session_end = $('#token_session_end').datepicker("getDate");
			token_session_end = moment(token_session_end).format('YYYY-MM-DD');
		}	
	})


	$("#myInput").on("keyup", function() {
		var value = $(this).val().toLowerCase();
		$("#table_token tr").filter(function() {
			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		});
	});

	$('.th_sortable').click(function(){
		var table = $(this).parents('table').eq(0)
		var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
		this.asc = !this.asc
		if (!this.asc){
			rows = rows.reverse()
		}
		for (var i = 0; i < rows.length; i++){table.append(rows[i])}
	})
	
	function comparer(index) {
		return function(a, b) {
			// let _a = $(a).children('td').eq(index)[0].dataset.name;
			// let _b = $(b).children('td').eq(index)[0].dataset.name;

			let _a = $(a).children('td').eq(index).text();
			let _b = $(b).children('td').eq(index).text();

			return $.isNumeric(_a) && $.isNumeric(_b) ? _a - _b : _a.toString().localeCompare(_b)
		}
	}

	$(".new_session").click(function(event) {	
		event.preventDefault();		

		// console.log(ts_id)
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Session");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_school_session_edit.cfm", function() {});
	});

	$("#new_token_user").click(function(event) {	
		event.preventDefault();		

		// console.log(ts_id)
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Candidat");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_school_user_edit.cfm?ts_id=<cfoutput>#ts_id#</cfoutput>", function() {});
	});
	
	$('.up_session').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var ts_id = idtemp[2];

		// console.log(ts_id)
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Session - " + ts_id);
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_school_session_edit.cfm?ts_id="+ts_id, function() {});
	});


	<cfif view eq "calendar">
		var avail_choice = "remove";
		var currentTimezone = "UTC";
		$('#calendar').fullCalendar({

		/**************COMMON****************/
		/*schedulerLicenseKey: '0542611006-fcs-1459164489',*/
		/*themeSystem: 'bootstrap4',*/
		/*nowIndicator:true,*/
		/*eventConstraint: "blocker",*/


		schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
		defaultDate: '<cfoutput>#dateformat(now(),"yyyy-mm-dd")#</cfoutput>',	
		timeFormat: 'H:mm',
		hiddenDays: [0,6],
		lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
		axisFormat: 'HH:mm',
		allDaySlot: true,	
		defaultEventMinutes:15,
		timezone: currentTimezone,
		defaultView: 'month',
		selectHelper: false,	
		firstDay: 1,
		minTime: '06:00:00',
		maxTime: '23:00:00',
		slotDuration: '00:15:00',
		navLinks: true,
		editable: false,
		eventStartEditable: false,
		eventResizableFromStart: false,
		eventDurationEditable: false,
		droppable: false,
		aspectRatio: 3,
		height:450,
		eventOrder:["task_group_alias"],

			
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month'
		},		

		eventOrder:'title',

		/**************SOURCE****************/	
		// eventSources: [],		
		events: [
			<cfoutput query="get_certif_all">
				<cfif CurrentRow GT 1>,</cfif>{
					title: '#REReplace(token_session_name,"['\n']","","all")#',
					start: '#token_session_start#',
					allDay : true,
					color: '##2BA9CD',
					session_id : '#token_session_id#'
				},
				{
					title: '#REReplace(token_session_name,"['\n']","","all")#',
					start: '#token_session_end#',
					allDay : true,
					color: '##44C47D',
					session_id : '#token_session_id#'
				}
			</cfoutput>
		],
		
		eventClick: function(event) {

			window.location.href = "db_certif_school_2.cfm?ts_id=" + event.session_id + "&tss_id=WAITING"

		}

		});
	</cfif>


	$(".token_used").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( dateText,inst ) {
			// console.log(dateText,inst);

			var idtemp = inst.id.split("_");
			var _id = idtemp[2];

			// console.log(_id, dateText)
			$.ajax({				 
				url: './api/token/token_post.cfc?method=update_token_used',
				type: 'POST',
				data: {
						date: dateText,
						t_id: _id
					},
				success : function(result, status){
					// console.log(result);
					// window.location.href = "db_certif_school.cfm?a_id=<cfoutput>#a_id#</cfoutput>&s_id=" + result
				},
				error : function(result, status, erreur){
				},
				complete : function(result, status){
				}	
			});
			// token_session_start = $('#token_session_start').datepicker("getDate");
			// token_session_start = moment(token_session_start).format('YYYY-MM-DD');
		}	
	})


	$("#send_mail").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$.ajax({
			url: './api/token/token_post.cfc?method=send_token',
			type: 'POST',
			data : {
				token_list:token_list, 
				a_id:<cfoutput>#a_id#</cfoutput>, 
				s_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				// console.log(result);
				$("#message_email_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});



	$("#send_technic_reminder").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$.ajax({
			url: './api/token/token_post.cfc?method=send_technic_reminder',
			type: 'POST',
			data : {
				token_list:token_list, 
				a_id:<cfoutput>#a_id#</cfoutput>, 
				s_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				// console.log(result);
				$("#message_email_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});
	

	<!--- $("#export_session").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		console.log(token_list);

		$.ajax({
			url: './api/school/school_post.cfc?method=export_school_session',
			type: 'POST',
			data : {
				ts_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				console.log(result);
				// $("#message_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});--->


	$("#send_deadline_approach").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$.ajax({
			url: './api/token/token_post.cfc?method=send_deadline_approach',
			type: 'POST',
			data : {
				token_list:token_list, 
				a_id:<cfoutput>#a_id#</cfoutput>, 
				s_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				console.log(result);
				$("#message_email_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

	$("#send_deadline_outdated_delay").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$.ajax({
			url: './api/token/token_post.cfc?method=send_deadline_outdated_delay',
			type: 'POST',
			data : {
				token_list:token_list, 
				a_id:<cfoutput>#a_id#</cfoutput>, 
				s_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				console.log(result);
				$("#message_email_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});


	
	$("#send_regenerate_token").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$.ajax({
			url: './api/token/token_post.cfc?method=send_regenerate_token',
			type: 'POST',
			data : {
				token_list:token_list, 
				a_id:<cfoutput>#a_id#</cfoutput>, 
				s_id:<cfoutput>#ts_id#</cfoutput>
			},
			success : function(result, status){
				console.log(result);
				$("#message_email_ok").collapse('show');
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});



	$("#form_token_session").submit(function( event ) {
		event.preventDefault();

		$.ajax({				 
			url: './api/token/token_post.cfc?method=insert_token_session',
			type: 'POST',
			data: $(event.target).serialize(),
			success : function(result, status){
				// console.log(result);
				window.location.href = "db_certif_school_2.cfm?ts_id=" + result
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});

	});


	$('.btn_create_token').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Send Token Anywhere");
		$('#modal_body_lg').load("modal_window_token.cfm?action=create&t_id="+t_id, function() {});

	});


	$('.upload_user').change(function(event) {	
		event.preventDefault();

		var fd = new FormData(event.target.form);

		$("#loading_user").collapse("show");

		$.ajax({
			url        : './api/school/school_post.cfc?method=upload_user',
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

				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Uploaded percent', percentComplete );
					}
				}, false );

				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
				console.log("Ok sent", data)
				// window.location.reload(true);
				window.location.href = "db_certif_school_2.cfm?doc_success=1"
			}
		});
	});

	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	$("#regenerate_token").click(function( event ) {
		event.preventDefault();
		
		var token_list = [];
		$.each($("input[class='user_checkbox']:checked"), function(){
			token_list.push($(this)[0].dataset.uid);
		});

		// console.log(token_list);

		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Token");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_school_r_token.cfm?token_list="+token_list, function() {});

	});


	$('.token_attach').change(function(event) {	
		event.preventDefault();

		var fd = new FormData(event.target.form);

		$("#loading_xlsx").collapse("show");

		$.ajax({
			url        : './api/token/token_post.cfc?method=upload_token_batch_cambridge',
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

				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Uploaded percent', percentComplete );
					}
				}, false );

				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
				console.log("Ok sent", data)
				<cfif SESSION.USER_ID neq 202>
					window.location.href = "db_certif_school_2.cfm?token_list_show=1"
				</cfif>
			}
		});
	});



	$('.certif_batch').change(function(event) {	
		event.preventDefault();

		var fd = new FormData(event.target.form);

		// console.log(fd);

		$("#loading_pdf").collapse("show");

		$.ajax({
			url        : './api/token/token_post.cfc?method=upload_certif_batch',
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
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Uploaded percent', percentComplete );
					}
				}, false );

				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
				console.log("ok", data)
				$("#message_ok").collapse('show');
				$("#loading_pdf").collapse("hide");
			}
		});
	});


	$('.certif_attach').change(function(event) {
		
		event.preventDefault();

		var fd = new FormData(event.target.form);

		var t_id = fd.get('t_id');

		$("#loading_"+t_id).collapse("show");

		$.ajax({
			url        : './api/token/token_post.cfc?method=upload_certif_user',
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
				console.log("ok");
				window.location.reload(true);

				
				// const obj = JSON.parse(data);
				// console.log("yeah", obj)

			}
		});
	});

	$.typeahead({
		input: '.js_typeahead_token',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',
		/*matcher: function(item) {
			return true
		}*/

		source: {
			
			display:"learner_name",
			href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/db_certif_school_2.cfm?token_code={{token_code}}",
			data: [
				<cfoutput query="get_token_search" group="user_id">{
					"user_id": #user_id#,
					"learner_name": "#learner_name#<br>**#replacenocase(status_name,"+","","ALL")#** - #REReplace(token_code,"[^0-9A-Za-z -]","","all")# <cfif user_phone neq ""><br> - [#replacenocase(user_phone,"+","","ALL")#]</cfif>",
					"token_code": "#REReplace(token_code,"[^0-9A-Za-z -]","","all")#"
				},
				</cfoutput>				
			]
		},
		callback: { }
	});

	</cfif>


});
</script>

</body>
</html>