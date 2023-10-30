<cfparam name="form.user_id" default="">
<cfparam name="form.user_password" default="">
<cfparam name="form.user_charter" default="">
<cfparam name="form.interest_id" default="">
<cfparam name="form.function_id" default="">
<cfparam name="form.avail_id" default="">
<cfparam name="form.user_account_right_id" default="">
<cfparam name="form.user_lst" default="">
<cfparam name="form.contact_id" default="">
<cfparam name="form.user_widget" default="">
<cfparam name="form.tp_id" default="">
<cfparam name="form.token_code" default="">
<cfdump var="#form#">
<cfif isDefined("form.contact_id") and NOT Len(Trim(form.contact_id)) EQ 0>
    <cfset contact_id = Int(form.contact_id)>
  <cfelse>
    <cfset contact_id = 0 >
  </cfif>

<cfif isDefined("form.user_id")>
    <cfset user_id = Int(form.user_id)>
  <cfelse>
    <cfset user_id = "" >
  </cfif>
<cfif isDefined("form.user_password")>
    <cfset user_password = form.user_password>
  <cfelse>
    <cfset user_password = "" >
  </cfif>
  
  <cfif isDefined("form.user_charter")>
    <cfset user_charter = Int(form.user_charter)>
  <cfelse>
    <cfset user_charter = "" >
  </cfif>
  <cfif isDefined("form.interest_id")>
    <cfset interest_id = form.interest_id>
  <cfelse>
    <cfset interest_id = "" >
  </cfif>
  <cfif isDefined("form.avail_id")>
    <cfset avail_id = form.avail_id>
  <cfelse>
    <cfset avail_id = "" >
  </cfif>
  <cfif isDefined("form.user_account_right_id")>
    <cfset user_account_right_id = form.user_account_right_id>
  <cfelse>
    <cfset user_account_right_id = "" >
  </cfif>
  <cfif isDefined("form.user_lst")>
    <cfset user_lst = form.user_lst>
  <cfelse>
    <cfset user_lst = "" >
  </cfif>
  <cfif isDefined("form.user_widget")>
    <cfset user_widget = form.user_widget>
  <cfelse>
    <cfset user_widget = "" >
  </cfif>
  <cfif isDefined("form.tp_id") and NOT Len(Trim(form.tp_id)) EQ 0>
    <cfset tp_id = Int(form.tp_id)>
  <cfelse>
    <cfset tp_id = "" >
  </cfif>
  <cfif isDefined("form.token_code")>
    <cfset token_code = form.token_code>
  <cfelse>
    <cfset token_code = "" >
  </cfif>
 
  <cfdump var="#user_id#">
  <cfdump var="#contact_id#">
  <cfdump var="#user_widget#">
<cftry> 

    <!--- Update user in the database --->
    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
    UPDATE user
    SET
    <cfif user_password NEQ "">
      user_password = <cfqueryparam value="#user_password#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif user_charter NEQ "">
    , user_charter = <cfqueryparam value="#user_charter#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif interest_id NEQ "">
     , interest_id = <cfqueryparam value="#interest_id#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif function_id NEQ "">
        , function_id = <cfqueryparam value="#function_id#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif avail_id NEQ "">
        , avail_id = <cfqueryparam value="#avail_id#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif user_account_right_id NEQ "">
       , user_account_right_id = <cfqueryparam value="#user_account_right_id#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif user_lst NEQ "">
       , user_lst = <cfqueryparam value="#user_lst#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif contact_id NEQ 0>
        , contact_id = <cfqueryparam value="#contact_id#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif user_widget NEQ "">
       , user_widget = <cfqueryparam value="#user_widget#" cfsqltype="cf_sql_varchar">
    </cfif>
            
    WHERE 
    user_id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">
    </cfquery>

     <!--- Update lms_tpuser table in the database --->
      <cfif tp_id NEQ ""> <cfquery name="updt_lms_tpuser" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tpuser
        SET
      
            tp_id = <cfqueryparam value="#tp_id#" cfsqltype="cf_sql_integer">
       
        WHERE 
        user_id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">
        </cfquery> </cfif>

           <!--- Update lms_tokens table in the database --->
     <cfif token_code NEQ ""> <cfquery name="updt_lms_tokens" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tokens
        SET
      
            token_code = <cfqueryparam value="#token_code#" cfsqltype="cf_sql_varchar">
      
        WHERE 
        user_id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">
        </cfquery>  </cfif>
  <!--- Display success message --->
    <cfset successMessage = "User updated successfully!">
    <cflocation url="_EM_maj_user_rm.cfm?message=#successMessage#" addtoken="false">

    <cfcatch>
        <!--- Display error message --->
        <cfset errorMessage = "Error updating user: #cfcatch.message#">
        <cflocation url="_EM_maj_user_rm.cfm?message=#errorMessage#" addtoken="false">
    </cfcatch>
</cftry> 