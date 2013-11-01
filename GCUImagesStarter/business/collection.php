<?php
// Business tier class for reading images information

class Collection
{
	// Retrieves all images
	public static function GetImages()
	{
		// Build SQL query
		$sql = 'CALL collection_get_images_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves latest images
	public static function GetLatestImages()
	{
		// Build SQL query
		$sql = 'CALL collection_get_images_latest()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves image details
	public static function GetImageDetails($imageId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_image_details(:image_id)';

		// Build the parameters array
		$params = array (':image_id' => $imageId);

		// Execute the query and return the results
		return DatabaseHandler::GetRow($sql, $params);
	}

		// Retrieves image tags
	public static function GetImageTags($imageId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_image_tags(:image_id)';

		// Build the parameters array
		$params = array (':image_id' => $imageId);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}


		// Retrieves image contributor details
	public static function GetImageContributor($imageId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_image_contributor(:image_id)';

		// Build the parameters array
		$params = array (':image_id' => $imageId);

		// Execute the query and return the results
		return DatabaseHandler::GetOne($sql, $params);
	}

	  	// Retrieves all contributor images
	public static function GetContributorImages($contributor)
	{
		// Build SQL query
		$sql = 'CALL collection_get_contributor_images(:image_contributor)';

		// Build the parameters array
		$params = array (':image_contributor' => $contributor);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Retrieves all tags
	public static function GetTags()
	{
		// Build SQL query
		$sql = 'CALL collection_get_tags_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves all categories
	public static function GetCategories()
	{
		// Build SQL query
		$sql = 'CALL collection_get_categories_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	/* Calculates how many pages of products could be filled by the
		number of products returned by the $countSql query */
	private static function HowManyPages($countSql, $countSqlParams)
	{
		// Create a hash for the sql query
		$queryHashCode = md5($countSql . var_export($countSqlParams, true));

		// Verify if we have the query results in cache
		if (isset ($_SESSION['last_count_hash']) &&
			isset ($_SESSION['how_many_pages']) &&
			$_SESSION['last_count_hash'] === $queryHashCode)
		{
			// Retrieve the the cached value
			$how_many_pages = $_SESSION['how_many_pages'];
		}
		else
		{
			// Execute the query
			$items_count = DatabaseHandler::GetOne($countSql, $countSqlParams);

			// Calculate the number of pages
			$how_many_pages = ceil($items_count / IMAGES_PER_PAGE);

			// Save the query and its count result in the session
			$_SESSION['last_count_hash'] = $queryHashCode;
			$_SESSION['how_many_pages'] = $how_many_pages;
		}

		// Return the number of pages
		return $how_many_pages;
	}


	// Retrieves paged list of images in collection
	public static function GetImagesInCollection($pageNo, &$rHowManyPages)
	{
		// Query that returns the number of images for the master page
		$sql = 'CALL collection_count_images_in_collection()';

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, null);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Retrieve the list of images
		$sql = 'CALL collection_get_images_on_collection(:images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':images_per_page' => IMAGES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

    	// Retrieves paged list of images with a specified tag
	public static function GetImagesByTag($tag, $pageNo, &$rHowManyPages)
	{
		// Query that returns the number of images by tag
		$sql = 'CALL collection_count_images_in_collection_by_tag(:tag)';
		$params = array(':tag' => $tag);

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Build SQL query
		$sql = 'CALL collection_get_images_by_tag(:tag, :images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':tag' => $tag, ':images_per_page' => IMAGES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

    	// Retrieves paged list of images with a specified category
	public static function GetImagesByCategory($category, $pageNo, &$rHowManyPages)
	{
		// Query that returns the number of images by category
		$sql = 'CALL collection_count_images_in_collection_by_category(:category)';
		$params = array(':category' => $category);

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Build SQL query
		$sql = 'CALL collection_get_images_by_category(:category, :images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':category' => $category, ':images_per_page' => IMAGES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Search the collection
	public static function Search($searchString, $pageNo, &$rHowManyPages)
	{
		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren't any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return $search_result;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Count the number of search results
		$sql = 'CALL collection_count_search_result(:search_string)';

		$params = array(':search_string' => $search_string);

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Retrieve the list of matching images
		$sql = 'CALL collection_search(:search_string, :images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $search_string, ':images_per_page' => IMAGES_PER_PAGE,
							':start_item' => $start_item);

		// Execute the query
		$search_result['images'] = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;

	}

	// Configure and execute search
	private static function ConfigureSearchString($searchString)
	{
		//The search result will be an array of this form
		$search_result = array ('accepted_words' => array (),
								'ignored_words' => array (),
								'albums' => array ());

		// Return void if the search string is void
		if (empty ($searchString))
			return $search_result;

		// Search string delimiters
		$delimiters = ',.; ';

		/* On the first call to strtok you supply the whole
			search string and the list of delimiters.
			It returns the first word of the string */
		$word = strtok($searchString, $delimiters);

		// Parse the string word by word until there are no more words
		while ($word)
		{
			// Short words are added to the ignored_words list from $search_result
			if (strlen($word) < FT_MIN_WORD_LEN)
				$search_result['ignored_words'][] = $word;
			else
				$search_result['accepted_words'][] = $word;

			// Get the next word of the search string
			$word = strtok($delimiters);
		}

		// Return the results
		return $search_result;
	}


	// Retrieves all contributors
	public static function GetContributors()
	{
		// Build SQL query
		$sql = 'CALL collection_get_contributors_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves all tags of Search Results
	public static function GetSearchResultTags($searchString)
	{

		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren''t any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return null;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Retrieve the list of matching images
		$sql = 'CALL collection_get_tags_list_search(:search_string)';

		// Build the parameters array
		$params = array (':search_string' => $search_string);

		// Execute the query
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Retrieves all categories of Search Results
	public static function GetSearchResultCategories($searchString)
	{

		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren't any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return null;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Retrieve the list of matching images
		$sql = 'CALL collection_get_categories_list_search(:search_string)';

		// Build the parameters array
		$params = array (':search_string' => $search_string);

		// Execute the query
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Search the collection with a specified tag
	public static function GetImagesByTagSearch($searchString, $tag, $pageNo, &$rHowManyPages)
	{

		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren''t any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return $search_result;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Count the number of search results
		$sql = 'CALL collection_count_search_tag_result(:search_string, :tag)';

		$params = array(':search_string' => $search_string, ':tag' => $tag);

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Retrieve the list of matching images
		$sql = 'CALL collection_search_tag(:search_string, :tag, :images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $search_string, ':tag' => $tag, ':images_per_page' => IMAGES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query
		$search_result['images'] = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;
	}


	// Search the collection with a specified category
	public static function GetImagesByCategorySearch($searchString, $category, $pageNo, &$rHowManyPages)
	{

		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren''t any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return $search_result;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Count the number of search results
		$sql = 'CALL collection_count_search_category_result(:search_string, :category)';

		$params = array(':search_string' => $search_string, ':category' => $category);

		// Calculate the number of pages required to display the images
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * IMAGES_PER_PAGE;

		// Retrieve the list of matching images
		$sql = 'CALL collection_search_category(:search_string, :category, :images_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $search_string, ':category' => $category, ':images_per_page' => IMAGES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query
		$search_result['images'] = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;
	}

  // Add an image
  public static function AddImage($imageTitle, $imageContributor, $imageDescription, $imageURL, $width, $height, $category){
    // Build the SQL query
    //$sql = 'CALL collection_add_image(:image_title, :image_contributor, :image_description, :image_url, :width, :height, :category)';

	$sql = "INSERT INTO image (image_title, image_contributor, image_description, image_url, width, height, category) values ('".$imageTitle."','".$imageContributor."','".$imageDescription."','".$imageURL."',".$width.",".$height.",'".$category."')";
	
    // Build the parameters array
    $params = array (':image_title' => $imageTitle,
                     ':image_contributor' => $imageContributor,
					 ':image_description' => $imageDescription,
					 ':image_url' => $imageURL,
					 ':width' => $width,
					 ':height' => $height,
					 ':category'=>$category);

    // Execute the query
    //DatabaseHandler::Execute($sql, $params);
	//echo($sql);
	DatabaseHandler::Execute($sql, null);
	
	$sql = "SELECT MAX( image_id ) as last FROM  image";
	return DatabaseHandler::GetOne($sql, null);
	
	
  }

  // Updates image details
  public static function UpdateImage($imageId, $imageTitle, $imageContributor, $imageDescription, $imageURL, $width, $height, $category)
  {
    // Build the SQL query
    $sql = 'CALL collection_update_image(:image_id, :image_title, :image_contributor, :image_description, :image_url, :width, :height, :category)';

    // Build the parameters array
    $params = array (':image_id' => $imageId,
                     ':image_title' => $imageTitle,
                     ':image_contributor' => $imageContributor,
					 ':image_description' => $imageDescription,
					 ':image_url' => $imageURL,
					 ':width' => $width,
					 ':height' => $height,
					 ':category'=>$category);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

  // Add an image tag
  public static function AddImageTag($imageID, $tagID)
  {
    // Build the SQL query
    $sql = 'CALL collection_add_image_tag(:image_id, :tag_id)';

    // Build the parameters array
    $params = array (':image_id' => $imageID,
					 ':tag_id'=>$tagID);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

  // Add a tag
  public static function AddTag($tagName)
  {
    // Build the SQL query
    $sql = 'CALL collection_add__tag(:tag_name)';

    // Build the parameters array
    $params = array (':image_id' => $tagName);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

  
   // delete an image tag
  public static function DeleteImage($image_id)
  {
	//echo("1");
	/*********************************************************************/
    /* TODO:This should be in a transaction but I cant be bother just now*/	
	/*********************************************************************/
    $sql1 = "DELETE FROM image_tag WHERE image_id=".$image_id;
	$sql2 = "DELETE FROM image WHERE image_id=".$image_id;
	//echo("2");
    // Execute the query
    DatabaseHandler::Execute($sql1,null);
	//echo("3");
	DatabaseHandler::Execute($sql2,null);
  } 
  

  public static function UpdateRating($imageId, $newRating){  
    $sql = 'CALL collection_rate_image(:image_id, :new_rating)';
    $params = array (':image_id' => $imageId,':new_rating' => $newRating);
    DatabaseHandler::Execute($sql, $params);
  }  
  
}




?>
