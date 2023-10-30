<!DOCTYPE html>

<cfsilent>

<cfparam name="view" default="details"> 

<cfinvoke component="api/tp/tp_get" method="oget_tp" returnvariable="get_tp">
    <cfinvokeargument name="t_id" value="#tp_id#">
</cfinvoke>

<cfinvoke component="api/tp/tp_get" method="oget_session" returnvariable="get_session_past">
	<cfinvokeargument name="t_id" value="#tp_id#">
	<cfinvokeargument name="status" value="past">
</cfinvoke>

<cfinvoke component="api/tp/tp_get" method="oget_session" returnvariable="get_session_incoming">
	<cfinvokeargument name="t_id" value="#tp_id#">
	<cfinvokeargument name="status" value="incoming">
</cfinvoke>

<cfinvoke component="api/tp/tp_get" method="oget_tp_trainer" returnvariable="get_tp_trainer">
	<cfinvokeargument name="t_id" value="#tp_id#">
</cfinvoke>


<cfset __lesson = obj_translater.get_translate('lesson')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __with = obj_translater.get_translate('with')>
<cfset __min = obj_translater.get_translate('short_minute')>
<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfset __card_tp_description = obj_translater.get_translate('card_tp_description')>
<cfset __card_tp_lessonnote = obj_translater.get_translate('card_tp_lessonnote')>
<cfset __card_tp_exercice = obj_translater.get_translate('card_tp_exercice')>
<cfset __card_tp_note = obj_translater.get_translate('card_tp_note')>

<cfset __modal_supports = obj_translater.get_translate('modal_supports')>
<cfset __modal_link_ws = obj_translater.get_translate('modal_link_ws')>
<cfset __modal_link_wsk = obj_translater.get_translate('modal_link_wsk')>
<cfset __modal_link_video = obj_translater.get_translate('modal_link_video')>
<cfset __modal_link_audio = obj_translater.get_translate('modal_link_audio')>

<cfset __tab_vc_incoming = obj_translater.get_translate('tab_vc_incoming')>
<cfset __tab_vc_replay = obj_translater.get_translate('tab_vc_replay')>
<cfset __tab_vc_series = obj_translater.get_translate('tab_vc_series')>

<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
<cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>
<cfset __btn_not_scheduled = obj_translater.get_translate('global_not_scheduled')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset __btn_note = obj_translater.get_translate('btn_note')>
<cfset __btn_remaining_seats = obj_translater.get_translate('vc_btn_remaining_seats')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
<cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>		

<cfdirectory directory="#SESSION.BO_ROOT#/assets/attachment/" name="dirQuery" action="LIST">

<cfif not isDefined("u_id")>
	<cfset u_id = SESSION.USER_ID>
</cfif>
</cfsilent>


<cfloop query="get_tp">

	<cfif isdefined("k")>

		<cfif k eq "1">	
			<div class="alert bg-light text-dark border border-success mt-2" role="alert">
				<div class="d-flex">
					<div>
						<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
					</div>
					<div class="ms-2">
						<cfoutput>#obj_translater.get_translate('vc_alert_tp_follow')#</cfoutput>
					</div>
				</div>
			</div>

		<cfelseif k eq "2">		

			<div class="alert bg-light text-dark border border-success mt-2" role="alert">
				<div class="d-flex">
					<div>
						<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
					</div>
					<div class="ms-2">
						<cfoutput>#obj_translater.get_translate('vc_alert_tp_unfollow')#</cfoutput>
					</div>
				</div>
			</div>

		</cfif>

	</cfif>

	

	<div class="row mt-3">
		<div class="col-md-12">

			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link <cfif view eq "details">active</cfif>" id="details_tab" data-toggle="tab" data-target="#details" type="button" role="tab" aria-controls="details" <cfif view eq "details">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
						<i class="fa-light fa-memo-circle-info"></i><br>
						<cfoutput>#__tab_vc_series#</cfoutput>
					</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link <cfif view eq "finished">active</cfif>" id="finished_tab" data-toggle="tab" data-target="#finished" type="button" role="tab" aria-controls="finished" <cfif view eq "finished">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
						<i class="fa-light fa-clapperboard-play"></i><br>
						<cfoutput>#__tab_vc_replay#</cfoutput>
					</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link <cfif view eq "incoming">active</cfif>" id="incoming_tab" data-toggle="tab" data-target="#incoming" type="button" role="tab" aria-controls="incoming" <cfif view eq "incoming">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
						<i class="fa-light fa-calendar-alt"></i><br>
						<cfoutput>#__tab_vc_incoming#</cfoutput>
					</button>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane <cfif view eq "details">show active</cfif> pt-3" id="details" role="tabpanel" aria-labelledby="details_tab">

					<cfset view="subscribe">
					<cfinclude template="./incl/incl_tp_header2.cfm">

				</div>
				<div class="tab-pane <cfif view eq "finished">show active</cfif> pt-3" id="finished" role="tabpanel" aria-labelledby="finished_tab">

					<cfoutput query="get_session_past" group="session_id">
						<cfset display_toolbox = "1">
						<cfset display_tab = tp_name>
						<cfset prevent_booking = "1">
						<cfinclude template="./incl/incl_session_container.cfm">
					</cfoutput>
						
				</div>
				<div class="tab-pane <cfif view eq "incoming">show active</cfif> pt-3" id="incoming" role="tabpanel" aria-labelledby="incoming_tab">
					
					<cfoutput query="get_session_incoming" group="session_id">

						<cfif lesson_id neq "">

							<cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
							SELECT COUNT(*) as nb
							FROM lms_lesson2_attendance la 
							LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
							WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
							AND subscribed = 1
							</cfquery>

							<cfif count_participant.nb neq "0">
								<cfset seats_total = tp_max_participants>
								<cfset seats_used = count_participant.nb>
								<cfset seats_remaining = seats_total-seats_used>
							<cfelse>
								<cfset seats_total = tp_max_participants>
								<cfset seats_used = 0>
								<cfset seats_remaining = seats_total>
							</cfif>

						</cfif>

						<cfset display_toolbox = "1">
						<cfset display_tab = tp_name>
						<cfset prevent_booking = "1">
						<cfinclude template="./incl/incl_session_container.cfm">

					</cfoutput>

				</div>
			</div>

		</div>
		
	</div>
</div>

</cfloop>
      
		

<!--- <cfinclude template="./incl/incl_scripts_lesson.cfm"> --->