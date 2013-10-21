<?php
	class AlbumsList
	{
		// Public variables to be read from Smarty template
		public $mAlbums;
		public $mCurrentPage;
		public $mPage = 1;
		public $mrTotalPages;
		public $mLinkToNextPage;
		public $mLinkToPreviousPage;
		public $mAlbumListPages = array();
		public $mCategory;
		public $mSearchDescription;
		public $mSearchString;

		// Class constructor
		public function __construct()
		{
			$this->mCurrentPage = $_SESSION['CurrentPage'];

			// Get Page number from query string casting it to int
			if (isset ($_GET['Page']))
			{
				$this->mPage = (int)$_GET['Page'];
			}

			// Get Category from query string if set
			if (isset ($_GET['category']))
			{
				$this->mCategory = $_GET['category'];
			}

			// Retrieve the search string from the query string or posted form
			if ($this->mCurrentPage == 'Search' || $this->mCurrentPage == 'Filter')
			{
				if (isset ($_GET['searchText']))
					$this->mSearchString = $_GET['searchText'];
				elseif (isset ($_POST['searchText']))
					$this->mSearchString = trim($_POST['searchText']);
			}
		}

		public function init()
		{
			if ($this->mCurrentPage == 'Albums' || $this->mCurrentPage == 'Filter' || $this->mCurrentPage == 'Search')
			{
				if ($this->mCurrentPage == 'Albums')
				{
					$this->mAlbums = Collection::GetAlbumsInCollection($this->mPage, $this->mrTotalPages);
					$basicURL = '?op=' . $_SESSION['CurrentPage'];
				}
				elseif ($this->mCurrentPage == 'Filter')
				{
					if (isset ($this->mSearchString))
					{
						$search_results = Collection::GetAlbumsByCategorySearch($this->mSearchString, $this->mCategory,  $this->mPage, $this->mrTotalPages);
						// Get the list of albums
						$this->mAlbums = $search_results['albums'];
						// Build the title for the list of albums
						$this->mSearchDescription =
							'<p class="description">Albums where title or artist contains '
							. 'all these words: <em>'
							. implode(', ', $search_results['accepted_words']) .
							'</em> filtered by category <em>' . $this->mCategory . '</em></p>';
						if (count($search_results['ignored_words']) > 0)
							$this->mSearchDescription .=
								'<p class="description">Ignored words: <em>'
								. implode(', ', $search_results['ignored_words']) .
								'</em></p>';
						if (!(count($search_results['albums']) > 0))
							$this->mSearchDescription .=
								'<p class="description">Your search generated no results.</p>';
						$basicURL = '?op=' . $_SESSION['CurrentPage'] . '&category=' . $this->mCategory . '&searchText=' . $this->mSearchString;
					}
					else
					{
					$this->mAlbums = Collection::GetAlbumsByCategory($this->mCategory, $this->mPage, $this->mrTotalPages);
					$basicURL = '?op=' . $this->mCurrentPage . '&category=' . $this->mCategory;
					}
				}
				elseif (isset ($this->mSearchString))
				{
					// Get search results
					$search_results = Collection::Search($this->mSearchString, $this->mPage, $this->mrTotalPages);
					// Get the list of albums
					$this->mAlbums = $search_results['albums'];
					// Build the title for the list of albums
					$this->mSearchDescription =
						'<p class="description">Albums where title or artist contains '
						. 'all these words: <em>'
						. implode(', ', $search_results['accepted_words']) .
						'</em></p>';
					if (count($search_results['ignored_words']) > 0)
						$this->mSearchDescription .=
							'<p class="description">Ignored words: <em>'
							. implode(', ', $search_results['ignored_words']) .
							'</em></p>';
					if (!(count($search_results['albums']) > 0))
						$this->mSearchDescription .=
							'<p class="description">Your search generated no results.</p>';
					$basicURL = '?op=' . $this->mCurrentPage . '&searchText=' . $this->mSearchString;
				}

				/* If there are subpages of albums, display navigation controls */
				if ($this->mrTotalPages > 1)
				{
					// Build the Next link
					if ($this->mPage < $this->mrTotalPages)
					{
						$nextPage = $this->mPage + 1;
						$this->mLinkToNextPage =  $basicURL. '&Page=' . $nextPage;
					}

 					// Build the Previous link
					if ($this->mPage > 1)
					{
						$prevPage = $this->mPage - 1;
						$this->mLinkToPreviousPage = $basicURL. '&Page=' . $prevPage;
					}

					// Build the pages links
					for ($i = 1; $i <= $this->mrTotalPages; $i++)
						$this->mAlbumListPages[] = $basicURL. '&Page=' . $i;
				}
			}
			elseif ($this->mCurrentPage == 'Home')
			{
				$this->mAlbums = Collection::GetLatestAlbums();
			}
		}
	}
?>
