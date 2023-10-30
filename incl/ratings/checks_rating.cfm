
<cfset l_id= lesson_id eq "" ? 0 : lesson_id >
<cfset tr_ids =  obj_query.oget_lesson(l_id).planner_id>
<cfset tr_id = tr_ids eq "" ? 0 : tr_ids>
   <!---    <cfdump var="#tr_id#" >
      <cfdump var="#l_id#" > --->
<cfinvoke component="api/ratings/badges_get" method="oget_lessontype" returnvariable="get_lesson_type">
          <cfinvokeargument name="l_id" value="#l_id#">
</cfinvoke>	
  <cfif ( !isDefined(get_lesson_type.level))><cfset lesson_level=1> 
  <cfelse> <cfset lesson_level="#get_lesson_type.level#"></cfif> 
  <cfif (!isDefined(get_lesson_type.method))> <cfset  lesson_method=1>
  <cfelse><cfset lesson_method="#get_lesson_type.method#"> </cfif> 

<cfinvoke  component="api/ratings/ratings_personality_post" method="ocheck_existingpersonality" returnvariable="existingpersonality" >
    <cfinvokeargument name="u_id" value="#u_id#"> 
    <cfinvokeargument name="tr_id" value="#tr_id#">
</cfinvoke>
<cfinvoke  component="api/ratings/badges_post" method="ocheck_existingBadge" returnvariable="existingBadge" >

    <cfinvokeargument name="l_id" value="#l_id#">
</cfinvoke>
<cfset get_rating = obj_query.oget_rating(lesson_id)>

