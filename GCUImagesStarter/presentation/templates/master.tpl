{* smarty *}
{config_load file="site.conf"}
{load_presentation_object filename="master" assign="obj"}
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="GCU, Images, Collection" />
  <meta name="description" content="GCU Images Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title>{#site_title#}</title>
</head>
<body>
  <div id="container">
	{include file="header.tpl"}	{include file="menu.tpl"}
	
	<div id="sidebar-a">
		{include file=$obj->mSideBar}        
    </div>
	
	<div id="content">
    	{include file=$obj->mContentsCell}
    </div>
	
	{include file="footer.tpl"}
  </div>
</body>
</html>
