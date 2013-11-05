<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 13:34:51
         compiled from "C:\Apps\xampp\htdocs\GCUImagesStarter\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:173445270fcebe7e895-25420131%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6242045019622f445ae3e70d789f10dcfd06f590' => 
    array (
      0 => 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter\\presentation\\templates\\searchbox.tpl',
      1 => 1382368412,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '173445270fcebe7e895-25420131',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5270fcebe8e2c7_80717565',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5270fcebe8e2c7_80717565')) {function content_5270fcebe8e2c7_80717565($_smarty_tpl) {?>
<div id="searchBox">
	<!--<h2>Search</h2>-->
	<form method="post" action="?op=Search" id="searchForm">
	<div>
		<p>
			<input maxlength="100" id="searchText" name="searchText" size="25" />
			<input type="submit" value="Go!" /><br />
		</p>
	</div>
	</form>
</div>




<?php }} ?>