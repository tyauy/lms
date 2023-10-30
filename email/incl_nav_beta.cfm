<cfset temp = structdelete(SESSION, "TRANSLATION_FR")>
<cfset temp = structdelete(SESSION, "TRANSLATION_EN")>
<cfset temp = structdelete(SESSION, "TRANSLATION_ES")>
<cfset temp = structdelete(SESSION, "TRANSLATION_DE")>
<cfset temp = structdelete(SESSION, "TRANSLATION_IT")>

<cfif isdefined("lang")>
    <cfset SESSION.LANG_CODE = lang>
<cfelse>
    <cfset lang = SESSION.LANG_CODE>
</cfif>

<cfoutput>
    <cfset vars = "#CGI.QUERY_STRING#">


<br>

<strong>CLASSIC NOTIF </strong> : 
<a href="test_email_lesson_status.cfm?status=reminder">reminder</a> | 
<a href="test_email_lesson_status.cfm?status=missed">missed</a> | 
<a href="test_email_lesson_status.cfm?status=confirm">confirm</a> | 
<a href="test_email_lesson_status.cfm?status=cancel_learner">cancel by learner</a> | 
<a href="test_email_lesson_status.cfm?status=cancel_trainer">cancel by trainer</a> | 
<a href="test_email_lesson_status.cfm?status=complete">complete</a> | 
<br><br>

<strong>SPECIAL NOTIF </strong> : 
<a href="test_email_lesson_status.cfm?status=na">1st BOOKED</a> | 
<a href="test_email_lesson_status.cfm?status=na_done">1st DONE</a> | 
<a href="test_email_lesson_status.cfm?status=pta_booked">PTA BOOKED</a> | 
<a href="test_email_lesson_status.cfm?status=pta_done">PTA DONE</a> | 
<a href="test_email_lesson_status.cfm?status=test_booked">Test BOOKED</a> | 
<a href="test_email_lesson_status.cfm?status=test_done">Test DONE</a> | 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="test_email_advertise_canceled_lesson.cfm">ADVERTISE CANCELLED SLOT</a> | 
<a href="test_email_next_vc_lesson.cfm">NEXT VC LESSON AVAIL TO BOOK !</a> | 

<br><br>

<strong>LATE NOTIF </strong> : 
<a href="test_email_lesson_status.cfm?status=force_cancel_by_learner">force_cancel_by_learner</a> | 
<a href="test_email_lesson_status.cfm?status=force_cancel_by_trainer">force_cancel_by_trainer</a>
<br><br>

<strong>LAUNCHING </strong> : 
<a href="test_email_new_formation.cfm?step=new_formation">LAUNCHING CLASSIC</a> | 
<a href="test_email_new_formation.cfm?step=new_test">LAUNCHING TEST</a> | 
<a href="test_email_new_formation.cfm?step=new_group">LAUNCHING GROUP</a> | 
<a href="test_email_new_formation.cfm?step=new_guest">LAUNCHING GUEST</a> | 
<br><br>

<strong>PWD </strong> : 
<a href="test_email_new_pwd.cfm?step=new_pwd">NEW PWD</a> | 
<a href="test_email_new_pwd.cfm?step=reset_pwd">RESET PWD</a> |
<span style="margin-left: 100px">
</span>
<br><br>

    <a href="test_email_prospect.cfm">Propspect</a> | 

<span style="margin-left: 100px">
    <a href="test_email_trainer_invoice.cfm">TRAINER INVOICE</a> |
</span>

<br><br>
<a href="test_email_admin_deadline.cfm">DEADLINE</a> | 
<a href="test_email_eval.cfm">SEND EVAL</a> | 
<a href="test_email_token.cfm">SEND CERTIF</a> | 
<br>




<cfif findnocase("lang=",vars)>
    <cfset vars = replace(vars, "lang=fr", "","ALL")>
    <cfset vars = replace(vars, "lang=en", "","ALL")>
    <cfset vars = replace(vars, "lang=de", "","ALL")>
    <cfset vars = replace(vars, "lang=es", "","ALL")>
    <cfset vars = replace(vars, "lang=it", "","ALL")>
</cfif>

<br><br><br>
<div align="center">
<a href="#SESSION.BO_CONNECT_URL##SCRIPT_NAME#?lang=fr<cfif vars neq "" AND vars neq "&">&#vars#</cfif>">FR</a> | 
<a href="#SESSION.BO_CONNECT_URL##SCRIPT_NAME#?lang=en<cfif vars neq "" AND vars neq "&">&#vars#</cfif>">EN</a> | 
<a href="#SESSION.BO_CONNECT_URL##SCRIPT_NAME#?lang=de<cfif vars neq "" AND vars neq "&">&#vars#</cfif>">DE</a> | 
<a href="#SESSION.BO_CONNECT_URL##SCRIPT_NAME#?lang=es<cfif vars neq "" AND vars neq "&">&#vars#</cfif>">ES</a> | 
<a href="#SESSION.BO_CONNECT_URL##SCRIPT_NAME#?lang=it<cfif vars neq "" AND vars neq "&">&#vars#</cfif>">IT</a>
</div>

</cfoutput>