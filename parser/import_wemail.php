<?php
if (($handle = fopen("/home/www/winegroup/www/manager/lms3/parser/wemail.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ";")) !== FALSE /*&& $row < 15*/) {
			$num = count($data);
			/*echo "<p> $num fields in line $row: <br /></p>\n";*/
			$row++;
			if($row > 0 /*&& $row < 15*/)
			{
				/*for ($c=0; $c < $num; $c++) {
					echo $data[$c] . "<br />\n";*/
					
$emb_id = $data[0];
echo $emb_id."<br>";
/*$email = mysqli_real_escape_string($link, $data[1]);
$gender = mysqli_real_escape_string($link, $data[2]);
$lastname = mysqli_real_escape_string($link, $data[3]);*/

				}
			}
		}


?>