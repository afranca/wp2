<?php
	class AdmImageSave{
		
		public $mImage;
			
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
		
	
		

		// Class constructor
		public function __construct(){
			//$this->mCurrentPage = $_SESSION['CurrentPage'];
			
			if (isset($_POST['image_id'])){
				$this->image_id = $_POST['image_id'];
				$this->update = true;
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
			if (isset($_POST['new_image'])){
				$this->new_image = $_POST['new_image'];
			}	
			
		}

		public function init(){
				
			$this::uploadImage();
			
			if (!$this->upload_error){		
				if ($this->update){				
					Collection::UpdateImage($this->image_id, $this->image_title, $this->image_contributor, $this->image_description, $this->new_image, 300 , 300, "update category");
					$this->mImage = Collection::GetImageDetails($this->image_id);	
					$this->ret_msg = "Operation Successful";
				} else {	
					echo ("<h1> CREATED</h1>");
					//$this->mImages = Collection::AddImage( $this->image_title, $this->image_contributor, $this->image_description, $this->new_image, 300 , 300, "new category");
				}
			} else {
				$this->ret_msg = $this->upload_ret_msg;
			}
					
		}
		
		
		
		
		private function uploadImage(){
		
			define("UPLOAD_DIR", "/Users/gauchoescoces/Documents/GitHub/wp2/GCUImagesStarter/images/");
			
			
			if (!empty($_FILES["new_image"])) {
				$myFile = $_FILES["new_image"];
			 
				if ($myFile["error"] !== UPLOAD_ERR_OK) {
					$this->upload_error = true;
					$this->upload_ret_msg = "Network Error: File has not been transferred";					
					exit;
				}
			 
				
				$name = preg_replace("/[^A-Z0-9._-]/i", "_", $myFile["name"]);
			 
			
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
