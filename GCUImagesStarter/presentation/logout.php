<?php
	// Class that deals with authenticating administrators
	class Logout{
		// Public variables available in smarty templates
		public $mUsername;
		public $mLoginMessage = '';

 		// Class constructor
		public function __construct(){
			// Verify if the correct username and password have been supplied
			if (isset ($_SESSION['admin_logged'])){
					$_SESSION['admin_logged']=false;
					header('Location: index.php');
			}			
		}
	}
?>
