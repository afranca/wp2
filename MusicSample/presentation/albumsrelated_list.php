<?php
	class AlbumRatingsList
	{
		// Public variables to be read from Smarty template
		public $mAlbums;
		public $mArtist;
		public $mCurrentPage;
		public $mAlbumID;

		// Class constructor
		public function __construct()
		{
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			if ($this->mCurrentPage == 'Details' || $this->mCurrentPage == 'Rate')
			{
				if (isset($_GET['album_id']))
				{
					$this->mAlbumID = $_GET['album_id'];
				}
				else
				{
					$this->mAlbumID = $_POST['album_id'];
				}
			}
 		}

		public function init()
		{
			if ($this->mCurrentPage == 'Home')
			{
				$this->mAlbums = Collection::GetHighestRatedAlbums();
			}
			else
			{
				$this->mArtist = Collection::GetAlbumArtist($this->mAlbumID);
				$this->mAlbums = Collection::GetArtistAlbums($this->mArtist);
			}
		}
	}
?>
