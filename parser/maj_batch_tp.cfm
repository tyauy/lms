
<cfabort>
<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
SELECT tp_id, user_id FROM lms_tp
</cfquery>
    
<cfquery name="truncate" datasource="#SESSION.BDDSOURCE#">
TRUNCATE TABLE lms_tpuser
</cfquery>



<cfquery name="insert_cor" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpuser 
(tp_id, user_id)
VALUES
<cfoutput query="get_tp">
<cfif get_tp.user_id neq "">
(#get_tp.tp_id#, #get_tp.user_id#)<cfif get_tp.recordcount neq get_tp.currentRow>,</cfif>
</cfif>
</cfoutput>
</cfquery>

