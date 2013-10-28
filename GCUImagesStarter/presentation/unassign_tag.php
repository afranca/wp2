<?php

$response = "";
//get the q parameter from URL
if (  isset($_GET["tag_id"]) && isset($_GET["image_id"] )  ) {

	$tag_id=$_GET["tag_id"];
	$image_id=$_GET["image_id"];
	
	$con=mysqli_connect("localhost","imagesadmin","imagesadmin","gcuimages");
	if (mysqli_connect_errno()){
	  $response = "Failed to connect to MySQL: " . mysqli_connect_error();
	}

	$response = "success -"  + mysqli_query($con,"DELETE FROM image_tag WHERE image_id=".$image_id." AND tag_id=".$tag_id) ;

	mysqli_close($con);
		
	//$response = "success";	
	
} else {
	$response = "missing parameters";
}

//output the response
echo $response;
?>