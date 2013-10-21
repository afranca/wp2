<?php
	class Admin	{
		// Public variables to be read from Smarty template
		public $mLoggedIn;

		// Private members
		private $mAction;

		// Class constructor
		public function __construct(){
			$this->mLoggedIn = TRUE;

 		}

		public function init(){

		}
	}
?>
