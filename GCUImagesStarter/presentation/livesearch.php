<?php
//$xmlDoc=new DOMDocument();
//$xmlDoc->load("links.xml");


$hint="";
//get the q parameter from URL
if (isset($_GET["q"]) ){

	$q=$_GET["q"];
	
	$con=mysqli_connect("localhost","imagesadmin","imagesadmin","gcuimages");
	if (mysqli_connect_errno()){
	  echo "Failed to connect to MySQL: " . mysqli_connect_error();
	  exit;
	}

	$result = mysqli_query($con,"SELECT tag_id,tag_name FROM tag WHERE tag_name like '".$q."%'");

	while($row = mysqli_fetch_array($result)){	

			$hint=$hint .' <a href="javascript:assignTagFieldTag('.$row["tag_id"].',\''.$row["tag_name"].'\') " target="_blank">' .$row["tag_name"] . '</a> <br />';
			
			//$hint=$hint . " <a href='javascript:assignTagFieldTag(".$row['tag_id'].")' target='_blank'>" .$row['tag_name'] . "</a> <br />";
			

	}
	 /*
	while($row = mysqli_fetch_array($result)){	
		if ($hint==""){
			$hint="<a href='" . $row['tag_id'] ."' target='_blank'>" .	 $row['tag_name'] . "</a>";
		} else  {
			$hint=$hint . " <br /><a href='" .$row['tag_id']."' target='_blank'>" .$row['tag_name'] . "</a>";
		}	

	}	
	*/
	mysqli_close($con);
		
	
}




/*
$x=$xmlDoc->getElementsByTagName('link');
if (strlen($q)>0){
	$hint="";
	for($i=0; $i<($x->length); $i++)  {
	  $y=$x->item($i)->getElementsByTagName('title');
	  $z=$x->item($i)->getElementsByTagName('url');
			if ($y->item(0)->nodeType==1)    {
				//find a link matching the search text
				if (stristr($y->item(0)->childNodes->item(0)->nodeValue,$q))      {
					  if ($hint=="")        {
							$hint="<a href='" . $z->item(0)->childNodes->item(0)->nodeValue ."' target='_blank'>" .	$y->item(0)->childNodes->item(0)->nodeValue . "</a>";
						} else  {
							$hint=$hint . "<br /><a href='" .$z->item(0)->childNodes->item(0)->nodeValue."' target='_blank'>" .$y->item(0)->childNodes->item(0)->nodeValue . "</a>";
						}
				  }
			}
	}
}
*/
// Set output to "no suggestion" if no hint were found
// or to the correct values
if ($hint=="") {
	$response="no suggestion";
}else {
	$response=$hint;
}

//output the response
echo $response;
?>