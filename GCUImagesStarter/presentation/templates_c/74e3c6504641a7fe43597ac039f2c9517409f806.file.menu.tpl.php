<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 16:09:44
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12816526535a86da1e1-59642290%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '74e3c6504641a7fe43597ac039f2c9517409f806' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\menu.tpl',
      1 => 1381743568,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12816526535a86da1e1-59642290',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526535a86e4248_38022372',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526535a86e4248_38022372')) {function content_526535a86e4248_38022372($_smarty_tpl) {?>
<div id="main-nav">
	<?php echo $_smarty_tpl->getSubTemplate ("searchbox.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

    <ul id="menu">
	<li>
		<a id="Menu_HomeLink" href="Index.php">Home</a>
	</li>
	<li>
		<a id="Menu_ImagesLink" href="?op=Images">Images</a>
	</li>
	<li>
		<a id="Menu_ContributorsLink" href="?op=Contributors">Contributors</a>
	</li>  
	<li>
		<a id="Menu_AdminLink" href="admin.php">Admin</a>
	</li>     
	</ul>
</div>

<?php }} ?>