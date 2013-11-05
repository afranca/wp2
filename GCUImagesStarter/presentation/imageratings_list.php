<?php
	class ImageRatingsList{
		
		public $mImages;
		public $mCurrentPage;
		public $mImageID;
		public $mContributor;

		// Class constructor
		public function __construct()	{
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if ($this->mCurrentPage == 'Details' || $this->mCurrentPage == 'Rate')	{
				if (isset($_GET['image_id']))	{
					$this->mImageID = $_GET['image_id'];
				}else{
					$this->mImageID = $_POST['image_id'];
				}
			}
 		}

		public function init(){
			if ($this->mCurrentPage == 'Home')			{
				$this->mImages = Collection::GetHighestRatedImages();
			}else{
				$this->mContributor = Collection::GetImageContributor($this->mImageID);
				$this->mImages = Collection::GetContributorImages($this->mContributor);
			}
		}
	}
?>
