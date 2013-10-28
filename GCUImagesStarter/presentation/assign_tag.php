<?php

$response = "";
//get the q parameter from URL
if (  isset($_GET["tag_id"]) && isset($_GET["image_id"] )  ) {

	$tag_id=$_GET["tag_id"];
	$image_id=$_GET["image_id"];
	
	$con=mysqli_connect("localhost","imagesadmin","imagesadmin","gcuimages");
	if (mysqli_connect_errno()){
	  $response = "Failed to connect to MySQL: " . mysqli_connect_error();
	  //exit;
	}

	$response = "success -"  + mysqli_query($con,"INSERT INTO image_tag VALUES (".$image_id.", ".$tag_id.")" ) ;
	
	

	mysqli_close($con);
		
	//$response = "success";	
	
} else {
	$response = "missing parameters";
}

//output the response
echo $response;
?>