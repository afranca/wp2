<?php
	class ArtistRatingsList
	{
		// Public variables to be read from Smarty template
		public $mArtists;


		// Class constructor
		public function __construct()
		{

 		}

		public function init()
		{
			$this->mArtists = Collection::GetHighestRatedArtists();

		}
	}
?>
