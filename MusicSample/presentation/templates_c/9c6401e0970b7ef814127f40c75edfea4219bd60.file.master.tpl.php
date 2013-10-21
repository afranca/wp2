<?php /* Smarty version Smarty-3.1.14, created on 2013-10-10 20:42:59
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample\presentation\templates\master.tpl" */ ?>
<?php /*%%SmartyHeaderCode:27075254178bbbaba6-35904810%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9c6401e0970b7ef814127f40c75edfea4219bd60' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample\\presentation\\templates\\master.tpl',
      1 => 1381241550,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '27075254178bbbaba6-35904810',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5254178bbfa315_00875700',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5254178bbfa315_00875700')) {function content_5254178bbfa315_00875700($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php  $_config = new Smarty_Internal_Config("site.conf", $_smarty_tpl->smarty, $_smarty_tpl);$_config->loadConfigVars(null, 'local'); ?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"master",'assign'=>"obj"),$_smarty_tpl);?>

<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="Music, Collection" />
  <meta name="description" content="Music Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title><?php echo $_smarty_tpl->getConfigVariable('site_title');?>
</title>
</head>
<body>
  <div id="container">
	<?php echo $_smarty_tpl->getSubTemplate ("header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
	<?php echo $_smarty_tpl->getSubTemplate ("menu.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	
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