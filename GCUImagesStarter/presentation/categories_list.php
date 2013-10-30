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
			
			if (isset ($this->searchText))	{
				$this->mCategories = Collection::GetSearchResultCategories($this->searchText);			
			}else{
				$this->mCategories = Collection::GetCategories();
			}			
		
				
		}
	}
?>
