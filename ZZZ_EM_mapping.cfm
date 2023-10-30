<cfquery name="get_quiz_mapping" datasource="#SESSION.BDDSOURCE#">
SELECT
q.quiz_name,
q.quiz_type,
sm.sessionmaster_name,
sm.sessionmaster_id,
m.mapping_name,
g.grammar_name<!---,
k.keyword_name_en--->
FROM
lms_quiz q
INNER JOIN lms_sessionmaster_grammarid_cor sg ON q.sessionmaster_id = sg.sessionmaster_id
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = sg.sessionmaster_id
INNER JOIN lms_grammar_mapping_cor gm ON sg.grammar_id = gm.lms_grammar_id
INNER JOIN lms_mapping m ON gm.lms_mapping_id = m.mapping_id
INNER JOIN lms_grammar g ON gm.lms_grammar_id = g.grammar_id
<!---INNER JOIN lms_sessionmaster_keywordid_cor sk ON q.sessionmaster_id = sk.sessionmaster_id
INNER JOIN lms_keyword k ON sk.keyword_id = k.keyword_id--->
INNER JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
INNER JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id

WHERE tm.tpmaster_id IN
(
11,
12,
13,
14
)
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Output Table</title>
    <!-- Include Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <cfset rowNumber = 0>
        <h1>Output Table</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Quiz Name</th>
                    <th scope="col">Sessionmaster_name</th>
                    <th scope="col">Type</th>
                    <th scope="col">Mapping Name</th>
                    <th scope="col">Grammar Name</th>
                  
                </tr>
            </thead>
            <tbody>
                <cfoutput query="get_quiz_mapping" group="quiz_name">
                    <cfset rowNumber++>
                    <tr>
                        <td>#rowNumber#</td>
                        <td>#quiz_name#</td>
                        <td>#sessionmaster_name#</td>
                        <td>#quiz_type#</td>
                        <td>
                            <cfoutput>
                                #mapping_name#<br>
                            </cfoutput>
                        </td>
                        <td>
                            <cfoutput>
                                #grammar_name#<br>
                            </cfoutput>
                        </td>
                        <!--- <td>
                            <cfoutput>
                                #keyword_name_en#<br>
                            </cfoutput>
                        </td> --->
                    </tr>
                </cfoutput>
            </tbody>
        </table>
        
    </tbody>
</table>

<cfif totalPages gt 1>
    <nav>
        <ul class="pagination justify-content-center">
            <li class="page-item<cfif currentPage eq 1> disabled</cfif>">
                <a class="page-link" href="#" data-page="1" aria-label="First">
                    <span aria-hidden="true">&laquo;</span>
                    <span class="sr-only">First</span>
                </a>
            </li>
            <cfif totalPages le 5>
                <!-- Output all page numbers if there are 5 or fewer pages -->
                <cfloop from="1" to="#totalPages#" index="pageNumber">
                    <li class="page-item<cfif pageNumber eq currentPage> active</cfif>">
                        <a class="page-link" href="#" data-page="#pageNumber#"><cfoutput> #pageNumber#</cfoutput></a>
                    </li>
                </cfloop>
            <cfelse>
                <!-- Output up to 5 page numbers with ellipsis if there are more than 5 pages -->
                <cfif currentPage gt 3>
                    <li class="page-item disabled">
                        <a class="page-link">...</a>
                    </li>
                </cfif>
                <cfloop from="#max(currentPage - 2, 1)#" to="#min(currentPage + 2, totalPages)#" index="pageNumber">
                    <li class="page-item<cfif pageNumber eq currentPage> active</cfif>">
                        <a class="page-link" href="#" data-page="#pageNumber#"><cfoutput>  #pageNumber#</cfoutput></a>
                    </li>
                </cfloop>
                <cfif currentPage lt totalPages - 2>
                    <li class="page-item disabled">
                        <a class="page-link">...</a>
                    </li>
                </cfif>
                <li class="page-item<cfif currentPage eq totalPages> active</cfif>">
                    <a class="page-link" href="#" data-page="#totalPages#"><cfoutput> #totalPages#</cfoutput></a>
                </li>
            </cfif>
            <li class="page-item<cfif currentPage eq totalPages> disabled</cfif>">
                <a class="page-link" href="#" data-page="#min(currentPage + 1, totalPages)#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                </a>
            </li>
        </ul>
    </nav>
</cfif>


        </div>

     
    
        <!-- Include Bootstrap 4 JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>

                // Handle checkbox change event
            $('input[name="selected_mappings"]').click(function() {
                alert("clicked")
                var mappingName = $(this).val();
                var quizQuestionId = $(this).data('quiz-question-id');
                var isCorrect = $(this).prop('checked') ? 1 : 0;
                $.ajax({
                    url: '_EM_update_mapping_ajax.cfm',
                    type: 'POST',
                    data: {
                        mapping_name: mappingName,
                        quiz_question_id: quizQuestionId,
                        is_correct: isCorrect
                    },
                    success: function(data) {
                        alert("Record updated successfully");
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("Error updating record: " + textStatus);
                    }
                });
            });
         $(function() {
            // Define function to show/hide table rows based on current page
            function showPage(page) {
                var rows = $('table tbody tr');
                var start = (page - 1) * <%=itemsPerPage%>;
                var end = start + <%=itemsPerPage%>;
                rows.hide();
                rows.slice(start, end).show();
            }
    
                // Show first page by default
                var currentPage = 1;
                showPage(currentPage);
                
            

    
    // Handle pagination links click event
    $('ul.pagination a.page-link').click(function(event) {
        event.preventDefault();
        var page = $(this).data('page');
        if (page == 'prev' && currentPage > 1) {
            currentPage--;
        } else if (page == 'next' && currentPage < <%=totalPages%>) {
            currentPage++;
        } else if (page != 'prev' && page != 'next' && page != currentPage) {
            currentPage = page;
        }
        showPage(currentPage);
        $('ul.pagination li').removeClass('active');
        $('ul.pagination a.page-link[data-page="'+currentPage+'"]').parent().addClass('active');
        $('ul.pagination a.page-link[data-page="prev"]').attr('data-page', currentPage > 1 ? currentPage - 1 : 1);
        $('ul.pagination a.page-link[data-page="next"]').attr('data-page', currentPage < <%=totalPages%> ? currentPage + 1 : <%=totalPages%>);
    });
    
});

            
        </script>
    </body>
    </html>
    