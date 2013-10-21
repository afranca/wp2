<?php /* Smarty version Smarty-3.1.14, created on 2013-10-10 16:33:09
         compiled from "C:\xampp\htdocs\MusicSample\presentation\templates\search_list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:51365256b52a8f6949-48215445%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2479e762056335fd07fb7ceea74eb3b4e73bcc23' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample\\presentation\\templates\\search_list.tpl',
      1 => 1381415581,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '51365256b52a8f6949-48215445',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5256b52a977593_65640042',
  'variables' => 
  array (
    'obj' => 0,
    'resultcond' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5256b52a977593_65640042')) {function content_5256b52a977593_65640042($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\MusicSample/presentation/smarty_plugins\\function.load_presentation_object.php';
if (!is_callable('smarty_function_math')) include 'C:\\xampp\\htdocs\\MusicSample/libs/smarty/plugins\\function.math.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"search_list",'assign'=>"obj"),$_smarty_tpl);?>


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

<?php }else{ ?>

	<div id="galleryThumbnail">

			<div class="cell">
				<p>  No entries match your search criteria	</p>
			</div>

	</div>

<?php }?>
<?php }} ?>