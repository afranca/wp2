<?php
	class ImagesList{
		// Public variables to be read from Smarty template
		public $mImages;
		public $mImageID;
		
		public $mPage = 1;
		public $mrTotalPages;
		public $mLinkToNextPage;
		public $mLinkToPreviousPage;
		public $mImageListPages = array();		
		

		// Class constructor
		public function __construct(){
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			}			

			if (isset ($_GET['Page'])){
				$this->mPage = (int)$_GET['Page'];
			}			
		}

		public function init(){
			if ( $this->mCurrentPage == 'Images'){
			
				$this->mImages = Collection::GetImagesInCollection($this->mPage,$this->mrTotalPages);
				//$this->mImages = Collection::GetImages();
				$basicURL = '?op=' . $_SESSION['CurrentPage'];
				
				if ($this->mrTotalPages > 1){	
						
					if ($this->mPage < $this->mrTotalPages)	{
						$nextPage = $this->mPage + 1;
						$this->mLinkToNextPage = $basicURL. '&Page=' . $nextPage;						
					}				
					if ($this->mPage > 1){
						$previousPage = $this->mPage - 1;
						$this->mLinkToPreviousPage = $basicURL. '&Page=' . $previousPage;						
					}				
				}	
								
				for ($i = 1; $i <= $this->mrTotalPages; $i++)  {
					$this->mImageListPages[] = $basicURL. '&Page=' . $i;  
				}				
				
			}elseif($this->mCurrentPage == 'Home'){
				$this->mImages = Collection::GetLatestImages();
			}
		}
	}
?>
