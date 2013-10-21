<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 16:18:01
         compiled from "C:\xampp\htdocs\MusicSample3\presentation\templates\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:17521525ff199e82636-78212934%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd5fb85ce0625bb663c678ed3c95ec403ed771b44' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample3\\presentation\\templates\\login.tpl',
      1 => 1377164540,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '17521525ff199e82636-78212934',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_525ff199eb7390_37152617',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_525ff199eb7390_37152617')) {function content_525ff199eb7390_37152617($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\MusicSample3/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php  $_config = new Smarty_Internal_Config("site.conf", $_smarty_tpl->smarty, $_smarty_tpl);$_config->loadConfigVars(null, 'local'); ?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"login",'assign'=>"obj"),$_smarty_tpl);?>

<div>
	<h2>Login</h2>
	<form method="post" action="./admin.php" id="loginForm">
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