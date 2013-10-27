{* logo_menu.tpl *}
<div id="main-nav">
	{include file="searchbox.tpl"}
    <ul id="menu">
		
		<li>
			<a id="Menu_HomeLink" href="Index.php">Home</a>
		</li>
		<!--
		<li>
			<a id="Menu_ImagesLink" href="Index.php?op=Images">Images</a>
		</li>
		<li>
			<a id="Menu_ContributorsLink" href="Index.php?op=Contributors">Contributors</a>
		</li>  
		<li>
			<a id="Menu_AdminLink" href="Index.php?op=Login">Admin</a>
		</li>
		-->
		<li>
			<a id="Menu_AdminImage" href="?op=admImageList">Image</a>
		</li> 		
		<li>
			<a id="Menu_AdminTag" href="?op=admTagList">Tag</a>
		</li> 
		<li>
			<a id="Menu_AdminLogout" href="?Page=Logout">Logout</a>
		</li> 		
		
	</ul>
</div>

