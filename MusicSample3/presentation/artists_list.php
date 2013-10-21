<?php
	class ArtistsList
	{
		// Public variables to be read from Smarty template
		public $mArtists;
		public $mArtistAlbums = array(array());

		// Class constructor
		public function __construct()
		{
			$mArtistAlbums;
 		}

		public function init()
		{
			$this->mArtists = Collection::GetArtists();
			for ($i = 0; $i < count($this->mArtists); $i++)  
			{
				$this->mArtistAlbums[$i] = Collection::GetArtistAlbums($this->mArtists[$i]['artist']);			
			}
		}
	}
?>
