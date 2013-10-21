<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 16:17:20
         compiled from "C:\xampp\htdocs\MusicSample3\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:30355525ff170a69e09-92214418%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '756454ae60a1bd9ed78b8f793ce6af8fb2d95752' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample3\\presentation\\templates\\searchbox.tpl',
      1 => 1376916838,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '30355525ff170a69e09-92214418',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_525ff170a6c604_96814014',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_525ff170a6c604_96814014')) {function content_525ff170a6c604_96814014($_smarty_tpl) {?>
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