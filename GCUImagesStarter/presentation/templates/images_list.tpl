{* images_list.tpl *}
{load_presentation_object filename="images_list" assign="obj"}

{if $obj->mImages}
	<div id="galleryThumbnail">
		{* Loop through the list of images *}
		{section name=i loop=$obj->mImages} 
        	{math equation="x % 4" x={$smarty.section.i.index} assign="resultcond"}        
        	{if $resultcond eq 0}             
			<div class="row">
		{/if}
				<div class="cell">
				<p>
                		{* Generate a new image in the list *}
                    	<img src="./images/{$obj->mImages[i].image_url}" alt="{$obj->mImages[i].image_title}"
                        		 height="100" width="100" />
					<span>
						{$obj->mImages[i].image_title}<br />
						{$obj->mImages[i].image_contributor}
					</span>
				</p>
				</div>
		{math equation="x % 4" x={$smarty.section.i.index}+1 assign="resultcond"} 
        	{if $resultcond eq 0}              
			</div>
        	{/if}            
		{/section}
	</div>
	{* End images list *}
{/if}

