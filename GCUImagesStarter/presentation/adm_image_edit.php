<?php
	class AdmImageEdit{
	
		public $mImage;
		
		public $mTags;
		public $mImageID;
		
		public $mCategories;
		
		public $mErrorMessage;
		
	
		public function __construct(){
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			} 
				
			
 		}

		public function init(){		

			$this->mImage = Collection::GetImageDetails($this->mImageID);
			
			if ( !empty($this->mImage) ){					
				
				//echo( "not empty");
				$this->mTags = Collection::GetImageTags($this->mImageID);
				
				$this->mCategories = Collection::GetCategories();
			} else {
				//echo( "empty");
				$this->mErrorMessage = "The Image your are requesting does not exist";
			}
			
			//echo("tags:".count($this->mTags));

		}
		
	}
?>
