{* admin.tpl *}
{load_presentation_object filename="admin" assign="obj"}
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="GCU, Images, Collection" />
  <meta name="description" content="GCU, Images, Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title>{#site_title#}</title>
</head>
<body>
  <div id="container">
	{include file="header.tpl"} {include file="menu.tpl"}
	
	{if $obj->mLoggedIn neq TRUE}
		<div id="loginDiv">
			{include file="login.tpl"}
		</div>
	{else}
		<div id="logout">
			<a href="admin.php?Page=Logout">Logout</a>
		</div>	

	{/if}
	
	{include file="footer.tpl"}
  </div>
</body>
</html>