{load_presentation_object filename="imageratings_list" assign="obj"}
<div>
    <h2>Rated Images</h2>
	{if $obj->mImages}
		<ul>

		{section name=i loop=$obj->mImages}
			<li>
				
                {if $obj->mImages[i].image_id neq $obj->mImageID}
                    {if $obj->mImages[i].image_url neq ""}
                        <a href="?op=Details&image_id={$obj->mImages[i].image_id}">  
							<img src="./images/{$obj->mImages[i].image_url}" alt="{$obj->mImages[i].image_title}"  height="30" width="30" />
						</a>                        
                    {/if} 
                    &nbsp;
                    {if $obj->mImages[i].average_rating neq 0}
                        <img src="./include/rated{$obj->mImages[i].average_rating}.png" alt="{$obj->mImages[i].average_rating} stars"  height="10" />
                    {else}
                        <img src="./include/rated0.png" alt="not rated"  height="10"	/>
                    {/if}<br />
                    {$obj->mImages[i].image_title}
                {/if}
		{/section}
    	</ul>

	{/if}
</div>



