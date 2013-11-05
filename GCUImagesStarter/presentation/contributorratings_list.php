<?php
	class ContributorRatingsList{

		public $mContributors;


		public function __construct()	{		}

		public function init()	{
		
			$this->mContributors = Collection::GetHighestRatedContributors();

		}
	}
?>
