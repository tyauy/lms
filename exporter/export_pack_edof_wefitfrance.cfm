<cfprocessingdirective pageEncoding="ISO-8859-1">
<cfset myxml = '<?xml version="1.0" encoding="ISO-8859-1"?>
<lheo xmlns="https://www.of.moncompteformation.gouv.fr">
	<offres>'>

<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
SELECT fc.*, lc.*
FROM lms_formation_pack fc
INNER JOIN lms_list_certification lc ON lc.certif_id = fc.certif_id
WHERE provider_id = 3 AND pack_active = 1
</cfquery>

<cfoutput query="get_formation_pack">

<cfif formation_id eq "1">
	<cfset lang_code = "FR">
<cfelseif formation_id eq "2">
	<cfset lang_code = "EN">
<cfelseif formation_id eq "3">
	<cfset lang_code = "DE">
<cfelseif formation_id eq "4">
	<cfset lang_code = "ES">
<cfelseif formation_id eq "5">
	<cfset lang_code = "IT">
<cfelseif formation_id eq "6">
	<cfset lang_code = "AR">
<cfelseif formation_id eq "8">
	<cfset lang_code = "ZH">
<cfelseif formation_id eq "9">
	<cfset lang_code = "NL">
<cfelseif formation_id eq "12">
	<cfset lang_code = "PT">
<cfelseif formation_id eq "13">
	<cfset lang_code = "RU">
</cfif>

<cfif get_formation_pack.tpmaster_id neq "">
<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
SELECT tpmaster_id, tpmaster_name, tpmaster_level
FROM lms_tpmaster2 tp
WHERE tp.tpmaster_prebuilt = 1 AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation_pack.formation_id#">
AND tp.tpmaster_id IN (#get_formation_pack.tpmaster_id#)
ORDER BY tp.tpmaster_id ASC LIMIT 8
</cfquery>	
</cfif>

<cfset myxml = myxml&'
		<formation numero="#pack_id#_FWF" datemaj="#dateformat(now(),'yyyymmdd')#" datecrea="20211001">
			<intitule-formation><![CDATA[#pack_name#]]></intitule-formation>
			<objectif-formation><![CDATA[#pack_objectives#]]></objectif-formation>
			<resultats-attendus><![CDATA[#pack_results#<br>#pack_certif_info#]]></resultats-attendus>'>
			
<cfif method_id eq "6">

		<cfquery name="get_coordonnees" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_list_destination WHERE destination_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#destination_id#">
		</cfquery>
		
		<cfset myxml = myxml&'
			<contenu-formation><![CDATA[#pack_content# <br><br>Lieu de formation :<br>#get_coordonnees.destination_address#]]></contenu-formation>'>

<cfelse>

	<cfif get_formation_pack.tpmaster_id neq "">
	
		<cfset pack_content_final = pack_content & '<br><br><strong>Exemples de parcours de formation :<strong><br>'>
		
		<cfloop query="get_sm">
			<cfset pack_content_final = pack_content_final & '<a href="https://formation.wefitgroup.com/detail.cfm?fwf=#get_formation_pack.pack_id#&tp_id=#get_sm.tpmaster_id#">#get_sm.tpmaster_level# - #get_sm.tpmaster_name#</a><br>'>
		</cfloop>
		
		<cfset pack_content_final = pack_content_final & '<a href="https://formation.wefitgroup.com/detail.cfm?fwf=#get_formation_pack.pack_id#">[...] D&eacute;couvrez tous nos parcours</a>'>
		
		<cfset myxml = myxml&'
			<contenu-formation><![CDATA[#pack_content_final#]]></contenu-formation>'>
	<cfelse>
	
		<cfset myxml = myxml&'
			<contenu-formation><![CDATA[#pack_content#]]></contenu-formation>'>
			
	</cfif>
</cfif>
								
		<cfset myxml = myxml&'			
			<parcours-de-formation>2</parcours-de-formation>
			<objectif-general-formation>6</objectif-general-formation>
			<certification>
				<code-RS>#rncp_info#</code-RS>
			</certification>
			<action numero="#pack_id#_AFWF" datemaj="#dateformat(now(),'yyyymmdd')#" datecrea="20211001">
				<niveau-entree-obligatoire>0</niveau-entree-obligatoire>'>
<cfif method_id eq "2" OR method_id eq "6">
			<cfset myxml = myxml&'
				<modalites-enseignement>0</modalites-enseignement>'>
<cfelseif method_id eq "1,2">
			<cfset myxml = myxml&'
				<modalites-enseignement>1</modalites-enseignement>'>
<cfelse>
			<cfset myxml = myxml&'
				<modalites-enseignement>2</modalites-enseignement>'>
</cfif>

			<!--- <cfset myxml = myxml&' --->
				<!--- <conditions-specifiques><![CDATA[]]></conditions-specifiques>'> --->
		

		<cfset myxml = myxml&'
				<lieu-de-formation>
					<coordonnees numero="PARIS_DID">
						<nom>Wefit</nom>
						<prenom>CPF</prenom>
						<adresse numero="PARIS_AID">
							<ligne>168 Rue de la Convention</ligne>
							<codepostal>75015</codepostal>
							<ville>PARIS</ville>
							<pays>FR</pays>
							<geolocalisation>
								<latitude>48.8384577</latitude>
								<longitude>2.2932025</longitude>
							</geolocalisation>
							<extras info="adresse">
								<extra info="numero-voie">168</extra>
								<extra info="code-nature-voie">RUE</extra>
								<extra info="libelle-voie">de la Convention</extra>
								<extra info="conformite-reglementaire">1</extra>
							</extras>
						</adresse>
						<telfixe>
							<numtel>01 84 17 59 70</numtel>
						</telfixe>
						<courriel>startfrance@wefitgroup.com</courriel>
					</coordonnees>
				</lieu-de-formation>'>

				
		<cfif method_id eq "6">
				<cfset myxml = myxml&'		
				<modalites-entrees-sorties>0</modalites-entrees-sorties>'>
		<cfelse>
				<cfset myxml = myxml&'		
				<modalites-entrees-sorties>1</modalites-entrees-sorties>'>		
		</cfif>
				
				<cfset myxml = myxml&'		
				<url-action>
					<urlweb>https://formation.wefitgroup.com/detail.cfm?fwf=#pack_id#</urlweb>
				</url-action>'>
				
<cfif method_id eq "6">
		<cfset counter = "0">
		<cfset list_session = "20220509,20220613,20220711,20220822">		
		<cfset list_session_end = "20220515,20220619,20220720,20220828">		
		
		<cfloop list="#list_session#" index="cor">
		<cfset counter ++>
		
		
			<cfset myxml = myxml&'
				<session numero="#pack_id#_#cor#_SFWF" datemaj="#dateformat(now(),'yyyymmdd')#" datecrea="20211001">
					<periode>
						<debut>#cor#</debut>
						<fin>#listgetat(list_session_end,counter)#</fin>
					</periode>
					<adresse-inscription>
						<adresse numero="STD_WEFIT">
							<ligne>168 Rue de la Convention</ligne>
							<codepostal>75015</codepostal>
							<ville>PARIS</ville>
							<pays>FR</pays>
							<geolocalisation>
								<latitude>48.8384577</latitude>
								<longitude>2.2932025</longitude>
							</geolocalisation>
							<extras info="adresse">
								<extra info="ligne5-adresse">168 Rue de la Convention</extra>
								<extra info="numero-voie">168</extra>
								<extra info="code-nature-voie">RUE</extra>
								<extra info="libelle-voie">Rue de la Convention</extra>
								<extra info="conformite-reglementaire">1</extra>
							</extras>
						</adresse>
					</adresse-inscription>
					<etat-recrutement>1</etat-recrutement>
					<extras info="session">
						<extra info="contact-inscription">
							<coordonnees numero="STD_WEFIT">
								<nom>WEFIT</nom>
								<prenom>Service Client</prenom>
								<telfixe>
									<numtel>01 84 17 59 70</numtel>
								</telfixe>
								<courriel>startfrance@wefitgroup.com</courriel>
							</coordonnees>				
						</extra>
						<extra info="garantie">1</extra>
					</extras>
				</session>'>
				
			</cfloop>
				
<cfelse>

<cfset myxml = myxml&'
				<session numero="#pack_id#_SFWF" datemaj="#dateformat(now(),'yyyymmdd')#" datecrea="20211001">
					<adresse-inscription>
						<adresse numero="STD_WEFIT">
							<ligne>168 Rue de la Convention</ligne>
							<codepostal>75015</codepostal>
							<ville>PARIS</ville>
							<geolocalisation>
								<latitude>48.8384577</latitude>
								<longitude>2.2932025</longitude>
							</geolocalisation>
							<extras info="adresse">
								<extra info="ligne5-adresse">168 Rue de la Convention</extra>
								<extra info="numero-voie">168</extra>
								<extra info="code-nature-voie">RUE</extra>
								<extra info="libelle-voie">Rue de la Convention</extra>
								<extra info="conformite-reglementaire">1</extra>
							</extras>
						</adresse>
					</adresse-inscription>
					<etat-recrutement>1</etat-recrutement>
					<extras info="session">
						<extra info="contact-inscription">
							<coordonnees numero="STD_WEFIT">
								<nom>WEFIT</nom>
								<prenom>Service Client</prenom>
								<telfixe>
									<numtel>01 84 17 59 70</numtel>
								</telfixe>
								<courriel>startfrance@wefitgroup.com</courriel>
							</coordonnees>				
						</extra>
						<extra info="garantie">1</extra>
					</extras>
				</session>'>
</cfif>

				
				<cfset myxml = myxml&'
				<adresse-information>
					<adresse numero="WEFIT PARIS">
						<ligne>168 Rue de la Convention</ligne>
						<codepostal>75015</codepostal>
						<ville>PARIS</ville>
						<geolocalisation>
							<latitude>48.8384577</latitude>
							<longitude>2.2932025</longitude>
						</geolocalisation>	
						<extras info="adresse">
							<extra info="ligne5-adresse">168 Rue de la Convention</extra>
							<extra info="numero-voie">168</extra>
							<extra info="code-nature-voie">RUE</extra>
							<extra info="libelle-voie">Rue de la Convention</extra>
							<extra info="conformite-reglementaire">1</extra>
						</extras>
					</adresse>
				</adresse-information>				
				<acces-handicapes>Formation accessible</acces-handicapes>
				<langue-formation>#lang_code#</langue-formation>'>
				
				<cfset myxml = myxml&"
				<modalites-recrutement><![CDATA[#pack_modalites#]]></modalites-recrutement>">
				
				<cfset myxml = myxml&"
				<modalites-pedagogiques><![CDATA[#pack_modalites#]]></modalites-pedagogiques>">
				
				<cfset myxml = myxml&'
				<code-perimetre-recrutement>6</code-perimetre-recrutement>
				<nombre-heures-centre>#trim(NumberFormat(pack_hour,'____'))#</nombre-heures-centre>
				<nombre-heures-entreprise>0</nombre-heures-entreprise>
				<extras info="action">
					<extra info="contact-information">
						<coordonnees numero="WEFIT PARIS">
							<nom>WEFIT</nom>
							<prenom>Service Client</prenom>
							<telfixe>
								<numtel>01 84 17 59 70</numtel>
							</telfixe>
							<courriel>startfrance@wefitgroup.com</courriel>
						</coordonnees>
					</extra>
					<extras info="codes-modalites-admission">
						<extra info="code-modalites-admission">99999</extra>
					</extras>
					<extra info="prise-en-charge-frais-obligatoire"></extra>
					<extra info="code-type-horaires">3</extra>
					<extra info="duree-apprentissage">#trim(NumberFormat(pack_hour,'____'))#</extra>
					<extras info="codes-rythme-formation">
						<extra info="code-rythme-formation">7</extra>
					</extras>					
					<extra info="frais-anpec">0.00</extra>
					<extra info="frais-certif-inclus-frais-anpec">1</extra>
					<extra info="code-modele-economique">2</extra>
					<extras info="frais-pedagogiques">
						<extra info="taux-tva">0.0</extra>
						<extra info="frais-ht">#xmlformat(pack_amount_ttc)#</extra>
						<extra info="frais-ttc">#xmlformat(pack_amount_ttc)#</extra>
					</extras>
					<extra info="existence-prerequis">0</extra>
				</extras>
			</action>
			<organisme-formation-responsable>
				<SIRET-organisme-formation>
					<SIRET>90224162900010</SIRET>
				</SIRET-organisme-formation>
			</organisme-formation-responsable>
			<extras info="formation">
				<extra info="resume-contenu"><![CDATA[#pack_keys#]]></extra>
			</extras>
		</formation>
	
'>

</cfoutput>

<cfset myxml = myxml&'</offres>
</lheo>'>

<cffile action="write" file="/home/www/wnotedev1/www/manager/lms/exporter/90224162900010_cpf.xml" charset="ISO-8859-1" output="#myxml#">