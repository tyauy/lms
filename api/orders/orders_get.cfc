<cfcomponent>

    <cffunction name="get_order_users" access="remote" returntype="any" returnFormat="JSON">
      <cfargument name="order_id" type="numeric" required="yes">

      <cfquery name="get_orders_users" datasource="#SESSION.BDDSOURCE#">
          SELECT u.user_id, u.user_name, u.user_firstname
          FROM orders_users ou
          LEFT JOIN user u ON u.user_id = ou.user_id
          WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">
      </cfquery>

      <cfprocessingdirective suppresswhitespace="yes">
        <cfset result = SerializeJSON(get_orders_users, "struct")>
      </cfprocessingdirective>

      <cfreturn result>


    </cffunction>



    <cffunction name="oget_order_learners" access="remote" returntype="query" output="true">
      <cfargument name="o_id" type="numeric" required="yes">

      <cfquery name="get_order_learners" datasource="#SESSION.BDDSOURCE#">
          SELECT u.user_id, u.user_name, u.user_firstname, u.user_phone, u.user_email
          FROM orders_users ou
          LEFT JOIN user u ON u.user_id = ou.user_id
          WHERE ou.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
      </cfquery>

      <cfreturn get_order_learners>


    </cffunction>
    
    <cffunction name="oget_orders" access="public" returntype="query" output="true">
      <cfargument name="a_id" type="any" required="no">
      <cfargument name="u_id" type="numeric" required="no">
      <cfargument name="o_id" type="numeric" required="no">
      <cfargument name="s_id" type="numeric" required="no">
      <cfargument name="y_id" type="numeric" required="no">
      <cfargument name="close_id" type="numeric" required="no">
      <cfargument name="list_account" type="any" required="no">
      <cfargument name="st_tm_id" type="numeric" required="no">
      <cfargument name="manager_id" type="numeric" required="no">
      <cfargument name="context_id" type="numeric" required="no">
      <cfargument name="exclude" type="string" required="no">
      <cfargument name="group_by" type="string" required="no">
      <cfargument name="limit" type="numeric" required="no">
      
      <cfargument name="alert_close" type="numeric" required="no">
      <cfargument name="alert_dead" type="numeric" required="no">
      
      <cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
      SELECT 
      a.account_name, 
      o.*, DATE_FORMAT(o.order_date,'%Y') AS order_year,
      oc.context_id ,oc.context_alias, oc.context_name, oc.context_color,
      u.user_id as learner_id, u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
      oim.order_item_mode_name, 
      oip.method_id, oip.hour_qty, oip.certif_id, oip.destination_id, oip.elearning_id,
      ofi.status_finance_id, ofi.status_finance_name, ofi.status_finance_css, ofi.status_finance_tm_#SESSION.LANG_CODE# as status_finance_tm,
      otm.status_tm_name, otm.status_tm_css, 
      oi.order_item_invoice_id, oi.invoice_id, oi.f_account_id, oi.item_inv_nb_users, oi.item_inv_hour, oi.item_inv_unit_price, oi.item_inv_fee, oi.item_inv_total, oi.product_id, oi.product_name, oi.coupon_id, oi.order_item_mode_id,
      a2.account_name as opca_name, 
      u.user_firstname, u.user_name,
      u2.user_firstname as manager_firstname, u2.user_color as manager_color,
      f.formation_id, f.formation_code, f.formation_name_fr as formation_name
      
      FROM orders o
  
      INNER JOIN account a ON a.account_id = o.account_id
      
      LEFT JOIN orders_users ou ON ou.order_id = o.order_id 
      LEFT JOIN user u ON ou.user_id = u.user_id
      
      LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
      LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
      
      LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
      LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
      LEFT JOIN order_item_package oip ON oip.order_id = o.order_id

      LEFT JOIN order_context oc ON oc.context_id = o.context_id
  
      INNER JOIN account a2 ON o.account_id = a2.account_id
      LEFT JOIN account_group ag ON ag.group_id = a2.group_id
      LEFT JOIN user u2 ON u2.user_id = a.user_id
      LEFT JOIN lms_formation f ON f.formation_id = o.formation_id
      
      <!---LEFT JOIN order_item oi ON oi.order_id = o.order_id
      LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
      LEFT JOIN order_mode om ON om.order_mode_id = o.order_mode_id--->
      <!---LEFT JOIN logs lo ON lo.order_id = oi.order_id--->
      
      WHERE 1 = 1
      <cfif isdefined("s_id")>
      AND o.order_status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
      </cfif>
      
      <cfif isdefined("a_id")>
      <cfif a_id neq 0>AND o.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"><cfelse>AND o.account_id IN (#SESSION.USER_ACCOUNT_RIGHT_ID#)</cfif>
      </cfif>
      
      <cfif isdefined("o_id")>
      AND o.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
      </cfif>
      
      <cfif isdefined("u_id")>
      AND ou.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
      </cfif>
      
      <cfif isdefined("manager_id")>
      AND ag.manager_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#manager_id#">
      </cfif>
      
      <cfif isdefined("y_id")>
        <!--- AND SUBSTRING(o.order_ref, 1, 2) = <cfqueryparam cfsqltype="cf_sql_integer" value="#y_id#"> --->
        AND SUBSTRING(DATE_FORMAT(o.order_date,'%Y'), 3, 4) = <cfqueryparam cfsqltype="cf_sql_integer" value="#y_id#">
      </cfif>

      <cfif isdefined("close_id")>
      AND DATE_FORMAT(o.order_date,'%Y') = '20#close_id#'
      </cfif>
       
      <cfif isdefined("context_id")>
      AND o.context_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#context_id#">
      </cfif>
      
      <cfif isdefined("list_account") AND listlen("list_account") neq "0">
      AND a.account_id IN (<cfqueryparam value="#list_account#" cfsqltype="cf_sql_integer" list="yes">)
      </cfif>

      <cfif isdefined("exclude")>
        AND o.order_status_id NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#exclude#">)
      </cfif>
      
      <cfif isdefined("st_tm_id")>
      <cfif st_tm_id eq "1">
      AND (
      o.order_status_id = 1
      OR o.order_status_id = 2
      )
      <cfelseif st_tm_id eq "2">
      AND (
      o.order_status_id = 3
      OR o.order_status_id = 4
      )
      <cfelseif st_tm_id eq "3">
      AND (
      o.order_status_id = 5
      OR o.order_status_id = 10
      )
      </cfif>
      </cfif>
      
      
      <cfif isdefined("alert_close")>
      AND o.order_end <= #dateadd('m',+2,now())# AND o.order_end > now() AND o.order_status_id <> "10" AND o.order_status_id <> "11" AND o.order_status_id <> "6"
      </cfif>
      
      <cfif isdefined("alert_dead")>
      AND o.order_end <= now() AND o.order_status_id <> "10" AND o.order_status_id <> "11" AND o.order_status_id <> "6"
      </cfif>

      <cfif isdefined("group_by")>
      GROUP BY o.order_id
      </cfif>
      
      ORDER BY o.order_id DESC

      <cfif isdefined("limit")>
      LIMIT #limit#
      </cfif>
      </cfquery>
      
      <cfreturn get_orders> 
    
    </cffunction>




    <cffunction name="oget_orders_package" access="public" returntype="query" output="true">
      <cfargument name="o_id" type="any" required="yes">

      <cfquery name="get_orders_package" datasource="#SESSION.BDDSOURCE#">
      SELECT 
      oit.hour_qty,
      f.formation_name_#SESSION.LANG_CODE# as formation_name,
      m.method_name_fr as method_name, m.method_id,
      el.elearning_name,
      c.certif_name
      FROM order_item_package oit
      INNER JOIN lms_formation f ON f.formation_id = oit.formation_id
      INNER JOIN lms_lesson_method m ON m.method_id = oit.method_id
      LEFT JOIN lms_list_certification c ON c.certif_id = oit.certif_id
      LEFT JOIN lms_list_elearning el ON el.elearning_id = oit.elearning_id
      WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
      </cfquery>

      <cfreturn get_orders_package> 

    </cffunction>


    <cffunction name="oget_orders_invoice" access="public" returntype="query" output="true">
      <cfargument name="o_id" type="any" required="yes">
      
      <cfquery name="get_orders_invoice" datasource="#SESSION.BDDSOURCE#">
      SELECT oii.*,
      a.account_name, a.account_address, a.account_address2, a.account_postal, a.account_city, a.account_f_referrer, a.account_f_name, a.account_f_address, a.account_f_address2, a.account_f_postal, a.account_f_city, a.account_f_country,
      oim.order_item_mode_name
      FROM order_item_invoice oii
      INNER JOIN account a ON a.account_id = oii.f_account_id
      LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oii.order_item_mode_id
      WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
      </cfquery>

      <cfreturn get_orders_invoice> 

    </cffunction>




    <cffunction name="oget_invoice" access="public" returntype="query" output="true">

      <cfargument name="ysel" type="numeric" required="no">
      <cfargument name="o_by" type="any" required="no">
      <cfargument name="st_id" type="numeric" required="no">
      <cfargument name="o_id" type="numeric" required="no">
      <cfargument name="prov_id" type="numeric" required="no">

      <!--- SUM is group all invoice we need to have them individually in modal_window_order_read --->
      <cfargument name="by_invoice" type="numeric" required="no" default="-1">
      
      <cfquery name="get_invoice" datasource="#SESSION.BDDSOURCE#">
      SELECT i.*,
      a.account_name as dest_name, a.account_id as dest_id,
      a2.account_name as a_name, a2.account_id as a_id, 
      ist.*,
      osf.*,
      SUM(ii.item_qty) as nbitem,

      <cfif by_invoice eq -1> 
        SUM(oi.item_inv_total) as order_amount,
      <cfelse>
        oi.item_inv_total as order_amount,
      </cfif>
      
      o.order_ref,
      u.user_firstname, u.user_name, u.user_id
      FROM invoice i
      LEFT JOIN invoice_item ii ON i.invoice_id = ii.invoice_id
      INNER JOIN invoice_status ist ON ist.status_id = i.status_id
      INNER JOIN account a ON a.account_id = i.account_id
      INNER JOIN orders o ON o.order_id = i.order_id
      LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
      INNER JOIN order_status_finance osf ON osf.status_finance_id = o.order_status_id
      INNER JOIN account a2 ON a2.account_id = o.account_id
      LEFT JOIN user u ON u.user_id = o.user_id
      WHERE 1 = 1
      
      <cfif isdefined("o_id")>
      AND i.order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
      </cfif>
      
      <cfif isdefined("ysel")>
      AND DATE_FORMAT(i.invoice_date, "%Y") = '#ysel#'
      </cfif>
      
      <cfif isdefined("prov_id")>
      AND o.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#prov_id#">
      </cfif>

      <cfif isdefined("st_id")>
      AND i.status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#st_id#">
      </cfif>
      
      <cfif by_invoice eq -1> 
        GROUP BY o.order_id
      <cfelse>
        GROUP BY i.invoice_id
      </cfif>
      <cfif isdefined("o_by")>
        <cfif o_by eq "i_date">
        ORDER BY invoice_date ASC
        <cfelseif o_by eq "o_ref">
        ORDER BY o.order_ref ASC
        <cfelseif o_by eq "a_name">
        ORDER BY a_name ASC
        <cfelseif o_by eq "d_name">
        ORDER BY dest_name ASC
        <cfelseif o_by eq "u_name">
        ORDER BY u.user_name ASC
        <cfelseif o_by eq "i_ref">
        ORDER BY invoice_ref ASC
        <cfelseif o_by eq "i_id">
        ORDER BY invoice_id ASC
        <cfelseif o_by eq "i_paid">
        ORDER BY invoice_paid ASC
        <cfelseif o_by eq "i_amount">
        ORDER BY invoice_amount DESC
        <cfelseif o_by eq "o_amount">
        ORDER BY order_amount DESC
        </cfif>
      <cfelse>
      ORDER BY invoice_ref ASC
      </cfif>
      </cfquery>
  
      <cfreturn get_invoice> 
    
    </cffunction>


    <cffunction name="get_invoice_solo" access="remote" returntype="query" returnFormat="JSON">
      <cfargument name="i_id" type="numeric" required="yes">

      <cfquery name="get_invoice" datasource="#SESSION.BDDSOURCE#">
          SELECT i.*
          FROM invoice i
          WHERE i.invoice_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#i_id#">
      </cfquery>

      <cfreturn get_invoice>


    </cffunction>


</cfcomponent>
