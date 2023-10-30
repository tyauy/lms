<cfcomponent>
    <cffunction name="ogetDetailedLearningPlans" access="remote" returnType="any" returnFormat="json">
        <cfargument name="employee" type="numeric" required="no" default="0">
        <cfargument name="startDate" type="date" required="no" default="#createDate(1900,1,1)#">
        <cfargument name="endDate" type="date" required="no" default="#createDate(2999,12,31)#">
        <cfargument name="status" type="numeric" required="no" default="0">
      
        <cfparam name="FORM.draw" default="1">
        <cfparam name="FORM.start" default="0">
        <cfparam name="FORM.length" default="10">
        
        <cfset draw = FORM.draw>
        <cfset start = FORM.start>
        <cfset length = FORM.length>
        
        <cfquery name="getDetailedData" datasource="#SESSION.BDDSOURCE#">
        SELECT 
        CONCAT(u.user_name, ' ', u.user_firstname) AS employee_name, 
            u2.user_name as trainer_name, 
            l.lesson_id, 
            l.STATUS_ID,
            u.USER_ID,  
            l.PLANNER_ID,
            l.LESSON_START,
            l.LESSON_END,
            l.LESSON_NAME,
            l.LESSON_DURATION
        FROM 
            lms_lesson2 l  
        INNER JOIN 
            user u ON u.user_id = l.user_id
        INNER JOIN 
            user u2 ON u2.user_id = l.planner_id
        WHERE 
            1=1 
        AND 
            (
                <cfif ARGUMENTS.employee NEQ 0>
                    u.user_id = <cfqueryparam value="#ARGUMENTS.employee#" cfsqltype="CF_SQL_INTEGER">
                <cfelse>
                    1=1  
                </cfif>
            )
        AND 
            l.lesson_start BETWEEN <cfqueryparam value="#ARGUMENTS.startDate#" cfsqltype="CF_SQL_DATE"> 
                                AND <cfqueryparam value="#ARGUMENTS.endDate#" cfsqltype="CF_SQL_DATE">
        AND 
            l.status_id = <cfqueryparam value="#ARGUMENTS.status#" cfsqltype="CF_SQL_INTEGER">  -- Here, prefix status_id with the table alias

            LIMIT #length# OFFSET #start# 
        </cfquery>
    
        
    
        <!-- Ensure only the JSON string is returned -->
        <cfcontent type="application/json; charset=utf-8">
        <cfset responseData = {
            draw = draw,
            recordsTotal = getDetailedData.recordcount,
            recordsFiltered = getDetailedData.recordcount, 
            data = []
        }>
        
        <cfloop query="getDetailedData">
            <cfset arrayAppend(responseData.data, {
                lesson_id = lesson_id,
                lesson_start = lesson_start,
                employee_name = employee_name,
                trainer_name = trainer_name,
                status_id = status_id
            })>
        </cfloop>
        
        <cfoutput>#serializeJSON(responseData)#</cfoutput>
        
        <cfabort> <!-- Ensure nothing else is processed or outputted after this point -->
    </cffunction>
</cfcomponent>

<script>
    
    $('#filtersForm').on('submit', function(e) {
        e.preventDefault();
        table.ajax.reload();  // Just reload the table data when filters are applied
    });

    var table = $('#learningPlansTable').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: 'api/EM/TM_reports.cfc?method=ogetDetailedLearningPlans',
            type: 'POST',
            data: function(d) {
                var selectedMonthYear = $('#monthSelection').val().split('-');
                var year = selectedMonthYear[0];
                var month = selectedMonthYear[1];

                var startDate = new Date(year, month - 1, 1);
                var endDate = new Date(year, month, 0);

                d.startDate = startDate.toISOString().split('T')[0];
                d.endDate = endDate.toISOString().split('T')[0];
                d.employee = $('#employee').val();
                d.status = $('#status').val();
            },
            dataFilter: function(data) {
                var json = jQuery.parseJSON(data);
                json.recordsTotal = json.RECORDSTOTAL;
                json.recordsFiltered = json.RECORDSFILTERED;
                json.draw = json.DRAW;
                json.data = json.DATA;
                return JSON.stringify(json);
            }
        },
        columns: [
            {data: 'LESSON_ID'},
            {data: 'LESSON_START'},
            {data: 'EMPLOYEE_NAME'},
            {data: 'TRAINER_NAME'},
            {data: 'STATUS_ID'}
        ]
    });
</script>

success: function(data) {
    console.log(data);  // Log the returned data to console

    // Clear the existing data
    table.clear().draw();

    // Check if expected data properties exist before proceeding
    if (data && data.DATA && data.COLUMNS) {
        var columns = data.COLUMNS;
        data.DATA.forEach(function(rowData) {
            var row = {};
            columns.forEach(function(column, index) {
                row[column] = rowData[index];
            });
            
            // Log each constructed row object to console
            console.log(row);

            // Add checks for each property and set to N/A if undefined
            var statusBadge = row.STATUS_CSS && row.STATUS_NAME 
                ? '<span class="badge badge-' + row.STATUS_CSS + '">' + row.STATUS_NAME + '</span>' 
                : 'N/A';
            var plannerName = row.TRAINER_NAME || 'N/A';
            var userName = row.EMPLOYEE_NAME
                ? row.EMPLOYEE_NAME 
                : 'N/A';
            var tpInfo = row.TP_ID !== "" 
                ? row.TP_ICON_HTML  // Adjust TP_ICON_HTML as needed 
                : 'N/A';  
            var sessionMasterName = row.SESSIONMASTER_NAME 
                ? (row.SESSIONMASTER_NAME.length > 25 ? row.SESSIONMASTER_NAME.substring(0, 25) + '...' : row.SESSIONMASTER_NAME) 
                : 'N/A';
            var methodIcon = row.METHOD_ID 
                ? '<img src="./assets/img/picto_methode_' + row.METHOD_ID + '.png" width="20" style="margin-right:2px">' 
                : 'N/A';
            var lessonStart = row.LESSON_START 
                ? moment(row.LESSON_START).format('DD/MM/YYYY HH:mm') 
                : 'N/A';
            var lessonDuration = row.LESSON_DURATION 
                ? row.LESSON_DURATION + ' min' 
                : 'N/A';

            // Now populate the DataTable with row data as needed
            table.row.add([
                statusBadge,
                plannerName,
                userName,
                tpInfo,
                sessionMasterName,
                methodIcon,
                lessonStart,
                lessonDuration
                // Add more cells as needed
            ]).draw();
        });
    }
}
