{* tags_list.tpl *}
{load_presentation_object filename="tags_list" assign="obj"}
<div>
    	<h2>Top 10 Tags</h2>
	{if $obj->mTags}
		<ul>
			{* Loop through the list of tags *}
			{section name=i max=10 loop=$obj->mTags}
			{if i==10}   {break}  {/if}
			<li>
				{* Generate a new tag in the list *}
        			<a href="?op=SearchTag&searchParam={$obj->mTags[i].tag_name}">{$obj->mTags[i].tag_name}</a>&nbsp;
					({$obj->mTags[i].kount})
			</li>
			
			{/section}
    		</ul>
		{* End tags list *}
	{/if}
</div>



