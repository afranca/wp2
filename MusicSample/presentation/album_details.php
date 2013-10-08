<?php
	class AlbumDetails
	{
		// Public variables to be read from Smarty template
		public $mAlbum;
		public $mYear;
		public $mTracks;
		public $mAlbumID;
		public $mAlbums;

		// Class constructor
		public function __construct()
		{
			if (isset($_GET['album_id']))
			{
				$this->mAlbumID = $_GET['album_id'];
			}
 		}

		public function init(){			
			
			$this->mAlbum = Collection::GetAlbumDetails($this->mAlbumID);
			$release_date = $this->mAlbum['release_date'];
			$this->mYear = substr($release_date,0,4);
			$this->mTracks = Collection::GetAlbumTracks($this->mAlbumID);
			
			// retrieves all albums the the current artist
			//$this->mAlbums = Collection::GetArtistAlbums($this->mAlbum['artist']);
		}
		
	}
?>
