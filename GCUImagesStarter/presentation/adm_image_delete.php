<?php
	class AdmImageDelete{
		
		public $mPage = 1;
		public $image_id;	

		// Class constructor
		public function __construct(){
			//$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_GET['image_id'])){
				$this->image_id = $_GET['image_id'];			
			}
			if (isset ($_GET['Page'])){
				$this->mPage = (int)$_GET['Page'];
			}			

		}

		public function init(){

			
			if (isset($this->image_id)){			
				 //Collection::DeleteImageTag($this->image_id);		
				
				 Collection::DeleteImage($this->image_id);
			}
			
			header( 'Location: http://localhost/GCUImagesStarter/index.php?op=admImageList&Page='.$this->mPage ) ;
					
		}
		
		
	}
?>
