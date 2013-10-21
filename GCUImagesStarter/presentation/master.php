<?php
class Master {
	// Define the template file for the page contents
	public $mContentsCell;
	public $mSideBar;

	// Class constructor
	public function __construct()	{	}

	// Initialize presentation object
	public function init()	{
		// Load the database handler
		require_once BUSINESS_DIR . 'database_handler.php';

		// Load Business Tier
		require_once BUSINESS_DIR . 'collection.php';


 		if ($_SESSION['CurrentPage'] == 'Home' || $_SESSION['CurrentPage'] == 'Images')	{
			$this->mContentsCell = 'images_list.tpl';
			if ($_SESSION['CurrentPage'] == 'Home'){
				$this->mSideBar = 'categories_list.tpl';
			}else{
				$this->mSideBar = 'tags_list.tpl';
			}
		}else if($_SESSION['CurrentPage'] == 'Details'){
			$this->mContentsCell = 'image_details.tpl';
			$this->mSideBar = 'tags_list.tpl';	
		}else if($_SESSION['CurrentPage'] == 'Search'){
			$this->mContentsCell = 'images_list.tpl';
			$this->mSideBar = 'tags_list.tpl';
		}else if($_SESSION['CurrentPage'] == 'SearchCategory'){
			$this->mContentsCell = 'images_list.tpl';
			$this->mSideBar = 'categories_list.tpl';
		}else if($_SESSION['CurrentPage'] == 'SearchTag'){
			$this->mContentsCell = 'images_list.tpl';
			$this->mSideBar = 'tags_list.tpl';			
		}else if($_SESSION['CurrentPage'] == 'Contributors'){
			$this->mContentsCell = 'contributors_list.tpl';
			$this->mSideBar = 'categories_list.tpl';	
		}else if($_SESSION['CurrentPage'] == 'Login'){
			$this->mContentsCell = 'login.tpl';
			$this->mSideBar = 'not_implemented.tpl';			
		}else{
			$this->mContentsCell = 'not_implemented.tpl';
			$this->mSideBar = 'not_implemented.tpl';
		}
	}
}
?>
