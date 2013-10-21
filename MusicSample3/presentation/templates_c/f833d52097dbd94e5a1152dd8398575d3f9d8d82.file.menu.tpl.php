<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 16:17:20
         compiled from "C:\xampp\htdocs\MusicSample3\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:24450525ff170a3b308-82332758%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f833d52097dbd94e5a1152dd8398575d3f9d8d82' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample3\\presentation\\templates\\menu.tpl',
      1 => 1377097374,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '24450525ff170a3b308-82332758',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_525ff170a403e4_56300721',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_525ff170a403e4_56300721')) {function content_525ff170a403e4_56300721($_smarty_tpl) {?>
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