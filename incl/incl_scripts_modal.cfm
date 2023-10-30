<div id="window_item_sm" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_sm" class="modal-title"></h6>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_sm" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<div id="window_item_lg" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_lg" class="modal-title"></h6>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_lg" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<div id="window_item_xl" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_xl" class="modal-title"></h6>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_xl" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<div id="window_item_xl_unclosable" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_xl_unclosable" class="modal-title"></h6>
				<div class="pull-right">
					<cfif isdefined("SESSION.USER_PROFILE") AND SESSION.USER_PROFILE neq "trainer">
						<cfif not isdefined("hide_setup")>
						<a href="##" class="btn btn-sm btn-outline-red btn_contact_wefit_modal my-0">
							<i class="far fa-calendar-alt"></i> <cfoutput>#obj_translater.get_translate('btn_take_meeting')#</cfoutput>
						</a>
						
					
						<cfif isdefined("SESSION.LANG_CODE") AND SESSION.LANG_CODE neq "de">
						<a href="##" class="btn btn-sm btn-outline-red btn_contact_wefit_modal my-0">
							<i class="far fa-phone-alt"></i> +33 (0)1 89 16 82 67
						</a>
						<cfelse>
						<a href="##" class="btn btn-sm btn-outline-red btn_contact_wefit_modal my-0">
							<i class="far fa-phone-alt"></i> +49 7151 2 59 40 54
						</a>
						</cfif>
					</cfif>
				</cfif>
					
				</div>
			</div>
			<div id="modal_body_xl_unclosable" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<div id="window_item_pw" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_pw" class="modal-title"></h6>
			</div>
			<div id="modal_body_pw" class="modal-body">
			
			</div>
        </div>
    </div>
</div>


<div id="window_item_el_syllabus" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_el_syllabus" class="modal-title"></h6>
				<button type="button" class="close" <!---data-dismiss="modal"---> aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</div>
			<div id="modal_body_el_syllabus" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<div id="window_item_el_video" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h6 id="modal_title_el_video" class="modal-title"></h6>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</div>
			<div id="modal_body_el_video" class="modal-body">
			
			</div>
        </div>
    </div>
</div>