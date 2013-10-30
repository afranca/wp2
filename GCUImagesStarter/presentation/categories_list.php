<?php
	class CategoriesList{
		// Public variables to be read from Smarty template
		public $mCategories;
		public $searchText;	

		// Class constructor
		public function __construct(){
			if (isset($_POST['searchText'])){
				$this->searchText = $_POST['searchText'];
			}

 		}

		public function init(){
		
				$this->mCategories = Collection::GetCategories();
		}
	}
?>
