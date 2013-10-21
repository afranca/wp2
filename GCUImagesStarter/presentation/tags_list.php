<?php
	class TagsList
	{
		// Public variables to be read from Smarty template
		public $mTags;

		// Class constructor
		public function __construct()
		{

 		}

		public function init()
		{
				$this->mTags = Collection::GetTags();
		}
	}
?>
