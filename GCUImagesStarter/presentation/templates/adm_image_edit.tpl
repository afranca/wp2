{load_presentation_object filename="adm_image_edit" assign="obj"}


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
</script>


<div>
    <div id="image">
		<h2>{$obj->mImage.image_title} {if $obj->mImage}by {/if} {$obj->mImage.image_contributor} &nbsp; </h2>
		<div id='leftItemTemplate'>
			<form action="?op=admImageSave" method="post" enctype="multipart/form-data"> 
				<input type="hidden" name="image_id" id="image_id" value="{$obj->mImage.image_id}"/>
				Title: <input type="text" name="image_title" id="image_title" value="{$obj->mImage.image_title}"/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value="{$obj->mImage.image_contributor}"/> <br>
				Category:   <SELECT name="image_category">
								{section name=i loop=$obj->mCategories}
									<OPTION VALUE="{$obj->mCategories[i].category}" {if $obj->mCategories[i].category== $obj->mImage.category} SELECTED {/if}>{$obj->mCategories[i].category}</OPTION>
								{/section} 
							</SELECT>
				Description: <textarea name="image_description" id="image_description" rows="5" cols="30"> {$obj->mImage.image_description} </textarea> <br>
				
				<p><img src='./images/{$obj->mImage.image_url}' alt='{$obj->mImage.image_title}' height='200' width='200' /></p>
				New Image: <input type="file" name="new_image" id="name="new_image">
				<br>
				<input type="submit" value="Save">
			</form>

		</div>
		<div id='rightItemTemplate'>
			{if $obj->mTags}
				<div id="tags">
					<ul>						
						{section name=i loop=$obj->mTags}
							<li> {$obj->mTags[i].tag_name} </li>
						{/section}        
					</ul>
				</div>			
			{/if}
			<form>
				<input type="text" size="30" onkeyup="javascript:showResult(this.value)">
				<div id="livesearch"></div>
			</form>
			
		</div>
	</div>
</div>
       
 