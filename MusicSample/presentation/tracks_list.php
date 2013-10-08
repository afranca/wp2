<?php
	class TracksList{
		// Public variables to be read from Smarty template
		public $mTracks;
		public $mTrackAlbum = array();

		// Class constructor
		public function __construct(){
			$mTrackAlbum;
 		}

		public function init(){
			$this->mTracks = Collection::GetAllTracks();
			for ($i = 0; $i < count($this->mTracks); $i++){
				//$this->mArtistAlbums[$i] = Collection::GetArtistAlbums($this->mArtists[$i]['artist']);			
			}
		}
	}
?>