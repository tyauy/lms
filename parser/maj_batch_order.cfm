
<cfprocessingdirective pageencoding = "utf-8">

<html lang="fr">
	<head>
		<meta charset="utf-8" />
		<link rel="apple-touch-icon" sizes="76x76" href="../assets/favicon.png">
		<link rel="icon" type="image/x-icon" href="../assets/favicon.ico">

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title>*WEFIT LMS*</title>
		<meta content=\\'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no\\' name=\\'viewport\\' />
		<!-- Fonts and icons -->

		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
		<link href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous" rel="stylesheet">


	</head>

<body>

<div class="wrapper">
<div class="main-panel">




</div>
</div>

<!---   CORE JS Files   --->
<script src="../assets/js/core/jquery.min.js"></script>
<script src="../assets/js/core/popper.min.js"></script>
<script src="../assets/js/core/bootstrap.min.js"></script>
<script src="../assets/js/plugins/bootstrap-notify.js"></script>
<script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>

<script>
$(document).ready(function() {
    console.log( "ready!" );
	

	function getData(ajaxurl) { 
		return $.ajax({
			url: ajaxurl,
			type: "GET",
		});
	};

	async function import_go() {
		try {
			var list = $(".main-panel a");
			for (let index = 0; index < list.length; index++) {
				const element = list.eq(index);
				const res = await getData(element.attr("href"));
				<!---console.log(res);--->
			}
		} catch(err) {
			console.log(err);
		}
	}

	import_go();
	
});

</script>
		
		