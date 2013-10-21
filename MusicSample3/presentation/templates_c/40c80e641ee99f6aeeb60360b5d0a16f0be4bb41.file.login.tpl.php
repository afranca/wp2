<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 23:15:15
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample3\presentation\templates\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:25857526599638e37a5-14686211%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '40c80e641ee99f6aeeb60360b5d0a16f0be4bb41' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3\\presentation\\templates\\login.tpl',
      1 => 1377164540,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '25857526599638e37a5-14686211',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526599638f8d45_92898867',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526599638f8d45_92898867')) {function content_526599638f8d45_92898867($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3/presentation/smarty_plugins\\function.load_presentation_object.php';
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