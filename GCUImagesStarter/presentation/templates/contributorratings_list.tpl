{load_presentation_object filename="contributorratings_list" assign="obj"}
<div>
    <h2>Highest Rated Contributor</h2>
	{if $obj->mContributors}
		<ul>

		{section name=i loop=$obj->mContributors}
			<li>

                {$obj->mContributors[i].image_contributor}<br />
				&nbsp;
				{if $obj->mContributors[i].average_rating neq 0}
					<img src="./include/rated{$obj->mContributors[i].average_rating}.png" alt="{$obj->mContributors[i].average_rating} stars" height="10" />
				{else}
					<img src="./include/rated0.png" alt="not rated" height="10"	/>
				{/if}<br />
		{/section}
    	</ul>

	{/if}
</div>



