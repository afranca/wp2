<?php
// Business tier class for reading music collection information

class Collection
{
	// Retrieves all albums
	public static function GetAlbums()
	{
		// Build SQL query
		$sql = 'CALL collection_get_albums_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves latest albums
	public static function GetLatestAlbums()
	{
		// Build SQL query
		$sql = 'CALL collection_get_albums_latest()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves album details
	public static function GetAlbumDetails($albumId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_album_details(:album_id)';

		// Build the parameters array
		$params = array (':album_id' => $albumId);

		// Execute the query and return the results
		return DatabaseHandler::GetRow($sql, $params);
	}

		// Retrieves all albums
	public static function GetAlbumTracks($albumId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_album_tracks(:album_id)';

		// Build the parameters array
		$params = array (':album_id' => $albumId);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

		// Retrieves highest rated albums
	public static function GetHighestRatedAlbums()
	{
		// Build SQL query
		$sql = 'CALL collection_get_highest_rated_albums()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves highest rated artists
	public static function GetHighestRatedArtists()
	{
		// Build SQL query
		$sql = 'CALL collection_get_highest_rated_artists()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves album details
	public static function GetAlbumArtist($albumId)
	{
		// Build SQL query
		$sql = 'CALL collection_get_album_artist(:album_id)';

		// Build the parameters array
		$params = array (':album_id' => $albumId);

		// Execute the query and return the results
		return DatabaseHandler::GetOne($sql, $params);
	}

	  	// Retrieves all albums
	public static function GetArtistAlbums($artist)
	{
		// Build SQL query
		$sql = 'CALL collection_get_artist_albums(:artist)';

		// Build the parameters array
		$params = array (':artist' => $artist);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Retrieves all categories
	public static function GetCategories()
	{
		// Build SQL query
		$sql = 'CALL collection_get_category_list()';

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
			$how_many_pages = ceil($items_count / ALBUMS_PER_PAGE);

			// Save the query and its count result in the session
			$_SESSION['last_count_hash'] = $queryHashCode;
			$_SESSION['how_many_pages'] = $how_many_pages;
		}

		// Return the number of pages
		return $how_many_pages;
	}


	// Retrieves paged list of albums in collection page
	public static function GetAlbumsInCollection($pageNo, &$rHowManyPages)
	{
		// Query that returns the number of albums for the master page
		$sql = 'CALL collection_count_albums_in_collection()';

		// Calculate the number of pages required to display the albums
		$rHowManyPages = Collection::HowManyPages($sql, null);

		// Calculate the start item
		$start_item = ($pageNo - 1) * ALBUMS_PER_PAGE;

		// Retrieve the list of albums
		$sql = 'CALL collection_get_albums_on_collection(:albums_per_page, :start_item)';

		// Build the parameters array
		$params = array (':albums_per_page' => ALBUMS_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

    	// Retrieves all albums within a category
	public static function GetAlbumsByCategory($category, $pageNo, &$rHowManyPages)
	{
		// Query that returns the number of albums for the master page
		$sql = 'CALL collection_count_albums_in_collection_by_category(:category)';
		$params = array(':category' => $category);
		// Calculate the number of pages required to display the albums
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * ALBUMS_PER_PAGE;

		// Build SQL query
		$sql = 'CALL collection_get_albums_by_category(:category, :albums_per_page, :start_item)';

		// Build the parameters array

		$params = array (':category' => $category, ':albums_per_page' => ALBUMS_PER_PAGE, ':start_item' => $start_item);

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

		// Calculate the number of pages required to display the products
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * ALBUMS_PER_PAGE;

		// Retrieve the list of matching products
		$sql = 'CALL collection_search(:search_string, :albums_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $search_string, ':albums_per_page' => ALBUMS_PER_PAGE,
							':start_item' => $start_item);

		// Execute the query
		$search_result['albums'] = DatabaseHandler::GetAll($sql, $params);

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


	// Retrieves all artists
	public static function GetArtists()
	{
		// Build SQL query
		$sql = 'CALL collection_get_artists_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
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

		// Retrieve the list of matching products
		$sql = 'CALL collection_get_category_list_search(:search_string)';

		// Build the parameters array
		$params = array (':search_string' => $search_string);

		// Execute the query
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Search the collection
	public static function GetAlbumsByCategorySearch($searchString, $category, $pageNo, &$rHowManyPages)
	{

		$search_result = Collection::ConfigureSearchString($searchString);

		// If there aren't any accepted words return the $search_result
		if (count($search_result['accepted_words']) == 0)
			return $search_result;

		// Build $search_string from accepted words list
		$search_string = '+';
		$search_string .= implode(" +", $search_result['accepted_words']);

		// Count the number of search results
		$sql = 'CALL collection_count_search_category_result(:search_string, :category)';

		$params = array(':search_string' => $search_string, ':category' => $category);

		// Calculate the number of pages required to display the products
		$rHowManyPages = Collection::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * ALBUMS_PER_PAGE;

		// Retrieve the list of matching products
		$sql = 'CALL collection_search_category(:search_string, :category, :albums_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $search_string, ':category' => $category, ':albums_per_page' => ALBUMS_PER_PAGE, ':start_item' => $start_item);

		// Execute the query
		$search_result['albums'] = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;
	}


  // Updates album rating
  public static function UpdateRating($albumId, $newRating)
  {
    // Build the SQL query
    $sql = 'CALL collection_rate_album(:album_id, :new_rating)';

	//$sql = 'Update album set rating = :new_rating where album_id = :album_id';
    // Build the parameters array
    $params = array (':album_id' => $albumId,
                     ':new_rating' => $newRating);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

  // Add an album
  public static function AddAlbum($albumTitle, $artist, $releaseDate, $image, $date_bought, $category)
  {
    // Build the SQL query
    $sql = 'CALL collection_add_album(:album_title, :artist, :release_date, :image, :date_bought, :category)';

    // Build the parameters array
    $params = array (':album_title' => $albumTitle,
                     ':artist' => $artist,
					 ':release_date' => $releaseDate,
					 ':image'=> $image,
					 ':date_bought'=> $date_bought,
					 ':category'=>$category);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

  // Updates album details
  public static function UpdateAlbum($albumId, $albumTitle, $artist, $releaseDate, $image, $dateBought, $category)
  {
    // Build the SQL query
    $sql = 'CALL collection_update_album(:album_id, :album_title, :artist, :release_date, :image, :date_bought, :category)';

    // Build the parameters array
    $params = array (':album_id' => $albumId,
                     ':album_title' => $albumTitle,
                     ':artist' => $artist,
					 ':release_date' => $releaseDate,
					 ':image'=> $image,
					 ':date_bought'=> $dateBought,
					 ':category'=> $category);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }
  
  
  // Add an track to album
  public static function AddTrack($trackTitle, $trackNo, $trackLength, $almbumId)
  {
    // Build the SQL query
    $sql = 'INSERT INTO track VALUES ('.$almbumId.','.$trackNo.',"'.$trackTitle.'",'.$trackLength.')'; 
    
    DatabaseHandler::Execute($sql, null);
  }  
  
  
}
?>
