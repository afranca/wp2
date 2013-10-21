<?php
	class Admin
	{
		// Public variables to be read from Smarty template
		public $mAlbum;
		public $mYear;
		public $mTracks;
		public $mAlbumID;
		public $mErrorMessage;
		public $mArtists;
		public $mAlbums;
		public $mAlbumTitle;
		public $mArtist;
		public $mReleaseDate;
		public $mImage;
		public $mDateBought;
		public $mCategory;
		public $mLoggedIn;
		
		public $mTrackTitle;
		public $mTrackLength;
		public $mTrackNo;				

		// Private members
		private $mAction;

		// Class constructor
		public function __construct()
		{
		// Load the database handler
		require_once BUSINESS_DIR . 'database_handler.php';

		// Load Business Tier
		require_once BUSINESS_DIR . 'collection.php';

				$this->mAction = 'None';
				if (isset ($_GET['Page']) && ($_GET['Page'] == 'Logout'))
				{
					unset($_SESSION['admin_logged']);
					header('Location: admin.php');
					exit();
				}
				elseif (isset ($_POST['submit_add']))
				{
					$this->mAction = 'AddAlbum';
				}
				elseif (isset ($_POST['submit_edit']))
				{
					$this->mAction = 'EditAlbum';
				}
				elseif (isset ($_POST['submit_select_artist']))
				{
					$this->mAction = 'SelectArtist';
				}
				elseif (isset ($_POST['submit_select_album']))
				{
					$this->mAction = 'SelectAlbum';
				}
				elseif (isset ($_POST['new_track_title']))
				{
					$this->mAction = 'AddTrack';
				}				
				if (isset ($_SESSION['admin_logged']))
				{
					$this->mLoggedIn = TRUE;
				}
 		}

		public function init()
		{
			$this->mArtists = Collection::GetArtists();
			if ($this->mAction == 'AddAlbum' || $this->mAction == 'EditAlbum')
			{
				$this->mAlbumID = $_POST['album_id'];
				$this->mAlbumTitle = $_POST['new_album_title'];
				$this->mArtist = $_POST['new_artist'];
				$this->mReleaseDate = $_POST['new_release_date'];
				$this->mImage = $_POST['new_image'];
				$this->mDateBought = $_POST['new_date_bought'];
				$this->mCategory = $_POST['new_category'];

				if ($this->mAlbumTitle == null)
					$this->mErrorMessage = 'Album title required';

				if ($this->mArtist == null)
					$this->mErrorMessage = 'Artist required';

				if ($this->mErrorMessage == null)
				{
					if ($this->mAction == 'AddAlbum')
					{
						Collection::AddAlbum($this->mAlbumTitle, $this->mArtist, $this->mReleaseDate, $this->mImage, $this->mDateBought, $this->mCategory);
					}
					else
					{
						Collection::UpdateAlbum($this->mAlbumID, $this->mAlbumTitle, $this->mArtist, $this->mReleaseDate, $this->mImage, $this->mDateBought, $this->mCategory);
					}
					header('Location: admin.php');
				}
			}
			elseif ($this->mAction == 'SelectArtist')
			{
				$this->mArtist = $_POST['artists'];
				$this->mAlbumID = '';
				$this->mAlbumTitle = '[album title]';
				$this->mReleaseDate = '[release date]';
				$this->mImage = '[image]';
				$this->mDateBought = '[date bought]';
				$this->mCategory = '[category]';
				$this->mAlbums = Collection::GetArtistAlbums($this->mArtist);
			}
			elseif ($this->mAction == 'SelectAlbum')
			{
				$this->mAlbumID = $_POST['albums'];
				$this->mAlbum = Collection::GetAlbumDetails($this->mAlbumID);
				$this->mAlbumTitle = $this->mAlbum['album_title'];
				$this->mArtist = $this->mAlbum['artist'];
				$this->mReleaseDate = $this->mAlbum['release_date'];
				$this->mImage = $this->mAlbum['image'];
				$this->mDateBought = $this->mAlbum['date_bought'];
				$this->mCategory = $this->mAlbum['category'];
			}

			elseif ($this->mAction == 'AddTrack')
			{
				$this->mAlbumID = $_POST['album_id'];
				$this->mTrackTitle = $_POST['new_track_title'];
				$this->mTrackLength = $_POST['new_track_length'];
				$this->mTrackNo = $_POST['new_track_no'];
				
				Collection::AddTrack($this->mTrackTitle, $this->mTrackNo, $this->mTrackLength, $this->mAlbumID);
				
			}			
			else
			{
				$this->mAlbumID = '';
				$this->mAlbumTitle = '[album title]';
				$this->mArtist = '[artist]';
				$this->mReleaseDate = '[release date]';
				$this->mImage = '[image]';
				$this->mDateBought = '[date bought]';
				$this->mCategory = '[category]';
			}

		}
	}
?>
