<?php /* Smarty version Smarty-3.1.14, created on 2013-11-06 13:12:56
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\searchbox_disabled.tpl" */ ?>
<?php /*%%SmartyHeaderCode:20938527a319e3517d0-24993285%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd82c74205a1852d1bfd2e61e96fd13ddb75c2fa3' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\searchbox_disabled.tpl',
      1 => 1383739969,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20938527a319e3517d0-24993285',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_527a319e353a65_97003136',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_527a319e353a65_97003136')) {function content_527a319e353a65_97003136($_smarty_tpl) {?><div id="searchBox">
	<!--<h2>Search</h2>-->
	<form method="post" action="?op=Search" id="searchForm">
	<div>
		<p>
			<input maxlength="100" id="searchText" name="searchText" size="25" disabled />
			<input type="submit" value="Go!" disabled/><br />
		</p>
	</div>
	</form>
</div>




<?php }} ?>