<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
	<tr>
		<td width="200">
			Soci&eacute;t&eacute;
		</td>
		<td bgcolor="#FFFFFF">
			<cfif isdefined("a_id")>
				<cfoutput>
				<strong>#get_account.account_name#</strong>
				</cfoutput>
			<cfelse>
				<cfoutput>
				<strong>#a_company#</strong>
				</cfoutput>
			</cfif>
		</td>
	</tr>
	<tr>
		<td width="200">
			Objectif p&eacute;dagogique
		</td>
		<td bgcolor="#FFFFFF">
			Apprentissage & renforcement en <cfif findnocase("fr",f_package)>Français<cfelseif findnocase("de",f_package)>Allemand<cfelseif findnocase("es",f_package)>Espagnol<cfelseif findnocase("it",f_package)>Italien</cfif>
		</td>
	</tr>
	<tr>
		<td width="200">
			Méthode
		</td>
		<td bgcolor="#FFFFFF">
			Formation Ouverte à Distance (FOAD) : Visio <cfif findnocase("en",f_package)>& e-Learning</cfif>
		</td>
	</tr>
	<tr>
		<td width="200">
			P&eacute;riode de formation
		</td>
		<td bgcolor="#FFFFFF">
			<cfoutput>Du #f_date_start# au #f_date_end#</cfoutput>
		</td>
	</tr>
</table>