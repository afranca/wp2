<?php
	class AlbumsList
	{
		// Public variables to be read from Smarty template
		public $mAlbums;
		public $mAlbumID;
		
		public $mPage = 1;
		public $mrTotalPages;
		public $mLinkToNextPage;
		public $mLinkToPreviousPage;
		public $mAlbumListPages = array();
		

		// Class constructor
		public function __construct() 
		{
			//Set mCurrentPage attribute to Session Variable value set in index.php
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_GET['album_id'])){
				$this->mAlbumID = $_GET['album_id'];
			}			

			if (isset ($_GET['Page'])){
				$this->mPage = (int)$_GET['Page'];
			}

		}

		public function init()
		{
			// Determine which Business Class method to call based on requested operation
			if ($this->mCurrentPage == 'Albums'){
				//$this->mAlbums = Collection::GetAlbums();	
				$this->mAlbums = Collection::GetAlbumsInCollection($this->mPage,$this->mrTotalPages);
				$basicURL = '?op=' . $_SESSION['CurrentPage'];
								
				if ($this->mrTotalPages > 1){
					// Build the Next link
					if ($this->mPage < $this->mrTotalPages)					{
						$nextPage = $this->mPage + 1;
						$this->mLinkToNextPage = $basicURL. '&Page=' . $nextPage;
					}
					
					// TODO: Build the Previous link
					if ($this->mPage > 1)					{
						$nextPage = $this->mPage - 1;
						$this->mLinkToPreviousPage = $basicURL. '&Page=' . $nextPage;
					}
				
				}	
				
				// Build links to all pages
				for ($i = 1; $i <= $this->mrTotalPages; $i++)  {
					$this->mAlbumListPages[] = $basicURL. '&Page=' . $i;  
				}
		
				
			} elseif ($this->mCurrentPage == 'Home')	{
				$this->mAlbums = Collection::GetLatestAlbums();		
			} elseif ($this->mCurrentPage == 'Details') {
				//$this->mAlbums = Collection::GetArtistAlbums();	
				
				$artist = Collection::GetAlbumArtist($this->mAlbumID);
				$this->mAlbums = Collection::GetArtistAlbums($artist);		
			}
			
		}
	}
?>
