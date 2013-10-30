{load_presentation_object filename="adm_image_create" assign="obj"}
<div>
    <div id="image">
		<h2> &nbsp; </h2>
		<div id='admin_leftItemTemplate'>
			<form action="?op=admImageSave" method="post" enctype="multipart/form-data"> 
				
				Title: <input type="text" name="image_title" id="image_title" value="" size="60"/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value=""  size="60"/> <br>
				Category:<br>   <SELECT name="image_category">
								{section name=i loop=$obj->mCategories}
									<OPTION VALUE="{$obj->mCategories[i].category}">{$obj->mCategories[i].category}</OPTION>
								{/section} 
							</SELECT>
				<br>			
				Description: <br><textarea name="image_description" id="image_description" rows="5" cols="30"></textarea> <br>
				
				
				New Image: <input type="file" name="new_image" id="name="new_image">
				<br>
				<input type="submit" value="Save">
			</form>

		</div>
		<div id='admin_rightItemTemplate'>
				<h2>Tags</h2>
				<form>
					<input type="text"   id="tag_name" size="30" onkeyup="javascript:showResult(this.value)"> <input type="button" value="assign"  onclick="javascript:alert('Before assigning tags, fill in image details and save it');">
					<input type="hidden" id="tag_id">
					<div id="livesearch"></div>				
				</form>			
				<div id="tags">

				</div>	

			
		</div>
	</div>
</div>
       
 