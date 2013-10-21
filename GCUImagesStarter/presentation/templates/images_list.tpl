{* images_list.tpl *}
{load_presentation_object filename="images_list" assign="obj"}

{if $obj->mImages}

	<div id="galleryThumbnail">
		
		{section name=i loop=$obj->mImages} 
        	
			{math equation="x % 4" x={$smarty.section.i.index} assign="resultcond"}        
        	{if $resultcond eq 0} 	<div class="row">	{/if}
			
			<div class="cell">
				<p>					
					<img src="./images/{$obj->mImages[i].image_url}" alt="{$obj->mImages[i].image_title}"  height="100" width="100" />
					<span>
						{$obj->mImages[i].image_title}<br />
						{$obj->mImages[i].image_contributor}
					</span>
				</p>
			</div>
			
			{math equation="x % 4" x={$smarty.section.i.index}+1 assign="resultcond"} 
        	{if $resultcond eq 0} </div>    	{/if}            
		
		{/section}
	</div>
	
{/if}
<div>
{if count($obj->mImageListPages) > 0}
	<div>
		{if $obj->mLinkToPreviousPage}
			<a href="{$obj->mLinkToPreviousPage}"> << </a>
		{/if}		
			
		{section name=m loop=$obj->mImageListPages}
			{if $obj->mPage eq $smarty.section.m.index_next}
				<strong> {$smarty.section.m.index_next} </strong>
			{else}
				<a href="{$obj->mImageListPages[m]}">{$smarty.section.m.index_next} </a>
			{/if}
		{/section}
		
		{if $obj->mLinkToNextPage}
			<a href="{$obj->mLinkToNextPage}"> >> </a>
		{/if}		
	</div>	
{/if}
</div>	
