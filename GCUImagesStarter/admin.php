<?php

	session_name('gcuimages');
	session_start();
	// Include utility files
	require_once 'include/config.php';

	// Load the application page template
	require_once PRESENTATION_DIR . 'application.php';

	//Load Smarty template file
	$application = new Application();
	$_SESSION['CurrentPage'] = 'Admin';

	// Display the page
	$application->display('admin.tpl');
?>
