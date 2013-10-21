<?php /* Smarty version Smarty-3.1.14, created on 2013-10-21 23:15:15
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\MusicSample3\presentation\templates\admin.tpl" */ ?>
<?php /*%%SmartyHeaderCode:27368526599637d8703-55057242%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd6ac406631171d0cf5f7b9681ff2b7987002b419' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3\\presentation\\templates\\admin.tpl',
      1 => 1382023496,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '27368526599637d8703-55057242',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526599638b0847_19590325',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526599638b0847_19590325')) {function content_526599638b0847_19590325($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\MusicSample3/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"admin",'assign'=>"obj"),$_smarty_tpl);?>

<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="Music, Collection" />
  <meta name="description" content="Music Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title><?php echo $_smarty_tpl->getConfigVariable('site_title');?>
</title>
</head>
<body>
  <div id="container">
	<?php echo $_smarty_tpl->getSubTemplate ("header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLoggedIn!=true){?>
		<div id="loginDiv">
			<?php echo $_smarty_tpl->getSubTemplate ("login.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

		</div>
	<?php }else{ ?>
		<div id="logout">
			<a href="admin.php?Page=Logout">Logout</a>
		</div>
	
<div id='leftItemTemplate'>
	<h3>Add New Album</h3>
	<form method="post" action="admin.php">
		<?php if ($_smarty_tpl->tpl_vars['obj']->value->mErrorMessage){?><p class="error"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mErrorMessage;?>
</p><?php }?>
		<div>
        	<p>
        		<label for="new_album_title">Title:</label><br />
				<input type="text" name="new_album_title" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbumTitle;?>
" size="40" />
            </p>
            <p>
        		<label for="new_artist">Artist:</label><br />            
				<input type="text" name="new_artist" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mArtist;?>
" size="40" />
            </p>
			<p>
        		<label for="new_release_date">Release Date:</label><br /> 			
            	<input type="text" name="new_release_date" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mReleaseDate;?>
" size="10" />
            </p>
			<p>
        		<label for="new_image">Image:</label><br />			
            	<input type="text" name="new_image" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage;?>
" size="40" />
            </p>
			<p>
        		<label for="new_date_bought">Date Bought:</label><br />				
            	<input type="text" name="new_date_bought" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mDateBought;?>
" size="10" />
            </p>
			<p>
        		<label for="new_category">Category:</label><br />			
            	<input type="text" name="new_category" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mCategory;?>
" size="10" />
            </p>
        	<p>
            	<input type="hidden" name="album_id" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbumID;?>
" />
            </p>                          
			<p>
            	<input type="submit" name="submit_add" value="Add" />
				<input type="submit" name="submit_edit" value="Update" /> 
            </p>
		</div>
	</form>
</div>
<?php if ($_smarty_tpl->tpl_vars['obj']->value->mArtists){?>
	<div id='rightItemTemplate'>
		<h3>Find Album to Update</h3>
		<form method="post" action="admin.php">
		<div>
        	<p>
    		<select name="artists">
    			<option>Select Artist</option>
			
			<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mArtists) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
				
                <option value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mArtists[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['artist'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mArtists[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['artist'];?>
</option>
        	<?php endfor; endif; ?>        
			</select>
            </p>
            <p>
			<input type="submit" name="submit_select_artist" value="Select Artist" />        
            </p>
		</div>
    	</form>
		<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAlbums){?>
			<form method="post" action="admin.php">
			<div>
            	<p>
    			<select name="albums">
				
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
					
					<option value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbums[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['album_title'];?>
</option>
        		<?php endfor; endif; ?>        
				</select>
                </p>
                <p>
				<input type="submit" name="submit_select_album" value="Select Album" />        
                </p>
			</div>
    		</form>
		<?php }?>
		
		
		<div id='rightItemTemplateTrack'>
			<form method="post" action="admin.php">
				<input type="hidden" name="album_id" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mAlbumID;?>
" />
		 		Track Title: <input type=text name="new_track_title" > <br>
				Track No: <input type=text name="new_track_no"> <br>
				Track Length: <input type=text name="new_track_length"> <br>
				<input type=submit >
			</form>

		
		</div>
    </div>
	 

	
	
	
<?php }?>
		<?php }?>
	<?php echo $_smarty_tpl->getSubTemplate ("footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

  </div>
</body>
</html><?php }} ?>