<?php
	class AdmImageEdit{
	
		public $mImage;
		
		public $mTags;
		public $mImageID;
		
		public $mCategories;
		
	
		public function __construct(){
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			}
 		}

		public function init(){			
			
			$this->mImage = Collection::GetImageDetails($this->mImageID);			
			
			$this->mTags = Collection::GetImageTags($this->mImageID);
			
			$this->mCategories = Collection::GetCategories();
			
			//echo("tags:".count($this->mTags));

		}
		
	}
?>
