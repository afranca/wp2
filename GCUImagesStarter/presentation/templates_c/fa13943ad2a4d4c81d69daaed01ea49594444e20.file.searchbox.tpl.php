<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 16:09:44
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:24841526535a86fa277-08518299%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'fa13943ad2a4d4c81d69daaed01ea49594444e20' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\searchbox.tpl',
      1 => 1376916838,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '24841526535a86fa277-08518299',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526535a86fee21_23597914',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526535a86fee21_23597914')) {function content_526535a86fee21_23597914($_smarty_tpl) {?>
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