<?php
	class SearchList{
		// Public variables to be read from Smarty template
		public $mAlbums;
		public $rHowManyPages;
		public $searchText;
		public $searchCategory;
		

		// Class constructor
		public function __construct(){
			//Set mCurrentPage attribute to Session Variable value set in index.php
			//$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_POST['searchText']))	{
				$this->searchText = $_POST['searchText'];
			} elseif (isset($_GET['searchCategory'])) {
				$this->searchCategory = $_GET['searchCategory'];
			}			

		}

		public function init(){	
			if (isset($this->searchText)) {
				$this->mAlbums = Collection::Search($this->searchText,1,$this->rHowManyPages)['albums'];
			} elseif ($this->searchCategory){
				$this->mAlbums = Collection::GetAlbumsByCategory($this->searchCategory, 1, $this->rHowManyPages);
			}
			
		}
	}
?>
