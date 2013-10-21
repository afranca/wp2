{* tags_list.tpl *}
{load_presentation_object filename="tags_list" assign="obj"}
<div>
    	<h2>Tags</h2>
	{if $obj->mTags}
		<ul>
			{* Loop through the list of tags *}
			{section name=i loop=$obj->mTags}
			<li>
				{* Generate a new tag in the list *}
        			{$obj->mTags[i].tag_name}&nbsp;
					({$obj->mTags[i].kount})
			</li>
			{/section}
    		</ul>
		{* End tags list *}
	{/if}
</div>



