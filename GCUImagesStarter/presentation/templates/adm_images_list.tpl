{load_presentation_object filename="adm_images_list" assign="obj"}

{if $obj->mImages}

	<div id="galleryThumbnail">
		<table>
			<tr class="header_row">	
				<td> Name </td>
				<td> Author </td>
				<td> Edit </td>
				<td> Delete </td>
			</tr>	
			
			{section name=i loop=$obj->mImages} 
				{math equation="x % 2" x={$smarty.section.i.index} assign="resultcond"}        				
				
				<tr {if $resultcond eq 0} class="odd_row"	 {else}  class="even_row" {/if}>
					<td>
						<p>								
							<a href="?op=Details&image_id={$obj->mImages[i].image_id}">
								{$obj->mImages[i].image_title} 
							</a>
							
							<span>
								{if $obj->mImages[i].image_url neq ""}
									<img src="./images/{$obj->mImages[i].image_url}" alt="{$obj->mImages[i].image_title}"  height="100" width="100" />
								{/if}
								hahah <a href="">Edit</a>
							</span>
						</p>
					</td>	
					<td> <a href="">{$obj->mImages[i].image_contributor} </a></td>
					<td>  edt </td>
					<td>  del </td>		
				</tr>	
			{/section}
		</table>
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
