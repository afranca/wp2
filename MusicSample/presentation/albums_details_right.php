<?php
	class AlbumsList
	{
		// Public variables to be read from Smarty template
		public $mAlbums;

		// Class constructor
		public function __construct()
		{
			//Set mCurrentPage attribute to Session Variable value set in index.php
			$this->mCurrentPage = $_SESSION['CurrentPage'];

		}

		public function init()
		{
			// Determine which Business Class method to call based on requested operation
			if ($this->mCurrentPage == 'Albums')
			{
				$this->mAlbums = Collection::GetAlbums();
			}
			elseif ($this->mCurrentPage == 'Home')
			{
				$this->mAlbums = Collection::GetLatestAlbums();		}
		}
	}
?>
