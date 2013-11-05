<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 15:50:11
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1986052659d240bb9e0-46546783%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '180439ecb19f897d50ba6a0d37719522deeead30' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\login.tpl',
      1 => 1383038684,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1986052659d240bb9e0-46546783',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_52659d240e7d57_30864331',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52659d240e7d57_30864331')) {function content_52659d240e7d57_30864331($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php  $_config = new Smarty_Internal_Config("site.conf", $_smarty_tpl->smarty, $_smarty_tpl);$_config->loadConfigVars(null, 'local'); ?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"login",'assign'=>"obj"),$_smarty_tpl);?>

<div>
	<h2>Login</h2>
	<form method="post" action="./index.php?op=admImageList" id="loginForm">
	<div>
		<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLoginMessage!=''){?>
			<p class="error"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mLoginMessage;?>
</p>
		<?php }?>    
		<p>
			<label for="username">Username:</label>
			<input type="text" name="username" size="35" />
			<label for="password">Password:</label>
			<input type="password" name="password" size="35" />
			<input type="submit" name="submit" value="Login" />
		</p>        
	</div>
	</form>
</div>
<?php }} ?>