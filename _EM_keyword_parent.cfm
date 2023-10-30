<!DOCTYPE html>
<html>
<head>
    <title>Assign Parent Keywords</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(document).ready(function(){
        $('#keyword-select').change(function(){
            var keyword_id = $(this).val();
            console.log('Selected keyword_id:', keyword_id);
            $.get("_EM_assignParents.cfm", { key: 1, keyword_id: keyword_id },
            function(data){
                    $("#parent-keywords").empty().html(data);
                }

            ).fail(function(xhr, status, error) {
                console.log('AJAX error:', error);
            });
        });

        $(document).on('change', '.parent-checkbox', function() {
            var keyword_id = $(this).data('keyword');
            var parent_id = $(this).data('parent');
            var checked = $(this).is(':checked') ? 1 : 0;

            $.post("_EM_assignParents.cfm", { keyword_id: keyword_id, parent_id: parent_id, checked: checked },
                function(data){
                    alert("Parent keyword updated successfully!");
                }
            );
        });
    });
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1>Assign Parent Keywords</h1>
        
        <cfquery name="getAllKeywords" datasource="#SESSION.BDDSOURCE#">
            SELECT keyword_id, keyword_name_en
            FROM lms_keyword2
            where keyword_cat_id=3
            order by keyword_name_en asc
        </cfquery>

        <div class="form-group">
            <label for="keyword-select">Select Keyword:</label>
            <select class="form-control" id="keyword-select">
                <option value="">-- Select --</option>
                <cfoutput query="getAllKeywords">
                    <option value="#getAllKeywords.keyword_id#">#getAllKeywords.keyword_name_en#</option>
                </cfoutput>
            </select>
        </div>

        <div id="parent-keywords">
            <!-- Parent keywords checkboxes will be loaded here -->
        </div>
        
        <hr>
        
        <h2>Parent Keywords and Their Children</h2>
<!-- Start of Bootstrap row -->
<div class="row">
    <!-- Get all keywords that have at least one child -->
    <cfquery name="getAllParentKeywords" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT k1.keyword_id, k1.keyword_name_en
        FROM lms_keyword2 AS k1
        INNER JOIN lms_keyword2 AS k2
        ON CONCAT(',', k2.parent_id, ',') LIKE CONCAT('%,', k1.keyword_id, ',%')
    </cfquery>

    <!-- For each parent keyword, get its child keywords -->
    <cfoutput query="getAllParentKeywords">
        <!-- Each parent keyword and its children will occupy 4 columns (12 / 3 = 4) -->
        <div class="col-md-4">
            <cfquery name="getChildKeywords" datasource="#SESSION.BDDSOURCE#">
                SELECT keyword_name_en
                FROM lms_keyword2
                WHERE CONCAT(',', parent_id, ',') LIKE CONCAT('%,', <cfqueryparam value="#getAllParentKeywords.keyword_id#" cfsqltype="CF_SQL_INTEGER">, ',%')
            </cfquery>
            
            <h3>#getAllParentKeywords.keyword_name_en#</h3>
            <ul>
                <cfloop query="getChildKeywords">
                    <li>#getChildKeywords.keyword_name_en#</li>
                </cfloop>
            </ul>
        </div>
        
        <!-- Add a clearfix for every third parent keyword to ensure that the rows line up correctly -->
        <cfif getAllParentKeywords.currentRow MOD 3 IS 0>
            <div class="clearfix"></div>
        </cfif>
    </cfoutput>
</div> <!-- End of Bootstrap row -->



    </div>
</body>
</html>
