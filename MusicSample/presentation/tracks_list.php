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
				$this->mTrackAlbum[$i] = Collection::GetAlbumDetails($this->mTracks[$i]['album_id']);			
			}
		}
	}
?>