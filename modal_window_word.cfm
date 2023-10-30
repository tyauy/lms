<cfparam name="voc_group">

<!--- <cfquery name="get_voc" datasource="#SESSION.BDDSOURCE#">
SELECT v.*, vc.*,
vtfr.voc_type_name_fr as voc_type_name_fr,
vten.voc_type_name_en as voc_type_name_en,
vtde.voc_type_name_de as voc_type_name_de

FROM lms_vocabulary v

INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id

LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id

WHERE voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_id#"> ORDER BY voc_word_en
</cfquery> --->

<!--- <cfquery name="get_voc" datasource="#SESSION.BDDSOURCE#">
	SELECT v.voc_id, v.voc_word_#SESSION.LANG_CODE# as voc_word, 
	v.voc_desc_#SESSION.LANG_CODE# as voc_desc, v.voc_category,
	vt.voc_type_name_#SESSION.LANG_CODE# as voc_type_name
	FROM lms_vocabulary v
	LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_#SESSION.LANG_CODE#_id
	WHERE v.voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
	ORDER BY voc_word ASC
</cfquery> --->

<cfquery name="get_voc" datasource="#SESSION.BDDSOURCE#">
	SELECT v.voc_id, v.voc_word, v.voc_desc, v.voc_category, v.formation_code,
	vt.*,
	vc.*
	FROM lms_vocabulary_new v
	INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
	LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
	WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">
</cfquery>



<div class="row">
<div class="col-12">
<table class="table">
	<cfoutput query="get_voc">
	<tr>
		<td><img src="./assets/img/cours_anglais.png" width="40"></td>
		<td>#voc_word#</td>
		<td>#evaluate("voc_cat_name_#formation_code#")#</td>
		<td>#voc_desc#</td>
		<td>
		<!--- <cfif fileexists("#SESSION.BO_ROOT#/assets/voc/word_en_#voc_id#.mp3")>
		<audio id="play_en_#voc_id#" src="./assets/voc/word_en_#voc_id#.mp3"></audio>
		<a class="btn btn-sm btn-success btn_player" id="btnplay_en_#voc_id#"><i class="fad fa-play"></i></a>
		</cfif> --->
		</td>
	</tr>
	</cfoutput>
	<!--- <tr>
		<td><img src="./assets/img/cours_français.png" width="40"></td>
		<td>#voc_word_fr#</td>
		<td>#voc_cat_name_fr#</td>
		<td>#voc_desc_fr#</td>
		<td>
		<cfif fileexists("#SESSION.BO_ROOT#/assets/voc/word_fr_#voc_id#.mp3")>
		<audio id="play_fr_#voc_id#" src="./assets/voc/word_fr_#voc_id#.mp3"></audio>
		<a class="btn btn-sm btn-success btn_player" id="btnplay_fr_#voc_id#"><i class="fad fa-play"></i></a>
		</cfif>
		</td>
	</tr>
	<tr>
		<td><img src="./assets/img/cours_allemand.png" width="40"></td>
		<td>#voc_word_de#</td>
		<td>#voc_cat_name_de#</td>
		<td>#voc_desc_de#</td>
		<td>
		<cfif fileexists("#SESSION.BO_ROOT#/assets/voc/word_de_#voc_id#.mp3")>
		<audio id="play_de_#voc_id#" src="./assets/voc/word_de_#voc_id#.mp3"></audio>
		<a class="btn btn-sm btn-success btn_player" id="btnplay_de_#voc_id#"><i class="fad fa-play"></i></a>
		</cfif>
		</td>
	</tr> --->
</table>

</div>
</div>


<script>
$(document).ready(function() {
	
	function play_audio(){
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	lang_code = idtemp[1];
	voc_id = idtemp[2];
	$("#play_"+lang_code+"_"+voc_id).get(0).play();
	
	}
	$(".btn_player").bind("click",play_audio);
	
});


	


</script>
