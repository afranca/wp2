{load_presentation_object filename="image_details" assign="obj"}

{if $obj->mImage}
<div>
    <div id="image">
		
		<div id='leftItemTemplate'>
			<h3>{$obj->mImage.image_title}</h3>
			<div id="image_cont"><b>Contributor:</b> {$obj->mImage.image_contributor}</div>  
        	<div id="image_cat"><b>Category:</b> {$obj->mImage.category}</div>   
            <div id="image_desc"><b>Description:</b> {$obj->mImage.image_description}</div>
			<p><img src='./images/{$obj->mImage.image_url}' alt='{$obj->mImage.image_title}' width='400'  /></p>

                     
			<div id="ratingDiv">
            	<p>

                </p>
			</div>
		</div>
		<div id='rightItemTemplate'>
			<h3>Asssocitated Tags</h3>
			{if $obj->mTags}
				<div id="tags">
                	
					<ul>						
						{section name=i loop=$obj->mTags}
							<li> {$obj->mTags[i].tag_name} </li>
						{/section}        
					</ul>
				</div>	
			{else}
				<br>No tags associated with this image
			{/if}
		</div>
	</div>
</div>
{/if}       
 