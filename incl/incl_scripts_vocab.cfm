
<style>
    .highlight{
        background-color: #F8A1A8 !important;
    }
    .sticky-header {
        position: sticky;
        top: 0;
        background-color: inherit;
        z-index: 100;
    }
    .typeahead__container {
    z-index: 101; 
    }

    </style><link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
<script type="text/javascript" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function() {

        // Hide translation for selected language
                      // Function to handle the change event
    function handleLangSelectChange() {
        // Reset all options to be visible first in the associated translate dropdown
        let $translateDropdown = $(this).closest('.d-inline-block').next('.d-inline-block').find('.translate');
        $translateDropdown.find('option').show();

        // Get the selected language
        let selectedLang = $(this).val();

        // Hide the selected language in the associated translate dropdown
        $translateDropdown.find('option[value="' + selectedLang + '"]').hide();
    }

    // Add event listener to the .lang_select dropdown
    $('.lang_select').on('change', handleLangSelectChange);

    // Initial setup: Hide the initially selected language in the associated translate dropdown
    $('.lang_select').each(function() {
        let initialLang = $(this).val();
        let $translateDropdown = $(this).closest('.d-inline-block').next('.d-inline-block').find('.translate');
        $translateDropdown.find('option[value="' + initialLang + '"]').hide();
    });

        // Count the number of columns in the table
        var columnCount = $('.table-pdf thead tr th').length;

        // Set the "columnDefs" option based on the number of columns
        var columnDefs;
        if (columnCount === 7) {
            columnDefs = [{ "orderable": false, "targets": [3, 4, 6] }];
        } else if (columnCount === 6) {
            columnDefs = [{ "orderable": false, "targets": [3, 4, 5] }];
        }

        $('.table-pdf').DataTable({
            "order": [[ 0, "asc" ]] ,// Default order by the first column (v.voc_word)
            "columnDefs": columnDefs,
            "searching": false, // Disable the search functionality
            "paging": false     // Disable the pagination functionality
        });


        $('.btn_rm_uvoc').click(function(e) {
               // Get the "id" attribute of the clicked button
                var buttonId = $(this).attr("id");

                // Split the button id by "_"
                var idParts = buttonId.split("_");

                // Assign the first and second parts to the "uid" and "vid" variables
                var uid = idParts[0];
                var vid = idParts[1];
                
            $.ajax({
                url: './components/vocabulary_perso.cfc?method=rm_user_voc',
                type: 'POST',
                data: {
                    act: "rm_user_voc",
                    uid: uid,
                    vid: vid
                },
                success: function(result, status) {
                    $('#alert-container').html('<div class="alert alert-info alert-dismissible fade show" role="alert" id="success-alert"><i class="fa-thin fa-thumbs-up"></i> Removed <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                // Remove the corresponding 'tr' element/line
                $('#' + buttonId).closest('tr').remove();
                // Fade out the alert after 5 seconds
                    setTimeout(function() {
                        $("#success-alert").alert('close');
                    }, 3000);
                }
            }); 
        });
        // When the language select element changes, update the language and redirect to the current page
        $(document).on('change', '.lang_select', function(e) {

            var lang_select = $(this).val();
        
            // Update the URL query string with the selected language
            updateQueryString('lang_select', lang_select);

            
        $("#container_table_"+cat_id).val(lang_translate);
        

        });

        // When the translate select element changes, update the language and redirect to the current page
        $(document).on('change', '.translate', function() {

            console.log('hello translate')

            var lang_translate = $(this).val();
            
            // Update the URL query string with the selected language
            updateQueryString('lang_translate', lang_translate);

        });

        // When the vocabulary category select element changes, redirect to the current page with the selected category
        $('.voc_category').change(function(event) {
            var cat_id = $(this).val();
            // Update the URL query string with the selected category
            updateQueryString('cat_id', cat_id);

        });

        // Set the language, translation and category selections on the page based on the values in the URL query string
        var urlParams = new URLSearchParams(window.location.search);
        var language = urlParams.get('lang_select');
        if (language) {
            $("#lang_select").val(language);
        }
        var cat_id = urlParams.get('cat_id');
        if (cat_id) {
            $("#category").val(cat_id);
        }
        var trad = urlParams.get('lang_translate');
        if (trad) {
            $("#lang_translate").val(lang_translate);
        }
    });

    // Update the URL query string with a specified key and value
            function updateQueryString(key, value) {
            console.log("Updating key:", key, "with value:", value);
            
            var urlParams = new URLSearchParams(window.location.search);
            urlParams.set(key, value);
            
            console.log("Resulting URL:", window.location.origin + window.location.pathname + "?" + urlParams.toString());
            
            window.location.search = urlParams.toString();
        }

    // When a play button is clicked, play the corresponding audio file
    $('.btn_player').click(function(e) {

        // Get the id of the play button
        var idtemp = $(this).data("id");
        console.log(idtemp);
        // Split the id into an array of language code, accent id, and vocabulary word id
        var idtemp = idtemp.split("_");
        // Get the language code, accent id, and vocabulary word id from the array
        var lang_code = idtemp[1];
        var accent_id = idtemp[2];
        var voc_id = idtemp[3];
        console.log("play_" + lang_code + "_" + accent_id + "_" + voc_id);
        // Play the audio file with the corresponding id
        $("#play_" + lang_code + "_" + accent_id + "_" + voc_id).get(0).play();

    });


    // Listen for clicks on elements with the class "btn_add_uvoc"
    $(document).on("click", ".btn_add_uvoc", function() {

        // Get the "id" attribute of the clicked button
        var buttonId = $(this).attr("id");

        // Split the button id by "_"
        var idParts = buttonId.split("_");

        // Assign the first and second parts to the "uid" and "vid" variables
        var uid = idParts[0];
        var vid = idParts[1];

        // Get the class of the clicked button
        var buttonClass = $(this).attr("class");

        // Check if the heart is empty
        if (buttonClass === "fa fa-heart-o red btn_add_uvoc cursored") {
            // Make an AJAX call to add the vocabulary item to the user's personal list
            $.ajax({
                url: './components/vocabulary_perso.cfc?method=add_user_voc',
                type: 'POST',
                data: {
                    act: "add_user_voc",
                    uid: uid,
                    vid: vid
                },
                success: function(result, status) {
                    if (window.showAlerts) {
                        // Show the alert
                        $('#alert-container').html('<div class="alert alert-success alert-dismissible fade show" role="alert" id="success-alert-add"><i class="fa-thin fa-thumbs-up"></i> Added <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                        setTimeout(function() {
                            $("#success-alert-add").alert('close');
                        }, 3000);
                    }
                }
            });

            // Update the class of the button to indicate that the vocabulary item has been added, full heart
            $(this).attr('class', 'fa-sharp fa-solid fa-heart btn_add_uvoc red cursored');
        } else {
            // Make an AJAX call to remove the vocabulary item from the user's personal list
            $.ajax({
                url: './components/vocabulary_perso.cfc?method=rm_user_voc',
                type: 'POST',
                data: {
                    act: "rm_user_voc",
                    uid: uid,
                    vid: vid
                },
                success: function(result, status) {
                    if (window.showAlerts) {
                    $('#alert-container').html('<div class="alert alert-info alert-dismissible fade show" role="alert" id="success-alert-rm"><i class="fa-thin fa-thumbs-up"></i> Removed <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                    setTimeout(function() {
                        $("#success-alert-rm").alert('close');
                    }, 3000);
                }
                 }
            });

            // Update the class of the button to indicate that the vocabulary item has been removed, empty heart
            $(this).attr('class', 'fa fa-heart-o red btn_add_uvoc cursored');
        }

    
    });


</script>