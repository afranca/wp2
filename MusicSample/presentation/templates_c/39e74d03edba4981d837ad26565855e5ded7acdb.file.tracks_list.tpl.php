<?php /* Smarty version Smarty-3.1.14, created on 2013-10-09 13:27:01
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample\presentation\templates\tracks_list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1600352542af5d12238-98142546%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '39e74d03edba4981d837ad26565855e5ded7acdb' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample\\presentation\\templates\\tracks_list.tpl',
      1 => 1381318019,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1600352542af5d12238-98142546',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_52542af5d78e80_16081682',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52542af5d78e80_16081682')) {function content_52542af5d78e80_16081682($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample/presentation/smarty_plugins\\function.load_presentation_object.php';
if (!is_callable('smarty_function_cycle')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample/libs/smarty/plugins\\function.cycle.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"tracks_list",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mTracks){?>
	<table id='GridView1' cellspacing='0' cellpadding='4' border='0' width='800'>
<!--	<thead>
	<tr style='color:White;background-color:#CD80F8;font-weight:bold;font-size:large;'>
		<th scope='col'>Artist</th>
		<th scope='col'>Albums</th>
	</tr>
	</thead>-->
	<tbody>
	
	
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
	<!--<tr class="<?php echo smarty_function_cycle(array('values'=>"odd,even"),$_smarty_tpl);?>
">-->
    <tr>

        <td>
        	<table>
            <tr>
            	
                <td>
                    <?php if ($_smarty_tpl->tpl_vars['obj']->value->mTrackAlbum[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image']!=''){?>
            			<a href="index.php?op=Details&album_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTracks[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_id'];?>
">      
							<img src="./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTrackAlbum[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['image'];?>
"
                            	 alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTrackAlbum[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>
"
                        		height="50" width="50" />
            			</a>
                    	<br />
					<?php }?>
                </td>
                
            </tr>
            </table>
        </td>	
		<td>
            <?php echo $_smarty_tpl->tpl_vars['obj']->value->mTracks[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['track_title'];?>
  by <b><?php echo $_smarty_tpl->tpl_vars['obj']->value->mTrackAlbum[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['artist'];?>
</b>
		</td>

	</tr>
	<?php endfor; endif; ?>
	</tbody>
	</table>

<?php }?>


<?php }} ?>