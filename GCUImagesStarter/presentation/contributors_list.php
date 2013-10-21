<?php
	class ContributorsList
	{
		// Public variables to be read from Smarty template
		public $mContributors;
		public $mContributorImages = array(array());

		// Class constructor
		public function __construct(){

 		}

		public function init(){
			$this->mContributors = Collection::GetContributors();
			for ($i = 0; $i < count($this->mContributors); $i++){
				$this->mContributorImages[$i] = Collection::GetContributorImages($this->mContributors[$i]['image_contributor']);
			}
		}
	}
?>
