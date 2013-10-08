<?php /* Smarty version Smarty-3.1.14, created on 2013-10-03 16:35:42
         compiled from "C:\xampp\htdocs\MusicSample\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:22319524d80beb54844-79773987%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5b40b7548d22d731b2f722c9305d71ae12931a98' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample\\presentation\\templates\\searchbox.tpl',
      1 => 1376916838,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '22319524d80beb54844-79773987',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_524d80beb56ef6_66031213',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_524d80beb56ef6_66031213')) {function content_524d80beb56ef6_66031213($_smarty_tpl) {?>
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