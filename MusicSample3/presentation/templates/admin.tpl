{* admin.tpl *}
{load_presentation_object filename="admin" assign="obj"}
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Martin L Gallacher" />
  <meta name="keywords" content="Music, Collection" />
  <meta name="description" content="Music Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2012.css"
	    title="Default" media="all" />
  <title>{#site_title#}</title>
</head>
<body>
  <div id="container">
	{include file="header.tpl"}
	{if $obj->mLoggedIn neq TRUE}
		<div id="loginDiv">
			{include file="login.tpl"}
		</div>
	{else}
		<div id="logout">
			<a href="admin.php?Page=Logout">Logout</a>
		</div>
	
<div id='leftItemTemplate'>
	<h3>Add New Album</h3>
	<form method="post" action="admin.php">
		{if $obj->mErrorMessage}<p class="error">{$obj->mErrorMessage}</p>{/if}
		<div>
        	<p>
        		<label for="new_album_title">Title:</label><br />
				<input type="text" name="new_album_title" value="{$obj->mAlbumTitle}" size="40" />
            </p>
            <p>
        		<label for="new_artist">Artist:</label><br />            
				<input type="text" name="new_artist" value="{$obj->mArtist}" size="40" />
            </p>
			<p>
        		<label for="new_release_date">Release Date:</label><br /> 			
            	<input type="text" name="new_release_date" value="{$obj->mReleaseDate}" size="10" />
            </p>
			<p>
        		<label for="new_image">Image:</label><br />			
            	<input type="text" name="new_image" value="{$obj->mImage}" size="40" />
            </p>
			<p>
        		<label for="new_date_bought">Date Bought:</label><br />				
            	<input type="text" name="new_date_bought" value="{$obj->mDateBought}" size="10" />
            </p>
			<p>
        		<label for="new_category">Category:</label><br />			
            	<input type="text" name="new_category" value="{$obj->mCategory}" size="10" />
            </p>
        	<p>
            	<input type="hidden" name="album_id" value="{$obj->mAlbumID}" />
            </p>                          
			<p>
            	<input type="submit" name="submit_add" value="Add" />
				<input type="submit" name="submit_edit" value="Update" /> 
            </p>
		</div>
	</form>
</div>
{if $obj->mArtists}
	<div id='rightItemTemplate'>
		<h3>Find Album to Update</h3>
		<form method="post" action="admin.php">
		<div>
        	<p>
    		<select name="artists">
    			<option>Select Artist</option>
			{* Loop through the list of artists *}
			{section name=i loop=$obj->mArtists}
				{* Generate a new artist in the list *}
                <option value="{$obj->mArtists[i].artist}">{$obj->mArtists[i].artist}</option>
        	{/section}        
			</select>
            </p>
            <p>
			<input type="submit" name="submit_select_artist" value="Select Artist" />        
            </p>
		</div>
    	</form>
		{if $obj->mAlbums}
			<form method="post" action="admin.php">
			<div>
            	<p>
    			<select name="albums">
				{* Loop through the list of albums *}
				{section name=i loop=$obj->mAlbums}
					{* Generate a new album in the list *}
					<option value="{$obj->mAlbums[i].album_id}">{$obj->mAlbums[i].album_title}</option>
        		{/section}        
				</select>
                </p>
                <p>
				<input type="submit" name="submit_select_album" value="Select Album" />        
                </p>
			</div>
    		</form>
		{/if}
		
		
		<div id='rightItemTemplateTrack'>
			<form method="post" action="admin.php">
				<input type="hidden" name="album_id" value="{$obj->mAlbumID}" />
		 		Track Title: <input type=text name="new_track_title" > <br>
				Track No: <input type=text name="new_track_no"> <br>
				Track Length: <input type=text name="new_track_length"> <br>
				<input type=submit >
			</form>

		
		</div>
    </div>
	 

	
	
	
{/if}
		{/if}
	{include file="footer.tpl"}
  </div>
</body>
</html>