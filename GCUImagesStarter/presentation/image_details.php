<?php
	class ImageDetails{
	
		public $mImage;
		
		public $mTrags;
		public $mImageID;
		
	
		public function __construct(){
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			}
 		}

		public function init(){			
			
			$this->mImage = Collection::GetImageDetails($this->mImageID);			
			
			$this->mTags = Collection::GetImageTags($this->mImageID);
			//echo("tags:".count($this->mTags));

		}
		
	}
?>
