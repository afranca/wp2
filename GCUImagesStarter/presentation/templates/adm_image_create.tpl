{load_presentation_object filename="adm_image_create" assign="obj"}
<div>
    <div id="image">
		<h2> &nbsp; </h2>
		<div id='leftItemTemplate'>
			<form action="?op=admImageSave" method="post" enctype="multipart/form-data"> 
				
				Title: <input type="text" name="image_title" id="image_title" value=""/> <br>
				Contributor: <input type="text" name="image_contributor" id="image_contributor" value=""/> <br>
				Description: <textarea name="image_description" id="image_description" rows="5" cols="50"></textarea> <br>
				Category:   <SELECT name="image_category">
								{section name=i loop=$obj->mCategories}
									<OPTION VALUE="{$obj->mCategories[i].category}" >{$obj->mCategories[i].category}</OPTION>
								{/section} 
							</SELECT>		<br>	
				Image: <input type="file" name="new_image" id="name="new_image">
				<br>
				<input type="submit" value="Save">
			</form>

		</div>
		<div id='rightItemTemplate'>
			
				<div id="tags">

				</div>	
				<form>
					<input type="text"   id="tag_name" size="30" onkeyup="javascript:showResult(this.value)"> <input type="button" value="assign"  onclick="javascript:alert('Before assigning tags, fill in image details and save it');">
					<input type="hidden" id="tag_id">
				<div id="livesearch"></div>
				
			</form>
			
		</div>
	</div>
</div>
       
 