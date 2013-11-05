<?php /* Smarty version Smarty-3.1.14, created on 2013-11-04 14:55:59
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\adm_images_list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12329526a8c20972b32-90767013%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '072d62235a32ecdec6c8e1e1efe193c02b0386f9' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\adm_images_list.tpl',
      1 => 1383573357,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12329526a8c20972b32-90767013',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526a8c20aee586_84405243',
  'variables' => 
  array (
    'obj' => 0,
    'resultcond' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526a8c20aee586_84405243')) {function content_526a8c20aee586_84405243($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
if (!is_callable('smarty_function_math')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/libs/smarty/plugins\\function.math.php';
?><?php echo smarty_function_load_presentation_object(array('filename'=>"adm_images_list",'assign'=>"obj"),$_smarty_tpl);?>

<script>
function confirmDeletion(image_id){

	if(confirm("Confirm permanent deletion?")){
		//alert("http://localhost/GCUImagesStarter/index.php?op=admImageDelete&image_id="+image_id);

			//window.location = "http://localhost/GCUImagesStarter/index.php?op=admImageDelete&image_id="+image_id;
			window.location = "http://localhost/GCUImagesStarter/index.php?op=admImageDelete&Page=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mPage;?>
&image_id="+image_id;
	
	}
}
</script>
<div id="adm_content">
	<?php if ($_smarty_tpl->tpl_vars['obj']->value->mImages){?>

		<div id="admin_galleryThumbnail" >
			<table width="600" border=0>
				<tr class="header_row">	
					<td> Name </td>
					<td> Author </td>
					<td width="40"> Edit </td>
					<td  width="40"> Delete </td>
				</tr>	
				
				<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mImages) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
					<?php ob_start();?><?php echo $_smarty_tpl->getVariable('smarty')->value['section']['i']['index'];?>
<?php $_tmp1=ob_get_clean();?><?php echo smarty_function_math(array('equation'=>"x % 2",'x'=>$_tmp1,'assign'=>"resultcond"),$_smarty_tpl);?>
        				
					
					<tr <?php if ($_smarty_tpl->tpl_vars['resultcond']->value==0){?> class="odd_row"	 <?php }else{ ?>  class="even_row" <?php }?>>
						<td>
							<p>								
								<a href="?op=admImageEdit&image_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_id'];?>
">
									<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_title'];?>
 
								</a>
								
								<span id="span_thumbnail">
									<?php echo substr($_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_description'],0,75);?>
... <br>
									<?php if ($_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_url']!=''){?>
										<img src="./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_url'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_title'];?>
"  height="100" /> 
									<?php }?>
									
									
								</span>
							</p>
						</td>	
						<td> <a href="?op=admImageEdit&image_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_contributor'];?>
 </a></td>
						<td> <a href="?op=admImageEdit&image_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_id'];?>
"> <img src="./include/edit_icon.png" height="20"> </a></td>
						<td> <a href="javascript:confirmDeletion(<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImages[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image_id'];?>
);"> <img src="./include/delete_icon.png" height="20"> </a></td>	
					</tr>	
				<?php endfor; endif; ?>
			</table>
		</div>	
	<?php }?>


	<div>
	<?php if (count($_smarty_tpl->tpl_vars['obj']->value->mImageListPages)>0){?>
		<div>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLinkToPreviousPage){?>
				<a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mLinkToPreviousPage;?>
"> << </a>
			<?php }?>		
				
			<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['m'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['m']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['name'] = 'm';
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mImageListPages) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['show'] = true;
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['max'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['loop'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['step'] = 1;
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['start'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['step'] > 0 ? 0 : $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['loop']-1;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['show']) {
    $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['total'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['loop'];
    if ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['total'] == 0)
        $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['show'] = false;
} else
    $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['total'] = 0;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['show']):

            for ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['start'], $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration'] = 1;
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration'] <= $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['total'];
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index'] += $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['step'], $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration']++):
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['rownum'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index_prev'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index'] - $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index_next'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['index'] + $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['first']      = ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration'] == 1);
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['last']       = ($_smarty_tpl->tpl_vars['smarty']->value['section']['m']['iteration'] == $_smarty_tpl->tpl_vars['smarty']->value['section']['m']['total']);
?>
				<?php if ($_smarty_tpl->tpl_vars['obj']->value->mPage==$_smarty_tpl->getVariable('smarty')->value['section']['m']['index_next']){?>
					<strong> <?php echo $_smarty_tpl->getVariable('smarty')->value['section']['m']['index_next'];?>
 </strong>
				<?php }else{ ?>
					<a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImageListPages[$_smarty_tpl->getVariable('smarty')->value['section']['m']['index']];?>
"><?php echo $_smarty_tpl->getVariable('smarty')->value['section']['m']['index_next'];?>
 </a>
				<?php }?>
			<?php endfor; endif; ?>
			
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLinkToNextPage){?>
				<a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mLinkToNextPage;?>
"> >> </a>
			<?php }?>		
		</div>	
	<?php }?>
	</div>	

</div>
<?php }} ?>