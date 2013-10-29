<?php
class Admin {
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


		if($_SESSION['CurrentPage'] == 'admImageList'){
			$this->mContentsCell = 'adm_images_list.tpl';
			$this->mSideBar = 'adm_side_menu.tpl';			
		
		}else if($_SESSION['CurrentPage'] == 'admImageEdit'){
			$this->mContentsCell = 'adm_image_edit.tpl';
			$this->mSideBar = 'adm_side_menu.tpl';	
		
		}else if($_SESSION['CurrentPage'] == 'admImageSave'){
			$this->mContentsCell = 'adm_image_save.tpl';
			$this->mSideBar = 'adm_side_menu.tpl';
			
		}else if($_SESSION['CurrentPage'] == 'admImageCreate'){
			$this->mContentsCell = 'adm_image_create.tpl';
			$this->mSideBar = 'adm_side_menu.tpl';					
					
		}else{
			$this->mContentsCell = 'not_implemented.tpl';
			$this->mSideBar = 'not_implemented.tpl';
		}
		
	
		
	}
}
?>
