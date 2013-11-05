<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 13:34:51
         compiled from "C:\Apps\xampp\htdocs\GCUImagesStarter\presentation\templates\master.tpl" */ ?>
<?php /*%%SmartyHeaderCode:189415270fcebd63e87-96710780%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd891e46ab1fc18d2de368e84042011cfbf08e12f' => 
    array (
      0 => 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter\\presentation\\templates\\master.tpl',
      1 => 1382978282,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '189415270fcebd63e87-96710780',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5270fcebdf60a0_10803446',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5270fcebdf60a0_10803446')) {function content_5270fcebdf60a0_10803446($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php  $_config = new Smarty_Internal_Config("site.conf", $_smarty_tpl->smarty, $_smarty_tpl);$_config->loadConfigVars(null, 'local'); ?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"master",'assign'=>"obj"),$_smarty_tpl);?>

<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="GCU, Images, Collection" />
  <meta name="description" content="GCU Images Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title><?php echo $_smarty_tpl->getConfigVariable('site_title');?>
</title>
</head>
<body>
  <div id="container">
		<?php echo $_smarty_tpl->getSubTemplate ("header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
	
		
		<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['obj']->value->mTopMenu, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	
		<div id="sidebar-a">
			<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['obj']->value->mSideBar, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
        
		</div>
	
		<div id="content">
			<?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['obj']->value->mContentsCell, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

		</div>
	
		<?php echo $_smarty_tpl->getSubTemplate ("footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

  </div>
</body>
</html>
<?php }} ?>