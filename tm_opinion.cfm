<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="form_display" default="opinon">

<cfif isdefined("form") AND isdefined("send_opinion")>

<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_rating_tm
(
account_id,
rating_tm_date,
ans_1,
ans_2,
ans_3,
ans_4,
ans_5,
ans_6,
ans_7,
ans_8,
ans_9,
ans_10,
ans_11
)
VALUES
(
#SESSION.ACCOUNT_ID#,
now(),
'#ans_1#',
'#ans_2#',
'#ans_3#',
'#ans_4#',
'#ans_5#',
'#ans_6#',
'#ans_7#',
'#ans_8#',
'#ans_9#',
'#ans_10#',
'#ans_11#'
)
</cfquery>

</cfif>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "<cfoutput>#obj_translater.get_translate('title_page_tm_opinion')#</cfoutput>">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  			
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			<form action="tm_opinion.cfm" id="form_opinion" method="post">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 col-md-12">
					<cfif isdefined("form") AND isdefined("send_opinion")>
						<div class="alert alert-success" role="alert" align="center">
						<cfoutput>#obj_translater.get_translate('alert_thx_giving_opinion')#</cfoutput>
						</div>
					</cfif>
					<cfif isdefined("form") AND isdefined("send_feedback")>
						<div class="alert alert-success" role="alert" align="center">
						<cfoutput>#obj_translater.get_translate('alert_thx_giving_opinion')#</cfoutput>
						</div>
					</cfif>
					<cfif form_display eq "opinion">
					<div class="card">						
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">
									<div class="media">
										<img src="./assets/img_material/351a26a75e7c0cd42d56fd126a84b16e.jpg" class="rounded float-left mr-3" width="220">	
										<div class="media-body">
										<cfoutput>#obj_translater.get_translate_complex('tm_ask_opinion')#</cfoutput>
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-4">
								<div class="col-md-12">
									<table class="table">
										<tr>
											<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q1')#</cfoutput></td>
											<td width="30%">
												<label><input type="radio" name="ans_1" id="ans_1" value="OUI"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#</cfoutput></label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_1" id="ans_1" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label>
											</td>
											<td>
												<textarea class="form-control" name="ans_2" id="ans_2" placeholder="<cfoutput>#obj_translater.get_translate('specify')#</cfoutput>"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q2')#</cfoutput></td>
											<td colspan="2">
											<label><input type="radio" name="ans_3" id="ans_3" value="OUI, COMPL&Egrave;TEMENT"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#, #Ucase(obj_translater.get_translate('completely'))#</cfoutput></label><br>
											<label><input type="radio" name="ans_3" id="ans_3" value="OUI, PARTIELLEMENT"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#, #Ucase(obj_translater.get_translate('partially'))#</cfoutput></label><br>
											<label><input type="radio" name="ans_3" id="ans_3" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label><br>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q3')#</cfoutput> </td>
											<td>
												<label><input type="radio" name="ans_4" id="ans_4" value="OUI"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#</cfoutput></label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_4" id="ans_4" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label>
											</td>
											<td colspan="2">
											<textarea class="form-control" name="ans_5" id="ans_5"></textarea>
											</td>
										</tr>
										<tr> 
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q4')#</cfoutput></td>
											<td colspan="2">
											<textarea class="form-control" name="ans_6" id="ans_6"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q5')#</cfoutput></td>
											<td colspan="2">
											<textarea class="form-control" name="ans_7" id="ans_7"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q6')#</cfoutput></td>
											<td>
												<label><input type="radio" name="ans_8" id="ans_8" value="OUI"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#</cfoutput></label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_8" id="ans_8" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label>
											</td>
											<td>
											<textarea class="form-control" name="ans_9" id="ans_9"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q7')#</cfoutput></td>
											<td colspan="2">
											<label><input type="checkbox" name="ans_10" id="ans_10" value="Gestion administrative"> <cfoutput>#obj_translater.get_translate('form_tm_partnership_ans1')#</cfoutput></label><br>
											<label><input type="checkbox" name="ans_10" id="ans_10" value="Conseil"> <cfoutput>#obj_translater.get_translate('form_tm_partnership_ans2')#</cfoutput></label><br>
											<label><input type="checkbox" name="ans_10" id="ans_10" value="Formation additionnelle"> <cfoutput>#obj_translater.get_translate('form_tm_partnership_ans3')#</cfoutput></label><br>
											<label><input type="checkbox" name="ans_10" id="ans_10" value="Organisation d'&eacute;v&egrave;nement"> <cfoutput>#obj_translater.get_translate('form_tm_partnership_ans4')#</cfoutput></label><br>
											<label><input type="checkbox" name="ans_10" id="ans_10" value="D&eacute;l&eacute;gation d'une t&acirc;che de votre poste RH (Recrutement, Gestion de carri&egrave;re, Team building...)"> <cfoutput>#obj_translater.get_translate_complex('tm_opinion_ans10')#</cfoutput></label><br>
											</td>
										</tr>
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_opinion_q8')#</cfoutput></td>
											<td colspan="2">
												<label><input type="radio" name="ans_11" id="ans_11" value="OUI"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#</cfoutput></label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_11" id="ans_11" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center">
												<input type="hidden" name="send_opinion" value="1">
												<input type="submit" value="<cfoutput>#obj_translater.get_translate('btn_send')#</cfoutput>" class="btn btn-info">
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<cfelseif form_display eq "interface">
					<div class="card">						
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">
									<div class="media">
										<img src="./assets/img_material/351a26a75e7c0cd42d56fd126a84b16e.jpg" class="rounded float-left mr-3" width="220">	
										<div class="media-body">
											<cfoutput>#obj_translater.get_translate_complex('tm_ask_interface_opinion')#<h6></cfoutput>
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-4">
								<div class="col-md-12">
									<table class="table">
										<!--- <tr> --->
											<!--- <td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate_complex('tm_interface_q1')#</cfoutput></td> --->
											<!--- <td width="30%"> --->
												<!--- <label><input type="radio" name="ans_1" id="ans_1" value="OUI"> <cfoutput>#Ucase(obj_translater.get_translate('yes'))#</cfoutput></label> &nbsp;&nbsp; --->
												<!--- <label><input type="radio" name="ans_1" id="ans_1" value="NON"> <cfoutput>#Ucase(obj_translater.get_translate('no'))#</cfoutput></label> --->
											<!--- </td> --->
											<!--- <td> --->
												
											<!--- </td> --->
										<!--- </tr> --->
										<tr>
											<td class="bg-light"><cfoutput>#obj_translater.get_translate_complex('tm_interface_q2')#</cfoutput></td>
											<td colspan="2">
											<textarea class="form-control" name="ans_2" id="ans_2" placeholder="<cfoutput>#obj_translater.get_translate('specify')#</cfoutput>" style="height:200px !important; max-height:200px !important"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center">
												<input type="hidden" name="send_interface" value="1">
												<input type="submit" value="<cfoutput>#Ucase(obj_translater.get_translate('btn_send'))#</cfoutput>" class="btn btn-info">
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					</cfif>
				</div>
			</div>
			
		</div>
		</form>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>
$(document).ready(function() {	
			
	$("#form_opinion").submit(function(event) {
	
		var tofill = "Informations manquantes : ";
		
		var ans_1 = [];
		var ans_3 = [];
		var ans_4 = [];
		var ans_8 = [];
		var ans_11 = [];
		
		$.each($("input[id='ans_1']:checked"), function(){
			ans_1.push($(this).val());					
		});		
		if(ans_1.length != "1")
		{
			var pbl = "1";
			tofill = tofill+"\n - Attentes";
		}
		
		
		$.each($("input[id='ans_3']:checked"), function(){
			ans_3.push($(this).val());					
		});	
		if(ans_3.length != "1")
		{
			var pbl = "1";
			tofill = tofill+"\n - Mise en pratique";
		}

		$.each($("input[id='ans_4']:checked"), function(){
			ans_4.push($(this).val());					
		});	
		if(ans_4.length != "1")
		{
			var pbl = "1";
			tofill = tofill+"\n - Collaborateurs / collaboratrices";
		}
		
		$.each($("input[id='ans_8']:checked"), function(){
			ans_8.push($(this).val());					
		});	
		if(ans_8.length != "1")
		{
			var pbl = "1";
			tofill = tofill+"\n - Wefit est-il un partenaire qui vous aide ?";
		}
		
		$.each($("input[id='ans_11']:checked"), function(){
			ans_11.push($(this).val());					
		});	
		if(ans_11.length != "1")
		{
			var pbl = "1";
			tofill = tofill+"\n - Pensez-vous poursuivre avec Wefit ?";
		}



		if(pbl){
			alert(tofill);
			return false;
			
		}
		
	
	});
})
</script>		

</body>
</html>