<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 23:15:11
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample3\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:280675265995fef09c8-82612974%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cdb3d3959701e0745a942d4b4133a175387ebf19' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3\\presentation\\templates\\searchbox.tpl',
      1 => 1376916838,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '280675265995fef09c8-82612974',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5265995fef5b04_18376822',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5265995fef5b04_18376822')) {function content_5265995fef5b04_18376822($_smarty_tpl) {?>
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