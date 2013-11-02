<?php
	class AdmImageSave{
		
		public $mImage;
		public $mOldImage;
			
		public $image_id;		
		public $image_title;
		public $image_contributor;
		public $image_description;
		public $new_image;
		public $image_width;
		public $image_height;
		public $image;
		public $height;
		public $category;
		public $ret_msg;
		
		
		private $update=false;
		
		private $upload_error=false;
		private $upload_ret_msg;
		
		public $mCategories;
		public $mTags;
	
		

		// Class constructor
		public function __construct(){
			//$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_POST['image_id'])){
				$this->image_id = $_POST['image_id'];
				$this->update = true;
				$this->mTags = Collection::GetImageTags($this->image_id);
				
			}						
			if (isset ($_POST['image_title'])){
				$this->image_title = $_POST['image_title'];
			}					
			if (isset($_POST['image_contributor'])){
				$this->image_contributor = $_POST['image_contributor'];
			}	
			if (isset($_POST['image_description'])){
				$this->image_description = $_POST['image_description'];
			}

			if (isset($_POST['image_category'])){
				$this->category = $_POST['image_category'];
			}		
			
			$this->mCategories = Collection::GetCategories();
			
			
	
			
		}

		public function init(){
		
			if (empty($_FILES["new_image"]["name"]) && $this->update){
				$this->mImage = Collection::GetImageDetails($this->image_id);				
				$this->new_image = $this->mImage['image_url'];
				//echo("1");
			}elseif (empty($_FILES["new_image"]["name"]) && !$this->update) {				
				$this->new_image = 'image_missing.png';
				//echo("2");
			
			} else  {			
				$this::uploadImage();
				//echo("3");
			}	
		
			//return;
			
			if (!$this->upload_error){
				//echo ("3");
				$dateArr = getdate();
				$dateTime = "<br>".$dateArr['hours'].":".$dateArr['minutes'].":".$dateArr['seconds']." - ".$dateArr['mday']."/".$dateArr['mon']."/".$dateArr['year'];
				if ($this->update){			
					//echo ("3.1");
					if (empty($_FILES["new_image"])){
						$this->new_image = $this->mOldImage.image_url;
					}				
					Collection::UpdateImage($this->image_id, $this->image_title, $this->image_contributor, $this->image_description, $this->new_image, 300 , 300, $this->category);
					$this->ret_msg = "Update Successful ".$dateTime;
				} else {
					//echo ("3.2");
					$this->image_id = Collection::AddImage( $this->image_title, $this->image_contributor, $this->image_description, $this->new_image, 300 , 300, $this->category);
					$this->ret_msg = "Create Successful ".$dateTime;
				}
				$this->mImage = Collection::GetImageDetails($this->image_id);
				
			} else {
				$this->ret_msg = $this->upload_ret_msg;
			}
					
		}
		
		
		
		
		private function uploadImage(){
		
			define("UPLOAD_DIR", "/Users/gauchoescoces/Documents/GitHub/wp2/GCUImagesStarter/images/");
			//echo ("1.1 ");
			
			if (!empty($_FILES["new_image"])) {
				//echo ("1.2 ");
				$myFile = $_FILES["new_image"];
				//echo ("1.3  ");
				if ($myFile["error"] !== UPLOAD_ERR_OK) {
					//echo ("1.4  ");
					$this->upload_error = true;
					$this->upload_ret_msg = "Network Error: File has not been transferred";					
					return;
				}
			 
				//echo ("1.5 ");
				$name = preg_replace("/[^A-Z0-9._-]/i", "_", $myFile["name"]);
				//echo ("1.6 ");
			
				$i = 0;
				$parts = pathinfo($name);
				while (file_exists(UPLOAD_DIR . $name)) {
					$i++;
					$name = $parts["filename"] . "-" . $i . "." . $parts["extension"];
				}
			 
				// preserve file from temporary directory
				$success = move_uploaded_file($myFile["tmp_name"],UPLOAD_DIR . $name);
				if (!$success) { 
					$this->upload_error = true;
					$this->upload_ret_msg = "I/O Error: moving temp file failed";	
					exit;
				} else {
					//echo "<p>file was succesfully saved on </p> ".UPLOAD_DIR;
					$this->new_image = $name;
					$this->upload_error = false;
					$this->upload_ret_msg = "Uploaded Image Successfully";	
				}
			 

			}
		
		}
	}
?>
