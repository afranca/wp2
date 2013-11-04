<?php
class Master {
	// Define the template file for the page contents
	public $mContentsCell;
	public $mSideBar;

	public $mTopMenu;
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
			$this->mSideBar = 'categories_list.tpl';
			/*
			if ($_SESSION['CurrentPage'] == 'Home'){
				$this->mSideBar = 'categories_list.tpl';
			}else{
				$this->mSideBar = 'categories_list.tpl';
			}
			*/
			
		}else if($_SESSION['CurrentPage'] == 'Details' || $_SESSION['CurrentPage'] == 'Rate'){
			$this->mContentsCell = 'image_details.tpl';
			$this->mSideBar = 'categories_list.tpl';	
			
		}else if($_SESSION['CurrentPage'] == 'Search'){
			$this->mContentsCell = 'images_list.tpl';
			$this->mSideBar = 'categories_list.tpl';
			
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
			$this->mSideBar = 'blank.tpl';
			
		}else if($_SESSION['CurrentPage'] == 'Logout'){
			$this->mContentsCell = 'logout.tpl';
			$this->mSideBar = 'blank.tpl';			
			
		}else if($_SESSION['CurrentPage'] == 'admImageList'){
			if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true ){
				$this->mContentsCell = 'adm_images_list.tpl';
				$this->mSideBar = 'adm_side_menu.tpl';			
			} else {
				$this->mContentsCell = 'login.tpl';
				$this->mSideBar = 'blank.tpl';
			}
			
		}else if($_SESSION['CurrentPage'] == 'admImageEdit'){
			if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true ){
				$this->mContentsCell = 'adm_image_edit.tpl';
				$this->mSideBar = 'adm_side_menu.tpl';			
			} else {
				$this->mContentsCell = 'login.tpl';
				$this->mSideBar = 'blank.tpl';
			}		
			
		}else if($_SESSION['CurrentPage'] == 'admImageSave'){
			if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true ){
				$this->mContentsCell = 'adm_image_save.tpl';
				$this->mSideBar = 'adm_side_menu.tpl';		
			} else {
				$this->mContentsCell = 'login.tpl';
				$this->mSideBar = 'blank.tpl';
			}		

			
		}else if($_SESSION['CurrentPage'] == 'admImageCreate'){
			if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true ){
				$this->mContentsCell = 'adm_image_create.tpl';
				$this->mSideBar = 'adm_side_menu.tpl';		
			} else {
				$this->mContentsCell = 'login.tpl';
				$this->mSideBar = 'blank.tpl';
			}			
		}else if($_SESSION['CurrentPage'] == 'admImageDelete'){
			if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true ){
				$this->mContentsCell = 'adm_image_delete.tpl';
				$this->mSideBar = 'adm_side_menu.tpl';		
			} else {
				$this->mContentsCell = 'login.tpl';
				$this->mSideBar = 'blank.tpl';
			}					
		}else{
			$this->mContentsCell = 'not_implemented.tpl';
			$this->mSideBar = 'not_implemented.tpl';
		}
		
		
        //if (isset($_SESSION['admin_logged']) && $_SESSION['admin_logged']==true){
		//	$this->mTopMenu="adm_menu.tpl";		
		//} else {
			$this->mTopMenu="menu.tpl";
		//}
	
		
	}
}
?>
