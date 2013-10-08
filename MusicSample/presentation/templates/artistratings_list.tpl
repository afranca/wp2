{* artist_ratings_list.tpl *}
{load_presentation_object filename="artistratings_list" assign="obj"}
<div>
    <h2>Highest Rated Artists</h2>
	{if $obj->mArtists}
		<ul>
		{* Loop through the list of artists *}
		{section name=i loop=$obj->mArtists}
			<li>
				{* Generate a new artist in the list *}
                {$obj->mArtists[i].artist}<br />
                    &nbsp;
                    {if $obj->mArtists[i].average_rating neq 0}
                        <img src="./images/rated{$obj->mArtists[i].average_rating}.png" alt="{$obj->mArtists[i].average_rating} stars"
                            height="10" />
                    {else}
                        <img src="./images/rated0.png" alt="not rated"
                            height="10"	/>
                    {/if}<br />
		{/section}
    	</ul>
	{* End artists list *}
	{/if}
</div>



