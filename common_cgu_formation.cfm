<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,3,4,5,6,7,8,9,10,11,12">
<cfinclude template="./incl/incl_secure.cfm">

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">
		<!--- <cfset help_page = "help_index"> --->
			
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<div class="row">
	
				<div class="col-md-12">

					<!--- <strong>ENGAGEMENT :</strong>
					<br>
					<br>
					<strong>LE CLIENT</strong>, en contrepartie des actions d'évaluation réalisées, s'engage à verser à l'organisme le montant
					correspondant aux frais d'évaluation négocié comprenant les frais pédagogiques, les frais de téléphone, ainsi que les
					documents de compte rendu pédagogiques.<br>
					La prise en charge financière de la formation est assurée par LE CLIENT.
					<br>
					<br>
					<strong>L'ORGANISME DE FORMATION</strong>, en contrepartie des sommes reçues, s'engage à réaliser toutes les actions prévues dans
					le cadre de la présente commande ainsi qu'à fournir tout document et pièce de nature à justifier la réalité et la validité
					des dépenses engagées à ce titre. <br>
					En exécution de la présente commande , L'ORGANISME DE FORMATION s'engage à assurer l'évaluation suivante.
					<br>
					<br>
					<strong>MODE DE FACTURATION / DELAI DE PAIEMENT </strong>
					La formation fera l'objet d'une facture unique au lancement de l'action d'évaluation, d'un montant correspondant à
					la proposition commerciale négociée.<br>
					Le réglement s'effectuera à 30 jours net, par chèque bancaire ou virement.
				
					<br><br>
					
					<strong>COMMITMENT:</strong><br><br>

					<strong>THE CLIENT</strong>, in return for the evaluation actions carried out, undertakes to pay the amount to the organization
					corresponding to the negotiated evaluation fee, which includes tuition, telephone fees, and
					educational debriefing materials.<br>
					The financial support for the training is provided by the CUSTOMER.
					<br><br>
					<strong>THE TRAINING BODY</strong>, in return for the sums received, undertakes to carry out all the measures provided for in
					the scope of this order and to provide any document or document that would justify the reality and validity
					expenditure incurred in this respect.<br>
					In execution of this order, the TRAINING ORGANISATION undertakes to ensure the following evaluation.
					<br><br>
					<strong>METHOD OF INVOICING / PAYMENT DEADLINE</strong>

					The training will be invoiced once the evaluation action is launched, for an amount corresponding to
					the negotiated commercial proposal.<br>
					Payment will be made at 30 days net, by bank cheque or transfer. --->
				
					<cfoutput>
						<!--- <strong>#obj_translater.get_translate('tm_formation_charter_title')#</strong>
						<br> --->
						#obj_translater.get_translate_complex('tm_formation_charter')#
						<br>
					</cfoutput>
				
				</div>		
				
			</div>		
			
		</div>	
<cfinclude template="./incl/incl_footer.cfm">
		
	</div>
</div>
  

  
<cfinclude template="./incl/incl_scripts.cfm">

	
<script>
$(document).ready(function() {





	
	
	
	
	
	
	
	
	
	
});
</script>
</body>
</html>