
<!DOCTYPE html>

<cfsilent>

	<cfset secure = "8,11">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfparam name="a_id" default="0">
	<cfparam name="token_code" default="0">
	<cfparam name="token_list_show" default="0">
	<cfparam name="ts_id" default="0">
	<cfparam name="tss_id" default="SENT">

    <cfset _token_code = token_code>
    <cfset _account_right = "">

    <cfif isDefined("SESSION.USER_ACCOUNT_RIGHT_ID") AND SESSION.USER_ACCOUNT_RIGHT_ID neq "">
        <cfset _account_right = SESSION.USER_ACCOUNT_RIGHT_ID>
    <cfelse>
        <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
            SELECT account_id
            FROM lms_list_token_session
            WHERE token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_SESSION_RIGHT_ID#" list="true">)
        </cfquery>

        <cfloop query="get_session">
            <cfset _account_right = listAppend(_account_right,account_id) >
        </cfloop>
    </cfif>

    <!--- <cfdump var="#_account_right#"> --->

    <cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
    SELECT ag.group_name, a.account_name, a.account_id, COUNT(u.user_id) AS nb
    FROM account a 
    INNER JOIN account_group ag ON ag.group_id = a.group_id 
    INNER JOIN user u ON u.account_id = a.account_id 
    WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
    GROUP BY a.account_id
    </cfquery>

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
        WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
        <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
            AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_SESSION_RIGHT_ID#" list="true">)
        </cfif>
        <cfif isdefined("a_id") AND a_id neq "0">
            AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
        </cfif>
    </cfquery>


    <cfif _token_code neq "0">
        <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
            SELECT token_id, token_session_id FROM lms_list_token WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_token_code#">
        </cfquery>
        <cfset ts_id = get_token.token_session_id>
    </cfif>

	<cfquery name="get_certif_all" datasource="#SESSION.BDDSOURCE#">
		SELECT lts.token_session_id, token_session_name, token_session_start, token_session_end, 
		token_session_last_update, token_session_method, token_session_certif_type, token_session_status,
		a.account_name, a.account_id,
        COUNT(lt.user_id) AS nb
		FROM lms_list_token_session lts
		INNER JOIN account a ON a.account_id = lts.account_id
		LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
        WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
        <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
            AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_SESSION_RIGHT_ID#" list="true">)
        </cfif>
		GROUP BY lts.token_session_id
		ORDER BY lts.token_session_id ASC
	</cfquery>

	<cfquery name="get_certif_session" datasource="#SESSION.BDDSOURCE#">
		SELECT lts.token_session_id, token_session_name, token_session_start, token_session_end, 
		token_session_last_update, token_session_method, token_session_certif_type, token_session_status,
		a.account_name, a.account_id,
		COUNT(lt.user_id) AS nb,
		SUM(CASE WHEN lt.token_status_id = '1' THEN 1 ELSE 0 END) AS nb_wait,
		SUM(CASE WHEN lt.token_status_id = '2' THEN 1 ELSE 0 END) AS nb_code_sent,
		SUM(CASE WHEN lt.token_status_id = '3' THEN 1 ELSE 0 END) AS nb_certif_sent,
		SUM(CASE WHEN lt.token_status_id = '4' THEN 1 ELSE 0 END) AS nb_nr,
		SUM(CASE WHEN lt.token_status_id = '5' THEN 1 ELSE 0 END) AS nb_nu

		FROM lms_list_token_session lts
		INNER JOIN account a ON a.account_id = lts.account_id
		LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id
		<!--- WHERE lts.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">--->
		WHERE lts.token_session_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tss_id#">
		<cfif ts_id neq "0">
		AND	lts.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
		</cfif>
        <cfif a_id neq "0">
		AND	a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		</cfif>
        AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
        <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
            AND lts.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_SESSION_RIGHT_ID#" list="true">)
        </cfif>
		GROUP BY lts.token_session_id
		ORDER BY a.account_name, lts.token_session_name ASC
	</cfquery>


	<cfif ts_id neq "0">
		<cfquery name="get_token_attributed" datasource="#SESSION.BDDSOURCE#">
			SELECT 
			lt.token_id, lt.user_id, lt.certif_id, lt.token_creation, lt.token_send, lt.token_code, lt.token_login, lt.token_end, lt.token_status_id, lt.token_use, lt.token_level, lt.token_start,
			ltss.token_session_name,
			lts.token_status_name, lts.token_status_css,
			u.user_id as id, u.user_firstname, u.user_name, u.user_email
			FROM user u
			INNER JOIN lms_list_token lt ON lt.user_id = u.user_id
			LEFT JOIN lms_list_token_session ltss ON ltss.token_session_id = lt.token_session_id
			LEFT JOIN lms_list_token_status lts ON lts.token_status_id = lt.token_status_id
			WHERE lt.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
			ORDER BY 
			<cfif _token_code neq "0">lt.token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_token_code#"> DESC,lt.token_id ASC<cfelse>u.user_name ASC</cfif>
			
		</cfquery>

		<cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
			SELECT token_status_id, token_status_name, token_status_css 
			FROM lms_list_token_status 
			ORDER BY lms_list_token_status.token_status_id ASC
		</cfquery>

        <cfif _token_code neq "0">
            <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                SELECT token_id, token_session_id FROM lms_list_token WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_token_code#">
            </cfquery>
            <cfset ts_id = get_token.token_session_id>
        </cfif>
    </cfif>

    <cfquery name="get_token_search" datasource="#SESSION.BDDSOURCE#">
		SELECT lt.token_code, u.user_id, u.account_id, 
		CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, 
		Replace(Replace(u.user_phone,CHAR(13),' '),CHAR(10), ' ') as user_phone,
		us.user_status_name_#SESSION.LANG_CODE# as status_name
		FROM lms_list_token lt 
		INNER JOIN user u ON u.user_id = lt.user_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
		WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#_account_right#" list="true">)
        <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
            AND lt.token_session_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_SESSION_RIGHT_ID#" list="true">)
        </cfif>
		ORDER BY u.user_id
	</cfquery>

    <cfif a_id eq 0 AND _account_right neq "">
        <cfset a_id = listGetAt(_account_right, 1)>
    </cfif>

    <cfquery name="get_token_left" datasource="#SESSION.BDDSOURCE#">
        SELECT llt.token_id, COUNT(*) as nb
        FROM lms_list_token llt
        INNER JOIN account a ON llt.group_id = a.group_id 
        WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
        AND llt.user_id IS NULL
    </cfquery>


</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

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
      
		<cfset title_page = "Gestion Certification - <cfoutput>#SESSION.GROUP_NAME#</cfoutput>">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">			
		
            

            <div class="row">
                <div class="col-md-12">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6>Aperçu activité</h6>
                                    
                                    <cfoutput>
                                    <span class="badge btn-primary p-2">
                                        CANDIDATS<br> / CODES <br><h4 class="m-0">#get_nb_all.nb_candidat# / #get_nb_all.nb_code#</h4>
                                    </span>
                                    <span class="badge btn-success p-2">
                                        CERT.<br>ATTENTE ENVOI<br><h4 class="m-0"><cfif get_nb_all.nb_wait neq "">#get_nb_all.nb_wait#<cfelse>0</cfif></h4>
                                    </span>
                                    <span class="badge btn-primary p-2">
                                        CERT.<br>ATTENTE PASSAGE<br><h4 class="m-0"><cfif get_nb_all.nb_wait neq "">#get_nb_all.nb_code_sent#<cfelse>0</cfif></h4>
                                    </span>
                                    <span class="badge btn-primary p-2">
                                        CERT.<br>R&Eacute;ALIS&Eacute;ES<br><h4 class="m-0"><cfif get_nb_all.nb_wait neq "">#get_nb_all.nb_certif_sent#<cfelse>0</cfif></h4>
                                    </span>
                                    <span class="badge btn-primary p-2">
                                        CERT.<br>NON VALIDES<br><h4 class="m-0"><cfif get_nb_all.nb_wait neq "">#get_nb_all.nb_nr#<cfelse>0</cfif></h4>
                                    </span>
                                    <a class="badge btn-primary p-2">
                                        CERT.<br>NON PASS&Eacute;ES<br><h4 class="m-0"><cfif get_nb_all.nb_wait neq "">#get_nb_all.nb_nu#<cfelse>0</cfif></h4>
                                    </a>
                                    <a class="badge btn-outline-primary p-2">
                                        CERT.<br>NON ATTRIBU&Eacute;ES<br><h4 class="m-0">#get_token_left.nb#</h4>
                                    </a>
                                    
                                    <cfif isdefined("a_id")>
                                        <a href="exporter/export_session_school.cfm?a_id=#a_id#" class="badge btn-info p-2">
                                            #ucase(obj_translater.get_translate("btn_export"))#<br><br><h4 class="m-0"><i class="fal fa-download"></i></h4>
                                        </a>
                                    </cfif>
                                    </cfoutput>
                                </div>
                                <div class="col-md-4">
                                    <h6>Sessions</h6>
                    
                                    <cfoutput>
                                    <a class="btn btn-sm p-1 m-1 btn-outline-primary <cfif tss_id eq "WAITING">btn-primary active</cfif>" href="?a_id=#a_id#&tss_id=WAITING">
                                        EN ATTENTE<br><i class="fa-thin fa-hourglass fa-lg"></i>
                                    </a>
                                    <a class="btn btn-sm p-1 m-1 btn-outline-success <cfif tss_id eq "SENT">active</cfif>" href="?a_id=#a_id#&tss_id=SENT">
                                        EN COURS<br><i class="fa-light fa-paper-plane fa-lg"></i>
                                    </a>
                                    <a class="btn btn-sm p-1 m-1 btn-outline-danger <cfif tss_id eq "CLOSE">active</cfif>" href="?a_id=#a_id#&tss_id=CLOSE">
                                        FINALIS&Eacute;ES<br><i class="fa-light fa-flag-checkered fa-lg"></i>
                                    </a>
                                    <a class="btn btn-sm p-1 m-1 btn-outline-info <cfif tss_id eq "EXTERNAL">active</cfif>" href="?a_id=#a_id#&tss_id=EXTERNAL">
                                        EXTERNES<br><i class="fa-light fa-cart-shopping fa-lg"></i>
                                    </a>
                                    </cfoutput>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                
            </div>

            



            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h6>Composantes</h6>

                            <cfoutput query="get_account">
                            <a class="btn btn-sm btn-outline-info <cfif a_id eq account_id>active</cfif>" href="?a_id=#account_id#&tss_id=#tss_id#">
                                #account_name#<!---<br>(#nb#)--->
                            </a>
                            </cfoutput>
                        </div>
                    </div>

                </div>
                

            </div>
            


            <cfif ts_id eq "0" AND tss_id eq "0" AND a_id eq "0">
            <div class="card">
                <div class="card-body">
                    <h6>Calendrier</h6><br>
                    <div id="calendar"></div> 
                </div> 
            </div>
            </cfif>


            <cfif ts_id eq "0" AND (tss_id neq "0" OR a_id neq "0")>

                <div class="row mt-1">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <table class="table table-sm bg-white">
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
                                            Composante	
                                        </th>
                                        <th>
                                            Session	
                                        </th>
                                        <th>
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
                                            Voir	
                                        </th>
                                    </tr>
                                    <cfoutput query="get_certif_session">
                                    <tr>
                                        <td>
                                            #token_session_id#
                                        </td>
                                        <td>
                                            <span class="badge <cfif token_session_status eq "WAITING">badge-info<cfelseif token_session_status eq "SENT">badge-success</cfif>">#token_session_status#</span>
                                        </td>
                                        <td>
                                            <span class="badge <cfif token_session_method eq "DISTANCIEL">badge-warning<cfelse>badge-secondary</cfif>">#token_session_method#</span>
                                        </td>
                                        <td>
                                            <span class="badge <cfif token_session_certif_type eq "GENERAL">badge-info<cfelse>badge-danger</cfif>">#token_session_certif_type#</span>
                                        </td>
                                        <td>
                                            #account_name#
                                        </td>
                                        <td>
                                            <a href="?ts_id=#token_session_id#&tss_id=#tss_id#" title="#token_session_name#" class="text-dark">#mid(token_session_name,1,35)#</a>
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
                                                <!--- <cfif token_session_start lte dateadd('d','7',now())>
                                                    <i class="fa-solid fa-diamond-exclamation text-danger"></i>
                                                </cfif> --->
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
                                        <td>
                                            <a href="?ts_id=#token_session_id#&tss_id=#tss_id#" class="btn btn-info btn-sm"><i class="fa-light fa-eye"></i></a>
                                        </td>
                                    </tr>

                                    </cfoutput>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            
            <cfelseif ts_id neq "0">

            <div class="row">
                <div class="col-md-10">
                </div>
                <div class="col-md-2">
                    <cfoutput>
                        <a href="exporter/export_session_school.cfm?ts_id=#ts_id#" class="btn btn-info" style="font-size:11px">
                            <i class="fad fa-download"></i> #obj_translater.get_translate("btn_export")#
                        </a>
                    </cfoutput>
                </div>
            </div>

            <table id="table_token" class="table table-sm bg-white">
                <tr class="bg-light">
                    <!--- <th>
                        <input type="checkbox" id="check_all">
                    </th> --->
                    <th class="th_sortable">
                        User id
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
                        Email	
                    </th>
                    <th id="sort_status_table">
                        Statut
                    </th>
                    <th class="th_sortable">
                        Code entry	
                    </th>
                    <th class="th_sortable">
                        Envoyé
                    </th>
                    <!--- <th class="th_sortable">
                        Start
                    </th>
                    <th class="th_sortable">
                        End
                    </th> --->
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
                    <!--- <td class="user_line" data-uid='#token_id#'>
                        <input type="checkbox"  data-uid='#token_id#' id="check_#token_id#" class="user_checkbox" style="pointer-events: none;">
                    </td> --->
                    <td class="user_line" data-uid='#token_id#' data-name='#token_id#'>
                        #user_id#
                    </td>
                    <td>
                        <small><strong>#token_session_name#</strong></small>
                    </td>
                    <td>
                        #ucase(user_name)#
                    </td>
                    <td>
                        #user_firstname#
                    </td>
                    <td>
                        #user_email#						
                    </td>
                    <td>
                        <span class="badge badge-pill badge-#token_status_css# p-1">#token_status_name# </span>
                    </td>
                    <td>
                        <small><strong>#token_code#</strong></small>
                    </td>
                    <td>
                        <small><strong>
                        <cfif token_send neq "">
                        #dateformat(token_send,'dd/mm/yyyy')#
                        <cfelse>
                        -
                        </cfif>
                        </strong></small>
                    </td>
                    <!--- <td>
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
                    </td> --->
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
                </tr>

                </cfoutput>
            </table>
            </cfif>

			
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>


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
				title: '#REReplace(token_session_name,"['\n']","","all")# [#nb#]',
				start: '#token_session_start#',
				allDay : true,
                color: '##2BA9CD',
                eventTextColor: '##FFFFFF',
                ts_id:#token_session_id#
			},
			{
				title: '#REReplace(token_session_name,"['\n']","","all")# [#nb#]',
				start: '#token_session_end#',
				allDay : true,
				color: '##ef8157',
                eventTextColor: '##FFFFFF',
                ts_id:#token_session_id#
			}
		</cfoutput>
	],
	
	eventClick: function(event) {
       document.location.href="index.cfm?ts_id="+event["ts_id"];
		//console.log(event["ts_id"])

	}

	});

});
</script>

</body>
</html>