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
					{if $obj->mImage.average_rating neq 0}
						<img src="./include/rated{$obj->mImage.average_rating}.png" alt="{$obj->mImage.average_rating} stars" height="10" />
					{else}
						<img src="./include/rated0.png" alt="not rated" height="10"	/>
					{/if}
           			({$obj->mImage.no_ratings})
					<input type="button" value="Rate" onclick="document.getElementById('ratingFormDiv').style.display='block'; document.getElementById('ratingDiv').style.display='none';" /> 
                </p>
			</div>
			<div id="ratingFormDiv">
				<form id="ratingForm" method="post" action="?op=Rate">
					<input name="rating" type="radio" value="1" checked="checked" />1
					<input name="rating" type="radio" value="2" />2
					<input name="rating" type="radio" value="3" />3
					<input name="rating" type="radio" value="4" />4
					<input name="rating" type="radio" value="5" />5
					<input type="hidden" name="image_id" id="image_id" value="{$obj->mImageID}" />
					<input type="submit" value="Rate" />
				</form>
			</div> 			
		</div>
		<div id='rightItemTemplate'>
			<h3>Asssocitated Tags</h3>
			{if $obj->mTags}
				<div id="tags">
                	
					<ul>						
						{section name=i loop=$obj->mTags}
							
							<li><a href="?op=SearchTag&searchParam={$obj->mTags[i].tag_name}">{$obj->mTags[i].tag_name}</a></li>
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
 