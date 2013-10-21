<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 23:15:11
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample3\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:22585265995fecd1b2-43971502%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9e9b930f35247be3ca80311031085c1643164579' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3\\presentation\\templates\\menu.tpl',
      1 => 1377097374,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '22585265995fecd1b2-43971502',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5265995fed91d5_67277811',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5265995fed91d5_67277811')) {function content_5265995fed91d5_67277811($_smarty_tpl) {?>
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