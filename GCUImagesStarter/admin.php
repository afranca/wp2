<?php

	session_name('gcuimages');
	session_start();
	// Include utility files
	require_once 'include/config.php';

	// Load the application page template
	require_once PRESENTATION_DIR . 'application.php';

	//Load Smarty template file
	$application = new Application();
	
	// Display the page
	if (isset($_GET["op"]))
		$_SESSION['CurrentPage'] = $_GET["op"];
	else
		$_SESSION['CurrentPage'] = 'admImageList';
	

	// Display the page
	$application->display('admin.tpl');
?>
