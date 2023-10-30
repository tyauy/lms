<cfparam name="ysel" default="#year(now())#">
<cfparam name="urlgo" default="common_orders_vue.cfm">

<div class="btn-group" role="group">
    <cfoutput>
        <a class="btn <cfif findnocase("tmg_index.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="tmg_index.cfm">Dashboard</a>
    </cfoutput>
</div>