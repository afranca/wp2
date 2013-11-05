<?php /* Smarty version Smarty-3.1.14, created on 2013-11-05 23:13:50
         compiled from "C:\Users\gauchoescoces\Documents\GitHub\wp2\GCUImagesStarter\presentation\templates\adm_image_edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:20179526b91db4390f2-40312686%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2504b2e02637178ba70845b75c7914cb58761554' => 
    array (
      0 => 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter\\presentation\\templates\\adm_image_edit.tpl',
      1 => 1383689628,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '20179526b91db4390f2-40312686',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_526b91db492320_86667737',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_526b91db492320_86667737')) {function content_526b91db492320_86667737($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\Users\\gauchoescoces\\Documents\\GitHub\\wp2\\GCUImagesStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?><?php echo smarty_function_load_presentation_object(array('filename'=>"adm_image_edit",'assign'=>"obj"),$_smarty_tpl);?>



<script>

function showResult(str){
	if (str.length==0)  { 
	  document.getElementById("livesearch").innerHTML="";
	  document.getElementById("livesearch").style.border="0px";
	  return;
	}
	
	if (window.XMLHttpRequest) {
	  xmlhttp=new XMLHttpRequest();
	}else  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200)	{
			document.getElementById("livesearch").innerHTML=xmlhttp.responseText;
			document.getElementById("livesearch").style.border="1px solid #A5ACB2";
		}
	}
	xmlhttp.open("GET","presentation/livesearch.php?q="+str,true);
	xmlhttp.send();
}

function assignTagFieldTag(tag_id,tag_name){
	document.getElementById('tag_name').value = tag_name;
	document.getElementById('tag_id').value = tag_id;	
	document.getElementById("livesearch").innerHTML="";
	document.getElementById("livesearch").style.border="0px";
}


function assignTag(){

	var tag_name = document.getElementById('tag_name').value;
	var tag_id =   document.getElementById('tag_id').value;
	var image_id =   document.getElementById('image_id').value;
	
		
	if (tag_name==""){
		alert("tag name is mandatory");
		return;
	}
	
	if (window.XMLHttpRequest) {
	  xmlhttp=new XMLHttpRequest();
	}else  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
		
	
	/* CREATES NEW TAG BEFORE ASSIGNING */
	if (tag_id==""){ 		
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200)	{
				tag_id = xmlhttp.responseText;
				document.getElementById("tags").innerHTML=document.getElementById("tags").innerHTML+"<div id='"+tag_id+"'><b>[</b>"+tag_name+"<b>]</b><a href='javascript:unassignTag("+tag_id+")'>x</a>" +"</div>";
				document.getElementById('tag_name').value="";	

			} 
		}		
		xmlhttp.open("GET","presentation/create_tag.php?tag_name="+tag_name+"&image_id="+image_id,true);
		xmlhttp.send();
		
	} else {	
	/* ASSIGN EXISTING TAG */	
	

		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200)	{
				document.getElementById("tags").innerHTML=document.getElementById("tags").innerHTML+"<div id='"+tag_id+"'><b>[</b>"+tag_name+"<b>]</b><a href='javascript:unassignTag("+tag_id+")'>x</a>" +"</div>";
				document.getElementById('tag_name').value="";	
				document.getElementById('tag_id').value="";	
			} else {
				//alert("ajax error: xmlhttp.readyState="+xmlhttp.readyState+"  xmlhttp.status="+xmlhttp.status);
			}
		}	
		
		xmlhttp.open("GET","presentation/assign_tag.php?tag_id="+tag_id+"&image_id="+image_id,true);
		xmlhttp.send();	
	
	}	
	
	

}

function unassignTag(tag_id){
	
	var image_id = <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_id'];?>
;
	var d = document.getElementById('tags');
	var olddiv = document.getElementById(tag_id);
	d.removeChild(olddiv);		

		
	if (window.XMLHttpRequest) {
	  xmlhttp=new XMLHttpRequest();
	}else  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200)	{
			//document.getElementById("tags").innerHTML=document.getElementById("tags").innerHTML+"["+tag_name+"]<a href=''>x</a>" +"&nbsp;";
			//document.getElementById('tag_name').value="";			
		} else {
			//alert("ajax error: xmlhttp.readyState="+xmlhttp.readyState+"  xmlhttp.status="+xmlhttp.status);
		}
	}	
	
	xmlhttp.open("GET","presentation/unassign_tag.php?tag_id="+tag_id+"&image_id="+image_id,true);
	xmlhttp.send();
}

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
		<h3><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
 <?php if ($_smarty_tpl->tpl_vars['obj']->value->mImage){?>by <?php }?> <?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_contributor'];?>
 &nbsp; </h3>
		<div id='leftItemTemplate'>
			<form action="?op=admImageSave" id="form1"  method="post" enctype="multipart/form-data"> 
				<input type="hidden" name="image_id" id="image_id" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_id'];?>
" />
				Title: <input type="text" name="image_title" id="image_title" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
" size="60"/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_contributor'];?>
"  size="60"/> <br>
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
" <?php if ($_smarty_tpl->tpl_vars['obj']->value->mCategories[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['category']==$_smarty_tpl->tpl_vars['obj']->value->mImage['category']){?> SELECTED <?php }?>><?php echo $_smarty_tpl->tpl_vars['obj']->value->mCategories[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['category'];?>
</OPTION>
								<?php endfor; endif; ?> 
							</SELECT>
				<br>			
				Description: <br><textarea name="image_description" id="image_description" rows="5" cols="46"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_description'];?>
</textarea> <br>
				
				<p><img src='./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_url'];?>
' alt='<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage['image_title'];?>
' height='200' /></p>
				New Image: <input type="file" name="new_image" id="name="new_image">
				<br><br>
				<input type="button" value="Save" onclick="javascript:submitForm()">
				&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Cancel" onclick="javascript:location.href='http://localhost/GCUImagesStarter/index.php?op=admImageList'"> 
			</form>

		</div>
		<div id='rightItemTemplate'>
			<h2>Tags</h2>
			<form>
				<input type="text"   id="tag_name" size="30" onkeyup="javascript:showResult(this.value)"> <input type="button" value="assign"  onclick="javascript:assignTag();">
				<input type="hidden" id="tag_id">
				<div id="livesearch"></div>
				
			</form>			
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mTags){?>
				<div id="tags">
											
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
							<div id="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_id'];?>
"><b>[</b><?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_name'];?>
<b>]</b><a href='javascript:unassignTag(<?php echo $_smarty_tpl->tpl_vars['obj']->value->mTags[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['tag_id'];?>
)'>x</a> &nbsp;</div>
						<?php endfor; endif; ?>        
					
				</div>			
			<?php }?>

			
		</div>
	</div>
</div>
       
 <?php }} ?>