<?php /* Smarty version Smarty-3.1.14, created on 2013-11-06 13:10:06
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\adm_menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:5755526d0211a55ee2-73486657%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '973c502137eca8ef65d4ed6da23990e168edbfd4' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\adm_menu.tpl',
      1 => 1383739715,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '5755526d0211a55ee2-73486657',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526d0211a5b5f2_20019299',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526d0211a5b5f2_20019299')) {function content_526d0211a5b5f2_20019299($_smarty_tpl) {?>
<div id="main-nav">
	<?php echo $_smarty_tpl->getSubTemplate ("searchbox_disabled.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

    <ul id="menu">
		
		<li>
			<a id="Menu_HomeLink" href="Index.php">Home</a>
		</li>
		
		<li>
			<a id="Menu_ImagesLink" href="Index.php?op=Images">Images</a>
		</li>
		<li>
			<a id="Menu_ContributorsLink" href="Index.php?op=Contributors">Contributors</a>
		</li>  

		<li>
			<a id="Menu_AdminLink" href="?op=Login">Admin</a>
		</li> 		
		
	</ul>
</div>

<?php }} ?>