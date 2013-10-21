<?php /* Smarty version Smarty-3.1.14, created on 2013-10-10 20:43:00
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:232415254178bc25720-32870811%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '86e74596b1f2ebec47f1197a687bbed58ea474c1' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample\\presentation\\templates\\menu.tpl',
      1 => 1381241550,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '232415254178bc25720-32870811',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5254178bc29d82_51639439',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5254178bc29d82_51639439')) {function content_5254178bc29d82_51639439($_smarty_tpl) {?>
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