<?php

$response = "";
//get the q parameter from URL
$tag_id;
$image_id;

if (  isset($_GET["tag_name"]) && isset($_GET["image_id"])) {

	$tag_name=$_GET["tag_name"];
	$image_id=$_GET["image_id"];
	
	$con=mysqli_connect("localhost","imagesadmin","imagesadmin","gcuimages");
	if (mysqli_connect_errno()){
		$response = "Failed to connect to MySQL: " . mysqli_connect_error();
	} else {
		mysqli_query($con,"INSERT INTO tag (tag_name) VALUES ('".$tag_name."')" ) ;
		$result = mysqli_query($con,"SELECT MAX(tag_id) as LAST_ID FROM tag" ) ;
		while($row = mysqli_fetch_array($result)){	
			 $tag_id = $row["LAST_ID"] ;			 
		}
		
		mysqli_query($con,"INSERT INTO image_tag VALUES (".$image_id.", ".$tag_id.")" ) ;
		$response = $tag_id;
		mysqli_close($con);
		
	}	
}
echo $response;
?>