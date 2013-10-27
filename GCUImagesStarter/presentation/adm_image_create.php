<?php
	class AdmImageCreate{
	
		public $mImage;
		
		public $mTags;
		public $mImageID;
		
		public $mCategories;
		
	
		public function __construct(){

 		}

		public function init(){				
	
			$this->mCategories = Collection::GetCategories();


		}
		
	}
?>
