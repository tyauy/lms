<cfoutput>

<cfset temp1="18-1757"><cfset temp2="1195.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1758"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1759"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1760"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1761"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1762"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1764"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1765"><cfset temp2="1530.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1766"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1767"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1770"><cfset temp2="2655.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1771"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1772"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1773"><cfset temp2="4000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1774"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1776"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1777"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1778"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1779"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1780"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1781"><cfset temp2="1362.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1782"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1783"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1784"><cfset temp2="225.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1785"><cfset temp2="910.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1786"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1787"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1789"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1790"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1792"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1793"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1794"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1795"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1796"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1797"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1798"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1799"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1800"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1801"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1802"><cfset temp2="65.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1803"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1806"><cfset temp2="60.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1807"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1808"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1809"><cfset temp2="4000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1811"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1812"><cfset temp2="70.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1813"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1814"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1815"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1816"><cfset temp2="4000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1817"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1819"><cfset temp2="1081.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1820"><cfset temp2="1320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1821"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1822"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1823"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1824"><cfset temp2="744.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1827"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1828"><cfset temp2="350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1829"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1830"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1831"><cfset temp2="3050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1832"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1833"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1834"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1835"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1836"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1837"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1838"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1839"><cfset temp2="1150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1840"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1841"><cfset temp2="1820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1842"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1843"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1844"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1845"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1846"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1847"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1848"><cfset temp2="1320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1849"><cfset temp2="1125.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1850"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1851"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1852"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1853"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1854"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1856"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1857"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1858"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1859"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1860"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1861"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1862"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1863"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1864"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1865"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1866"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1867"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1868"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1869"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1870"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1871"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1872"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1873"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1874"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1875"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1876"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1877"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1878"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1879"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1880"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1881"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1882"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1883"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1884"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1885"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1886"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1887"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1888"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1889"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1890"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1891"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1892"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1893"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1894"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1895"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1896"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1897"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1898"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1899"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1900"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1901"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1902"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1903"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1904"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1905"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1906"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1907"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1909"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1910"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1911"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1912"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1913"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1914"><cfset temp2="1375.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1915"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1916"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1917"><cfset temp2="780.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1918"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1919"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1920"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1921"><cfset temp2="410.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1922"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1923"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1924"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1925"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1926"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1927"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1928"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1929"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1930"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1931"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1932"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1933"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1934"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1935"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1936"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1937"><cfset temp2="1031.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1938"><cfset temp2="1287.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1939"><cfset temp2="1900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1940"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1942"><cfset temp2="831.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1943"><cfset temp2="1900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1944"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1948"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1949"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1950"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1952"><cfset temp2="1331.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1953"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1954"><cfset temp2="1168.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1955"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1956"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1957"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1958"><cfset temp2="943.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1959"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1960"><cfset temp2="1393.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1961"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1962"><cfset temp2="918.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1963"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1964"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1965"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1966"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1967"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1968"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1969"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1970"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1971"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1972"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1973"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1974"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1975"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1976"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1977"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1978"><cfset temp2="112.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1979"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1980"><cfset temp2="1470.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1981"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1982"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1983"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1984"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1985"><cfset temp2="1470.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1987"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1988"><cfset temp2="70.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1989"><cfset temp2="330.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1990"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1991"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1992"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3326"><cfset temp2="806.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1994"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1995"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1996"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1997"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1998"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-1999"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2000"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2002"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2003"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2005"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2006"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2008"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2009"><cfset temp2="520.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2010"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2012"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2013"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2015"><cfset temp2="288.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2016"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2017"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2021"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2024"><cfset temp2="875.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2026"><cfset temp2="875.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2027"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2028"><cfset temp2="875.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2030"><cfset temp2="3150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2031"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2032"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2033"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2034"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2036"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2038"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2039"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2040"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2041"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2042"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2044"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2045"><cfset temp2="640.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2046"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2047"><cfset temp2="970.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2049"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2050"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2051"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2052"><cfset temp2="372.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2053"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2054"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2055"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2056"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2057"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2059"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2060"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2061"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2062"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2063"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2066"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2068"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2069"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2070"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2071"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2072"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2073"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2074"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2075"><cfset temp2="1080.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2076"><cfset temp2="5000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2078"><cfset temp2="1575.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2079"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2080"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2081"><cfset temp2="1195.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2082"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2083"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3327"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2085"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2086"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2087"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2088"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2089"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2090"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2091"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2092"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2093"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2094"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2095"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2096"><cfset temp2="870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2097"><cfset temp2="400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2098"><cfset temp2="400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2099"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2100"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2102"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2103"><cfset temp2="1755.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2104"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2105"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2106"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2107"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2108"><cfset temp2="495.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2109"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2112"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2113"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2114"><cfset temp2="382.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2118"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2119"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2120"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2121"><cfset temp2="585.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2122"><cfset temp2="400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2123"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2125"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2126"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2127"><cfset temp2="881.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2128"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2129"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2130"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2131"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2132"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2133"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2134"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2135"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2136"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2137"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2138"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2139"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2140"><cfset temp2="248.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2141"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2142"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2143"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2144"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2145"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2146"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2147"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2148"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2149"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2150"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2151"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2152"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2153"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2154"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2155"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2156"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2157"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2158"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2159"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2160"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2161"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2162"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2163"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2164"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2165"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2166"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2167"><cfset temp2="487.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2168"><cfset temp2="230.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2169"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2170"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2171"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2172"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2174"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2175"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2176"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2178"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2179"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2180"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2181"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2182"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2183"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2184"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2185"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2186"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2187"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2188"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2189"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2190"><cfset temp2="1195.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2191"><cfset temp2="670.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2192"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2193"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2194"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2195"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2196"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2197"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2198"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2199"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2200"><cfset temp2="831.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2201"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2202"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2203"><cfset temp2="230.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2204"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2205"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2207"><cfset temp2="950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2208"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2209"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2210"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2211"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2212"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2213"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2214"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2215"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2216"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2217"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2218"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2219"><cfset temp2="517.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2220"><cfset temp2="590.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2221"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2222"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2223"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2224"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2225"><cfset temp2="558.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2226"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2227"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2228"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2229"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2230"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2231"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2232"><cfset temp2="7560.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2233"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2234"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2235"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2236"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2237"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2238"><cfset temp2="1900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2239"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2240"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2241"><cfset temp2="768.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2242"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2243"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2244"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2245"><cfset temp2="155.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2246"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2247"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2248"><cfset temp2="855.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2249"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2250"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2251"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2252"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2253"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2254"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2255"><cfset temp2="1210.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2256"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2257"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2258"><cfset temp2="403.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2259"><cfset temp2="372.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2260"><cfset temp2="350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2261"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2262"><cfset temp2="62.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2263"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2264"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2266"><cfset temp2="5760.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2267"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2268"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2269"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2270"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2271"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2272"><cfset temp2="4000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2274"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2275"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2276"><cfset temp2="1975.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2277"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2279"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2280"><cfset temp2="3000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2282"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2283"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2284"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2287"><cfset temp2="248.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2288"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2289"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2290"><cfset temp2="3210.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2291"><cfset temp2="1037.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2292"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2293"><cfset temp2="2700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2294"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2295"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2296"><cfset temp2="1260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2297"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2298"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2299"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2300"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2302"><cfset temp2="1755.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2303"><cfset temp2="2600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2304"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2305"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2306"><cfset temp2="62.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2308"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2309"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2310"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2311"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2312"><cfset temp2="175.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2313"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2314"><cfset temp2="80.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2315"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2316"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2317"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2318"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2319"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2321"><cfset temp2="620.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2323"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2324"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2325"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2326"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2327"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2328"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2332"><cfset temp2="1260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2333"><cfset temp2="2050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2334"><cfset temp2="1220.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2335"><cfset temp2="4050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2336"><cfset temp2="1630.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2337"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2338"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2339"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2340"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2341"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2342"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2343"><cfset temp2="300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2344"><cfset temp2="300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2345"><cfset temp2="1330.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2347"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2348"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2349"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2350"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2351"><cfset temp2="1140.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2352"><cfset temp2="2160.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2353"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2354"><cfset temp2="5040.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2355"><cfset temp2="600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2356"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2357"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2358"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2359"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2360"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2362"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2363"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2364"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2365"><cfset temp2="1510.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2366"><cfset temp2="446.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2367"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2368"><cfset temp2="4120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2369"><cfset temp2="675.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2370"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2371"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2372"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2373"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2374"><cfset temp2="720.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2375"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2377"><cfset temp2="960.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2378"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2379"><cfset temp2="3200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2380"><cfset temp2="1181.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2383"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2384"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2385"><cfset temp2="756.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2386"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2387"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2388"><cfset temp2="1480.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2390"><cfset temp2="912.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2391"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2392"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2393"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2394"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2395"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2396"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2397"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2398"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2399"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2400"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2401"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2402"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2403"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2404"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2405"><cfset temp2="431.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2406"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2407"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2408"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2409"><cfset temp2="820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2410"><cfset temp2="468.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2411"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2412"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2413"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2414"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2415"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2416"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2417"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2418"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2419"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2421"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2423"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2424"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2425"><cfset temp2="1470.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2426"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2427"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2428"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2429"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2430"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2431"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2432"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2433"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2434"><cfset temp2="350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2435"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2436"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2437"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2438"><cfset temp2="720.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2440"><cfset temp2="1440.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2441"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2442"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2443"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2444"><cfset temp2="893.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2445"><cfset temp2="921.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2446"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2447"><cfset temp2="2750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2449"><cfset temp2="850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2450"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2451"><cfset temp2="687.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2452"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2453"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2454"><cfset temp2="1370.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2455"><cfset temp2="1305.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2456"><cfset temp2="745.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2457"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2458"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2459"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2460"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2461"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2462"><cfset temp2="507.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2465"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2466"><cfset temp2="1698.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2467"><cfset temp2="618.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2468"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2469"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2470"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2473"><cfset temp2="1656.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2484"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2485"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2486"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2487"><cfset temp2="3960.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2488"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2489"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2490"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2491"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2495"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2496"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2497"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2498"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2499"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2500"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2501"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2502"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2503"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2505"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2506"><cfset temp2="438.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2508"><cfset temp2="1010.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2509"><cfset temp2="960.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2511"><cfset temp2="197.14">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2513"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2514"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2515"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2516"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2517"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2518"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2519"><cfset temp2="1680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2521"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2522"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2523"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2524"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2525"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2527"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2528"><cfset temp2="13600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2529"><cfset temp2="3010.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2530"><cfset temp2="4550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2531"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2532"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2533"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2534"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2535"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2536"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2537"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2538"><cfset temp2="4950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2539"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2540"><cfset temp2="1417.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2541"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2542"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2543"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2544"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2545"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2546"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2547"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2554"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2555"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2556"><cfset temp2="1240.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2557"><cfset temp2="3150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2558"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2559"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2560"><cfset temp2="1680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2562"><cfset temp2="675.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2563"><cfset temp2="675.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2564"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2565"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2566"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2567"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2568"><cfset temp2="2160.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2569"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2570"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2571"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2572"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2573"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2574"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2575"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2576"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2577"><cfset temp2="5880.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2578"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2579"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2580"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2581"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2583"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2584"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2585"><cfset temp2="621.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2586"><cfset temp2="621.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2587"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2588"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2589"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2590"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2591"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2592"><cfset temp2="525.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2593"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2595"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2596"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2597"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2598"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2599"><cfset temp2="315.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2600"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2601"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2602"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2604"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2605"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2606"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2608"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2609"><cfset temp2="612.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2610"><cfset temp2="428.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2611"><cfset temp2="411.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2612"><cfset temp2="180.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2613"><cfset temp2="2520.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2614"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2615"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2616"><cfset temp2="1530.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2617"><cfset temp2="1080.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2618"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2619"><cfset temp2="1190.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2620"><cfset temp2="4800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2621"><cfset temp2="960.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2622"><cfset temp2="3000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2623"><cfset temp2="3500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2639"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2640"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2643"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2644"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2645"><cfset temp2="1445.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2646"><cfset temp2="1445.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2647"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2648"><cfset temp2="1015.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2649"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2650"><cfset temp2="411.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2651"><cfset temp2="612.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2652"><cfset temp2="525.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2653"><cfset temp2="411.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2655"><cfset temp2="810.08">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2656"><cfset temp2="520.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2657"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2658"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2659"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2661"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2662"><cfset temp2="525.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2663"><cfset temp2="1445.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2664"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2665"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2666"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2668"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2669"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2670"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2671"><cfset temp2="855.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2672"><cfset temp2="2275.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2673"><cfset temp2="893.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2674"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2675"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2676"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2677"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2678"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2679"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2680"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2681"><cfset temp2="50.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2682"><cfset temp2="1170.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2684"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2685"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2686"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2687"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2688"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2689"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2690"><cfset temp2="1680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2691"><cfset temp2="6580.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2692"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2693"><cfset temp2="1620.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2695"><cfset temp2="1470.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2696"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2697"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2698"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2699"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2700"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2701"><cfset temp2="1280.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2702"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2703"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2704"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2705"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2706"><cfset temp2="3000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2707"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2708"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2709"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2710"><cfset temp2="1445.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2711"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2712"><cfset temp2="1425.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2713"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2714"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2715"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2716"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2718"><cfset temp2="1070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2720"><cfset temp2="6550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2721"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2723"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2724"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2728"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2730"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2731"><cfset temp2="4050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2732"><cfset temp2="2350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2733"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2734"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2735"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2736"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2738"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2739"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2740"><cfset temp2="1575.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2742"><cfset temp2="600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2743"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2745"><cfset temp2="1160.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2746"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2747"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2748"><cfset temp2="2475.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2749"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2750"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2751"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2752"><cfset temp2="1320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2754"><cfset temp2="1900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2756"><cfset temp2="586.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2757"><cfset temp2="1980.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2758"><cfset temp2="8460.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2759"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2760"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2761"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2762"><cfset temp2="375.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2764"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2766"><cfset temp2="791.63">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2767"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2768"><cfset temp2="37.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2769"><cfset temp2="75.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2770"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2771"><cfset temp2="315.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2772"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2773"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2774"><cfset temp2="1680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2775"><cfset temp2="5600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2776"><cfset temp2="2600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2777"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2778"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2779"><cfset temp2="1864.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2781"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2782"><cfset temp2="500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2783"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2784"><cfset temp2="4050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2785"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2786"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2787"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2788"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2789"><cfset temp2="7680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2790"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2791"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2792"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2793"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2794"><cfset temp2="1980.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2795"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2796"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2797"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2798"><cfset temp2="1674.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2800"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2801"><cfset temp2="650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2802"><cfset temp2="2976.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2803"><cfset temp2="3250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2804"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2805"><cfset temp2="3600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2808"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2811"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2813"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2814"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2816"><cfset temp2="3024.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2818"><cfset temp2="2976.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2819"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2820"><cfset temp2="2655.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2821"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2823"><cfset temp2="2739.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2824"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2825"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2827"><cfset temp2="2871.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2828"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2829"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2830"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2831"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2832"><cfset temp2="744.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2833"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2834"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2836"><cfset temp2="1116.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2837"><cfset temp2="1604.06">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2838"><cfset temp2="4620.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2841"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2842"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2844"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2845"><cfset temp2="240.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2846"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2847"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2849"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2850"><cfset temp2="1100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2851"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2852"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2853"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2854"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2855"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2856"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2857"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2858"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2859"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2860"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2861"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2862"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2863"><cfset temp2="1760.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2864"><cfset temp2="850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2865"><cfset temp2="663.75">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2866"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2867"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2868"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2869"><cfset temp2="3150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2870"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2871"><cfset temp2="1680.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2873"><cfset temp2="1260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2874"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2875"><cfset temp2="2770.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2876"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2877"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2878"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2879"><cfset temp2="542.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2881"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2882"><cfset temp2="360.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2884"><cfset temp2="1260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2885"><cfset temp2="2850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2886"><cfset temp2="1980.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2887"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2888"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2890"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2891"><cfset temp2="2320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2892"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2893"><cfset temp2="2850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2894"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2895"><cfset temp2="350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2898"><cfset temp2="6000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2899"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2900"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2901"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2902"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2903"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2904"><cfset temp2="350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2906"><cfset temp2="1645.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2908"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2909"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2910"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2911"><cfset temp2="2160.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2912"><cfset temp2="3000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2913"><cfset temp2="3000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2914"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2915"><cfset temp2="3780.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2917"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2918"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2919"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2920"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2921"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2922"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2923"><cfset temp2="1000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2924"><cfset temp2="1250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2925"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2926"><cfset temp2="1950.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2928"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2929"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2930"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2931"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2932"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2933"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2935"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2936"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2938"><cfset temp2="18000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2940"><cfset temp2="2800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2941"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2942"><cfset temp2="2112.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2943"><cfset temp2="825.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2944"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2945"><cfset temp2="1320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2946"><cfset temp2="1470.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2947"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2948"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2949"><cfset temp2="1221.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2950"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2951"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2954"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2955"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2956"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2957"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2958"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2959"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2960"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2961"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2963"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2964"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2966"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2967"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2968"><cfset temp2="1260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2969"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2970"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2971"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2972"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2973"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2974"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2975"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2976"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2977"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2978"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2982"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2983"><cfset temp2="150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2984"><cfset temp2="2205.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2985"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2986"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2987"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2988"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2989"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2990"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2992"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2993"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2994"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2995"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2997"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2998"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-2999"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3000"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3002"><cfset temp2="870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3004"><cfset temp2="1820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3005"><cfset temp2="1820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3006"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3007"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3008"><cfset temp2="810.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3009"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3010"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3012"><cfset temp2="4150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3013"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3014"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3015"><cfset temp2="2970.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3016"><cfset temp2="3210.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3017"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3019"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3020"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3022"><cfset temp2="1420.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3025"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3026"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3027"><cfset temp2="1550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3028"><cfset temp2="1025.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3030"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3031"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3032"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3034"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3035"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3036"><cfset temp2="8650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3037"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3038"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3040"><cfset temp2="2170.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3041"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3043"><cfset temp2="1395.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3044"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3045"><cfset temp2="1920.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3048"><cfset temp2="1870.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3049"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3051"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3052"><cfset temp2="337.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3053"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3054"><cfset temp2="390.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3066"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3069"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3070"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3071"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3072"><cfset temp2="1575.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3073"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3074"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3075"><cfset temp2="1650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3077"><cfset temp2="675.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3078"><cfset temp2="840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3080"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3083"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3084"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3085"><cfset temp2="1740.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3086"><cfset temp2="2020.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3087"><cfset temp2="2850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3088"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3089"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3090"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3091"><cfset temp2="2310.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3092"><cfset temp2="1170.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3093"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3094"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3095"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3096"><cfset temp2="3150.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3097"><cfset temp2="2655.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3098"><cfset temp2="2655.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3099"><cfset temp2="2840.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3102"><cfset temp2="1270.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3104"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3105"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3106"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3107"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3108"><cfset temp2="750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3109"><cfset temp2="5760.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3111"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3112"><cfset temp2="1195.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3113"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3114"><cfset temp2="6000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3115"><cfset temp2="3600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3116"><cfset temp2="6000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3117"><cfset temp2="2200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3119"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3120"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3121"><cfset temp2="2250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3122"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3123"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3124"><cfset temp2="4050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3125"><cfset temp2="385.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3126"><cfset temp2="3060.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3127"><cfset temp2="1820.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3128"><cfset temp2="880.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3129"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3130"><cfset temp2="1300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3131"><cfset temp2="1600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3132"><cfset temp2="18.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3134"><cfset temp2="4960.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3137"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3138"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3139"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3140"><cfset temp2="2430.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3142"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3143"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3144"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3145"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3146"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3147"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3148"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3149"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3150"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3151"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3152"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3153"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3154"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3155"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3156"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3157"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3158"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3159"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3161"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3162"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3163"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3164"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3165"><cfset temp2="945.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3166"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3167"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3168"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3169"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3170"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3171"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3172"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3173"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3174"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3175"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3176"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3177"><cfset temp2="700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3178"><cfset temp2="355.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3179"><cfset temp2="2700.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3180"><cfset temp2="1106.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3181"><cfset temp2="3355.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3184"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3185"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3186"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3187"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3189"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3190"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3191"><cfset temp2="2400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3192"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3193"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3194"><cfset temp2="1290.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3195"><cfset temp2="345.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3197"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3199"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3200"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3201"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3203"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3206"><cfset temp2="2600.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3207"><cfset temp2="4500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3208"><cfset temp2="2070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3209"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3210"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3211"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3214"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3215"><cfset temp2="850.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3217"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3218"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3219"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3220"><cfset temp2="1200.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3222"><cfset temp2="3630.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3223"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3224"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3225"><cfset temp2="3300.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3226"><cfset temp2="3070.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3227"><cfset temp2="720.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3228"><cfset temp2="2320.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3229"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3230"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3231"><cfset temp2="462.50">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3232"><cfset temp2="1570.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3236"><cfset temp2="2500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3241"><cfset temp2="1269.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3242"><cfset temp2="650.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3243"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3244"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3245"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3246"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3247"><cfset temp2="900.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3248"><cfset temp2="1750.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3249"><cfset temp2="1350.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3251"><cfset temp2="4000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3252"><cfset temp2="581.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3253"><cfset temp2="2000.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3254"><cfset temp2="4260.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3255"><cfset temp2="800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3256"><cfset temp2="2100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3257"><cfset temp2="1400.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3258"><cfset temp2="1800.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3259"><cfset temp2="1575.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3260"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3262"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3263"><cfset temp2="1330.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3264"><cfset temp2="2418.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3265"><cfset temp2="2418.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3267"><cfset temp2="1500.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3268"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3269"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3271"><cfset temp2="100.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3272"><cfset temp2="450.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3273"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3274"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3275"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3276"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3277"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3278"><cfset temp2="0.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3299"><cfset temp2="1690.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3311"><cfset temp2="180.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3312"><cfset temp2="461.25">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3314"><cfset temp2="550.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3315"><cfset temp2="1050.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3316"><cfset temp2="250.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3317"><cfset temp2="806.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3318"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3319"><cfset temp2="930.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3320"><cfset temp2="1120.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3321"><cfset temp2="806.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3322"><cfset temp2="434.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3323"><cfset temp2="930.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3324"><cfset temp2="744.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
<cfset temp1="18-3325"><cfset temp2="868.00">
<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">SELECT SUM(oi.item_inv_total) as ca FROM orders o INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id INNER JOIN account a ON o.account_id = a.account_id INNER JOIN account_group ag ON ag.group_id = a.group_id INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id WHERE o.order_ref = '#temp1#' </cfquery>	
<cfif get_ca_status.ca neq temp2>temp1 = #temp1# // temp2 = #temp2# // bdd = #get_ca_status.ca#<br><br></cfif>
</cfoutput>