{* contributors_list.tpl *}
{load_presentation_object filename="contributors_list" assign="obj"}

{if $obj->mContributors}
	<table id='GridView1' cellspacing='0' cellpadding='4' border='0' width='800'>
<!--	<thead>
	<tr style='color:White;background-color:#CD80F8;font-weight:bold;font-size:large;'>
		<th scope='col'>Contributor</th>
		<th scope='col'>Images</th>
	</tr>
	</thead>-->
	<tbody>
	{* Loop through the list of contributors *}
	{section name=i loop=$obj->mContributors}
	<!--<tr class="{cycle values="odd,even"}">-->
    		<tr>
			{* Generate a new contributor in the list *}
			<td>
            		{$obj->mContributors[i].image_contributor}
			</td>
        		<td>
        			<table>
            		<tr>
            		{section name=j loop=$obj->mContributorImages[i]}
                		<td>
						<img src="./images/{$obj->mContributorImages[i][j].image_url}"
							alt="{$obj->mContributorImages[i][j].image_title}"
                        			height="50" width="50" />
						<br />
                		</td>
                	{/section}
            		</tr>
            		</table>
        		</td>
		</tr>
	{/section}
	</tbody>
	</table>
	{* End contributors list *}
{/if}


