{load_presentation_object filename="image_details" assign="obj"}

{if $obj->mImage}
<div>
    <div id="image">
		<h2>{$obj->mImage.image_title} by {$obj->mImage.image_contributor} </h2>
		<div id='leftItemTemplate'>
			<p><img src='./images/{$obj->mImage.image_url}' alt='{$obj->mImage.image_title}' height='200' width='200' /></p>
			<div id="ratingDiv">
            	<p>

                </p>
			</div>
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
 