<div>

	<div>
		<img src="./assets/img/header_modal_13.jpg" class="header_rounded_top border-bottom-2 border-red" width="100%">
	</div>

	<div class="p-3">

	
	<cfoutput>
		<cfif isdefined("SESSION.USER_PROFILE") AND SESSION.USER_PROFILE eq "TM">

			<cfquery name="get_sales" datasource="#SESSION.BDDSOURCE#">
			SELECT a.user_id, u.user_firstname, u.user_name, u.user_email, u.user_phone, u.user_phone_code, u.user_gender, u.user_appointlet
			FROM account a 
			INNER JOIN user u ON u.user_id = a.user_id 
			WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
			</cfquery>
			
			
			<cfloop query="get_sales">
			<div align="center">
			<cfif get_sales.user_gender eq "M." or get_sales.user_gender eq "Mr." or get_sales.user_gender eq "Hr.">
				<strong>#obj_translater.get_translate_complex('contact_sales_solo_male_title')#</strong>
			<cfelse>
				<strong>#obj_translater.get_translate_complex('contact_sales_solo_female_title')#</strong>
			</cfif>
			</div>


			<div align="center">
				<small><em>#obj_translater.get_translate_complex('contact_sales_subtitle_tm')#</em></small>
			</div>

			<br>

			<div class="card bg-light border">
				<div class="card-body">
					#obj_lms.get_thumb(user_id="#user_id#",size="85",css="border border-info mr-3 float-left",style="border-width:5px !important")#
					<h6><strong>#user_firstname# #user_name#</strong></h6>
					#user_email#<br>
					+#user_phone_code# #user_phone#
					<br><br>
					<div align="center">
					<a href="#get_sales.user_appointlet#" class="btn btn-info" target="_blank">#obj_translater.get_translate('btn_take_appointment')#</a>
					</div>
				</div>
			</div>
			</cfloop>
			
			<!--- <br>

			<div align="center">
				<strong>#obj_translater.get_translate_complex('contact_sales_title')#</strong>
			</div>
				
			<br>

			<div class="card bg-light border">
				<div class="card-body">
					<img src="./assets/img/logo_wefit_solo_150.png" class="mr-3 float-left rounded-circle" width="85" style="border-width:5px !important">
					#obj_translater.get_translate_complex('contact_sales_content')#
				</div>
			</div>

			<div align="center">
			<small>#obj_translater.get_translate_complex('contact_free_call')#</small>
			</div> --->
		<cfelseif isdefined("SESSION.USER_PROFILE") AND SESSION.USER_PROFILE eq "TRAINER">
			<div align="center">
			<strong>#obj_translater.get_translate_complex('contact_tm_title')#</strong>
			<br><br>
			<em>#obj_translater.get_translate_complex('contact_tm_subtitle')#</em>
			<br><br>
			<a href="##" class="btn btn-info"> #obj_translater.get_translate_complex('contact_tm_content')#</a>
			</div>
		<cfelse>
			<!--- <div align="center"> --->
			<!--- <strong>#obj_translater.get_translate_complex('contact_sales_title')#</strong> --->
			<!--- <br><br> --->
			<!--- <em>#obj_translater.get_translate_complex('contact_sales_subtitle_lrn')#</em> --->
			<!--- <br><br> --->
			<!--- <a href="##" class="btn btn-info"> #obj_translater.get_translate_complex('contact_sales_content')#</a> --->
			<!--- </div>			 --->
			<!--- <br>			 --->
			
			<div class="row justify-content-center">
				
				
				<div class="col-md-9" align="center">

					<cfif SESSION.LANG_CODE eq "de">
						Sie erreichen uns telefonisch unter folgender Nummer:
						<br>
						+49 (0) 7151 2 59 40 54
						<br><br>
					<cfelse>
						<strong>#obj_translater.get_translate_complex('contact_cs_title')#</strong>
						<br><br>
						<em>#obj_translater.get_translate_complex('contact_cs_subtitle')#</em>
						<br><br>

					</cfif>

				</div>

			</div>

			<div class="row justify-content-center">
				
				<div class="col-md-6">


					<cfif SESSION.LANG_CODE eq "en">
						<a href="##" class="btn btn-block btn-info"> #obj_translater.get_translate_complex(id_translate='contact_cs_content',lg_translate='fr')#</a>
						<a href="##" class="btn btn-block btn-info"> #obj_translater.get_translate_complex(id_translate='contact_cs_content',lg_translate='de')#</a>
					<cfelseif SESSION.LANG_CODE eq "de">
						
					<cfelse>
						<a href="##" class="btn btn-block btn-info"> #obj_translater.get_translate_complex('contact_cs_content')#</a>
					</cfif>

					<cfif isdefined("SESSION.USER_SETUP") AND SESSION.USER_SETUP eq "1">
					
					<a href="##" class="btn btn-block btn-info btn_meet_wefit"> #obj_translater.get_translate('btn_take_appointment')#</a>
					</cfif>
					
				</div>
				
			</div>	
			
			<br><br>
			<div align="center">
			<small>#obj_translater.get_translate_complex('contact_free_call')#</small>
			</div>		
		</cfif>
	
	</cfoutput>
	
		
	</div>
</div>

<script>

$(document).ready(function() {

	$('.btn_meet_wefit').click(function(event) {
	
		event.preventDefault();		
		/*var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);*/
		/*$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Meet WEFIT");*/
		$('#modal_body_ctc').empty();		
		$('#modal_body_ctc').load("modal_window_calendar_cs.cfm", function() {});
	});
	
})
	
</script>
