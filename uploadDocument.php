<?PHP

if (isset($_FILES['file'])) {
    $folder = 'uploads';
    //server automatically creates folder for every user to store his files.
    if (!file_exists($folder)) {
        mkdir($folder, 0777, true);
    } 
    
    
    $filePath = $folder . '/' . basename($_FILES['file']['name']);
    
    if (move_uploaded_file($_FILES['file']['tmp_name'], $filePath)) {
        $fileURL = 'http://www.ultimate-teenchat.com/test-app/uploads/' . $_FILES['file']['name'];
    
    echo "Successfully, $fileURL";
       
    } else {
        
         echo "Sorry, there was an error uploading your file.";
    }
 
}

?>