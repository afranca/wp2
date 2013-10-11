<?php
	class SearchList{
		// Public variables to be read from Smarty template
		public $mAlbums;
		public $rHowManyPages;
		public $searchText;
		public $searchCategory;
		public $ret;
		
		public $mCurrentPage;
		public $mPage = 1;
		public $mrTotalPages;
		public $mLinkToNextPage;
		public $mLinkToPreviousPage;
		public $mAlbumListPages = array();
		
		private $searchParm;
		
	

		

		// Class constructor
		public function __construct(){
			//Set mCurrentPage attribute to Session Variable value set in index.php
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			// Get Page number from query string casting it to int
			if (isset ($_GET['Page'])){
				$this->mPage = (int)$_GET['Page'];
			}
			
			
			if (isset($_POST['searchText']))	{
				$this->searchText = $_POST['searchText'];
				$this->searchParm = $_POST['searchText'];
			} elseif (isset($_GET['searchCategory'])) {
				$this->searchCategory = $_GET['searchCategory'];
				$this->searchParm = $_GET['searchCategory'];
			}			

		}

		public function init(){	
			if (isset($this->searchText)) {
				$this->mAlbums = Collection::Search($this->searchText,$this->mPage,$this->mrTotalPages)['albums'];
			} elseif ($this->searchCategory){
				$this->mAlbums = Collection::GetAlbumsByCategory($this->searchCategory,$this->mPage, $this->mrTotalPages, $this->ret);
			}
			
			$basicURL = '?op=' . $_SESSION['CurrentPage'];
							
			if ($this->mrTotalPages > 1){
				// Build the Next link
				if ($this->mPage < $this->mrTotalPages)					{
					$nextPage = $this->mPage + 1;
					$this->mLinkToNextPage = $basicURL. '&searchCategory='.$this->searchParm.'&Page=' . $nextPage;
				}
				
				// TODO: Build the Previous link
				if ($this->mPage > 1)					{
					$nextPage = $this->mPage - 1;
					$this->mLinkToPreviousPage = $basicURL. '&searchCategory='.$this->searchParm.'&Page=' . $nextPage;
				}
			
			}	
				
				// Build links to all pages
				for ($i = 1; $i <= $this->mrTotalPages; $i++)  {
					$this->mAlbumListPages[] = $basicURL. '&searchCategory='.$this->searchParm.'&Page=' . $i;
					$this->ret = $i.'<='. $this->mrTotalPages;
				}			
			
			
			
		}
	}
?>
