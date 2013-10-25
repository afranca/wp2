<?php
	// Class that deals with authenticating administrators
	class Login{
		// Public variables available in smarty templates
		public $mUsername;
		public $mLoginMessage = '';

 		// Class constructor
		public function __construct(){
			// Verify if the correct username and password have been supplied
			if (isset ($_POST['submit'])){
				//if ($_POST['username'] == ADMIN_USERNAME && $_POST['password'] == ADMIN_PASSWORD){
				if (true) {
					$_SESSION['admin_logged'] = true;			
					header('Location: index.php?op=admImageList');
					exit();					
				}else{				
					$this->mLoginMessage = 'Login failed. Please try again:';
				}
				
			}			
		}
	}
?>
