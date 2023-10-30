<cfif get_voc.recordcount gt 1>
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

<!-----  TITLE & INTRO TEXT  ----->
	<cfif #mystart# eq 1>
	<tr>
		<td width="100%" align="center">			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:10px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td width="100%" align="center">
						<h2 align="center">	
						<cfif #voc_cat_id# gt 0>
							<cfoutput>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)# : #evaluate("get_cat_name.voc_cat_name_#lang_select#")#</cfoutput>
						<cfelse>
							<cfoutput>#obj_translater.get_translate("table_th_my_vocab_list",lang_select_id)#</cfoutput>
						</cfif>
						
						</h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<cfif #voc_cat_id# gt 0>
	<tr>
		<td valign="top">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; margin-top:5px;" width="100%" cellpadding="10" cellspacing="0">
				<tr>
					<td>
						<cfoutput>#obj_translater.get_translate_complex('intro_vocablist')#</cfoutput>
					</td>
				</tr>		
			</table>
		</td>
	</tr>
	</cfif>
	<cfset nb_row -= #nb_diff#>
	</cfif>
</table>

<cfset perso = 0>
<cfif #voc_cat_id# lt 1>
<cfset perso = 1>
</cfif>
	
	<!------  VOCAB ARRAY  ------>
	<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px; text-align:justify;" valign="middle" width="100%" cellpadding="6" cellspacing="1" bgcolor="#CCCCCC">
		<!-- COL NAMES -->
		<tr style="font-size:13px;">
			<cfoutput>
				
				<cfif isdefined("lang_translate") AND lang_translate neq "">
					<cfif perso eq 1>
						<th bgcolor="##ECECEC" height="40" width="73%"><strong>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)#</strong></th>
						<th bgcolor="##ECECEC" width="20%"><strong>#obj_translater.get_translate("table_th_translation",lang_translate_id)#</strong></th>
						<th bgcolor="##ECECEC" width="10%"><strong>#obj_translater.get_translate("table_th_vocab_category",lang_select_id)#<strong></th>
					<cfelse>
						<th bgcolor="##ECECEC" height="40" width="80%"><strong>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)#</strong></th>
						<th bgcolor="##ECECEC" width="20%"><strong>#obj_translater.get_translate("table_th_translation",lang_translate_id)#</strong></th>
					</cfif>
				<cfelse>
					<cfif perso eq 1>
						<th bgcolor="##ECECEC" height="40" width="85%"><strong>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)#</strong></th>
						<th bgcolor="##ECECEC" width="15%"><strong>#obj_translater.get_translate("table_th_vocab_category",lang_select_id)#<strong></th>
					<cfelse>
						<th bgcolor="##ECECEC" height="40" width="100%"><strong>#obj_translater.get_translate("table_th_vocab_list",lang_select_id)#</strong></th>
					</cfif>
				</cfif>			
								
			</cfoutput>	

		</tr>
		
		<cfoutput query="get_voc" startrow="#mystart#" maxrows="#nb_row#">
			<tr>
				
				<!-- <td width="15%" bgcolor="##FFFFFF">#evaluate("voc_word_#lang_select#")#</td> -->
				<!-- <td width="10%" bgcolor="##FFFFFF"><em>#evaluate("voc_type_name_#lang_select#")#</em></td> -->
				<cfif isdefined("lang_translate") AND lang_translate neq "">
					<cfif perso eq 1>
						<td width="73%" bgcolor="##FFFFFF">
							<strong>#evaluate("voc_word_#lang_select#")#</strong>
							<cfif isdefined("voc_type_name_#lang_select#") AND evaluate("voc_type_name_#lang_select#") neq ""><span style="font-size:10px;"> [#evaluate("voc_type_name_#lang_select#")#]</span></cfif>
							<br>#evaluate("voc_desc_#lang_select#")#
						</td>
						<td width="20%" bgcolor="##FFFFFF">
							#evaluate("voc_word_#lang_translate#")#<cfif isdefined("voc_type_name_#lang_translate#") AND evaluate("voc_type_name_#lang_translate#") neq ""> [#evaluate("voc_type_name_#lang_translate#")#]</cfif>
						</td>
						<td width="10%" bgcolor="##FFFFFF">#voc_cat#</td>
					<cfelse>					
					
						<td width="80%" bgcolor="##FFFFFF">
							<strong>#evaluate("voc_word_#lang_select#")#</strong>
							<cfif isdefined("voc_type_name_#lang_select#") AND evaluate("voc_type_name_#lang_select#") neq ""><span style="font-size:10px;"> [#evaluate("voc_type_name_#lang_select#")#]</span></cfif>
							<br>#evaluate("voc_desc_#lang_select#")#
						</td>
						<td width="20%" bgcolor="##FFFFFF">
							#evaluate("voc_word_#lang_translate#")#<cfif isdefined("voc_type_name_#lang_translate#") AND evaluate("voc_type_name_#lang_translate#") neq ""> [#evaluate("voc_type_name_#lang_translate#")#]</cfif>
						</td>
					</cfif>
				<cfelse>
					<cfif perso eq 1>
						<td width="85%" bgcolor="##FFFFFF">
							<strong>#evaluate("voc_word_#lang_select#")#</strong>
							<cfif isdefined("voc_type_name_#lang_select#") AND evaluate("voc_type_name_#lang_select#") neq ""><span style="font-size:10px;"> [#evaluate("voc_type_name_#lang_select#")#]</span></cfif>
							<br>#evaluate("voc_desc_#lang_select#")#
						</td>
						<td width="15%" bgcolor="##FFFFFF">#voc_cat#</td>
					<cfelse>
				
						<td width="100%" bgcolor="##FFFFFF">
							<strong>#evaluate("voc_word_#lang_select#")#</strong>
							<cfif isdefined("voc_type_name_#lang_select#") AND evaluate("voc_type_name_#lang_select#") neq ""><span style="font-size:10px;"> [#evaluate("voc_type_name_#lang_select#")#]</span></cfif>
							<br>#evaluate("voc_desc_#lang_select#")#
						</td>
					</cfif>
				</cfif>
			</tr>
		</cfoutput>
	</table>

</body>
</html>
</cfif>