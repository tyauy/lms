<meta charset="utf-8" />

<link rel="apple-touch-icon" sizes="76x76" href="./assets/favicon.png">
<link rel="icon" type="image/x-icon" href="./assets/favicon.ico">

<title>*WEFIT LMS*</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />

<!--- Fonts and icons --->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Titillium+Web:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />

<!--- <script src="https://kit.fontawesome.com/df41bd149d.js" crossorigin="anonymous"></script> --->
<script src="https://kit.fontawesome.com/ef9bd4f9c6.js" crossorigin="anonymous"></script>

<!--- VUE --->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">


<!--- CSS Files --->
<!--- <link href="./assets/css/bootstrap-4.5.3/bootstrap.min.css" rel="stylesheet" /> --->

<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<link href="./assets/css/flags/flags.css" rel="stylesheet">	
<link href="./assets/css/flags.css" rel="stylesheet">	
<link href="./assets/css/custom.css" rel="stylesheet" />

<!--- CSS Calendar --->
<link href="./assets/js/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet" />
<link href="./assets/js/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print" />	
<link href="./assets/js/fullcalendar-scheduler-1.9.4/scheduler.css" rel="stylesheet" />
<!--- CSS Datatable--->
<!---<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css"/>--->

<!--- CSS Multiselect --->
<link href="./assets/js/bootstrap-multiselect-master/dist/css/bootstrap-multiselect.css" type="text/css" rel="stylesheet">

<!--- CSS TypeAHEAD ---->
<link href="./assets/js/jquery-typeahead-2.10.6/dist/jquery.typeahead.min.css" rel="stylesheet" />

<!--- JQUERY UI --->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!--- TIMEPICKER ADDON --->
<link href="./assets/js/timepicker/timepicker.css" rel="stylesheet" />

<!--- STARRR --->
<link href="./assets/js/starrr/starrr.css" rel="stylesheet">	


<link  rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>

<cfif isdefined("SESSION.USER_PROFILE")>
  <cfif SESSION.USER_PROFILE eq "TRAINER" OR SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "TEST">
    <!-- Sendinblue Conversations {literal} -->
    <script>
    (function(d, w, c) {
        w.SibConversationsID = '5d0894d318a79992d85b61b4';
        w[c] = w[c] || function() {
            (w[c].q = w[c].q || []).push(arguments);
        };
        var s = d.createElement('script');
        s.async = true;
        s.src = 'https://conversations-widget.sendinblue.com/sib-conversations.js';
        if (d.head) d.head.appendChild(s);
    })(document, window, 'SibConversations');
    </script>
    <!-- /Sendinblue Conversations {/literal} -->
  </cfif>
</cfif>

