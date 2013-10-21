<?php
	class ImagesList
	{
		// Public variables to be read from Smarty template
		public $mImages;

		// Class constructor
		public function __construct()
		{
			$this->mCurrentPage = $_SESSION['CurrentPage'];

		}

		public function init()
		{
			if ($this->mCurrentPage == 'Home' || $this->mCurrentPage == 'Images')
			{
				$this->mImages = Collection::GetImages();
			}
		}
	}
?>
