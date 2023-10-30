<cfcomponent name="personality_get">

 
    <!---------------------------- Get trainer personalities from DB  ---->
    <cffunction name="oget_allpersonnalities" access="public"  returntype="query">		
    <cfquery name="get_personality_all" datasource="#SESSION.BDDSOURCE#">
        SELECT p.perso_name_#SESSION.LANG_CODE# as perso_name, p.perso_id as perso_id, p.perso_description_#SESSION.LANG_CODE# as perso_description FROM `user_personality_index` as p
        </cfquery>
   <cfreturn get_personality_all >
 
</cffunction>

	<!---------------------------- Get a specific trainer's personality by user from DB  ---->
  <cffunction name="oread_trainer_personality" access="public"  returntype="query">
    
    <cfargument name="tr_id" type="numeric" required="yes">
    <cfargument name="u_id" type="numeric" required="yes">

    <cfquery name="get_personality_trainer" datasource="#SESSION.BDDSOURCE#">
    SELECT pi.perso_name_#SESSION.LANG_CODE# as perso_name, up.perso_giver_id as user_id, up.user_id as trainer_id, up.personality_id as perso_id, pi.perso_description_#SESSION.LANG_CODE# as perso_description
    FROM `user_personality_index` as pi 
    left join user_personality as up on pi.perso_id=up.personality_id 
    where up.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">
    and up.perso_giver_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    </cfquery>
  <cfreturn get_personality_trainer>
</cffunction>


	<!---------------------------- Get a specific trainer's ponderated personality from DB  ---->
<cffunction name="oget_personality_votes_bystudent" access="public"  returntype="query">
       
    <cfquery name="get_personality_votes" datasource="#SESSION.BDDSOURCE#">
      select pi.perso_name_#SESSION.LANG_CODE# as perso_name, up.user_id, up.personality_id as perso_id, count(DISTINCT up.perso_giver_id) as votes
      from user_personality as up
      left join user_personality_index as pi
      on up.personality_id=pi.perso_id
      where up.user_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">
      and up.personality_id > 4
      and up.personality_id != 7
      group by up.personality_id
      having votes > 4
    
        </cfquery>
<cfreturn get_personality_votes>
 
</cffunction>
</cfcomponent>