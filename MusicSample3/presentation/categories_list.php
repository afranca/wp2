<?php
	class CategoriesList
	{
		// Public variables to be read from Smarty template
		public $mCategories;
		public $mSearchString;

		// Class constructor
		public function __construct()
		{
			if (isset ($_GET['searchText']))
			{
				$this->mSearchString = $_GET['searchText'];
			}
			elseif (isset ($_POST['searchText']))
			{
				$this->mSearchString = trim($_POST['searchText']);
			}		
 		}

		public function init()
		{
			if (isset ($this->mSearchString))
			{
				$this->mCategories = Collection::GetSearchResultCategories($this->mSearchString);			
			}
			else
			{
				$this->mCategories = Collection::GetCategories();
			}
		}
	}
?>
