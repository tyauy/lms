<cfabort>
<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_formation_pack WHERE pack_active = 1
</cfquery>


<cfoutput query="get_formation_pack">

    <cfquery name="update" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_formation_pack SET 
        pack_keys = 

'
<video poster="https://formation.wefitgroup.com/assets/img/Video_Presentation_Wefit_thumbnail.jpg" controls="controls" width="100%"><source src="https://formation.wefitgroup.com/assets/video/VIDEO_WEFIT_CPF.mp4" type="video/mp4"></video>
<ul><li>Discerner les axes de progression possibles</li><li>Progresser significativement dans la langue et les compétences travaillées (compréhension/expression orale & écrite)</li><li>Optimiser votre score lors de la certification</li></ul>
'

        
        WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
        </cfquery>


</cfoutput>