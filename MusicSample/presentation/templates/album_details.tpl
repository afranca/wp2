{* album_details.tpl *}
{load_presentation_object filename="album_details" assign="obj"}

{if $obj->mAlbum}
<div>
    <div id="album">
		<h2>{$obj->mAlbum.album_title} - {$obj->mAlbum.artist} ({$obj->mYear})</h2>
		<div id='leftItemTemplate'>
			<p><img src='./images/{$obj->mAlbum.image}' alt='{$obj->mAlbum.album_title} Album Cover'
					height='200' width='200' /></p>
			<div id="ratingDiv">
            	<p>
					{if $obj->mAlbum.average_rating neq 0}
						<img src="./images/rated{$obj->mAlbum.average_rating}.png" alt="{$obj->mAlbum.average_rating} stars"
								height="10" />
					{else}
						<img src="./images/rated0.png" alt="not rated"
							height="10"	/>
					{/if}
           			({$obj->mAlbum.no_ratings})
                </p>
			</div>
		</div>
		<div id='rightItemTemplate'>
			{if $obj->mTracks}
				<div id="tracks">
					<ul>
						{* Loop through the list of tracks *}
						{section name=i loop=$obj->mTracks}
						<li>
							{* Generate a new track in the list *}
							{$obj->mTracks[i].track_no}&nbsp;
							{$obj->mTracks[i].track_title}
						</li>
						{/section}        
					</ul>
				</div>
			{* End tracks list *}
			{/if}
		</div>
	</div>
{* End album *}
</div>
{/if}       
 