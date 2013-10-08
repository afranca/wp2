<?php
	class CategoriesList
	{
		// Public variables to be read from Smarty template
		public $mCategories;

		// Class constructor
		public function __construct()
		{

 		}

		public function init()
		{

			$this->mCategories = Collection::GetCategories();

		}
	}
?>
