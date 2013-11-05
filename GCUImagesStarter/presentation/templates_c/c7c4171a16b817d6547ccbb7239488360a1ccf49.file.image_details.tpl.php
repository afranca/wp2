<?php /* Smarty version Smarty-3.1.14, created on 2013-10-30 13:53:55
         compiled from "C:\Apps\xampp\htdocs\GCUImagesStarter\presentation\templates\image_details.tpl" */ ?>
<?php /*%%SmartyHeaderCode:77425270ffe92baaf2-96569236%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c7c4171a16b817d6547ccbb7239488360a1ccf49' => 
    array (
      0 => 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter\\presentation\\templates\\image_details.tpl',
      1 => 1383137633,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '77425270ffe92baaf2-96569236',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5270ffe937a006_06918315',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5270ffe937a006_06918315')) {function content_5270ffe937a006_06918315($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Apps\\xampp\\htdocs\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php echo smarty_function_load_presentation_object(array('filename'=>"image_details",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mImage){?>
<div>
    <div id="image">
		<h2><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
 by <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_contributor'];?>
 </h2>
		<div id='leftItemTemplate'>
        	<div id="image_cat"><b>Category:</b><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['category'];?>
</div>   
            <div id="image_desc"><b>Description:</b><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_description'];?>
</div>
			<p><img src='./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_url'];?>
' alt='<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
' height='200' width='200' /></p>

                     
			<div id="ratingDiv">
            	<p>

                </p>
			</div>
		</div>
		<div id='rightItemTemplate'>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mTags){?>
				<div id="tags">
                	<h2>Tags</h2>
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
							<li> <?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_name'];?>
 </li>
						<?php endfor; endif; ?>        
					</ul>
				</div>			
			<?php }?>
		</div>
	</div>
</div>
<?php }?>       
 <?php }} ?>