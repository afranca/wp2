<?php
	class Admin	{
		// Public variables to be read from Smarty template
		public $mLoggedIn;
		
		public $mContentsCell;
		public $mSideBar;

		public $mTopMenu;		

		// Private members
		private $mAction;

		// Class constructor
		public function __construct(){
			$this->mLoggedIn = TRUE;

 		}

		public function init(){
		
		
			if($_SESSION['CurrentPage'] == 'admImageList'){
				$this->mContentsCell = 'adm_images_list.tpl';
				$this->mSideBar = 'not_implemented.tpl';			
			
			}else if($_SESSION['CurrentPage'] == 'admImageEdit'){
				$this->mContentsCell = 'adm_image_edit.tpl';
				$this->mSideBar = 'not_implemented.tpl';	
			
			}else if($_SESSION['CurrentPage'] == 'admImageSave'){
				$this->mContentsCell = 'adm_image_save.tpl';
				$this->mSideBar = 'not_implemented.tpl';				
						
			}else{
				$this->mContentsCell = 'not_implemented.tpl';
				$this->mSideBar = 'not_implemented.tpl';
			}		

		}
	}
?>
