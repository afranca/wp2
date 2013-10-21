<?php /* Smarty version Smarty-3.1.14, created on 2013-10-10 20:43:00
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:55825254178bc36026-58576380%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '092b9da2ee8b3196adaf6c450ec78f8e8479047f' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample\\presentation\\templates\\searchbox.tpl',
      1 => 1381241550,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '55825254178bc36026-58576380',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5254178bc381b0_48628122',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5254178bc381b0_48628122')) {function content_5254178bc381b0_48628122($_smarty_tpl) {?>
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