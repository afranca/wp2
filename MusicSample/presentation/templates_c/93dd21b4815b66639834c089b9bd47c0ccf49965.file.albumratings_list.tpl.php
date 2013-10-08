<?php /* Smarty version Smarty-3.1.14, created on 2013-10-03 17:21:01
         compiled from "C:\xampp\htdocs\MusicSample\presentation\templates\albumratings_list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:8474524d8b5d4aa772-67532577%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '93dd21b4815b66639834c089b9bd47c0ccf49965' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample\\presentation\\templates\\albumratings_list.tpl',
      1 => 1377090448,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '8474524d8b5d4aa772-67532577',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_524d8b5d535812_88616580',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_524d8b5d535812_88616580')) {function content_524d8b5d535812_88616580($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\MusicSample/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"albumratings_list",'assign'=>"obj"),$_smarty_tpl);?>

<div>
    <h2>Rated Albums</h2>
	<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums){?>
		<ul>
		
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
			<li>
				
                <?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_id']!=$_smarty_tpl->tpl_vars['obj']->value->mAlbumID){?>
                    <?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image']!=''){?>
                        <a href="?op=Details&album_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_id'];?>
">      
                            <img src="./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>
"
                                height="30" width="30" /></a>
                        
                    <?php }?> 
                    &nbsp;
                    <?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['average_rating']!=0){?>
                        <img src="./images/rated<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['average_rating'];?>
.png" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['average_rating'];?>
 stars"
                            height="10" />
                    <?php }else{ ?>
                        <img src="./images/rated0.png" alt="not rated"
                            height="10"	/>
                    <?php }?><br />
                    <?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>

                <?php }?>
		<?php endfor; endif; ?>
    	</ul>
	
	<?php }?>
</div>



<?php }} ?>