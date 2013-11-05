<?php /* Smarty version Smarty-3.1.14, created on 2013-11-05 23:13:04
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\adm_image_create.tpl" */ ?>
<?php /*%%SmartyHeaderCode:28259526d5ba5995f17-04305464%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e9c0cba00fc0b0cb024209de03af786ca91dc6d7' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\adm_image_create.tpl',
      1 => 1383689583,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '28259526d5ba5995f17-04305464',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526d5ba59bdff1_93888288',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526d5ba59bdff1_93888288')) {function content_526d5ba59bdff1_93888288($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php echo smarty_function_load_presentation_object(array('filename'=>"adm_image_create",'assign'=>"obj"),$_smarty_tpl);?>



<script>
function submitForm(){	
	
	var image_title = document.getElementById('image_title').value;
	var image_contributor = document.getElementById('image_contributor').value;
	
	if (image_title.trim()==""){
		alert("Ttitle is a mandatory field");
		return;
	}
	
	if (image_contributor.trim()==""){
		alert("Contributor is a mandatory field");
		return;
	}
	

	document.getElementById("form1").submit();

}
</script>

<div>
    <div id="image">
		<h2> &nbsp; </h2>
		<div id='leftItemTemplate'>
			<form action="?op=admImageSave" id="form1" method="post" enctype="multipart/form-data"> 
				
				Title: <input type="text" name="image_title" id="image_title" value="" size="60"/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value=""  size="60"/> <br>
				Category:<br>   <SELECT name="image_category">
								<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mCategories) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = true;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['max'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] = 1;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] > 0 ? 0 : $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop']-1;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']) {
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
    if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] == 0)
        $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = false;
} else
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = 0;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']):

            for ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] = 1;
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] <= $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'];
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] += $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration']++):
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['rownum'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_prev'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] - $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_next'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] + $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['first']      = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == 1);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['last']       = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total']);
?>
									<OPTION VALUE="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mCategories[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['category'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mCategories[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['category'];?>
</OPTION>
								<?php endfor; endif; ?> 
							</SELECT>
				<br>			
				Description: <br><textarea name="image_description" id="image_description" rows="5" cols="46"></textarea> <br>
				
				
				New Image: <input type="file" name="new_image" id="new_image">
				<br><br>
				<input type="button" value="Save" onclick="javascript:submitForm()"> 
				&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Cancel" onclick="javascript:location.href='http://localhost/GCUImagesStarter/index.php?op=admImageList'"> 
			</form>

		</div>
		<div id='rightItemTemplate'>
				<h2>Tags</h2>
				<form>
					<input type="text"   id="tag_name" size="30" onkeyup="javascript:showResult(this.value)"> <input type="button" value="assign"  onclick="javascript:alert('Before assigning tags, fill in image details and save it');">
					<input type="hidden" id="tag_id">
					<div id="livesearch"></div>				
				</form>			
				<div id="tags">

				</div>	

			
		</div>
	</div>
</div>
       
 <?php }} ?>