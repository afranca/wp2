<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 15:50:11
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\adm_side_menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2628526d085562c3d0-12540936%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd3609e01c1c9d4e3cd31508465e316c3217501be' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\adm_side_menu.tpl',
      1 => 1383067982,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2628526d085562c3d0-12540936',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526d0855650567_96866251',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526d0855650567_96866251')) {function content_526d0855650567_96866251($_smarty_tpl) {?>
<div>
    <h2>Admin Actions</h2>	
	<ul>
		<li>
			<a href="?op=admImageList"> List Images </a>&nbsp; 
		</li>
		<li>
			<a href="?op=admImageCreate"> Create Images </a>&nbsp; 
		</li>
		<li>
			<a href="?op=Logout">Logout</a>
		</li> 		
				
	</ul>
</div>



<?php }} ?>