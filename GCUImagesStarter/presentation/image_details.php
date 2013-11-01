<?php
	class ImageDetails{
	
		public $mImage;
		
		public $mTrags;
		public $mImageID;
		public $mNewRating;
		
	
		public function __construct(){
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			}elseif (isset($_POST["rating"])){
			 	$this->mNewRating = $_POST['rating'];
			 	$this->mImageID = $_POST['image_id'];
			}
 		}

		public function init(){		

			if (isset($this->mNewRating)){
			 	Collection::UpdateRating($this->mImageID, $this->mNewRating);
			}		
			
			$this->mImage = Collection::GetImageDetails($this->mImageID);			
			
			$this->mTags = Collection::GetImageTags($this->mImageID);
			//echo("tags:".count($this->mTags));

		}
		
	}
?>
