{* categories_list.tpl *}
{load_presentation_object filename="categories_list" assign="obj"}
<div>
    <h2>Categories</h2>
	{if $obj->mCategories}
		<ul>
		{* Loop through the list of categories *}
		{section name=i loop=$obj->mCategories}
			<li>
				{* Generate a new category in the list *}
        			<a href="?op=SearchCategory&searchParam={$obj->mCategories[i].category}{if $obj->searchText}&searchText={$obj->searchText}{/if}"> {$obj->mCategories[i].category}</a>&nbsp; ({$obj->mCategories[i].kount})
        
			</li>
		{/section}
    		</ul>
	{* End categories list *}
	{/if}
</div>



