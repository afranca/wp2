<?php
	class AlbumDetails
	{
		// Public variables to be read from Smarty template
		public $mAlbum;
		public $mYear;
		public $mTracks;
		public $mAlbumID;
		public $mNewRating;

		// Class constructor
		public function __construct()
		{
			if (isset($_GET['album_id']))
			{
				$this->mAlbumID = $_GET['album_id'];
			}
			elseif (isset($_POST["rating"]))
			{
			 	$this->mNewRating = $_POST['rating'];
			 	$this->mAlbumID = $_POST['album_id'];
			}
 		}

		public function init()
		{
			if (isset($this->mNewRating))
			{
			 	Collection::UpdateRating($this->mAlbumID, $this->mNewRating);
			}
			$this->mAlbum = Collection::GetAlbumDetails($this->mAlbumID);
			$release_date = $this->mAlbum['release_date'];
			$this->mYear = substr($release_date,0,4);
			$this->mTracks = Collection::GetAlbumTracks($this->mAlbumID);
		}
	}
?>
