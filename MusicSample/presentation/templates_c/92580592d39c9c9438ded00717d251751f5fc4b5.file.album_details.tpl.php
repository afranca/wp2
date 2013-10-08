<?php /* Smarty version Smarty-3.1.14, created on 2013-10-03 17:23:32
         compiled from "C:\xampp\htdocs\MusicSample\presentation\templates\album_details.tpl" */ ?>
<?php /*%%SmartyHeaderCode:20008524d8baee49357-25048549%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '92580592d39c9c9438ded00717d251751f5fc4b5' => 
    array (
      0 => 'C:\\xampp\\htdocs\\MusicSample\\presentation\\templates\\album_details.tpl',
      1 => 1380813792,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20008524d8baee49357-25048549',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_524d8baeeca5e8_34749817',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_524d8baeeca5e8_34749817')) {function content_524d8baeeca5e8_34749817($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\MusicSample/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"album_details",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbum){?>
<div>
    <div id="album">
		<h2><?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['album_title'];?>
 - <?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['artist'];?>
 (<?php echo $_smarty_tpl->tpl_vars['obj']->value->mYear;?>
)</h2>
		<div id='leftItemTemplate'>
			<p><img src='./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['image'];?>
' alt='<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['album_title'];?>
 Album Cover'
					height='200' width='200' /></p>
			<div id="ratingDiv">
            	<p>
					<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbum['average_rating']!=0){?>
						<img src="./images/rated<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['average_rating'];?>
.png" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['average_rating'];?>
 stars"
								height="10" />
					<?php }else{ ?>
						<img src="./images/rated0.png" alt="not rated"
							height="10"	/>
					<?php }?>
           			(<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbum['no_ratings'];?>
)
                </p>
			</div>
		</div>
		<div id='rightItemTemplate'>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mTracks){?>
				<div id="tracks">
					<ul>
						
						<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mTracks) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
							
							<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTracks[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['track_no'];?>
&nbsp;
							<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTracks[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['track_title'];?>

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