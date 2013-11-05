<?php /* Smarty version Smarty-3.1.14, created on 2013-11-01 17:55:10
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\image_details.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1275252655fc74dc4f3-10046812%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f261e1328ab27430322191ab97a14650a7e99b0f' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\image_details.tpl',
      1 => 1383324908,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1275252655fc74dc4f3-10046812',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_52655fc752cf54_36819170',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52655fc752cf54_36819170')) {function content_52655fc752cf54_36819170($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php echo smarty_function_load_presentation_object(array('filename'=>"image_details",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mImage){?>
<div>
    <div id="image">
		
		<div id='leftItemTemplate'>
			<h3><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
</h3>
			<div id="image_cont"><b>Contributor:</b> <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_contributor'];?>
</div>  
        	<div id="image_cat"><b>Category:</b> <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['category'];?>
</div>   
            <div id="image_desc"><b>Description:</b> <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_description'];?>
</div>
			<p><img src='./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_url'];?>
' alt='<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
' width='400'  /></p>

                     
			<div id="ratingDiv">
            	<p>
					<?php if ($_smarty_tpl->tpl_vars['obj']->value->mImage['average_rating']!=0){?>
						<img src="./include/rated<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['average_rating'];?>
.png" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['average_rating'];?>
 stars" height="10" />
					<?php }else{ ?>
						<img src="./include/rated0.png" alt="not rated" height="10"	/>
					<?php }?>
           			(<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['no_ratings'];?>
)
					<input type="button" value="Rate" onclick="document.getElementById('ratingFormDiv').style.display='block'; document.getElementById('ratingDiv').style.display='none';" /> 
                </p>
			</div>
			<div id="ratingFormDiv">
				<form id="ratingForm" method="post" action="?op=Rate">
					<input name="rating" type="radio" value="1" checked="checked" />1
					<input name="rating" type="radio" value="2" />2
					<input name="rating" type="radio" value="3" />3
					<input name="rating" type="radio" value="4" />4
					<input name="rating" type="radio" value="5" />5
					<input type="hidden" name="image_id" id="image_id" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImageID;?>
" />
					<input type="submit" value="Rate" />
				</form>
			</div> 			
		</div>
		<div id='rightItemTemplate'>
			<h3>Asssocitated Tags</h3>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mTags){?>
				<div id="tags">
                	
					<ul>						
						<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mTags) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
							
							<li><a href="?op=SearchTag&searchParam=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_name'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_name'];?>
</a></li>
						<?php endfor; endif; ?>        
					</ul>
				</div>	
			<?php }else{ ?>
				<br>No tags associated with this image
			<?php }?>
		</div>
	</div>
</div>
<?php }?>       
 <?php }} ?>