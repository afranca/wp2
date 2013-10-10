{* albums_list.tpl *}
{load_presentation_object filename="albums_list" assign="obj"}

{if $obj->mAlbums}
	<div id="galleryThumbnail">
		{* Loop through the list of album *}
		{section name=i loop=$obj->mAlbums} 
        	{math equation="x % 4" x={$smarty.section.i.index} assign="resultcond"}        
        	{if $resultcond eq 0}             
		  		<div class="row">
          	{/if}
			<div class="cell">
				<p>
                	{* Generate a new album in the list *}
					{if $obj->mAlbums[i].image neq ""}
                    	<a href="?op=Details&album_id={$obj->mAlbums[i].album_id}">      
							<img src="./images/{$obj->mAlbums[i].image}" alt="{$obj->mAlbums[i].album_title}"
                        		 height="100" width="100" />
                         </a>
					{/if}                     
					<span>
                           {$obj->mAlbums[i].album_title}<br />
							{$obj->mAlbums[i].artist}
					</span>
				</p>
			</div>
            {math equation="x % 4" x={$smarty.section.i.index}+1 assign="resultcond"} 
        	{if $resultcond eq 0}              
		   		</div>
        	{/if}            
		{/section}
	</div>
{* End albums list *}
{/if}
<div>
{if count($obj->mAlbumListPages) > 0}
	<div>
		{if $obj->mLinkToPreviousPage}
			<a href="{$obj->mLinkToPreviousPage}">Previous page</a>
		{/if}		
			
		{section name=m loop=$obj->mAlbumListPages}
			{if $obj->mPage eq $smarty.section.m.index_next}
				<strong> {$smarty.section.m.index_next} </strong>
			{else}
				<a href="{$obj->mAlbumListPages[m]}">{$smarty.section.m.index_next} </a>
			{/if}
		{/section}
		
		{if $obj->mLinkToNextPage}
			<a href="{$obj->mLinkToNextPage}">Next page</a>
		{/if}		
	</div>	
{/if}
</div>	
