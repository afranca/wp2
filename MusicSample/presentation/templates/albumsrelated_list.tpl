{* albumsrelated_list.tpl *}
{load_presentation_object filename="albumratings_list" assign="obj"}
<div>
    <h2>Related Albums</h2>
	{if $obj->mAlbums}
		<ul>
		{* Loop through the list of albums *}
		{section name=i loop=$obj->mAlbums}
			<li>
				{* Generate a new album in the list *}
                {if $obj->mAlbums[i].album_id neq $obj->mAlbumID}
                    {if $obj->mAlbums[i].image neq ""}
                        <a href="?op=Details&album_id={$obj->mAlbums[i].album_id}">      
                            <img src="./images/{$obj->mAlbums[i].image}" alt="{$obj->mAlbums[i].album_title}"
                                height="30" width="30" /></a>
                        
                    {/if} 
                    &nbsp;
                    {if $obj->mAlbums[i].average_rating neq 0}
                        <img src="./images/rated{$obj->mAlbums[i].average_rating}.png" alt="{$obj->mAlbums[i].average_rating} stars"
                            height="10" />
                    {else}
                        <img src="./images/rated0.png" alt="not rated"
                            height="10"	/>
                    {/if}<br />
                    {$obj->mAlbums[i].album_title}
                {/if}
		{/section}
    	</ul>
	{* End albums list *}
	{/if}
</div>



