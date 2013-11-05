<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 13:34:51
         compiled from "C:\Apps\xampp\htdocs\GCUImagesStarter\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:85155270fcebe5ebb6-48332395%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e67cfcf78e90d2db001cb4ad211841a5fc8cabce' => 
    array (
      0 => 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter\\presentation\\templates\\menu.tpl',
      1 => 1382391798,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '85155270fcebe5ebb6-48332395',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5270fcebe63600_47352954',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5270fcebe63600_47352954')) {function content_5270fcebe63600_47352954($_smarty_tpl) {?>
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
		<a id="Menu_AdminLink" href="?op=Login">Admin</a>
	</li>     
	</ul>
</div>

<?php }} ?>