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
		
		public $searchText;		
		public $searchCategory;
		public $searchTag;

		// Class constructor
		public function __construct(){
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_GET['image_id'])){
				$this->mImageID = $_GET['image_id'];
			}
			if (isset ($_GET['Page'])){
				$this->mPage = (int)$_GET['Page'];
			}
			if (isset($_POST['searchText'])){
				$this->searchText = $_POST['searchText'];
			}	
			if (isset($_GET['searchParam']) && $this->mCurrentPage == 'SearchCategory'){
				$this->searchCategory = $_GET['searchParam'];
			}
			if (isset($_GET['searchParam']) && $this->mCurrentPage == 'SearchTag'){
				$this->searchTag = $_GET['searchParam'];
			}	
			
		}

		public function init(){
			if ( $this->mCurrentPage == 'Images' || $this->mCurrentPage == 'Search' || $this->mCurrentPage == 'SearchCategory' || $this->mCurrentPage == 'SearchTag'){
				$basicURL = '?op=' . $_SESSION['CurrentPage'];
			 
				if (isset($this->searchText)){					 
					$this->mImages = Collection::Search($this->searchText,$this->mPage,$this->mrTotalPages)['images'];
				}elseif(isset($this->searchCategory)){
					$this->mImages = Collection::GetImagesByCategory($this->searchCategory,$this->mPage,$this->mrTotalPages);
					//echo(count($this->mImages));
					$basicURL = $basicURL.'&searchParam='.$this->searchCategory;
				}elseif(isset($this->searchTag)){
					$this->mImages = Collection::GetImagesByTag($this->searchTag,$this->mPage,$this->mrTotalPages);
					//echo(count($this->mImages));
					$basicURL = $basicURL.'&searchParam='.$this->searchTag;					
				}else{
					$this->mImages = Collection::GetImagesInCollection($this->mPage,$this->mrTotalPages);
				}
						
				
				
				
				if ($this->mrTotalPages > 1){	
						
					if ($this->mPage < $this->mrTotalPages)	{
						$nextPage = $this->mPage + 1;
						$this->mLinkToNextPage = $basicURL. '&Page=' . $nextPage;						
					}				
					if ($this->mPage > 1){
						$previousPage = $this->mPage - 1;
						$this->mLinkToPreviousPage = $basicURL. '&Page=' . $previousPage;						
					}	

					for ($i = 1; $i <= $this->mrTotalPages; $i++)  {
						$this->mImageListPages[] = $basicURL. '&Page=' . $i;  
					}					
				}	
								
				
				
			}elseif($this->mCurrentPage == 'Home'){
				$this->mImages = Collection::GetLatestImages();
			}
		}
	}
?>
