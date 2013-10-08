<?php /* Smarty version Smarty-3.1.14, created on 2013-10-03 16:35:42
         compiled from "C:\xampp\htdocs\MusicSample\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12558524d80beb251e9-89490241%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '827d78044aad41080ac7bdf286b53ea419d7b261' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample\\presentation\\templates\\menu.tpl',
      1 => 1377097374,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12558524d80beb251e9-89490241',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_524d80beb29f01_16153515',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_524d80beb29f01_16153515')) {function content_524d80beb29f01_16153515($_smarty_tpl) {?>
<div id="main-nav">
	<?php echo $_smarty_tpl->getSubTemplate ("searchbox.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

    <ul id="menu">
	<li>
		<a id="Menu_HomeLink" href="Index.php">Home</a>
	</li>
	<li>
		<a id="Menu_AlbumsLink" href="?op=Albums">Albums</a>
	</li>
	<li>
		<a id="Menu_ArtistsLink" href="?op=Artists">Artists</a>
	</li>
	<li>
		<a id="Menu_SongsLink" href="?op=Songs">Songs</a>
	</li>
	<li>
		<a id="Menu_StatsLink" href="?op=Stats">Stats</a>
	</li>   
	<li>
		<a id="Menu_AdminLink" href="admin.php">Admin</a>
	</li>     
	</ul>
</div>

<?php }} ?>