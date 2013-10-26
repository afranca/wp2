{load_presentation_object filename="adm_image_edit" assign="obj"}

{if $obj->mImage}
<div>
    <div id="image">
		<h2>{$obj->mImage.image_title} by {$obj->mImage.image_contributor} </h2>
		<div id='leftItemTemplate'>
			<form action="file_handler.php" method="post" enctype="multipart/form-data"> 
				Title: <input type="text" name="image_title" id="image_title" value="{$obj->mImage.image_title}"/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value="{$obj->mImage.image_contributor}"/> <br>
				Description: <textarea name="image_description" id="image_description" rows="5" cols="50"> {$obj->mImage.image_description} </textarea> <br>
				
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
		</div>
	</div>
</div>
{/if}       
 