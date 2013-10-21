<?php /* Smarty version Smarty-3.1.14, created on 2013-10-17 16:17:21
         compiled from "C:\xampp\htdocs\MusicSample3\presentation\templates\albums_list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9929525ff171b86fe4-97384096%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f421e18f9365f9461e8af46b1a3fba0fc2dceca7' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample3\\presentation\\templates\\albums_list.tpl',
      1 => 1377009714,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9929525ff171b86fe4-97384096',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
    'resultcond' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_525ff171c2f604_52476750',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_525ff171c2f604_52476750')) {function content_525ff171c2f604_52476750($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\MusicSample3/presentation/smarty_plugins\\function.load_presentation_object.php';
if (!is_callable('smarty_function_math')) include 'C:\\xampp\\htdocs\\MusicSample3/libs/smarty/plugins\\function.math.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"albums_list",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mSearchDescription){?>
<div>
	<?php echo $_smarty_tpl->tpl_vars['obj']->value->mSearchDescription;?>

</div>
<?php }?>
<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums){?>
	<div id="galleryThumbnail">
		
		<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mAlbums) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
<?php $_tmp1=ob_get_clean();?><?php echo smarty_function_math(array('equation'=>"x % 4",'x'=>$_tmp1,'assign'=>"resultcond"),$_smarty_tpl);?>
        
        	<?php if ($_smarty_tpl->tpl_vars['resultcond']->value==0){?>             
				<div class="row">
            <?php }?>
			<div class="cell">
				<p>
                	
					<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image']!=''){?>
                    	<a href="?op=Details&album_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_id'];?>
">      
							<img src="./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>
"
                        		 height="100" width="100" />
                        </a>
					<?php }?>                     
					<span>
                        <?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>
<br />
						<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['artist'];?>

					</span>
				</p>
			</div>
            <?php ob_start();?><?php echo $_smarty_tpl->getVariable('smarty')->value['section']['i']['index'];?>
<?php $_tmp2=ob_get_clean();?><?php echo smarty_function_math(array('equation'=>"x % 4",'x'=>$_tmp2+1,'assign'=>"resultcond"),$_smarty_tpl);?>
 
        	<?php if ($_smarty_tpl->tpl_vars['resultcond']->value==0){?>              
				</div>
        	<?php }?>            
		<?php endfor; endif; ?>
	</div>

<?php }?>
<?php if (count($_smarty_tpl->tpl_vars['obj']->value->mAlbumListPages)>0){?>
<p>

  <?php if ($_smarty_tpl->tpl_vars['obj']->value->mLinkToPreviousPage){?>
  <a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mLinkToPreviousPage;?>
">Previous page</a>
  <?php }?>

  <?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['m'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['m']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['name'] = 'm';
$_smarty_tpl->tpl_vars['smarty']->value['section']['m']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mAlbumListPages) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
    <strong><?php echo $_smarty_tpl->getVariable('smarty')->value['section']['m']['index_next'];?>
</strong>
    <?php }else{ ?>
    <a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbumListPages[$_smarty_tpl->getVariable('smarty')->value['section']['m']['index']];?>
"><?php echo $_smarty_tpl->getVariable('smarty')->value['section']['m']['index_next'];?>
</a>
    <?php }?>
  <?php endfor; endif; ?>

  <?php if ($_smarty_tpl->tpl_vars['obj']->value->mLinkToNextPage){?>
  <a href="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mLinkToNextPage;?>
">Next page</a>
  <?php }?>

</p>
<?php }?>
<?php }} ?>