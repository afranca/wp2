<?php
class Master
{
	// Define the template file for the page contents
	public $mContentsCell;
	public $mSideBar;

	// Class constructor
	public function __construct()
	{
	}

	// Initialize presentation object
	public function init()
	{
		// Load the database handler
		require_once BUSINESS_DIR . 'database_handler.php';

		// Load Business Tier
		require_once BUSINESS_DIR . 'collection.php';


 		if ($_SESSION['CurrentPage'] == 'Home' || $_SESSION['CurrentPage'] == 'Albums')
		{
			$this->mContentsCell = 'albums_list.tpl';
			if ($_SESSION['CurrentPage'] == 'Home')
				$this->mSideBar = 'albumratings_list.tpl';
			else
				$this->mSideBar = 'categories_list.tpl';
		}
		elseif ($_SESSION['CurrentPage'] == 'Details')
		{
			$this->mContentsCell = 'album_details.tpl';
			$this->mSideBar = 'albumsrelated_list.tpl';
		}
		else
		{
			$this->mContentsCell = 'not_implemented.tpl';
			$this->mSideBar = 'not_implemented.tpl';
		}
	}
}
?>
